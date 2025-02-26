Return-Path: <linux-rdma+bounces-8118-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBB8A45A87
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 10:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02891894122
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 09:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD78E226CFD;
	Wed, 26 Feb 2025 09:46:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C572459C5
	for <linux-rdma@vger.kernel.org>; Wed, 26 Feb 2025 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563181; cv=none; b=RkqDF4mb1DC+HqG+1TGlFsaXlgo5+VpSiYEozQ7ZVz2iG3OhI7Fa8x4+5cm9kI3+gPYgiry0LB5O9nGdgIT9vfCwY9lr3dXK7oA6JYObEnNuwN53QFCgFhL1Lk9Zx+UQPi2BCnVDzFj6a1J5+arEZMMTUqwbG6W7OeLECM8qqsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563181; c=relaxed/simple;
	bh=oKRHSPmQbACsec7UgJDZXf0zbgWRqVfOOdWHDp8POEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gUoXFI5LTR+iwB+OpePY4EtSiUiikaTmXl/O6+UEnnP8g4ChO4uUcxsYIyi7iOqATLm8S/5K+ljnIlZcgUlw77kp159OBD3POU7GuTR2V0csvUUX++EgNE1hbGCsZ+4C9lTSC6/3O2wBbeD5BoJhKWrUJLqTmT4J8d07wlDYt3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Z2qPM0PQ7z17NVc;
	Wed, 26 Feb 2025 17:46:47 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id C8AC6140451;
	Wed, 26 Feb 2025 17:46:14 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 26 Feb 2025 17:46:13 +0800
Message-ID: <f5e1b589-d9a6-04c4-dffd-9aa3d2e77ab1@hisilicon.com>
Date: Wed, 26 Feb 2025 17:46:12 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH for-next 0/4] RDMA/hns: Introduce delay-destruction
 mechanism
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<linuxarm@huawei.com>, <tangchengchang@huawei.com>
References: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
 <20250219121454.GE53094@unreal>
 <bb0a621e-78e1-c030-f8f6-e175978acf0f@hisilicon.com>
 <20250219143523.GH53094@unreal>
 <e8e09f3e-a8f9-429a-ac60-272db35f25fb@hisilicon.com>
 <20250220141059.GV3696814@ziepe.ca>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20250220141059.GV3696814@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2025/2/20 22:10, Jason Gunthorpe wrote:
> On Thu, Feb 20, 2025 at 11:48:49AM +0800, Junxian Huang wrote:
> 
>> Driver notifies HW about the memory release with mailbox. The procedure
>> of a mailbox is:
>> 	a) driver posts the mailbox to FW
>> 	b) FW writes the mailbox data into HW
>>
>> In this scenario, step a) will fail due to the FW reset, HW won't get
>> notified and thus may lead to UAF.
> 
> That's just wrong, a FW reset must fully stop and sanitize the HW as
> well. You can't have HW running rouge with no way for FW to control it
> anymore.
> 

I agree, but there is a small time gap between the start of FW reset
and the stop of HW. Please see my earlier reply today.

Thanks,
Junxian

> Jason

