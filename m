Return-Path: <linux-rdma+bounces-7129-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 721D9A177D2
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 07:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8663AB87D
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 06:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888C81C243D;
	Tue, 21 Jan 2025 06:57:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8D91B041B;
	Tue, 21 Jan 2025 06:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737442658; cv=none; b=g2PWY6pP6AU5b8XF/UZ6no6M08VKgbA+JTXNrUAU6WWPX8a6epP3bUA41xN5Rx09z0/Ro/p3juM2rdCyS+humBdF+PIW2zyv1rlgfSsenuGlwoS6tmhiKDXU4vQuY6dKJe5KT2Anm68IXU1L7hvSscuuAsrSRkOGhtlsOXN8ppY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737442658; c=relaxed/simple;
	bh=MHb9TyuXgUHeuarU9Yir/7RmkDw32ubVkuACnX19mig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5XtzGt88s/a4zQj/JjShdMXVvYX0f+4TwtpfreSKhYptTwJcfsYPdyzyQ1cm3x93AMlb95SG3t16I78wdZ5SeI+WcS+UYH6ZH946woipur59SFQvxqVLCe6B6MbQdKnUKNkwaHdE18bl0BQVcuQEvg2PAnGbRrjHsUnKuB0zd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YcdHq4py9z22lgZ;
	Tue, 21 Jan 2025 14:55:03 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 956551402C3;
	Tue, 21 Jan 2025 14:57:32 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 14:57:32 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 14:57:22 +0800
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
Subject: [PATCH v1 03/21] net: aquantia: Use HWMON_CHANNEL_INFO macro to simplify code
Date: Tue, 21 Jan 2025 14:45:01 +0800
Message-ID: <20250121064519.18974-4-lihuisong@huawei.com>
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

Use HWMON_CHANNEL_INFO macro to simplify code.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 .../net/ethernet/aquantia/atlantic/aq_drvinfo.c    | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_drvinfo.c b/drivers/net/ethernet/aquantia/atlantic/aq_drvinfo.c
index 414b2e448d59..787ea91802e7 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_drvinfo.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_drvinfo.c
@@ -113,19 +113,9 @@ static const struct hwmon_ops aq_hwmon_ops = {
 	.read_string = aq_hwmon_read_string,
 };
 
-static u32 aq_hwmon_temp_config[] = {
-	HWMON_T_INPUT | HWMON_T_LABEL,
-	HWMON_T_INPUT | HWMON_T_LABEL,
-	0,
-};
-
-static const struct hwmon_channel_info aq_hwmon_temp = {
-	.type = hwmon_temp,
-	.config = aq_hwmon_temp_config,
-};
-
 static const struct hwmon_channel_info * const aq_hwmon_info[] = {
-	&aq_hwmon_temp,
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL),
 	NULL,
 };
 
-- 
2.22.0


