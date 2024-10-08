Return-Path: <linux-rdma+bounces-5295-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D5F994214
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 10:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FBFB290BBA
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 08:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61291EABC1;
	Tue,  8 Oct 2024 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NvWYPmMN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387041E32DD
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374564; cv=none; b=EKC2ru4e29KzifVfOKUSOICl1tcKa56wOBD0ocGkOgTbSzchtDn2JrsSVPIWMKCH5/p39C3PLzP8APjyTWXljMEYngsjVxpD/i/9uAZ3iR99WkcuBESOxT/4xAAwxavn1CH4jnEu4NDvdbcoHsdy7K3ynhkreBGDz4sUFo4j3Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374564; c=relaxed/simple;
	bh=diS55E6awTAYUhoOaKfgHQOliA2vXxFwudo0cn3R3TQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=u3U+6n2TD/mfLaMCiW6NjyUtvWGmc94AC0Jlpe2VPSkpR8nuyPfO824kvQZ4UEo4kcIQzrIOmKN5E/FqN4JfPmGxHI5kEAw5g/aEHwH6o9U9B5Sike1u+1jEJxvjdZr4kLsWA+99dO9cumirsweM6vqgmEgFYsKOJia5mZAZCDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NvWYPmMN; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20bcae5e482so46290565ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2024 01:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728374561; x=1728979361; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ACuz4S4P9KJ42l4wMrBRlMhNyXuBrVIndcKfsMl1Yxg=;
        b=NvWYPmMNDseYuJDp9HQCLLtcMhM2w38WJXxqqZV03GwsFT+kQFbE+od1cmMhM0nwAM
         9N3OoAUWD8kIUBFxcbP8nxYiLUUHSXft6OcZQkO1p3SurwZ5OV0feqBF9141ceGzWkIh
         d8Z6Wa1GLisqqp8t2cj2ZOiyqRabPZGmH3Hl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728374561; x=1728979361;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACuz4S4P9KJ42l4wMrBRlMhNyXuBrVIndcKfsMl1Yxg=;
        b=COdRSzAf1M16DzlOx9Bdu8waC0FDYmWYZ2dfyedsQXpKgq4fGF1xLGD+SBv/W+nRfy
         tPuWXMeyuQwJ5G6wQLepQqut/lSeZIH+3Si7PMJWfoL6iMzfaudgODOnv8weinCTMx89
         fNHJTo1OsqVktkwUko05snIIfojxtRc3c21JErTskjphx8BtpWDnt4c74motU0TDW/Hd
         E0IRSNNYdWvXkdoqJU5lCvtQ59LSPMU9A0iNQ+cR6nqZnsJ25BBtf7gq+wXaZI2F7YI5
         7kF8yKa1S7bCy+7EHbzu1ZTeUzh3t2NGCr+v5QQc0irnaBSiXknxCaqnjf6uvJyfOhEL
         AigA==
X-Gm-Message-State: AOJu0Yyjf8OkCHoN51NUWXZzoZz3sGorXwIimzUkQTT5n90e01xY4DSz
	345Mu12+4qI0gAFYtTES+wlKRsyi1bC8OOIf4j+bQxMN3l4s8thJ4cpCaN6t0g==
X-Google-Smtp-Source: AGHT+IHdPstX9BoKCiPv5/+jj32h8t79l3YxZktTXlfsPxM7PUypNgkCInnlvBfu78xa+8GhADLmFw==
X-Received: by 2002:a17:902:f642:b0:205:6114:9628 with SMTP id d9443c01a7336-20bfe023d32mr245595045ad.7.1728374561303;
        Tue, 08 Oct 2024 01:02:41 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1396d547sm50339915ad.223.2024.10.08.01.02.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2024 01:02:40 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Abhishek Mohapatra <abhishek.mohapatra@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc 01/10] RDMA/bnxt_re: Fix the max CQ WQEs for older adapters
Date: Tue,  8 Oct 2024 00:41:33 -0700
Message-Id: <1728373302-19530-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1728373302-19530-1-git-send-email-selvin.xavier@broadcom.com>
References: <1728373302-19530-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Abhishek Mohapatra <abhishek.mohapatra@broadcom.com>

Older adapters doesn't support the MAX CQ WQEs reported by
older FW. So restrict the value reported to 1M always for
older adapters.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Signed-off-by: Abhishek Mohapatra<abhishek.mohapatra@broadcom.com>
Reviewed-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 2 ++
 drivers/infiniband/hw/bnxt_re/qplib_sp.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 4f75e7e..32c1cc7 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -140,6 +140,8 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 			    min_t(u32, sb->max_sge_var_wqe, BNXT_VAR_MAX_SGE) : 6;
 	attr->max_cq = le32_to_cpu(sb->max_cq);
 	attr->max_cq_wqes = le32_to_cpu(sb->max_cqe);
+	if (!bnxt_qplib_is_chip_gen_p7(rcfw->res->cctx))
+		attr->max_cq_wqes = min_t(u32, BNXT_QPLIB_MAX_CQ_WQES, attr->max_cq_wqes);
 	attr->max_cq_sges = attr->max_qp_sges;
 	attr->max_mr = le32_to_cpu(sb->max_mr);
 	attr->max_mw = le32_to_cpu(sb->max_mw);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index acd9c14..ecf3f45 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -56,6 +56,7 @@ struct bnxt_qplib_dev_attr {
 	u32				max_qp_wqes;
 	u32				max_qp_sges;
 	u32				max_cq;
+#define BNXT_QPLIB_MAX_CQ_WQES          0xfffff
 	u32				max_cq_wqes;
 	u32				max_cq_sges;
 	u32				max_mr;
-- 
2.5.5


