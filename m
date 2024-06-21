Return-Path: <linux-rdma+bounces-3392-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5C8911A26
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 07:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094731F224D7
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 05:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B3316EC1C;
	Fri, 21 Jun 2024 05:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oi13HSaT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA3F16EBF5;
	Fri, 21 Jun 2024 05:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718946369; cv=none; b=NUSk228y/zvgfkyx+J724NOVRwKgaNb1rkZ6hxYfQ/qC48vqANu28rwPoVeYrEzcmt3uYU50A0AnAbDT8rtBM19RLBDAUXqhyfKZ3KJLmRkWgdTQukXqRjxQu/GdLaWHZJRbEsrsV6b3jHEc/mHd3hDdO3umHwZO0Ak16oi5RL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718946369; c=relaxed/simple;
	bh=cI06cWMeiiaaHvVrivHUrUMAP27szVAGIwpicbm6Rjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XzZODQe7pYvHGc1PXaoZGGnKKI+Avg6lroQl6oKvDvaG65Go2Yb8fGssfe7tLGYHlNx0icApj/y2+tiB9VDKvVQ/ZNpmFjneW9Sn2mWt8EdQNummdQt/eM9+wxBlySQkkPKpZRNhsbjFzoT2BC3GAUDzFbNp8a2BFK4nct8uPW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oi13HSaT; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5c1bf0649a5so795469eaf.3;
        Thu, 20 Jun 2024 22:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718946367; x=1719551167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Duz+R7OD5yozyO0xOdsWZmjZsXtc7sydmF+n4fo7yxk=;
        b=Oi13HSaTOmu7MXJGesAKZblZSYMeUViXGOtGHHE9Bd5FUl1Gnay0Yu4COFGweYO7ck
         JusiDnq7yeXymvveSfBZt599aK8vpxApebhovn1ixgdu7u9bSI8TvDkQ12dgUPKKCWwf
         S1c1atuhyPQPjL7YZDa7/9sGZ991K72sW9JUH7ZzsJeiPywohROHz8/jLiq7j4vdzcHr
         /FH5L2XIP5HOgOhgjJR8t80rWbsfaQjD8fIKDgk7B3Y4XnRp2N5gk5mBeXeOP8XC+4qN
         6S4hA9DK0PtvUe0xhv8rn/Kqgup91KnonucW5XAgr3HON8y8KB2rvV1ykZ8JKvdVnkHY
         gFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718946367; x=1719551167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Duz+R7OD5yozyO0xOdsWZmjZsXtc7sydmF+n4fo7yxk=;
        b=mHVRmD/P7YxgLklci4ZcmGmnzniLGwQD4rWsMP/sWuzxyyZNDMkPKJcc27PL3s7E6Y
         mmTRPvxNs2aTcyobt5eVYbDqtpE4fdtgyCUxG+fGNNhNiGZSqL/1wP019fgv3TQTjjJz
         1vUgdDrzQZUISmBE7yRw0lmCUx40ZBchmlKtxC/aP2ZIpdfWqjgWIQwKRi0/W6yueRij
         zsaHrGI+FYkthTb1C60Y6zoXxLsb0QvywL+DvnO4D0UfD8fS6OfPmY7x9iK8U3yt5f+a
         jxORjjQy63D5zRHmDruOdqKpiyuLIOjFEvXTW3knijaDaryLBpU39ocKrNBP0IAUUjlq
         UhRg==
X-Forwarded-Encrypted: i=1; AJvYcCVQZiOWmyB5BxHsTpSoSVHt250j+P+49GaUrzEox2VzfddpUzlTGTMWy+ZIJoX9DRye7ma8N3WSWcW9IycZL2ie9viDMgQ3Q1Ny/3qJAw0Ndh2bnPjEj/Uj/mLyOtK4lyVQM0NSNMcFL41/c0uw5NSaeQBiBn7DS3ydVX+EuysIog==
X-Gm-Message-State: AOJu0YyolaxPmrWgLqLOTtjMQinYw9DlRx8XZSDq3U7+1tSLgNfkzxIm
	70ZmFEAARx8/yjaqrnw4m10Qszd0g1yqPo2acjIWPEcnK+i0x5L+
X-Google-Smtp-Source: AGHT+IGT9uXfh3BNKu1qNO8/2xY3x6EuWChfPz49EjQAep0tUJhHE+dOOG2sFET4fGBrowHmzjImpA==
X-Received: by 2002:a05:6870:16:b0:23c:1f34:730 with SMTP id 586e51a60fabf-25c94d7278cmr6774170fac.49.1718946367326;
        Thu, 20 Jun 2024 22:06:07 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716c950d71asm371308a12.62.2024.06.20.22.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 22:06:06 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: kuba@kernel.org,
	Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jes@trained-monkey.org,
	kda@linux-powerpc.org,
	cai.huoqing@linux.dev,
	dougmill@linux.ibm.com,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com,
	nnac123@linux.ibm.com,
	tlfalcon@linux.ibm.com,
	cooldavid@cooldavid.org,
	marcin.s.wojtas@gmail.com,
	mlindner@marvell.com,
	stephen@networkplumber.org,
	borisp@nvidia.com,
	bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com,
	louis.peens@corigine.com,
	richardcochran@gmail.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acenic@sunsite.dk,
	linux-net-drivers@amd.com,
	Allen Pais <allen.lkml@gmail.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 15/15] net: mtk-wed: Convert tasklet API to new bottom half workqueue mechanism
Date: Thu, 20 Jun 2024 22:05:25 -0700
Message-Id: <20240621050525.3720069-16-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621050525.3720069-1-allen.lkml@gmail.com>
References: <20240621050525.3720069-1-allen.lkml@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate tasklet APIs to the new bottom half workqueue mechanism. It
replaces all occurrences of tasklet usage with the appropriate workqueue
APIs throughout the mtk-wed driver. This transition ensures compatibility
with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_wed_wo.c | 12 ++++++------
 drivers/net/ethernet/mediatek/mtk_wed_wo.h |  3 ++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed_wo.c b/drivers/net/ethernet/mediatek/mtk_wed_wo.c
index 7063c78bd35f..acca9ec67fcf 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_wo.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_wo.c
@@ -71,7 +71,7 @@ static void
 mtk_wed_wo_irq_enable(struct mtk_wed_wo *wo, u32 mask)
 {
 	mtk_wed_wo_set_isr_mask(wo, 0, mask, false);
-	tasklet_schedule(&wo->mmio.irq_tasklet);
+	queue_work(system_bh_wq, &wo->mmio.irq_bh_work);
 }
 
 static void
@@ -227,14 +227,14 @@ mtk_wed_wo_irq_handler(int irq, void *data)
 	struct mtk_wed_wo *wo = data;
 
 	mtk_wed_wo_set_isr(wo, 0);
-	tasklet_schedule(&wo->mmio.irq_tasklet);
+	queue_work(system_bh_wq, &wo->mmio.irq_bh_work);
 
 	return IRQ_HANDLED;
 }
 
-static void mtk_wed_wo_irq_tasklet(struct tasklet_struct *t)
+static void mtk_wed_wo_irq_bh_work(struct work_struct *work)
 {
-	struct mtk_wed_wo *wo = from_tasklet(wo, t, mmio.irq_tasklet);
+	struct mtk_wed_wo *wo = from_work(wo, work, mmio.irq_bh_work);
 	u32 intr, mask;
 
 	/* disable interrupts */
@@ -395,7 +395,7 @@ mtk_wed_wo_hardware_init(struct mtk_wed_wo *wo)
 	wo->mmio.irq = irq_of_parse_and_map(np, 0);
 	wo->mmio.irq_mask = MTK_WED_WO_ALL_INT_MASK;
 	spin_lock_init(&wo->mmio.lock);
-	tasklet_setup(&wo->mmio.irq_tasklet, mtk_wed_wo_irq_tasklet);
+	INIT_WORK(&wo->mmio.irq_bh_work, mtk_wed_wo_irq_bh_work);
 
 	ret = devm_request_irq(wo->hw->dev, wo->mmio.irq,
 			       mtk_wed_wo_irq_handler, IRQF_TRIGGER_HIGH,
@@ -449,7 +449,7 @@ mtk_wed_wo_hw_deinit(struct mtk_wed_wo *wo)
 	/* disable interrupts */
 	mtk_wed_wo_set_isr(wo, 0);
 
-	tasklet_disable(&wo->mmio.irq_tasklet);
+	disable_work_sync(&wo->mmio.irq_bh_work);
 
 	disable_irq(wo->mmio.irq);
 	devm_free_irq(wo->hw->dev, wo->mmio.irq, wo);
diff --git a/drivers/net/ethernet/mediatek/mtk_wed_wo.h b/drivers/net/ethernet/mediatek/mtk_wed_wo.h
index 87a67fa3868d..50d619fa213a 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_wo.h
+++ b/drivers/net/ethernet/mediatek/mtk_wed_wo.h
@@ -6,6 +6,7 @@
 
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
+#include <linux/workqueue.h>
 
 struct mtk_wed_hw;
 
@@ -247,7 +248,7 @@ struct mtk_wed_wo {
 		struct regmap *regs;
 
 		spinlock_t lock;
-		struct tasklet_struct irq_tasklet;
+		struct work_struct irq_bh_work;
 		int irq;
 		u32 irq_mask;
 	} mmio;
-- 
2.34.1


