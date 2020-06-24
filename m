Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551B52069F8
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2020 04:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388001AbgFXCP2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 22:15:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41704 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387985AbgFXCP1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jun 2020 22:15:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05O22VJ7188934;
        Wed, 24 Jun 2020 02:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=e0+MzToXCC9v1nNJLhO5p8forogNppI9KUbriWiSc0E=;
 b=hekE31OzPMWiCF253CguXL+AiExgYX7o7jOrwUw6r/7elcc+1tX6/lHQtF8N8qGi3gLj
 RtXgOJf7fD/5UWQgdaOb4Xs7dCmQzZfBVr+/WvcAI7tKDcHt8AeOT6pl5ZQGcYutwkUG
 iHnPdDoghRTWIL79nxXuAUf7JxkE73DIZncuEgpTcVhzmJuSQpnAxravZO1IqKNyEsoZ
 TzJ94VMqZ2WOvQcnJzdM5aHjZWvRrpoWRdQaOkqxZ8+ozZJuBGiRLg4qE7yRDpW34J1g
 wubN5t5QwtjZzv+RSaC+C5d+2EJjUAXL6MrvQIJ58wkuWyPxW+9+g+4mxZU9jlJRxeGk KQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31uustg9y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 02:15:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05O24AAM139408;
        Wed, 24 Jun 2020 02:13:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 31uur6m21u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jun 2020 02:13:21 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05O2DIF7010266;
        Wed, 24 Jun 2020 02:13:18 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jun 2020 02:13:17 +0000
From:   Divya Indi <divya.indi@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Kaike Wan <kaike.wan@intel.com>
Cc:     Gerd Rausch <gerd.rausch@oracle.com>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Divya Indi <divya.indi@oracle.com>
Subject: [PATCH v4] IB/sa: Resolving use-after-free in ib_nl_send_msg
Date:   Tue, 23 Jun 2020 19:13:09 -0700
Message-Id: <1592964789-14533-1-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9661 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=2 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9661 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 cotscore=-2147483648 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=2 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006240012
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit 3ebd2fd0d011 ("IB/sa: Put netlink request into the request list before sending")'
-
1. Adds the query to the request list before ib_nl_snd_msg.
2. Moves ib_nl_send_msg out of spinlock, hence safe to use gfp_mask as is.

However, if there is a delay in sending out the request (For
eg: Delay due to low memory situation) the timer to handle request timeout
might kick in before the request is sent out to ibacm via netlink.
ib_nl_request_timeout may release the query causing a use after free situation
while accessing the query in ib_nl_send_msg.

Call Trace for the above race:

[<ffffffffa02f43cb>] ? ib_pack+0x17b/0x240 [ib_core]
[<ffffffffa032aef1>] ib_sa_path_rec_get+0x181/0x200 [ib_sa]
[<ffffffffa0379db0>] rdma_resolve_route+0x3c0/0x8d0 [rdma_cm]
[<ffffffffa0374450>] ? cma_bind_port+0xa0/0xa0 [rdma_cm]
[<ffffffffa040f850>] ? rds_rdma_cm_event_handler_cmn+0x850/0x850
[rds_rdma]
[<ffffffffa040f22c>] rds_rdma_cm_event_handler_cmn+0x22c/0x850
[rds_rdma]
[<ffffffffa040f860>] rds_rdma_cm_event_handler+0x10/0x20 [rds_rdma]
[<ffffffffa037778e>] addr_handler+0x9e/0x140 [rdma_cm]
[<ffffffffa026cdb4>] process_req+0x134/0x190 [ib_addr]
[<ffffffff810a02f9>] process_one_work+0x169/0x4a0
[<ffffffff810a0b2b>] worker_thread+0x5b/0x560
[<ffffffff810a0ad0>] ? flush_delayed_work+0x50/0x50
[<ffffffff810a68fb>] kthread+0xcb/0xf0
[<ffffffff816ec49a>] ? __schedule+0x24a/0x810
[<ffffffff816ec49a>] ? __schedule+0x24a/0x810
[<ffffffff810a6830>] ? kthread_create_on_node+0x180/0x180
[<ffffffff816f25a7>] ret_from_fork+0x47/0x90
[<ffffffff810a6830>] ? kthread_create_on_node+0x180/0x180
....
RIP  [<ffffffffa03296cd>] send_mad+0x33d/0x5d0 [ib_sa]

To resolve the above issue -
1. Add the req to the request list only after the request has been sent out.
2. To handle the race where response comes in before adding request to
the request list, send(rdma_nl_multicast) and add to list while holding the
spinlock - request_lock.
3. Use non blocking memory allocation flags for rdma_nl_multicast since it is
called while holding a spinlock.

Fixes: 3ebd2fd0d011 ("IB/sa: Put netlink request into the request list
before sending")

Signed-off-by: Divya Indi <divya.indi@oracle.com>
---
v1:
- Use flag IB_SA_NL_QUERY_SENT to prevent the use-after-free.

v2:
- Use atomic bit ops for setting and testing IB_SA_NL_QUERY_SENT.
- Rewording and adding comments.

v3:
- Change approach and remove usage of IB_SA_NL_QUERY_SENT.
- Add req to request list only after the request has been sent out.
- Send and add to list while holding the spinlock (request_lock).
- Overide gfp_mask and use GFP_NOWAIT for rdma_nl_multicast since we
  need non blocking memory allocation while holding spinlock.

v4:
- Formatting changes.
- Use GFP_NOWAIT conditionally - Only when GFP_ATOMIC is not provided by caller.
---
 drivers/infiniband/core/sa_query.c | 41 ++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 74e0058..9066d48 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -836,6 +836,10 @@ static int ib_nl_send_msg(struct ib_sa_query *query, gfp_t gfp_mask)
 	void *data;
 	struct ib_sa_mad *mad;
 	int len;
+	unsigned long flags;
+	unsigned long delay;
+	gfp_t gfp_flag;
+	int ret;
 
 	mad = query->mad_buf->mad;
 	len = ib_nl_get_path_rec_attrs_len(mad->sa_hdr.comp_mask);
@@ -860,36 +864,39 @@ static int ib_nl_send_msg(struct ib_sa_query *query, gfp_t gfp_mask)
 	/* Repair the nlmsg header length */
 	nlmsg_end(skb, nlh);
 
-	return rdma_nl_multicast(&init_net, skb, RDMA_NL_GROUP_LS, gfp_mask);
-}
+	gfp_flag = ((gfp_mask & GFP_ATOMIC) == GFP_ATOMIC) ? GFP_ATOMIC :
+		GFP_NOWAIT;
 
-static int ib_nl_make_request(struct ib_sa_query *query, gfp_t gfp_mask)
-{
-	unsigned long flags;
-	unsigned long delay;
-	int ret;
+	spin_lock_irqsave(&ib_nl_request_lock, flags);
+	ret =  rdma_nl_multicast(&init_net, skb, RDMA_NL_GROUP_LS, gfp_flag);
 
-	INIT_LIST_HEAD(&query->list);
-	query->seq = (u32)atomic_inc_return(&ib_nl_sa_request_seq);
+	if (ret)
+		goto out;
 
-	/* Put the request on the list first.*/
-	spin_lock_irqsave(&ib_nl_request_lock, flags);
+	/* Put the request on the list.*/
 	delay = msecs_to_jiffies(sa_local_svc_timeout_ms);
 	query->timeout = delay + jiffies;
 	list_add_tail(&query->list, &ib_nl_request_list);
 	/* Start the timeout if this is the only request */
 	if (ib_nl_request_list.next == &query->list)
 		queue_delayed_work(ib_nl_wq, &ib_nl_timed_work, delay);
+
+out:
 	spin_unlock_irqrestore(&ib_nl_request_lock, flags);
 
+	return ret;
+}
+
+static int ib_nl_make_request(struct ib_sa_query *query, gfp_t gfp_mask)
+{
+	int ret;
+
+	INIT_LIST_HEAD(&query->list);
+	query->seq = (u32)atomic_inc_return(&ib_nl_sa_request_seq);
+
 	ret = ib_nl_send_msg(query, gfp_mask);
-	if (ret) {
+	if (ret)
 		ret = -EIO;
-		/* Remove the request */
-		spin_lock_irqsave(&ib_nl_request_lock, flags);
-		list_del(&query->list);
-		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
-	}
 
 	return ret;
 }
-- 
1.8.3.1

