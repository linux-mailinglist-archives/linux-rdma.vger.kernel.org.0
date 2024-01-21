Return-Path: <linux-rdma+bounces-666-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD49D8354E6
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jan 2024 09:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54EF41F21970
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jan 2024 08:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699AB14F75;
	Sun, 21 Jan 2024 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ID4niUS6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC23D52E
	for <linux-rdma@vger.kernel.org>; Sun, 21 Jan 2024 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705826125; cv=none; b=agkE1yTEjyOGx7tZIHlh5UlWHBX+ZZSKi3K4SWEm4V/Am2CAYAJKBba1HG5D94f9aCdq1hWVxxBMH7feO2uV0H+Ydk4dHXvmhaGkSSnaN8NEI0sdpumt8UAwiX6tX+97lGrstx91EsW9mJ1egh77SLlIVa5+T621JKdfhR50+7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705826125; c=relaxed/simple;
	bh=E1j4lbGFKciuXk1Yg1UrA3T+hieubxNYeula/VLi/l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzlOKENIM9bBKwB7N1Wc57HdGAqPclTIjhGEpgXNpsRgPWB2U7sCfj1uz4s08GCI3ZjWRazltLe0+MX/npbyAE+yKHVoemCC8kUBrsHjsab7v+o1ABL80ccs0/TI7kDzSDZDPl2akNuisSheONxpC4TXFj6hQpXSKy3S9y88EjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ID4niUS6; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <27319d3d-61dd-41e3-be6c-ccc08b9b3688@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705826119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C+nKUquRVnsiH6ByWnfEanFY19iANj8L7VwJgB+g6PQ=;
	b=ID4niUS6btI4yknwMoJD2+kTFdn7M75cHav8CR/B+ezHxDwlWG4Pzvu8SUvG/lvDekjZN9
	v1QDEEgSL2mZApw6FtqFgNKAWIf7pdnrafm3xvkoHswrxrbQJRnPi6fDt62Qq5XbQlyvXk
	q0lkR9tyN1Vb61M3GOZiVrCrATcjaFk=
Date: Sun, 21 Jan 2024 16:34:58 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Linux Kernel Bug] UBSAN: array-index-out-of-bounds in
 rds_cmsg_recv
To: Chenyuan Yang <chenyuan0y@gmail.com>, santosh.shilimkar@oracle.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, "syzkaller@googlegroups.com"
 <syzkaller@googlegroups.com>, Zijie Zhao <zzjas98@gmail.com>
References: <CALGdzuoVdq-wtQ4Az9iottBqC5cv9ZhcE5q8N7LfYFvkRsOVcw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CALGdzuoVdq-wtQ4Az9iottBqC5cv9ZhcE5q8N7LfYFvkRsOVcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/1/19 22:29, Chenyuan Yang 写道:
> Dear Linux Kernel Developers for Network RDS,
> 
> We encountered "UBSAN: array-index-out-of-bounds in rds_cmsg_recv"
> when testing the RDS with our generated specifications. The C
> reproduce program and logs for this crash are attached.
> 
> This crash happens when RDS receives messages by using
> `rds_cmsg_recv`, which reads the `j+1` index of the array
> `inc->i_rx_lat_trace`
> (https://elixir.bootlin.com/linux/v6.7/source/net/rds/recv.c#L585).
> The length of `inc->i_rx_lat_trace` array is 4 (defined by
> `RDS_RX_MAX_TRACES`,
> https://elixir.bootlin.com/linux/v6.7/source/net/rds/rds.h#L289) while
> `j` is the value stored in another array `rs->rs_rx_trace`
> (https://elixir.bootlin.com/linux/v6.7/source/net/rds/recv.c#L583),
> which is sent from others and could be arbitrary value.

I recommend to use the latest rds to make tests. The rds in linux kernel 
upstream is too old. The rds in oracle linux is newer.

Zhu Yanjun

> 
> This crash might be exploited to read the value out-of-bound from the
> array by setting arbitrary values for the array `rs->rs_rx_trace`.
> 
> If you have any questions or require more information, please feel
> free to contact us.
> 
> Best,
> Chenyuan


