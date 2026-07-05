Return-Path: <linux-rdma+bounces-22768-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YwbWBH1NSmq2BAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22768-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 14:26:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DD3709F2B
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 14:26:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JpXn5PS3;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22768-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22768-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6E75300FED0
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2026 12:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062A837DAA2;
	Sun,  5 Jul 2026 12:26:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A901D36CDE0;
	Sun,  5 Jul 2026 12:26:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783254390; cv=none; b=jN7oJkzkrxjsJFkcO3yW43ZTLeco9tQCdcXAWvEh+oB8Av7r4okRFA1XLapZXvkz9xuHd8YKHTk7Vza03aqW4jNMs5YvyedVy9D69vtJp7pEoIFAih8YtQobsJzubJ5ViaUgQd4gsMTTbt7yljX3jM53Lmop58ZN+VG8w0Hts50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783254390; c=relaxed/simple;
	bh=aB3Z9WGuFaC2BC1xe0HIlkuoBOZ55BrZBf5t7bPZfjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNJtVjhnBmCoJoV1/MV3l8OWvz/NT4WHVO+V40+KfVQ0OnuXDF3UBJYNQAO2zAO2IDi49CBO5kTltP+Hmi4+0CoFDMxfmqSSA0tOVKP1PTFRU4f8PvSWeSqRK1ktgO3Q7FMP2Jay3eOr6DHuocAYb7Yf4mLO/J3wsF3umZcVyrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpXn5PS3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A651F000E9;
	Sun,  5 Jul 2026 12:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783254389;
	bh=KzFnOOOKHluNEjhqZvTI1UdcNCzvMLYH9AIe8qq+Gzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JpXn5PS3TBYSjnkFHLsi1wWWXKWOQ1inO4WtwzNg99riF44E+1BA9AmcP69uTQ5DB
	 135k2sUEqTDbszGyyGzXFByzhtUZxNnR8r2D/5TdQSGDxKzx4tk8pklt7Emnr/k1AW
	 80a4/CgBCTVIfVdb95HERzIaPPfzF6CXzy7KR4eBUG9KLmBtxBCOv2vd7YSNbmWmeB
	 TzX+EJDIkZg9kwzbZJfq0P8Qv14moC1v1yejElKe4FMPyeXdGHG5HPkFdr+bys4uZG
	 5ac22Vyub9kLjWxyqxgxgAP/5GULjodurNbTCa7QlxbNsjl0f+xb52HP6KiRDtKOTC
	 qnDbhJPHQ7sbQ==
Date: Sun, 5 Jul 2026 15:26:23 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: WenTao Liang <vulab@iscas.ac.cn>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix: infiniband/rxe: check_rkey: fix refcount underflow
 due to unchecked rxe_get return value
Message-ID: <20260705122623.GE15188@unreal>
References: <20260626150511.50084-1-vulab@iscas.ac.cn>
 <c219948e-1fd3-4bcf-8e38-0db3bfa49a6d@linux.dev>
 <6597C9CE-970B-4650-97BD-651F8226E3D9@iscas.ac.cn>
 <f3a8dd38-7f9e-42d4-8e53-a5d1a973979d@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3a8dd38-7f9e-42d4-8e53-a5d1a973979d@linux.dev>
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
	FORGED_RECIPIENTS(0.00)[m:yanjun.zhu@linux.dev,m:vulab@iscas.ac.cn,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22768-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[unreal:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67DD3709F2B

On Sat, Jun 27, 2026 at 07:09:07PM -0700, Zhu Yanjun wrote:
> 
> 在 2026/6/27 4:45, WenTao Liang 写道:
> > 
> > 
> > > 2026年6月27日 09:42，yanjun.zhu <yanjun.zhu@linux.dev> 写道：
> > > 
> > > On 6/26/26 8:05 AM, WenTao Liang wrote:
> > > > rxe_get is a conditional get (kref_get_unless_zero) that returns 0 when
> > > >   the object's refcount is already zero. In check_rkey, the
> > > > return value of
> > > >   rxe_get(mr) is ignored. If rxe_get fails (returns 0), the code
> > > > continues
> > > >   to use mr without a valid reference, and error paths will call
> > > >   rxe_put(mr) on an unheld reference, causing a refcount underflow.
> > > > Check the return value of rxe_get and bail out with an error
> > > > when it fails.
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 290c4a902b79 ("RDMA/rxe: Fix \"Replace mr by rkey in
> > > > responder resources\"")
> > > > Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> > > > ---
> > > >  drivers/infiniband/sw/rxe/rxe_resp.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c
> > > > b/drivers/infiniband/sw/rxe/rxe_resp.c
> > > > index 9cb2f6fbf2dd..0c3f3930b494 100644
> > > > --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> > > > +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> > > > @@ -514,7 +514,12 @@ static enum resp_states check_rkey(struct
> > > > rxe_qp *qp,
> > > > if (mw->access & IB_ZERO_BASED)
> > > > qp->resp.offset = mw->addr;
> > > >  -rxe_get(mr);
> > > > +if (!rxe_get(mr)) {
> > > 
> > > Can you reproduce this (rxe_get(mr) = 0)?
> > > 
> > > Thanks a lot.
> > > 
> > > Zhu Yanjun
> > > 
> > > > +rxe_put(mw);
> > > > +mw = NULL;
> > > > +state = get_rkey_violation_state(pkt);
> > > > +goto err;
> > > > +}
> > > > rxe_put(mw);
> > > > mw = NULL;
> > > > } else {
> > 
> > Hi Zhu Yanjun,
> > 
> > Thank you for reviewing the patch.
> > 
> > I haven't been able to reproduce the exact scenario where rxe_get(mr)
> > returns 0 in testing, because the race window is extremely narrow.
> > 
> > However, this patch is a defensive fix based on code analysis:
> > 
> > 1. rxe_get() is a wrapper around kref_get_unless_zero and explicitly
> >    returns a success/failure indication. Ignoring the return value
> >    violates the API contract.
> static inline __must_check
> bool __refcount_add_not_zero(int i, refcount_t *r, int *oldp)
> {
>     int old = refcount_read(r);
> 
>     do {
>         if (!old)
>             break;
>     } while (!atomic_try_cmpxchg_relaxed(&r->refs, &old, old + i));
>     if (oldp)
>         *oldp = old;
> 
>     if (unlikely(old < 0 || old + i < 0))
> 
>         refcount_warn_saturate(r, REFCOUNT_ADD_NOT_ZERO_OVF);
> 
>     return old;
> }
> 
> 
> rxe_get will call the above function finally. Only mr->ref_cnt is zero, this
> rxe_get will return false.
> 
> When mr->ref_cnt is zero, mr will be destroyed in rxe_put. But in the
> function
> 
> 
>  444 static enum resp_states check_rkey(struct rxe_qp *qp,
>  445                    struct rxe_pkt_info *pkt)
> ...
>  507         mr = mw->mr;
>  508         if (!mr) {
>  509             rxe_dbg_qp(qp, "MW doesn't have an MR\n");
>  510             state = get_rkey_violation_state(pkt);
>  511             goto err;
>  512         }
>  513
>  514         if (mw->access & IB_ZERO_BASED)
>  515             qp->resp.offset = mw->addr;
>  516
>  517         rxe_get(mr);
>  518         rxe_put(mw);
>  519         mw = NULL;
> ...
> }
> 
> mr is guaranteed to be non-NULL by the checks above, and its reference count
> should be valid at this point.
> 
> It should be impossible for rxe_get() to fail here under normal conditions.

I came to the same conclusion. This rxe_get() is useless.

Thanks

