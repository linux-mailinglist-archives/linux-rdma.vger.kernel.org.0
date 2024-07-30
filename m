Return-Path: <linux-rdma+bounces-4122-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55210941FCB
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 20:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BEFEB25AA0
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 18:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBB918DF69;
	Tue, 30 Jul 2024 18:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSXFyeU5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CB01A8C1A;
	Tue, 30 Jul 2024 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364491; cv=none; b=uk4BC2Q+mzbokB8y1FUpwJUalv7L9p3AhBpw/2GQCzi8sn4cfRKx8u3TbyVhZWqFdls06H57Mi82ukdwQGJPwdu6u1hkUG1ZIHjCeP47VkGjz6bIFF+ytjba+LkqZUScUwQkNR2OYKuRVNy0gYwIbUj1WizuQwpHg5xuGUhA+fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364491; c=relaxed/simple;
	bh=cI06cWMeiiaaHvVrivHUrUMAP27szVAGIwpicbm6Rjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gv24Xz4QXpRQWR8deQZ2NHTOEEARxAoipXi3i6YMlHyJDRjRAk8Ty9mqat0KbEsQ1ky0f2LLp+klDZtkDLKo9Oyy9Dbh32Jas6GjuXvGaj9jdLO2UivlQqwirI6yMYVa0BgXVxnDEAW1vqCiCooEyZNHHj+cIBM8Crf6rEyoe0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSXFyeU5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d316f0060so103127b3a.1;
        Tue, 30 Jul 2024 11:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722364489; x=1722969289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Duz+R7OD5yozyO0xOdsWZmjZsXtc7sydmF+n4fo7yxk=;
        b=DSXFyeU59qGR0zDPifqdax5QeLucKdmOEIU7nvy0g1tQuAY57S3MwEmrSAknaOUaZ9
         uWxV6cs17gO+BcT3HxE2aE9LqRM3DusMx96kJFK8OF9zaYc2pNwEjo9OlbaWqtPOthdv
         GwKDhZl1FwzyjhJX7k2XfVXcokoEYaRBXvdYB6bkpLV10C3+xKz+LxkxCL+UjH/QPpJH
         uoc1c0fjhv6zEywQlEUYBdtXdfQ9oCEPUYPobyWab6TuBuC1no7IwFpJJtbNacTghg31
         Dy1MBJOMD1cOmJ+JsGCW4ZDhQh1o7gTr7GwH0ejObaoIkJILZwxV9rctt98I30wd8vqW
         SLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722364489; x=1722969289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Duz+R7OD5yozyO0xOdsWZmjZsXtc7sydmF+n4fo7yxk=;
        b=jDjPWxihWV5PC4w1WqZ+cRdcioo0qkSfV8F46Hnk+1dTxqSyMTqv+7Je4EegGaJ/uX
         bXa9mjNn3xBEou84IPMx7COL8y/S0K0SIUx/8ETBr/dPpJxHAW238MPtmXjm7nJxR4fL
         6/WIhxkrC1fdIHGFz0pGn8YP1X8QNzaepAPcrueyqplXWo902N4zSg2dP2RVcx8kYCLh
         PZXaMlPuxnVZN2mLJ7Qy8LiaLCccHFjJj19fW+FYcO4Co/hB9ia4cctz+xVinVkUtB9z
         PJw+O6VxMdBoYIaQAws0zJCb9V70DBx6BZ/JFvm25Iwh9UwwgPOGC7lQsXpHeoP1IS7B
         cmTw==
X-Forwarded-Encrypted: i=1; AJvYcCVUAPkaenQoLmjuMo+K8N6c1ktS4oKZwtA6uxU+Q1jVEfoBaLRIzWrObcmz2gtE2QelDfX13kJWFP4DfDY4QsQGiLtezSerC4qJwNp0J7vWq0zUX7Oa9MojniXG4kxib/c2DRN7j8/MAj4tsP48+Dx1CEmnusBX4bs0A/DHIWm19w==
X-Gm-Message-State: AOJu0YwilgX/5rhLaaemuBi7spbkipV+F37my6Y5XYFtce/ln+EIQUrX
	G/M7RhqZLkf6RtsCbU0bQqbm+1f1/kd22wGAHaGln0bM7O6XLhyh
X-Google-Smtp-Source: AGHT+IGxxd98poQZ5VsvVAwrejG7muttGAGaSqTTcastI4KpGM1zGNrfIl2gMAD8HKtiDAx4TeEmCQ==
X-Received: by 2002:a05:6a20:8425:b0:1c4:8294:95da with SMTP id adf61e73a8af0-1c4e4883b4cmr4197746637.26.1722364488814;
        Tue, 30 Jul 2024 11:34:48 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:f2df:af9:e1f6:390e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f817f5a2sm7837763a12.24.2024.07.30.11.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:34:48 -0700 (PDT)
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
	netdev@vger.kernel.org,
	Allen Pais <allen.lkml@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [net-next v3 15/15] net: mtk-wed: Convert tasklet API to new bottom half workqueue mechanism
Date: Tue, 30 Jul 2024 11:34:03 -0700
Message-Id: <20240730183403.4176544-16-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730183403.4176544-1-allen.lkml@gmail.com>
References: <20240730183403.4176544-1-allen.lkml@gmail.com>
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


