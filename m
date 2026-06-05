Return-Path: <linux-rdma+bounces-21875-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id att/NE4xI2oWkAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21875-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 22:27:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6AD64B27B
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 22:27:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=NzOuKHoK;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21875-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21875-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50406304094F
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 20:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B883C4163;
	Fri,  5 Jun 2026 20:24:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0293B2FC8
	for <linux-rdma@vger.kernel.org>; Fri,  5 Jun 2026 20:24:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691057; cv=none; b=X+eiSwkQ1FgPMxnx3w8SYmfpst/FEZdbF47/5MIHmmeWq7Gzx5FYaJs7a9Q9+E+AprBSenI+alXgRX8Hgv+xuDyZRzg6Tc+3xsrZkb7GSE1IzDjv4nIsRF3V8U/C+sXef+t/hZyhuHppkAa4CN+4VAkwfgJ3R8Y4IvwL/eNtxZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691057; c=relaxed/simple;
	bh=0alPM7ZjfAMd/ki603E0PbGRvyrSgLB7F40WRIYVdF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdE6yZlhHtfdJKj/5wzF8iJl0rvWCd1ralE4xFygGswn7VQ5CB/I3SZuEXAtgWQlvgZBxFndFunfj+x4XB67J6l1v4ZtmSKzxU8y+fJtrcmZyc0nyNusW7mOX48Gn85NTBAGk1O/GK2uT74qRRXxiPKM98ZlmCvOUfqjZBQ6o2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NzOuKHoK; arc=none smtp.client-ip=91.218.175.181
Message-ID: <8ae64c12-ee5b-4fec-a008-59eb82195331@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780691043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZclMYE4IkSoYpFS6tYNVUrhNnQaNYjUHDBmwWWKMtag=;
	b=NzOuKHoKcfLKFv9tsNIN0ji6QZQCek08iUgMDSPnaIdiP8taf3rS/rJE0SDzz1ysFMprGl
	0vDyWCxuESXl80XMeisjTr0IIMIsVyJ09Xy22kAnzsUwhrPLHmnP37SvkIMNzdJ86Q9PVK
	fD8H7y0PXk1c9fDSO0G5+2vjxGhqoss=
Date: Fri, 5 Jun 2026 13:23:50 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.6] RDMA/rxe: Fix "trying to register non-static key in
 rxe_qp_do_cleanup" bug
To: Vladislav Nikolaev <vlad102nikolaev@gmail.com>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Haggai Eran <haggaie@mellanox.com>,
 Kamal Heib <kamalh@mellanox.com>, Amir Vadai <amirv@mellanox.com>,
 Moni Shoua <monis@mellanox.com>, Yonatan Cohen <yonatanc@mellanox.com>,
 Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zhu Yanjun <yanjunz@nvidia.com>,
 lvc-project@linuxtesting.org,
 syzbot+4edb496c3cad6e953a31@syzkaller.appspotmail.com
References: <20260605165556.1082-1-vlad102nikolaev@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260605165556.1082-1-vlad102nikolaev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:vlad102nikolaev@gmail.com,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:yanjun.zhu@linux.dev,m:zyjzyj2000@gmail.com,m:dledford@redhat.com,m:jgg@ziepe.ca,m:haggaie@mellanox.com,m:kamalh@mellanox.com,m:amirv@mellanox.com,m:monis@mellanox.com,m:yonatanc@mellanox.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yanjunz@nvidia.com,m:lvc-project@linuxtesting.org,m:syzbot+4edb496c3cad6e953a31@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21875-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,linuxfoundation.org,linux.dev];
	FORGED_SENDER(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,ziepe.ca,mellanox.com,kernel.org,vger.kernel.org,nvidia.com,linuxtesting.org,syzkaller.appspotmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,4edb496c3cad6e953a31];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:from_mime,linux.dev:email,vger.kernel.org:from_smtp,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F6AD64B27B

On 6/5/26 9:55 AM, Vladislav Nikolaev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> commit 1c7eec4d5f3b39cdea2153abaebf1b7229a47072 upstream.
> 
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>   assign_lock_key kernel/locking/lockdep.c:986 [inline]
>   register_lock_class+0x4a3/0x4c0 kernel/locking/lockdep.c:1300
>   __lock_acquire+0x99/0x1ba0 kernel/locking/lockdep.c:5110
>   lock_acquire kernel/locking/lockdep.c:5866 [inline]
>   lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5823
>   __timer_delete_sync+0x152/0x1b0 kernel/time/timer.c:1644
>   rxe_qp_do_cleanup+0x5c3/0x7e0 drivers/infiniband/sw/rxe/rxe_qp.c:815
>   execute_in_process_context+0x3a/0x160 kernel/workqueue.c:4596
>   __rxe_cleanup+0x267/0x3c0 drivers/infiniband/sw/rxe/rxe_pool.c:232
>   rxe_create_qp+0x3f7/0x5f0 drivers/infiniband/sw/rxe/rxe_verbs.c:604
>   create_qp+0x62d/0xa80 drivers/infiniband/core/verbs.c:1250
>   ib_create_qp_kernel+0x9f/0x310 drivers/infiniband/core/verbs.c:1361
>   ib_create_qp include/rdma/ib_verbs.h:3803 [inline]
>   rdma_create_qp+0x10c/0x340 drivers/infiniband/core/cma.c:1144
>   rds_ib_setup_qp+0xc86/0x19a0 net/rds/ib_cm.c:600
>   rds_ib_cm_initiate_connect+0x1e8/0x3d0 net/rds/ib_cm.c:944
>   rds_rdma_cm_event_handler_cmn+0x61f/0x8c0 net/rds/rdma_transport.c:109
>   cma_cm_event_handler+0x94/0x300 drivers/infiniband/core/cma.c:2184
>   cma_work_handler+0x15b/0x230 drivers/infiniband/core/cma.c:3042
>   process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
>   process_scheduled_works kernel/workqueue.c:3319 [inline]
>   worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
>   kthread+0x3c2/0x780 kernel/kthread.c:464
>   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>   </TASK>
> 
> The root cause is as below:
> 
> In the function rxe_create_qp, the function rxe_qp_from_init is called
> to create qp, if this function rxe_qp_from_init fails, rxe_cleanup will
> be called to handle all the allocated resources, including the timers:
> retrans_timer and rnr_nak_timer.
> 
> The function rxe_qp_from_init calls the function rxe_qp_init_req to
> initialize the timers: retrans_timer and rnr_nak_timer.
> 
> But these timers are initialized in the end of rxe_qp_init_req.
> If some errors occur before the initialization of these timers, this
> problem will occur.
> 
> The solution is to check whether these timers are initialized or not.
> If these timers are not initialized, ignore these timers.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Reported-by: syzbot+4edb496c3cad6e953a31@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=4edb496c3cad6e953a31
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Link: https://patch.msgid.link/20250419080741.1515231-1-yanjun.zhu@linux.dev
> Signed-off-by: Leon Romanovsky <leon@kernel.org>
> [ Vladislav: keep del_timer_sync() because linux-6.6.y has not renamed it
>    to timer_delete_sync() yet. The actual fix is unchanged: check the timer
>    .function fields before deleting the timers. ]
> Signed-off-by: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
> ---
> Backport of upstream commit 1c7eec4d5f3b to linux-6.6.y.
>   drivers/infiniband/sw/rxe/rxe_qp.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index 287fc8b8f5ba..8426c261c263 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -817,7 +817,12 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
>   	spin_unlock_irqrestore(&qp->state_lock, flags);
>   	qp->qp_timeout_jiffies = 0;
>   
> -	if (qp_type(qp) == IB_QPT_RC) {
> +	/* In the function timer_setup, .function is initialized. If .function
> +	 * is NULL, it indicates the function timer_setup is not called, the
> +	 * timer is not initialized. Or else, the timer is initialized.
> +	 */
> +	if (qp_type(qp) == IB_QPT_RC && qp->retrans_timer.function &&
> +		qp->rnr_nak_timer.function) {
>   		del_timer_sync(&qp->retrans_timer);
>   		del_timer_sync(&qp->rnr_nak_timer);
>   	}
Thanks a lot.

Sashiko:

This isn't a bug introduced by this patch, but does this teardown sequence
leave a window for the timer to be illegally re-armed?
rxe_qp_do_cleanup() deletes the timers here before the asynchronous tasks
(like the completer task) are fully stopped by rxe_cleanup_task() just below
this block.
If rxe_completer() is already executing and has passed the qp->valid check
before it was cleared, del_timer_sync() will return immediately as the timer
isn't pending.
Then, rxe_completer() can process an incoming RNR NAK and reach
COMPST_RNR_RETRY, where it calls mod_timer(&qp->rnr_nak_timer, ...) without
holding the state_lock.
When the cleanup task unblocks and finishes, ib_destroy_qp_user() frees the
qp memory. Later, the newly armed rnr_nak_timer fires, and the
rnr_nak_timer() callback attempts to acquire the freed qp->state_lock,
resulting in a use-after-free.
Additionally, if a timer fires concurrently with teardown while the refcount
is already 0, it invokes rxe_sched_task(). The underlying rxe_get() fails
silently on the 0-refcount, but the task is still queued. When the task
finishes, it calls rxe_put(), triggering a refcount_t underflow.

I think it is not caused from this commit.
I am fine with this patch.

Zhu Yanjun

