Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 237BE1086F3
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2019 05:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKYEPM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Nov 2019 23:15:12 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54812 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfKYEPM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 24 Nov 2019 23:15:12 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAP4DqEO088720;
        Mon, 25 Nov 2019 04:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2019-08-05;
 bh=WJrw8pBLZhnlfqOpopMiV5myCWZu7hP0u3UDVZxLG2o=;
 b=M4fqXeoVB2XJnS2oDi780MiTHoJygnkXoPvLe4N8AdO1c20H8rJSsdmRL7cmLgNvFCOI
 5UtrYW/uh8RRZ2lTZWzAYx7WdoOttLnLNLLU1u7bee3G3HgB0+Xhb0FOHUXTGGa1fzQU
 NjeEwdSMfp6gayCO6btlWlBf3nYoBzBWP55be/K5092+QuY4cQv6A4mhS2CK4gxQJCA1
 t+SaTC5LlpLPw5G+pLNyz3kXQ+3CLhCQ4Kg/1q5nSbLdWIM+zZgZWfUeicfRMYw72NLj
 Y9VYXrrdjfzSKX2ZDhSzLzfA5FeHNYk6en9ha3+GQS60laAzFvaY5NQCk+yaS6o5GFLo xA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wewdqvw9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 04:14:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAP4Cser012107;
        Mon, 25 Nov 2019 04:14:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2wfe7y886q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 04:14:35 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAP4EXSe026863;
        Mon, 25 Nov 2019 04:14:33 GMT
Received: from shipfan.cn.oracle.com (/10.113.210.105)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 24 Nov 2019 20:14:33 -0800
From:   Zhu Yanjun <yanjun.zhu@oracle.com>
To:     dledford@redhat.com, jgg@ziepe.ca, michael.j.ruhl@intel.com,
        ira.weiny@intel.com, rostedt@goodmis.org, leon@kernel.org,
        kamalheib1@gmail.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Subject: [PATCHv2 1/1] RDMA/core: avoid kernel NULL pointer error
Date:   Sun, 24 Nov 2019 23:24:35 -0500
Message-Id: <1574655875-3475-1-git-send-email-yanjun.zhu@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911250037
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911250037
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When the interface related with IB device is set to down/up over and
over again, the following call trace will pop out.
"
 Call Trace:
  [<ffffffffa039ff8d>] ib_mad_completion_handler+0x7d/0xa0 [ib_mad]
  [<ffffffff810a1a41>] process_one_work+0x151/0x4b0
  [<ffffffff810a1ec0>] worker_thread+0x120/0x480
  [<ffffffff810a709e>] kthread+0xce/0xf0
  [<ffffffff816e9962>] ret_from_fork+0x42/0x70

 RIP  [<ffffffffa039f926>] ib_mad_recv_done_handler+0x26/0x610 [ib_mad]
"
From vmcore, we can find the following:
"
crash7lates> struct ib_mad_list_head ffff881fb3713400
struct ib_mad_list_head {
  list = {
    next = 0xffff881fb3713800,
    prev = 0xffff881fe01395c0
  },
  mad_queue = 0x0
}
"

Before the call trace, a lot of ib_cancel_mad is sent to the sender.
So it is necessary to check mad_queue in struct ib_mad_list_head to avoid
"kernel NULL pointer" error.

From the new customer report, when there is something wrong with IB HW/FW,
the above call trace will appear. It seems that bad IB HW/FW will cause
this problem.

Signed-off-by: Zhu Yanjun <yanjun.zhu@oracle.com>
---
V1->V2: Add new bug symptoms.
---
 drivers/infiniband/core/mad.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 9947d16..43f596c 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2279,6 +2279,17 @@ static void ib_mad_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		return;
 	}
 
+	if (unlikely(!mad_list->mad_queue)) {
+		/*
+		 * When the interface related with IB device is set to down/up,
+		 * a lot of ib_cancel_mad packets are sent to the sender. In
+		 * sender, the mad packets are cancelled.  The receiver will
+		 * find mad_queue NULL. If the receiver does not test mad_queue,
+		 * the receiver will crash with "kernel NULL pointer" error.
+		 */
+		return;
+	}
+
 	qp_info = mad_list->mad_queue->qp_info;
 	dequeue_mad(mad_list);
 
-- 
2.7.4

