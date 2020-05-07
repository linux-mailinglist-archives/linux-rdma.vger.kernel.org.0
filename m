Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593F21C996C
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2020 20:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgEGShF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 May 2020 14:37:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49232 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgEGShF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 May 2020 14:37:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047IMZIv032669;
        Thu, 7 May 2020 18:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=jEL0Tl/TzlxZbwRuXIi5yCGHz7/aI7KOtsR7w/YVdFY=;
 b=UUCafa24ozcJZ0XsA13Jv6QhHXg6Pw8qsfPRt+JLuvNivFcVvJy0dZxFtK1BAvC5J/lg
 Q3kQO9/VmsnAIBRMgIkFRQegc6DMJqP0MCNdFXVdIDIsGFMQsPreCgmX4h8XMvfnq90a
 aUyLEeQcV9fTNXC4CMwxKap1JpTDnngsTeiALAiSkGTELcFD+fTMaKrEwA+JSv/oVdj9
 UgY3HbLkp9sUR9dbj7BrGnR0tkzifnvaRX0bcWe7v535KRvxgR4cqG3yKPR2dv9hTwX1
 LoQa/oixKtexzIZPrwS15jIft7BACckhgidLTrqncu+jhJW6cIGMwwk/msmIuzOsd3oN Bg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30usgq8ysg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 18:37:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047IHZu6080226;
        Thu, 7 May 2020 18:35:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 30sjnq8qus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 18:35:00 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 047IYx9b019749;
        Thu, 7 May 2020 18:34:59 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 May 2020 11:34:59 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Kaike Wan <kaike.wan@intel.com>
Cc:     Gerd Rausch <gerd.rausch@oracle.com>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Divya Indi <divya.indi@oracle.com>
Subject: [PATCH 1/2] IB/sa: Resolving use-after-free in ib_nl_send_msg.
Date:   Thu,  7 May 2020 11:34:47 -0700
Message-Id: <1588876487-5781-2-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588876487-5781-1-git-send-email-divya.indi@oracle.com>
References: <1588876487-5781-1-git-send-email-divya.indi@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070150
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch fixes commit -
commit 3ebd2fd0d011 ("IB/sa: Put netlink request into the request list before sending")'

Above commit adds the query to the request list before ib_nl_snd_msg.

However, if there is a delay in sending out the request (For
eg: Delay due to low memory situation) the timer to handle request timeout
might kick in before the request is sent out to ibacm via netlink.
ib_nl_request_timeout may release the query if it fails to send it to SA
as well causing a use after free situation.

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

To resolve this issue, we introduce a new flag IB_SA_NL_QUERY_SENT.
This flag Indicates if the request has been sent out to ibacm yet.

If this flag is not set for a query and the query times out, we add it
back to the list with the original delay.

To handle the case where a response is received before we could set this
flag, the response handler waits for the flag to be
set before proceeding with the query.

Signed-off-by: Divya Indi <divya.indi@oracle.com>
---
 drivers/infiniband/core/sa_query.c | 45 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 30d4c12..ffbae2f 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -59,6 +59,9 @@
 #define IB_SA_LOCAL_SVC_TIMEOUT_MAX		200000
 #define IB_SA_CPI_MAX_RETRY_CNT			3
 #define IB_SA_CPI_RETRY_WAIT			1000 /*msecs */
+
+DECLARE_WAIT_QUEUE_HEAD(wait_queue);
+
 static int sa_local_svc_timeout_ms = IB_SA_LOCAL_SVC_TIMEOUT_DEFAULT;
 
 struct ib_sa_sm_ah {
@@ -122,6 +125,7 @@ struct ib_sa_query {
 #define IB_SA_ENABLE_LOCAL_SERVICE	0x00000001
 #define IB_SA_CANCEL			0x00000002
 #define IB_SA_QUERY_OPA			0x00000004
+#define IB_SA_NL_QUERY_SENT		0x00000008
 
 struct ib_sa_service_query {
 	void (*callback)(int, struct ib_sa_service_rec *, void *);
@@ -746,6 +750,11 @@ static inline int ib_sa_query_cancelled(struct ib_sa_query *query)
 	return (query->flags & IB_SA_CANCEL);
 }
 
+static inline int ib_sa_nl_query_sent(struct ib_sa_query *query)
+{
+	return (query->flags & IB_SA_NL_QUERY_SENT);
+}
+
 static void ib_nl_set_path_rec_attrs(struct sk_buff *skb,
 				     struct ib_sa_query *query)
 {
@@ -889,6 +898,15 @@ static int ib_nl_make_request(struct ib_sa_query *query, gfp_t gfp_mask)
 		spin_lock_irqsave(&ib_nl_request_lock, flags);
 		list_del(&query->list);
 		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
+	} else {
+		query->flags |= IB_SA_NL_QUERY_SENT;
+
+		/*
+		 * If response is received before this flag was set
+		 * someone is waiting to process the response and release the
+		 * query.
+		 */
+		wake_up(&wait_queue);
 	}
 
 	return ret;
@@ -994,6 +1012,21 @@ static void ib_nl_request_timeout(struct work_struct *work)
 		}
 
 		list_del(&query->list);
+
+		/*
+		 * If IB_SA_NL_QUERY_SENT is not set, this query has not been
+		 * sent to ibacm yet. Reset the timer.
+		 */
+		if (!ib_sa_nl_query_sent(query)) {
+			delay = msecs_to_jiffies(sa_local_svc_timeout_ms);
+			query->timeout = delay + jiffies;
+			list_add_tail(&query->list, &ib_nl_request_list);
+			/* Start the timeout if this is the only request */
+			if (ib_nl_request_list.next == &query->list)
+				queue_delayed_work(ib_nl_wq, &ib_nl_timed_work,
+						delay);
+			break;
+		}
 		ib_sa_disable_local_svc(query);
 		/* Hold the lock to protect against query cancellation */
 		if (ib_sa_query_cancelled(query))
@@ -1123,6 +1156,18 @@ int ib_nl_handle_resolve_resp(struct sk_buff *skb,
 
 	send_buf = query->mad_buf;
 
+	/*
+	 * Make sure the IB_SA_NL_QUERY_SENT flag is set before
+	 * processing this query. If flag is not set, query can be accessed in
+	 * another context while setting the flag and processing the query will
+	 * eventually release it causing a possible use-after-free.
+	 */
+	if (unlikely(!ib_sa_nl_query_sent(query))) {
+		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
+		wait_event(wait_queue, ib_sa_nl_query_sent(query));
+		spin_lock_irqsave(&ib_nl_request_lock, flags);
+	}
+
 	if (!ib_nl_is_good_resolve_resp(nlh)) {
 		/* if the result is a failure, send out the packet via IB */
 		ib_sa_disable_local_svc(query);
-- 
1.8.3.1

