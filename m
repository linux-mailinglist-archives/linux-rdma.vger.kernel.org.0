Return-Path: <linux-rdma+bounces-3812-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA6992E2D5
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 10:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB251C223D3
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 08:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BCC15445D;
	Thu, 11 Jul 2024 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfXaACPO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D46578283
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2024 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720688217; cv=none; b=FnK6Z7yGU232/6g4I7RH8Y/Nwh70+4W/Hmieg5m2K3X/xnY1eKkrVVIb3jMLyiAUBK+oa09VfJns3JD9U1BtpOOudAmaJUgmQHDfmyE2H7rBk//CTUY4l2o3J2OC5awIqRAcvsPodDpp0N+Y4IDkg9DicgU7z8RqirUQs0CgsAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720688217; c=relaxed/simple;
	bh=RAlC/K9MNXFoVV9z8ugwZBxqdvLS/All/R6iStmALYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GuwzBnZI17N3HPJfk6ZgNWApWQxr2HhAl34mmue+ZqEuiDoUDY7HgX/QQmDxXrVxDHPV4W2oZY21ZsLBQGLwj8Lra69ZbEVNbNN72O5eI1ncLk433Uv10bmMw8aeEx4JcjfxML1kw0/POIme5SecSTDP2IDl3PUTrs2w9MDVn9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfXaACPO; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5c66de0c24bso375165eaf.1
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2024 01:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720688215; x=1721293015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mD0fmukApTdaIgPJAuvTs6rc/Zu4zhwWGUTRQ6VSq+s=;
        b=JfXaACPO6FRDFz9tOy+QvLZ1gZSXaKRtPiz544NNcQwnsvSdNUtu8mt+ZYpbtpOdFj
         2VGEoThedE1ckhpzZfbA4zP5VZSJEVTbyr99EDXM+ypBSUOZpal5dyJtLjE29kJ+CFIO
         byBGlA2nBn6JuzLUDq822g1wBtKuwelFeGokqp8BdMm8AGraV9VDtC+h+YLeWvr4L+Ax
         z6e6z0vP+pAd388dglOi8HBz+dFvMPxb2LNRgD59uPKwAn5aILMAXFVPmXDxJCTaEr5g
         RIXuWtZlSRbfduIQ3WLnmNZlJwrUwwxDORN/g0SVFEc5GaA05sVWD720QWWTZQ1Fnc8f
         rMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720688215; x=1721293015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mD0fmukApTdaIgPJAuvTs6rc/Zu4zhwWGUTRQ6VSq+s=;
        b=s3agFtJyRl/bAQ5MvV6uPl56RzyPBX1a+15Pm+C+8iqTu0f8UiXXEv+efiu6spZcHS
         wL615AJBIQS8spIcga4jtxalzPbDsrSaqniwf2pUViGBI0/Zn/W3Kq2/1TDPUmKozb2u
         /X9PkpOJk04sm0r0ZpljNDdNEcEph3IDBHdTKX0zXIGpdHmZnFVURIzPxjVLVMF6g6Pt
         koc7frbLLH5lUzlXZXWUkfGjTWpH+i5+bPdfwAAVRWNnz/JrO4wEy6463dxcL6KefnwD
         uu0yPmUuq+HJRcF9qtk0g9VDuAS4EuCVR2jil8HasW5SORKxqkDoeunW+kGBx7XCo5PT
         YDDA==
X-Gm-Message-State: AOJu0YwlBa/fb/t3neB7TRRN3FPXOQh/Wsqn55i9hUuA5QXfs5wKkGqY
	raS2Eb1eyBETakI46YsnICB2XMko4RBufKLO870h7gew5MdmNPuObCTDSQ==
X-Google-Smtp-Source: AGHT+IEIkyni+UAzbTA6o5jYRKwvg4JOe5MAhJtJFtHPjPlLh1qHewfo5g065tMCEj7BJLmcSmPNiw==
X-Received: by 2002:a05:6359:7b13:b0:1aa:aec5:674b with SMTP id e5c5f4694b2df-1aade2520f7mr604526055d.29.1720688215466;
        Thu, 11 Jul 2024 01:56:55 -0700 (PDT)
Received: from FLYINGPENG-MB1.tencent.com ([103.7.29.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d667ecd9fsm3385693a12.72.2024.07.11.01.56.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jul 2024 01:56:54 -0700 (PDT)
From: flyingpenghao@gmail.com
X-Google-Original-From: flyingpeng@tencent.com
To: gg@ziepe.ca,
	nathan@kernel.org
Cc: linux-rdma@vger.kernel.org,
	Peng Hao <flyingpeng@tencent.com>
Subject: [PATCH v3]  infiniband/hw/ocrdma: make function ocrdma_add_stat as noinline_for_stack
Date: Thu, 11 Jul 2024 16:56:47 +0800
Message-Id: <20240711085647.81004-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peng Hao <flyingpeng@tencent.com>

clang report:
drivers/infiniband/hw/ocrdma/ocrdma_stats.c:686:16: error: stack frame size (20664) exceeds limit (2048) in 'ocrdma_dbgfs_ops_read' [-Werror,-Wframe-larger-than]
static ssize_t ocrdma_dbgfs_ops_read(struct file *filp, char __user *buffer,
               ^

A 128-byte array is defined in ocrdma_add_stat and is called multiple times
by multiple functions (up to dozens of times), which results in a large amount
of stack space being accumulated in ocrdma_dbgfs_ops_read. mark it as noinline_for_stack
to prevent it from spreading to ocrdma_dbgfs_ops_read's stack size.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
index 5f831e3bdbad..0b26c4e6de53 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
@@ -46,7 +46,7 @@
 
 static struct dentry *ocrdma_dbgfs_dir;
 
-static int ocrdma_add_stat(char *start, char *pcur,
+static noinline_for_stack int ocrdma_add_stat(char *start, char *pcur,
 				char *name, u64 count)
 {
 	char buff[128] = {0};
-- 
2.27.0


