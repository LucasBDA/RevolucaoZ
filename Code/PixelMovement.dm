public class Player : MonoBehaviour {public GameObject PlayerGet;public float StopDistance;private float XPos;private float YPos;public float Speed;
 void Start () {XPos = transform.position.x;YPos = transform.position.y;}
 void Update () {transform.position = new Vector2 (XPos, YPos);RaycastHit2D HitPoint = Physics2D.Raycast (transform.position, PlayerGet.transform.position - transform.position, 2f)}
 	if (HitPoint.collider != null)
 	{if (HitPoint.collider.tag == "Player"){Invoke ("ChaseInitiation", 1)}
 	else{CancelInvoke ("ChaseInitiation");}
 	else{CancelInvoke ("Chase");}
 void ChaseInitiation () {StartCoroutine (Chase ());}
 IEnumerator Chase ()
 	{if (transform.position.x < PlayerGet.transform.position.x - StopDistance){ XPos += Speed / 32; }
 	if (transform.position.x > PlayerGet.transform.position.x + StopDistance) { XPos -= Speed / 32; }
 	if (transform.position.y < PlayerGet.transform.position.y - StopDistance) { YPos += Speed / 32; }
 	if (transform.position.y > PlayerGet.transform.position.y + StopDistance) {YPos -= Speed / 32;}yield return new WaitForSeconds (0.25f);}}