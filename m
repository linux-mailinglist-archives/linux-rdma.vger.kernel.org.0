Return-Path: <linux-rdma+bounces-4412-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D8B956308
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 07:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F3A0B21E8E
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 05:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37363149DF7;
	Mon, 19 Aug 2024 05:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Uy7Evz5K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828C714A0B9
	for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2024 05:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724044140; cv=none; b=WUtp7Ohxk9Dy7HLP8x10AV9bntZAe4MX4E7o3pmunFrfP/1u8YC4vtp5KqgpMoCChk8CNb+D1p/4CuqoPv+P0R+8I7MB0ft5JjI9yXzOnGkHX2sw+pUmGCWEDrQPmMsypuCE9yyH45BKKXPn1opY64zca/hywPnRcKBmMHuL0IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724044140; c=relaxed/simple;
	bh=TahX3B1Iuw1jEr2+u0UIDJab1OxyO54LI0+bMBFXKUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JvWl+3hmTaIP2WAMgHiFLvb/O546qNSsOvTYzJBuPiJiexnV4rSWST3QffQfbIEJ4RstscLJBRaUAR2CCNyZ8mkS+TCF6JJNG4UFlzWp/18975+Re/KZEiQWRmVBRiOI0RnLLIWkpFOWqBbz6fNC73hLJlqoCdy90ZXKfMC2FBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Uy7Evz5K; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-709346604a7so1882237a34.1
        for <linux-rdma@vger.kernel.org>; Sun, 18 Aug 2024 22:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724044137; x=1724648937; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+leSXdUbIYKI7LvY2C7MNiQQxTay47JkFU/iIQbOOFI=;
        b=Uy7Evz5KJ6PSXaFFZL4fEeyicnDdqtmYor9+GIP8hV3WY8QbET51DEs++0nKxlrt5r
         P/6OqpAU7NQtD8D8Lf+Nw6xZ/qwh1YtDlAylUtiq4rXf0V9YZXxRCd4yovBEuVbHMhtX
         B9pPhauqwFnLrG4XWsTyM6U8PimlJJtlnEPwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724044137; x=1724648937;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+leSXdUbIYKI7LvY2C7MNiQQxTay47JkFU/iIQbOOFI=;
        b=npDLCLWEF6jc7YaZbLm9FaYrjh1y+5veLkKti74q4KvgqG6kmxc1VydhKY8311+EwM
         i34HtJbbG16spmyhbrym0bEYBa6P85N3XXhs5jYNNmcDt8HRDxmHcSaCFelk8ulAMInE
         kWHQYSkxROdqSeS8IgqaiSm5Dm9zPDyGdXvHOT3HcsSyyiwTWvTw/8anO2Ha+m4QYitO
         vbJ9OE3iHqUS7yZD/zt2t/R5V38zzsfCvduT7JRl6jAuEDQlQ9mt5WQOnFjtuEw7SyS9
         ttp2eLv+UfidZtDINUNITy5HGDByWbfn7z6c6F3r3JmYbU3nsU44vux86Gg8PlQKYC4r
         IlWQ==
X-Gm-Message-State: AOJu0YyXwTO/IdSMAjnN1eBzYnkutEbMyY5dPNebXmTMeZfwY2AuyWcP
	ECQX5Ly82m86KXb4frTn0jUazzZ2GeR6hD/qOXg788dg+Y4kkqUVIh1feHyQPg==
X-Google-Smtp-Source: AGHT+IFZG/Vxpi/Bxi0mll2sYNYAFKuYkASE99SXga3KHUUeMjmMePxK0TmDf9NHsrABjlYqilwNkg==
X-Received: by 2002:a05:6830:d8b:b0:708:72d7:223f with SMTP id 46e09a7af769-70cac8c1cb3mr14486198a34.22.1724044137595;
        Sun, 18 Aug 2024 22:08:57 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([42.104.124.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61a7672sm6908021a12.4.2024.08.18.22.08.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2024 22:08:57 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH for-next v3 5/5] RDMA/bnxt_re: Enable variable size WQEs for user space applications
Date: Sun, 18 Aug 2024 21:47:27 -0700
Message-Id: <1724042847-1481-6-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1724042847-1481-1-git-send-email-selvin.xavier@broadcom.com>
References: <1724042847-1481-1-git-send-email-selvin.xavier@broadcom.com>
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


