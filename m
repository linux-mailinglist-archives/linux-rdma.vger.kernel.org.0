Return-Path: <linux-rdma+bounces-16929-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGGoM59yk2n75AEAu9opvQ
	(envelope-from <linux-rdma+bounces-16929-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 20:40:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B5D147516
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 20:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E755A3024958
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 19:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150FA2E88B6;
	Mon, 16 Feb 2026 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cbz9jROL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA742E54CC
	for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771270812; cv=none; b=Wj/4y4HvjJIlCjIYYoNKfh+fOUUV6puQQcPREIh7ZYvp+9AN9NfTlrWHbL74do8sOYJvkmO+GZcgSNNn3Ug7+Lx949eyGLWLkV3MKRlWEfwW+c3v4AFqGIo0cNK7puqpx8D0IV9YjWH9PrAOmrpIIWk7Z6bNjaDAhId/8yNcDao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771270812; c=relaxed/simple;
	bh=oNx02DxJngR7P3lr+ifhUuMYiqOZkwb0bIBGHfMYRSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqutprOanAnSeUNyjmkWT8GQqBjNKsrxn8HUxlE3wnIdrQ+z0pnFMmTe7zlrfyKl/XTm+Jh5Hr5D6eJn8r+marFTMntm+PayQ0Np4YILEiYqeC1NiDnRX2mHxucnOlogb9kYxki1wkqTyNkCSJ2ZqGI0bNmQX1Vahj9TG0qd8L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cbz9jROL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BF3C116C6;
	Mon, 16 Feb 2026 19:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771270812;
	bh=oNx02DxJngR7P3lr+ifhUuMYiqOZkwb0bIBGHfMYRSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cbz9jROLBwjsGuIJgWoxRep2cnmu06VFNAHlxxvbR1lB9P64pA5pAF4KtdiQ6u537
	 kL1Upgl5AHvPdYOUOUX0oEDy5RxEv4wSWYVB3Lchm2kgXl5jXV3mgsmH/39P4E9L6u
	 mZOYlSoF0n8fMaWDWMa6GQ3hLVh8WYs+0IfUA9z0EJqwM5u1Pz+UFFQKftWUdNFKZH
	 VasOEnz/2RHazLKfOq1WfQgVOKL6roHXC2yfIp6ZojsVABqthuHBKAFXvOGu/P3I9i
	 XegdW/BMj/iFsC4wqSgb6mrLMBdHwlX1gZpkQefb4YbLNVx8zbhErSO3m70e3+B+Nk
	 t8+69pY9ovWdA==
Date: Mon, 16 Feb 2026 21:40:08 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v12 5/6] RDMA/bnxt_re: Support dmabuf for CQ
 rings
Message-ID: <20260216194008.GG12989@unreal>
References: <20260211124927.57617-1-sriharsha.basavapatna@broadcom.com>
 <20260211124927.57617-6-sriharsha.basavapatna@broadcom.com>
 <20260213111256.GO12887@unreal>
 <20260213145425.GN750753@ziepe.ca>
 <20260213162211.GX12887@unreal>
 <CAHHeUGW5L_qkNv7y66WXK9f2XzH6Ja=uKnH5fFOTv_HLqo1yxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHHeUGW5L_qkNv7y66WXK9f2XzH6Ja=uKnH5fFOTv_HLqo1yxA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16929-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35B5D147516
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 08:30:35PM +0530, Sriharsha Basavapatna wrote:
> On Fri, Feb 13, 2026 at 9:52 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Fri, Feb 13, 2026 at 10:54:25AM -0400, Jason Gunthorpe wrote:
> > > On Fri, Feb 13, 2026 at 01:12:56PM +0200, Leon Romanovsky wrote:
> > > > > +int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
> > > > > +               struct uverbs_attr_bundle *attrs)
> > > > > +{
> > > > > + return bnxt_re_create_cq_umem(ibcq, attr, NULL, attrs);
> > > > > +}
> > > >
> > > > Please don't mix create_cq and create_cq_umem.
> > > > https://lore.kernel.org/linux-rdma/20260213-refactor-umem-v1-15-f3be85847922@nvidia.com/T/#u
> > >
> > > Either we drop this one patch and put those 50 ahead of it, or we just
> > > take this one and rebase the above.. The above has the advantage that
> > > it enables all drivers to support cq dmabuf in one giant shot.
> > >
> > > However, frankly I'm getting tired of looking at this bnxt_re stuff so
> > > I'd like to just see it done.
> >
> > In addition, push them to create 2 separate functions.
> > One is .create_cq_umem() for uverbs flow and another .create_cq()
> > variant for kernel flow.
> >
> > bnxt_re_create_cq()
> >  {
> >   if (udata)
> >      return bnxt_re_create_cq_umem()
> >
> >   .... <kernel CQ>
> >   }
> >
> > It will allow me to rebase my series more easily.
> >
> > Thanks
> The above change can be done as a separate patch once the current
> bnxt_re patch series gets merged. > I can push that before your patchset
> is ready to be merged. If you still want this change in the current
> series itself, I can do that too. Please confirm.

No concerns were raised about the first eight patches, so they are ready
to merge. This series, however, still requires further work.

Thanks

> 
> Thanks,
> -Harsha
> >
> > >
> > > Jason



