Return-Path: <linux-rdma+bounces-5306-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F1E994454
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 11:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A55C281015
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 09:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D568F17C21E;
	Tue,  8 Oct 2024 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CcY1caTQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C57A1667DA
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 09:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379920; cv=none; b=cngSzkRzY67dxujoMLw7+DK20WfIj1NutDo3QhLdkXH/sF+ZsDaFqO/RGsYP0YWhFPkNVOMAnSWKxdxBKg+KM54lSpDWWYDJ1m0SkqTaqGCggaQIpZcvg480uYiWgRLNBwFnAELA1xcrn6s/yQe8qDkmR7O5T0CPkneOGwFsHQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379920; c=relaxed/simple;
	bh=t8vpajiPE2txeYeHQN3s/lukNZrc3RUcMG2Olyx68MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WcDJj+ZKyZbTS7Dcd8NIMtNKYzijN8qOPKweVIu3MCfidLy9UZxDSJGDrBrz4dg8X3zLK7NSaqOjMRvtvVMpjmkixvp+ZioWezaYCJig6yaybE/JSntYq7e35WoM5OSidzS2MEFK1CZGE7QZwXLzLUzZIKXqd0aOpKqGLDM7GhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CcY1caTQ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3cecfd89-b6a6-47cc-8361-de6be943cf80@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728379915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uyDX2hRvovTAYvoIws3jWRBwqsnw6pkBjgs4txlDDoM=;
	b=CcY1caTQRvy4cJ98Nts2DNWBdQvgC/IRAcqwXBDITgutCeHUejmWXQBSV9kRA7MjDxt5qD
	3g8cZYJMwj7v8TRI4Kvgeu/uJlL//rhOtYj1wzjnFP9UBvv1MzhnqUCGB7nt65cVKVrnia
	z9u3zmO0VbpIKRmaXadFKyYvvFSeiWA=
Date: Tue, 8 Oct 2024 17:31:37 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
To: Leon Romanovsky <leon@kernel.org>, Michael Galaxy <mgalaxy@akamai.com>
Cc: Yu Zhang <yu.zhang@ionos.com>, Sean Hefty <shefty@nvidia.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "elmar.gerdes@ionos.com" <elmar.gerdes@ionos.com>,
 zhengchuan <zhengchuan@huawei.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Xiexiangyou <xiexiangyou@huawei.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "lixiao (H)" <lixiao91@huawei.com>,
 "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
 Wangjialin <wangjialin23@huawei.com>
References: <DM6PR12MB431364C7A2D94609B4AAF9A8BD6B2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com> <Zvrq7nSbiLfPQoIY@x1n>
 <DM6PR12MB4313D6BA256740DE1ACA29E9BD762@DM6PR12MB4313.namprd12.prod.outlook.com>
 <ZvsAV0MugV85HuZf@x1n> <c24fa344-0add-477d-8ed3-bf2e91550e0b@akamai.com>
 <Zv8P8uQmSowF8sGl@x1n> <6211c525-0b9b-4eba-ac3c-2ac796c8ec83@akamai.com>
 <CAHEcVy7_WveokcN+3J2Qqxg8oJ1BT8sNoU2qUHeU8oZWwVyS6g@mail.gmail.com>
 <856d4f0e-8742-4848-acc5-dbaa5d21c9fd@akamai.com>
 <20241007181513.GC25819@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20241007181513.GC25819@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/10/8 2:15, Leon Romanovsky 写道:
> On Mon, Oct 07, 2024 at 08:45:07AM -0500, Michael Galaxy wrote:
>> Hi,
>>
>> On 10/7/24 03:47, Yu Zhang wrote:
>>> !-------------------------------------------------------------------|
>>>     This Message Is From an External Sender
>>>     This message came from outside your organization.
>>> |-------------------------------------------------------------------!
>>>
>>> Sure, as we talked at the KVM Forum, a possible approach is to set up
>>> two VMs on a physical host, configure the SoftRoCE, and run the
>>> migration test in two nested VMs to ensure that the migration data
>>> traffic goes through the emulated RDMA hardware. I will continue with
>>> this and let you know.
>>>
>> Acknowledged. Do share if you have any problems with it, like if it has
>> compatibility issues
>> or if we need a different solution. We're open to change.
>>
>> I'm not familiar with the "current state" of this or how well it would even
>> work.
> 
> Any compatibility issue between versions of RXE (SoftRoCE) or between
> RXE and real devices is a bug in RXE, which should be fixed.
> 
> RXE is expected to be compatible with rest RoCE devices, both virtual
> and physical.

 From my tests, about physical RoCE devices, for example, Nvidia MLX5 
and intel E810 (iRDMA), if RDMA feature is disabled on those devices. 
RXE can work well with them.

About Virtual devices, most virtual devices can work well with RXE, for 
example,bonding, veth. I have done a lot of tests with them.

If some virtual devices can not work well with RXE, please share the 
error messages in RDMA maillist.

Zhu Yanjun

> 
> Thanks
> 
>>
>> - Michael
>>
>>
>>> On Fri, Oct 4, 2024 at 4:06 PM Michael Galaxy <mgalaxy@akamai.com> wrote:
>>>>
>>>> On 10/3/24 16:43, Peter Xu wrote:
>>>>> !-------------------------------------------------------------------|
>>>>>      This Message Is From an External Sender
>>>>>      This message came from outside your organization.
>>>>> |-------------------------------------------------------------------!
>>>>>
>>>>> On Thu, Oct 03, 2024 at 04:26:27PM -0500, Michael Galaxy wrote:
>>>>>> What about the testing solution that I mentioned?
>>>>>>
>>>>>> Does that satisfy your concerns? Or is there still a gap here that needs to
>>>>>> be met?
>>>>> I think such testing framework would be helpful, especially if we can kick
>>>>> it off in CI when preparing pull requests, then we can make sure nothing
>>>>> will break RDMA easily.
>>>>>
>>>>> Meanwhile, we still need people committed to this and actively maintain it,
>>>>> who knows the rdma code well.
>>>>>
>>>>> Thanks,
>>>>>
>>>> OK, so comments from Yu Zhang and Gonglei? Can we work up a CI test
>>>> along these lines that would ensure that future RDMA breakages are
>>>> detected more easily?
>>>>
>>>> What do you think?
>>>>
>>>> - Michael
>>>>
>>


