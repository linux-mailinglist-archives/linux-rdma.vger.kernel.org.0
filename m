Return-Path: <linux-rdma+bounces-15183-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AF9CD967F
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 14:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 334F43012AE3
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 13:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F2332D448;
	Tue, 23 Dec 2025 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SLgzLV+9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15063332EA2
	for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766495528; cv=none; b=aV8sKRQFPjWnu4gBsS4iGb7N4eiEOjlr+Ys08arrDSVwVEENQ/ZGZKsuHhncDor2DhmdQBKFImrmH/MQPvUavDnlbCra9cHmLESSBgZTaow48u9hnyCmlEYLgS/BFn7GzwoVSlKGHCjz/Qvbsnge3vTIrwDcSIgUS/gmBpPGDsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766495528; c=relaxed/simple;
	bh=UObO+sewys7WApZvMix1mZ/u0hIOamJE7FEMBn1oSnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZvkjuIAcPnG1/BipkZm0qfrYzIDncG9JNJvIReGmMiqbgn43vV4m/NipTIoFzUGJyodAAeAFJSTGUKGiC0OZHw4vu8O8OC0awiHv17ZnQblAAQ3C41RmN4aPVkCorcSRSg7qIzWGYEyxEqxMxcx8xZY4pIRWQnOI7Ila7cpe+kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SLgzLV+9; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a07fac8aa1so54073215ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 05:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766495526; x=1767100326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+CzjxtQBlDg1zg17jSZfSgvsvrDAHLbUxrU+sqchZc=;
        b=VVeHVZHzcuLv5y1OXstct5nvutfyyw6dRuIq3D18V4NeQIbM/s4NAZdJXsgLtRtF3x
         +Nj9FdCWcYlZeBitxeWdu9psQG/sQGECGDzfvbG6vU/63heH0zq3X5tLSW62on+u43SB
         wS+Is0DFn4ntvOY6XO8l58SvMp6GuGKQhYd+1YTRbFnP3SxYgl+WnBzXTIXo0XiufEje
         gcJ/nci4gC3skDjLSMBx9tNQPKPYerrzOx7MrYGZa0ZIro5r5E+ENL6cvA+yR/6cA+pR
         MzbjlpNeqK8p6h0p4zSYT16AgFuC4NkrzQQINMZHel/reGrzWauibe0We3zqNasDdd8w
         svPA==
X-Gm-Message-State: AOJu0YybQLlhHl7IyLDJ9SKflgjwWcCR1s8q8zfZjJhQHOBG+mUMXmtT
	3QMDxxaGOfg4YTYBb9XuZ3cSpQ6yiu7lZ2xXABRpxRCDlJNTnWszPlYQEJA3meZCNf1SJaV0uP/
	qaNDEYDrGpIsuGOPBYkvq47TtwIcyNoySqsX3qh6E6/fPdTOJvihrnZijpeervYQ+Tp2Yr6ZzN9
	7SQgkvE5Tl/APq0OxS3qCfChP+BjaAAzS4k+pMplqQIcFNFilwe3y4kmmDcrAN45Xp++5j+VfmO
	J35n1F2Vu4M1K0qqKFiNfG2UY6rEw==
X-Gm-Gg: AY/fxX5syojD891VNa+7bzIW2wSO1yn0pWtgfZwzYSXBDj70Q7eC0n7nSvhIx2Mn25O
	9EYpAf15LP8MuygP9zMMhUkXgOLuoaX/8sRo1QxxthY3SvCtZjttqYLZCGAJry5rZSvIYiDfS5k
	I42TRLgm16VYGDo+vJUJlwZAILXAKuKGz9stFPHI/WyQB2Z2v1aRKutdsv7s4fdozl/7DbT6xEQ
	l1+17Fr0+AdlAqmJWE5HmyGdg2KlG58JfGen7Ejj6t/qsA2p3CAsSjEqU7KVxqeOVNOl/US7T/T
	Jn0Oot2aiOi2PH5JEye4tF5WAWQNU06RxOndyv1Ufb7FF9eXNCCs1OcCT4SI0RlIpDKlZFfoKMT
	QSmgVq2+ydweMhHqXrRSSpZxEp6qrPUX3rvv4zMAwLMv8o4X4CB/lzH3YfAsw6mR+8xrV1sxt1t
	B6ijOALA+D4oW2g8OyY6pU5Rc49TZS/7PBHd0Zb+bFhId9rqQahADFub+45w==
X-Google-Smtp-Source: AGHT+IFTkzFasbDAy1AnO2JZDzxDoOtxoQheX8aSbKAIjKj6ip5GHenUXyLKiGqmMNAFihwRCzqh4Bp2eI97
X-Received: by 2002:a05:7022:6887:b0:11b:ca88:c50f with SMTP id a92af1059eb24-121722e9d56mr17290358c88.40.1766495526109;
        Tue, 23 Dec 2025 05:12:06 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-10.dlp.protect.broadcom.com. [144.49.247.10])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-12172537f65sm2738162c88.6.2025.12.23.05.12.05
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Dec 2025 05:12:06 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c3501d784so5676173a91.1
        for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 05:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1766495524; x=1767100324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U+CzjxtQBlDg1zg17jSZfSgvsvrDAHLbUxrU+sqchZc=;
        b=SLgzLV+9caJEq0azohuSQ4+IXfdWd8z4u4HoLzyTHNxFwoalk8z126BaDuXmYtnUmb
         qRM4HoXxu/jD8N6hjE2U4on4E7M9fLWZ5IUunR6a1kT5pz2e4VaZAg6VkcXM4O38p6A5
         I/sHPM1R73g5ChTJi1NjsiYM87Ch0AMc3I2mE=
X-Received: by 2002:a05:6a20:7d9f:b0:366:14af:9bca with SMTP id adf61e73a8af0-376a9acf00cmr12995285637.64.1766495524349;
        Tue, 23 Dec 2025 05:12:04 -0800 (PST)
X-Received: by 2002:a05:6a20:7d9f:b0:366:14af:9bca with SMTP id adf61e73a8af0-376a9acf00cmr12995261637.64.1766495523809;
        Tue, 23 Dec 2025 05:12:03 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e589b0csm13962617b3a.56.2025.12.23.05.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 05:12:03 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH rdma-rc] RDMA/bnxt_re: Fix to use correct page size for PDE table
Date: Tue, 23 Dec 2025 18:48:55 +0530
Message-ID: <20251223131855.145955-1-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

In bnxt_qplib_alloc_init_hwq(), while allocating memory for PDE table
driver incorrectly is using the "pg_size" value passed to the function.
Fixed to use the right value 4K. Also, fixed the allocation size for
PBL table.

Fixes: 0c4dcd602817 ("RDMA/bnxt_re: Refactor hardware queue memory allocation")
Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 875d7b52c06a..d5c12a51aa43 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -237,7 +237,7 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
 			if (npbl % BIT(MAX_PDL_LVL_SHIFT))
 				npde++;
 			/* Alloc PDE pages */
-			sginfo.pgsize = npde * pg_size;
+			sginfo.pgsize = npde * ROCE_PG_SIZE_4K;
 			sginfo.npages = 1;
 			rc = __alloc_pbl(res, &hwq->pbl[PBL_LVL_0], &sginfo);
 			if (rc)
@@ -245,7 +245,7 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
 
 			/* Alloc PBL pages */
 			sginfo.npages = npbl;
-			sginfo.pgsize = PAGE_SIZE;
+			sginfo.pgsize = ROCE_PG_SIZE_4K;
 			rc = __alloc_pbl(res, &hwq->pbl[PBL_LVL_1], &sginfo);
 			if (rc)
 				goto fail;
-- 
2.43.5


