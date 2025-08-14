Return-Path: <linux-rdma+bounces-12760-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B4BB26411
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 13:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A04E17DCCA
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 11:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A369929BDA9;
	Thu, 14 Aug 2025 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Uvhgk8w6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7122727FC
	for <linux-rdma@vger.kernel.org>; Thu, 14 Aug 2025 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170415; cv=none; b=b5989CBcb1/PklaOr7v1WqoM4caMKIvwP7LEOGtZ3be11lGaF3EARfOj3QYC/+b+/2oJL4ysX8sL5YVgGfptRefzRdhaF229RcoJ3O8/s0d8vFK1evA7vguSyUHIihHSgJ2yj38HMwo/jQDb+BdqSoLJYnhG5ElPIqSECFtcOWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170415; c=relaxed/simple;
	bh=8kSRrvB0a7afVqU8smtoTYoeIoMgQQJUfanoTJYsPTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKX8RL7r+aq2MxoMBu8+TKyvg033l+/nZIegRoNXvuuTnIrzBsXYICIfeGWmLWdUIAYH0k3rMXCW5lmTn5NA8hK4GejQCrzpiRqTVZNp65Az6Bck8VbM2xGADp5xRVPOT372EhsF+zE6jaSatWYinRjzND6aA1dnL6ohnPq9qL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Uvhgk8w6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24457f47492so5186485ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 14 Aug 2025 04:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755170413; x=1755775213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynrXLoYx5QTWw4ssDF6sGfj29BZIgOS/ocLxOyh5Y3w=;
        b=Uvhgk8w6IpZsaHR+no4FSgQ8sjtzFb2EzV19So9tRkzcuWTcy+ThAN9ZrtMm2AzXy0
         +FPs6O4AyRLJgrpltJl23BQ3AuImrDKTfFt5dvwzL5n6o1zHJ2dN9cD7nx8kwAnNWW8I
         UoPXArOKVRB9iYfY3yHW3Eg8LaNbcaaf80Wcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755170413; x=1755775213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynrXLoYx5QTWw4ssDF6sGfj29BZIgOS/ocLxOyh5Y3w=;
        b=n38bYMGK+J/G34DwsUhZyJ3yvCPvwpBFxuT08/QDG0oo+VEf/+oJmNEHfgKmw3gWYG
         4UnTR0A0e0apyM/U3/HKjzAWW0szcGLbiQsJXVcP2IIkfs5LeCzpbgByl1gCLAjjX7n7
         Ct2lN2pozCFZ7otWnTzg+PcvjVzftlsSRYI3DK2As92epn8pKeT2p4WCQBlzVecZqhbK
         GiuLd/MNlI5Qi0QeGbVWjhrly9XMsGwqgImgp1HjDFZG4OiejwzWG2g+biebjrTh8r1S
         A2r+GoIqGO/7wBBjd1plFqt3jUxY1ukvj35/6RjL29obOgw7O/gLwijmGfBb+km86+si
         /8HQ==
X-Gm-Message-State: AOJu0YymUpIz252nVPGX/ZjKhzwuJlMBA6rvl99swZhIrQefT2AeQ9Bw
	DVApch4XeAnjjUnR4wC3cJBl6WURhOO7yHii6FBCc7o8SHJJU5Bv/J8M/Ya4JgDQdA==
X-Gm-Gg: ASbGncukF8Iab5TZH3/EBdSkfEmKeRfLrxqks+D3DapnMWw5cu889VTGABUuI1X7Z/r
	VqB1MNxKRndN0vjPlxFwxoEFESVoNYQqkS9JDNa+8DlRPFdU6tPqfVU5aFhEawlU9D5QSG1LFtg
	aU2SJCaTxOt0c5fijihCBqpYG9S/8pJJsuez5OjVhYkZvzP+5mi7X7eyNtdkCmJduHzwCk6y/je
	hlOZEgt1uvJwfZaXAiWcfteMUM+q1df+yuR1qhcpIJePZceOn1/m4M+KrYwjIdtLuGNebUK26Ip
	R61oHelLs1PKZxvoDvmfBGvUuNN6JIMp92B7M6KtBFXOKJ0wrx7PvbyqdLWmBBowQKFkUO3h+BW
	XnHyLbtJ+zWOHI1AhFmLxICOOelrRxAtirSqd1QfnydMndGwsJhpSb3ED8LKyCebjxeOidvSLvl
	hMdK8rQrwfARF27Ggbh5wnlhNi7+vVQg==
X-Google-Smtp-Source: AGHT+IFk777WeQ+zmxCpFP7J6qejGm2fRQ0JzcRubTPfJGbDdOB+1JYl7vxwCfYp7ynJMlMGZ971dw==
X-Received: by 2002:a17:902:c94b:b0:242:2cad:2f8 with SMTP id d9443c01a7336-24458518b80mr43617885ad.22.1755170413444;
        Thu, 14 Aug 2025 04:20:13 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f21c65sm352415175ad.73.2025.08.14.04.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:20:13 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next 8/9] RDMA/bnxt_re: Delete always true SGID table check
Date: Thu, 14 Aug 2025 16:55:54 +0530
Message-ID: <20250814112555.221665-9-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250814112555.221665-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250814112555.221665-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "sgid_tbl" inside "rdev->qplib_res" is a static memory.
Hence, the check always return true.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 98bc8b6290f1..195a9ba6f65d 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -375,7 +375,7 @@ int bnxt_re_del_gid(const struct ib_gid_attr *attr, void **context)
 	if (!ctx)
 		return -EINVAL;
 
-	if (sgid_tbl && sgid_tbl->active) {
+	if (sgid_tbl->active) {
 		if (ctx->idx >= sgid_tbl->max)
 			return -EINVAL;
 		gid_to_del = &sgid_tbl->tbl[ctx->idx].gid;
-- 
2.43.5


