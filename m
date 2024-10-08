Return-Path: <linux-rdma+bounces-5296-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E6A994215
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 10:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CFC290B57
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 08:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFFB1EABC4;
	Tue,  8 Oct 2024 08:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UkAgWJmA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B0F1EABCA
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374566; cv=none; b=m4azAMqtUVXcOx3PXrc3F3tGKValoq9DXTPzWjTy7DsWj6zbxb8x/lapL2iZneI85L4y8n8FA/KlCxo/c5JSbDht1rnDRf7J4vymOhCHCMb3GeD4vRDbcVQu6OAQ3hv+vQmbKJvic/jrV7dLomDejsULLwUAoarrAJrx5NfXBm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374566; c=relaxed/simple;
	bh=p0Vuf8x9HnR2i6qSJvHNXYbQ4h47x3HbM7tF8vY9XKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Tv8XdP+bMRv/Qf/vqi1IQ4ePKDukQluLvcvSe0k7xRmRrkbyNRoPfAv1MLKJk0083abjaFUtzJBpCavScGK2Gf/fxdqUDzICzXBhPA78SPzpiEZKzdJC/kpqdI/tpCsr3RsyB3pN8EXn744gaN/7qzJxX/pRWkZgcW8LXWYKZDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UkAgWJmA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b6c311f62so46454425ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2024 01:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728374564; x=1728979364; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8gQESwiKbsg3d8SZLPLfCVF8FKFvHGjRVR8DWlwfdtU=;
        b=UkAgWJmA/dKfSbhz5WFtOuPV0o47eb+fluwJVSaKHJdr+ZlooD/QbBdtQUXm72q95a
         nJfbWQ5FP6GFIMHt07bTG9R4OUEStQokfc0x12DjX3aJWWcGn1x/DBKGRF78iSKPA/dy
         UOlCoRnVfl5shWw3UdmPI+3wH0G88f1eiewnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728374564; x=1728979364;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gQESwiKbsg3d8SZLPLfCVF8FKFvHGjRVR8DWlwfdtU=;
        b=rDEx/XvYCoCwC8DUtgaPV5yHhEWjiNBSA4Qpn+xy6Y4egUuZP/2tMh0PYbGCZe223J
         zXTQThLaunyOx47tngKzOxVS2O6DLSXY/cGpkgy4s6uf5ZTBidauWQFjKAwBW3tWGnDP
         cGlo0lIGqik93v84wlx/QtDvJsdMKSf5PBSlu5AA94jE6O3I0t3teULTVhXsyhrmeNGE
         JpSfjkN+aIxms6lt/MGNjSQX4U+/Oy6gRvKkIYfTVmk/l6QNN0y3dQ0ZSmP04Z+4o4eW
         Rlcb0pKQkr5SDICE8R7ORzuO8YpzkajJHq3JY+Nzt9WY86iji9n4FRbcuHJMxp/KF2jV
         5jqQ==
X-Gm-Message-State: AOJu0YzVyjixAIH4AyIDLNTZ/t6nqW6nqQp2sLrvI7HeKV1+Nko5cA4P
	RIjo2SwyktzJNJod5SycKJp7QGnPdBtmnvo1s5t6r+ZYDb5QBvMU2FN+XSQ2fTnelvj+YHIIvUh
	s1w==
X-Google-Smtp-Source: AGHT+IGvrnD+EmIMjnl8jyLU1rinL9RBcdChSQc7n9YH3YGpeC7sGn10E+SeRCGXRq+AguZ7gcXm4g==
X-Received: by 2002:a17:902:e745:b0:20b:c1e4:2d70 with SMTP id d9443c01a7336-20bfe294c52mr223138335ad.23.1728374564075;
        Tue, 08 Oct 2024 01:02:44 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1396d547sm50339915ad.223.2024.10.08.01.02.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2024 01:02:43 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc 02/10] RDMA/bnxt_re: Fix out of bound check
Date: Tue,  8 Oct 2024 00:41:34 -0700
Message-Id: <1728373302-19530-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1728373302-19530-1-git-send-email-selvin.xavier@broadcom.com>
References: <1728373302-19530-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Driver exports pacing stats only on GenP5 and P7 adapters. But while
parsing the pacing stats, driver has a check for "rdev->dbr_pacing".
This caused a trace when KASAN is enabled.

BUG: KASAN: slab-out-of-bounds in bnxt_re_get_hw_stats+0x2b6a/0x2e00 [bnxt_re]
Write of size 8 at addr ffff8885942a6340 by task modprobe/4809

Fixes: 8b6573ff3420 ("bnxt_re: Update the debug counters for doorbell pacing")
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/hw_counters.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
index 128651c..1e63f80 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
@@ -366,7 +366,7 @@ int bnxt_re_ib_get_hw_stats(struct ib_device *ibdev,
 				goto done;
 			}
 		}
-		if (rdev->pacing.dbr_pacing)
+		if (rdev->pacing.dbr_pacing && bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx))
 			bnxt_re_copy_db_pacing_stats(rdev, stats);
 	}
 
-- 
2.5.5


