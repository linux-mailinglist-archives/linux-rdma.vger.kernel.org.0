Return-Path: <linux-rdma+bounces-4738-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B7896B85E
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 12:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19CC281F0E
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 10:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06461CF2B5;
	Wed,  4 Sep 2024 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b4m8vsTi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA211372
	for <linux-rdma@vger.kernel.org>; Wed,  4 Sep 2024 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445507; cv=none; b=n8LDYOw8XZxJjJD7gp0CuOK8x2l+lVAgU1uQMHj1nMNI5mlyYG+wCdvdAkbb0n/7WxyLTbVTVNu17Fgg2WyQGmgVph0RlzeSyIEUQ8+aAB0JjPfX2o2va6GDiPdd91tCsCFTx77OQGSULF1Vjf8nYL8P/brPTprebeddBBS1dec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445507; c=relaxed/simple;
	bh=yx2ID0MsFz6LxPOjcHy661eRROKdaqL52MrMdSPWCpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=p0afzhz/ZUld42FS2pu0BC779WM1soqIi5sUNdLgnfIm/RL7vYxiJTFOTkYQz1PGUBaZ67Cb92Qr69xOoYHnjwTdk4X7oyKLjBGkMv8iG/y7KTaRznN2qBFLpLKe86+km//dnJW3uMRcunQyRS3oHYeBIgOg4juIPxTGzJIsQSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b4m8vsTi; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7d4ed6158bcso1507721a12.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 Sep 2024 03:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725445505; x=1726050305; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=92A+Jkx3LHHtle6MIsTeeZuUjqOvoPnKOWP6KxkEaCc=;
        b=b4m8vsTiGO5kDry8Yxy0UYo7yA06U/126NyVT5uvpuFq9cysPaglOj2RgKsCVj6D8N
         y5SRecrZ1MGHKji7KILafC4wO2wIKISRlWUyg8FzXDp7oHNBn05U0FIGk9W0CvcfjwSr
         Sc8BW0SjecWT1m7kLddwOJ02QAyXkLAPIjjPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725445505; x=1726050305;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=92A+Jkx3LHHtle6MIsTeeZuUjqOvoPnKOWP6KxkEaCc=;
        b=iDPPlTEe9Uble2lSNrz5chuiPKgpgzd10L+RXcuC+BO3UsKHDLz412MW9ezP9I9DOi
         OdvVjr8tWtWRyOvlTOmAn3XHP7ynHo0sXAm57WaXFuQcnasKhSrPPey72k5nXGwKhCh1
         rpKZqP42FwTB7/gPSI798ljKkQmSabzXzsJdH2JE0LeBQj0nKbqLPSRcu6Ual2L0zj3N
         GHr42Wr+ipf6wB7SrquHkpIaEfvCbFcWM+7i5DjL9STkMvcqy6hjAcK6uzTqK5kTVzIi
         sRuXdB7tdaaJaKv86lATtO/Tnicc8yCeQ+HnlJILIwsZ2IV48gcU6ru7SkIyzztzN3jr
         vyng==
X-Gm-Message-State: AOJu0YyqBtFhkO1y5WaIGebtIl9lYlwTrx0a+QlTulwopZZo0lwdUjpT
	ZRQMn3TIVQGuQG2EOrWkWqHFmGN3Ou1JxVE0ivBlpzVYZWWDUUwhDNXgr7QStcNn35HE3PSVffV
	EBA==
X-Google-Smtp-Source: AGHT+IEnnH0XH50kdnfOqAQW+v1K57tEHlQdMkyxKSL44tfx8pbWMpFvPxAoLkoGaxnKBxeX+l7Osw==
X-Received: by 2002:a05:6a20:e687:b0:1cc:dd02:f8f3 with SMTP id adf61e73a8af0-1cece520b7amr15088495637.28.1725445505136;
        Wed, 04 Sep 2024 03:25:05 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea383aasm10940265ad.136.2024.09.04.03.25.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2024 03:25:04 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 1/2] RDMA/bnxt_re: Fix the compatibility flag for variable size WQE
Date: Wed,  4 Sep 2024 03:04:12 -0700
Message-Id: <1725444253-13221-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1725444253-13221-1-git-send-email-selvin.xavier@broadcom.com>
References: <1725444253-13221-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

For older adapters that doesn't support variable size WQE,
driver is wrongly reporting that variable WQE is supported,
when the latest library is used.

Report the variable WQE capability only if the driver supports
it.

Fixes: 10a104c0debb ("RDMA/bnxt_re: Enable variable size WQEs for user space applications")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 82c1f3b..ecee691 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -4272,7 +4272,8 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 		if (ureq.comp_mask & BNXT_RE_COMP_MASK_REQ_UCNTX_VAR_WQE_SUPPORT) {
 			resp.comp_mask |= BNXT_RE_UCNTX_CMASK_HAVE_MODE;
 			resp.mode = rdev->chip_ctx->modes.wqe_mode;
-			uctx->cmask |= BNXT_RE_UCNTX_CAP_VAR_WQE_ENABLED;
+			if (resp.mode == BNXT_QPLIB_WQE_MODE_VARIABLE)
+				uctx->cmask |= BNXT_RE_UCNTX_CAP_VAR_WQE_ENABLED;
 		}
 	}
 
-- 
2.5.5


