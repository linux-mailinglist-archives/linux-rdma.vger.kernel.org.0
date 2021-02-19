Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B060631FA42
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Feb 2021 15:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBSOEg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Feb 2021 09:04:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229553AbhBSOEY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Feb 2021 09:04:24 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11JE1i6U070133;
        Fri, 19 Feb 2021 09:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=iWZ0fKme2wbdlR/QlaFVz0SuVsw7wbxPBDvLyiwUAyQ=;
 b=GEqYHBQpwmr+OjlyGOLS2348NIkMXZYr1Hx8K9h06OqtgvyH19sVHNjj+wJPgwTAQOOJ
 S/PoCt0uCIDKJg2LeMzFlCfQObSKTjm1vqqRGjjadNL8otdwqI09p2+kk/Lrs4ggF1LG
 9b1TI04LjQKMQ0J3vLgsQgeXNjzj4ZmjZwE7tXzOI5UQnDBqV6nzVyzGUvIyP2XTQ/G0
 RuQjouFmFd/je8boV4v53Xd9S1W5dx7rborNaaL8tc1ANhZfFaiY1YgiYifE7x+mrcy9
 v1Xo6M+D5skUNRcGLvVo5q4XbhqgvSLczWxrdIQa9RSpEZEIPje/V1rX466Bvgxzi0CC zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36tenqg8mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 09:03:40 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11JE1rh5071329;
        Fri, 19 Feb 2021 09:03:40 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36tenqg8jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 09:03:40 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11JE3an1024454;
        Fri, 19 Feb 2021 14:03:37 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 36p6d8axh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 14:03:37 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11JE3ZHr23331204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 14:03:35 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4715DA405B;
        Fri, 19 Feb 2021 14:03:35 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 028D2A406A;
        Fri, 19 Feb 2021 14:03:35 +0000 (GMT)
Received: from Pescara.zurich.ibm.com (unknown [9.171.85.34])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Feb 2021 14:03:34 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     gg@ziepe.ca, Bernard Metzler <bmt@zurich.ibm.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH] RDMA/iwcm: Allow AFONLY binding for IPv6 addresses.
Date:   Fri, 19 Feb 2021 15:02:54 +0100
Message-Id: <20210219140254.1022-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_05:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190109
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Binding IPv6 address/port to AF_INET6 domain only is provided
via rdma_set_afonly(), but was not signalled to the provider.
Applications like NFS/RDMA bind the same port to both IPv4
and IPv6 addresses simultaneously and thus rely on it working
correctly.

Tested-by: Chuck Lever <chuck.lever@oracle.com>
Tested-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/core/cma.c      |  1 +
 drivers/infiniband/sw/siw/siw_cm.c | 19 +++++++++++++++++--
 include/rdma/iw_cm.h               |  1 +
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index c51b84b2d2f3..046d42c1f8f3 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2466,6 +2466,7 @@ static int cma_iw_listen(struct rdma_id_private *id_priv, int backlog)
 
 	id->tos = id_priv->tos;
 	id->tos_set = id_priv->tos_set;
+	id->afonly = id_priv->afonly;
 	id_priv->cm_id.iw = id;
 
 	memcpy(&id_priv->cm_id.iw->local_addr, cma_src_addr(id_priv),
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 1f9e15b71504..8bd0d0785433 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1300,7 +1300,7 @@ static void siw_cm_llp_state_change(struct sock *sk)
 }
 
 static int kernel_bindconnect(struct socket *s, struct sockaddr *laddr,
-			      struct sockaddr *raddr)
+			      struct sockaddr *raddr, bool afonly)
 {
 	int rv, flags = 0;
 	size_t size = laddr->sa_family == AF_INET ?
@@ -1311,6 +1311,12 @@ static int kernel_bindconnect(struct socket *s, struct sockaddr *laddr,
 	 */
 	sock_set_reuseaddr(s->sk);
 
+	if (afonly) {
+		rv = ip6_sock_set_v6only(s->sk);
+		if (rv) 
+			return rv;
+	}
+
 	rv = s->ops->bind(s, laddr, size);
 	if (rv < 0)
 		return rv;
@@ -1371,7 +1377,7 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	 * mode. Might be reconsidered for async connection setup at
 	 * TCP level.
 	 */
-	rv = kernel_bindconnect(s, laddr, raddr);
+	rv = kernel_bindconnect(s, laddr, raddr, id->afonly);
 	if (rv != 0) {
 		siw_dbg_qp(qp, "kernel_bindconnect: error %d\n", rv);
 		goto error;
@@ -1786,6 +1792,15 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 	} else {
 		struct sockaddr_in6 *laddr = &to_sockaddr_in6(id->local_addr);
 
+		if (id->afonly) {
+			rv = ip6_sock_set_v6only(s->sk);
+			if (rv) {
+				siw_dbg(id->device,
+					"ip6_sock_set_v6only erro: %d\n", rv);
+				goto error;
+			}
+		}
+
 		/* For wildcard addr, limit binding to current device only */
 		if (ipv6_addr_any(&laddr->sin6_addr))
 			s->sk->sk_bound_dev_if = sdev->netdev->ifindex;
diff --git a/include/rdma/iw_cm.h b/include/rdma/iw_cm.h
index 91975400e1b3..03abd30e6c8c 100644
--- a/include/rdma/iw_cm.h
+++ b/include/rdma/iw_cm.h
@@ -70,6 +70,7 @@ struct iw_cm_id {
 	u8  tos;
 	bool tos_set:1;
 	bool mapped:1;
+	bool afonly:1;
 };
 
 struct iw_cm_conn_param {
-- 
2.17.2

