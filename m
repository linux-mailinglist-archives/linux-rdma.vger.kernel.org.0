Return-Path: <linux-rdma+bounces-4993-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458F697C323
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 05:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0245F28305B
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 03:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C24312E75;
	Thu, 19 Sep 2024 03:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AM+Urz88"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CE92F28
	for <linux-rdma@vger.kernel.org>; Thu, 19 Sep 2024 03:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726716422; cv=none; b=KGzySV4hUql5W6KGBpFNfdwweYLsxLKwauJUFlfEzsWZVBvNha3WdgEVO7w6E9uNI1wkiq4xL6X4CU3BLmT8wD87CCJyg8rwtMdiDVukuytFwpOWKL0SCAXVfX1IVzUd/xdLV+TVBrfSk2jxgZQZeGb6tdV0TB5PrSdkAC7MtjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726716422; c=relaxed/simple;
	bh=yHJBT0zktJrwBrQeXQk5Sz2r4oLmjnHknn8GxycdboY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YtX4HVrYdv92gvbwcerW2WYP3gmCfZCBCEDtxlxb6+e48ZuYwdL0JlnO6T63QatL4HgJUcoy1r6e62dPsDpudydTzgYXtcGD8GzuEMD8PXlc8AkvLFbfp08OKTliNGV0X1yJOqRoO5wMZ4IJY9lp8mzfBlc/1A7xx1r1zLLL7z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AM+Urz88; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71970655611so329153b3a.0
        for <linux-rdma@vger.kernel.org>; Wed, 18 Sep 2024 20:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726716420; x=1727321220; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zfPUA/rgj8ZO5zioWhOvpSaAURSYsjgbOH0/+cb7F4w=;
        b=AM+Urz88tEjeUUrPog/UWicz3lndXb2Ap82wUJarqxOrpGW6FVUYrAbzM2VzweyoIx
         0FOeTabtii9EAlF6H6GQWsFaUKOcx1NIV5fIApAyLmWSBGCiMKHUsckBujlFxZjPm412
         7NRtsQE8N6OVmkgt/bf8pFEf1ug3yNhEzttHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726716420; x=1727321220;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zfPUA/rgj8ZO5zioWhOvpSaAURSYsjgbOH0/+cb7F4w=;
        b=egWB7tO0Qhd1o2VGwWXrgWA/qi2qczQVt2DvlB9SOz6AkLVNPqObjAEiecN268hdds
         npWJrRvkeS4fzj8+Juz0vLW82IJNISZIT5DJeJ2Q9oTynFxZ1LPntLbtr7X66YENzumM
         tpBGlAkAqSXKw1ffd6yuYJ6yjfIb7qNodZA9VMpg1TZQq6KFjVnAvkKYI09EUSJXv+bX
         xFGQykm9zRV2fru1lvaKs4nicxUJp0vDeJbXrABQsmwS+J1qMN03q8e1J+w3MApz8JYL
         9AX+lh31jmSI/ePBOiiOqunFmnwe5D3AQGMcaG4ndXA69iPoWaHDkx23pkkWW23PTPPx
         75hw==
X-Gm-Message-State: AOJu0YxbxZi3It8u/Oj7Owh0s/mIJuUHXuO9mNhU5PBMtdVHnwxV1fSP
	BwndM9woGLcxDqjv8v9+NHNjTIHJB9UqsltrTo0SU296X5hSiSCrgY2LQ3cKag==
X-Google-Smtp-Source: AGHT+IFPpTrJt1q+Woy31wmn/40UO/PHkIK5Gh8002BVb/chaV8MGFwqjoNAsz7nAjd+4ndhRY4Jdw==
X-Received: by 2002:a05:6a00:1948:b0:717:8ee0:4ea1 with SMTP id d2e1a72fcca58-71925fa95c9mr42636634b3a.0.1726716420035;
        Wed, 18 Sep 2024 20:27:00 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a980b4sm7400686b3a.34.2024.09.18.20.26.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2024 20:26:59 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v2 for-rc 3/6] RDMA/bnxt_re: Add a check for memory allocation
Date: Wed, 18 Sep 2024 20:05:58 -0700
Message-Id: <1726715161-18941-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1726715161-18941-1-git-send-email-selvin.xavier@broadcom.com>
References: <1726715161-18941-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

__alloc_pbl() can return error when memory allocation fails.
Driver is not checking the status on one of the instances.

Fixes: 0c4dcd602817 ("RDMA/bnxt_re: Refactor hardware queue memory allocation")
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index dfc943f..1fdffd6 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -244,6 +244,8 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
 			sginfo.pgsize = npde * pg_size;
 			sginfo.npages = 1;
 			rc = __alloc_pbl(res, &hwq->pbl[PBL_LVL_0], &sginfo);
+			if (rc)
+				goto fail;
 
 			/* Alloc PBL pages */
 			sginfo.npages = npbl;
-- 
2.5.5


