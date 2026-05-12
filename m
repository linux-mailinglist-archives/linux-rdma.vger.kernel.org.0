Return-Path: <linux-rdma+bounces-20463-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE6THK/kAmpEyQEAu9opvQ
	(envelope-from <linux-rdma+bounces-20463-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 10:28:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A41951CB1D
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 10:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72341301D4BF
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 08:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219164949F7;
	Tue, 12 May 2026 08:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZy1MWXc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BED84949FF
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574459; cv=none; b=OxA7ZgW5zUt7lftW3OQA5bHcs0QyvbDowQsSM5s/kHKHkkF3T45LZ45Lghnx48CI40HtomkJAYK0zKAZRD848G1O+Iv/LRfT31iHN9GIzg1OuPWcls3H3WXwGPFULVg5NwDuax4zXtjeorGK08KRlbN2+GFQwu39cHG9iK32a5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574459; c=relaxed/simple;
	bh=3f3TWl/FMyDabHUfcf1LYXSNUp/KGmnxIWuBbs4atEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMzFUNF5tAv7Tud6RWiUBkfyYWMaBD/99FRT8Jc27jkk6Ma5EjGTAi9cK+cKveIc/KdLgg59JPNt5c0EV/q/lY77t+7eOnhjPUVtbQFCgauZKT8aHnLtk11il9pi0xs661CQfFDyjyh4uEWy3yXK9GeAGIiuT/A20w55kup+yeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZy1MWXc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778574457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YNx0TFbbiCBLwtVn8Zame8DbRPfhYzAJuNIRgs2yuOA=;
	b=RZy1MWXcfLTXYFp9+z8BneUtjAnyr8zdk9Bcrf/63vAJg6Aa6mB6fsS2+K/o6mA0GmIHV7
	YJD3YHZSZXwNBhKMUhQRJtGSetdGx+k9Fwn53exO1FI/CEzajp3y6n81F/ksPSAqBfDTkB
	p+OXSMPnptycFdsneM5rvpm/nmCW2kk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-pdQZZTbpP0WDI5-TwzXooQ-1; Tue,
 12 May 2026 04:27:34 -0400
X-MC-Unique: pdQZZTbpP0WDI5-TwzXooQ-1
X-Mimecast-MFC-AGG-ID: pdQZZTbpP0WDI5-TwzXooQ_1778574451
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E7851956095;
	Tue, 12 May 2026 08:27:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.142])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 797D418004A3;
	Tue, 12 May 2026 08:27:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: alibuda@linux.alibaba.com
Cc: davem@davemloft.net,
	dust.li@linux.alibaba.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	mjambigi@linux.ibm.com,
	horms@kernel.org,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com,
	pasic@linux.ibm.com
Subject: Re: [PATCH net-next 2/2] net/smc: reduce TX slot contention with exclusive wait
Date: Tue, 12 May 2026 10:26:43 +0200
Message-ID: <20260512082643.89020-1-pabeni@redhat.com>
In-Reply-To: <20260508063718.101622-3-alibuda@linux.alibaba.com>
References: <20260508063718.101622-3-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 6A41951CB1D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20463-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Action: no action

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net/smc: reduce TX slot contention with exclusive wait

This patch replaces the non-exclusive wait_event_interruptible_timeout()
in smc_wr_tx_get_free_slot() with an open-coded exclusive wait loop via
prepare_to_wait_exclusive(), so wake_up() on a freed TX slot wakes only
a single waiter instead of the entire wait queue.

> diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
> index 48037a3d97a3..0a6f2befb0e2 100644
> --- a/net/smc/smc_wr.c
> +++ b/net/smc/smc_wr.c
> @@ -171,17 +173,27 @@ int smc_wr_tx_get_free_slot(struct smc_link *link,
>  		if (rc)
>  			return rc;
>  	} else {
> -		rc = wait_event_interruptible_timeout(
> -			link->wr_tx_wait,
> -			!smc_link_sendable(link) ||
> -			lgr->terminating ||
> -			(smc_wr_tx_get_free_slot_index(link, &idx) != -EBUSY),
> -			SMC_WR_TX_WAIT_FREE_SLOT_TIME);
> -		if (!rc) {
> -			/* timeout - terminate link */
> -			smcr_link_down_cond_sched(link);
> -			return -EPIPE;
> +		rc = 0;
> +		for (;;) {
> +			prepare_to_wait_exclusive(&link->wr_tx_wait, &wait,
> +						  TASK_INTERRUPTIBLE);
> +			if (!smc_link_sendable(link) || lgr->terminating ||
> +			    smc_wr_tx_get_free_slot_index(link, &idx) != -EBUSY)
> +				break;
> +			timeout = schedule_timeout(timeout);
> +			if (!timeout) {
> +				/* timeout - terminate link */
> +				smcr_link_down_cond_sched(link);
> +				break;
> +			}
> +			if (signal_pending(current)) {
> +				rc = -ERESTARTSYS;
> +				break;
> +			}

[High]
With exclusive waiters, wake_up() on link->wr_tx_wait wakes only one
task per freed slot. If that waiter is about to exit via the
signal_pending() branch, can the freed slot be lost to the remaining
sleepers?

Consider two exclusive waiters A and B asleep in schedule_timeout():

  1. smc_wr_tx_put_slot() -> wake_up(&link->wr_tx_wait) is effectively
     __wake_up(..., nr_exclusive=1).  default_wake_function makes A
     runnable, autoremove_wake_function pulls A off the queue, and
     __wake_up_common stops -- B is not woken.

  2. A signal is delivered to A before it actually runs.  Because A is
     already TASK_RUNNING, signal_wake_up only sets TIF_SIGPENDING.

  3. A returns from schedule_timeout() with timeout > 0, so the
     !timeout branch is skipped.  signal_pending(current) is true, so
     the loop sets rc = -ERESTARTSYS and breaks without re-testing
     smc_wr_tx_get_free_slot_index() and without issuing any wake_up()
     on the way out.

  4. B stays asleep on the wait queue even though the wr_tx_mask bit
     for the freed slot is still available.  With no further
     completions, B sleeps until the full SMC_WR_TX_WAIT_FREE_SLOT_TIME
     expires, at which point smcr_link_down_cond_sched() tears down an
     otherwise healthy link.

The previous wait_event_interruptible_timeout() was non-exclusive, so
every waiter was woken on each wake_up() and re-evaluated the
condition, which avoided this class of lost-wakeup.

Should the signal path re-check the slot condition before returning,
or issue a wake_up() on exit so another exclusive waiter gets a chance
at the slot?

[Medium]
The commit message says this is a contention optimization and that
"teardown behavior is unchanged", but does it also change the errno
returned to callers on signal delivery?

Before this patch, wait_event_interruptible_timeout() returned
-ERESTARTSYS on signal; that value is non-zero, so the old if (!rc)
branch was skipped, control fell through to the trailing
if (idx == link->wr_tx_cnt) return -EPIPE, and callers saw -EPIPE.

After the patch, the signal path does:

    if (signal_pending(current)) {
        rc = -ERESTARTSYS;
        break;
    }
    ...
    finish_wait(&link->wr_tx_wait, &wait);
    if (rc)
        return rc;

so -ERESTARTSYS propagates up through smc_cdc_get_free_slot() (which
only remaps rc to -EPIPE when conn->killed is set),
smcr_cdc_get_slot_and_msg_send(), smc_cdc_get_slot_and_msg_send() and
smc_tx_sendmsg(), meaning userspace sees syscall restart / -EINTR
instead of -EPIPE.

Note that the sibling smc_wr_reg_send() in the same file explicitly
converts -ERESTARTSYS to -EINTR.  Should this return-code change be
called out in the commit message (and possibly split out), given that
the stated intent of the patch is purely to reduce contention?

[Low]
On timeout expiry the new loop takes the teardown path without
re-testing whether a slot became available:

> +			timeout = schedule_timeout(timeout);
> +			if (!timeout) {
> +				/* timeout - terminate link */
> +				smcr_link_down_cond_sched(link);
> +				break;
> +			}

The old wait_event_interruptible_timeout() expansion re-evaluated the
condition via ___wait_cond_timeout after schedule_timeout() returned
0, so a wake_up() racing with timer expiry could still report success
and let smc_wr_tx_get_free_slot_index() claim the slot.

In the narrow race where a slot is freed at the same instant the
timer fires, does this now tear the link down even though a slot was
actually available?

>  		}
> +		finish_wait(&link->wr_tx_wait, &wait);
> +		if (rc)
> +			return rc;
>  		if (idx == link->wr_tx_cnt)
>  			return -EPIPE;
>  	}
-- 
This is an AI-generated review.


