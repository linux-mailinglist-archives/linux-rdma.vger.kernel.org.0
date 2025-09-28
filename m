Return-Path: <linux-rdma+bounces-13689-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96027BA66B2
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 05:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5134117D6F6
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 03:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A662C221FB2;
	Sun, 28 Sep 2025 03:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Qul7CtBJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F319819CC0A;
	Sun, 28 Sep 2025 03:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759028762; cv=none; b=bFVKtYZbuYNZV/FJHZa766XZ/DmfG6w98mDk1okuuG+7yGnr2W7RnIaHGnBZWqZsX9AQkcoLgKS89RUJyEQ9g/nIncmNQAsXMDUctb1YT4ZTEQIX4A9lHWI2UF3Dpon2dkmk64R1lTiWSqLd1oqXLzlGfPc5fCrmXUECQJxxGBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759028762; c=relaxed/simple;
	bh=6sGNYBzLgO0w5bLjfboufglxKETar7+C3OCrRc81MvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sadI7vzO36H2k5bcMkMnNOiZ+wbwz/tfmbiHZSVXJlKmRKfSMYx8e1uZYLV7ARdSdfep1vG6MTwFFLLHbNdGTZHsKijafNDx3MEIPfWh0g0jRrzucHLVpIuuTgleCsJckHnDvjEtZvcxbG7UWGMLYxL6AOjrhlgPhW1vNwBBqBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Qul7CtBJ; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759028747; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cL9x2decLDwPNVgIuERgCGP0LyHtqq3UXa3rvBQC5SQ=;
	b=Qul7CtBJWdZyZud0wrgvhowe8YfPN7MHBo6QIuQrut/Ue/gnzV9avGUeiWHx8wd8/Ue1F/KfsEsov4T0fXqKCJtIdFJU6U3I9IgDLtsuggE8C3BO08CgKlNuI2uneyy5DYG/SkvSVzWNzqyYPu1Ty5vH4CrizWtddd8m78ZH7U8=
Received: from 30.221.115.89(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WowxfSo_1759028745 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 28 Sep 2025 11:05:46 +0800
Message-ID: <24a398b3-e3e5-4b0d-8ed7-cd86f3e661eb@linux.alibaba.com>
Date: Sun, 28 Sep 2025 11:05:45 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net/smc: make wr buffer count
 configurable
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond
 <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org
References: <20250921214440.325325-1-pasic@linux.ibm.com>
 <20250921214440.325325-2-pasic@linux.ibm.com>
 <1aa764d0-0613-499e-bc44-52e70602b661@linux.alibaba.com>
 <20250926121249.687b519d.pasic@linux.ibm.com>
 <20250926123028.2130fa49.pasic@linux.ibm.com>
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <20250926123028.2130fa49.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2025/9/26 18:30, Halil Pasic 写道:
> On Fri, 26 Sep 2025 12:12:49 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On Fri, 26 Sep 2025 10:44:00 +0800
>> Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:
>>
>>>
>>> Notice that the ratio of smcr_max_recv_wr to smcr_max_send_wr is set to 3:1, with the
>>> intention of ensuring that the peer QP's smcr_max_recv_wr is three times the local QP's
>>> smcr_max_send_wr and the local QP's smcr_max_recv_wr is three times the peer QP's
>>> smcr_max_send_wr, rather than making the local QP's smcr_max_recv_wr three times its own
>>> smcr_max_send_wr. The purpose of this design is to guarantee sufficient receive WRs on
>>> the side to receive incoming data when peer QP doing RDMA sends. Otherwise, RNR (Receiver
>>> Not Ready) may occur, leading to poor performance(RNR will drop the packet and retransmit
>>> happens in the transport layer of the RDMA).  
> 
> Sorry this was sent accidentally by the virtue of unintentionally
> pressing the shortcut for send while trying to actually edit! 
> 
>>
>> Thank you Guangguan! I think we already had that discussion. 
> 
> Please have a look at this thread
> https://lore.kernel.org/all/4c5347ff-779b-48d7-8234-2aac9992f487@linux.ibm.com/
> 
> I'm aware of this, but I think this problem needs to be solved on
> a different level.
> 
Oh, I see. Sorry for missing the previous discussion.

BTW, the RNR counter is the file like '/sys/class/infiniband/mlx5_0/ports/1/hw_counters/rnr_nak_retry_err'.

>>>
>>> Let us guess a scenario that have multiple hosts, and the multiple hosts have different
>>> smcr_max_send_wr and smcr_max_recv_wr configurations, mesh connections between these hosts.
>>> It is difficult to ensure that the smcr_max_recv_wr/smcr_max_send_wr is 3:1 on the connected
>>> QPs between these hosts, and it may even be hard to guarantee the smcr_max_recv_wr > smcr_max_send_wr
>>> on the connected QPs between these hosts.  
>>
>>
>> It is not difficult IMHO. You just leave the knobs alone and you have
> [..]
> 
> It is not difficult IMHO. You just leave the knobs alone and you have
> 3:1 per default. If tuning is attempted that needs to be done carefully.
> At least with SMC-R V2 there is this whole EID business, as well so it
> is reasonable to assume that the environment can be tuned in a coherent
> fashion. E.g. whoever is calling the EID could call use smcr_max_recv_wr:=32
> and smcr_max_send_wr:=96. 
> 
>>>
>>> Therefore, I believe that if these values are made configurable, additional mechanisms must be
>>> in place to prevent RNR from occurring. Otherwise we need to carefully configure smcr_max_recv_wr
>>> and smcr_max_send_wr, or ensure that all hosts capable of establishing SMC-R connections are configured
>>> smcr_max_recv_wr and smcr_max_send_wr with the same values.  
>>
> 
> I'm in favor of adding such mechanisms on top of this. Do you have
> something particular in mind? Unfortunately I'm not knowledgeable enough
> in the area to know what mechanisms you may mean. But I guess it is
> patches welcome as always! Currently I would encourage to users
> to tune carefully. 
> 

AFAIK, flow control is a usual way, maybe credit-based flow control is enough. Credit means the valid
counts of receive wr can be used. The receiver counts the credit every time post_recv, and advertises
credits to the connected sender at a certain frequency. The sender counts the credits advertised from
peer. The sender consumes a credit everytime post_send wr which will consume a receive wr in the receiver,
if have enough credits to consume. Otherwise the sender should hang the wr and should wait for the credits
advertised from peer. 

But this requires support at the SMC-R protocol level. And this also can be addressed as an enhancement.
I do not known if someone from Dust Li's team or someone from IBM has interests to pick this up.

Regards,
Guangguan Wang


