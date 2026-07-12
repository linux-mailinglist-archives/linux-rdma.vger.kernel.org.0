Return-Path: <linux-rdma+bounces-23069-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WsnBHFtXU2rZZwMAu9opvQ
	(envelope-from <linux-rdma+bounces-23069-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 10:59:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B5874436F
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 10:59:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lL1lbCY1;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23069-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23069-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A6AF301113B
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 08:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089603911BD;
	Sun, 12 Jul 2026 08:59:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB8823BCF7;
	Sun, 12 Jul 2026 08:58:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783846740; cv=none; b=WWcdwefUVs4ZyWakpkVzebNTR0gMr/CkZXFTZriPPAEoKYYIP9JEDrgjuMqFSKURWI0DaXrj9x7BnezVAiZsBcWFMgHGeUivBH/RQ1dbcE1vLPy0UqVvkrYMhvD/ugBLtPO/7EfU7ThxW9wTNo+GoFBKQexasd8oNFA3Ez3GuXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783846740; c=relaxed/simple;
	bh=uRLQLRyxwtHE5O1pVBAZbAghFo7A6NH9F7/p5s8u9B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSQAPS/SKLn3rHLl/9EBLY25F9qGUrnGypeIdTTLNjR1g4kV+CHSB7i+/87M+dpVw9UJ7EVhE/YePpE3ksbbc0Ksjo+B3MeqFOw2eBFkuS5F8KIFxt0CXNL8vX/PS0QsYW5pAX59p0VwDHBq32Fwbv8Vy1/167uOU7hgNORmNgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lL1lbCY1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DEC1F000E9;
	Sun, 12 Jul 2026 08:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783846739;
	bh=J64ehip8Tb1bFN8XDylGiqy4Rg9r8gPvbRiDoeEVIVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lL1lbCY1I8kLeRQDlHoC50SDVImNz/MPH+BaENVBc8RswfONoeLeLpPoMgo5pJ4+N
	 7af8tGB3FPJiYrfT6ounX2pYSoiaFRpOLmTWiFylsTpBZ3zW5rLdXdX2FWkLf1gQON
	 6T8K6ED+AgwpdfqQllNeU+EZVr/Aty06WR3ZVdu7M+EIAkOXYOvLiyhU2ilMKL83Z2
	 gjLCf+TKTf7P6s9CwlAorB69U208V3myOy5DmBoawQoaepOYp3SxkoP0Ekg2S81VKF
	 x6g2lvQ+tOybB4uMorkyEjAAHJq+N8O2Jc5ecgun2Utpa0IxZPO0e9FFaDxy9RiaYE
	 gNefQ2Sx/b0hA==
Date: Sun, 12 Jul 2026 11:58:55 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "yanjun.zhu" <yanjun.zhu@linux.dev>
Cc: Ibrahim Hashimov <security@auditcode.ai>, zyjzyj2000@gmail.com,
	jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/rxe: fix responder UAF on
 IB_QP_MAX_DEST_RD_ATOMIC modify_qp
Message-ID: <20260712085855.GD33197@unreal>
References: <20260708224550.1281-1-security@auditcode.ai>
 <20260709072651.9040-1-security@auditcode.ai>
 <821c7993-b99d-42eb-be3f-0c2b9ac33340@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <821c7993-b99d-42eb-be3f-0c2b9ac33340@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23069-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[auditcode.ai,gmail.com,ziepe.ca,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:yanjun.zhu@linux.dev,m:security@auditcode.ai,m:zyjzyj2000@gmail.com,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,unreal:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00B5874436F

On Thu, Jul 09, 2026 at 11:24:32AM -0700, yanjun.zhu wrote:
> On 7/9/26 12:26 AM, Ibrahim Hashimov wrote:
> > rxe_qp_from_attr()'s IB_QP_MAX_DEST_RD_ATOMIC branch frees and
> > reallocates qp->resp.resources[] (the rd_atomic resource array used by
> > the responder to track in-flight RDMA READ/ATOMIC/FLUSH requests)
> > completely outside of the IB_QP_STATE handling above it. Unlike every
> > other place that tears this array down -- rxe_qp_reset(), reached only
> > under IB_QP_STATE, always calls rxe_disable_task(&qp->recv_task) /
> > rxe_disable_task(&qp->send_task) to drain the responder and requester
> > tasks before touching per-QP state, then re-enables them -- this branch
> > runs with the responder task (rxe_receiver(), scheduled as recv_task on
> > the rxe_wq workqueue) fully live and unlocked. A userspace modify_qp()
> > that sets only IB_QP_MAX_DEST_RD_ATOMIC (no state change, so
> > __qp_chk_state()/ib_modify_qp_is_ok() never runs and qp->state_lock is
> > never taken here) can therefore race the responder in two ways:
> > 
> >   1. free_rd_atomic_resources() calls kfree(qp->resp.resources) and
> >      alloc_rd_atomic_resources() kzalloc_objs()'s a new array while
> >      rxe_prepare_res()/find_resource() in rxe_resp.c are concurrently
> >      walking &qp->resp.resources[i] with no lock held -- a straight
> >      free-vs-read race on the array itself.
> > 
> >   2. free_rd_atomic_resources() only NULLs qp->resp.resources; it never
> >      clears qp->resp.res, the raw pointer *into* that array that
> >      rxe_resp.c caches across a multi-packet RDMA READ/ATOMIC/FLUSH
> >      reply (set at rxe_resp.c read/atomic/flush-reply sites, cleared
> >      only on the normal completion paths). If a modify_qp() races a
> >      resource still referenced by qp->resp.res, the array is freed out
> >      from under the cached pointer and the next reply packet dereferences
> >      it -- independent of the kfree/kzalloc_objs() window in (1).
> > 
> > Reproduced with KASAN: a single process driving one RC QP pair in rxe
> > loopback, one thread pumping large multi-packet IBV_WR_RDMA_READs
> > against qpB while a second thread hammers
> > ibv_modify_qp(qpB, IB_QP_MAX_DEST_RD_ATOMIC), reliably (~11s) produces
> > 
> >    BUG: KASAN: slab-use-after-free in rxe_receiver+0x4f78/0x89e0 [rdma_rxe]
> >    Workqueue: rxe_wq do_work [rdma_rxe]
> > 
> > with the freed kmalloc-1k object being the rd_atomic resource array
> > freed by the modify_qp() thread while the recv_task kworker reads it.
> > An identical run modifying only IB_QP_MIN_RNR_TIMER (no resource free)
> > is clean.
> > 
> > Fix both races the same way rxe_qp_reset() already handles tearing down
> > this exact array: quiesce the responder task around the free/realloc by
> > calling rxe_disable_task(&qp->recv_task) before free_rd_atomic_resources()
> > and rxe_enable_task(&qp->recv_task) only after alloc_rd_atomic_resources()
> > has succeeded, so rxe_receiver() cannot observe the array mid-free/
> > mid-realloc. On the alloc-failure path the responder is deliberately
> > left quiesced: qp->resp.resources is NULL at that point and
> > rxe_prepare_res()/find_resource() would dereference it, so recv_task
> > must not be re-enabled until a fresh array has been installed. And
> > close the still-open window for (2) at the source: have
> > free_rd_atomic_resources() clear qp->resp.res along with
> > qp->resp.resources, exactly like the existing completion paths in
> > rxe_resp.c (check_rkey()/duplicate_request()/RESPST_CLEANUP) already do
> > when a resource's lifetime ends, so a drained-and-resumed responder
> > restarts at RESPST_CHK_PSN against the fresh array instead of replaying
> > a stale reference into the old one.
> > 
> > Only qp->recv_task is drained: qp->resp.resources / qp->resp.res are
> > touched exclusively by the responder (rxe_resp.c); the requester
> > (send_task / rxe_sender()) never reads them, so there is no need to
> > widen this beyond what rxe_qp_reset() would drain for the equivalent
> > state.
> > 
> > Verified on the same v6.19 KASAN stand: with this fix applied, the
> > identical differential reproducer drives sustained MAX_DEST_RD_ATOMIC
> > storms against qpB well past the ~11s pre-fix time-to-first-splat with
> > zero KASAN reports, versus reliably tripping the slab-use-after-free in
> > rxe_receiver() described above before the fix.
> > 
> > Fixes: 8700e3e7c485 ("Soft RoCE driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> > Assisted-by: AuditCode-AI:2026.07
> > ---
> > v2: address Zhu Yanjun's review of v1
> >      (https://lore.kernel.org/linux-rdma/20260708224550.1281-1-security@auditcode.ai/):
> >      only re-enable recv_task after alloc_rd_atomic_resources() succeeds, so
> >      the responder is not resumed against a NULL qp->resp.resources on the
> >      ENOMEM path (rxe_prepare_res()/find_resource() would dereference it).
> >      No change to the successful path; fix description updated accordingly.
> > 
> >   drivers/infiniband/sw/rxe/rxe_qp.c | 16 +++++++++++++++-
> >   1 file changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> > index f3dff1aea96a..e39fb144cbbb 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> > @@ -172,6 +172,7 @@ static void free_rd_atomic_resources(struct rxe_qp *qp)
> >   		}
> >   		kfree(qp->resp.resources);
> >   		qp->resp.resources = NULL;
> > +		qp->resp.res = NULL;
> >   	}
> >   }
> > @@ -709,11 +710,24 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
> >   		qp->attr.max_dest_rd_atomic = max_dest_rd_atomic;
> > +		/*
> > +		 * This branch is not gated by IB_QP_STATE, so the responder
> > +		 * task is live here. Quiesce it the way rxe_qp_reset() does
> > +		 * before swapping the rd_atomic resource array, so
> > +		 * rxe_receiver() cannot race the free/realloc.
> > +		 */
> > +		rxe_disable_task(&qp->recv_task);
> >   		free_rd_atomic_resources(qp);
> > -
> >   		err = alloc_rd_atomic_resources(qp, max_dest_rd_atomic);
> > +		/*
> > +		 * On failure the responder stays quiesced: qp->resp.resources
> > +		 * is NULL now, and rxe_prepare_res()/find_resource() would
> > +		 * dereference it, so do not re-enable recv_task until a fresh
> > +		 * array has been installed.
> > +		 */
> >   		if (err)
> >   			return err;
> > +		rxe_enable_task(&qp->recv_task);
> 
> Thanks a lot. I am fine with this commit. Please Leon and Jason comment on
> this commit.

1. Please send patches as a standalone series, not as a reply to
   the previous one.

2. Write commit messages in a clear and sensible way so they are
   easy for humans to understand. Keep them short and direct, and
   describe the function call flow instead of producing AI prose.

Thanks

> 
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Zhu Yanjun
> 
> >   	}
> >   	if (mask & IB_QP_EN_SQD_ASYNC_NOTIFY)
> 

