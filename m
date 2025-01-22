Return-Path: <linux-rdma+bounces-7172-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EE2A18B78
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 06:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033EB188C07E
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 05:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7580319341F;
	Wed, 22 Jan 2025 05:58:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B778F196;
	Wed, 22 Jan 2025 05:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737525481; cv=none; b=ckON1AiiaxhWv+6luaCcEUyrYEApDLNNms5Q4ADZJrVtrO+s4qpuInsax0ydhJ/TELY8ikAQsO9P7DwfDpu0bdJ5Dhr2D8NdAlCmNxXE0gf/k69VCv1OgWl0HXL8VWegtNHZCNARgML8QjI5jQrnvNIHn/u3tMwnP7s9R48j53g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737525481; c=relaxed/simple;
	bh=eoz/E3K902Ol8UoKvHfkLNgPA4v2w2hHa2uiTZoppPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NZe/zbXv2/8GIn+qq+eEIsP67edZnQzW7pQygRvXtHcBjHOVM15ttBxeeSi0dJhvA68VGu0/I+1xlTuWYdgiKT2mzQlncNHpCDJ/iYH9/0RNExONCkRv6+3RDGKfXymHTrAmB6XG2/IwxUO0SaDXND2fbbiTq3EdomCFRvkIBTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YdCxW310SzmZ87;
	Wed, 22 Jan 2025 13:56:15 +0800 (CST)
Received: from dggemv703-chm.china.huawei.com (unknown [10.3.19.46])
	by mail.maildlp.com (Postfix) with ESMTPS id 4DF251400D1;
	Wed, 22 Jan 2025 13:57:54 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 Jan 2025 13:57:54 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 22 Jan
 2025 13:57:52 +0800
Message-ID: <ef34bf8a-c8d9-13bb-011c-6a4365bb3cb8@huawei.com>
Date: Wed, 22 Jan 2025 13:57:51 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 19/21] platform/x86: dell-ddv: Fix the type of 'config'
 in struct hwmon_channel_info to u64
To: =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-hwmon@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<arm-scmi@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, <oss-drivers@corigine.com>,
	<linux-rdma@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<linuxarm@huawei.com>, <linux@roeck-us.net>, <jdelvare@suse.com>,
	<kernel@maidavale.org>, <pauk.denis@gmail.com>, <james@equiv.tech>,
	<sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <matt@ranostay.sg>,
	<mchehab@kernel.org>, <irusskikh@marvell.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<tariqt@nvidia.com>, <louis.peens@corigine.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <kabel@kernel.org>, <W_Armin@gmx.de>, Hans de Goede
	<hdegoede@redhat.com>, <alexandre.belloni@bootlin.com>, <krzk@kernel.org>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <liuyonglong@huawei.com>
References: <20250121064519.18974-1-lihuisong@huawei.com>
 <20250121064519.18974-20-lihuisong@huawei.com>
 <844c5097-eeb7-7275-7558-83ca4e5ee4b2@linux.intel.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <844c5097-eeb7-7275-7558-83ca4e5ee4b2@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/1/21 20:18, Ilpo Järvinen 写道:
> On Tue, 21 Jan 2025, Huisong Li wrote:
>
>> The type of 'config' in struct hwmon_channel_info has been fixed to u64.
>> Modify the related code in driver to avoid compiling failure.
> Does this mean that after applying part of your series but not yet this
> patch, compile would fail? If so, it's unacceptable. At no point in a
> patch series are you allowed to cause a compile failure because it hinders
> 'git bisect' that is an important troubleshooting tool.
>
> So you might have to combine changes to drivers and API if you make an
> API change that breaks driver build until driver too is changed. Note that
> it will impact a lot how quickly your patches can be accepted as much
> higher level of coordination is usually required if your patch is touching
> things all over the place, but it cannot be avoided at times. And
> requirement of doing minimal change only will be much much higher in such
> a large scale change.
>
Ack. Thanks for your reply.
>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/platform/x86/dell/dell-wmi-ddv.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x86/dell/dell-wmi-ddv.c
>> index e75cd6e1efe6..efb2278aabb9 100644
>> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
>> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
>> @@ -86,7 +86,7 @@ struct thermal_sensor_entry {
>>   
>>   struct combined_channel_info {
>>   	struct hwmon_channel_info info;
>> -	u32 config[];
>> +	u64 config[];
>>   };
>>   
>>   struct combined_chip_info {
>> @@ -500,7 +500,7 @@ static const struct hwmon_ops dell_wmi_ddv_ops = {
>>   
>>   static struct hwmon_channel_info *dell_wmi_ddv_channel_create(struct device *dev, u64 count,
>>   							      enum hwmon_sensor_types type,
>> -							      u32 config)
>> +							      u64 config)
>>   {
>>   	struct combined_channel_info *cinfo;
>>   	int i;
>> @@ -543,7 +543,7 @@ static struct hwmon_channel_info *dell_wmi_ddv_channel_init(struct wmi_device *w
>>   							    struct dell_wmi_ddv_sensors *sensors,
>>   							    size_t entry_size,
>>   							    enum hwmon_sensor_types type,
>> -							    u32 config)
>> +							    u64 config)
>>   {
>>   	struct hwmon_channel_info *info;
>>   	int ret;
>>
> .

