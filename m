Return-Path: <linux-rdma+bounces-8117-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD80A45A60
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 10:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED63169AE9
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 09:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AAC226D08;
	Wed, 26 Feb 2025 09:38:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B04226D0E
	for <linux-rdma@vger.kernel.org>; Wed, 26 Feb 2025 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562726; cv=none; b=OdzltLL2U4FkSOmUS9WygX+LmtmnXxnwn0MCEMEbIExLtQCVkNL+F0nkuhCR7caZlFkvdzHqP5hLo5bVeW8Y7X5C1yPZHTG03/xO64B+NbcyNP4T9pho1DeydnuiOG0pgLh62v7MJpiUWG3H1797fEnjOgRkC52nAojqXhd5Kn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562726; c=relaxed/simple;
	bh=JWBl+/OvAtTp8pYzfDa7+BWVp97ctbJjY0Lb2TT8Ma0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=PBdwzu7rc1CdefQb/qV3GAaGZ6tMuhftreBRcQN6GWVNJ8bLX6mTt1bPDwsFUCjI5UaB1Sf23dBX7KrShUheYPhnXOB80AqKk+c3Mp7ArK6BmDCm2+k94MX+TgCjGgLXdlzXDojz0TLrncFTIYYq9WYR7lKNXaAinBQVSSPpTq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Z2qDW2LWPz17NTQ;
	Wed, 26 Feb 2025 17:39:07 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C55018001B;
	Wed, 26 Feb 2025 17:38:35 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 26 Feb 2025 17:38:31 +0800
Message-ID: <d2066098-9187-dc72-0c8d-dcef7384a2e4@hisilicon.com>
Date: Wed, 26 Feb 2025 17:38:29 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: Junxian Huang <huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-next 0/4] RDMA/hns: Introduce delay-destruction
 mechanism
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<linuxarm@huawei.com>, <tangchengchang@huawei.com>
References: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
 <20250219121454.GE53094@unreal>
 <bb0a621e-78e1-c030-f8f6-e175978acf0f@hisilicon.com>
 <20250219143523.GH53094@unreal>
 <e8e09f3e-a8f9-429a-ac60-272db35f25fb@hisilicon.com>
 <20250220073217.GM53094@unreal>
 <bdc9cae7-4d8c-4294-18a5-687e9b7edac8@hisilicon.com>
 <20250220090856.GO53094@unreal>
 <542860d8-34a9-b109-2a85-794149df1fe3@hisilicon.com>
 <20250220141346.GW3696814@ziepe.ca>
Content-Language: en-US
In-Reply-To: <20250220141346.GW3696814@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2025/2/20 22:13, Jason Gunthorpe wrote:
> On Thu, Feb 20, 2025 at 07:05:06PM +0800, Junxian Huang wrote:
> 
>> Mailbox carries information of the specific resource (QP/CQ/SRQ/MR)
>> that are being destroyed. It's impossible for FW to predict which
>> QP/CQ/SRQ/MR will be destroyed by driver during reset before the
>> reset starts.
> 
> That doesn't make any sense, the device reset is supposed to clean up
> everything. It doesn't matter what the mailbox was doing, after the
> reset finishes it is no longer necessary because the reset was the
> thing that cleaned it up.

Yes, our current implementation is exactly what you said. FW reset
will disable HW, trigger driver reset and clean up everything.

> 
> You need a way to track the reset completion and cancel all
> outstanding commands with a reset failure so cleanup can
> happen. Combined with disassociate and some other locking you need to
> create a strong fence across the reset where there is no leakage of
> 'before' and 'after' reset objects and kernel state.

This is also what we're trying to do now. Currently we check the
reset status in driver when posting mailbox and fail them during
the reset.

The problem is that there is a time gap between the start of FW
reset and the stop of HW, where driver's mailbox will fail while HW
may still access memory. This gap won't last long but in some extreme
cases it's still possible to cause some errors. We try to address
this with this series by reserving the memory until HW is disabled.

Thanks,
Junxian

> 
> Jason

