Return-Path: <linux-rdma+bounces-776-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B51A83F3A8
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jan 2024 04:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05EC31F2246D
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jan 2024 03:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9853234;
	Sun, 28 Jan 2024 03:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wfh+9Klj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962134437
	for <linux-rdma@vger.kernel.org>; Sun, 28 Jan 2024 03:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706414008; cv=none; b=oKgcuT3rAYhd7Yno1Jwu1loAX6ZfF9xJIcgKN3Vcs+o0fIQTGVAiu2mZ2zbqosi96kyq6XIJw/Y5Q/jFHgta+Npjw1N2fLdUBaPqWj/GKZSfxjvV3iBpXdWjttqJsU1kxqwzbWotUjKslsziAql10gs+yIF+hr4tl9uVUSUSCMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706414008; c=relaxed/simple;
	bh=p9oceIiYff1ioZFUJXiZ4WmFS+XrA543mWNiQEA15Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZjW9mbYfJTr90mTQUqpdkdtXauzRMYjJm+khme1tsKqNKmmreWWiNKgda3udxnonAK+BiTKcADFsqa07g46XH5KRaUvc/zM8wL5FVMdvT7exhDqpi128xrHJcDhd4PdBJTx6NyXuSeIDyCYzp+y3jjhLvbydCAhxQGx/kVOOmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wfh+9Klj; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8858652e-7506-4061-9294-c6607389eee7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706414003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bx7kb2nLdhwT2+aAS40SDU3AmuHd/VNi5jvcOCH/sVY=;
	b=Wfh+9KljeC2zR/OeXXQP9XFhVRhYfmMsgD4A2YBrzRoNl17RcaYLR6Ava4G0FnWP4OvnLP
	U/834IgnqPIL9YVkp5IGmN2nOQI/59vaqbw9d/3XYB4hAxnVBhh8td6MUkYyuhJHUhmwJL
	BSitK8jAQBx5MEZKSS//7Bmdid9suEs=
Date: Sun, 28 Jan 2024 11:53:11 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Linux Kernel Bug] UBSAN: array-index-out-of-bounds in
 rds_cmsg_recv
To: Allison Henderson <allison.henderson@oracle.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Santosh Shilimkar <santosh.shilimkar@oracle.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "chenyuan0y@gmail.com" <chenyuan0y@gmail.com>
Cc: "zzjas98@gmail.com" <zzjas98@gmail.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "syzkaller@googlegroups.com"
 <syzkaller@googlegroups.com>
References: <CALGdzuoVdq-wtQ4Az9iottBqC5cv9ZhcE5q8N7LfYFvkRsOVcw@mail.gmail.com>
 <27319d3d-61dd-41e3-be6c-ccc08b9b3688@linux.dev>
 <c4cd5048-1838-4464-ba79-26cc595e380f@infradead.org>
 <9f7eb287-543f-4865-90ca-b853e04ff126@linux.dev>
 <8dc57a5a51783495878c9f43f2fc39d6898dd043.camel@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <8dc57a5a51783495878c9f43f2fc39d6898dd043.camel@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/1/27 8:00, Allison Henderson 写道:
> On Mon, 2024-01-22 at 16:49 +0800, Zhu Yanjun wrote:
>> 在 2024/1/22 13:48, Randy Dunlap 写道:
>>> Hi,
>>>
>>>
>>> On 1/21/24 00:34, Zhu Yanjun wrote:
>>>> 在 2024/1/19 22:29, Chenyuan Yang 写道:
>>>>> Dear Linux Kernel Developers for Network RDS,
>>>>>
>>>>> We encountered "UBSAN: array-index-out-of-bounds in
>>>>> rds_cmsg_recv"
>>>>> when testing the RDS with our generated specifications. The C
>>>>> reproduce program and logs for this crash are attached.
>>>>>
>>>>> This crash happens when RDS receives messages by using
>>>>> `rds_cmsg_recv`, which reads the `j+1` index of the array
>>>>> `inc->i_rx_lat_trace`
>>>>> (
>>>>> https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.
>>>>> 7/source/net/rds/recv.c*L585__;Iw!!ACWV5N9M2RV99hQ!J8QGG3fi_O0g
>>>>> 6p3oOboqNj5BuTcMuLuF-7-
>>>>> SATmNj8EFTKyC68co6cnoG6LQzY1lJ9M_XA6voErOfj-qXTq3BSnW21Tk$ ).
>>>>> The length of `inc->i_rx_lat_trace` array is 4 (defined by
>>>>> `RDS_RX_MAX_TRACES`,
>>>>> https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.7/source/net/rds/rds.h*L289__;Iw!!ACWV5N9M2RV99hQ!J8QGG3fi_O0g6p3oOboqNj5BuTcMuLuF-7-SATmNj8EFTKyC68co6cnoG6LQzY1lJ9M_XA6voErOfj-qXTq3BYX3yVFo$
>>>>>   ) while
>>>>> `j` is the value stored in another array `rs->rs_rx_trace`
>>>>> (
>>>>> https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.
>>>>> 7/source/net/rds/recv.c*L583__;Iw!!ACWV5N9M2RV99hQ!J8QGG3fi_O0g
>>>>> 6p3oOboqNj5BuTcMuLuF-7-
>>>>> SATmNj8EFTKyC68co6cnoG6LQzY1lJ9M_XA6voErOfj-qXTq3BVTaaNkx$ ),
>>>>> which is sent from others and could be arbitrary value.
>>>> I recommend to use the latest rds to make tests. The rds in linux
>>>> kernel upstream is too old. The rds in oracle linux is newer.
>>> Why is the upstream kernel lagging behind?  Is the RDS maintainer
>>> going
>>> to submit patches to update mainline?
>> When I was in Oracle and worked with RDS, I have planned to upgrade
>> kernel rds to the latest. But after I submitted several patch series,
>> Oracle Developing Center of China was shutdown. I can not finish the
>> plan. But the UEK kernel in Oracle linux has the latest RDS.
>>
>> If you want to make tests with rds, I recommend to use UEK kernel in
>> Oracle Linux.
>>
>> Or you can install UEK kernel in RedHat. IMO, this UEK kernel can
>> also
>> work in RedHat Linux.
>>
>> Zhu Yanjun
> The challenge with updateing rds in upstream is that the uek rds
> diverged from upstream a long time ago.  So most of the uek patches
> wont apply very well with a pretty big revert to bring it back to the
> point of divergence.  It not entirly clear how much rds is used outside
> of oracle linux, but we are looking at how we might go about updating
> at least the rds_tcp module, as we think this area would have less

 From my perspective, a lot of people are more interested in rds_rdma 
module.

Exactly the gap between linux upstream and UEK is very big. But based on 
the rds features,

we can backport these features to linux upstream.

Zhu Yanjun

> patching conflicts, and may be of more interest to community folks.
> This is still very much a work in progress though, and still undergoing
> a lot of investigation, so Zhu is likley correct in that for now it's
> probably best to simply use a uek kernel if you are just wanting to
> develop test cases.
>
> Zhu, I was unaware that an effort had been submitted, but I am still
> very much learning rds.  If you want to point me to your set, I would
> be happy to study it even if it was submitted a long time ago.  Thanks!
>
> Allison
>
>>> Thanks.
>>>
>>>> Zhu Yanjun
>>>>
>>>>> This crash might be exploited to read the value out-of-bound
>>>>> from the
>>>>> array by setting arbitrary values for the array `rs-
>>>>>> rs_rx_trace`.
>>>>> If you have any questions or require more information, please
>>>>> feel
>>>>> free to contact us.
>>>>>
>>>>> Best,
>>>>> Chenyuan
>>>>
>>

