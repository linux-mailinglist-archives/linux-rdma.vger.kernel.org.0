Return-Path: <linux-rdma+bounces-1046-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8528185A30D
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Feb 2024 13:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73041C2342E
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Feb 2024 12:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4BD2DF9F;
	Mon, 19 Feb 2024 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CaIe+yC3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F5C2D04B
	for <linux-rdma@vger.kernel.org>; Mon, 19 Feb 2024 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345178; cv=none; b=AlaJmzoYt5bAFLXt8DhpvlSLKkmlbU+1XlrxjGuTnVo73ac3pbbjf4xjt7aEZ1DYStyDlWfhIieEQc74SJCsT72ddIlPeVc2Qupmf030VG28Atk7mN/8Fg+t28hWwiGyqIfD0tWAvbLvPvEwieZnEoeqc9FwBNqdl66oWBGU5sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345178; c=relaxed/simple;
	bh=XZhHjRkTj6nAHd5DH2JdWTq2TlG6374TlIGjtVi+DOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qK326QHYznunHeJ7k4b6+THFp9oPdIloD4wOWuUTBTXWH+wmdpp6QlAdjG8HrCOB5z854sognoEdK6IDZto8NWud6Mr04gHksDjnQxzSgHWSZniNGTSNN5he5t+X/0eFK+r1DbjoiiqWb9ZdWkrpn5c8Fnd54ZmXjZJHUIeenuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CaIe+yC3; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <99e3e994-ef6a-4339-abf2-cda62d24b1ce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708345173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DkVT2jDCTEiEB3I4q1MvWvXu2gwGeHJQocWwFjbYXGE=;
	b=CaIe+yC3VWWsIwDtdZDwlDmoJQpk6KwmTKHJjMIbgk2ALrL3MJOcJRTs0xk71hAcD0iHcs
	rG4whUuljZj/jHmsTTZ0T6Pk/ZKRszUCWxxxHZ0EzOS7Isofz+m+i+9m2jq/REDPQQ3xss
	45FxfJFgIskFkV4+58egD+GIeT71+/4=
Date: Mon, 19 Feb 2024 20:19:23 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net/mlx5: fix possible stack overflows
To: Hamdan Agbariya <hamdani@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
 Arnd Bergmann <arnd@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>,
 Alex Vesker <valex@nvidia.com>, Netdev <netdev@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240213100848.458819-1-arnd@kernel.org>
 <84874528-daea-424d-af63-b9b86835fae6@linux.dev>
 <2ebe5a36-ce81-4d26-a12b-7affbd65c5e3@app.fastmail.com>
 <11f40993-ec02-48b7-aec5-13ff7cddf665@linux.dev>
 <DM6PR12MB45168A0957212864D8D53B80CE512@DM6PR12MB4516.namprd12.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <DM6PR12MB45168A0957212864D8D53B80CE512@DM6PR12MB4516.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/2/19 17:05, Hamdan Agbariya 写道:
>> 在 2024/2/15 16:03, Arnd Bergmann 写道:
>>> On Thu, Feb 15, 2024, at 01:18, Zhu Yanjun wrote:
>>>> 在 2024/2/13 18:08, Arnd Bergmann 写道:
>>>>>     static int
>>>>> -dr_dump_rule_rx_tx(struct seq_file *file, struct mlx5dr_rule_rx_tx
>>>>> *rule_rx_tx,
>>>>> +dr_dump_rule_rx_tx(struct seq_file *file, char *buff,
>>>>> +              struct mlx5dr_rule_rx_tx *rule_rx_tx,
>>>>>                 bool is_rx, const u64 rule_id, u8 format_ver)
>>>>>     {
>>>>>      struct mlx5dr_ste *ste_arr[DR_RULE_MAX_STES +
>>>>> DR_ACTION_MAX_STES]; @@ -533,7 +532,7 @@
>> dr_dump_rule_rx_tx(struct seq_file *file, struct mlx5dr_rule_rx_tx
>> *rule_rx_tx,
>>>>>              return 0;
>>>>>
>>>>>      while (i--) {
>>>>> -           ret = dr_dump_rule_mem(file, ste_arr[i], is_rx, rule_id,
>>>> Before buff is reused, I am not sure whether buff should be firstly
>>>> zeroed or not.
>>> I don't see why it would, but if you want to zero it, that would be a
>>> separate patch that is already needed on the existing code, which
>>> never zeroes its buffers.
>>
>> Sure. I agree with you. In the existing code, the buffers are not zeroed.
>>
>> But to a buffer which is used for several times, it is good to zero it before it is
>> used again.
>>
>> Can you add a new commit with the following?
>>
>> 1). Zero the buffers in the existing code
>>
> 
> No need to zero the buffers, as it does not have any necessity and it will only affect performance.
> Thanks,

Sorry. I can not get your point. Can you explain why no need to zero the 
buffers? Thanks in advance.

> Hamdan
> 
> 
> 
> 
>> 2). Add the zero functionality to your patch

If a buffer is used for many times, is it necessary to zero it before it 
is used again?

Thanks,
Zhu Yanjun

>>
>>   From my perspective, it is good to the whole commit.
>>
>> Please Jason and Leon comment on this.
>>
>> Thanks,
>>
>> Zhu Yanjun
>>
>>>
>>>       Arnd


