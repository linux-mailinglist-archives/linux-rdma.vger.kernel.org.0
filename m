Return-Path: <linux-rdma+bounces-12587-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CA3B1B1AF
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Aug 2025 12:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0ECB17BE93
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Aug 2025 10:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8142580CF;
	Tue,  5 Aug 2025 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Fvn86cKe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C031E9B2A
	for <linux-rdma@vger.kernel.org>; Tue,  5 Aug 2025 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754388247; cv=none; b=JYiNmfLs173MbdtERHTwMoZNNNuwi7b1lIvqc2nfqIbpx629K776vTrHKkNGLZ6UYsAhxRpKqbwA6qp+HYz2jM2NQ+tVigCQAI74YAmE5LAkg6Ewutd4VqbjcU48QHeB0XpXTbI4A8CI6lF0vkIopjuof6RzGPRWSh/DqUgOh/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754388247; c=relaxed/simple;
	bh=m7zlfgTezKFqy6bi9Iq4grBpEZc1dB0pRT743pSmMDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YB9gvOcPPszhmjDvis0rGa4w1l1VKff2gjxIMB7hwT5LZurOTBgNLycXRzEDXHI8JFiZJ8lQ/Tjx7nJScXmTHF51N71ASBEXVOfRxnSflwmAsOnMz6iHAYBJ8DyhjmFdHNKJhUe23lq+YzaWqyRfoQGV8cpylO7ehbO5aVrIrMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Fvn86cKe; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2406fe901c4so34534485ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 05 Aug 2025 03:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754388244; x=1754993044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DfEX0ZFKH30Jx2rXUlWe4o8Du0pefmTxplpUeThXJM=;
        b=Fvn86cKeLMDgsf36Ylfs63HPEDMibpPlE3/IYIK610cJV0tn3s+3QooJKrj7aEV4/H
         pJeqe57hvEU7FNzAbLa4ucl0k7NaQAiX1+6e4T9NwuLLQ+1hFszL9i0IUhk65mhehfNS
         UwbLINwYeG1kD1YLjCHQTxTjsaOo1ZqGWfSUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754388244; x=1754993044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DfEX0ZFKH30Jx2rXUlWe4o8Du0pefmTxplpUeThXJM=;
        b=tD9ZSQA2hCRp+5hDrH/xv6aZ+QaZY2tb5eepsAQh2O52DGqvSV/TxKNquIamttsogK
         e4tutc/o/Gmisp1LkUDs6fAIRMmij1ISMXlylL12d3I6or3/I5nO1RhobuHAmUIGpOoF
         paDcO9BamRGMJyXXFaxO++wRL3itbhQVYkDpY+RvpTeuObySqBX5drO6w+TAetncKXPC
         H/sWGd21jhggVANl7/q/KgpgwMYmTUbnk93kPEwS1R5N0QhMiuId08/Utn9/FAbvlWlK
         0AKrgPoRFsmXfis4iMxJ5b79icvMsDTgA5PhRJTvmfeODehU5QVw1vLLtBhvGo1TBhMv
         18Bw==
X-Gm-Message-State: AOJu0YzgO2EfapwgPEmz43DF84mBgwzEBf5dTSXfZjfXEoZwzBG/BC8v
	mBkkzlDBl0cc5Ub8yXlPsbecrwqXZ5VAFAXKLlqmddRq+QjJGoMYx1flqeVYXhVWyA==
X-Gm-Gg: ASbGncsyYS5iLbpWJcBDdMaT2QjAT1jNHds6LiYOP04aRYicN0jGChM6uOzSpfUeITc
	Gi5u6/OkWZNyp06Fgg2llY7OVWBBQHM7/OeOja8tgl54/6MWQvGYBHjno8gUhV9UtBxLJaiucv3
	xoczEVbOJIWyus5vphhvng6FERhJ6M+3dDiak3knJQvA3SBBJhCtkH3wlmZ1iqAWl/KdlO4y8WC
	J507hCrUS9atxo32EZ9ZyIWOSTdd2+jUQB695TZGTQE0DMsKG/rpNM64lieuUx/lm8YqeEa2xwK
	xVFwvIbU3cSEFdabpvu9f3eUylwRDVEJPK1nugwdffElAIC3oYCQKsX1tPoJARFPAcgFtCtAMdH
	WzKFemBbfukslN9CyUgO4OTIUJYFTNR6tbZZOywfpvuoOXxiG3/SnF23WlFgmsMIK2q4yG5w0Rh
	lsyQ3vnhCUIFKtqFXGerZWWjVpdEfSo1aG1BrxjZdKB5L9ziQ=
X-Google-Smtp-Source: AGHT+IHCGFbfwPPm86oPwe74JQg6CBceWuyWQjX/BfPpvphvL1xnKzK1WLlWXXUkiE1XUxqgfk4Icg==
X-Received: by 2002:a17:903:2348:b0:240:9dd8:2194 with SMTP id d9443c01a7336-24246f787e8mr189348465ad.22.1754388244400;
        Tue, 05 Aug 2025 03:04:04 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2423783a84bsm96838595ad.51.2025.08.05.03.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 03:04:04 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Anantha Prabhu <anantha.prabhu@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-rc 4/4] RDMA/bnxt_re: Fix to initialize the PBL array
Date: Tue,  5 Aug 2025 15:40:00 +0530
Message-ID: <20250805101000.233310-5-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250805101000.233310-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250805101000.233310-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anantha Prabhu <anantha.prabhu@broadcom.com>

memset the PBL page pointer and page map arrays before
populating the SGL addresses of the HWQ.

Fixes: 0c4dcd602817 ("RDMA/bnxt_re: Refactor hardware queue memory allocation")
Signed-off-by: Anantha Prabhu <anantha.prabhu@broadcom.com>
Reviewed-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 6cd05207ffed..cc5c82d96839 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -121,6 +121,7 @@ static int __alloc_pbl(struct bnxt_qplib_res *res,
 	pbl->pg_arr = vmalloc_array(pages, sizeof(void *));
 	if (!pbl->pg_arr)
 		return -ENOMEM;
+	memset(pbl->pg_arr, 0, pages * sizeof(void *));
 
 	pbl->pg_map_arr = vmalloc_array(pages, sizeof(dma_addr_t));
 	if (!pbl->pg_map_arr) {
@@ -128,6 +129,7 @@ static int __alloc_pbl(struct bnxt_qplib_res *res,
 		pbl->pg_arr = NULL;
 		return -ENOMEM;
 	}
+	memset(pbl->pg_map_arr, 0, pages * sizeof(dma_addr_t));
 	pbl->pg_count = 0;
 	pbl->pg_size = sginfo->pgsize;
 
-- 
2.43.5


