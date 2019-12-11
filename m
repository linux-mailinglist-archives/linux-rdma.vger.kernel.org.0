Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D41F311A8FB
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2019 11:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfLKKeV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Dec 2019 05:34:21 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51870 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbfLKKeV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Dec 2019 05:34:21 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBBAXtXh079335;
        Wed, 11 Dec 2019 10:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=KrJgP+hPrA6HIMRw0ThGFo1a08LINcQPwDgkb5xVXm8=;
 b=CJqZO1Zsk3Zz1BNTdqb2Xfd7N/Eq5z1uXvBTrygNq20LT5h8kZJGjtRGAQBf43vFklus
 cB0y0AxXvAJVO2W1BXmTkHPLPyHJZPxQut6MaZnXvCCqJka2JR4GdOnY5qGSFkKqxxFi
 /tGc3/AKkrVA6ZpTvacj7ib3Gr7GWrEt4GKRTlX0ZYretfQ6S//Y4AR5oYyKbrV/CPWk
 CcIZPC5hQ2sINxn5Q5SzHPzcRdQoqoAnT++BlFijxPXOzjhHOJTbv355//RRcmDzGRUc
 HrIp6zuWrJCyr8qFK/dC/DwNlav/qODuvbYrHir5H+qM0mw0vVniu1WpxDo9Lo4RxJqY wQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2wr41qbsu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 10:34:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBBAXIa8128335;
        Wed, 11 Dec 2019 10:34:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2wte9brkyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 10:34:12 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBBAYBRk004650;
        Wed, 11 Dec 2019 10:34:11 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Dec 2019 02:34:10 -0800
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Mark Haywood <mark.haywood@oracle.com>
Subject: [PATCH RDMA/netlink] RDMA/netlink: Adhere to returning zero on success
Date:   Wed, 11 Dec 2019 11:34:00 +0100
Message-Id: <20191211103400.2949140-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9467 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912110093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9467 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912110093
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
---
 drivers/infiniband/core/addr.c     | 2 +-
 drivers/infiniband/core/sa_query.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 606fa6d86685..9449ed2536fa 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -139,7 +139,7 @@ int ib_nl_handle_ip_res_resp(struct sk_buff *skb,
 	if (ib_nl_is_good_ip_resp(nlh))
 		ib_nl_process_good_ip_rsep(nlh);
 
-	return skb->len;
+	return skb->len > 0 ? 0 : skb->len;
 }
 
 static int ib_nl_ip_send_msg(struct rdma_dev_addr *dev_addr,
diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 8917125ea16d..dc249e382367 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -1068,7 +1068,7 @@ int ib_nl_handle_set_timeout(struct sk_buff *skb,
 	}
 
 settimeout_out:
-	return skb->len;
+	return skb->len > 0 ? 0 : skb->len;
 }
 
 static inline int ib_nl_is_good_resolve_resp(const struct nlmsghdr *nlh)
@@ -1139,7 +1139,7 @@ int ib_nl_handle_resolve_resp(struct sk_buff *skb,
 	}
 
 resp_out:
-	return skb->len;
+	return skb->len > 0 ? 0 : skb->len;
 }
 
 static void free_sm_ah(struct kref *kref)
-- 
2.20.1

