Return-Path: <linux-rdma+bounces-7168-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7598A18ABD
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 04:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76C416B430
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 03:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF88415B0F2;
	Wed, 22 Jan 2025 03:36:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE853219FC;
	Wed, 22 Jan 2025 03:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737516982; cv=none; b=nTTjK9GLzaHXYccoNFRk/dRTWIYliDnDHHV5jQ020z9ih0qHeeBOBLlRV3zF3cuwDfTpH/L+1gi65cJs/0jTYkfwUKbDvE0t0LNNjKrwZ0E8t2MzGhlAJjCNGXKyXV4ujuIvnMUKt2AvVCf8SoazdDt+NuMrdFN28Scsx/OrbZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737516982; c=relaxed/simple;
	bh=08NVmOQnkwz3F7FGT5VoLrbPemX14WP+GpsIGUev6NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oBmRO/Kuu32QS4dDYViOGMYH3FCt+hocUh9IoVYIUTZQ1vnVRu4S/S40mFRnt0SVarEdGhTW9u06BrW5Go2+5JAjM7x0+N/ePWpS5ws0Wganaka1QGw2afZZmuybqOUL3t0/ydKmoHS1uLIffeDP/TeSXF9AsnIVuy+B8gtBUQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Yd8ps518lz1JHkG;
	Wed, 22 Jan 2025 11:35:17 +0800 (CST)
Received: from dggemv703-chm.china.huawei.com (unknown [10.3.19.46])
	by mail.maildlp.com (Postfix) with ESMTPS id CA4FD180044;
	Wed, 22 Jan 2025 11:36:17 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 Jan 2025 11:36:17 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 22 Jan
 2025 11:36:15 +0800
Message-ID: <c7cdc9cb-e10f-097e-bd53-bca9b3e2c8d4@huawei.com>
Date: Wed, 22 Jan 2025 11:36:14 +0800
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
To: Guenter Roeck <linux@roeck-us.net>, Armin Wolf <W_Armin@gmx.de>,
	<linux-hwmon@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <arm-scmi@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
	<oss-drivers@corigine.com>, <linux-rdma@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>, <linuxarm@huawei.com>,
	<jdelvare@suse.com>, <kernel@maidavale.org>, <pauk.denis@gmail.com>,
	<james@equiv.tech>, <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
	<matt@ranostay.sg>, <mchehab@kernel.org>, <irusskikh@marvell.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>, <tariqt@nvidia.com>, <louis.peens@corigine.com>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <kabel@kernel.org>,
	<hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<alexandre.belloni@bootlin.com>, <krzk@kernel.org>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <liuyonglong@huawei.com>
References: <20250121064519.18974-1-lihuisong@huawei.com>
 <03b138e9-688f-4ebc-bd01-3d54fd20e525@gmx.de>
 <9add68ac-7d10-4011-9da8-1f2de077d3e9@roeck-us.net>
 <fd412ce2-ec40-fe73-6b1b-284a99a39f12@huawei.com>
 <b965f04e-a706-4abf-89ed-4749a2c0b9b9@roeck-us.net>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <b965f04e-a706-4abf-89ed-4749a2c0b9b9@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/1/22 11:19, Guenter Roeck 写道:
> On 1/21/25 18:52, lihuisong (C) wrote:
>
>>> Those are not hwmon attributes and should not be (or have been) exposed
>>> as sysfs attributes in the first place, but (if really wanted/needed)
>>> through debugfs files. Even _if_ exposed as sysfs attributes they 
>>> should
>>> not have the power1_ prefix (except maybe for the last one).
>> I plan to accept the suggestion Armin proposed that acpi_power_meter 
>> can use the "extra_groups" parameter for these "not generic hwmon 
>> power attributes".
>> Should we drop the power1_ prefix? But this will lead to the change 
>> of these attributes.
>> Do you mean 'power1_is_battery' can be added to hwmon power 
>> attributes in hwmon.h?
>
> No; power1_is_battery is still not a hardware monitoring attribute,
> much less one to standardize. Also, don't change any attribute names.
> They are wrong, but they are the ABI for this driver.
>
Ok, it's clear now.
> .

