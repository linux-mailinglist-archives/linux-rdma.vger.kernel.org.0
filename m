Return-Path: <linux-rdma+bounces-775-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 419A483EE54
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jan 2024 17:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC4F1F22DDF
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jan 2024 16:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D582C87A;
	Sat, 27 Jan 2024 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gZ8ff1Xz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BDF2C6B0;
	Sat, 27 Jan 2024 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372308; cv=none; b=NQjNXBIfiMfXt2FkALY12Htxg+7J1PZRNBjDj6Qm0+WudR48lY7u0ZQp/rb6nT3YTqXyCnFNS/mp7st2aINfnX1/x5BQvu+S33sOaML2mB1pryQA/GhCGp66sMmXVX0E/146cgP61VgVxenxTMn3YX1lraKJLyxw1+PqH9Iy48I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372308; c=relaxed/simple;
	bh=IbQ9l1hVz0C4qu+GOHbCmVmS3NyAmVNSZ0QYxsyHvWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRkgg6UKbHO6hYHOjdM+RVY/4tI617Kx0ui8FFkMx79NXJvW6w5n5J4X2o4eY8LwXKtTYBFBHHsXeGgSmrv11WnyRcqzab12UQqRNwEvSmEibgtsL5M3KX+v1ZQaZzBAoDORgIEwqdAIx5CB9sCJCJhgSWaqxiK5kVIZx4qQJwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gZ8ff1Xz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=XJWCJ9vnXiZ+XqThJeYYorMwdW5v3gaxGN+6WmhiHKk=; b=gZ8ff1Xz3PUauddr4U1OYkNbBF
	JO1AM5nKecFduDggbJlEuYM6mCViFVERLdq6Hec2vQSokyp9Brq0xTY1I7nby8/oxT1h02zZA+qj0
	z2qAMYnaQRPm0xyn7gt4Or+aiq96ZRZa7p+WcfLRS14D1giBH8ATF6keqkqCCxKmSaxx/VIeYuYgk
	D+p9F5AvsfCLhr8wkEgMAggxT0G7MsGhqEryaN7FapSqtSYTmG4Le9waGcU0lIPvfyChr+6gpA9g/
	ZWNFBO1iwPADLs8GaQDX0fJ0OBr+BRg2+THSDb9wVhWm4JzdW3iIGw/4r+pLTFMpI5EoUojksJPHS
	H+xD9tgA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTlNx-00000007jwf-1v9i;
	Sat, 27 Jan 2024 16:18:25 +0000
Message-ID: <365902d0-c5cd-48a0-b779-ef48913297b6@infradead.org>
Date: Sat, 27 Jan 2024 08:18:22 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux Kernel Bug] UBSAN: array-index-out-of-bounds in
 rds_cmsg_recv
Content-Language: en-US
To: Allison Henderson <allison.henderson@oracle.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Santosh Shilimkar <santosh.shilimkar@oracle.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
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
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <8dc57a5a51783495878c9f43f2fc39d6898dd043.camel@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/26/24 16:00, Allison Henderson wrote:
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
>>>>>  ) while
>>>>> `j` is the value stored in another array `rs->rs_rx_trace`
>>>>> (
>>>>> https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.
>>>>> 7/source/net/rds/recv.c*L583__;Iw!!ACWV5N9M2RV99hQ!J8QGG3fi_O0g
>>>>> 6p3oOboqNj5BuTcMuLuF-7-
>>>>> SATmNj8EFTKyC68co6cnoG6LQzY1lJ9M_XA6voErOfj-qXTq3BVTaaNkx$ ),
>>>>> which is sent from others and could be arbitrary value.
>>>>
>>>> I recommend to use the latest rds to make tests. The rds in linux
>>>> kernel upstream is too old. The rds in oracle linux is newer.
>>>
>>> Why is the upstream kernel lagging behind?  Is the RDS maintainer
>>> going
>>> to submit patches to update mainline?
>>
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
> 
> The challenge with updateing rds in upstream is that the uek rds
> diverged from upstream a long time ago.  So most of the uek patches
> wont apply very well with a pretty big revert to bring it back to the
> point of divergence.  It not entirly clear how much rds is used outside
> of oracle linux, but we are looking at how we might go about updating
> at least the rds_tcp module, as we think this area would have less
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

Thanks for the update.

> 
>>
>>>
>>> Thanks.
>>>
>>>> Zhu Yanjun
>>>>
>>>>>
>>>>> This crash might be exploited to read the value out-of-bound
>>>>> from the
>>>>> array by setting arbitrary values for the array `rs-
>>>>>> rs_rx_trace`.
>>>>>
>>>>> If you have any questions or require more information, please
>>>>> feel
>>>>> free to contact us.
>>>>>
>>>>> Best,
>>>>> Chenyuan
>>>>
>>>>
>>>
>>
>>
> 

-- 
#Randy

