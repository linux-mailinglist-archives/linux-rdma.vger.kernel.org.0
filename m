Return-Path: <linux-rdma+bounces-6727-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 045699FBD12
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 13:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF623188529D
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 12:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123371B78E7;
	Tue, 24 Dec 2024 12:05:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8086A192D76;
	Tue, 24 Dec 2024 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735041940; cv=none; b=mwGRNq4lg5zHDbmprDsEtaGfQK3P4zGt3irri0YpZInK4V4ds312FmywZenjKgApB4ibhzgC+acWlJNFLIpxvbg6xKyrhLlcKSawMTx3mTarEr+FGvPuft+tKSdH+ujHobdlNWMmFx2hxrt2IK+6sFqqj8tIPMuFyLNcZcP/GpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735041940; c=relaxed/simple;
	bh=1185hR/sw9QFuR0LPlGGod23RCiTgVKzgsCuC3Ze98Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IX3MVfm1LyhRbPiBPCSMKUrzjDXBa4qb2nA1swWVAUo7tmTBXTurmPXyBwIpw9o0gFUDR84QzFvBDlKT2GfTyi9ep1sh5sjqg4TYKIHlVMq4hCE8EOXwRZ8k6z+CB1Ah0b2urh2gqFkVO65zRB6DTLPnWq4zokNEzkwKZJMZCLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YHYRs0SV3zhZTs;
	Tue, 24 Dec 2024 20:02:49 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id BBD38180AEA;
	Tue, 24 Dec 2024 20:05:27 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Dec 2024 20:05:26 +0800
Message-ID: <ea392da6-15e1-ea62-f5f0-78e3da0874ae@hisilicon.com>
Date: Tue, 24 Dec 2024 20:05:26 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC 00/12] RDMA: Support link status events dispatching in
 ib_core
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@ziepe.ca>, <selvin.xavier@broadcom.com>,
	<chengyou@linux.alibaba.com>, <kaishen@linux.alibaba.com>,
	<mustafa.ismail@intel.com>, <tatyana.e.nikolova@intel.com>,
	<yishaih@nvidia.com>, <benve@cisco.com>, <neescoba@cisco.com>,
	<bryan-bt.tan@broadcom.com>, <vishnu.dasa@broadcom.com>,
	<zyjzyj2000@gmail.com>, <bmt@zurich.ibm.com>, <linux-rdma@vger.kernel.org>,
	<linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
	<tangchengchang@huawei.com>, <liyuyu6@huawei.com>, linux-netdev
	<netdev@vger.kernel.org>
References: <20241122105308.2150505-1-huangjunxian6@hisilicon.com>
 <20241224103224.GF171473@unreal>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20241224103224.GF171473@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/12/24 18:32, Leon Romanovsky wrote:
> On Fri, Nov 22, 2024 at 06:52:56PM +0800, Junxian Huang wrote:
>> This series is to integrate a common link status event handler in
>> ib_core as this functionality is needed by most drivers and
>> implemented in very similar patterns. This is not a new issue but
>> a restart of the previous work of our colleagues from several years
>> ago, please see [1] and [2].
>>
>> [1]: https://lore.kernel.org/linux-rdma/1570184954-21384-1-git-send-email-liweihang@hisilicon.com/
>> [2]: https://lore.kernel.org/linux-rdma/20200204082408.18728-1-liweihang@huawei.com/
>>
>> With this series, ib_core can handle netdev events of link status,
>> i.e. NETDEV_UP, NETDEV_DOWN and NETDEV_CHANGE, and dispatch ib port
>> events to ULPs instead of drivers. However some drivers currently
>> have some private processing in their handler, rather than simply
>> dispatching events. For these drivers, this series provides a new
>> ops report_port_event(). If this ops is set, ib_core will call it
>> and the events will still be handled in the driver.
>>
>> Events of LAG devices are also not handled in ib_core as currently
>> there is no way to obtain ibdev from upper netdev in ib_core. This
>> can be a TODO work after the core have more support for LAG. For
>> now mlx5 is the only driver that supports RoCE LAG, and the events
>> handling of mlx5 RoCE LAG will remain in mlx5 driver.
>>
>> In this series:
>>
>> Patch #1 adds a new helper to query the port num of a netdev
>> associated with an ibdev. This is used in the following patch.
>>
>> Patch #2 adds support for link status events dispatching in ib_core.
>>
>> Patch #3-#7 removes link status event handler in several drivers.
>> The port state setting in erdma, rxe and siw are replaced with
>> ib_get_curr_port_state(), so their handler can be totally removed.
>>
>> Patch #8-#10 add support for report_port_event() ops in usnic, mlx4
>> and pvrdma as their current handler cannot be perfectly replaced by
>> the ib_core handler in patch #2.
>>
>> Patch #11 adds a check in mlx5 that only events of RoCE LAG will be
>> handled in mlx5 driver.
>>
>> Patch #12 adds a fast path for link-down events dispatching in hns by
>> getting notified from hns3 nic driver directly.
>>
>> Yuyu Li (12):
>>   RDMA/core: Add ib_query_netdev_port() to query netdev port by IB
>>     device.
>>   RDMA/core: Support link status events dispatching
>>   RDMA/bnxt_re: Remove deliver net device event
>>   RDMA/erdma: Remove deliver net device event
>>   RDMA/irdma: Remove deliver net device event
>>   RDMA/rxe: Remove deliver net device event
>>   RDMA/siw: Remove deliver net device event
>>   RDMA/usnic: Support report_port_event() ops
>>   RDMA/mlx4: Support report_port_event() ops
>>   RDMA/pvrdma: Support report_port_event() ops
>>   RDMA/mlx5: Handle link status event only for LAG device
>>   RDMA/hns: Support fast path for link-down events dispatching
> 
> I took the series as it is good thing to remove code duplication
> and we waited enough.
> 

Thanks Leon.

The kernel test robot has reported one warning and one error for
this series:

https://lore.kernel.org/oe-kbuild-all/202411251625.VrcLuTRx-lkp@intel.com/
https://lore.kernel.org/oe-kbuild-all/202411251727.RFxtcpiI-lkp@intel.com/

I was planning to fix them when I could send the formal patches,
but since you have applied these RFC patches，could you please
fix them on your wip branch, or should I send separate patches
to fix them?

Junxian

