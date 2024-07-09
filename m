Return-Path: <linux-rdma+bounces-3764-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E84A192B5EE
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 12:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2510A1C224C7
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 10:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38024156967;
	Tue,  9 Jul 2024 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Biz2bAWs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9A7157A4D
	for <linux-rdma@vger.kernel.org>; Tue,  9 Jul 2024 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720522372; cv=none; b=kv7IOWls+8u15OQdRXbaBSGeHgISjQ2lagpZDr8ZxyMXREWtVukmAyFJ2rY3Asug2TqnkLvREDjtia7SPvYQNrFx5OGi9tnPQIm9YvY/LbTw5JyoT5IMzbdYCMG96QggjsWotzKpIdXelsnKMjQm0GBffYS38PTpqfrQyOqiKkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720522372; c=relaxed/simple;
	bh=Rd9hVZq5DolwLgKikKzdOrknCdl+c6oagNy6elsstFo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jukw3jiRuNmHQSuZQX4eU8dPF97SA/qSILMKLI3Gbm2zcS6RisSldGGyKBzAJO32H4GKxYC6P+KMoPZXG5r8XllQb1NF9EAmNyXiE5Gc+hd436tyMWGsdxhTuOiGgz/nsLQWiD64+aHNSh46tDV+PLif0B/VeEI6TkFcM1xcUqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Biz2bAWs; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d6301e7279so3326462b6e.3
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jul 2024 03:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720522370; x=1721127170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v8z/ievk+s2nVOZ6wuDit8mxRL/tYs8JyALuKM0K1iE=;
        b=Biz2bAWs8FmnSPvYYgAO53J40jGYxBRep+c1nZcN/zr8A6kTz5gg3h2g2WSOEAuH3u
         Do3TFcopcM4DjdvJ25USR3m10MS1f96Gfu2/iDmXXREnUpLQB3hW+YmWLfbl/eqeoWX6
         kP0kAfLVsTP0bzmxiIyxVFWM5yMutx5jCeyUB8otHTo3KKHzDg6JzpDgxXeOAX/sXZQQ
         cWzi/qUnf5TvO7ZaqCN6MXAvE+2wHwl7X6hHHksVzdSFhLxNUZRNBQtAn/MNnNlpRN2t
         HpQHSxxeUExafBwOp0ovDQIbOsVeD5DOnSmGP7+8E9JM8Ih2ZBciq0E4wQlAml/FrLk2
         Rddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720522370; x=1721127170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8z/ievk+s2nVOZ6wuDit8mxRL/tYs8JyALuKM0K1iE=;
        b=RzdxEwGIQ4RHWcbASogz47rWVOCTE+yoSVN4RmYOAKSe2+/A3gOpT7Z6ZPwviy6f/z
         RnMKuz+Plnbtl9wnhwrXcKVmhlRC8TcY+pRXtBmplS87pyc5F7w5SPMS+182nJZ+8QAs
         t92NUS+jow/492NRL7kEUV7ZVgtEG8I147XgMtvSa/I+1rdBGcRbgd8W3tDhvotnE7EV
         SyZOfH+hnwVr/Amwdkdn1gRKep7CUEv1C9WeZgKbvv+9+lRCqlYnVBttRhVe2KlseES5
         4JMMWzExrBJfMESH8359G1NfVp16mSZgpAdNBYo20NKk58ji6zkXdaL/Qx+uXmaCfdYH
         bi8Q==
X-Gm-Message-State: AOJu0YxAKe7xtgRiPlXMTPsh50TBziqyqoHJm9qsFix2qljqAhvBm1cW
	CaI6mA6fKoPUBGXkNXpbebL+Hh2esV6QKRAebCgJGL+guGvdBugaKpewsQ==
X-Google-Smtp-Source: AGHT+IGFBNlD6WMEeKffZjc4jWP/Jiieo9P5GOHKV3vHtIl/7pyWmKKLDtYwoVIlX3Zt02PjM41+Uw==
X-Received: by 2002:a05:6808:1312:b0:3d9:243a:7ae8 with SMTP id 5614622812f47-3d93c08c8cfmr1926915b6e.39.1720522369589;
        Tue, 09 Jul 2024 03:52:49 -0700 (PDT)
Received: from FLYINGPENG-MB1.tencent.com ([103.7.29.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d621c6300sm1202980a12.51.2024.07.09.03.52.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Jul 2024 03:52:48 -0700 (PDT)
From: flyingpenghao@gmail.com
X-Google-Original-From: flyingpeng@tencent.com
To: gg@ziepe.ca,
	nathan@kernel.org
Cc: linux-rdma@vger.kernel.org,
	Peng Hao <flyingpeng@tencent.com>
Subject: [PATCH]   infiniband/hw/ocrdma: increase frame warning limit in verifier when using KASAN or KCSAN
Date: Tue,  9 Jul 2024 18:52:42 +0800
Message-Id: <20240709105242.63299-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peng Hao <flyingpeng@tencent.com>

When building kernel with clang, which will typically
have sanitizers enabled, there is a warning about a large stack frame.

drivers/infiniband/hw/ocrdma/ocrdma_stats.c:686:16: error: stack frame size (20664) exceeds limit (8192) in 'ocrdma_dbgfs_ops_read' [-Werror,-Wframe-larger-than]
static ssize_t ocrdma_dbgfs_ops_read(struct file *filp, char __user *buffer,
               ^

Increase the frame size by 20% to set.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 drivers/infiniband/hw/ocrdma/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/hw/ocrdma/Makefile b/drivers/infiniband/hw/ocrdma/Makefile
index 14fba95021d8..a1e9fcc04751 100644
--- a/drivers/infiniband/hw/ocrdma/Makefile
+++ b/drivers/infiniband/hw/ocrdma/Makefile
@@ -3,4 +3,10 @@ ccflags-y := -I $(srctree)/drivers/net/ethernet/emulex/benet
 
 obj-$(CONFIG_INFINIBAND_OCRDMA)	+= ocrdma.o
 
+ifneq ($(CONFIG_FRAME_WARN),0)
+ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
+CFLAGS_ocrdma_stats.o = -Wframe-larger-than=22664
+endif
+endif
+
 ocrdma-y :=	ocrdma_main.o ocrdma_verbs.o ocrdma_hw.o ocrdma_ah.o ocrdma_stats.o
-- 
2.27.0


