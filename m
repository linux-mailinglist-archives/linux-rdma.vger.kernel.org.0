Return-Path: <linux-rdma+bounces-4430-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB89F957E9D
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2024 08:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DFFE1F24E5D
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2024 06:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400851B813;
	Tue, 20 Aug 2024 06:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="giZ6BvOJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C317A1849
	for <linux-rdma@vger.kernel.org>; Tue, 20 Aug 2024 06:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724136619; cv=none; b=Bnzwub+GPs3cZYs/2sRsIgEYiy7/0mels2Pq8NXz8WYvoD2ggaWKZcdK7KhbDeUpdNhDN4ViQ+4zBpiTtwcOxGAcd8qzDbAu9ACsTsbvwAGmve9oqNU1B8RydkjNUAEGzPUgJWf9udvWLjSG7vdIAyiG7uSSWTNR5zKFTzBtYOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724136619; c=relaxed/simple;
	bh=/dpjJTf8tBHWSnU/+F0fahUfvzQNQ0zSTFsvNKsMPc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxBxCMcDitE0IlbR/AkaahCVj0eH/YoieLD4rHdJJBLCKps55tf+Djn9DDZwQrMefAP2G0jslyv6eAzYcYk8BLGfXvlZCteoJBU47x6toH4RtPGKYl72csisENzlxCZvKE0fXDqTzRqEOTKZ/UnksoXmrnbe9FyeH7zBYX8a5G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=giZ6BvOJ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d61bcb00-301c-400e-9738-b4ec5463f1b9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724136614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cddEREqh8r33aqRjZQeizDrZj/6ggFfx+uuliKO6eFk=;
	b=giZ6BvOJ9Mz2x7pg+Js9ECMc46tCHMGw6iilF2Up1DlTFJecezcXgqNG7EGM5h2/yw0zQb
	1pc+jJd9tHWgWEs4iPfTxC29/YDjSlEvQ35a1MYL1SMrTf0taK4IAFdN3uj8R5BzjpLVRB
	uVno7PnYoQhjeY7uvTVbk2aPW54vN0A=
Date: Tue, 20 Aug 2024 14:50:05 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [linus:master] [RDMA/iwcm] aee2424246:
 WARNING:at_kernel/workqueue.c:#check_flush_dependency
To: Oliver Sang <oliver.sang@intel.com>
Cc: Bart Van Assche <bvanassche@acm.org>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-rdma@vger.kernel.org
References: <202408151633.fc01893c-oliver.sang@intel.com>
 <c64a2f6e-ea18-4e8d-b808-0f1732c6d004@linux.dev>
 <4254277c-2037-44bc-9756-c32b41c01bdf@linux.dev>
 <717ccc9e-87e0-49da-a26c-d8a0d3c5d8f8@linux.dev>
 <3411d2cd-1aa5-4648-9c30-3ea5228f111f@acm.org>
 <5377e3e7-9644-4e71-8d2f-b34b2b5ae676@linux.dev>
 <ZsGTtLzYjawssOs9@xsang-OptiPlex-9020> <ZsP0ae1Y5ztsqFj1@xsang-OptiPlex-9020>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <ZsP0ae1Y5ztsqFj1@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/8/20 9:42, Oliver Sang 写道:
> hi, Zhu Yanjun,
>
> On Sun, Aug 18, 2024 at 02:24:52PM +0800, Oliver Sang wrote:
>> hi, Yanjun.Zhu,
>>
>> On Sat, Aug 17, 2024 at 04:46:23PM +0800, Zhu Yanjun wrote:
>>> 在 2024/8/17 1:10, Bart Van Assche 写道:
>>>> On 8/16/24 5:49 AM, Zhu Yanjun wrote:
>>>>> Hi, kernel test robot
>>>>>
>>>>> Please help to make tests with the following commits.
>>>>>
>>>>> Please let us know the result.
>>>> I don't think that the kernel test robot understands the above request.
>>> Got it. I do not know how to let test robot make tests with this patch.^_^
>> we can test the patch for you. just cannot test quickly due to resource
>> constraint. will let you know the results in one or two days. thanks
> the WARNING is random in our tests. for aee2424246, it shows up 6 times in 20
> runs as below table.
>
> the "e0cc1e2cd74a66b5252ea674a26" is just your fix patch.
>
> we run it to 100 times, and the issue doesn't show.
>
> Tested-by: kernel test robot <oliver.sang@intel.com>

Thanks a lot for your tests. I will send out the latest patch very soon.

Zhu Yanjun

>
> a1babdb5b615751e aee2424246f9f1dadc33faa7899 e0cc1e2cd74a66b5252ea674a26
> ---------------- --------------------------- ---------------------------
>         fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
>             |             |             |             |             |
>             :20          30%           6:20           0%            :100   dmesg.RIP:check_flush_dependency
>             :20          30%           6:20           0%            :100   dmesg.WARNING:at_kernel/workqueue.c:#check_flush_dependency
>
>
>>> Follow your advice, I have sent out a patch to rdma maillist. Please review.
>>>
>>> Best Regards,
>>>
>>> Zhu Yanjun
>>>
>>>> Thanks,
>>>>
>>>> Bart.
>>> -- 
>>> Best Regards,
>>> Yanjun.Zhu
>>>
-- 
Best Regards,
Yanjun.Zhu


