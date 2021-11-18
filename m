Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A316445643C
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Nov 2021 21:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhKRUel (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Nov 2021 15:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhKRUel (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Nov 2021 15:34:41 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2B5C06173E
        for <linux-rdma@vger.kernel.org>; Thu, 18 Nov 2021 12:31:40 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so9217843pjb.2
        for <linux-rdma@vger.kernel.org>; Thu, 18 Nov 2021 12:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AvCNgTG4dIQ/J8VhnY2kfW7Ruay+7fLS/XLv7Mhn16Y=;
        b=FyEc/BqXXHNsTUt8eQU19q05pRbel6tXzsFVgeZVKmGdK8b/ZSFyLMLnOLB+uXGmme
         Qur93Oz+IbNqDSpSFMyfeOu/tOtQzDeTaOkNoPEG+wN609xW6GAXI0tv7Lg/I9RiPZRm
         47YCxStcGRdQ2MwkWLGj3N4ag75DV6GcgpNak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AvCNgTG4dIQ/J8VhnY2kfW7Ruay+7fLS/XLv7Mhn16Y=;
        b=efJZWTxTQZu/WQP16fla5RaZu6trRHB42ry7VfiMAntasJf9HpbomrNalcMGt0CUJs
         NmYOnghXnNm5N1ifSQbN1viQ9rlAG6qauCe/edVMpg3y4LPlljsAT5zPpWIrhklhc5UE
         8NZzvOWFaPzrLqvPQKtztvOW2gorjiMDGj7XLeGBjaypsR22O24nhtPMdSCzKhYQXQMt
         UvGYgCo7FLdgRpoELspwHbMdX+rIGWZNZcGD3di1TpZFvE/pVzrIErrGFG/ZUXcBZHZY
         AR5zhfXpawabKfdpqkuSaz9keHlhh9JVHTAFQYfALgtNqcYhe/dQYC+rbCNdZ+lllN2i
         o51A==
X-Gm-Message-State: AOAM533OcqDEZbr/lTiMT1Q4JmDJ6Lkm9zayrVbqMNHsefSnw8bNNq9T
        e8cy3Q1Y27tfMr4gQrhin5IMsA==
X-Google-Smtp-Source: ABdhPJyS2w5E4zPG9RW3gffZYcu/BykzlDd1J9/f22V7NA3IveU9sLmHKRRxZfBZDhmolkKgku0/aA==
X-Received: by 2002:a17:902:bd88:b0:143:d318:76e6 with SMTP id q8-20020a170902bd8800b00143d31876e6mr27177037pls.66.1637267500490;
        Thu, 18 Nov 2021 12:31:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z19sm448672pfe.181.2021.11.18.12.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 12:31:40 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] RDMA/mlx5: Use memset_after() to zero struct mlx5_ib_mr
Date:   Thu, 18 Nov 2021 12:31:38 -0800
Message-Id: <20211118203138.1287134-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1294; h=from:subject; bh=LHGb8vL1VmjEfw7v5ZUO1VSWr6rAqrzXkHeL3awDSQA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhlrgqPxGkXyCK4FHv29cZrosNyOt0A5S6RiL+pN0U wZbzRcCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYZa4KgAKCRCJcvTf3G3AJuG7D/ 0XlNWRNkqRV+SuUtjfY8jyATz0zHm4oVO81e7OhePHCT+v7TXt8NCzaU7vv1uXtL5JcwWqNEDxN6pT I8jx1B0qGXjaINpQtH/JMgHg2Vq7aKgmIPmM/GMRDvUO6h+w9PqpbsdXofGqAdmD2Xu33vvk1qTbHa G0hLvcsz3AZOaPqjm05UkL+ndFVdgZuOgpUg5J030jtsHgBhefSb0+vI5wgpfQVtckGNAiU7B0xwqb UGBM3QqNuQVoFZeCx9MjBHiXFbEbr8L9FkAiwT6yqDaHNTzEv8H7GTuy4zJyeHHLcmdo/jiG5FDEn/ 5QdIwJQSRyR8sgiUGP5Y9Rr1WWp1RFpjY5bSwEuvLrfTZ5N8HEwmxb/7iLrm84wgE2ioiPYsp4yJSD qSllulzfueYk221EF2ZVk81JG1DL8j+wPana0/in4n9rZdOQltWvC01aGZed8rD5LZKbjz3S88u2hE dTX32NBIvg68G+s36JkZJB1uob+GZi4xkmwCGmtOMMP8jt7Nx54Hadck5i4RRPx6eoexKp3RG6xuIX hpbJcCdKX+adjV79l49WQT+mx/O04XODjzxPSCgjxa0A0IKgxJQg7ZM9T6wZEUODWMcWeAT2PoWSPt 47iqCxY4bPBr9Tv/160fuOR3baOn86RUHccKCx2aMlKQTLL/V6+XNDx4mwXA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Use memset_after() to zero the end of struct mlx5_ib_mr that should
be initialized.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index e636e954f6bf..af94c9fe8753 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -665,8 +665,7 @@ struct mlx5_ib_mr {
 	/* User MR data */
 	struct mlx5_cache_ent *cache_ent;
 	struct ib_umem *umem;
-
-	/* This is zero'd when the MR is allocated */
+	/* Everything after umem is zero'd when the MR is allocated */
 	union {
 		/* Used only while the MR is in the cache */
 		struct {
@@ -718,7 +717,7 @@ struct mlx5_ib_mr {
 /* Zero the fields in the mr that are variant depending on usage */
 static inline void mlx5_clear_mr(struct mlx5_ib_mr *mr)
 {
-	memset(mr->out, 0, sizeof(*mr) - offsetof(struct mlx5_ib_mr, out));
+	memset_after(mr, 0, umem);
 }
 
 static inline bool is_odp_mr(struct mlx5_ib_mr *mr)
-- 
2.30.2

