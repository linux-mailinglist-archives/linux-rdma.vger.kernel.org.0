Return-Path: <linux-rdma+bounces-15616-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A81FD2E91B
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 10:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4B213012248
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 09:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527C531B82A;
	Fri, 16 Jan 2026 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GStG4eNg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BCE4C81
	for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768554842; cv=none; b=nt4hJ+dkbfPzwpSVRxcwkaeC5CHF9oCBwg+8hkDx0+o/v2La8Lv3ljYzOcygtGE1ASzcfYI7CqmC+EQSeyeWTpRnLMZHpffnvVh3eMEkDDMlfwdiDTrwbAOD/GsDDjqVlHQQiDZl73+8fQQVWc/lhNI91e09jxRUEmq56dakCVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768554842; c=relaxed/simple;
	bh=ov8clyLfqxNEBvWRpGujN20ZfaTjVz3FzH/hPrH5x0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8wbuXCMRi0UIeMYzvabk8XVUVEm03Le6j//Mhss3vsSzWGPtdCfILg13AHqjQE0yKU35DTcHi4AmNIuBMfV0BMop4AEiBIRAYUFziJTKDxaZ1oVXz47lKtVc3tj+nFCUy+XE628hXOPO8vmAEyx7XXHagy2K+xDoRYD5V1RxPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GStG4eNg; arc=none smtp.client-ip=209.85.221.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-5636274b338so1532043e0c.1
        for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 01:14:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768554839; x=1769159639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5wKTjqNGqwbPWUWBwX0EYSUZ4Cl88mKrjf+1xnIB43M=;
        b=sdR9OX0d/YnxqllwB/mTHnCW9hXTMwKCrOFbbD0n3w7YFHDu1BeogL5onRa1wiiMrV
         lSDTDJ8FbkfLdqD6liksulu7nTEju/NZaDZLa0gwnGsGgvNwZ9yHHdxR/TBIY3cG+Z/y
         e0mDnPJZ84lUZcLqhCR5arIq8qV768jHUg6T6T/jFNrnqN244dZfWrJpR3t83aejCOn7
         FPOc5jFTvJfOwmgHcipPsgVjUuFs+/K1lL4YmuuoAiz6KVJUJjzlFS7OmyWlUw8rQPmQ
         bVWFZgrg2XVMOwCH3cOHt2ZEdMI1r76ODiVD5DO4/6oihdQoFb+LXBVW0gO1v3HRIoue
         Nv0A==
X-Gm-Message-State: AOJu0YwvPT5IUY9ivnEorsgXNX5rf9XYOhPyXRcDqcQzjqdbseVGMjAq
	9+3afce14eXuN3HUYTGYptctxTZzUKoUC2OhUhfCYeVAY76z9jCyMFHvUZzlVlt8MMob1mreerf
	zovzjQB2mUsxF7s3yb5nwGwjitFUISsk7J9l4Ya12fS28PkxRlogiTRbzZ3opunm/CzB/PEIJra
	UEdvrKmJBJLn9s8NNMQ8Izbsr1K+4aQfjSKV+ZJD31MeQMqneLEsj3SMhfRrNvUQqwhhFpwjlUL
	W4Gm56c1zw4IEFu7ewUp+hoUE7JqA==
X-Gm-Gg: AY/fxX4aKE3e2MhA0w74vJLaDNaGvlg0lO64c+KNg4MBAqn3kO81H1REiUiYryDDqLj
	wMnuarVx4Ov1tnWaQ6auNdyY6jmgjwdpujFva01Tfh23jSQ2cI39PMn5zTHaCcHXYXB2Q/VZ/d2
	sH0aRaKR4lhSdCP3k149Zm9o2WYJU7FgxTIIUOdvw6Yx6P8L3p3rcuaUouKY5Kp04TOGc1w+X3e
	F1Sw/WTzcM4o4vy4vaN2uA57EtVrFPEt07WbYcscDkc2nrPn4BQE66eH0GigN4TTTJD/8TVEaNK
	kgjiwTIU22pZnD3LaQSS9VF8aYUa1XXh0NhfYYNY3Cz2/36+aZf9DyXCNgUizfsn6CdX+0D34nC
	dWSWQzBlyWcbRPcCzyHXxaZ0HFBZx87qSGOljUxEOB4PTQmcNcQvzMjSmYJaHrh8CecJU+Dq1CC
	0oFkC8rliAZn7f53SKQVt+qZ2SKsF7uIkw2ntkCGBKH7KTsCe3OYIczIs=
X-Received: by 2002:a05:6122:2676:b0:563:ba2e:91a0 with SMTP id 71dfb90a1353d-563ba2e91d6mr178349e0c.10.1768554839411;
        Fri, 16 Jan 2026 01:13:59 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-563b6fed5e9sm238139e0c.2.2026.01.16.01.13.58
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jan 2026 01:13:59 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34ab8aafd24so2019501a91.0
        for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 01:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768554838; x=1769159638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wKTjqNGqwbPWUWBwX0EYSUZ4Cl88mKrjf+1xnIB43M=;
        b=GStG4eNgiYt/jVSQ4/i8O1BxtrjkFz8x6gfVYOn9er7iKE0kD39cNlBQfbcXYC1c47
         8PRoWT9C/X1CKhwby5v35ey5w4807yeUDkDO9ZalpbNYyxP/BPHjmUtfmFaQQa/9TKKn
         NmgyfgUMnwXQvfxOLFHmCySICiAfKe1iZEEI4=
X-Received: by 2002:a17:90b:4984:b0:34e:6e7d:7e73 with SMTP id 98e67ed59e1d1-352678b93d7mr5632142a91.11.1768554837946;
        Fri, 16 Jan 2026 01:13:57 -0800 (PST)
X-Received: by 2002:a17:90b:4984:b0:34e:6e7d:7e73 with SMTP id 98e67ed59e1d1-352678b93d7mr5632130a91.11.1768554837540;
        Fri, 16 Jan 2026 01:13:57 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352678c6a3dsm4161100a91.13.2026.01.16.01.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 01:13:56 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH rdma-rext 1/4] IB/core: Extend rate limit support for RC QPs
Date: Fri, 16 Jan 2026 14:48:05 +0530
Message-ID: <20260116091808.2028633-2-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260116091808.2028633-1-kalesh-anakkur.purayil@broadcom.com>
References: <20260116091808.2028633-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Broadcom devices supports setting the rate limit while changing
RC QP state from INIT to RTR, RTR to RTS and RTS to RTS.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
---
 drivers/infiniband/core/verbs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 8b56b6b62352..02ebc3e52196 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1537,7 +1537,8 @@ static const struct {
 						 IB_QP_PKEY_INDEX),
 				 [IB_QPT_RC]  = (IB_QP_ALT_PATH			|
 						 IB_QP_ACCESS_FLAGS		|
-						 IB_QP_PKEY_INDEX),
+						 IB_QP_PKEY_INDEX		|
+						 IB_QP_RATE_LIMIT),
 				 [IB_QPT_XRC_INI] = (IB_QP_ALT_PATH		|
 						 IB_QP_ACCESS_FLAGS		|
 						 IB_QP_PKEY_INDEX),
@@ -1585,7 +1586,8 @@ static const struct {
 						 IB_QP_ALT_PATH			|
 						 IB_QP_ACCESS_FLAGS		|
 						 IB_QP_MIN_RNR_TIMER		|
-						 IB_QP_PATH_MIG_STATE),
+						 IB_QP_PATH_MIG_STATE		|
+						 IB_QP_RATE_LIMIT),
 				 [IB_QPT_XRC_INI] = (IB_QP_CUR_STATE		|
 						 IB_QP_ALT_PATH			|
 						 IB_QP_ACCESS_FLAGS		|
@@ -1619,7 +1621,8 @@ static const struct {
 						IB_QP_ACCESS_FLAGS		|
 						IB_QP_ALT_PATH			|
 						IB_QP_PATH_MIG_STATE		|
-						IB_QP_MIN_RNR_TIMER),
+						IB_QP_MIN_RNR_TIMER		|
+						IB_QP_RATE_LIMIT),
 				[IB_QPT_XRC_INI] = (IB_QP_CUR_STATE		|
 						IB_QP_ACCESS_FLAGS		|
 						IB_QP_ALT_PATH			|
-- 
2.43.5


