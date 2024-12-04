Return-Path: <linux-rdma+bounces-6221-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071AA9E33E4
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 08:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7299BB23DB6
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 07:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108B718BB9C;
	Wed,  4 Dec 2024 07:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JnriCWgG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B161E522;
	Wed,  4 Dec 2024 07:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733296371; cv=none; b=Kcgf5hplf7txFlRxBJT+2Xi0++0fK3qpE6D5iXFDvZ2Yl+r0cLAM4u9o04dic32x+1dvvSa0bdFkyHnOZ00MNoAUazffMHivuWOiloVq4nXXfkcrWbWs8HqIDcOsglFdNlW47iiRiEVG1l2nntH68DQO2FZKmsnDATO7H5Amk/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733296371; c=relaxed/simple;
	bh=Zba78+gYrWAoBfrxNZ7VQ+Kvb5wQPYUwdoQFXqA5xpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DGeemOZD9ItTui++m4ShkxVE1/YiTZZnZe3bYWEFbQTJqLupWzDCWmPYoXo2kocqM54jeQEa0ycPXmRGqvgLYuB0+nfTbOP7cQZx45U/OlX/IW6KrG2okUYEn76KgFvrQyaRcrp1WMMkYJxMOAbRNoH1KmOyBCdntbJWWOxzVAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JnriCWgG; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733296365; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=R2wd7f4YKjWBjF5YWtj+hMQ427DiXvpVSrWDNNtOBuo=;
	b=JnriCWgGaGnqW5P0YPyY9ZfrgGT9s2kK4juO5hAfDS4w/UBXiRZjWsVtSCSZQbZXr1X1IHX95zeHPcADUTaTXVyPWcTJf+mNqFfN+HfteL8Sbr8d5GKAjA9kQ4i8KgU7Bc3B7Sg+TMuAy8K5u0ajIa6NJeHzuY0uC8cE3km4GiI=
Received: from 30.221.101.58(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WKp7DFJ_1733296363 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Dec 2024 15:12:44 +0800
Message-ID: <2b9d0b12-6830-48d5-ad65-49f401c4e365@linux.alibaba.com>
Date: Wed, 4 Dec 2024 15:12:42 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/6] net/smc: set SOCK_NOSPACE when send_remaining but
 no sndbuf_space left
To: Paolo Abeni <pabeni@redhat.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241128121435.73071-1-guangguan.wang@linux.alibaba.com>
 <20241128121435.73071-3-guangguan.wang@linux.alibaba.com>
 <62cd6d62-b233-4906-af4a-72127fc4c0f4@redhat.com>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <62cd6d62-b233-4906-af4a-72127fc4c0f4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/12/3 18:04, Paolo Abeni wrote:
> 
> 
> On 11/28/24 13:14, Guangguan Wang wrote:
>> When application sending data more than sndbuf_space, there have chances
>> application will sleep in epoll_wait, and will never be wakeup again. This
>> is caused by a race between smc_poll and smc_cdc_tx_handler.
>>
>> application                                      tasklet
>> smc_tx_sendmsg(len > sndbuf_space)   |
>> epoll_wait for EPOLL_OUT,timeout=0   |
>>   smc_poll                           |
>>     if (!smc->conn.sndbuf_space)     |
>>                                      |  smc_cdc_tx_handler
>>                                      |    atomic_add sndbuf_space
>>                                      |    smc_tx_sndbuf_nonfull
>>                                      |      if (!test_bit SOCK_NOSPACE)
>>                                      |        do not sk_write_space;
>>       set_bit SOCK_NOSPACE;          |
>>     return mask=0;                   |
>>
>> Application will sleep in epoll_wait as smc_poll returns 0. And
>> smc_cdc_tx_handler will not call sk_write_space because the SOCK_NOSPACE
>> has not be set. If there is no inflight cdc msg, sk_write_space will not be
>> called any more, and application will sleep in epoll_wait forever.
>> So set SOCK_NOSPACE when send_remaining but no sndbuf_space left in
>> smc_tx_sendmsg, to ensure call sk_write_space in smc_cdc_tx_handler
>> even when the above race happens.
> 
> I think it should be preferable to address the mentioned race the same
> way as tcp_poll(). i.e. checking again smc->conn.sndbuf_space after
> setting the NOSPACE bit with appropriate barrier, see:
> 
> https://elixir.bootlin.com/linux/v6.12.1/source/net/ipv4/tcp.c#L590
> 
> that will avoid additional, possibly unneeded atomic operation in the tx
> path (the application could do the next sendmsg()/poll() call after that
> the send buf has been freed) and will avoid some code duplication.
> 
> Cheers,
> 
> Paolo

Hi, Paolo

Thanks for advice, and the way in tcp_poll() seems a better solution for this race.
I will retest it, and resend a new version of patch if it works.

Thanks,
Guangguan Wang

