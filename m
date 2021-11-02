Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9372144286B
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Nov 2021 08:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhKBHdr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Nov 2021 03:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhKBHdq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Nov 2021 03:33:46 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FE4C061714
        for <linux-rdma@vger.kernel.org>; Tue,  2 Nov 2021 00:31:12 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ee33so1605221edb.8
        for <linux-rdma@vger.kernel.org>; Tue, 02 Nov 2021 00:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e8EF6/XIlIGHi9ABjgm/8ym6m7zHmD2N7WKz5A7P42M=;
        b=k0WMAqrjdS69BPHYnuaCRIWtAEXocBBnVcffaDqCSdLw2gfK2hDJpD64yX1MIPSZQZ
         zmMsmX1nQgi9akXiKUdfTHgh9Rt4OPUtZWPLbhKoeOg96hyA0p725T8CyzTBxe1uVzBm
         CVPgvxWlfKZN/lgFX980Q9NZJ6AUgi1Rn/LHV1fMedFLydrsTMboUCqMAlSq+R21MtV5
         Xhinb2LOopIo3ak7ekgyM2FCnNMyfvKbOwW0vfStEarmWFIT+gPLlDQ6OrY5Cnnpokll
         Biz+XGt1dLqAJESWSga4x03PnQKAMcyfQXOanyp6AUtWHkMVVqcEvGi+nX0eruyAHylC
         KCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e8EF6/XIlIGHi9ABjgm/8ym6m7zHmD2N7WKz5A7P42M=;
        b=6+nsnkbrsyLkCNVakvTGz1gPuQ1bf/0i0qM492rxQp2AG3iImGLXSkQZgoLVqxiR7v
         7Kv96g0tqSZJTiDEFGz0RcTmovbJ1LXFHbo/4W7fEe7Rlgf2YMX/gbRk9bHSLptoSXZS
         YKihxFJw3lfqJohXqxG6pjh/5TmX7zGoO4WA5w2qs3+gexSCx+BxMTygS2AifsxDrrDB
         0HfIXqL8qTEK95WBuyp+/WRYxaHBeQMokI/loRuNzQyx5suxo/IwUvV4rrr62Vt4r0Z8
         6ht8Lq19n0Iuz5bIP6HWWtIa7c2nM2Mb8S+wTkArxqFuf1ZxkVtFmTB1CFRpudV57OGe
         IM1Q==
X-Gm-Message-State: AOAM530aq42c7R38yaWF17AEGdV9omq0ORxbnsZuu9tM8FC6LJD9hsqn
        fVKAQOwEv2QqD8+R6nkt+yW1RPDHfAaHsQ==
X-Google-Smtp-Source: ABdhPJzhCua0fuq4riDB72sZNFPxKiDC11RbOi3atZN/p7OsqoavOuEPs2GQP7OpP4tG+ClhNUhJ6A==
X-Received: by 2002:a05:6402:3547:: with SMTP id f7mr48577185edd.184.1635838270644;
        Tue, 02 Nov 2021 00:31:10 -0700 (PDT)
Received: from fedora.. ([2a00:a040:19b:e02f::1003])
        by smtp.gmail.com with ESMTPSA id nb17sm1063728ejc.7.2021.11.02.00.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 00:31:10 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/bnxt_re: Remove unsupported bnxt_re_modify_ah callback
Date:   Tue,  2 Nov 2021 09:30:54 +0200
Message-Id: <20211102073054.410838-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is no need to return always zero for function which is not
supported, especially since 0 is the wrong return code.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 5 -----
 drivers/infiniband/hw/bnxt_re/ib_verbs.h | 1 -
 drivers/infiniband/hw/bnxt_re/main.c     | 1 -
 3 files changed, 7 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index d5f347f8d088..29cc0d14399a 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -708,11 +708,6 @@ int bnxt_re_create_ah(struct ib_ah *ib_ah, struct rdma_ah_init_attr *init_attr,
 	return 0;
 }
 
-int bnxt_re_modify_ah(struct ib_ah *ib_ah, struct rdma_ah_attr *ah_attr)
-{
-	return 0;
-}
-
 int bnxt_re_query_ah(struct ib_ah *ib_ah, struct rdma_ah_attr *ah_attr)
 {
 	struct bnxt_re_ah *ah = container_of(ib_ah, struct bnxt_re_ah, ib_ah);
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index b5c6e0f4f877..94326267f9bb 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -166,7 +166,6 @@ int bnxt_re_alloc_pd(struct ib_pd *pd, struct ib_udata *udata);
 int bnxt_re_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);
 int bnxt_re_create_ah(struct ib_ah *ah, struct rdma_ah_init_attr *init_attr,
 		      struct ib_udata *udata);
-int bnxt_re_modify_ah(struct ib_ah *ah, struct rdma_ah_attr *ah_attr);
 int bnxt_re_query_ah(struct ib_ah *ah, struct rdma_ah_attr *ah_attr);
 int bnxt_re_destroy_ah(struct ib_ah *ah, u32 flags);
 int bnxt_re_create_srq(struct ib_srq *srq,
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 83c0748e092d..b44944fb9b24 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -696,7 +696,6 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.get_port_immutable = bnxt_re_get_port_immutable,
 	.map_mr_sg = bnxt_re_map_mr_sg,
 	.mmap = bnxt_re_mmap,
-	.modify_ah = bnxt_re_modify_ah,
 	.modify_qp = bnxt_re_modify_qp,
 	.modify_srq = bnxt_re_modify_srq,
 	.poll_cq = bnxt_re_poll_cq,
-- 
2.31.1

