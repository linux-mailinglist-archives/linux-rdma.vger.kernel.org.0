Return-Path: <linux-rdma+bounces-1032-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE528572BB
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Feb 2024 01:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D66DB21DAE
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Feb 2024 00:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020D43FC2;
	Fri, 16 Feb 2024 00:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tv+itwG+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EADC2D6
	for <linux-rdma@vger.kernel.org>; Fri, 16 Feb 2024 00:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044211; cv=none; b=mDcPCB56J1Z2PhRAkYEgSH+pKi6C8KSY+eEp7IjhIBeA6gKTS0eOy1dJKR5jzJm2lhSIiII3bY4I/SGOuhJaxMFL7iwpSe073NmLnVY+LtYPUKMo6sgI/aHx/sQBqodbSIfk/Q+0E7AJDhKByevvECNRavLfn+NmzQbKv0wjBbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044211; c=relaxed/simple;
	bh=2+VZnPCSYNk+2pPRyl152ePQ0FX0U8JpHjxax5vPuDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8Nr3Oo5NsOfBVctq8LAqVPLAwf3mpFoZvpAWVNsHSg+LP0O4kjbTiz3VHtBQjDlSUdSGByWK51AxyqalHT1mYHpTiuZZW/XiIviwct8jC2we1A77NUCkb6R/CBOUhwPSHqMgQC7HFz0qr/PMzL7ql3fHnFWAWSbxFpE1RpZEp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tv+itwG+; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <11f40993-ec02-48b7-aec5-13ff7cddf665@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708044208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KlOE/QHrK685/cBSEGlCbbuAZty4HqZtwl2hI0O+jio=;
	b=tv+itwG+azGIKJ3yf3N8V0VgYXvjLKRlNl497rfWJd7CpaqicNRKY2qiWipQT1saJxVnNj
	2ET24KwQQh84jFd/9tAmCflA3IxxlWQjPSdARAYSJ60kbx98IfUNBRGbzk4elELkgj2qCQ
	sFSGpacZdFq7hENHEjQbYTByzwIXDV0=
Date: Fri, 16 Feb 2024 08:43:18 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net/mlx5: fix possible stack overflows
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>,
 Alex Vesker <valex@nvidia.com>, Hamdan Igbaria <hamdani@nvidia.com>,
 Netdev <netdev@vger.kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240213100848.458819-1-arnd@kernel.org>
 <84874528-daea-424d-af63-b9b86835fae6@linux.dev>
 <2ebe5a36-ce81-4d26-a12b-7affbd65c5e3@app.fastmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <2ebe5a36-ce81-4d26-a12b-7affbd65c5e3@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/2/15 16:03, Arnd Bergmann 写道:
> On Thu, Feb 15, 2024, at 01:18, Zhu Yanjun wrote:
>> 在 2024/2/13 18:08, Arnd Bergmann 写道:
>>>    static int
>>> -dr_dump_rule_rx_tx(struct seq_file *file, struct mlx5dr_rule_rx_tx *rule_rx_tx,
>>> +dr_dump_rule_rx_tx(struct seq_file *file, char *buff,
>>> +		   struct mlx5dr_rule_rx_tx *rule_rx_tx,
>>>    		   bool is_rx, const u64 rule_id, u8 format_ver)
>>>    {
>>>    	struct mlx5dr_ste *ste_arr[DR_RULE_MAX_STES + DR_ACTION_MAX_STES];
>>> @@ -533,7 +532,7 @@ dr_dump_rule_rx_tx(struct seq_file *file, struct mlx5dr_rule_rx_tx *rule_rx_tx,
>>>    		return 0;
>>>    
>>>    	while (i--) {
>>> -		ret = dr_dump_rule_mem(file, ste_arr[i], is_rx, rule_id,
>> Before buff is reused, I am not sure whether buff should be firstly
>> zeroed or not.
> I don't see why it would, but if you want to zero it, that would be
> a separate patch that is already needed on the existing code,
> which never zeroes its buffers.

Sure. I agree with you. In the existing code, the buffers are not zeroed.

But to a buffer which is used for several times, it is good to zero it 
before it is used again.

Can you add a new commit with the following?

1). Zero the buffers in the existing code

2). Add the zero functionality to your patch

 From my perspective, it is good to the whole commit.

Please Jason and Leon comment on this.

Thanks,

Zhu Yanjun

>
>      Arnd

