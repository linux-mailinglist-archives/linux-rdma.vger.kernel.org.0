Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3C82B814
	for <lists+linux-rdma@lfdr.de>; Mon, 27 May 2019 17:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfE0PCq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 May 2019 11:02:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54662 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfE0PCp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 May 2019 11:02:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4REs4lp193021;
        Mon, 27 May 2019 15:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=vfDEggQSXDDMDApuh85n/9fw87ur1avOGR9DQTcQE2o=;
 b=fMDqHryH9HKJw7OD5lrBMQ57P7x5GFqFTQApz9ha4OjX65wouJP/Gk2eG7yOXIbOy/32
 G8utBtHgcgkD4+nchURbYvl3fLMDoQuFHK9jHVHukUD/pongUyeOFXpByBavFX5+00Wf
 oHvQhgo7HgMASCcGi/jdLKXd3kFs0e82tuQMyYnvsKiKu7VSruG+1OLWMLI0eI8L0FDz
 e43WrfzDMu+8ShHXPlpaidLXv8vUonCANJQcVGU1t5bs8ViEnQaLtolnplCA8NNhcEYL
 bYFvqYTIlTnCrsiKtALU10N/cAVWocZN4sjReRcCMlbHZpEqZHygCTeiHcOy07pJvWEo nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2spw4t6pge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 May 2019 15:02:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4RExkoV131070;
        Mon, 27 May 2019 15:00:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2srbdwd6rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 May 2019 15:00:18 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4RF0FiP005514;
        Mon, 27 May 2019 15:00:15 GMT
Received: from host4.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 May 2019 08:00:14 -0700
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     yishaih@mellanox.com, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org, jgg@mellanox.com
Cc:     Yuval Shaia <yuval.shaia@oracle.com>
Subject: [PATCH rdma-core] verbs: Introduce a new reg_mr API for virtual address space
Date:   Mon, 27 May 2019 18:00:04 +0300
Message-Id: <20190527150004.21191-1-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9269 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905270106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9269 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905270106
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The virtual address that is registered is used as a base for any address
used later in post_recv and post_send operations.

On a virtualised environment this is not correct.

A guest cannot register its memory so hypervisor maps the guest physical
address to a host virtual address and register it with the HW. Later on,
at datapath phase, the guest fills the SGEs with addresses from its
address space.
Since HW cannot access guest virtual address space an extra translation
is needed to map those addresses to be based on the host virtual address
that was registered with the HW.

To avoid this, a logical separation between the address that is
registered and the address that is used as a offset at datapath phase is
needed.

This separation is already implemented in the lower layer part
(ibv_cmd_reg_mr) but blocked at the API level.

Fix it by introducing a new API function that accepts a address from
guest virtual address space as well.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 libibverbs/verbs.c | 24 ++++++++++++++++++++++++
 libibverbs/verbs.h |  6 ++++++
 2 files changed, 30 insertions(+)

diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
index 1766b9f5..9ad74ee0 100644
--- a/libibverbs/verbs.c
+++ b/libibverbs/verbs.c
@@ -324,6 +324,30 @@ LATEST_SYMVER_FUNC(ibv_reg_mr, 1_1, "IBVERBS_1.1",
 	return mr;
 }
 
+LATEST_SYMVER_FUNC(ibv_reg_mr_virt_as, 1_1, "IBVERBS_1.1",
+		   struct ibv_mr *,
+		   struct ibv_pd *pd, void *addr, size_t length,
+		   uint64_t hca_va, int access)
+{
+	struct verbs_mr *vmr;
+	struct ibv_reg_mr cmd;
+	struct ib_uverbs_reg_mr_resp resp;
+	int ret;
+
+	vmr = malloc(sizeof(*vmr));
+	if (!vmr)
+		return NULL;
+
+	ret = ibv_cmd_reg_mr(pd, addr, length, hca_va, access, vmr, &cmd,
+			     sizeof(cmd), &resp, sizeof(resp));
+	if (ret) {
+		free(vmr);
+		return NULL;
+	}
+
+	return &vmr->ibv_mr;
+}
+
 LATEST_SYMVER_FUNC(ibv_rereg_mr, 1_1, "IBVERBS_1.1",
 		   int,
 		   struct ibv_mr *mr, int flags,
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index cb2d8439..7b3e12a5 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -2372,6 +2372,12 @@ static inline int ibv_close_xrcd(struct ibv_xrcd *xrcd)
 struct ibv_mr *ibv_reg_mr(struct ibv_pd *pd, void *addr,
 			  size_t length, int access);
 
+/**
+ * ibv_reg_mr_virt_as - Register a memory region with address from virtual
+ * address space
+ */
+struct ibv_mr *ibv_reg_mr_virt_as(struct ibv_pd *pd, void *addr, size_t length,
+				  uint64_t hca_va, int access);
 
 enum ibv_rereg_mr_err_code {
 	/* Old MR is valid, invalid input */
-- 
2.20.1

