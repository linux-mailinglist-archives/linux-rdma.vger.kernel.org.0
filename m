Return-Path: <linux-rdma+bounces-4439-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61F1959203
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 03:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05081C221DB
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 01:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6B414295;
	Wed, 21 Aug 2024 01:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="x12xIxBd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E602F4A24;
	Wed, 21 Aug 2024 01:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724202212; cv=none; b=LhCwe16LG+wz2kOWamM2PaULvzdHMvo4xfI8LGzO3q5Rk8RFXjkXBf5cxzeWg/6H6kpW2tw2RntS0lVlXC4d5Y1KTMZGHPzp4ikmtwBR9sWJ4l42Ee/iMIjQ7mUooQIljaxWZwXdYqWHava+dau7oc28jQmVXTTq2punxtGy4Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724202212; c=relaxed/simple;
	bh=z2jysoZi6yxlThI/0Nib1B5K3XhfafD9ahDmV5nJaeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iS2mYqbfm8MJGFH38uqx7yAMLs8FXzotVDNo6LdiB8o//LWGT5nsnu1ySalsMALzX7ZX3CetIkNw1M3DgjytUJzW8cbB5Hp9K9rzjYuXjqurAh53qQGs7v0PbZN+iQAfRuFeQYDgv/wIZwFyYu7hb9P1rBOXJUCLPfxxyOlibJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=x12xIxBd; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724202206; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=8XVqm7QyDtTkGXTuO6TqOs0r8S6hn9akvbKGi06dngk=;
	b=x12xIxBd7LpNUo/wi4joWOLfTUF/sv76WJULet5Q0Gm92LeeJLQeQCLVc93bbObztQtqx73x1Fk7Srs6ZnKCF5CvEuXV7ypyTmJM1K2ZLjjRTimBCT+RugDpYjHg9iGZTV4GidztQ5LpWR/+tq443SS8EB07CNyleRXhYQcQkm0=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WDJyfvj_1724202205)
          by smtp.aliyun-inc.com;
          Wed, 21 Aug 2024 09:03:25 +0800
Date: Wed, 21 Aug 2024 09:03:24 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Jan Karcher <jaka@linux.ibm.com>, Liu Jian <liujian56@huawei.com>,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Cc: jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com,
	wenjia@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next 0/4] Make SMC-R can work with rxe devices
Message-ID: <20240821010324.GK103152@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20240809083148.1989912-1-liujian56@huawei.com>
 <0d5e2cec-dd0b-4920-99ff-9299e4df604f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d5e2cec-dd0b-4920-99ff-9299e4df604f@linux.ibm.com>

On 2024-08-20 15:16:57, Jan Karcher wrote:
>
>
>On 09/08/2024 10:31, Liu Jian wrote:
>> Make SMC-R can work with rxe devices. This allows us to easily test and
>> learn the SMC-R protocol without relying on a physical RoCE NIC.
>
>Hi Liu,
>
>sorry for taking quite some time to answer.
>
>Looking into this i cannot accept this series at the given point of time.
>
>FWIU, RXE is mainly for testing and development and i agree that it would be
>a nice thing to have for SMC-R.
>The problem is that there is no clean layer for different RoCE devices
>currently. Adding RXE to it works but isn't clean.

Hi jan,

>Also we have no way to do a "test" build which would have such a device
>supported and a "prod" build which would not support it.

I don't quite understand what you mean here, Maybe I missed something ?
IIUC, we can control whether to use RXE by simpling insmod or rmmod rdma_rxe.ko

I believe having RXE support is beneficial for testing, especially in
simple physical networking setups where many corner cases are unlikely
to occur. By using RXE, we can easily configure unusual scenarios with
the existing iptables/netfilter infrastructure to simulate real-world
situations, such as packet dropping or network retransmission. This
approach can be advantageous for finding hidden bugs.

Best regards,
Dust


>
>Please give us time to investigate how to solve this in a neat way without
>building up to much technical debt.
>
>Thanks for your contribution and making us aware of this area of improvment.
>- Jan
>
>> 
>> Liu Jian (4):
>>    rdma/device: export ib_device_get_netdev()
>>    net/smc: use ib_device_get_netdev() helper to get netdev info
>>    net/smc: fix one NULL pointer dereference in smc_ib_is_sg_need_sync()
>>    RDMA/rxe: Set queue pair cur_qp_state when being queried
>> 
>>   drivers/infiniband/core/core_priv.h   |  3 ---
>>   drivers/infiniband/core/device.c      |  1 +
>>   drivers/infiniband/sw/rxe/rxe_verbs.c |  2 ++
>>   include/rdma/ib_verbs.h               |  2 ++
>>   net/smc/smc_ib.c                      | 10 +++++-----
>>   net/smc/smc_pnet.c                    |  6 +-----
>>   6 files changed, 11 insertions(+), 13 deletions(-)
>> 

