Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95B91F1B40
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2020 16:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgFHOqj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jun 2020 10:46:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41656 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729958AbgFHOqj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Jun 2020 10:46:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058EcS1K177007;
        Mon, 8 Jun 2020 14:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=3ST82eFgXt92EYVicsN7tP+o1dS2XHSuxwNV51uYE34=;
 b=emZT5qAq70yICtdA+THiWQjdCFWPX8H0CxPo2Phb1FN7m11+APRVT8VHbZeW7OK70fnO
 Koi2TdhrMUER4tesMGga9dV/nrsJl0SRlZL6LRO1njB/kbCNOJsF5urNh+fJu5cJgKQv
 isJSOXXqBqe98vG1q+cywTzIC8Rp22oSTIN6kMv8d+Eyv/uf5yKGDXWgruorQ7iBSjiT
 oGssVa8Vxj4e4YgGf63zjG5UipnPdACdw4rpihNOE8bjf5b+7HJnGJkNI4zDrWOk5aED
 p398jmdmUUVFDDwLbq/RH08AiHkqrPCGj3isFFPOrmLraOu/p7TOHEx2ckeW2ws4z7wv +A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31g3smq65g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 14:46:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058EhbPI007318;
        Mon, 8 Jun 2020 14:46:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 31gn2vah5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 14:46:29 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 058EkSRD015634;
        Mon, 8 Jun 2020 14:46:28 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jun 2020 07:46:27 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Kaike Wan <kaike.wan@intel.com>
Cc:     Gerd Rausch <gerd.rausch@oracle.com>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Divya Indi <divya.indi@oracle.com>
Subject: [PATCH v3] IB/sa: Resolving use-after-free in ib_nl_send_msg
Date:   Mon,  8 Jun 2020 07:46:16 -0700
Message-Id: <1591627576-920-2-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1591627576-920-1-git-send-email-divya.indi@oracle.com>
References: <1591627576-920-1-git-send-email-divya.indi@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=2
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080109
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit 3ebd2fd0d011 ("IB/sa: Put netlink request into the request list before sending")'
-
1. Adds the query to the request list before ib_nl_snd_msg.
2. Removes ib_nl_send_msg from within the spinlock which also makes it
possible to allocate memory with GFP_KERNEL.

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
3. Use GFP_NOWAIT for rdma_nl_multicast since it is called while holding
a spinlock. In case of memory allocation failure, request will go out to SA.

Signed-off-by: Divya Indi <divya.indi@oracle.com>
Fixes: 3ebd2fd0d011 ("IB/sa: Put netlink request into the request list
before sending")
---
 drivers/infiniband/core/sa_query.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 74e0058..042c99b 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -836,6 +836,9 @@ static int ib_nl_send_msg(struct ib_sa_query *query, gfp_t gfp_mask)
 	void *data;
 	struct ib_sa_mad *mad;
 	int len;
+	unsigned long flags;
+	unsigned long delay;
+	int ret;
 
 	mad = query->mad_buf->mad;
 	len = ib_nl_get_path_rec_attrs_len(mad->sa_hdr.comp_mask);
@@ -860,35 +863,32 @@ static int ib_nl_send_msg(struct ib_sa_query *query, gfp_t gfp_mask)
 	/* Repair the nlmsg header length */
 	nlmsg_end(skb, nlh);
 
-	return rdma_nl_multicast(&init_net, skb, RDMA_NL_GROUP_LS, gfp_mask);
+	spin_lock_irqsave(&ib_nl_request_lock, flags);
+	ret =  rdma_nl_multicast(&init_net, skb, RDMA_NL_GROUP_LS, GFP_NOWAIT);
+	if (!ret) {
+		/* Put the request on the list.*/
+		delay = msecs_to_jiffies(sa_local_svc_timeout_ms);
+		query->timeout = delay + jiffies;
+		list_add_tail(&query->list, &ib_nl_request_list);
+		/* Start the timeout if this is the only request */
+		if (ib_nl_request_list.next == &query->list)
+			queue_delayed_work(ib_nl_wq, &ib_nl_timed_work, delay);
+	}
+	spin_unlock_irqrestore(&ib_nl_request_lock, flags);
+
+	return ret;
 }
 
 static int ib_nl_make_request(struct ib_sa_query *query, gfp_t gfp_mask)
 {
-	unsigned long flags;
-	unsigned long delay;
 	int ret;
 
 	INIT_LIST_HEAD(&query->list);
 	query->seq = (u32)atomic_inc_return(&ib_nl_sa_request_seq);
 
-	/* Put the request on the list first.*/
-	spin_lock_irqsave(&ib_nl_request_lock, flags);
-	delay = msecs_to_jiffies(sa_local_svc_timeout_ms);
-	query->timeout = delay + jiffies;
-	list_add_tail(&query->list, &ib_nl_request_list);
-	/* Start the timeout if this is the only request */
-	if (ib_nl_request_list.next == &query->list)
-		queue_delayed_work(ib_nl_wq, &ib_nl_timed_work, delay);
-	spin_unlock_irqrestore(&ib_nl_request_lock, flags);
-
 	ret = ib_nl_send_msg(query, gfp_mask);
 	if (ret) {
 		ret = -EIO;
-		/* Remove the request */
-		spin_lock_irqsave(&ib_nl_request_lock, flags);
-		list_del(&query->list);
-		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
 	}
 
 	return ret;
-- 
1.8.3.1

