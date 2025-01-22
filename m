Return-Path: <linux-rdma+bounces-7162-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A12B9A18A14
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 03:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 603447A1BE9
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 02:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0475215687D;
	Wed, 22 Jan 2025 02:34:19 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A73354764;
	Wed, 22 Jan 2025 02:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513258; cv=none; b=aLBQh6w/ulWuP2PIlyFuiy6KEAPi4qNoY6OB6ddNbglelZvlGKFoFIRngjUeuMcGWJ14d2N4UHEO3+NgTmqKcG4YsMCtgxlm+DJQASyNjY5uVsVkQiwnBV+cD7Hvrh0q0PL9dtNRAe/AS8K1vLD5BZNRvz2jXeuwY/p6kLOFXW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513258; c=relaxed/simple;
	bh=ahL/0Ai3hbmd4fgtPdz9MFVO3eMVv9sVRtU0Vxotbj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ku3gTH4DA7GtVTZ38PtKPQWLK5O3nXAGHk29a2rGOtwxlHwXzQ/7TOphRQoLcyJlqB4Pc8Y7Gy43BXmizTzyZ0OjSYxA7N/4RkzRrGap3bak3Bnrkw/+z7Pl3JrfbDozUIP8aUtZSeIKho/fQeg6G1iSZhhHFfxQAQQa5AYX9JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Yd7PV04n7zRln3;
	Wed, 22 Jan 2025 10:31:42 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 0615818006C;
	Wed, 22 Jan 2025 10:34:12 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Jan 2025 10:34:11 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 22 Jan
 2025 10:34:09 +0800
Message-ID: <9575c823-4f77-8037-a4be-075b2e35d6f1@huawei.com>
Date: Wed, 22 Jan 2025 10:34:08 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 00/21] hwmon: Fix the type of 'config' in struct
 hwmon_channel_info to u64
To: Armin Wolf <W_Armin@gmx.de>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<arm-scmi@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, <oss-drivers@corigine.com>,
	<linux-rdma@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<linuxarm@huawei.com>, <linux@roeck-us.net>, <jdelvare@suse.com>,
	<kernel@maidavale.org>, <pauk.denis@gmail.com>, <james@equiv.tech>,
	<sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <matt@ranostay.sg>,
	<mchehab@kernel.org>, <irusskikh@marvell.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<tariqt@nvidia.com>, <louis.peens@corigine.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <kabel@kernel.org>, <hdegoede@redhat.com>,
	<ilpo.jarvinen@linux.intel.com>, <alexandre.belloni@bootlin.com>,
	<krzk@kernel.org>, <jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <liuyonglong@huawei.com>
References: <20250121064519.18974-1-lihuisong@huawei.com>
 <03b138e9-688f-4ebc-bd01-3d54fd20e525@gmx.de>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <03b138e9-688f-4ebc-bd01-3d54fd20e525@gmx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/1/21 22:12, Armin Wolf 写道:
> Am 21.01.25 um 07:44 schrieb Huisong Li:
>
>> The hwmon_device_register() is deprecated. When I try to repace it with
>> hwmon_device_register_with_info() for acpi_power_meter driver, I 
>> found that
>> the power channel attribute in linux/hwmon.h have to extend and is more
>> than 32 after this replacement.
>>
>> However, the maximum number of hwmon channel attributes is 32 which is
>> limited by current hwmon codes. This is not good to add new channel
>> attribute for some hwmon sensor type and support more channel attribute.
>>
>> This series are aimed to do this. And also make sure that 
>> acpi_power_meter
>> driver can successfully replace the deprecated hwmon_device_register()
>> later.
>
> Hi,
>
> what kind of new power attributes do you want to add to the hwmon API?
The attributes you list is right.
>
> AFAIK the acpi-power-meter driver supports the following attributes:
>
>     power1_accuracy            -> HWMON_P_ACCURACY
>     power1_cap_min            -> HWMON_P_CAP_MIN
>     power1_cap_max            -> HWMON_P_CAP_MAX
>     power1_cap_hyst            -> HWMON_P_CAP_HYST
>     power1_cap            -> HWMON_P_CAP
>     power1_average            -> HWMON_P_AVERAGE
>     power1_average_min        -> HWMON_P_AVERAGE_MIN
>     power1_average_max        -> HWMON_P_AVERAGE_MAX
>     power1_average_interval        -> HWMON_P_AVERAGE_INTERVAL
>     power1_average_interval_min    -> HWMON_P_AVERAGE_INTERVAL_MIN
>     power1_average_interval_max    -> HWMON_P_AVERAGE_INTERVAL_MAX
>     power1_alarm            -> HWMON_P_ALARM
>     power1_model_number
>     power1_oem_info
>     power1_serial_number
>     power1_is_battery
>     name                -> handled by hwmon core
>
> The remaining attributes are in my opinion not generic enough to add 
> them to the generic
> hwmon power attributes. I think you should implement them as a 
> attribute_group which can
> be passed to hwmon_device_register_with_info() using the 
> "extra_groups" parameter.
>
This is a good idea. Thanks.
>
>>
>> Huisong Li (21):
>>    hwmon: Fix the type of 'config' in struct hwmon_channel_info to u64
>>    media: video-i2c: Use HWMON_CHANNEL_INFO macro to simplify code
>>    net: aquantia: Use HWMON_CHANNEL_INFO macro to simplify code
>>    net: nfp: Use HWMON_CHANNEL_INFO macro to simplify code
>>    net: phy: marvell: Use HWMON_CHANNEL_INFO macro to simplify code
>>    net: phy: marvell10g: Use HWMON_CHANNEL_INFO macro to simplify code
>>    rtc: ab-eoz9: Use HWMON_CHANNEL_INFO macro to simplify code
>>    rtc: ds3232: Use HWMON_CHANNEL_INFO macro to simplify code
>>    w1: w1_therm: w1: Use HWMON_CHANNEL_INFO macro to simplify code
>>    net: phy: aquantia: Use HWMON_CHANNEL_INFO macro to simplify code
>>    hwmon: (asus_wmi_sensors) Fix type of 'config' in struct
>>      hwmon_channel_info to u64
>>    hwmon: (hp-wmi-sensors) Fix type of 'config' in struct
>>      hwmon_channel_info to u64
>>    hwmon: (mr75203) Fix the type of 'config' in struct 
>> hwmon_channel_info
>>      to u64
>>    hwmon: (pwm-fan) Fix the type of 'config' in struct 
>> hwmon_channel_info
>>      to u64
>>    hwmon: (scmi-hwmon) Fix the type of 'config' in struct
>>      hwmon_channel_info to u64
>>    hwmon: (tmp401) Fix the type of 'config' in struct hwmon_channel_info
>>      to u64
>>    hwmon: (tmp421) Fix the type of 'config' in struct hwmon_channel_info
>>      to u64
>>    net/mlx5: Fix the type of 'config' in struct hwmon_channel_info to 
>> u64
>>    platform/x86: dell-ddv: Fix the type of 'config' in struct
>>      hwmon_channel_info to u64
>>    hwmon: (asus-ec-sensors) Fix the type of 'config' in struct
>>      hwmon_channel_info to u64
>>    hwmon: (lm90) Fix the type of 'config' in struct 
>> hwmon_channel_info to
>>      u64
>>
>>   drivers/hwmon/asus-ec-sensors.c               |   6 +-
>>   drivers/hwmon/asus_wmi_sensors.c              |   8 +-
>>   drivers/hwmon/hp-wmi-sensors.c                |   6 +-
>>   drivers/hwmon/hwmon.c                         |   4 +-
>>   drivers/hwmon/lm90.c                          |   4 +-
>>   drivers/hwmon/mr75203.c                       |   6 +-
>>   drivers/hwmon/pwm-fan.c                       |   4 +-
>>   drivers/hwmon/scmi-hwmon.c                    |   6 +-
>>   drivers/hwmon/tmp401.c                        |   4 +-
>>   drivers/hwmon/tmp421.c                        |   2 +-
>>   drivers/media/i2c/video-i2c.c                 |  12 +-
>>   .../ethernet/aquantia/atlantic/aq_drvinfo.c   |  14 +-
>>   .../net/ethernet/mellanox/mlx5/core/hwmon.c   |   8 +-
>>   .../net/ethernet/netronome/nfp/nfp_hwmon.c    |  40 +--
>>   drivers/net/phy/aquantia/aquantia_hwmon.c     |  32 +-
>>   drivers/net/phy/marvell.c                     |  24 +-
>>   drivers/net/phy/marvell10g.c                  |  24 +-
>>   drivers/platform/x86/dell/dell-wmi-ddv.c      |   6 +-
>>   drivers/rtc/rtc-ab-eoz9.c                     |  24 +-
>>   drivers/rtc/rtc-ds3232.c                      |  24 +-
>>   drivers/w1/slaves/w1_therm.c                  |  12 +-
>>   include/linux/hwmon.h                         | 300 +++++++++---------
>>   22 files changed, 205 insertions(+), 365 deletions(-)
>>
> .

