Return-Path: <linux-rdma+bounces-18833-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NwbAGeJy2kuIwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18833-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 10:44:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB046366590
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 10:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4A69301D32B
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 08:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3471C3E3143;
	Tue, 31 Mar 2026 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXdHaeEt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93A123536B;
	Tue, 31 Mar 2026 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774946381; cv=none; b=KlWOK8OgTa9U27QrwNoqW2Tdc8MY2LyD0cUREqgklWYpmh+e1y4xLJ84ZWxb6fiEXNYqUKMDU25cfTmrjunIaW2MCyP6ftD/XGQbekGMtpnv1Uc5hxKvx/2XjGgnAi8EJXpfVViYOg/58LrZSyCDxCsXyexFp6n/uUiF6TqK/YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774946381; c=relaxed/simple;
	bh=9sA0RSLV5+ly21pfDzUPFohcEh6PFz1+BwavgS11Jjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYmSgpPv2eEwjvMGhml08haE/RXfa7ty0YlCjPJ0GPaBy8cGQuOdlAMDpSsbEwXj2JuUuee86UsuwB5UAN6kVj2x4Qiq52nVSip3TyjQr/KnCVyuoidBnD1kur9oL9ExCWUwHPgNPuLtf8Y2kUs9zBupS+8eLqK8qzt7RQhDQe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXdHaeEt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E524DC19423;
	Tue, 31 Mar 2026 08:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774946380;
	bh=9sA0RSLV5+ly21pfDzUPFohcEh6PFz1+BwavgS11Jjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QXdHaeEtt5Ygpyji6z/xXuLjEqwGjMQ/Sp1FN/mQ2+fxi2PSQp7uWY/j0NOmTQSTw
	 wL8FNAz3qm7sxxFcktmOGZoPY0Ijih+SPXYWE8u6EYWx5qVJ87XUTfv6G+eIXPVNuh
	 mbDjmCJQlg4JPOprQJhnmegmjeeTDKhk7fAXzwQHPdd4KVN60L7abuTEXxteDa1mV9
	 P2SCxMQ3nTv39zNrP4dCNDeUH88jiuMxgs6k9PqoPpCFkSLvJuwquC2I/jeBe8S67m
	 ywYE3vpGeijji9987NQqLhFiSlMRfwsXVV1LMpaeO5cKfvGYMtHiqkGjGR5SyMmXKy
	 NVL5A4/QbSnFA==
Date: Tue, 31 Mar 2026 11:39:36 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Keith Busch <kbusch@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
Message-ID: <20260331083936.GB814676@unreal>
References: <20260324234615.3731237-1-zhipingz@meta.com>
 <20260324234615.3731237-2-zhipingz@meta.com>
 <20260325082534.GN814676@unreal>
 <acW2BwQKaUbS3eL9@kbusch-mbp>
 <CAH3zFs1nbAKpYxwzMcwpC_Sdy+3tE0n0wUzxJ411gV-q1O++qQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH3zFs1nbAKpYxwzMcwpC_Sdy+3tE0n0wUzxJ411gV-q1O++qQ@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18833-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AB046366590
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 03:55:44PM -0700, Zhiping Zhang wrote:
> On Thu, Mar 26, 2026 at 3:41 PM Keith Busch <kbusch@kernel.org> wrote:
> >
> > >
> > On Wed, Mar 25, 2026 at 10:25:34AM +0200, Leon Romanovsky wrote:
> > > On Tue, Mar 24, 2026 at 04:46:02PM -0700, Zhiping Zhang wrote:
> > > >  struct vfio_device_feature_dma_buf {
> > > >     __u32   region_index;
> > > >     __u32   open_flags;
> > > > -   __u32   flags;
> > > > -   __u32   nr_ranges;
> > > > +   __u32   flags;
> > > > +#define VFIO_DMABUF_FL_TPH         (1U << 0) /* TPH info is present */
> > > > +#define VFIO_DMABUF_TPH_PH_SHIFT   1         /* bits 1-2: PH (2-bit) */
> > > > +#define VFIO_DMABUF_TPH_PH_MASK    0x6U
> > > > +#define VFIO_DMABUF_TPH_ST_SHIFT   16        /* bits 16-31: steering tag */
> > > > +#define VFIO_DMABUF_TPH_ST_MASK            0xffff0000U
> > >
> > > This extension of flags is basically kills future extension of this
> > > struct for anything that includes TPH.
> > >
> > > Add new
> > > enum vfio_device_feature_dma_buf_flags {
> > >     VFIO_DMABUF_FL_TPH  = 1 << 0
> > > }
> 
> yes we can do that.
> 
> > >
> > > > +   __u32   nr_ranges;
> > >
> > > add your "__u16 steering_tag" and "__u8 ph" fields here.
> >
> That is what I did in V1, Leon.

Not really, you did only half of the work. You didn't introduce new flag
and didn't calculate "old dma range" position.

Thanks

