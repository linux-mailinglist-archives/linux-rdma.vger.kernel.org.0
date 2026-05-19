Return-Path: <linux-rdma+bounces-20950-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLk5M2T+C2qrTAUAu9opvQ
	(envelope-from <linux-rdma+bounces-20950-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 08:08:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7742D577BF2
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 08:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAF19301D6A0
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 06:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337E337AA94;
	Tue, 19 May 2026 06:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JqJmJ/Y6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F633345A;
	Tue, 19 May 2026 06:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779170879; cv=none; b=tyQYNN8zNO/aWBMTVYS8/R7ewITvqoOTDZFAOSZT27dqPgDjktzBdYpcLxwMzaqt567ETuDmqXEY7y1BUWNKrdu1o/XG4wptqtvQFHoQ8UbZ37SLmso4m9W17kUSjba2ASydKUVt5SMb/0yMdLtytkfLSYUgqvG18SXQceJMm9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779170879; c=relaxed/simple;
	bh=PZndKE+k5QGC8aLpPQMN1H7BjKRFK23i1VvVtQVRyTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TV8gCfuY026bF6lDJlcS0BkQLW1H8PF6WIw/LTei0Ky/IHYGeX2aMZuO+EpZN9WQVItN0v769VqBa1YftE2bpo7lzdLVyYKh/IYBJBP9jpQFgU2makTxV7cjnoGDNFj4dKU2CjEohpwZD3ZqYsp1FEoyaRUG3jjSmqqxyMYPAAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JqJmJ/Y6; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779170865; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=rK/MNzc7TgF79y6vUvuw5P/fnsxLJQlPVnDjCHUzi7k=;
	b=JqJmJ/Y6hEKRoXVia4v7r6Gxgm7rVstruzpnzhK4Fpb3CV3ajdpi/QeNaksOqURcfRTOOWyBe7C+5xSaOSJUEFl+1sjoL5PVp1UAqDGfcbXPw47PoCFPMSoP8ioAhdyKToGsu3Ae2AWXL54ESqiRq62vSPhhFkv91dJEI/nth8I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X3EVwCV_1779170864;
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0X3EVwCV_1779170864 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 19 May 2026 14:07:44 +0800
Date: Tue, 19 May 2026 14:07:44 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Paolo Abeni <pabeni@redhat.com>
Cc: alibuda@linux.alibaba.com, davem@davemloft.net,
	dust.li@linux.alibaba.com, edumazet@google.com, kuba@kernel.org,
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com,
	horms@kernel.org, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com, pasic@linux.ibm.com
Subject: Re: [PATCH net-next 2/2] net/smc: reduce TX slot contention with
 exclusive wait
Message-ID: <20260519060744.GA7104@j66a10360.sqa.eu95>
References: <20260508063718.101622-3-alibuda@linux.alibaba.com>
 <20260512082643.89020-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512082643.89020-1-pabeni@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url,linux.alibaba.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20950-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.alibaba.com:+]
X-Rspamd-Queue-Id: 7742D577BF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 12, 2026 at 10:26:43AM +0200, Paolo Abeni wrote:
> From: AI Reviewer <ai@example.com>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> net/smc: reduce TX slot contention with exclusive wait
> 
> This patch replaces the non-exclusive wait_event_interruptible_timeout()
> in smc_wr_tx_get_free_slot() with an open-coded exclusive wait loop via
> prepare_to_wait_exclusive(), so wake_up() on a freed TX slot wakes only
> a single waiter instead of the entire wait queue.
> 
> > diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
> > index 48037a3d97a3..0a6f2befb0e2 100644
> > --- a/net/smc/smc_wr.c
> > +++ b/net/smc/smc_wr.c
> > @@ -171,17 +173,27 @@ int smc_wr_tx_get_free_slot(struct smc_link *link,
> >  		if (rc)
> >  			return rc;
> >  	} else {
> > -		rc = wait_event_interruptible_timeout(
> > -			link->wr_tx_wait,
> > -			!smc_link_sendable(link) ||
> > -			lgr->terminating ||
> > -			(smc_wr_tx_get_free_slot_index(link, &idx) != -EBUSY),
> > -			SMC_WR_TX_WAIT_FREE_SLOT_TIME);
> > -		if (!rc) {
> > -			/* timeout - terminate link */
> > -			smcr_link_down_cond_sched(link);
> > -			return -EPIPE;
> > +		rc = 0;
> > +		for (;;) {
> > +			prepare_to_wait_exclusive(&link->wr_tx_wait, &wait,
> > +						  TASK_INTERRUPTIBLE);
> > +			if (!smc_link_sendable(link) || lgr->terminating ||
> > +			    smc_wr_tx_get_free_slot_index(link, &idx) != -EBUSY)
> > +				break;
> > +			timeout = schedule_timeout(timeout);
> > +			if (!timeout) {
> > +				/* timeout - terminate link */
> > +				smcr_link_down_cond_sched(link);
> > +				break;
> > +			}
> > +			if (signal_pending(current)) {
> > +				rc = -ERESTARTSYS;
> > +				break;
> > +			}
> 
> [High]
> With exclusive waiters, wake_up() on link->wr_tx_wait wakes only one
> task per freed slot. If that waiter is about to exit via the
> signal_pending() branch, can the freed slot be lost to the remaining
> sleepers?
> 
> Consider two exclusive waiters A and B asleep in schedule_timeout():
> 
>   1. smc_wr_tx_put_slot() -> wake_up(&link->wr_tx_wait) is effectively
>      __wake_up(..., nr_exclusive=1).  default_wake_function makes A
>      runnable, autoremove_wake_function pulls A off the queue, and
>      __wake_up_common stops -- B is not woken.
> 
>   2. A signal is delivered to A before it actually runs.  Because A is
>      already TASK_RUNNING, signal_wake_up only sets TIF_SIGPENDING.
> 
>   3. A returns from schedule_timeout() with timeout > 0, so the
>      !timeout branch is skipped.  signal_pending(current) is true, so
>      the loop sets rc = -ERESTARTSYS and breaks without re-testing
>      smc_wr_tx_get_free_slot_index() and without issuing any wake_up()
>      on the way out.
> 
>   4. B stays asleep on the wait queue even though the wr_tx_mask bit
>      for the freed slot is still available.  With no further
>      completions, B sleeps until the full SMC_WR_TX_WAIT_FREE_SLOT_TIME
>      expires, at which point smcr_link_down_cond_sched() tears down an
>      otherwise healthy link.
> 
> The previous wait_event_interruptible_timeout() was non-exclusive, so
> every waiter was woken on each wake_up() and re-evaluated the
> condition, which avoided this class of lost-wakeup.
> 
> Should the signal path re-check the slot condition before returning,
> or issue a wake_up() on exit so another exclusive waiter gets a chance
> at the slot?
> 

Thanks for the review, all three points are valid.

[High] & [Low]: Both resolved by a unified re-check after finish_wait():
if no slot was acquired in the loop (due to signal or timeout),
re-evaluate the condition one final time. If a slot is now available,
claim it and proceed. No wake_up() is needed on exit — the teardown path
already does wake_up_all when the link goes down, and waking the next
waiter when no slot exists is pointless.

> [Medium]
> The commit message says this is a contention optimization and that
> "teardown behavior is unchanged", but does it also change the errno
> returned to callers on signal delivery?
> 
> Before this patch, wait_event_interruptible_timeout() returned
> -ERESTARTSYS on signal; that value is non-zero, so the old if (!rc)
> branch was skipped, control fell through to the trailing
> if (idx == link->wr_tx_cnt) return -EPIPE, and callers saw -EPIPE.
> 
> After the patch, the signal path does:
> 
>     if (signal_pending(current)) {
>         rc = -ERESTARTSYS;
>         break;
>     }
>     ...
>     finish_wait(&link->wr_tx_wait, &wait);
>     if (rc)
>         return rc;
> 
> so -ERESTARTSYS propagates up through smc_cdc_get_free_slot() (which
> only remaps rc to -EPIPE when conn->killed is set),
> smcr_cdc_get_slot_and_msg_send(), smc_cdc_get_slot_and_msg_send() and
> smc_tx_sendmsg(), meaning userspace sees syscall restart / -EINTR
> instead of -EPIPE.
> 
> Note that the sibling smc_wr_reg_send() in the same file explicitly
> converts -ERESTARTSYS to -EINTR.  Should this return-code change be
> called out in the commit message (and possibly split out), given that
> the stated intent of the patch is purely to reduce contention?

Agreed. I'll keep the return code as -EPIPE to match the original behavior, so
this patch remains a pure contention optimization with no semantic
change.


> [Low]
> On timeout expiry the new loop takes the teardown path without
> re-testing whether a slot became available:
> 
> > +			timeout = schedule_timeout(timeout);
> > +			if (!timeout) {
> > +				/* timeout - terminate link */
> > +				smcr_link_down_cond_sched(link);
> > +				break;
> > +			}
> 
> The old wait_event_interruptible_timeout() expansion re-evaluated the
> condition via ___wait_cond_timeout after schedule_timeout() returned
> 0, so a wake_up() racing with timer expiry could still report success
> and let smc_wr_tx_get_free_slot_index() claim the slot.
> 
> In the narrow race where a slot is freed at the same instant the
> timer fires, does this now tear the link down even though a slot was
> actually available?
> 
> >  		}
> > +		finish_wait(&link->wr_tx_wait, &wait);
> > +		if (rc)
> > +			return rc;
> >  		if (idx == link->wr_tx_cnt)
> >  			return -EPIPE;
> >  	}

D. Wythe

> -- 
> This is an AI-generated review.

