Return-Path: <linux-rdma+bounces-1202-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0BC8702D1
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Mar 2024 14:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182A21C23BF5
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Mar 2024 13:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1297A3FB15;
	Mon,  4 Mar 2024 13:33:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62143FB07;
	Mon,  4 Mar 2024 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559197; cv=none; b=POM1bgKQoYWUekHjaK78nbrVJmeFJVQVP2FrU82ZP4fGZ0pLNh6O2HeP7KyEQkrh1Ajp2XrNkAl3ElxkDqodhQXhLT7PAcaFd/x7j+D+H1itgEPfxhLNr3qbwIxdYzcWc5/2NwIvVS3Lxhopo0gDOKHk2/QE0TtidMMAQurpbM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559197; c=relaxed/simple;
	bh=p3LIkl9rC/cvDmNDiTkY3DxMJpyCd0pKeUzStd2zvqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P4MNNgKRl1J5jjeF3ZVSlazGcKMgqkkVOq2X6I2j5GhfvDzfV4Gjk4ONrRXJyjiuwvRiGeE0deCeEhA1zaSI978w3387yjZHXIl8A0Y3+JpgOxHyon7xo/WQ0srEO/R5pOlwbaVCyp9q76ca5hiPdLdjYp1lo9QdVuXJneCRQcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TpKMX0RY4z2BfBT;
	Mon,  4 Mar 2024 21:30:48 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (unknown [7.193.23.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 865B4140118;
	Mon,  4 Mar 2024 21:33:07 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 21:33:06 +0800
Message-ID: <c6826eab-3e12-48fb-8e8a-e347571b1446@huawei.com>
Date: Mon, 4 Mar 2024 21:33:05 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/restrack: Fix potential invalid address access
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240301095514.3598280-1-haowenchao2@huawei.com>
 <20240303125737.GB112581@unreal>
 <a7b2409c-4a3b-472d-a23a-87b12530be6d@huawei.com>
 <20240304073548.GA13620@unreal>
From: Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <20240304073548.GA13620@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600012.china.huawei.com (7.193.23.74)

On 2024/3/4 15:35, Leon Romanovsky wrote:
> On Mon, Mar 04, 2024 at 11:21:19AM +0800, Wenchao Hao wrote:
>> On 2024/3/3 20:57, Leon Romanovsky wrote:
>>> On Fri, Mar 01, 2024 at 05:55:15PM +0800, Wenchao Hao wrote:
>>>> struct rdma_restrack_entry's kern_name was set to KBUILD_MODNAME
>>>> in ib_create_cq(), while if the module exited but forgot del this
>>>> rdma_restrack_entry, it would cause a invalid address access in
>>>> rdma_restrack_clean() when print the owner of this rdma_restrack_entry.
>>>
>>> How is it possible to exit owner module without cleaning the resources?
>>>
>>
>> I meet this issue with one of our product who develop their owner kernel
>> modules based on ib_core, and there are terrible logic with the exit
>> code which cause resource leak.
>>
>> Of curse it's bug of module who did not clear resource when exit, but
>> I think ib_core should avoid accessing memory of other modules directly
>> to provides better stability.
>>
>> What's more, from the context of rdma_restrack_clean() when print
>> "restack: %s %s object allocated by %s is not freed ...", it seems
>> designed for the above scene where client has bug to alerts there
>> are resource leak, so we should not panic on this log print.
> 
> Can you please share the kernel panic?
> 

Sorry, there is no stack or panic info recorded. This is because
another issue of "printk". It seems printk would cause a deadlock
when printk access invalid address with our kernel.

Actually, I found this issue with ftrace/kprobe but not printk, that's
why it takes me a long time to address it.

BTW, I am not developer of rdma, after found the issue, I think it's
better to enhance, so send this patch, and the patch has been tested with
the origin scene.

> Thanks


