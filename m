Return-Path: <linux-rdma+bounces-671-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E603835D4F
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 09:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4BDAB25640
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 08:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFC739843;
	Mon, 22 Jan 2024 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kTk+oUuT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD9F3D54E
	for <linux-rdma@vger.kernel.org>; Mon, 22 Jan 2024 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913365; cv=none; b=O90L/xpRGttnaOlKcF4JODFJaiLt8Gp0JqRLHE857men9N37AAdh+yWxcXBH3ZAIHQhH/BQCgpN88lSoP++P0ykka4KqAmJdMs+DvBuPv6L+jVgSgFOBWR80afErpUnkcORhjh+mCxzA2hcjVz11FH+st7ksydyBWG4pXBq1QzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913365; c=relaxed/simple;
	bh=bNH3ZpjBAKn5TeoM1nK6+6sD5RKl/6zFsJkHG6oXOcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUPrphX8XrH6ythrTaxL5lbvq+PqVd9zfd+/WvUfzuRo6Kc0kYeI+0Zo2coPdFPoGoH+MHhsR6JSj9c/BHdxRIdOIlQwgHBovEwsS/nj6uV0z0z34vSdUxgwcKii9LmljXSTupbX/Tm4vO4tVO0btFiAaiesI+kbcjY2faeVoko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kTk+oUuT; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9f7eb287-543f-4865-90ca-b853e04ff126@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705913361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lRUsv1GPag3hvBW68P9fUo86vXVS9tXvByMFvo4Foag=;
	b=kTk+oUuTs9giJlWOdBKKx8r081rAhh+zGj7csG9qyiKpSD4wl63zcvowgcm8CtZn/Nwa7w
	r8Q8DGiof+Fi5lVNBXd+6LMthdA1SF4IK2fZGFojGHqmjw6y9z8xvuApt8DPH06PZstbK5
	uMTQSkdtb7NYjFy628QGNQHtKh9eJKs=
Date: Mon, 22 Jan 2024 16:49:07 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Linux Kernel Bug] UBSAN: array-index-out-of-bounds in
 rds_cmsg_recv
To: Randy Dunlap <rdunlap@infradead.org>, Chenyuan Yang
 <chenyuan0y@gmail.com>, santosh.shilimkar@oracle.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, "syzkaller@googlegroups.com"
 <syzkaller@googlegroups.com>, Zijie Zhao <zzjas98@gmail.com>
References: <CALGdzuoVdq-wtQ4Az9iottBqC5cv9ZhcE5q8N7LfYFvkRsOVcw@mail.gmail.com>
 <27319d3d-61dd-41e3-be6c-ccc08b9b3688@linux.dev>
 <c4cd5048-1838-4464-ba79-26cc595e380f@infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <c4cd5048-1838-4464-ba79-26cc595e380f@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/1/22 13:48, Randy Dunlap 写道:
> Hi,
> 
> 
> On 1/21/24 00:34, Zhu Yanjun wrote:
>> 在 2024/1/19 22:29, Chenyuan Yang 写道:
>>> Dear Linux Kernel Developers for Network RDS,
>>>
>>> We encountered "UBSAN: array-index-out-of-bounds in rds_cmsg_recv"
>>> when testing the RDS with our generated specifications. The C
>>> reproduce program and logs for this crash are attached.
>>>
>>> This crash happens when RDS receives messages by using
>>> `rds_cmsg_recv`, which reads the `j+1` index of the array
>>> `inc->i_rx_lat_trace`
>>> (https://elixir.bootlin.com/linux/v6.7/source/net/rds/recv.c#L585).
>>> The length of `inc->i_rx_lat_trace` array is 4 (defined by
>>> `RDS_RX_MAX_TRACES`,
>>> https://elixir.bootlin.com/linux/v6.7/source/net/rds/rds.h#L289) while
>>> `j` is the value stored in another array `rs->rs_rx_trace`
>>> (https://elixir.bootlin.com/linux/v6.7/source/net/rds/recv.c#L583),
>>> which is sent from others and could be arbitrary value.
>>
>> I recommend to use the latest rds to make tests. The rds in linux kernel upstream is too old. The rds in oracle linux is newer.
> 
> Why is the upstream kernel lagging behind?  Is the RDS maintainer going
> to submit patches to update mainline?

When I was in Oracle and worked with RDS, I have planned to upgrade 
kernel rds to the latest. But after I submitted several patch series, 
Oracle Developing Center of China was shutdown. I can not finish the 
plan. But the UEK kernel in Oracle linux has the latest RDS.

If you want to make tests with rds, I recommend to use UEK kernel in 
Oracle Linux.

Or you can install UEK kernel in RedHat. IMO, this UEK kernel can also 
work in RedHat Linux.

Zhu Yanjun

> 
> Thanks.
> 
>> Zhu Yanjun
>>
>>>
>>> This crash might be exploited to read the value out-of-bound from the
>>> array by setting arbitrary values for the array `rs->rs_rx_trace`.
>>>
>>> If you have any questions or require more information, please feel
>>> free to contact us.
>>>
>>> Best,
>>> Chenyuan
>>
>>
> 


