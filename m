Return-Path: <linux-rdma+bounces-9109-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA58A787A7
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 07:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438DE16D2E0
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 05:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67E72046B2;
	Wed,  2 Apr 2025 05:50:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A3F524C
	for <linux-rdma@vger.kernel.org>; Wed,  2 Apr 2025 05:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743573012; cv=none; b=PGGabkLlxFexbIVHtSIBI6oruK0RXC3iJbriTVSBLzyHnSEJRgRMaIbPbRz46GdQyF29uyWoZvLrMc/CfS/+LzdM0uy6QFtmsZS69sX7wol9O0RMP36ce9hHXES/eDbGUgcZZTHqJHeW90Yu14pb6My8INsCcrKuCqOeQm4KlUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743573012; c=relaxed/simple;
	bh=r30oyxvMxYlDS2Hwj9QS1efLAWRncNlUV8meslBf1zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n77zGUVEsVybaTmMGvITwBuMs8L2RAyVgpMyapNI087I8+cX17Ezf9ReVdEMWu9eDOuDsYq5q5Zgs6jQ8ZYR7hbLxlNpd1NPtss7Qt3nNLqXfk18e4ecqxkKMOhQP3DGHKi0+RV7vgTghpL9+JCPeyHn9MUWiT66RvXJAbp9Mtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZSDNZ3SWSz2TRyC;
	Wed,  2 Apr 2025 13:45:18 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E37D1402CD;
	Wed,  2 Apr 2025 13:50:06 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Apr 2025 13:50:05 +0800
Message-ID: <66ad71a6-dadb-6bb2-6dcc-0b37a78765f2@hisilicon.com>
Date: Wed, 2 Apr 2025 13:50:05 +0800
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
CC: <leon@kernel.org>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<tangchengchang@huawei.com>, <jonathan.cameron@huawei.com>
References: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
 <6e8c05f4-c925-8466-9453-214555e8772d@hisilicon.com>
 <20250401133956.GC186258@ziepe.ca>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20250401133956.GC186258@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2025/4/1 21:39, Jason Gunthorpe wrote:
> On Tue, Mar 18, 2025 at 11:23:57AM +0800, Junxian Huang wrote:
>> Hi Leon and Jason. After discussions and analysis with our FW team,
>> we've agreed that FW can stop HW to prevent HW UAF in most FW reset
>> cases.
>>
>> But there's still one case where FW cannot intervene when FW reset
>> is triggered by watchdog due to FW crash, because it is completely
>> passive for FW. So we still need these patches to prevent this
>> unlikely but still possible HW UAF case. Is this series okay to be
>> applied?
> 
> You need to have an architecture where there are clear rules about
> when HW is allowed to access DMA memory and when it is not, then
> implement accordingly. Most devices have a hard reset which is a
> strong barrier preventing DMA from crossing it. You need something
> similar.
> 
> For things like mbox failures/timeouts, a timeout means the SW cannot
> assume the devices is no longer doing DMA. It would be appropriate to
> immediately trigger the reset sequence, wait for it to reach the
> barrier, then conclude and error the mbox.
> 
> This way this:
> 
>>> When mailboxes for resource(QP/CQ/SRQ) destruction fail, it's unable
>>> to notify HW about the destruction. In this case, driver will still
>>> free the resources, while HW may still access them, thus leading to
>>> a UAF.
> 
> Changes "destruction fail" into a barrier that waits for the device to
> be fenced and DMA to be halted before returning keeping the driver
> life cycle together.
> 
> You want to avoid "destruction fail" paths that result in the device
> continuing to function.
> 

Thanks, we'll try this way.

Junxian

> Jason

