Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15601D34AA
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2020 17:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgENPMD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 May 2020 11:12:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43042 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgENPMC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 May 2020 11:12:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04EF6ivL050766;
        Thu, 14 May 2020 15:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=6o1LUfbQCyN+UnMYkK3bYQKYatwgSp8QSo7oZ6ZUnVw=;
 b=vdpdPCIQEEY3gUFmYa4+NH/TqKR9YZXKHn0f21aZrOCGPsfNRACQCMgnde1+uA5FrVPw
 HDqursrn0OuQ2FDDK2X1sA42fMY8LwRk/XW/rnz8agH21OYwQLT2vMAd7PmJ3iHnIiTr
 vY7xa9scRKczicZ1r+LJlfNwzMuswUh7X6QPn/hFqElp3jP6EP69lvkERAtdxyz4i+N6
 KJT3ik+GxPgvLwonVCHnLnHXmOER8cN2tZ/GmEJRPQ1Vo+Fj+db3a35ZCNlFAlHE6k2P
 HGiX8Tih3CczcsfrKeYz6t3tP7h54t5kYSI6o5zW7A8bgvRRRzIxSIcc8jzrehDQ1tVT Sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3100yg35gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 May 2020 15:11:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04EF8J4q134514;
        Thu, 14 May 2020 15:11:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3100ycucn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 May 2020 15:11:56 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04EFBsPk006327;
        Thu, 14 May 2020 15:11:54 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 May 2020 08:11:49 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Kaike Wan <kaike.wan@intel.com>
Cc:     Gerd Rausch <gerd.rausch@oracle.com>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Divya Indi <divya.indi@oracle.com>
Subject: [PATCH] IB/sa: Resolving use-after-free in ib_nl_send_msg.
Date:   Thu, 14 May 2020 08:11:24 -0700
Message-Id: <1589469084-15125-2-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1589469084-15125-1-git-send-email-divya.indi@oracle.com>
References: <1589469084-15125-1-git-send-email-divya.indi@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=2 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 cotscore=-2147483648 mlxscore=0 suspectscore=2 spamscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005140133
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
 drivers/infiniband/core/sa_query.c | 53 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 30d4c12..91486e7 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -42,6 +42,7 @@
 #include <linux/kref.h>
 #include <linux/xarray.h>
 #include <linux/workqueue.h>
+#include <linux/bitops.h>
 #include <uapi/linux/if_ether.h>
 #include <rdma/ib_pack.h>
 #include <rdma/ib_cache.h>
@@ -59,6 +60,9 @@
 #define IB_SA_LOCAL_SVC_TIMEOUT_MAX		200000
 #define IB_SA_CPI_MAX_RETRY_CNT			3
 #define IB_SA_CPI_RETRY_WAIT			1000 /*msecs */
+
+DECLARE_WAIT_QUEUE_HEAD(wait_queue);
+
 static int sa_local_svc_timeout_ms = IB_SA_LOCAL_SVC_TIMEOUT_DEFAULT;
 
 struct ib_sa_sm_ah {
@@ -123,6 +127,12 @@ struct ib_sa_query {
 #define IB_SA_CANCEL			0x00000002
 #define IB_SA_QUERY_OPA			0x00000004
 
+/*
+ * This bit in the SA query flags indicates whether the query
+ * has been sent out to ibacm via netlink
+ */
+#define IB_SA_NL_QUERY_SENT		3
+
 struct ib_sa_service_query {
 	void (*callback)(int, struct ib_sa_service_rec *, void *);
 	void *context;
@@ -746,6 +756,11 @@ static inline int ib_sa_query_cancelled(struct ib_sa_query *query)
 	return (query->flags & IB_SA_CANCEL);
 }
 
+static inline int ib_sa_nl_query_sent(struct ib_sa_query *query)
+{
+	return test_bit(IB_SA_NL_QUERY_SENT, (unsigned long *)&query->flags);
+}
+
 static void ib_nl_set_path_rec_attrs(struct sk_buff *skb,
 				     struct ib_sa_query *query)
 {
@@ -889,6 +904,15 @@ static int ib_nl_make_request(struct ib_sa_query *query, gfp_t gfp_mask)
 		spin_lock_irqsave(&ib_nl_request_lock, flags);
 		list_del(&query->list);
 		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
+	} else {
+		set_bit(IB_SA_NL_QUERY_SENT, (unsigned long *)&query->flags);
+
+		/*
+		 * If response is received before this flag was set
+		 * someone is waiting to process the response and release the
+		 * query.
+		 */
+		wake_up(&wait_queue);
 	}
 
 	return ret;
@@ -994,6 +1018,21 @@ static void ib_nl_request_timeout(struct work_struct *work)
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
@@ -1122,6 +1161,20 @@ int ib_nl_handle_resolve_resp(struct sk_buff *skb,
 	}
 
 	send_buf = query->mad_buf;
+	/*
+	 * In case of a quick response ie when a response comes in before
+	 * setting IB_SA_NL_QUERY_SENT, we can have an unlikely race where the
+	 * response handler will release the query, but we can still access the
+	 * freed query while setting the flag.
+	 * Hence, before proceeding and eventually releasing the query -
+	 * wait till the flag is set. The flag should be set soon since getting
+	 * a response is indicative of having successfully sent the query.
+	 */
+	if (unlikely(!ib_sa_nl_query_sent(query))) {
+		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
+		wait_event(wait_queue, ib_sa_nl_query_sent(query));
+		spin_lock_irqsave(&ib_nl_request_lock, flags);
+	}
 
 	if (!ib_nl_is_good_resolve_resp(nlh)) {
 		/* if the result is a failure, send out the packet via IB */
-- 
1.8.3.1

