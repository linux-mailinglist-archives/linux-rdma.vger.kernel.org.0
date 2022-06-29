Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029DC5606AB
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jun 2022 18:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiF2Qt7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jun 2022 12:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiF2Qt4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jun 2022 12:49:56 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5763B13F81
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jun 2022 09:49:55 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id mf9so33875782ejb.0
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jun 2022 09:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DU5+CFC2WoBVppnaTL5VaG3r0cY2p2xU+tbOEwdfHrg=;
        b=kNxvyam4JM7FkpGsln++6N8F233CpT+7nt0xYssDiNN9mL8A8Vehseg2W5NWfxwpa/
         DIXa1WkyJQqA/YQTCcNWvye5GGO45YhX1aPZIYDqLUzKvdYy5gJ/Ftm3KmlVnGDLOb6b
         D9YAmj6WDiSqq25qMvukAfgh1z7gpmbgabNyS24v91iC+ucUvVZp0Tgwq4vydvt/fKGD
         DDlhWf87mfqzRLGhxF3jOKa8jgtFm3v03971ZfkuC7+x1Hfg+SOliSNE1ebfpl386fWD
         DpA+T6Yqr6QoM1cEt/NN0Mgskv2AnVagyJBt++lsrJUXZrodr0ceEII6RdCPLA/VqWgJ
         VNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DU5+CFC2WoBVppnaTL5VaG3r0cY2p2xU+tbOEwdfHrg=;
        b=j8PPGphiO3/CgHLTdxlQgixtOQVuqpu8IhoYYALmLpFFWZt0ZxRgVdAnY+wbTcI8C+
         CiOQmyvZ1KjRxZBc4MtBS7JlTjnUcLqDTeVNQjht0ohlNJLp3OZQBXeh/T6xloMMcAkE
         CT+fGVtCVScxleDCzUsS+xqxDIoo6o1P0yqthHkJMkFrYvF/SJHiRoAO4Tacwu30JJCG
         Ztnp5CKOQmtRIzNWB/qYnDok+voPiSwaNMO2/AW4C8BsKKidSiYzggwuuP0v8uEm2jHE
         suL1zlHNUwayAi9fjUWOy17gYEmqJRgLw+2aTfFQWwA55jfMPbDmbrmH5tk3HH1QHhFg
         q7Vg==
X-Gm-Message-State: AJIora9btvomFL09c/TnOvZav2q7w8I59FizAoS0CPoyBaeinSB/rP2K
        kHBuHB6w6AdMNpbS54hwJC3JosWjramX32ktN6I=
X-Google-Smtp-Source: AGRyM1seZI770LTw856ECBbotO9w0XqX5x+0qng8qGpjtnqRA/oNj1EM3Sylo4GhDcPQ9iRS0+bRyA==
X-Received: by 2002:a17:907:8a21:b0:728:7984:76d with SMTP id sc33-20020a1709078a2100b007287984076dmr4302942ejc.189.1656521393666;
        Wed, 29 Jun 2022 09:49:53 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id o12-20020a056402038c00b0043561e0c9adsm11482745edv.52.2022.06.29.09.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 09:49:53 -0700 (PDT)
From:   Md Haris Iqbal <haris.phnx@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     zyjzyj2000@gmail.com, aleksei.marov@ionos.com, leon@kernel.org,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.phnx@gmail.com>, rpearsonhpe@gmail.com
Subject: [PATCH] RDMA/rxe: For invalidate compare keys according to the MR access
Date:   Wed, 29 Jun 2022 18:49:46 +0200
Message-Id: <20220629164946.521293-1-haris.phnx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In rxe, the access permissions decide which of the lkey/rkey would be set
during an MR registration. For an MR with only LOCAL access, only lkey is
set and rkey stays 0. For an MR with REMOTE access, both lkey and rkey are
set, such that rkey=lkey.

Hence, for MR invalidate, do the comparison for keys according to the MR
access. Since the invalidate wr can contain only a single key
(ex.invalidate_rkey), it should match MR->rkey if the MR being invalidated
has REMOTE access. If the MR has only LOCAL access, then that key should
match MR->lkey.

Fixes: 3902b429ca14 ("RDMA/rxe: Implement invalidate MW operations")
Cc: rpearsonhpe@gmail.com
Signed-off-by: Md Haris Iqbal <haris.phnx@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h |  2 +-
 drivers/infiniband/sw/rxe/rxe_mr.c  | 17 +++++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 0e022ae1b8a5..37484a559d20 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -77,7 +77,7 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
-int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
+int rxe_invalidate_mr(struct rxe_qp *qp, u32 key);
 int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr);
 int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index fc3942e04a1f..790cff7077fd 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -576,22 +576,27 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 	return mr;
 }
 
-int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
+int rxe_invalidate_mr(struct rxe_qp *qp, u32 key)
 {
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct rxe_mr *mr;
 	int ret;
 
-	mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
+	mr = rxe_pool_get_index(&rxe->mr_pool, key >> 8);
 	if (!mr) {
-		pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
+		pr_err("%s: No MR for key %#x\n", __func__, key);
 		ret = -EINVAL;
 		goto err;
 	}
 
-	if (rkey != mr->rkey) {
-		pr_err("%s: rkey (%#x) doesn't match mr->rkey (%#x)\n",
-			__func__, rkey, mr->rkey);
+	if ((mr->access & IB_ACCESS_REMOTE) && key != mr->rkey) {
+		pr_err("%s: key (%#x) doesn't match mr->rkey (%#x)\n",
+			__func__, key, mr->rkey);
+		ret = -EINVAL;
+		goto err_drop_ref;
+	} else if ((mr->access & IB_ACCESS_LOCAL_WRITE) && key != mr->lkey) {
+		pr_err("%s: key (%#x) doesn't match mr->lkey (%#x)\n",
+			__func__, key, mr->lkey);
 		ret = -EINVAL;
 		goto err_drop_ref;
 	}
-- 
2.25.1

