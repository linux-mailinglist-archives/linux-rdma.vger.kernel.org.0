Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C7831FB04
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Feb 2021 15:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhBSOgf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Feb 2021 09:36:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230280AbhBSOfb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Feb 2021 09:35:31 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11JEXMCv026346;
        Fri, 19 Feb 2021 09:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=iWZ0fKme2wbdlR/QlaFVz0SuVsw7wbxPBDvLyiwUAyQ=;
 b=Zo1UjzU5rvmaktNRpAS8Nxr878aoE9hmrD8d9wpQGC4ddzR9mkCPT7GSJ4vcSSzyaESa
 UQxWdGf/nxn0AE6JavCQKvJih+at8eACuEeudB0zZqwmAm+0yg4lS6kEqoSF9KxXZtLr
 0EKpPZPCRlS2Ib3vGo3VEva6o/DLhgePSBxOqsPTnnlCTXgUurDigcHaHEQC5TD8rMWU
 ufe4ZPm2XgmWa5KBANUdCoOrtENy1SfXqU2+p4fPKtiTBGq6QxZGBQ0kVNnVYPjrPBmW
 aNzD+adS01z+fA2xAvZAD0XdfEd/aj4jVmDyD5ejHW+btCAc4TmRRo069DCIehDX+4rV JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36tehv1h74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 09:34:50 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11JEXU9S026986;
        Fri, 19 Feb 2021 09:34:49 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36tehv1h67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 09:34:49 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11JEWrcn008968;
        Fri, 19 Feb 2021 14:34:47 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 36p61hdn2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 14:34:47 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11JEYXx332964964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 14:34:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF847A4064;
        Fri, 19 Feb 2021 14:34:44 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A642A4066;
        Fri, 19 Feb 2021 14:34:44 +0000 (GMT)
Received: from Pescara.zurich.ibm.com (unknown [9.171.85.34])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Feb 2021 14:34:44 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, Bernard Metzler <bmt@zurich.ibm.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH] RDMA/iwcm: Allow AFONLY binding for IPv6 addresses.
Date:   Fri, 19 Feb 2021 15:34:41 +0100
Message-Id: <20210219143441.1068-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_05:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102190112
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

