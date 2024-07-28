Return-Path: <linux-rdma+bounces-4036-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BED93E3F7
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2024 09:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB71C1C20FA8
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2024 07:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2F92F28;
	Sun, 28 Jul 2024 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZZOd3ei"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3BF23776
	for <linux-rdma@vger.kernel.org>; Sun, 28 Jul 2024 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722152296; cv=none; b=Vyr05DgsDsoDRHe0YUfn+YRsJGUOVlO1t0hvzZKEYgo8MSzT6QngoPT/ikTwsuqVrELV4IwQQ5sGJqvCMu54lhuK12zBZTYcuiAfKP3ko+OgBCzHlRaa0q6CZmOrca/FrZr6+rKwSF9hRuY9nG8NVmg+4R8R3U4690h6U0CfCBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722152296; c=relaxed/simple;
	bh=JK2ESoex87F3QK4ako8rtmfSaiiYZq7V9g8b4yRfQZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRNwlHIwutYJxc3hJrop+buJ/GwnmBvm13yL6Kq8BG8dOcrBWTba8DD8IOaEMT/+qPdydcZ0idaJFW7v2+4UCGxvlmSXvMxiR/qX/cENbsAXEYa9ptd+IGslTv5RP/TqIVo92Upc6yUtLXi2DFOBdTLv1H2EJczj78g2U0VlrcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZZOd3ei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCD8C116B1;
	Sun, 28 Jul 2024 07:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722152295;
	bh=JK2ESoex87F3QK4ako8rtmfSaiiYZq7V9g8b4yRfQZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UZZOd3eiQ9RLJSJjgHDOuCjGHERQP/+LEhRfE6DVlRUag+jd7b4gtJ/Y5q8AnrGew
	 VnnPpcV9jsHF0iC44+MvCGvC18r3E3r180EFPthG4amzjy8ExwflbCa51AwjB8DAsx
	 n7g0VO/c823reAxQygcc02mJQv/7VD2m4mFBmCWUmx/3md0gQzKcOXytkSPP7/jdOp
	 FtruD4BvzBgC1v1/YDUbat5z18Yg5oO9tIzEzFCWc/quMMyFOhFnzVoK7FOfGE2rdw
	 wV9zlQ98nbCdQvl3zuMPzlg4nG+ubOJEjSjDEJV9CotP8MrsBsohc0HOJ0kKSFZ87S
	 Bw4Qy5dInwe5g==
Date: Sun, 28 Jul 2024 10:38:11 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc] rdma-core/mad: Improve handling of timed out WRs
 of mad agent
Message-ID: <20240728073811.GA4296@unreal>
References: <20240722110325.195085-1-saravanan.vajravel@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722110325.195085-1-saravanan.vajravel@broadcom.com>

On Mon, Jul 22, 2024 at 04:33:25PM +0530, Saravanan Vajravel wrote:
> Current timeout handler of mad agent aquires/releases mad_agent_priv
> lock for every timed out WRs. This causes heavy locking contention
> when higher no. of WRs are to be handled inside timeout handler.
> 
> This leads to softlockup with below trace in some use cases where
> rdma-cm path is used to establish connection between peer nodes
> 
> Trace:
> -----
>  BUG: soft lockup - CPU#4 stuck for 26s! [kworker/u128:3:19767]
>  CPU: 4 PID: 19767 Comm: kworker/u128:3 Kdump: loaded Tainted: G OE
>      -------  ---  5.14.0-427.13.1.el9_4.x86_64 #1
>  Hardware name: Dell Inc. PowerEdge R740/01YM03, BIOS 2.4.8 11/26/2019
>  Workqueue: ib_mad1 timeout_sends [ib_core]
>  RIP: 0010:__do_softirq+0x78/0x2ac
>  RSP: 0018:ffffb253449e4f98 EFLAGS: 00000246
>  RAX: 00000000ffffffff RBX: 0000000000000000 RCX: 000000000000001f
>  RDX: 000000000000001d RSI: 000000003d1879ab RDI: fff363b66fd3a86b
>  RBP: ffffb253604cbcd8 R08: 0000009065635f3b R09: 0000000000000000
>  R10: 0000000000000040 R11: ffffb253449e4ff8 R12: 0000000000000000
>  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000040
>  FS:  0000000000000000(0000) GS:ffff8caa1fc80000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007fd9ec9db900 CR3: 0000000891934006 CR4: 00000000007706e0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  PKRU: 55555554
>  Call Trace:
>   <IRQ>
>   ? show_trace_log_lvl+0x1c4/0x2df
>   ? show_trace_log_lvl+0x1c4/0x2df
>   ? __irq_exit_rcu+0xa1/0xc0
>   ? watchdog_timer_fn+0x1b2/0x210
>   ? __pfx_watchdog_timer_fn+0x10/0x10
>   ? __hrtimer_run_queues+0x127/0x2c0
>   ? hrtimer_interrupt+0xfc/0x210
>   ? __sysvec_apic_timer_interrupt+0x5c/0x110
>   ? sysvec_apic_timer_interrupt+0x37/0x90
>   ? asm_sysvec_apic_timer_interrupt+0x16/0x20
>   ? __do_softirq+0x78/0x2ac
>   ? __do_softirq+0x60/0x2ac
>   __irq_exit_rcu+0xa1/0xc0
>   sysvec_call_function_single+0x72/0x90
>   </IRQ>
>   <TASK>
>   asm_sysvec_call_function_single+0x16/0x20
>  RIP: 0010:_raw_spin_unlock_irq+0x14/0x30
>  RSP: 0018:ffffb253604cbd88 EFLAGS: 00000247
>  RAX: 000000000001960d RBX: 0000000000000002 RCX: ffff8cad2a064800
>  RDX: 000000008020001b RSI: 0000000000000001 RDI: ffff8cad5d39f66c
>  RBP: ffff8cad5d39f600 R08: 0000000000000001 R09: 0000000000000000
>  R10: ffff8caa443e0c00 R11: ffffb253604cbcd8 R12: ffff8cacb8682538
>  R13: 0000000000000005 R14: ffffb253604cbd90 R15: ffff8cad5d39f66c
>   cm_process_send_error+0x122/0x1d0 [ib_cm]
>   timeout_sends+0x1dd/0x270 [ib_core]
>   process_one_work+0x1e2/0x3b0
>   ? __pfx_worker_thread+0x10/0x10
>   worker_thread+0x50/0x3a0
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0xdd/0x100
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x29/0x50
>   </TASK>
> 
> Simplified timeout handler by creating local list of timed out WRs
> and invoke send handler post creating the list. The new method acquires/
> releases lock once to fetch the list and hence helps to reduce locking
> contetiong when processing higher no. of WRs
> 
> Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
> ---
>  drivers/infiniband/core/mad.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
> index 674344eb8e2f..58befbaaf0ad 100644
> --- a/drivers/infiniband/core/mad.c
> +++ b/drivers/infiniband/core/mad.c
> @@ -2616,14 +2616,16 @@ static int retry_send(struct ib_mad_send_wr_private *mad_send_wr)
>  
>  static void timeout_sends(struct work_struct *work)
>  {
> +	struct ib_mad_send_wr_private *mad_send_wr, *n;
>  	struct ib_mad_agent_private *mad_agent_priv;
> -	struct ib_mad_send_wr_private *mad_send_wr;
>  	struct ib_mad_send_wc mad_send_wc;
> +	struct list_head local_list;
>  	unsigned long flags, delay;
>  
>  	mad_agent_priv = container_of(work, struct ib_mad_agent_private,
>  				      timed_work.work);
>  	mad_send_wc.vendor_err = 0;
> +	INIT_LIST_HEAD(&local_list);
>  
>  	spin_lock_irqsave(&mad_agent_priv->lock, flags);
>  	while (!list_empty(&mad_agent_priv->wait_list)) {
> @@ -2641,13 +2643,16 @@ static void timeout_sends(struct work_struct *work)
>  			break;
>  		}
>  
> -		list_del(&mad_send_wr->agent_list);
> +		list_del_init(&mad_send_wr->agent_list);
>  		if (mad_send_wr->status == IB_WC_SUCCESS &&
>  		    !retry_send(mad_send_wr))
>  			continue;
>  
> -		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
> +		list_add_tail(&mad_send_wr->agent_list, &local_list);
> +	}
> +	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
>  
> +	list_for_each_entry_safe(mad_send_wr, n, &local_list, agent_list) {
>  		if (mad_send_wr->status == IB_WC_SUCCESS)
>  			mad_send_wc.status = IB_WC_RESP_TIMEOUT_ERR;
>  		else
> @@ -2655,11 +2660,8 @@ static void timeout_sends(struct work_struct *work)
>  		mad_send_wc.send_buf = &mad_send_wr->send_buf;
>  		mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
>  						   &mad_send_wc);

I understand the problem, but I'm not sure that this is safe to do. How
can we be sure that this is safe to call the send_handler on entry in
wait_list without the locking?

Thanks

> -
>  		deref_mad_agent(mad_agent_priv);
> -		spin_lock_irqsave(&mad_agent_priv->lock, flags);
>  	}
> -	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
>  }
>  
>  /*
> -- 
> 2.39.3
> 

