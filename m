Return-Path: <linux-rdma+bounces-7123-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FDCA177A3
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 07:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F98188B4D2
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 06:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D311B4134;
	Tue, 21 Jan 2025 06:57:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A341B21A8;
	Tue, 21 Jan 2025 06:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737442651; cv=none; b=lQOgf7Q54d3hsXwoUwjeAB8Ol3+kiPJCuOgPk9sybrGe1hs5xnAX3GQQdfja09lt5c+kUV8FL18ONGtnhiWjosr24QHdFKfLcqxJGvdKqyAREUP6nvjUHsK+HG2yZJw/bp4fKVG5HOIb9VY4LOvsOMJo+EmOYWO6r/9UiGWUly0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737442651; c=relaxed/simple;
	bh=pLDYZI2ORguKTw/14TF5fTg2eqigu3oKV9kYu2UT8Ik=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=chKx4ZjRBbnLV9oBkfY0xu0arBX9k/7NQS/J057H0L3xz4WnfuEFCDuwRcuFo6jFE2Gk+RKjc5kSW5ySG/NHbzq4zrzKDliQ0EwYHpMlEfYl9Lf6h9StL1BlkWORJN6yxEFRGmrT+YqMwApZzg08c1MMwNzEojFiWSflz7LbjzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YcdGq1MdBzbp8C;
	Tue, 21 Jan 2025 14:54:11 +0800 (CST)
Received: from dggemv703-chm.china.huawei.com (unknown [10.3.19.46])
	by mail.maildlp.com (Postfix) with ESMTPS id D21421800D1;
	Tue, 21 Jan 2025 14:57:19 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 Jan 2025 14:57:19 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 14:57:17 +0800
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
Subject: [PATCH v1 00/21] hwmon: Fix the type of 'config' in struct hwmon_channel_info to u64
Date: Tue, 21 Jan 2025 14:44:58 +0800
Message-ID: <20250121064519.18974-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
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

The hwmon_device_register() is deprecated. When I try to repace it with
hwmon_device_register_with_info() for acpi_power_meter driver, I found that
the power channel attribute in linux/hwmon.h have to extend and is more
than 32 after this replacement.

However, the maximum number of hwmon channel attributes is 32 which is
limited by current hwmon codes. This is not good to add new channel
attribute for some hwmon sensor type and support more channel attribute.

This series are aimed to do this. And also make sure that acpi_power_meter
driver can successfully replace the deprecated hwmon_device_register()
later.

Huisong Li (21):
  hwmon: Fix the type of 'config' in struct hwmon_channel_info to u64
  media: video-i2c: Use HWMON_CHANNEL_INFO macro to simplify code
  net: aquantia: Use HWMON_CHANNEL_INFO macro to simplify code
  net: nfp: Use HWMON_CHANNEL_INFO macro to simplify code
  net: phy: marvell: Use HWMON_CHANNEL_INFO macro to simplify code
  net: phy: marvell10g: Use HWMON_CHANNEL_INFO macro to simplify code
  rtc: ab-eoz9: Use HWMON_CHANNEL_INFO macro to simplify code
  rtc: ds3232: Use HWMON_CHANNEL_INFO macro to simplify code
  w1: w1_therm: w1: Use HWMON_CHANNEL_INFO macro to simplify code
  net: phy: aquantia: Use HWMON_CHANNEL_INFO macro to simplify code
  hwmon: (asus_wmi_sensors) Fix type of 'config' in struct
    hwmon_channel_info to u64
  hwmon: (hp-wmi-sensors) Fix type of 'config' in struct
    hwmon_channel_info to u64
  hwmon: (mr75203) Fix the type of 'config' in struct hwmon_channel_info
    to u64
  hwmon: (pwm-fan) Fix the type of 'config' in struct hwmon_channel_info
    to u64
  hwmon: (scmi-hwmon) Fix the type of 'config' in struct
    hwmon_channel_info to u64
  hwmon: (tmp401) Fix the type of 'config' in struct hwmon_channel_info
    to u64
  hwmon: (tmp421) Fix the type of 'config' in struct hwmon_channel_info
    to u64
  net/mlx5: Fix the type of 'config' in struct hwmon_channel_info to u64
  platform/x86: dell-ddv: Fix the type of 'config' in struct
    hwmon_channel_info to u64
  hwmon: (asus-ec-sensors) Fix the type of 'config' in struct
    hwmon_channel_info to u64
  hwmon: (lm90) Fix the type of 'config' in struct hwmon_channel_info to
    u64

 drivers/hwmon/asus-ec-sensors.c               |   6 +-
 drivers/hwmon/asus_wmi_sensors.c              |   8 +-
 drivers/hwmon/hp-wmi-sensors.c                |   6 +-
 drivers/hwmon/hwmon.c                         |   4 +-
 drivers/hwmon/lm90.c                          |   4 +-
 drivers/hwmon/mr75203.c                       |   6 +-
 drivers/hwmon/pwm-fan.c                       |   4 +-
 drivers/hwmon/scmi-hwmon.c                    |   6 +-
 drivers/hwmon/tmp401.c                        |   4 +-
 drivers/hwmon/tmp421.c                        |   2 +-
 drivers/media/i2c/video-i2c.c                 |  12 +-
 .../ethernet/aquantia/atlantic/aq_drvinfo.c   |  14 +-
 .../net/ethernet/mellanox/mlx5/core/hwmon.c   |   8 +-
 .../net/ethernet/netronome/nfp/nfp_hwmon.c    |  40 +--
 drivers/net/phy/aquantia/aquantia_hwmon.c     |  32 +-
 drivers/net/phy/marvell.c                     |  24 +-
 drivers/net/phy/marvell10g.c                  |  24 +-
 drivers/platform/x86/dell/dell-wmi-ddv.c      |   6 +-
 drivers/rtc/rtc-ab-eoz9.c                     |  24 +-
 drivers/rtc/rtc-ds3232.c                      |  24 +-
 drivers/w1/slaves/w1_therm.c                  |  12 +-
 include/linux/hwmon.h                         | 300 +++++++++---------
 22 files changed, 205 insertions(+), 365 deletions(-)

-- 
2.22.0


