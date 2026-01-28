Return-Path: <linux-rdma+bounces-16122-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBMhOWnIeWnxzQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16122-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 09:27:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE079E300
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 09:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0715B3006B70
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 08:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94FD32C949;
	Wed, 28 Jan 2026 08:27:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ECFEAE7
	for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 08:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769588838; cv=none; b=KLFOWlptVfGpTAQ5ErT8Crz/faR09HXwQvH3cQRezyQmhKs5KSkWw9deYaq1pp3ZeEFh1ER9pZgdEhU5Q7Kr+enxd86OzmubB0Pq8MzV1YCl0oMieQhneMcqosLswTCnPLRsx5qq5Wydk/R+YfdEaq8zBsoDHZs1ZDmFT3HVj3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769588838; c=relaxed/simple;
	bh=BlUzCIq2uzB4lfuojR11L4r+pJsP9x6EMM/eMR/kKeo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OWk9gbgcqU3IWayE/nJo7LHCgKzCwPtvJYMsrQZphUS2WGlDPq7Zd4yxe5oNdkoSSBHG5SeE67xQG9L8vgce2Dc38yqBbzsUVpNX5CAVfQL7kq3R7DEunH6QlbbX48Z8Upx82Dq5ij+8WJi4H5neW/w0HYAuuCcCnCYeTJozCoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60S8QqJP067891;
	Wed, 28 Jan 2026 17:26:52 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60S8Qq5H067887
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 28 Jan 2026 17:26:52 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <0952d053-0de4-469c-88b4-509e6d29296c@I-love.SAKURA.ne.jp>
Date: Wed, 28 Jan 2026 17:26:52 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/core: Fix stale RoCE GIDs during netdev events at
 registration
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, msanalla@nvidia.com,
        maorg@nvidia.com, parav@nvidia.com, mbloch@nvidia.com,
        markzhang@nvidia.com, marco.crivellari@suse.com,
        roman.gushchin@linux.dev, "Yanjun.Zhu" <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20260127093839.126291-1-jiri@resnulli.us>
 <21d63279-79a2-47aa-b305-30a55b8f40f4@I-love.SAKURA.ne.jp>
 <20260127160000.GG1641016@ziepe.ca>
 <05b40f3c-0d21-411a-b61a-156246482327@linux.dev>
 <9975b59a-58e2-4766-9e4e-c927a1d7a3d0@I-love.SAKURA.ne.jp>
 <f3402d0f-40a1-4792-a8e2-be65c71a176b@linux.dev>
 <af4866d0-2e50-477c-b823-1c4a8a86f7e5@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <af4866d0-2e50-477c-b823-1c4a8a86f7e5@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav301.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-16122-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: EFE079E300
X-Rspamd-Action: no action

On 2026/01/28 13:52, Tetsuo Handa wrote:
> Two things I worry about Jiri's patch are that
> 
>   refcount_set(&device->refcount, 2) in enable_device_and_get() becomes unsafe if 
>   DEVICE_GID_UPDATES notifications can let someone to call ib_device_put()

Well, since siw_netdev_event() is calling ib_device_put()
( https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/infiniband/sw/siw/siw_main.c#L403 ),
calling refcount_set() immediately before setting
xa_set_mark(&devices, device->index, DEVICE_REGISTERED) is no longer safe.

> 
> and
> 
>   I'm not convinced that it is safe/meaningful to keep DEVICE_GID_UPDATES notifications valid
>   between wait_for_completion(&device->unreg_completion) in disable_device() and the beginning
>   of ib_cache_cleanup_one() because I don't know whether DEVICE_GID_UPDATES notifications can
>   make sense after device->refcount became 0
> 
> .
> 


