Return-Path: <linux-rdma+bounces-4301-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EAF94DE4E
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Aug 2024 21:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500371C2128E
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Aug 2024 19:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A5F13C9D5;
	Sat, 10 Aug 2024 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fy2LBz+s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C1113B5B9
	for <linux-rdma@vger.kernel.org>; Sat, 10 Aug 2024 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723318819; cv=none; b=g4iWlpcRzgrduSmCkq8pnzekleCotse2mMfwvp/v+yQQKMBcUtRnNbbT2LlXP5pVbC5llU7j4Y/NQx9nuvLrE1jN9E5KyfKvEXV0WlAKxedqsukAZx7YLvY4laPCpISv42GSczn80LrCQaRUC4Mr89YTJX0M3sHnIlIiEhDeKCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723318819; c=relaxed/simple;
	bh=TahX3B1Iuw1jEr2+u0UIDJab1OxyO54LI0+bMBFXKUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Mh0cNuUbNDWRSknkH5meK5cQr+h05b5A7E1qSz8o05GbXvHuCBGzgasPo2Z5U2Apg0CQ9TDliBZ0G9jBM93ZPBZr4WgXcB4IRlQ/kzKcfC+rdhTmzDN/StfL+BEX2ScGWY/+b6u3w7UJ2TPuvG/hRAcDBm9Eam7VNtOrIWyuON0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fy2LBz+s; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-264a12e05b9so2033872fac.1
        for <linux-rdma@vger.kernel.org>; Sat, 10 Aug 2024 12:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723318817; x=1723923617; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+leSXdUbIYKI7LvY2C7MNiQQxTay47JkFU/iIQbOOFI=;
        b=fy2LBz+s0PN9vYeFxFI2zd7WtnKXF8K0KqZnEVfH3UAL9gbCC+4WDdZLDGWBavmEkU
         8H1PJjobkuzvoeo5ZvQ5zwWBtY07Bv9V76Km1TKenrku9GuCH2rli1kc40OJaiBfV7lH
         /h1PJGllEW4+4WF+UxREx8cbTO9RKY8QymUXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723318817; x=1723923617;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+leSXdUbIYKI7LvY2C7MNiQQxTay47JkFU/iIQbOOFI=;
        b=kcR0MERVkOOmpoMnP9lcFkchLmVgJ6lZyQj8eRWOi2ZIQJ/yZg6CdVpQ+NIb/R1HHe
         6hC3wAeRXA5rdyOEIjqa00KzigoT7+XPArOaJAQ/Glsj134vPHtrHwBo4o1cOM1iNmZ0
         LDm1Sr6zMGkVIjLCdTerRzNnFgpRU01ZDz+bEXLRoDX5ohDXRYbYB/V8ohZeVAtKrve+
         L/X4xLaHUppPzWHBxqNlwDghQSOirJXnpMI9n2VEEVeXFwMwzrIufFgjD+lpj/+CYx+u
         hRIJyrBWl16MXXVA0CMTcUmm1N1Ny2jciNSiEysDDy2iixHsagx98DvKZBgLj0x9G5ai
         Kf2A==
X-Gm-Message-State: AOJu0YzYTMotgXeX3gfOKx4M1eXrkFG1Y3pbhRzMNikCwJmWgBxT4Mhi
	TVrriMqiQtiUY3jARR0LMqvsVlvV8N1+yMT0zN1AcU1Ot4/gmN09TjHvkt77cg==
X-Google-Smtp-Source: AGHT+IE2xWOx8Mm0nuo5KmoTkY5k/hp3vR+B9dpKvTO7aWb+BaZE9co31/4twlsFnOcS3t/DLF6aiQ==
X-Received: by 2002:a05:6870:7b4a:b0:260:f7e7:65e with SMTP id 586e51a60fabf-26c62f871b7mr6869289fac.45.1723318817135;
        Sat, 10 Aug 2024 12:40:17 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([42.104.124.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a437b7sm1541513b3a.128.2024.08.10.12.40.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Aug 2024 12:40:16 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH for-next 4/4] RDMA/bnxt_re: Enable variable size WQEs for user space applications
Date: Sat, 10 Aug 2024 12:19:13 -0700
Message-Id: <1723317553-13002-5-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1723317553-13002-1-git-send-email-selvin.xavier@broadcom.com>
References: <1723317553-13002-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Add backward compatibility code to enable variable size WQEs
only if the user lib supports it.

Signed-off-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 5 +++++
 include/uapi/rdma/bnxt_re-abi.h          | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 2932db1..82444fd 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -4233,6 +4233,11 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 			resp.comp_mask |= BNXT_RE_UCNTX_CMASK_POW2_DISABLED;
 			uctx->cmask |= BNXT_RE_UCNTX_CAP_POW2_DISABLED;
 		}
+		if (ureq.comp_mask & BNXT_RE_COMP_MASK_REQ_UCNTX_VAR_WQE_SUPPORT) {
+			resp.comp_mask |= BNXT_RE_UCNTX_CMASK_HAVE_MODE;
+			resp.mode = rdev->chip_ctx->modes.wqe_mode;
+			uctx->cmask |= BNXT_RE_UCNTX_CAP_VAR_WQE_ENABLED;
+		}
 	}
 
 	rc = ib_copy_to_udata(udata, &resp, min(udata->outlen, sizeof(resp)));
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index 7114061..6821002 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -66,6 +66,7 @@ enum bnxt_re_wqe_mode {
 
 enum {
 	BNXT_RE_COMP_MASK_REQ_UCNTX_POW2_SUPPORT = 0x01,
+	BNXT_RE_COMP_MASK_REQ_UCNTX_VAR_WQE_SUPPORT = 0x02,
 };
 
 struct bnxt_re_uctx_req {
-- 
2.5.5


