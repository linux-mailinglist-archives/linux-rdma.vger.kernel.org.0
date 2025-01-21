Return-Path: <linux-rdma+bounces-7136-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9F2A17802
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 08:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93855188E2A1
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 07:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3901F3FD1;
	Tue, 21 Jan 2025 06:57:44 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E5A1F37D4;
	Tue, 21 Jan 2025 06:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737442664; cv=none; b=qYtwjn5MeElxPQb92yc0x0DyAICWaRTZ+JaMoVEueKyRCuKfHRNUEFFHxZm1sBZOwFfTY1E+4t688FBXPGO/5IuwXPnOJKdWcAgPX7MnM05Ku7T4+WWserWnZ6UbBI89Hgr2cZmGapBL9aH9U6+eXf1YtA+HgxU0L0dnonedTdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737442664; c=relaxed/simple;
	bh=9QpnncAYEGL/R1ZpJFaCXmpN7BRyTIcAv/iKRtqMnGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=saxQHXfHZkd9yor/xvi/kkQUBEcLc/cYD4jA3UBbrEmaElrnPYpdHrjzA6VZjUu5qUZ5pGKmKajhr86ZVJysBLC4ISSZu9f7xCJsKu4k3w8HurGuiAVXckaLMxsikPyhV7SQcmmqhGtvpd1SjyYRr3cdzZA7LnFs6I8swJ5v2Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4YcdHy51YmzRlYj;
	Tue, 21 Jan 2025 14:55:10 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id CC2101802D0;
	Tue, 21 Jan 2025 14:57:39 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 14:57:39 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 14:57:37 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <linux-hwmon@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <arm-scmi@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
	<oss-drivers@corigine.com>, <linux-rdma@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux@roeck-us.net>, <jdelvare@suse.com>, <kernel@maidavale.org>,
	<pauk.denis@gmail.com>, <james@equiv.tech>, <sudeep.holla@arm.com>,
	<cristian.marussi@arm.com>, <matt@ranostay.sg>, <mchehab@kernel.org>,
	<irusskikh@marvell.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<saeedm@nvidia.com>, <leon@kernel.org>, <tariqt@nvidia.com>,
	<louis.peens@corigine.com>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<kabel@kernel.org>, <W_Armin@gmx.de>, <hdegoede@redhat.com>,
	<ilpo.jarvinen@linux.intel.com>, <alexandre.belloni@bootlin.com>,
	<krzk@kernel.org>, <jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 14/21] hwmon: (pwm-fan) Fix the type of 'config' in struct hwmon_channel_info to u64
Date: Tue, 21 Jan 2025 14:45:12 +0800
Message-ID: <20250121064519.18974-15-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20250121064519.18974-1-lihuisong@huawei.com>
References: <20250121064519.18974-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn100009.china.huawei.com (7.202.194.112)

The type of 'config' in struct hwmon_channel_info has been fixed to u64.
Modify the related code in driver to avoid compiling failure.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/hwmon/pwm-fan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 579d31bb9ac7..91bb6d590a36 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -498,7 +498,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	int ret;
 	const struct hwmon_channel_info **channels;
 	u32 initial_pwm, pwm_min_from_stopped = 0;
-	u32 *fan_channel_config;
+	u64 *fan_channel_config;
 	int channel_count = 1;	/* We always have a PWM channel. */
 	int i;
 
@@ -586,7 +586,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 		ctx->fan_channel.type = hwmon_fan;
 		fan_channel_config = devm_kcalloc(dev, ctx->tach_count + 1,
-						  sizeof(u32), GFP_KERNEL);
+						  sizeof(u64), GFP_KERNEL);
 		if (!fan_channel_config)
 			return -ENOMEM;
 		ctx->fan_channel.config = fan_channel_config;
-- 
2.22.0


