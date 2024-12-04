Return-Path: <linux-rdma+bounces-6223-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2869E34D8
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 09:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37DB416660D
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 08:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CE71AAE10;
	Wed,  4 Dec 2024 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eGZA4DIz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8171192D86
	for <linux-rdma@vger.kernel.org>; Wed,  4 Dec 2024 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299097; cv=none; b=HhOtXmnpBQI1SW02zzKD1PGkOyLkJod/GQXL3w97Rad1URO/vWr/z4yeYyDfkBupPmoTHqDAs/19z6TqX6wYCSH7DeBcibDJu6867e3SzaRDeOMrLydQmMpRryHiT1qWygGXdMvyyKgpr8JFsDDeRT9mEIcrhrtnp1iTXm72A1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299097; c=relaxed/simple;
	bh=N/U60O4Ck0Nm6kaetMC4A7sNcfgISQ4eA1+dej1Ae8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbBR7k/B6JafQvTImeHKCTwkpuh6DuGE6SBJorm4i14R4GiNMaSV9Kb4T+MO9uUg6o6ZTNalTTYJEcB2m8ur6bzT69bdaEP2Gs3J3XAA3SswLvjBwPLuN2CJbXpBuKoixAIgf36Fktq30VjAVfXDHGJ9Er8tzP3+te2fHI/nPFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eGZA4DIz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2154e3af730so39722115ad.3
        for <linux-rdma@vger.kernel.org>; Tue, 03 Dec 2024 23:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733299094; x=1733903894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMwFjqYRs5rLhlVUhm9tYS8e6al8EfCryfrjNlOEgLM=;
        b=eGZA4DIzmN1VelDrRnUbkridjO//0i0h6KQBPJmXiE0Gd/B63KAijEjWwoxtdIoSpz
         mRAH38mQkf06iU9GXFRIPTDuUYU+F8XHzA7B+g/E7+kB/+4czcjHGRGfCp/IPDOilGBo
         iLlyFGrliO0POJmOKS1yXxhb4SBxR/SMXPYDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733299094; x=1733903894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMwFjqYRs5rLhlVUhm9tYS8e6al8EfCryfrjNlOEgLM=;
        b=uxzdqEU7aZ+CbFAedPOw1RAP7VZg8ytag+pn9EqnH7ejhSl/uNgi+ijUlgKYN0cS53
         t0gKsQK7HQef0FqLktw4HQnyrpoezLVxJ/Yea5FCjb4BYu8L4paORJQxTndaZZtiNNBs
         o7EnoLtgVVItT2iXJRBSr5ZaF+mtO0wxdj9ZRBK47ZPb42qwCa1mOMUHQyOqIFX3evcv
         N8aqxOr2udsFZh/MEAoY8K1LnUeekYu4qG9w9UUK5gXH6Y3db6/aF20JQp8ImOKN9t6D
         n/gZl/0S/yqVmfIjfz1pIOFqweoHjwXW5M9y4MjfcpyioHL2tJs5d2GzLsbP8jyGLu35
         7f/w==
X-Gm-Message-State: AOJu0YzBOydCh9K5ctsLuYK7iW5vNAFJev6N/e81fin3dvw0IVD0FkGz
	+p+rR8fFlO5V+Pkalg5pTZrZXrIrvHvjWlNYcNXc+Q9hZ4xvbMAc5iI8pyFt/Q==
X-Gm-Gg: ASbGnctcb9j8XEJWj3guCfbFi5K5O3Tu25LexSGDj2VkkYdn1MebSBcde1EzGEMUgC0
	r6QoDKGMb1jTEJUVTQhiC4DhOWIUaNEbc8FA6c+Ff/cJQRp7RZUKSIzXnBp3yM7MGzvaXfc2VQ/
	HNl/sTUd1Tp49i9D8O60+UQKTNfOQPRGkn1MaQFfceVeGESmywNZ8plA/IvNjInZExyqD+PS3Pb
	gFltiEoQxnX9fNsfxmZpry6ZQB0GXE7ssEoVbg1N9I+ZiJ8X/SWD4R3uTzeMnplwl4QnoFwgXWd
	f5dOEQTFvQekf5F5aMS7TFLdl+jjQDsfcGMP4g/8d+jrzQ+5xyPn
X-Google-Smtp-Source: AGHT+IHgilz1ch7ILFLhcQan9NEElCaD5AJUXagnVy67K2DQGxswA5uR365qu9FiJI2FRoWRid9reQ==
X-Received: by 2002:a17:902:d4ca:b0:215:b6f1:78df with SMTP id d9443c01a7336-215d003e862mr56650895ad.19.1733299094130;
        Tue, 03 Dec 2024 23:58:14 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21536d67e95sm95462235ad.76.2024.12.03.23.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 23:58:13 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kashyap Desai <kashyap.desai@broadcom.com>
Subject: [PATCH for-rc 1/5] RDMA/bnxt_re: Fix max SGEs for the Work Request
Date: Wed,  4 Dec 2024 13:24:12 +0530
Message-ID: <20241204075416.478431-2-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204075416.478431-1-kalesh-anakkur.purayil@broadcom.com>
References: <20241204075416.478431-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kashyap Desai <kashyap.desai@broadcom.com>

Gen P7 supports up to 13 SGEs for now. WQE software structure
can hold only 6 now. Since the max send sge is reported as
13, the stack can give requests up to 13 SGEs. This is causing
traffic failures and system crashes.

Use the define for max SGE supported for variable size. This
will work for both static and variable WQEs.

Fixes: 227f51743b61 ("RDMA/bnxt_re: Fix the max WQE size for static WQE support")
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index ef3424c81345..19e279871f10 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -114,7 +114,6 @@ struct bnxt_qplib_sge {
 	u32				size;
 };
 
-#define BNXT_QPLIB_QP_MAX_SGL	6
 struct bnxt_qplib_swq {
 	u64				wr_id;
 	int				next_idx;
@@ -154,7 +153,7 @@ struct bnxt_qplib_swqe {
 #define BNXT_QPLIB_SWQE_FLAGS_UC_FENCE			BIT(2)
 #define BNXT_QPLIB_SWQE_FLAGS_SOLICIT_EVENT		BIT(3)
 #define BNXT_QPLIB_SWQE_FLAGS_INLINE			BIT(4)
-	struct bnxt_qplib_sge		sg_list[BNXT_QPLIB_QP_MAX_SGL];
+	struct bnxt_qplib_sge		sg_list[BNXT_VAR_MAX_SGE];
 	int				num_sge;
 	/* Max inline data is 96 bytes */
 	u32				inline_len;
-- 
2.31.1


