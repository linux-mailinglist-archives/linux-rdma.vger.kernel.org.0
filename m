Return-Path: <linux-rdma+bounces-14520-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A580FC6278B
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 07:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A2C3B225F
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 06:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ED030C37C;
	Mon, 17 Nov 2025 06:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AU6tY/9V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4EC1DE4F1
	for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 06:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763359702; cv=none; b=e/On00kBg2RTCFtXuXAAg+xm7AaChCfiDzEY00DI6Z68jPyv+i/wPsmXFY11DXFzBmsXoK4Yuh27Ojo7HF5eJqHfRpBfgskguNdNL2D6WMSxfdtM8/D2wxcLn+CuE8pBIKGQW4d7uM0uiB+rBGndTfWet8A+aMCQ4nGkcxLgvzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763359702; c=relaxed/simple;
	bh=R2AV+HfS5Kbpfrn1DLFQs1nIYDTEgPBUtXsDOp9g1wM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TIGT7ICj0mrSFVniql3aUVSOKbyMbXuLa5N434Sk2GPcxR2nvlmlgglcGCE1lK+bGqWeyZfSJZGYdvrBli067zmDDR3N9vjm11WsS6N0m64Tt4LM/rWBRnINnN5ihVMHnWsaTRmNEPhET2QgbAyA93yqCgdXzjmCX6/4RVZ5OFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AU6tY/9V; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-9482931b14bso320463539f.1
        for <linux-rdma@vger.kernel.org>; Sun, 16 Nov 2025 22:08:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763359700; x=1763964500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ex7Lum3xqnNfces3C9wgzngN9WAuxNaLpuJCsbdQa0=;
        b=MBwkQkgOU4gObQ9Jz4L/r9VSyyQTXjQQr6hyu6mb1gM9C1OopQnJZQLOyQx2k29axI
         n6wZTh35Pc2NIsezEr7wX7YHchfxZplu35xHJ0m248kuVjEL5o+LBG+6QmTQKOgoj1WQ
         oig2ozeoZAxCtkF1QpTgB+1qy73Zmbsgx9o3PtyXK3AwJd6GCsQfShdCrFWxLUoi3LFd
         IerpuqeFsXgNCvOjeE0L4o5zsJwfGKEV2iBpP/NZn5FHadHGYvQvgS2aFSvhq7Z/vsWT
         eE36AJvMsJiCLUdKEE4869Crs1AJ/OVp8GAtOXXIz3cv8xz0Cy3PkH1i5kSF3MJ+aLqg
         bFBg==
X-Gm-Message-State: AOJu0YwCTOtY/u4gbQdr7bghmcq+9TClQOh8HjH8CdJp3z0RL/JFltHl
	Gl1CaVgwWPe0hUUoEIxOgHq2PrVcGC2KeHzPiz6L1RpzBi0+Zb5BsfUBez8/jYugbJsP4bgfjh5
	FUmKak2x/4PMLvN/wUQoCqIt/FZ84eucRT9dPD9h0PkHIu2vEqWvh8gP94W8xLhBe+GPE0Tml5h
	vLp0ks3Cjbb+Gq/tNfZQyxQNJJ4fQ0J7fvMqWcLQeRHaIajTMuA9E+uqirvz5nnliDT7MVeLhDC
	d2BRF/Tl17I2Z01KXwIeoHcUlKG1A==
X-Gm-Gg: ASbGncs/c+Hz2kb80hrJvk+fvoO5pry4NiyjtuNWHnNlFwlvqJUWKQIvnxVTAIxeO8m
	vc2TtPV2/ygk7hVm7U2n76r+MpbbohW1QznGtfc16ZWPYLyPj+NOKHhu0uiTLee+5fA9a9dvnIW
	A4gUkL2pk9gl2q5bVWNhGC3t7Cqp3G+mAF42v8yQUW59CZs3u2P7LIQUmmEG/zE2eXAC0GVfFF5
	xRK8S424M+QesmT1PrVoa4fxLqgO8rU/jkgFz0PfI9Ppu2lRe1uebEteydcXHuTydVnooh75+aV
	d0BHkWitDQA7ikRD0CjAGhRYZ96EIq5sveAEksNu6+kK66bj4/KluFvUP3VAkzj3eS9SyrUWFGW
	G+Mo4UuZ3Rh6Nib2SWCA1NhkUFWbqLAouCIhcI7SK9mupT8LB/etLT//4GKNmpCIKz++Ko2QvUU
	QuJa5guqfmUMJKF2nVL9ZYTrhjw9du6JfmV6sq1tUJ/yrfo+NJTQ==
X-Google-Smtp-Source: AGHT+IH63T1OTpKjw05fZb4qgXKWM9Ps/yNwNACXvRoD9BnmK12XHzerGycKZZwczoI9lJ1U8xGLuoSAnxz4
X-Received: by 2002:a05:6638:c114:b0:5b7:bf63:9c2b with SMTP id 8926c6da1cb9f-5b7c9d5acefmr8467354173.12.1763359699827;
        Sun, 16 Nov 2025 22:08:19 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5b7bd27fc2fsm753039173.17.2025.11.16.22.08.19
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Nov 2025 22:08:19 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3438744f11bso6778737a91.2
        for <linux-rdma@vger.kernel.org>; Sun, 16 Nov 2025 22:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763359698; x=1763964498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ex7Lum3xqnNfces3C9wgzngN9WAuxNaLpuJCsbdQa0=;
        b=AU6tY/9VKv04D4YrHdlvZxDKA3ftuuyUvllKDCls/y+9HyTINg7lrBXgs/8f7QkYyi
         NrORhbpspVIrNg74mZes49xnRAgNGZPyc9UWweUFVXmy8JEP0iqjvDXTHiHwM5BQWofY
         D/rKSuAd+nlC98tS31uWuUJ0VXit0vIVs4FKg=
X-Received: by 2002:a17:90b:1a8a:b0:341:69e3:785a with SMTP id 98e67ed59e1d1-343f9fdf8efmr14928858a91.16.1763359698100;
        Sun, 16 Nov 2025 22:08:18 -0800 (PST)
X-Received: by 2002:a17:90b:1a8a:b0:341:69e3:785a with SMTP id 98e67ed59e1d1-343f9fdf8efmr14928837a91.16.1763359697688;
        Sun, 16 Nov 2025 22:08:17 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e07bbbd2sm17152109a91.16.2025.11.16.22.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 22:08:17 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next] RDMA/bnxt_re: Fix wrong check for CQ coalesc support
Date: Mon, 17 Nov 2025 11:43:06 +0530
Message-ID: <20251117061306.1140588-1-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Driver is not creating the debugfs hooks for CQ coalesc parameters
because of a wrong check. Fixed the condition check inside
bnxt_re_init_cq_coal_debugfs().

Fixes: cf2749079011 ("RDMA/bnxt_re: Add a debugfs entry for CQE coalescing tuning")
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.c b/drivers/infiniband/hw/bnxt_re/debugfs.c
index d03f5bb0d890..88817c86ae24 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.c
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.c
@@ -454,7 +454,7 @@ static void bnxt_re_init_cq_coal_debugfs(struct bnxt_re_dev *rdev)
 	struct bnxt_re_dbg_cq_coal_params *dbg_cq_coal_params;
 	int i;
 
-	if (_is_cq_coalescing_supported(rdev->dev_attr->dev_cap_flags2))
+	if (!_is_cq_coalescing_supported(rdev->dev_attr->dev_cap_flags2))
 		return;
 
 	dbg_cq_coal_params = kzalloc(sizeof(*dbg_cq_coal_params), GFP_KERNEL);
-- 
2.43.5


