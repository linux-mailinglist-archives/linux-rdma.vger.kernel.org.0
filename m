Return-Path: <linux-rdma+bounces-3975-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EC193BCFD
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 09:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58EE1F2237B
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 07:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D31816C867;
	Thu, 25 Jul 2024 07:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fL844Br7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B34F4428
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2024 07:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721891848; cv=none; b=frFqPKVKtf2Fsfu+rXuMeL2TfPV6hVUMNn/BZiqhaITpQfyhxg3DWOUoMyCzjT9MTIdWQfir3kCiBiq9kCr6AH8JYUKnm9E7y5awM10o87HHkFjnImT56vn+wabIghaBPJE5D1RwTm3NlTt+cDYBJXUBhymYjIqUiz3VVRidBwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721891848; c=relaxed/simple;
	bh=uFNFM8i9+NpOIcVydx0T4yR3xkAC23Ay7rJBpm79rBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QOA2xuy7iPrK9sgj1wTE7djQGQ2E5sN2MUQl1uKmxj6zvKGVD2RVgh3PCRHOs2DOq7BkiKSOZSuBMi45CQJqEa3WBtg7STBv0CfY0pJLsC32sxvlEBwjhNvsAoFhGn0DFvlHOAWVGKd/WIGKxBixnrVGMC/CV7fUkgNdAIHT3ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fL844Br7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc491f9b55so5490965ad.3
        for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2024 00:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721891846; x=1722496646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fIjMr7Sqml4CyoZDqjS7IDgIW58H6bCMxiYK67geGrA=;
        b=fL844Br7BclpLE6IUpLAaWClGCwcHtmW2z3sgMLWDLrakKUA69iVnecCxT+OLsZidv
         Eq44fQs0JTp6B591n4PlfH6r1Kt7Lb6Qu7ZPW1o0iTN0Jh0oifZj+dFB1lITeIodWvoi
         tpBUs088pzCLMu2ZNNYI9WVHH9Do2cd8ZZig7KGpgMGkwL9Xk/Q3b4IWg36J5MCYxRwF
         DrnITfs48/tVwxsU/+nVeAFBRHcHAuO18+32UNafqMtwNNZK5kfTQ/1ICvquVeKT5y/A
         Z/R6RzXTyDqL7ziUjjHXd1bj1C+/Tnc7TfmMd+TSFoPB2d1vhdrY6azqdCr4Vy6KjouM
         ywzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721891846; x=1722496646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fIjMr7Sqml4CyoZDqjS7IDgIW58H6bCMxiYK67geGrA=;
        b=iQ0t2z6cxDWWuqADyHRGfjHrOJ2HO2aqnCJ9VMdW012cb5kftkDN55yBhFIYtxU6Ap
         sgxf1JDZytlplflbUl43zdnu01l2wANCGw5E/xa1lV7XwBtQsby0ywsRtf0FMiKF2ehH
         sYdlmLROABQ9TSmYDHWAgX8iK2bjCxtunzXg5jZGEnPY8ZuCFBzxJToMpKJIFXVcwcuA
         2DMfNPwfTd7116xDfgR9frIYb7FCuQCAgDHV/sRSVsh+9FYClS6+xNWhXCf4YpMMNMB+
         YkbNk7vC8uXYg7OwGO7HS/iIsLILOJ28O2zUIWfFbZICHGSRFCfPJcyu1FQpFniYpMWW
         0R+Q==
X-Gm-Message-State: AOJu0YwFgFSGspfQBfGwnYEft1bU3yNIOT2ebHMiuqHdFX9GE62Gwhci
	LdFBkW/7PKGDTvjeRnLhGOoDhfQQStnMfboygL3d8cel2T15r66dTbv1cg==
X-Google-Smtp-Source: AGHT+IE55jg1mDlxM9hShXItSZGy4QkCMwEvtPp+OsoqIeE8Yam3kX11q0UDu35SMlYfAZAweTARwg==
X-Received: by 2002:a17:902:c40d:b0:1f6:f0fe:6cc9 with SMTP id d9443c01a7336-1fed92ca0b3mr10402235ad.54.1721891845674;
        Thu, 25 Jul 2024 00:17:25 -0700 (PDT)
Received: from FLYINGPENG-MB1.tencent.com ([103.7.29.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fa468bsm7132305ad.255.2024.07.25.00.17.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jul 2024 00:17:25 -0700 (PDT)
From: flyingpenghao@gmail.com
X-Google-Original-From: flyingpeng@tencent.com
To: dennis.dalessandro@cornelisnetworks.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	Peng Hao <flyingpeng@tencent.com>
Subject: [PATCH]   infiniband/hw/hfi1/tid_rdma: use kmalloc_array_node()
Date: Thu, 25 Jul 2024 15:17:16 +0800
Message-Id: <20240725071716.26136-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peng Hao <flyingpeng@tencent.com>

kmalloc_array_node() is a NUMA-aware version of kmalloc_array that
has overflow checking and can be used as a replacement for kmalloc_node.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 drivers/infiniband/hw/hfi1/tid_rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
index c465966a1d9c..6b1921f6280b 100644
--- a/drivers/infiniband/hw/hfi1/tid_rdma.c
+++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
@@ -1636,7 +1636,7 @@ static int hfi1_kern_exp_rcv_alloc_flows(struct tid_rdma_request *req,
 
 	if (likely(req->flows))
 		return 0;
-	flows = kmalloc_node(MAX_FLOWS * sizeof(*flows), gfp,
+	flows = kmalloc_array_node(MAX_FLOWS, sizeof(*flows), gfp,
 			     req->rcd->numa_id);
 	if (!flows)
 		return -ENOMEM;
-- 
2.27.0


