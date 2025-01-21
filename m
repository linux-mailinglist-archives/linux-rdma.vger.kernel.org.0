Return-Path: <linux-rdma+bounces-7122-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A920A1779C
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 07:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5FA3A64ED
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 06:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327D21B0424;
	Tue, 21 Jan 2025 06:57:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748361A83F4;
	Tue, 21 Jan 2025 06:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737442648; cv=none; b=fReSXRNXqfFy3WxNpU2GahB/wtt4xK9XQhLZOECxsNOx7g6MLq6YQQsnzHCsy+7nNSTqIjsir/4EVLEHz/6aWUHVXOZ/niPS4pGC6R+5arUvI4qYjRYBvlJJ2jMIEKFFmZ2BKBOUcZGAsIsrt+MdA626RVre3KCm8vR+aLfDqNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737442648; c=relaxed/simple;
	bh=ersZ7svCfdCBBWOQ2aD9ovIVd7sskiWFwOEOCNa85Es=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ucmYHSBFVIIaVXS0IiipCSOhiSmcfjzB050fsnkgF1PP7S8FoMpKkfPDXeBQ/fxtrX5pTs/Bek86aMmMb3PrC4OjG9yQ308Sf6yXIhdyLYCZuXmKryFMvxqtVHVJK5hmeOydziHOQ3KQ9oVi0bc4ktwilEsSVIK5uuOalee44aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4YcdLy3R0Pz20pDJ;
	Tue, 21 Jan 2025 14:57:46 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B2511A0188;
	Tue, 21 Jan 2025 14:57:21 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 14:57:21 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 14:57:19 +0800
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
Subject: [PATCH v1 01/21] hwmon: Fix the type of 'config' in struct hwmon_channel_info to u64
Date: Tue, 21 Jan 2025 14:44:59 +0800
Message-ID: <20250121064519.18974-2-lihuisong@huawei.com>
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

Currently, the maximum number of hwmon channel attributes is 32 which is
limited by current hwmon core codes. And the power attributes are up to 31.
It's already encountered the issue of not adding attribute name to power
channel attribute.

So fix the type of 'config' in struct hwmon_channel_info to u64 so as to
support more attributes. For this goal, the following points are needed to
be done:
(1) Fix the type of 'config' in hwmon_channel_info structure to u64.
(2) Modify hwmon_num_channel_attrs() with hweight64.
(3) Type of BIT(xxx) in linux/hwmon.h is 'UL', need to modify to BIT_ULL.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/hwmon/hwmon.c |   4 +-
 include/linux/hwmon.h | 300 +++++++++++++++++++++---------------------
 2 files changed, 152 insertions(+), 152 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 9703d60e9bbf..1fe8fa12cc60 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -790,7 +790,7 @@ static int hwmon_num_channel_attrs(const struct hwmon_channel_info *info)
 	int i, n;
 
 	for (i = n = 0; info->config[i]; i++)
-		n += hweight32(info->config[i]);
+		n += hweight64(info->config[i]);
 
 	return n;
 }
@@ -811,7 +811,7 @@ static int hwmon_genattrs(const void *drvdata,
 	template_size = __templates_size[info->type];
 
 	for (i = 0; info->config[i]; i++) {
-		u32 attr_mask = info->config[i];
+		u64 attr_mask = info->config[i];
 		u32 attr;
 
 		while (attr_mask) {
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 3a63dff62d03..544266a58d07 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -48,20 +48,20 @@ enum hwmon_chip_attributes {
 	hwmon_chip_pec,
 };
 
-#define HWMON_C_TEMP_RESET_HISTORY	BIT(hwmon_chip_temp_reset_history)
-#define HWMON_C_IN_RESET_HISTORY	BIT(hwmon_chip_in_reset_history)
-#define HWMON_C_CURR_RESET_HISTORY	BIT(hwmon_chip_curr_reset_history)
-#define HWMON_C_POWER_RESET_HISTORY	BIT(hwmon_chip_power_reset_history)
-#define HWMON_C_REGISTER_TZ		BIT(hwmon_chip_register_tz)
-#define HWMON_C_UPDATE_INTERVAL		BIT(hwmon_chip_update_interval)
-#define HWMON_C_ALARMS			BIT(hwmon_chip_alarms)
-#define HWMON_C_SAMPLES			BIT(hwmon_chip_samples)
-#define HWMON_C_CURR_SAMPLES		BIT(hwmon_chip_curr_samples)
-#define HWMON_C_IN_SAMPLES		BIT(hwmon_chip_in_samples)
-#define HWMON_C_POWER_SAMPLES		BIT(hwmon_chip_power_samples)
-#define HWMON_C_TEMP_SAMPLES		BIT(hwmon_chip_temp_samples)
-#define HWMON_C_BEEP_ENABLE		BIT(hwmon_chip_beep_enable)
-#define HWMON_C_PEC			BIT(hwmon_chip_pec)
+#define HWMON_C_TEMP_RESET_HISTORY	BIT_ULL(hwmon_chip_temp_reset_history)
+#define HWMON_C_IN_RESET_HISTORY	BIT_ULL(hwmon_chip_in_reset_history)
+#define HWMON_C_CURR_RESET_HISTORY	BIT_ULL(hwmon_chip_curr_reset_history)
+#define HWMON_C_POWER_RESET_HISTORY	BIT_ULL(hwmon_chip_power_reset_history)
+#define HWMON_C_REGISTER_TZ		BIT_ULL(hwmon_chip_register_tz)
+#define HWMON_C_UPDATE_INTERVAL		BIT_ULL(hwmon_chip_update_interval)
+#define HWMON_C_ALARMS			BIT_ULL(hwmon_chip_alarms)
+#define HWMON_C_SAMPLES			BIT_ULL(hwmon_chip_samples)
+#define HWMON_C_CURR_SAMPLES		BIT_ULL(hwmon_chip_curr_samples)
+#define HWMON_C_IN_SAMPLES		BIT_ULL(hwmon_chip_in_samples)
+#define HWMON_C_POWER_SAMPLES		BIT_ULL(hwmon_chip_power_samples)
+#define HWMON_C_TEMP_SAMPLES		BIT_ULL(hwmon_chip_temp_samples)
+#define HWMON_C_BEEP_ENABLE		BIT_ULL(hwmon_chip_beep_enable)
+#define HWMON_C_PEC			BIT_ULL(hwmon_chip_pec)
 
 enum hwmon_temp_attributes {
 	hwmon_temp_enable,
@@ -94,34 +94,34 @@ enum hwmon_temp_attributes {
 	hwmon_temp_beep,
 };
 
-#define HWMON_T_ENABLE		BIT(hwmon_temp_enable)
-#define HWMON_T_INPUT		BIT(hwmon_temp_input)
-#define HWMON_T_TYPE		BIT(hwmon_temp_type)
-#define HWMON_T_LCRIT		BIT(hwmon_temp_lcrit)
-#define HWMON_T_LCRIT_HYST	BIT(hwmon_temp_lcrit_hyst)
-#define HWMON_T_MIN		BIT(hwmon_temp_min)
-#define HWMON_T_MIN_HYST	BIT(hwmon_temp_min_hyst)
-#define HWMON_T_MAX		BIT(hwmon_temp_max)
-#define HWMON_T_MAX_HYST	BIT(hwmon_temp_max_hyst)
-#define HWMON_T_CRIT		BIT(hwmon_temp_crit)
-#define HWMON_T_CRIT_HYST	BIT(hwmon_temp_crit_hyst)
-#define HWMON_T_EMERGENCY	BIT(hwmon_temp_emergency)
-#define HWMON_T_EMERGENCY_HYST	BIT(hwmon_temp_emergency_hyst)
-#define HWMON_T_ALARM		BIT(hwmon_temp_alarm)
-#define HWMON_T_MIN_ALARM	BIT(hwmon_temp_min_alarm)
-#define HWMON_T_MAX_ALARM	BIT(hwmon_temp_max_alarm)
-#define HWMON_T_CRIT_ALARM	BIT(hwmon_temp_crit_alarm)
-#define HWMON_T_LCRIT_ALARM	BIT(hwmon_temp_lcrit_alarm)
-#define HWMON_T_EMERGENCY_ALARM	BIT(hwmon_temp_emergency_alarm)
-#define HWMON_T_FAULT		BIT(hwmon_temp_fault)
-#define HWMON_T_OFFSET		BIT(hwmon_temp_offset)
-#define HWMON_T_LABEL		BIT(hwmon_temp_label)
-#define HWMON_T_LOWEST		BIT(hwmon_temp_lowest)
-#define HWMON_T_HIGHEST		BIT(hwmon_temp_highest)
-#define HWMON_T_RESET_HISTORY	BIT(hwmon_temp_reset_history)
-#define HWMON_T_RATED_MIN	BIT(hwmon_temp_rated_min)
-#define HWMON_T_RATED_MAX	BIT(hwmon_temp_rated_max)
-#define HWMON_T_BEEP		BIT(hwmon_temp_beep)
+#define HWMON_T_ENABLE		BIT_ULL(hwmon_temp_enable)
+#define HWMON_T_INPUT		BIT_ULL(hwmon_temp_input)
+#define HWMON_T_TYPE		BIT_ULL(hwmon_temp_type)
+#define HWMON_T_LCRIT		BIT_ULL(hwmon_temp_lcrit)
+#define HWMON_T_LCRIT_HYST	BIT_ULL(hwmon_temp_lcrit_hyst)
+#define HWMON_T_MIN		BIT_ULL(hwmon_temp_min)
+#define HWMON_T_MIN_HYST	BIT_ULL(hwmon_temp_min_hyst)
+#define HWMON_T_MAX		BIT_ULL(hwmon_temp_max)
+#define HWMON_T_MAX_HYST	BIT_ULL(hwmon_temp_max_hyst)
+#define HWMON_T_CRIT		BIT_ULL(hwmon_temp_crit)
+#define HWMON_T_CRIT_HYST	BIT_ULL(hwmon_temp_crit_hyst)
+#define HWMON_T_EMERGENCY	BIT_ULL(hwmon_temp_emergency)
+#define HWMON_T_EMERGENCY_HYST	BIT_ULL(hwmon_temp_emergency_hyst)
+#define HWMON_T_ALARM		BIT_ULL(hwmon_temp_alarm)
+#define HWMON_T_MIN_ALARM	BIT_ULL(hwmon_temp_min_alarm)
+#define HWMON_T_MAX_ALARM	BIT_ULL(hwmon_temp_max_alarm)
+#define HWMON_T_CRIT_ALARM	BIT_ULL(hwmon_temp_crit_alarm)
+#define HWMON_T_LCRIT_ALARM	BIT_ULL(hwmon_temp_lcrit_alarm)
+#define HWMON_T_EMERGENCY_ALARM	BIT_ULL(hwmon_temp_emergency_alarm)
+#define HWMON_T_FAULT		BIT_ULL(hwmon_temp_fault)
+#define HWMON_T_OFFSET		BIT_ULL(hwmon_temp_offset)
+#define HWMON_T_LABEL		BIT_ULL(hwmon_temp_label)
+#define HWMON_T_LOWEST		BIT_ULL(hwmon_temp_lowest)
+#define HWMON_T_HIGHEST		BIT_ULL(hwmon_temp_highest)
+#define HWMON_T_RESET_HISTORY	BIT_ULL(hwmon_temp_reset_history)
+#define HWMON_T_RATED_MIN	BIT_ULL(hwmon_temp_rated_min)
+#define HWMON_T_RATED_MAX	BIT_ULL(hwmon_temp_rated_max)
+#define HWMON_T_BEEP		BIT_ULL(hwmon_temp_beep)
 
 enum hwmon_in_attributes {
 	hwmon_in_enable,
@@ -146,26 +146,26 @@ enum hwmon_in_attributes {
 	hwmon_in_fault,
 };
 
-#define HWMON_I_ENABLE		BIT(hwmon_in_enable)
-#define HWMON_I_INPUT		BIT(hwmon_in_input)
-#define HWMON_I_MIN		BIT(hwmon_in_min)
-#define HWMON_I_MAX		BIT(hwmon_in_max)
-#define HWMON_I_LCRIT		BIT(hwmon_in_lcrit)
-#define HWMON_I_CRIT		BIT(hwmon_in_crit)
-#define HWMON_I_AVERAGE		BIT(hwmon_in_average)
-#define HWMON_I_LOWEST		BIT(hwmon_in_lowest)
-#define HWMON_I_HIGHEST		BIT(hwmon_in_highest)
-#define HWMON_I_RESET_HISTORY	BIT(hwmon_in_reset_history)
-#define HWMON_I_LABEL		BIT(hwmon_in_label)
-#define HWMON_I_ALARM		BIT(hwmon_in_alarm)
-#define HWMON_I_MIN_ALARM	BIT(hwmon_in_min_alarm)
-#define HWMON_I_MAX_ALARM	BIT(hwmon_in_max_alarm)
-#define HWMON_I_LCRIT_ALARM	BIT(hwmon_in_lcrit_alarm)
-#define HWMON_I_CRIT_ALARM	BIT(hwmon_in_crit_alarm)
-#define HWMON_I_RATED_MIN	BIT(hwmon_in_rated_min)
-#define HWMON_I_RATED_MAX	BIT(hwmon_in_rated_max)
-#define HWMON_I_BEEP		BIT(hwmon_in_beep)
-#define HWMON_I_FAULT		BIT(hwmon_in_fault)
+#define HWMON_I_ENABLE		BIT_ULL(hwmon_in_enable)
+#define HWMON_I_INPUT		BIT_ULL(hwmon_in_input)
+#define HWMON_I_MIN		BIT_ULL(hwmon_in_min)
+#define HWMON_I_MAX		BIT_ULL(hwmon_in_max)
+#define HWMON_I_LCRIT		BIT_ULL(hwmon_in_lcrit)
+#define HWMON_I_CRIT		BIT_ULL(hwmon_in_crit)
+#define HWMON_I_AVERAGE		BIT_ULL(hwmon_in_average)
+#define HWMON_I_LOWEST		BIT_ULL(hwmon_in_lowest)
+#define HWMON_I_HIGHEST		BIT_ULL(hwmon_in_highest)
+#define HWMON_I_RESET_HISTORY	BIT_ULL(hwmon_in_reset_history)
+#define HWMON_I_LABEL		BIT_ULL(hwmon_in_label)
+#define HWMON_I_ALARM		BIT_ULL(hwmon_in_alarm)
+#define HWMON_I_MIN_ALARM	BIT_ULL(hwmon_in_min_alarm)
+#define HWMON_I_MAX_ALARM	BIT_ULL(hwmon_in_max_alarm)
+#define HWMON_I_LCRIT_ALARM	BIT_ULL(hwmon_in_lcrit_alarm)
+#define HWMON_I_CRIT_ALARM	BIT_ULL(hwmon_in_crit_alarm)
+#define HWMON_I_RATED_MIN	BIT_ULL(hwmon_in_rated_min)
+#define HWMON_I_RATED_MAX	BIT_ULL(hwmon_in_rated_max)
+#define HWMON_I_BEEP		BIT_ULL(hwmon_in_beep)
+#define HWMON_I_FAULT		BIT_ULL(hwmon_in_fault)
 
 enum hwmon_curr_attributes {
 	hwmon_curr_enable,
@@ -189,25 +189,25 @@ enum hwmon_curr_attributes {
 	hwmon_curr_beep,
 };
 
-#define HWMON_C_ENABLE		BIT(hwmon_curr_enable)
-#define HWMON_C_INPUT		BIT(hwmon_curr_input)
-#define HWMON_C_MIN		BIT(hwmon_curr_min)
-#define HWMON_C_MAX		BIT(hwmon_curr_max)
-#define HWMON_C_LCRIT		BIT(hwmon_curr_lcrit)
-#define HWMON_C_CRIT		BIT(hwmon_curr_crit)
-#define HWMON_C_AVERAGE		BIT(hwmon_curr_average)
-#define HWMON_C_LOWEST		BIT(hwmon_curr_lowest)
-#define HWMON_C_HIGHEST		BIT(hwmon_curr_highest)
-#define HWMON_C_RESET_HISTORY	BIT(hwmon_curr_reset_history)
-#define HWMON_C_LABEL		BIT(hwmon_curr_label)
-#define HWMON_C_ALARM		BIT(hwmon_curr_alarm)
-#define HWMON_C_MIN_ALARM	BIT(hwmon_curr_min_alarm)
-#define HWMON_C_MAX_ALARM	BIT(hwmon_curr_max_alarm)
-#define HWMON_C_LCRIT_ALARM	BIT(hwmon_curr_lcrit_alarm)
-#define HWMON_C_CRIT_ALARM	BIT(hwmon_curr_crit_alarm)
-#define HWMON_C_RATED_MIN	BIT(hwmon_curr_rated_min)
-#define HWMON_C_RATED_MAX	BIT(hwmon_curr_rated_max)
-#define HWMON_C_BEEP		BIT(hwmon_curr_beep)
+#define HWMON_C_ENABLE		BIT_ULL(hwmon_curr_enable)
+#define HWMON_C_INPUT		BIT_ULL(hwmon_curr_input)
+#define HWMON_C_MIN		BIT_ULL(hwmon_curr_min)
+#define HWMON_C_MAX		BIT_ULL(hwmon_curr_max)
+#define HWMON_C_LCRIT		BIT_ULL(hwmon_curr_lcrit)
+#define HWMON_C_CRIT		BIT_ULL(hwmon_curr_crit)
+#define HWMON_C_AVERAGE		BIT_ULL(hwmon_curr_average)
+#define HWMON_C_LOWEST		BIT_ULL(hwmon_curr_lowest)
+#define HWMON_C_HIGHEST		BIT_ULL(hwmon_curr_highest)
+#define HWMON_C_RESET_HISTORY	BIT_ULL(hwmon_curr_reset_history)
+#define HWMON_C_LABEL		BIT_ULL(hwmon_curr_label)
+#define HWMON_C_ALARM		BIT_ULL(hwmon_curr_alarm)
+#define HWMON_C_MIN_ALARM	BIT_ULL(hwmon_curr_min_alarm)
+#define HWMON_C_MAX_ALARM	BIT_ULL(hwmon_curr_max_alarm)
+#define HWMON_C_LCRIT_ALARM	BIT_ULL(hwmon_curr_lcrit_alarm)
+#define HWMON_C_CRIT_ALARM	BIT_ULL(hwmon_curr_crit_alarm)
+#define HWMON_C_RATED_MIN	BIT_ULL(hwmon_curr_rated_min)
+#define HWMON_C_RATED_MAX	BIT_ULL(hwmon_curr_rated_max)
+#define HWMON_C_BEEP		BIT_ULL(hwmon_curr_beep)
 
 enum hwmon_power_attributes {
 	hwmon_power_enable,
@@ -243,37 +243,37 @@ enum hwmon_power_attributes {
 	hwmon_power_rated_max,
 };
 
-#define HWMON_P_ENABLE			BIT(hwmon_power_enable)
-#define HWMON_P_AVERAGE			BIT(hwmon_power_average)
-#define HWMON_P_AVERAGE_INTERVAL	BIT(hwmon_power_average_interval)
-#define HWMON_P_AVERAGE_INTERVAL_MAX	BIT(hwmon_power_average_interval_max)
-#define HWMON_P_AVERAGE_INTERVAL_MIN	BIT(hwmon_power_average_interval_min)
-#define HWMON_P_AVERAGE_HIGHEST		BIT(hwmon_power_average_highest)
-#define HWMON_P_AVERAGE_LOWEST		BIT(hwmon_power_average_lowest)
-#define HWMON_P_AVERAGE_MAX		BIT(hwmon_power_average_max)
-#define HWMON_P_AVERAGE_MIN		BIT(hwmon_power_average_min)
-#define HWMON_P_INPUT			BIT(hwmon_power_input)
-#define HWMON_P_INPUT_HIGHEST		BIT(hwmon_power_input_highest)
-#define HWMON_P_INPUT_LOWEST		BIT(hwmon_power_input_lowest)
-#define HWMON_P_RESET_HISTORY		BIT(hwmon_power_reset_history)
-#define HWMON_P_ACCURACY		BIT(hwmon_power_accuracy)
-#define HWMON_P_CAP			BIT(hwmon_power_cap)
-#define HWMON_P_CAP_HYST		BIT(hwmon_power_cap_hyst)
-#define HWMON_P_CAP_MAX			BIT(hwmon_power_cap_max)
-#define HWMON_P_CAP_MIN			BIT(hwmon_power_cap_min)
-#define HWMON_P_MIN			BIT(hwmon_power_min)
-#define HWMON_P_MAX			BIT(hwmon_power_max)
-#define HWMON_P_LCRIT			BIT(hwmon_power_lcrit)
-#define HWMON_P_CRIT			BIT(hwmon_power_crit)
-#define HWMON_P_LABEL			BIT(hwmon_power_label)
-#define HWMON_P_ALARM			BIT(hwmon_power_alarm)
-#define HWMON_P_CAP_ALARM		BIT(hwmon_power_cap_alarm)
-#define HWMON_P_MIN_ALARM		BIT(hwmon_power_min_alarm)
-#define HWMON_P_MAX_ALARM		BIT(hwmon_power_max_alarm)
-#define HWMON_P_LCRIT_ALARM		BIT(hwmon_power_lcrit_alarm)
-#define HWMON_P_CRIT_ALARM		BIT(hwmon_power_crit_alarm)
-#define HWMON_P_RATED_MIN		BIT(hwmon_power_rated_min)
-#define HWMON_P_RATED_MAX		BIT(hwmon_power_rated_max)
+#define HWMON_P_ENABLE			BIT_ULL(hwmon_power_enable)
+#define HWMON_P_AVERAGE			BIT_ULL(hwmon_power_average)
+#define HWMON_P_AVERAGE_INTERVAL	BIT_ULL(hwmon_power_average_interval)
+#define HWMON_P_AVERAGE_INTERVAL_MAX	BIT_ULL(hwmon_power_average_interval_max)
+#define HWMON_P_AVERAGE_INTERVAL_MIN	BIT_ULL(hwmon_power_average_interval_min)
+#define HWMON_P_AVERAGE_HIGHEST		BIT_ULL(hwmon_power_average_highest)
+#define HWMON_P_AVERAGE_LOWEST		BIT_ULL(hwmon_power_average_lowest)
+#define HWMON_P_AVERAGE_MAX		BIT_ULL(hwmon_power_average_max)
+#define HWMON_P_AVERAGE_MIN		BIT_ULL(hwmon_power_average_min)
+#define HWMON_P_INPUT			BIT_ULL(hwmon_power_input)
+#define HWMON_P_INPUT_HIGHEST		BIT_ULL(hwmon_power_input_highest)
+#define HWMON_P_INPUT_LOWEST		BIT_ULL(hwmon_power_input_lowest)
+#define HWMON_P_RESET_HISTORY		BIT_ULL(hwmon_power_reset_history)
+#define HWMON_P_ACCURACY		BIT_ULL(hwmon_power_accuracy)
+#define HWMON_P_CAP			BIT_ULL(hwmon_power_cap)
+#define HWMON_P_CAP_HYST		BIT_ULL(hwmon_power_cap_hyst)
+#define HWMON_P_CAP_MAX			BIT_ULL(hwmon_power_cap_max)
+#define HWMON_P_CAP_MIN			BIT_ULL(hwmon_power_cap_min)
+#define HWMON_P_MIN			BIT_ULL(hwmon_power_min)
+#define HWMON_P_MAX			BIT_ULL(hwmon_power_max)
+#define HWMON_P_LCRIT			BIT_ULL(hwmon_power_lcrit)
+#define HWMON_P_CRIT			BIT_ULL(hwmon_power_crit)
+#define HWMON_P_LABEL			BIT_ULL(hwmon_power_label)
+#define HWMON_P_ALARM			BIT_ULL(hwmon_power_alarm)
+#define HWMON_P_CAP_ALARM		BIT_ULL(hwmon_power_cap_alarm)
+#define HWMON_P_MIN_ALARM		BIT_ULL(hwmon_power_min_alarm)
+#define HWMON_P_MAX_ALARM		BIT_ULL(hwmon_power_max_alarm)
+#define HWMON_P_LCRIT_ALARM		BIT_ULL(hwmon_power_lcrit_alarm)
+#define HWMON_P_CRIT_ALARM		BIT_ULL(hwmon_power_crit_alarm)
+#define HWMON_P_RATED_MIN		BIT_ULL(hwmon_power_rated_min)
+#define HWMON_P_RATED_MAX		BIT_ULL(hwmon_power_rated_max)
 
 enum hwmon_energy_attributes {
 	hwmon_energy_enable,
@@ -281,9 +281,9 @@ enum hwmon_energy_attributes {
 	hwmon_energy_label,
 };
 
-#define HWMON_E_ENABLE			BIT(hwmon_energy_enable)
-#define HWMON_E_INPUT			BIT(hwmon_energy_input)
-#define HWMON_E_LABEL			BIT(hwmon_energy_label)
+#define HWMON_E_ENABLE			BIT_ULL(hwmon_energy_enable)
+#define HWMON_E_INPUT			BIT_ULL(hwmon_energy_input)
+#define HWMON_E_LABEL			BIT_ULL(hwmon_energy_label)
 
 enum hwmon_humidity_attributes {
 	hwmon_humidity_enable,
@@ -301,19 +301,19 @@ enum hwmon_humidity_attributes {
 	hwmon_humidity_max_alarm,
 };
 
-#define HWMON_H_ENABLE			BIT(hwmon_humidity_enable)
-#define HWMON_H_INPUT			BIT(hwmon_humidity_input)
-#define HWMON_H_LABEL			BIT(hwmon_humidity_label)
-#define HWMON_H_MIN			BIT(hwmon_humidity_min)
-#define HWMON_H_MIN_HYST		BIT(hwmon_humidity_min_hyst)
-#define HWMON_H_MAX			BIT(hwmon_humidity_max)
-#define HWMON_H_MAX_HYST		BIT(hwmon_humidity_max_hyst)
-#define HWMON_H_ALARM			BIT(hwmon_humidity_alarm)
-#define HWMON_H_FAULT			BIT(hwmon_humidity_fault)
-#define HWMON_H_RATED_MIN		BIT(hwmon_humidity_rated_min)
-#define HWMON_H_RATED_MAX		BIT(hwmon_humidity_rated_max)
-#define HWMON_H_MIN_ALARM		BIT(hwmon_humidity_min_alarm)
-#define HWMON_H_MAX_ALARM		BIT(hwmon_humidity_max_alarm)
+#define HWMON_H_ENABLE			BIT_ULL(hwmon_humidity_enable)
+#define HWMON_H_INPUT			BIT_ULL(hwmon_humidity_input)
+#define HWMON_H_LABEL			BIT_ULL(hwmon_humidity_label)
+#define HWMON_H_MIN			BIT_ULL(hwmon_humidity_min)
+#define HWMON_H_MIN_HYST		BIT_ULL(hwmon_humidity_min_hyst)
+#define HWMON_H_MAX			BIT_ULL(hwmon_humidity_max)
+#define HWMON_H_MAX_HYST		BIT_ULL(hwmon_humidity_max_hyst)
+#define HWMON_H_ALARM			BIT_ULL(hwmon_humidity_alarm)
+#define HWMON_H_FAULT			BIT_ULL(hwmon_humidity_fault)
+#define HWMON_H_RATED_MIN		BIT_ULL(hwmon_humidity_rated_min)
+#define HWMON_H_RATED_MAX		BIT_ULL(hwmon_humidity_rated_max)
+#define HWMON_H_MIN_ALARM		BIT_ULL(hwmon_humidity_min_alarm)
+#define HWMON_H_MAX_ALARM		BIT_ULL(hwmon_humidity_max_alarm)
 
 enum hwmon_fan_attributes {
 	hwmon_fan_enable,
@@ -331,19 +331,19 @@ enum hwmon_fan_attributes {
 	hwmon_fan_beep,
 };
 
-#define HWMON_F_ENABLE			BIT(hwmon_fan_enable)
-#define HWMON_F_INPUT			BIT(hwmon_fan_input)
-#define HWMON_F_LABEL			BIT(hwmon_fan_label)
-#define HWMON_F_MIN			BIT(hwmon_fan_min)
-#define HWMON_F_MAX			BIT(hwmon_fan_max)
-#define HWMON_F_DIV			BIT(hwmon_fan_div)
-#define HWMON_F_PULSES			BIT(hwmon_fan_pulses)
-#define HWMON_F_TARGET			BIT(hwmon_fan_target)
-#define HWMON_F_ALARM			BIT(hwmon_fan_alarm)
-#define HWMON_F_MIN_ALARM		BIT(hwmon_fan_min_alarm)
-#define HWMON_F_MAX_ALARM		BIT(hwmon_fan_max_alarm)
-#define HWMON_F_FAULT			BIT(hwmon_fan_fault)
-#define HWMON_F_BEEP			BIT(hwmon_fan_beep)
+#define HWMON_F_ENABLE			BIT_ULL(hwmon_fan_enable)
+#define HWMON_F_INPUT			BIT_ULL(hwmon_fan_input)
+#define HWMON_F_LABEL			BIT_ULL(hwmon_fan_label)
+#define HWMON_F_MIN			BIT_ULL(hwmon_fan_min)
+#define HWMON_F_MAX			BIT_ULL(hwmon_fan_max)
+#define HWMON_F_DIV			BIT_ULL(hwmon_fan_div)
+#define HWMON_F_PULSES			BIT_ULL(hwmon_fan_pulses)
+#define HWMON_F_TARGET			BIT_ULL(hwmon_fan_target)
+#define HWMON_F_ALARM			BIT_ULL(hwmon_fan_alarm)
+#define HWMON_F_MIN_ALARM		BIT_ULL(hwmon_fan_min_alarm)
+#define HWMON_F_MAX_ALARM		BIT_ULL(hwmon_fan_max_alarm)
+#define HWMON_F_FAULT			BIT_ULL(hwmon_fan_fault)
+#define HWMON_F_BEEP			BIT_ULL(hwmon_fan_beep)
 
 enum hwmon_pwm_attributes {
 	hwmon_pwm_input,
@@ -353,18 +353,18 @@ enum hwmon_pwm_attributes {
 	hwmon_pwm_auto_channels_temp,
 };
 
-#define HWMON_PWM_INPUT			BIT(hwmon_pwm_input)
-#define HWMON_PWM_ENABLE		BIT(hwmon_pwm_enable)
-#define HWMON_PWM_MODE			BIT(hwmon_pwm_mode)
-#define HWMON_PWM_FREQ			BIT(hwmon_pwm_freq)
-#define HWMON_PWM_AUTO_CHANNELS_TEMP	BIT(hwmon_pwm_auto_channels_temp)
+#define HWMON_PWM_INPUT			BIT_ULL(hwmon_pwm_input)
+#define HWMON_PWM_ENABLE		BIT_ULL(hwmon_pwm_enable)
+#define HWMON_PWM_MODE			BIT_ULL(hwmon_pwm_mode)
+#define HWMON_PWM_FREQ			BIT_ULL(hwmon_pwm_freq)
+#define HWMON_PWM_AUTO_CHANNELS_TEMP	BIT_ULL(hwmon_pwm_auto_channels_temp)
 
 enum hwmon_intrusion_attributes {
 	hwmon_intrusion_alarm,
 	hwmon_intrusion_beep,
 };
-#define HWMON_INTRUSION_ALARM		BIT(hwmon_intrusion_alarm)
-#define HWMON_INTRUSION_BEEP		BIT(hwmon_intrusion_beep)
+#define HWMON_INTRUSION_ALARM		BIT_ULL(hwmon_intrusion_alarm)
+#define HWMON_INTRUSION_BEEP		BIT_ULL(hwmon_intrusion_beep)
 
 /**
  * struct hwmon_ops - hwmon device operations
@@ -433,13 +433,13 @@ struct hwmon_ops {
  */
 struct hwmon_channel_info {
 	enum hwmon_sensor_types type;
-	const u32 *config;
+	const u64 *config;
 };
 
 #define HWMON_CHANNEL_INFO(stype, ...)		\
 	(&(const struct hwmon_channel_info) {	\
 		.type = hwmon_##stype,		\
-		.config = (const u32 []) {	\
+		.config = (const u64 []) {	\
 			__VA_ARGS__, 0		\
 		}				\
 	})
-- 
2.22.0


