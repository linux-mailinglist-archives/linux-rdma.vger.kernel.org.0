Return-Path: <linux-rdma+bounces-11897-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6B1AF86D4
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jul 2025 06:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1276D167D91
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jul 2025 04:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC681E990E;
	Fri,  4 Jul 2025 04:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F21usjPj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8389015E5DC
	for <linux-rdma@vger.kernel.org>; Fri,  4 Jul 2025 04:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751603593; cv=none; b=Tc36XG4UYq6q76Ynp3tUtb42c7KJ8ShKieyW3n5lJNjA/4HCxOS9FUK/1jWZH4apEynkBeMwT5kRBsx7Rl1urE63VbcxPDcKJwAFT6XrVhuz6QK1qCVXZlnq5TrsImtTGypKsBDCTOjZwE9j8RjXZhTS5qB+IcAO5aXF1ndgHFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751603593; c=relaxed/simple;
	bh=20/V+5hiWKD+1VbdlFqkEZptMWSArT6NQzuE1FNqqY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHkCcv7gZDSwmkPrOKcKaYaFgF54SkVPwjSjvSeEuOCNEg3Jg0rhk2O7I0ObbU1xMHkbbq8RQYv2Xmh1WGJj+QLPCsg111FnApYRv9iiF379RGiMv1mGpfKf0xZgzJJHbL+S5xLWz8yD7m2qyf5uXXZde+yg3LFUxGVdCn/GBqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F21usjPj; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b34ab678931so404410a12.0
        for <linux-rdma@vger.kernel.org>; Thu, 03 Jul 2025 21:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751603592; x=1752208392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBd9viHP/81YNHJwAgf5zgLrI/qF67U48yrJdl1vkyc=;
        b=F21usjPjMrXkjgISbTz2rgBiZ3sR/zC0jAW6tdpVT23T8aGooK7eeMdXT1pCsmN2b5
         LDxPcnYLO1CcqdrNaahU0+8yFfo76ZB8UbFUFMjq3nPj+nFu47UiqUaiBA/Y4JQEq1zz
         XNFwZExqQmFA83iNfzLMpaJvVkoLXFCAQCj/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751603592; x=1752208392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBd9viHP/81YNHJwAgf5zgLrI/qF67U48yrJdl1vkyc=;
        b=VfdlXk3zZzRK8cB1fNXdioCB31TGvVJlVQ9+1QCf5DrONUKWVLeHRkHP3OQgn0sSOM
         0aezeROL7iRSzhWlpiftJNQ7JcAxOlanwjTnUGz2+0V+SOQvTFRjvZ/p9MxLFAKhKwg+
         H6L5WCIfsuucRJhp9DTtu26OHYiQ1rHPSA7I8UFZtjmJxsbeR9aDzfSsaYLS36PRayRf
         XaSlJfB4vEgdrMP+PLVOfJ5JL8DYlT43GTi7nczfYUPFFra+h85JBuK5GiblsVPieo63
         M2oGwjVOEW7qYrs9Q9BgwMU/1oR7JYWsbHdoggvBm/dba9yBsg5J3iVZ6ciOwaeWND10
         f+OA==
X-Gm-Message-State: AOJu0YzvaC9cUEpaFvwP8lFecl88tt1PCg/AtJ0k+XI8LcZCRk7ayHmT
	sVZj/qDufolY4qPZ5VUEBFp1KajfxKI53bKT2AlFrDTisUD9j3FAirdQKje3zKPBHg==
X-Gm-Gg: ASbGnct6qF92nZcdiKAfdkRlNe8DJitSuza67wHMODw0GNn5lImPl+zmPtd1offqD2t
	Bpgx7cnAhS9IU/BLpnSq6rhUTn/HWbwTf38FFNIFhM9B1xslwB6dxbqmtm2k7OCN8uzp53Zeu/X
	NAmUNAPQN6UITo5LLO8tsHQa65sfpFIa2K85BYGcSIRZxOmqx9UruiSjZZdzT8f1oLQXE25oXam
	Sv1DxP1K2Br0ZuPa5RYbDBuKC1rdFaWxDDQ3qsXmiCs9+AFvQBn805Yie7qfN4riYPdnlYQYUTk
	rP1Xov/8LzZ4WEhUN1O5uG1m6N2rmINTNsYXCuAWyvFpf1ZsW5PgOn1c5Pz+aFiRa7BzQ+8HJ0C
	zO38jR6gIHltmqjiXHUqzwFZ07ewrQ2vE6OxAzjaN+ywuNvdo5MJLlWTA+cO2h15eTg==
X-Google-Smtp-Source: AGHT+IEgEd85NEu68E61OneG24jldiqPCLBWMSoHYmlpV6QV7/FZD3rxt+6gskJ5NIZzrToxCbHUcQ==
X-Received: by 2002:a05:6a20:431f:b0:1f5:8e94:2e81 with SMTP id adf61e73a8af0-225be6e3effmr2029192637.9.1751603591896;
        Thu, 03 Jul 2025 21:33:11 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee74cf48sm976223a12.77.2025.07.03.21.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 21:33:11 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Shravya KN <shravya.k-n@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH rdma-next 3/3] RDMA/bnxt_re: Use macro instead of hard coded value
Date: Fri,  4 Jul 2025 10:08:57 +0530
Message-ID: <20250704043857.19158-4-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250704043857.19158-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250704043857.19158-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. Defined a macro for the hard coded value.
2. "access" field in the request structure is of type "u8".
   Updated the mask accordingly.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Shravya KN <shravya.k-n@broadcom.com>
Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 2 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 9efd32a3dc55..68981399598d 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -674,7 +674,7 @@ int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
 	req.log2_pbl_pg_size = cpu_to_le16(((ilog2(PAGE_SIZE) <<
 				 CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_SFT) &
 				CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_MASK));
-	req.access = (mr->access_flags & 0xFFFF);
+	req.access = (mr->access_flags & BNXT_QPLIB_MR_ACCESS_MASK);
 	req.va = cpu_to_le64(mr->va);
 	req.key = cpu_to_le32(mr->lkey);
 	if (_is_alloc_mr_unified(res->dattr->dev_cap_flags))
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index e626b05038a1..09faf4a1e849 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -111,6 +111,7 @@ struct bnxt_qplib_mrw {
 	struct bnxt_qplib_pd		*pd;
 	int				type;
 	u32				access_flags;
+#define BNXT_QPLIB_MR_ACCESS_MASK	0xFF
 #define BNXT_QPLIB_FR_PMR		0x80000000
 	u32				lkey;
 	u32				rkey;
-- 
2.43.5


