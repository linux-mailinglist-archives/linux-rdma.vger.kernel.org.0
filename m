Return-Path: <linux-rdma+bounces-7978-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A15A3FCD6
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 18:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5D867A9845
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 17:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311FC2475C8;
	Fri, 21 Feb 2025 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jeH5YS+U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA687246325
	for <linux-rdma@vger.kernel.org>; Fri, 21 Feb 2025 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157451; cv=none; b=YhLRw4tkQmxkxqqs2xrJFUikXXGYfraHizC0xZJPWlYtdb4wGQv8NY3U+8pnyTqPeP6cNHsyTC7r2MK2inDvUxbUbEKtKTTRq2gHAaqaoR3BTwVM9byQ4rwANFfyCGpSmvyFcGCNABJCOYkDbF/4RJiJS6PsCgAj7jeY3pfKJNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157451; c=relaxed/simple;
	bh=oHjbmru2QQsuHj6N6JXRu2GEOFcK9yNuDxoXnx9CeRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZQwqn5BeehNMueg3JDlDlRueDByHolgNiarLh+nQUdutazXUIGXybyjA5vZNi76GV49Qy5TgNNT191DaQtyFqsldjyTDl6gaeXbXt7hJHUKqwxPUPD/pfUTuHHTmA+XcUKvVAwXsqqLaNxCUzHrB66VxLiiuLnYdZi/I3JDxQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jeH5YS+U; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <838a95a2-f286-4f94-8667-2da8ba330c47@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740157444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqkeLl4edF4Abj4+G0T6cEX5+oLzQ4akTCIi4bYHP/U=;
	b=jeH5YS+Uzt+v/9+tGV7z38jRVej745cuayfW1layp3p+kpPIDPOPs86cwmMloApHqEJ7C1
	/INL/AUCemJCCbJlFqHr2pk2/k7AWSIoaeq0jqpBPlMZH7qiCK5ljND4yMXjPOd3CVpN/B
	elpu1NQdK2YfJ4b9FcvzTZhkGOqzF30=
Date: Fri, 21 Feb 2025 18:03:59 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] IB/cm: use rwlock for MAD agent lock
To: Jacob Moroni <jmoroni@google.com>, jgg@ziepe.ca, leon@kernel.org,
 markzhang@nvidia.com
Cc: linux-rdma@vger.kernel.org, edumazet@google.com
References: <20250220175612.2763122-1-jmoroni@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250220175612.2763122-1-jmoroni@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 20.02.25 18:56, Jacob Moroni wrote:
> In workloads where there are many processes establishing
> connections using RDMA CM in parallel (large scale MPI),
> there can be heavy contention for mad_agent_lock in
> cm_alloc_msg.
> 
> This contention can occur while inside of a spin_lock_irq
> region, leading to interrupts being disabled for extended
> durations on many cores. Furthermore, it leads to the
> serialization of rdma_create_ah calls, which has negative
> performance impacts for NICs which are capable of processing
> multiple address handle creations in parallel.

In the link: 
https://www.cs.columbia.edu/~jae/4118-LAST/L12-interrupt-spinlock.html
"
...
spin_lock() / spin_unlock()

must not lose CPU while holding a spin lock, other threads will wait for 
the lock for a long time

spin_lock() prevents kernel preemption by ++preempt_count in 
uniprocessor, that’s all spin_lock() does

must NOT call any function that can potentially sleep
ex) kmalloc, copy_from_user

hardware interrupt is ok unless the interrupt handler may try to lock 
this spin lock
spin lock not recursive: same thread locking twice will deadlock

keep the critical section as small as possible
...
"
And from the source code, it seems that spin_lock/spin_unlock are not 
related with interrupts.

I wonder why "leading to interrupts being disabled for extended 
durations on many cores" with spin_lock/spin_unlock?

I am not against this commit. I am just obvious why 
spin_lock/spin_unlock are related with "interrupts being disabled".

Thanks a lot.
Zhu Yanjun

> 
> The end result is the machine becoming unresponsive, hung
> task warnings, netdev TX timeouts, etc.
> 
> Since the lock appears to be only for protection from
> cm_remove_one, it can be changed to a rwlock to resolve
> these issues.
> 
> Reproducer:
> 
> Server:
>    for i in $(seq 1 512); do
>      ucmatose -c 32 -p $((i + 5000)) &
>    done
> 
> Client:
>    for i in $(seq 1 512); do
>      ucmatose -c 32 -p $((i + 5000)) -s 10.2.0.52 &
>    done
> 
> Fixes: 76039ac9095f5ee5 ("IB/cm: Protect cm_dev, cm_ports and mad_agent with kref and lock")
> Signed-off-by: Jacob Moroni <jmoroni@google.com>
> ---
>   drivers/infiniband/core/cm.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index 142170473e75..effa53dd6800 100644
> --- a/drivers/infiniband/core/cm.c
> +++ b/drivers/infiniband/core/cm.c
> @@ -167,7 +167,7 @@ struct cm_port {
>   struct cm_device {
>   	struct kref kref;
>   	struct list_head list;
> -	spinlock_t mad_agent_lock;
> +	rwlock_t mad_agent_lock;
>   	struct ib_device *ib_device;
>   	u8 ack_delay;
>   	int going_down;
> @@ -285,7 +285,7 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
>   	if (!cm_id_priv->av.port)
>   		return ERR_PTR(-EINVAL);
>   
> -	spin_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
> +	read_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
>   	mad_agent = cm_id_priv->av.port->mad_agent;
>   	if (!mad_agent) {
>   		m = ERR_PTR(-EINVAL);
> @@ -311,7 +311,7 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
>   	m->ah = ah;
>   
>   out:
> -	spin_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
> +	read_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
>   	return m;
>   }
>   
> @@ -1297,10 +1297,10 @@ static __be64 cm_form_tid(struct cm_id_private *cm_id_priv)
>   	if (!cm_id_priv->av.port)
>   		return cpu_to_be64(low_tid);
>   
> -	spin_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
> +	read_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
>   	if (cm_id_priv->av.port->mad_agent)
>   		hi_tid = ((u64)cm_id_priv->av.port->mad_agent->hi_tid) << 32;
> -	spin_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
> +	read_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
>   	return cpu_to_be64(hi_tid | low_tid);
>   }
>   
> @@ -4378,7 +4378,7 @@ static int cm_add_one(struct ib_device *ib_device)
>   		return -ENOMEM;
>   
>   	kref_init(&cm_dev->kref);
> -	spin_lock_init(&cm_dev->mad_agent_lock);
> +	rwlock_init(&cm_dev->mad_agent_lock);
>   	cm_dev->ib_device = ib_device;
>   	cm_dev->ack_delay = ib_device->attrs.local_ca_ack_delay;
>   	cm_dev->going_down = 0;
> @@ -4494,9 +4494,9 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
>   		 * The above ensures no call paths from the work are running,
>   		 * the remaining paths all take the mad_agent_lock.
>   		 */
> -		spin_lock(&cm_dev->mad_agent_lock);
> +		write_lock(&cm_dev->mad_agent_lock);
>   		port->mad_agent = NULL;
> -		spin_unlock(&cm_dev->mad_agent_lock);
> +		write_unlock(&cm_dev->mad_agent_lock);
>   		ib_unregister_mad_agent(mad_agent);
>   		ib_port_unregister_client_groups(ib_device, i,
>   						 cm_counter_groups);


