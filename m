Return-Path: <linux-rdma+bounces-7393-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E82A26D72
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 09:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688AE3A3C19
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 08:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DCC206F2E;
	Tue,  4 Feb 2025 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RcJmWixH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28508206F18
	for <linux-rdma@vger.kernel.org>; Tue,  4 Feb 2025 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738658543; cv=none; b=A598fGY1pfdzwyD4TrexxRlmA9qPUeA1eXGBqRE44a/g+NsW8n9v5v01eJCY9cxD2IDDtySRF2qrWC2xzduzD5jLgsR7JFmbZED1gv0GnjoAnlgcsB+8dnYh6ITonW1jXinsBcPTZRATmM4FssBs5/0/9Z2afxPVk8sKw8frdZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738658543; c=relaxed/simple;
	bh=3e+i/8dxQ+ENphukw2p8Urc4mXA1jbuBeoaFRuOgPms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OaaawcUOe1MYXJyiGoSU8/tSzxmwC2onlCddTZAWBK3NlQzNFVg/vRZ/sgIzE9N8J0Zkpuxo/PerY1COc8wUhPHoTsGKbrgePPOHN+qDWotwBr9TpKn8olZKTnJbEijSiXxF1xDkuJs+6YxXjQ7bXVc7BinU7hg3zyZKoTebyTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RcJmWixH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-216281bc30fso27653825ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 04 Feb 2025 00:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738658541; x=1739263341; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+J3q7sg0dOEVMNiRmZamY5toy7f04GTF5dJeUzdhtdI=;
        b=RcJmWixHPQYrlURX17Dz8XKQK/pc1fgQxlR8XRlDhNeyqwB/4MwE6M0hoUoOQk/YuE
         U7arVqQtZWzVX0LpKcG+uEAnRpRYeYbYD4ubR7zrVkfS1hmj2pDSCViE0zC57ycUSWvl
         oeAyOJXJ2/3kqMsLqYRsptp9nkjSqf3+Mdjs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738658541; x=1739263341;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+J3q7sg0dOEVMNiRmZamY5toy7f04GTF5dJeUzdhtdI=;
        b=ocjX1n49go1q+hb2FlBIg4kCM88vkiXuJb3ftmRKC5rEWr6dRj9GWFa9ESWF44vGd7
         mFntVrRvtHjM4HFuwBKr51moC4OH2x2d9RgyRdWsgFGDbyeSOza12M5V0SNCeDjgsxzh
         Y2hLVuUCOKTl3AHN/nI4bMhkowZLkYWtyCpbRgaW23FWN52mIXyhDQPhjtj05a9KIFaU
         G7r+fEP6cuWwZukVFvrwd8Olb1hMxvyR/hnih1ZGsq4tFbDcXqsqH2m7Lb+m2+KFuvXG
         9nAznZMCBo89/7M9M2KB4CykQvIlxnHBb5tkgf1/0+tOw0XxPbJq0SfvqLnTX+ln0kHF
         Iuxw==
X-Gm-Message-State: AOJu0YwE0bE1zNFS9zAeq9MGXItfBLuCvUUbTmDoMW5ugBF0yFRVcORL
	hzqAnrSVAUZcTDKB9bOav5x+kCjC+xtyMNf/osQZ52PV5gNt6mkbN/Cribhjtg==
X-Gm-Gg: ASbGnctApcdJhjfG00/5tW9UqWTTeajOYnII4j8+S7J7Lgmrc4I6gn7FmviLUm7AJJf
	EoO83tQiPE2jYIHkn0SFynN4/zlttNedciIhkUuhghdfcuV5txcvXfI0YKjlrKh41GFSBHCakza
	+7UkbOVsnKz8vMAKx4/qD0DGqJGkgbwmFlJ334O2Xzj4m3FZKGI6QWHGdGt/EuN6SlchXgkbg7/
	Yu2Oe9GXorTdrbsBP38bCcfDmx++eZ4qrshMyoFlr2We256JQI+B9tg1KvxntEA7GglxlGJKzVH
	79LmiglBjF/N+J8rTsrploYP/T4Ktw1lIZagVY3uBn8i9YJCZOBmpQBifZ4m6pvBsSiG3Mg=
X-Google-Smtp-Source: AGHT+IEDLE/nR0t63uvN7glzxWwF/B/tI4cPlMeyOm0g7Ak1FHiS2GDNPo3s87CUx3cKB6LXOsOu4A==
X-Received: by 2002:a05:6a00:448a:b0:726:54f1:d133 with SMTP id d2e1a72fcca58-72fd0c2098amr37757604b3a.12.1738658541386;
        Tue, 04 Feb 2025 00:42:21 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cdce1sm9822069b3a.126.2025.02.04.00.42.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Feb 2025 00:42:21 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc 4/4] RDMA/bnxt_re: Fix the statistics for Gen P7 VF
Date: Tue,  4 Feb 2025 00:21:25 -0800
Message-Id: <1738657285-23968-5-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1738657285-23968-1-git-send-email-selvin.xavier@broadcom.com>
References: <1738657285-23968-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Gen P7 VF support the extended stats and is prevented
by a VF check. Fix the check to issue the FW command
for GenP7 VFs also.

Fixes: 1801d87b3598 ("RDMA/bnxt_re: Support new 5760X P7 devices")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/hw_counters.c | 4 ++--
 drivers/infiniband/hw/bnxt_re/qplib_res.h   | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
index 3ac47f4..f039aef 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
@@ -348,8 +348,8 @@ int bnxt_re_ib_get_hw_stats(struct ib_device *ibdev,
 			goto done;
 		}
 		bnxt_re_copy_err_stats(rdev, stats, err_s);
-		if (_is_ext_stats_supported(rdev->dev_attr->dev_cap_flags) &&
-		    !rdev->is_virtfn) {
+		if (bnxt_ext_stats_supported(rdev->chip_ctx, rdev->dev_attr->dev_cap_flags,
+					     rdev->is_virtfn)) {
 			rc = bnxt_re_get_ext_stat(rdev, stats);
 			if (rc) {
 				clear_bit(BNXT_RE_FLAG_ISSUE_ROCE_STATS,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index be5d907..7119902 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -547,6 +547,14 @@ static inline bool _is_ext_stats_supported(u16 dev_cap_flags)
 		CREQ_QUERY_FUNC_RESP_SB_EXT_STATS;
 }
 
+static inline int bnxt_ext_stats_supported(struct bnxt_qplib_chip_ctx *ctx,
+					   u16 flags, bool virtfn)
+{
+	/* ext stats supported if cap flag is set AND is a PF OR a Thor2 VF */
+	return (_is_ext_stats_supported(flags) &&
+		((virtfn && bnxt_qplib_is_chip_gen_p7(ctx)) || (!virtfn)));
+}
+
 static inline bool _is_hw_retx_supported(u16 dev_cap_flags)
 {
 	return dev_cap_flags &
-- 
2.5.5


