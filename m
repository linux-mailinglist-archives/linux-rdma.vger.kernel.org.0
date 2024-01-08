Return-Path: <linux-rdma+bounces-552-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A75F826A26
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 10:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B534B2199D
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 09:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F7CD310;
	Mon,  8 Jan 2024 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZjZM6Wi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AB71170F
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jan 2024 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d89446895so8806585e9.0
        for <linux-rdma@vger.kernel.org>; Mon, 08 Jan 2024 01:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704704775; x=1705309575; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=msJDdr+tw/pwMzu/gEPxG7IevnqWt9byzrz1bK4tMkQ=;
        b=qZjZM6WiFgwhJ5sFfYej1GtfyzxjC2nlWkz3XDa+EWZULfu1UVh8xZbvuQLHd00Gup
         9neKZ5MzLDifuN0uP8qNdKn+lxO+qIHxPrX11+EopmYt9MZ4V4RWHWleO160Y+zMwuRt
         YFpqIg02jE9/mWu5SQIfAqiHZ3AWHCF3TM6FaV5NZ40k3lhTeOIxPHBVqAZv+iXE7svn
         d4mP+v5N5cLpQnBKNMg38jB8NopkCeL8qEHLm1BUTtBfpkLgC9/LLaTjZ2x2fmw1txS7
         jF1t+ZWPEppyUseE7HQVzig/capMwWWtO9vA5IVo2aWA8Hu+JOfBpokC8AX5mnWAuWTh
         LW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704704775; x=1705309575;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=msJDdr+tw/pwMzu/gEPxG7IevnqWt9byzrz1bK4tMkQ=;
        b=Gqmk/HJ0LT0CzRqTUsjDZcRRoHcM7fs7Hq2hYD9+2IpLmr3WU0FHeoeBTEbJ4yO/tK
         UqC4CYv3BBf7EFAQmb0jYKf6plcGeVIaNelNiwtXrouQOKIrz4uz/X/MhoiO5XvjOQZV
         63tI8ocDFMLVnLY+MnWg7Pzm7XEZ5+stQiiek9n9cABnuKHVozfrKeVKoLuJ5aZgGitT
         UIerYwUsn8JPGCX+CuyfwWS+miHhSwVwI3/zYBYGbjQogjalXNCvjTb6GBhXNOCiVi+b
         ytWBJq1NRt64pJfVhd1TqdHWqryjJFSgxTrIQfwkkrSPQ8rR4HiiYXwSbdc7RwkdOxjw
         jcZA==
X-Gm-Message-State: AOJu0YzVvqYKrCf27F0mBp25D+2RPsEOiGqzAeuBo6jZlN+YNDgFR+GZ
	wpFauvzlqSnORbwIWg5HzGBPLKxGtuABXw==
X-Google-Smtp-Source: AGHT+IE4Gbx6ph0/udW5CwFHOz7npE3W3GoZs8gPaNe+Vqot6Fs0vGGigyOm3bV7K/AaOKEOMFrMXA==
X-Received: by 2002:a05:600c:4683:b0:40e:4380:c8e5 with SMTP id p3-20020a05600c468300b0040e4380c8e5mr926343wmo.49.1704704775216;
        Mon, 08 Jan 2024 01:06:15 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id z6-20020a05600c0a0600b0040e3ac9f4c8sm9222609wmp.28.2024.01.08.01.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:06:15 -0800 (PST)
Date: Mon, 8 Jan 2024 12:06:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/bnxt_re: Fix error code in bnxt_re_create_cq()
Message-ID: <d714306e-b7d7-4e89-b973-a9ff0f260c78@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return -ENOMEM if get_zeroed_page() fails.  Don't return success.

Fixes: e275919d9669 ("RDMA/bnxt_re: Share a page to expose per CQ info with userspace")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 7213dc7574d0..824349659d69 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2944,9 +2944,9 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
 	struct bnxt_qplib_chip_ctx *cctx;
 	struct bnxt_qplib_nq *nq = NULL;
-	int rc = -ENOMEM, entries;
 	unsigned int nq_alloc_cnt;
 	int cqe = attr->cqe;
+	int rc, entries;
 	u32 active_cqs;
 
 	if (attr->flags)
@@ -3027,8 +3027,10 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 			hash_add(rdev->cq_hash, &cq->hash_entry, cq->qplib_cq.id);
 			/* Allocate a page */
 			cq->uctx_cq_page = (void *)get_zeroed_page(GFP_KERNEL);
-			if (!cq->uctx_cq_page)
+			if (!cq->uctx_cq_page) {
+				rc = -ENOMEM;
 				goto c2fail;
+			}
 			resp.comp_mask |= BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT;
 		}
 		resp.cqid = cq->qplib_cq.id;
-- 
2.42.0


