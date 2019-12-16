Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2953C1204AE
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2019 13:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfLPMFE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Dec 2019 07:05:04 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36716 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfLPMFE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Dec 2019 07:05:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBGBxKjh123297;
        Mon, 16 Dec 2019 12:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=wo/CQisY+w2+IOb2wFp2A0hAr6aaU6g8hzIuvvri2vU=;
 b=bIPqrPWXtFgajnc89s854mHVWJ5F6jHg+/w3mCXniFUcSr8vl0yeZbKuLsgcGL/whflc
 AHHe1DJ4wBkYKljhlowWHpN9ra+D7ufoSZKFxGAITl0hxU/FDLHkQpMWDDZHty3l82qD
 cR8BhDAIiJZgnrI/OdRsyMt1hziuUZEWexmF2cbMufZAYdkhmC7F76K9O46dnOJg9l5e
 CH6h8lpcRdKQLiJ0l02JTGDgi6l9i7YtpwpcxOcaG+nr4bhrww6vZVNQGtBa5ENUo5XG
 wPbvQqaP/W8HacgSkT9p3HeuB//F1rVtIosee6JW9ePRi/tM/KopvrweNx5NHmnNW2i8 9A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wvqppy3vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Dec 2019 12:04:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBGC3c02188262;
        Mon, 16 Dec 2019 12:04:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2ww98qvxd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Dec 2019 12:04:51 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBGC4nbF008391;
        Mon, 16 Dec 2019 12:04:50 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Dec 2019 04:04:49 -0800
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Mark Haywood <mark.haywood@oracle.com>
Subject: [PATCH RDMA/netlink v2] RDMA/netlink: Adhere to returning zero on success
Date:   Mon, 16 Dec 2019 13:04:36 +0100
Message-Id: <20191216120436.3204814-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9472 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912160108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9472 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912160108
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In rdma_nl_rcv_skb(), the local variable err is assigned the return
value of the supplied callback function, which could be one of
ib_nl_handle_resolve_resp(), ib_nl_handle_set_timeout(), or
ib_nl_handle_ip_res_resp(). These three functions all return skb->len
on success.

rdma_nl_rcv_skb() is merely a copy of netlink_rcv_skb(). The callback
functions used by the latter have the convention: "Returns 0 on
success or a negative error code".

In particular, the statement (equal for both functions):

   if (nlh->nlmsg_flags & NLM_F_ACK || err)

implies that rdma_nl_rcv_skb() always will ack a message, independent
of the NLM_F_ACK being set in nlmsg_flags or not.

The fix could be to change the above statement, but it is better to
keep the two *_rcv_skb() functions equal in this respect and instead
change the callback functions in the rdma subsystem to the correct
convention.

Suggested-by: Mark Haywood <mark.haywood@oracle.com>
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Tested-by: Mark Haywood <mark.haywood@oracle.com>
Fixes: 2ca546b92a02 ("IB/sa: Route SA pathrecord query through netlink")
Fixes: ae43f8286730 ("IB/core: Add IP to GID netlink offload")

---
    v1 -> v2:
       * Realized sk_buff::len is unsigned, hence simply returning
         zero in the good case
---
 drivers/infiniband/core/addr.c     | 2 +-
 drivers/infiniband/core/sa_query.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 606fa6d86685..1753a9801b70 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -139,7 +139,7 @@ int ib_nl_handle_ip_res_resp(struct sk_buff *skb,
 	if (ib_nl_is_good_ip_resp(nlh))
 		ib_nl_process_good_ip_rsep(nlh);
 
-	return skb->len;
+	return 0;
 }
 
 static int ib_nl_ip_send_msg(struct rdma_dev_addr *dev_addr,
diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 8917125ea16d..30d4c126a2db 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -1068,7 +1068,7 @@ int ib_nl_handle_set_timeout(struct sk_buff *skb,
 	}
 
 settimeout_out:
-	return skb->len;
+	return 0;
 }
 
 static inline int ib_nl_is_good_resolve_resp(const struct nlmsghdr *nlh)
@@ -1139,7 +1139,7 @@ int ib_nl_handle_resolve_resp(struct sk_buff *skb,
 	}
 
 resp_out:
-	return skb->len;
+	return 0;
 }
 
 static void free_sm_ah(struct kref *kref)
-- 
2.20.1

