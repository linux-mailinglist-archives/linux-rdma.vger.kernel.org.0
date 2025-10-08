Return-Path: <linux-rdma+bounces-13797-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 37375BC572A
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Oct 2025 16:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6594C34407C
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Oct 2025 14:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148832EBBAC;
	Wed,  8 Oct 2025 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PYiweDzo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D562EB870;
	Wed,  8 Oct 2025 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759934256; cv=none; b=L6zYhCoxr4eTkJQgJWI3of7Lv2muCz6aKD2zFlhlYDDISEy/xwVt5NYc4zUOjN9MeStPffO2GEySAc1U41derYSkWBRRnYDAEHtLNLWxVdUUE4uv9BZ59vOHPwZPbca65/POh67Ia7PQTZmdr3KlmaRLkflO6j/WllwAd2HEyzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759934256; c=relaxed/simple;
	bh=fM/soW1wxcm6ZUoUCSrXUsq1Ch641FejBxdWZ2T9VTY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RP5mZRQ0fLWRtYpLvlvoEZKmvK4Iavn4+YMrZrjc5vxVkUUkBU5xDWFueylwAFXMqZ/JSK2h0FYtrzzlWsZfj4M/EgfS5Yq5AKsNxx8Gbc9aZ0ZSj+DjkRl7A6dgUqIJUfV6mFReX6AXyJI3OrdwxXH6FgVLfTEzTEEJ/imj6iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PYiweDzo; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759934244; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=y8JH2A/X+FfSGLqk5PRkD3V44OnLqwLLX/lM69mSF2o=;
	b=PYiweDzo0YOeOsiHJRq0QGRmJ9YqbxqcuL9iWNng1x09kPqvoXGqNwd4OkNnfukheFXOny3gBGe03TOO1dX55vQ9oua8uirGGE34OHhIw/OjYMnzoFT13PRP7a/CLvBK7yUsU2ZKhQXe7p97lzCkAv5TQiosJyA8Wn9kZ4rGzA0=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WpfC3B0_1759932368 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 08 Oct 2025 22:06:08 +0800
Date: Wed, 8 Oct 2025 22:06:08 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Guangguan Wang <guangguan.wang@linux.alibaba.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/2] net/smc: handle -ENOMEM from
 smc_wr_alloc_link_mem gracefully
Message-ID: <aOZv0NmekKIgpc5M@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250929000001.1752206-1-pasic@linux.ibm.com>
 <20250929000001.1752206-3-pasic@linux.ibm.com>
 <aNnl_CfV0EvIujK0@linux.alibaba.com>
 <de0baa92-417c-475a-a342-9041f8fb5b8e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de0baa92-417c-475a-a342-9041f8fb5b8e@linux.ibm.com>

On 2025-10-06 11:25:22, Mahanta Jambigi wrote:
>On 29/09/25 7:20 am, Dust Li wrote:
>>> diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
>>> index 8d06c8bb14e9..5c18f08a4c8a 100644
>>> --- a/net/smc/smc_core.h
>>> +++ b/net/smc/smc_core.h
>>> @@ -175,6 +175,8 @@ struct smc_link {
>>> 	struct completion	llc_testlink_resp; /* wait for rx of testlink */
>>> 	int			llc_testlink_time; /* testlink interval */
>>> 	atomic_t		conn_cnt; /* connections on this link */
>>> +	u16			max_send_wr;
>>> +	u16			max_recv_wr;
>> 
>> Here, you've moved max_send_wr/max_recv_wr from the link group to individual links.
>> This means we can now have different max_send_wr/max_recv_wr values on two
>> different links within the same link group.
>> Since in Alibaba we doesn't use multi-link configurations, we haven't tested
>
>Does Alibaba always use a single RoCE device for SMC-R? In that case how
>redundancy is achieved if that link goes down?

We expose a virtual RDMA device to our client inside their virtual
machine. The underlying network is already redundant, so it’s got
built-in reliability. You can think of it kind of like virtio-net, but
instead of a regular virtual NIC, it’s an RDMA device.

>
>> this scenario. Have you tested the link-down handling process in a multi-link
>> setup?
>I did test this after you query & don't see any issues. As Halil
>mentioned in worst case scenario one link might perform lesser than the
>other, that too if the kcalloc() failed for that link in
>smc_wr_alloc_link_mem() & succeeded in subsequent request with reduced
>max_send_wr/max_recv_wr size(half).

Great! You can add my

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

>> Otherwise, the patch looks good to me.
>> 
>> Best regards,
>> Dust

