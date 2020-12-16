Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D022DC985
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 00:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbgLPXQk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Dec 2020 18:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgLPXQk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Dec 2020 18:16:40 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D024CC0617A7
        for <linux-rdma@vger.kernel.org>; Wed, 16 Dec 2020 15:15:59 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id s75so29870760oih.1
        for <linux-rdma@vger.kernel.org>; Wed, 16 Dec 2020 15:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aq4UndTq5JISLlGGeXFVBwfYx3fYkDJyOVTup1G9Obo=;
        b=DLtFcscaVEONPIDdQStpfBFUFzW0Uh0p79glHdTDoffzlhH6XzK1a1/tTFSntH+d38
         wBj1W87gpQcbaqI/ol3dF7gSqI1xFiBQKGCVzxeccCSAEHbvOlfBteFNadVGelG7OLYi
         nDgHiwzX7hX4Avy97TbkmuOE7IqiarPseAEc6x98lipEtsUjC/qKoAPgsU0eJ98z51xc
         DfUvKpLsXDKidduAL/xpuLFp4ET6I95hxtU1HvASajEDC7P0WAqI/sQL3wtb+De4AJ3v
         NncY2Vyxnffc+ufmJ70K0/fMz0mj4ZkZaaaPjXAGNbFUjhR8SQD4fJhF5zqPPkBk0HML
         gvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aq4UndTq5JISLlGGeXFVBwfYx3fYkDJyOVTup1G9Obo=;
        b=Wu0MoDCbd0mD9+fbMQNcIhRocH3pRpDjxEzhJlR4AAgHF+Acsko/WIvyORJmQ2JY22
         6C7lBD/ObPSMy6wr8bhsQiIgDueW/kU/uA/y/hyo0JXrq1PBVsquP6HNEjJUJioXA/QM
         5hpCm7d59nRO41hWvcBfUFSDA/3TdaRg1tkkdG0ImlyT9CfLE88pGt3oFQWVvp1+W8ar
         LAuWBnZBGwIrUuTaFE0pXWbCnddMfCuHqUkwb63PS14oSmhTa1SG2BpeZiPkQq8WTWdH
         B9cnE2adHEAaLj1qfoiDRbPvmL/+CWKodZP9QD/wy9jKCo0phJnkQp/ob6dersxgcES/
         Sdpw==
X-Gm-Message-State: AOAM532SvOA5otZDbP90CSaQF9FHH//RMjAcT8gKDb5s2EOQDbCm76bK
        OvHNO05ZDcfRQUMKqiwXOT8=
X-Google-Smtp-Source: ABdhPJzod8sCZjXYvhqu8mcVMTbP9qHyP7I3ZHnYHcpTuQmOf0Hb0qewUvDB8KqhSJnU2Bn96beFxA==
X-Received: by 2002:aca:568f:: with SMTP id k137mr3287246oib.138.1608160559321;
        Wed, 16 Dec 2020 15:15:59 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-6a03-8d89-0aec-a801.res6.spectrum.com. [2603:8081:140c:1a00:6a03:8d89:aec:a801])
        by smtp.gmail.com with ESMTPSA id f18sm793437otf.55.2020.12.16.15.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 15:15:59 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next 3/7] RDMA/rxe: Add elem_offset field to rxe_type_info
Date:   Wed, 16 Dec 2020 17:15:46 -0600
Message-Id: <20201216231550.27224-4-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201216231550.27224-1-rpearson@hpe.com>
References: <20201216231550.27224-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The rxe verbs objects each include an rdma-core object 'ib_xxx'
and a rxe_pool_entry 'pelem' in addition to rxe specific data.
Originally these all had pelem first and ib_xxx second. Currently
about half have ib_xxx first and half have pelem first. Saving
the offset of the pelem field in rxe_type info will enable making
the rxe_pool APIs type safe as the pelem field continues to vary.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 10 ++++++++++
 drivers/infiniband/sw/rxe/rxe_pool.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index f1ecf5983742..4d667b78af9b 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -15,21 +15,25 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_UC] = {
 		.name		= "rxe-uc",
 		.size		= sizeof(struct rxe_ucontext),
+		.elem_offset	= offsetof(struct rxe_ucontext, pelem),
 		.flags          = RXE_POOL_NO_ALLOC,
 	},
 	[RXE_TYPE_PD] = {
 		.name		= "rxe-pd",
 		.size		= sizeof(struct rxe_pd),
+		.elem_offset	= offsetof(struct rxe_pd, pelem),
 		.flags		= RXE_POOL_NO_ALLOC,
 	},
 	[RXE_TYPE_AH] = {
 		.name		= "rxe-ah",
 		.size		= sizeof(struct rxe_ah),
+		.elem_offset	= offsetof(struct rxe_ah, pelem),
 		.flags		= RXE_POOL_NO_ALLOC,
 	},
 	[RXE_TYPE_SRQ] = {
 		.name		= "rxe-srq",
 		.size		= sizeof(struct rxe_srq),
+		.elem_offset	= offsetof(struct rxe_srq, pelem),
 		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
 		.min_index	= RXE_MIN_SRQ_INDEX,
 		.max_index	= RXE_MAX_SRQ_INDEX,
@@ -37,6 +41,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_QP] = {
 		.name		= "rxe-qp",
 		.size		= sizeof(struct rxe_qp),
+		.elem_offset	= offsetof(struct rxe_qp, pelem),
 		.cleanup	= rxe_qp_cleanup,
 		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_QP_INDEX,
@@ -45,12 +50,14 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_CQ] = {
 		.name		= "rxe-cq",
 		.size		= sizeof(struct rxe_cq),
+		.elem_offset	= offsetof(struct rxe_cq, pelem),
 		.flags          = RXE_POOL_NO_ALLOC,
 		.cleanup	= rxe_cq_cleanup,
 	},
 	[RXE_TYPE_MR] = {
 		.name		= "rxe-mr",
 		.size		= sizeof(struct rxe_mem),
+		.elem_offset	= offsetof(struct rxe_mem, pelem),
 		.cleanup	= rxe_mem_cleanup,
 		.flags		= RXE_POOL_INDEX,
 		.max_index	= RXE_MAX_MR_INDEX,
@@ -59,6 +66,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_MW] = {
 		.name		= "rxe-mw",
 		.size		= sizeof(struct rxe_mem),
+		.elem_offset	= offsetof(struct rxe_mem, pelem),
 		.flags		= RXE_POOL_INDEX,
 		.max_index	= RXE_MAX_MW_INDEX,
 		.min_index	= RXE_MIN_MW_INDEX,
@@ -66,6 +74,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_MC_GRP] = {
 		.name		= "rxe-mc_grp",
 		.size		= sizeof(struct rxe_mc_grp),
+		.elem_offset	= offsetof(struct rxe_mc_grp, pelem),
 		.cleanup	= rxe_mc_cleanup,
 		.flags		= RXE_POOL_KEY,
 		.key_offset	= offsetof(struct rxe_mc_grp, mgid),
@@ -74,6 +83,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_MC_ELEM] = {
 		.name		= "rxe-mc_elem",
 		.size		= sizeof(struct rxe_mc_elem),
+		.elem_offset	= offsetof(struct rxe_mc_elem, pelem),
 		.flags		= RXE_POOL_ATOMIC,
 	},
 };
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 3d722aae5f15..b37df6198e8a 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -36,6 +36,7 @@ struct rxe_pool_entry;
 struct rxe_type_info {
 	const char		*name;
 	size_t			size;
+	size_t			elem_offset;
 	void			(*cleanup)(struct rxe_pool_entry *obj);
 	enum rxe_pool_flags	flags;
 	u32			max_index;
-- 
2.27.0

