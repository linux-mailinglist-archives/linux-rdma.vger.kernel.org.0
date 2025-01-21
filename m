Return-Path: <linux-rdma+bounces-7145-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 271CAA17923
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 09:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F253AA2B2
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 08:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993E51B0F20;
	Tue, 21 Jan 2025 08:15:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA242145A18;
	Tue, 21 Jan 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737447304; cv=none; b=pTR3V+Gl5NmcrRermjahoFYqEKyn2LWSdk2GsTXbcuuZ37mQ3qllxe9E8a6YJvHaowsPyo+VkgTo83QWhuYtf0Hu4NySjQFe3+bcUJCpjp7aALdbxNbDVCgXs9BSbplvzYfofBUb1zhVqFzxBJ8hEBiD8xnD4fRNJtOXbPHbsQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737447304; c=relaxed/simple;
	bh=ahKx+Enfn4BHZ/bI33qcRisaH6MuqL4Vm495WshmSRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=haW+9med9PpxyyyIJSLgdUwIgfj+BQqbe0AM3ixxMsFZENM9E65hZJLdjmhuruT16eQ9KeRG9AMtlzZ8vXRS1xz6lO2pcZWKGEguI1AR9iTyFns6efNV5vTYgcDRBHGOOs9RS8pt5l/qLAF+UAU3ziYkFfCkR0lHU6gSTqlNbC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ycg0F3dPczgc2x;
	Tue, 21 Jan 2025 16:11:41 +0800 (CST)
Received: from dggemv704-chm.china.huawei.com (unknown [10.3.19.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 65860140203;
	Tue, 21 Jan 2025 16:14:52 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 Jan 2025 16:14:52 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Jan
 2025 16:14:50 +0800
Message-ID: <d42bf49b-e71b-d31e-2784-379076ebf370@huawei.com>
Date: Tue, 21 Jan 2025 16:14:49 +0800
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
To: Krzysztof Kozlowski <krzk@kernel.org>, <linux-hwmon@vger.kernel.org>
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
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <liuyonglong@huawei.com>
References: <20250121064519.18974-1-lihuisong@huawei.com>
 <870c6b3e-d4f9-4722-934e-00e9ddb84e2e@kernel.org>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <870c6b3e-d4f9-4722-934e-00e9ddb84e2e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/1/21 15:47, Krzysztof Kozlowski 写道:
> On 21/01/2025 07:44, Huisong Li wrote:
>> The hwmon_device_register() is deprecated. When I try to repace it with
>> hwmon_device_register_with_info() for acpi_power_meter driver, I found that
>> the power channel attribute in linux/hwmon.h have to extend and is more
>> than 32 after this replacement.
>>
>> However, the maximum number of hwmon channel attributes is 32 which is
>> limited by current hwmon codes. This is not good to add new channel
>> attribute for some hwmon sensor type and support more channel attribute.
>>
>> This series are aimed to do this. And also make sure that acpi_power_meter
>> driver can successfully replace the deprecated hwmon_device_register()
>> later.
> Avoid combining independent patches into one patch bomb. Or explain the
> dependencies and how is it supposed to be merged - that's why you have
> cover letter here.
These patches having a title ('Use HWMON_CHANNEL_INFO macro to simplify 
code') are also for this series.
Or we need to modify the type of the 'xxx_config' array in these patches.
If we directly use the macro HWMON_CHANNEL_INFO, the type of 'config' 
has been modifyed in patch 1/21 and these driver don't need to care this 
change.

/Huisong
>
>
> .

