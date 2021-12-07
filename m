Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D3946C68E
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 22:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhLGVVQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 16:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhLGVVO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Dec 2021 16:21:14 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58ADC061574
        for <linux-rdma@vger.kernel.org>; Tue,  7 Dec 2021 13:17:43 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso582216otj.1
        for <linux-rdma@vger.kernel.org>; Tue, 07 Dec 2021 13:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1hdrZbVIkxBgshTkvm8cv6kxLV+NxS4x9aZ5UMFkuqQ=;
        b=AN52PRuPNDCGVb8C41UlWyhK1Rq+9F/ehaF1xxSZfBzxrE6rWTfG29Cfgh5qysm6Kk
         yrVkZhhq0XkzgmkP0x+h5aaLXHHxKKz5TEpzzpbKCuqcpsRNVokuplTtNshoC7++plb+
         RAs4yD/kYMfwEL/6+OCoi86Ium7OQ6PiPvk1/dEqlGdT7ksUUYHEIUPwROlx/YFp1F0C
         6dGhl8+s/yEzTyzOfNvmwa68+W/T/te8TEHwfnjPfvFmlyTyls9hWXA0EhMr4FOBGrNL
         r0xveeKw6ddVPta4H09XNo9N5DIvPuwnerxZ/bXHUOz1GobKWyGqCqSFqj7gYq2qe3Vw
         oxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1hdrZbVIkxBgshTkvm8cv6kxLV+NxS4x9aZ5UMFkuqQ=;
        b=W1N+WoC7Y3yx97ETqzfmEgj4hXRyvJRHWUqd6vmC2kDqUtrhAHKmUcLNPshwjTPp5q
         SgiEYhhqlFSiMnBXKxc99T2S0x4QcXx4STuM+Dr+CGVITvrJAznOKxhp6DzN5Osj/16g
         Gzzu/kGP5Y3Um6qAI50mwOU2qOtBYxqZIio9Ur4Ay5R7aNqdX+bVtWLs8Gzx9fSw7wss
         vVNRzjoTijyxHy35LMm7XKnJUPO08KRBHXAHw64puD2Fbr0DlPaqD95/A+b2aT6QP2rQ
         Af1eXF+5jujMlRTRehAs3rX6nAMs3yeXseH8Sqh9qxsjvDuIDvcnjrQr6rTmewGeUgf8
         HPiQ==
X-Gm-Message-State: AOAM533GkMnCiBpR/CdoEbOOJEZ13SlRO+CANrdobIZOLcxWwv2cMu6m
        thONWLYCjIUj68QNnzOt95y+Up+HjrU=
X-Google-Smtp-Source: ABdhPJy6B5WQIQwqKv+NmxmWz3CUZ0EK2TMUxFbrcOBOQS6FoTDMuYA70eBgUP9az1Nu+tHhJr/iVA==
X-Received: by 2002:a9d:7b51:: with SMTP id f17mr37585403oto.88.1638911863222;
        Tue, 07 Dec 2021 13:17:43 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-c177-2672-65e9-b340.res6.spectrum.com. [2603:8081:140c:1a00:c177:2672:65e9:b340])
        by smtp.googlemail.com with ESMTPSA id w4sm188466oiv.37.2021.12.07.13.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 13:17:42 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v2] Providers/rxe: Replace AV by AH for UD sends
Date:   Tue,  7 Dec 2021 15:17:01 -0600
Message-Id: <20211207211701.43027-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently the rxe provider computes an AV for each AH created. These
are then passed to the kernel in each UD send WQE. This rxe provider
patch matches a set of kernel patches that creates an index for the
pool of AHs which are passed back to the rxe provider which in turn
returns them in the UD send WQEs instead of AVs. This falls back to
the older AV based WQE if either the rxe provider or the kernel does
not have these patches applied.

This patch applies cleanly to

commit 3cc40881ef17 ("Merge pull request #1103 from nmorey/dev/master/suse")

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2
  Rebased to current rdma-core
---
 providers/rxe/rxe-abi.h |   2 +
 providers/rxe/rxe.c     | 117 ++++++++++++++++++++++++++--------------
 providers/rxe/rxe.h     |   8 ++-
 3 files changed, 85 insertions(+), 42 deletions(-)

diff --git a/providers/rxe/rxe-abi.h b/providers/rxe/rxe-abi.h
index 0689c3f4..020201a9 100644
--- a/providers/rxe/rxe-abi.h
+++ b/providers/rxe/rxe-abi.h
@@ -39,6 +39,8 @@
 #include <rdma/rdma_user_rxe.h>
 #include <kernel-abi/rdma_user_rxe.h>
 
+DECLARE_DRV_CMD(urxe_create_ah, IB_USER_VERBS_CMD_CREATE_AH,
+		empty, rxe_create_ah_resp);
 DECLARE_DRV_CMD(urxe_create_cq, IB_USER_VERBS_CMD_CREATE_CQ,
 		empty, rxe_create_cq_resp);
 DECLARE_DRV_CMD(urxe_create_cq_ex, IB_USER_VERBS_EX_CMD_CREATE_CQ,
diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 0119474a..9050bd31 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -975,16 +975,20 @@ static void wr_set_ud_addr(struct ibv_qp_ex *ibqp, struct ibv_ah *ibah,
 			   uint32_t remote_qpn, uint32_t remote_qkey)
 {
 	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
-	struct rxe_ah *ah = container_of(ibah, struct rxe_ah, ibv_ah);
+	struct rxe_ah *ah = to_rah(ibah);
 	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue,
 						   qp->cur_index - 1);
 
 	if (qp->err)
 		return;
 
-	memcpy(&wqe->wr.wr.ud.av, &ah->av, sizeof(ah->av));
 	wqe->wr.wr.ud.remote_qpn = remote_qpn;
 	wqe->wr.wr.ud.remote_qkey = remote_qkey;
+	wqe->wr.wr.ud.ah_num = ah->ah_num;
+
+	if (!ah->ah_num)
+		/* old kernels only */
+		memcpy(&wqe->wr.wr.ud.av, &ah->av, sizeof(ah->av));
 }
 
 static void wr_set_inline_data(struct ibv_qp_ex *ibqp, void *addr,
@@ -1405,7 +1409,8 @@ static int validate_send_wr(struct rxe_qp *qp, struct ibv_send_wr *ibwr,
 	return 0;
 }
 
-static void convert_send_wr(struct rxe_send_wr *kwr, struct ibv_send_wr *uwr)
+static void convert_send_wr(struct rxe_qp *qp, struct rxe_send_wr *kwr,
+					struct ibv_send_wr *uwr)
 {
 	struct ibv_mw *ibmw;
 	struct ibv_mr *ibmr;
@@ -1428,8 +1433,13 @@ static void convert_send_wr(struct rxe_send_wr *kwr, struct ibv_send_wr *uwr)
 
 	case IBV_WR_SEND:
 	case IBV_WR_SEND_WITH_IMM:
-		kwr->wr.ud.remote_qpn		= uwr->wr.ud.remote_qpn;
-		kwr->wr.ud.remote_qkey		= uwr->wr.ud.remote_qkey;
+		if (qp_type(qp) == IBV_QPT_UD) {
+			struct rxe_ah *ah = to_rah(uwr->wr.ud.ah);
+
+			kwr->wr.ud.remote_qpn	= uwr->wr.ud.remote_qpn;
+			kwr->wr.ud.remote_qkey	= uwr->wr.ud.remote_qkey;
+			kwr->wr.ud.ah_num	= ah->ah_num;
+		}
 		break;
 
 	case IBV_WR_ATOMIC_CMP_AND_SWP:
@@ -1465,11 +1475,15 @@ static int init_send_wqe(struct rxe_qp *qp, struct rxe_wq *sq,
 	int i;
 	unsigned int opcode = ibwr->opcode;
 
-	convert_send_wr(&wqe->wr, ibwr);
+	convert_send_wr(qp, &wqe->wr, ibwr);
 
-	if (qp_type(qp) == IBV_QPT_UD)
-		memcpy(&wqe->wr.wr.ud.av, &to_rah(ibwr->wr.ud.ah)->av,
-		       sizeof(struct rxe_av));
+	if (qp_type(qp) == IBV_QPT_UD) {
+		struct rxe_ah *ah = to_rah(ibwr->wr.ud.ah);
+
+		if (!ah->ah_num)
+			/* old kernels only */
+			memcpy(&wqe->wr.wr.ud.av, &ah->av, sizeof(struct rxe_av));
+	}
 
 	if (ibwr->send_flags & IBV_SEND_INLINE) {
 		uint8_t *inline_data = wqe->dma.inline_data;
@@ -1644,59 +1658,82 @@ static inline int rdma_gid2ip(sockaddr_union_t *out, union ibv_gid *gid)
 	return 0;
 }
 
-static struct ibv_ah *rxe_create_ah(struct ibv_pd *pd, struct ibv_ah_attr *attr)
+static int rxe_create_av(struct rxe_ah *ah, struct ibv_pd *pd,
+			 struct ibv_ah_attr *attr)
 {
-	int err;
-	struct rxe_ah *ah;
-	struct rxe_av *av;
+	struct rxe_av *av = &ah->av;
 	union ibv_gid sgid;
-	struct ib_uverbs_create_ah_resp resp;
-
-	err = ibv_query_gid(pd->context, attr->port_num, attr->grh.sgid_index,
-			    &sgid);
-	if (err) {
-		fprintf(stderr, "rxe: Failed to query sgid.\n");
-		return NULL;
-	}
+	int ret;
 
-	ah = calloc(1, sizeof(*ah));
-	if (ah == NULL)
-		return NULL;
+	ret = ibv_query_gid(pd->context, attr->port_num,
+			attr->grh.sgid_index, &sgid);
+	if (ret)
+		return ret;
 
-	av = &ah->av;
 	av->port_num = attr->port_num;
 	memcpy(&av->grh, &attr->grh, sizeof(attr->grh));
-	av->network_type =
-		ipv6_addr_v4mapped((struct in6_addr *)attr->grh.dgid.raw) ?
-		RXE_NETWORK_TYPE_IPV4 : RXE_NETWORK_TYPE_IPV6;
+
+	ret = ipv6_addr_v4mapped((struct in6_addr *)attr->grh.dgid.raw);
+	av->network_type = ret ? RXE_NETWORK_TYPE_IPV4 :
+				 RXE_NETWORK_TYPE_IPV6;
 
 	rdma_gid2ip(&av->sgid_addr, &sgid);
 	rdma_gid2ip(&av->dgid_addr, &attr->grh.dgid);
-	if (ibv_resolve_eth_l2_from_gid(pd->context, attr, av->dmac, NULL)) {
-		free(ah);
-		return NULL;
-	}
 
-	memset(&resp, 0, sizeof(resp));
-	if (ibv_cmd_create_ah(pd, &ah->ibv_ah, attr, &resp, sizeof(resp))) {
-		free(ah);
+	ret = ibv_resolve_eth_l2_from_gid(pd->context, attr,
+					  av->dmac, NULL);
+
+	return ret;
+}
+
+/*
+ * Newer kernels will return a non-zero AH index in resp.ah_num
+ * which can be returned in UD send WQEs.
+ * Older kernels will leave ah_num == 0. For these create an AV and use
+ * in UD send WQEs.
+ */
+static struct ibv_ah *rxe_create_ah(struct ibv_pd *pd,
+					struct ibv_ah_attr *attr)
+{
+	struct rxe_ah *ah;
+	struct urxe_create_ah_resp resp = {};
+	int ret;
+
+	ah = calloc(1, sizeof(*ah));
+	if (!ah)
 		return NULL;
+
+	ret = ibv_cmd_create_ah(pd, &ah->ibv_ah, attr,
+				&resp.ibv_resp, sizeof(resp));
+	if (ret)
+		goto err_free;
+
+	ah->ah_num = resp.ah_num;
+
+	if (!ah->ah_num) {
+		/* old kernels only */
+		ret = rxe_create_av(ah, pd, attr);
+		if (ret)
+			goto err_free;
 	}
 
 	return &ah->ibv_ah;
+
+err_free:
+	free(ah);
+	return NULL;
 }
 
 static int rxe_destroy_ah(struct ibv_ah *ibah)
 {
-	int ret;
 	struct rxe_ah *ah = to_rah(ibah);
+	int ret;
 
 	ret = ibv_cmd_destroy_ah(&ah->ibv_ah);
-	if (ret)
-		return ret;
+	if (!ret)
+		free(ah);
 
-	free(ah);
-	return 0;
+	return ret;
 }
 
 static const struct verbs_context_ops rxe_ctx_ops = {
diff --git a/providers/rxe/rxe.h b/providers/rxe/rxe.h
index ddb8fe89..6882d9c7 100644
--- a/providers/rxe/rxe.h
+++ b/providers/rxe/rxe.h
@@ -67,6 +67,7 @@ struct rxe_cq {
 struct rxe_ah {
 	struct ibv_ah		ibv_ah;
 	struct rxe_av		av;
+	int			ah_num;
 };
 
 struct rxe_wq {
@@ -89,8 +90,6 @@ struct rxe_qp {
 	int			err;
 };
 
-#define qp_type(qp)		((qp)->vqp.qp.qp_type)
-
 struct rxe_srq {
 	struct ibv_srq		ibv_srq;
 	struct mminfo		mmap_info;
@@ -130,4 +129,9 @@ static inline struct rxe_ah *to_rah(struct ibv_ah *ibah)
 	return to_rxxx(ah, ah);
 }
 
+static inline enum ibv_qp_type qp_type(struct rxe_qp *qp)
+{
+	return qp->vqp.qp.qp_type;
+}
+
 #endif /* RXE_H */
-- 
2.32.0

