Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5968246C69D
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 22:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241588AbhLGVYF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 16:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhLGVYF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Dec 2021 16:24:05 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB975C061748
        for <linux-rdma@vger.kernel.org>; Tue,  7 Dec 2021 13:20:34 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id g18so587104pfk.5
        for <linux-rdma@vger.kernel.org>; Tue, 07 Dec 2021 13:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9z9mcEOqCc5xD2F5/F5rihEXJE01JxUzDidSsCCdREk=;
        b=CpBR6wmm1q6jWDwcnPxLQ3eMVgLCMnWFpH/o4g4TOXf9nFP9SWnEqaaxXlDeGX+EZ8
         Ti6YfyZ6T2EOBk32ZsoAaoWeXmb0qSroICK6P41ALMW45UTnGimHGqnXY9zqa2gZPNgX
         0/zHHWtMekKdeEZ2FrmB6cpEcmVbmQI/K1fic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9z9mcEOqCc5xD2F5/F5rihEXJE01JxUzDidSsCCdREk=;
        b=pjRmmAZXXfwDMgBrXTVe2W3fi6Qan++MRjtVqb+zP4TN/HsepyW3ItorpKSSnmUjTm
         B0cYhxK+5HIdvBs7v8nZmFJhZBnkk+kE+DbZwU7TOdsm8rLhNHntdtAdMmH31Z4M/Uan
         rLg2mtDzAOmys3grDfH+zxHTAb0akE/rBiwqGqkwZD/sCcbFY8+J1lBc9v/9EWB1+MI9
         V1+6I/DpvtAVcAtSfqNpGfvktDscz4IeRx1G5oSJlQTjsx6xyVTLrBfr+3bcRthZf3Ut
         pUpjJiat7JTn/975liGf7YS986AHttdtuKM3omR0DgwBS2YODGsG86pOHuoJ5kZaP+G7
         DixA==
X-Gm-Message-State: AOAM532IPqPYbE/g2QeJomJ2FAKC7MdhjPajXjqiKlGhW44u1RUzGyq5
        nM2rtyStUIT3EN2F56tY4LNsFQ==
X-Google-Smtp-Source: ABdhPJyvXRCXfhQQlLw8UElZzV252uBcZyBir6qj6QPih1VfaMbvXTVORYMT+legzIvu9nrnxuCRPA==
X-Received: by 2002:a63:e16:: with SMTP id d22mr26642297pgl.291.1638912034224;
        Tue, 07 Dec 2021 13:20:34 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p15sm705084pfo.143.2021.12.07.13.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 13:20:33 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] RDMA/mlx5: Use memset_after() to zero struct mlx5_ib_mr
Date:   Tue,  7 Dec 2021 13:20:22 -0800
Message-Id: <20211207212022.364703-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1414; h=from:subject; bh=162T4AOcO3pT2xkQ5YSgkPbdfq/MnpvbH7x7jZVSmyI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhr9AVt4fvyuoCUfWH5T4YqQjLaDiCbZE9rfkKTIwE k5jq8UWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYa/QFQAKCRCJcvTf3G3AJtidEA CbLWyJKGTDTi5CTjVhgCptMfETdGlaUHcet5W6ruTsexrxTi8bcw1tOszLU6g9YOaXfJC+lzn+aXac iLA0o5hcR8Bh3Z/k5ezZsUtbY7HBdYc9Sfs0YQMdEcd3YoVsO8djnCJvC20QoztfeZswwjj8eWVQuf z5V7q3hKkjIdH697FYNb7UVd4d6UcOuPsWmi0KjrUBa+rin+z+9LkhrkaTNfzCAV6HNmTCR8fvqP/Y DMirXCEU/MByHo78qZFYXP/zUnKYPiEtPtyKs4rMxYoC/H6wCHnfo27DjIwvtZnbZZi8J+78mIlDV+ XLddXmXKKc/ELcSqEMzQpjbBcr6pqSo8wJQE1k8lAubxr8Yy2p8V/4AekPGsW+0OZbiy3hBH4i3sdz KMyXGYiL5tMQ1dSScN3U98IeICngVOUdrGkmZmP5CssOGB04cFF/PKKrU9qOUXWY+BrK1CRwwzeJWM I5JQYPyTv9RkreRNppv4xfU1aGy17jDhP55bJ+VFQ84ptzKeKhrcExH5MGxoCXpPCDfoWAgwQeh5Uo qOT22dFDX73NRe1ai/oXoLtrtzJFknz+GjB7ZS06wl+YKghyxrE0PgCHpxAKuP1qTae9kXTri1eeqW ALV9Q2tXkUiJE5HKSF7L952YixS4ynmd6IsURnzlIyoAz2iPSuI6s9aNMxGA==
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
v2: rebased, umem moved into the union and is expected to be wiped
    https://lore.kernel.org/lkml/20211207194525.GL6385@nvidia.com
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 4a7a56ed740b..ded10719b643 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -664,8 +664,8 @@ struct mlx5_ib_mr {
 
 	/* User MR data */
 	struct mlx5_cache_ent *cache_ent;
+	/* Everything after cache_ent is zero'd when MR allocated */
 
-	/* This is zero'd when the MR is allocated */
 	union {
 		/* Used only while the MR is in the cache */
 		struct {
@@ -718,7 +718,7 @@ struct mlx5_ib_mr {
 /* Zero the fields in the mr that are variant depending on usage */
 static inline void mlx5_clear_mr(struct mlx5_ib_mr *mr)
 {
-	memset(mr->out, 0, sizeof(*mr) - offsetof(struct mlx5_ib_mr, out));
+	memset_after(mr, 0, cache_ent);
 }
 
 static inline bool is_odp_mr(struct mlx5_ib_mr *mr)
-- 
2.30.2

