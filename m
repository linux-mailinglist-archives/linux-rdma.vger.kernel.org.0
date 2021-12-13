Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48C2473785
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Dec 2021 23:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243656AbhLMWdr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Dec 2021 17:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243612AbhLMWdk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Dec 2021 17:33:40 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B00C061371
        for <linux-rdma@vger.kernel.org>; Mon, 13 Dec 2021 14:33:39 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id k6-20020a17090a7f0600b001ad9d73b20bso14525979pjl.3
        for <linux-rdma@vger.kernel.org>; Mon, 13 Dec 2021 14:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2QF7GtMPgeovGkn/Um2s+IAYrZXWu92GGIBGeTuNd0g=;
        b=D+azZllfG6Hnp0tbGVmfDafUxIigk3rYUYjjqPQ2VSzfBBPhVdIQmsR7RDW6bHnoeu
         oGkp8ZAXw9HssYxoaBs8VV/+9XVjNOqWzr8j3tRu8Eja6Jp1MR7ynC5HlHGrQUJG795M
         1wsIddaY0RcyVwTTH1e8V0WT9SwTdhkcaldoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2QF7GtMPgeovGkn/Um2s+IAYrZXWu92GGIBGeTuNd0g=;
        b=06XmoQmmboNDgEFMZgNItKz52/4Im/+Xplg7BvOV5teAuH5TK/AKB3gSf0ZaRoy8ir
         uxZjPbp1wumI/gtLa1gfpg895H/HISAEZxAILNvkqjpd4WaCV8EEuXaqYEJ7dEuWIDlS
         sTUUruCCceOmf54du2nkKB3qYAUTn/YScgI9oRycTn9QMSvCnS9iCU9kZsrQgBE7HdGb
         Klc01zV4zX2xW6RIJYhFYH1tN7CYcmWGpNcQw6psyGasCWKaspcEl1+qurn3n5BwOiH8
         6QCruB+el2V9T8EApIlRYur8QTwrmEBXDb6IbkSL7ylMUjUjFyV9EnfQd5diZgu+eQ3l
         Fpgg==
X-Gm-Message-State: AOAM531hGqC7Zwg/iX0wm9YZ5jXjbJN4d52bKcv2ChOCdj7kSARttOUq
        rHp/QsyNfDibMKKAcObIzwQzQw==
X-Google-Smtp-Source: ABdhPJw/heRlxL9p9MafpKPpU+aOX/8aQldq2ikYRg4gpnEqC+p3RlEcTY7uzjlt0iiAzHzPVVVY4A==
X-Received: by 2002:a17:90b:34b:: with SMTP id fh11mr1299850pjb.14.1639434819283;
        Mon, 13 Dec 2021 14:33:39 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m3sm10922153pgj.25.2021.12.13.14.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:33:37 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/17] RDMA/mlx5: Use memset_after() to zero struct mlx5_ib_mr
Date:   Mon, 13 Dec 2021 14:33:23 -0800
Message-Id: <20211213223331.135412-10-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211213223331.135412-1-keescook@chromium.org>
References: <20211213223331.135412-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1489; h=from:subject; bh=ci7qDUSQ7qxfbgt9mwXtWi+IdiOxq4CPa5QMzuuRbIM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBht8o4c9gG5dEjAyZVb2YGUUu1WKghUR8yjX2IwA14 lNycyx+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYbfKOAAKCRCJcvTf3G3AJmCgD/ 94y/49uzwy2o4ceIgt9+LabsLgQ83nyWbVWzKF7S+FkPF2fdPgUnZo1u9AUKHX0NfCIEEUhu2QpFLt lD6tuJUJhfURZriu7JD241xMcFM+tk8XapHBoUEgDV5I6DuxCKANkWFsIcLgOkDbaUPkoG4D43qzBg CYWMgZmg/6c7JaDkP3M6vnTFxmh+X3HECy+9ucC46uKNwVm1jaz9L51AqtpYpXdM8s6ckqRLskpydz vh8Zvvu9c909q1aMS6twz0Y4QovPGZkcqBI9C4C289/ekn4BTrEOX84wXntPOMmVrdYSiuWY8D6DYP hrolXMIdtsk9pGuSWT5Hm6oKImFOUWVoxxtsciKQXkaCGe8H32gHQlH7FWBAQQ3f1cs4C7zgTi5lqb 74R6nJXU/yxFmXvHKIYhoid8VaogMVj+DKMOZtscumAjD3jY9XweYiCBvdu87kwtetw2Pk5qBBGQtf umEkP+SIFK3hQsPRUQUVjL5dH3JT3gFxmQMab9Iql8GfYGNAAQUPTnBbR7jIpOiFuewqgotfBhAQdq j0XwcevUQx/JF3i4DsLsVWTPD07eYKmRzsHZmRoFMkGrnMgVEHL04p3So0NNoHEXupSRfSfsgzca/8 npTJ0Rg2JkPh/NgMyrhGq+IYI7SL6gJr8j0vQxoX442T1P8h8uEzDWglsLUA==
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

Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Acked-by: Leon Romanovsky <leonro@nvidia.com>
Link: https://lore.kernel.org/lkml/YbByJSkBgLRp5S8V@unreal
Signed-off-by: Kees Cook <keescook@chromium.org>
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

