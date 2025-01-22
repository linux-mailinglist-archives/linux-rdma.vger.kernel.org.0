Return-Path: <linux-rdma+bounces-7167-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D295AA18AB6
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 04:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F8F3A4495
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 03:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3107C156F4A;
	Wed, 22 Jan 2025 03:35:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D833E186A;
	Wed, 22 Jan 2025 03:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737516901; cv=none; b=kPpFiVROwBmheE1uEO4+Um68uBBXdxXxEgJEcGCOPGIhG4n0Ei8iz1U4swcDuZvy74QLiFUiR1xR4EXwv0hWSNoVUeeJmGF2IdL7TGHLsAMTKbqXIWFzbR2XKQPXXEWqqyjLijg5JBWFrBrpflor1lqABJJCUwhLH4it7Jt7v9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737516901; c=relaxed/simple;
	bh=9+UzdScW3huxDHKv6+o/1auHOY2id/DXO1P5Vu2yYuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mQBocSYwBanfqdiiSe8bmF0qf5CQTjcEORfiCPWcBsiEw7aelKsGkb3bFhAuy+eeaQ2eyGHDAiy1bvkvI8YAFcENQ+0/1+3unCQcthcPU7364RYCPN2Bt1YZPK4LCbbj0S5QoTcjbtgfhQSLuZI7aW8O19naHlB3XM8QUzv/UgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Yd8kb6CTFz1kygS;
	Wed, 22 Jan 2025 11:31:35 +0800 (CST)
Received: from dggemv704-chm.china.huawei.com (unknown [10.3.19.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 7FC281A016C;
	Wed, 22 Jan 2025 11:34:54 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 Jan 2025 11:34:54 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 22 Jan
 2025 11:34:52 +0800
Message-ID: <4aa36466-6b22-738e-36ab-41413dd64a0c@huawei.com>
Date: Wed, 22 Jan 2025 11:34:52 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 01/21] hwmon: Fix the type of 'config' in struct
 hwmon_channel_info to u64
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
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
	<kabel@kernel.org>, <W_Armin@gmx.de>, <hdegoede@redhat.com>,
	<ilpo.jarvinen@linux.intel.com>, <alexandre.belloni@bootlin.com>,
	<krzk@kernel.org>, <jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <liuyonglong@huawei.com>
References: <20250121064519.18974-1-lihuisong@huawei.com>
 <20250121064519.18974-2-lihuisong@huawei.com>
 <Z4_T3s7zn3UQNkbW@shell.armlinux.org.uk>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <Z4_T3s7zn3UQNkbW@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/1/22 1:05, Russell King (Oracle) 写道:
> On Tue, Jan 21, 2025 at 02:44:59PM +0800, Huisong Li wrote:
>>    */
>>   struct hwmon_channel_info {
>>   	enum hwmon_sensor_types type;
>> -	const u32 *config;
>> +	const u64 *config;
>>   };
>>   
>>   #define HWMON_CHANNEL_INFO(stype, ...)		\
>>   	(&(const struct hwmon_channel_info) {	\
>>   		.type = hwmon_##stype,		\
>> -		.config = (const u32 []) {	\
>> +		.config = (const u64 []) {	\
>>   			__VA_ARGS__, 0		\
>>   		}				\
>>   	})
> I'm sorry, but... no. Just no. Have you tried building with only your
> first patch?
>
> It will cause the compiler to barf on, e.g. the following:
>
> static u32 marvell_hwmon_chip_config[] = {
> ...
>
> static const struct hwmon_channel_info marvell_hwmon_chip = {
>          .type = hwmon_chip,
>          .config = marvell_hwmon_chip_config,
> };
>
> I suggest that you rearrange your series: first, do the conversions
> to HWMON_CHANNEL_INFO() in the drivers you have.
Yes.
>
> At this point, if all the drivers that assign to hw_channel_info.config
> have been converted, this patch 1 is then suitable.
>
> If there are still drivers that assign a u32 array to
> hw_channel_info.config, then you need to consider how to handle
> that without causing regressions. You can't cast it between a u32
> array and u64 array to silence the warning, because config[1]
> won't point at the next entry.
>
> I think your only option would be to combine the conversion of struct
> hwmon_channel_info and the other drivers into a single patch. Slightly
> annoying, but without introducing more preprocessor yuckiness, I don't
> see another way.
got it. Thanks for suggestion.

