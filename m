Return-Path: <linux-rdma+bounces-14387-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228A9C4D0E3
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 11:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8906F421BC1
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 10:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24209337BB1;
	Tue, 11 Nov 2025 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pgrzjid3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8585221FBF
	for <linux-rdma@vger.kernel.org>; Tue, 11 Nov 2025 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856087; cv=none; b=pmfdz3+JcaMGgC/JAoPmKrAqP+ESEf2IZhBvmWZuzXrpR+y7M1lVs+Dn8O2/mNGamY5JFnVzsCyD63n0k9F8WrfQnxiHXb/QikrtTwkntV5TxGX4RaoDmHrDalh6P7m6SgSnfOjOipGH/VE4xj1S9MvUAw/AvL+hEEjx9SW07PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856087; c=relaxed/simple;
	bh=iVvrWclPnacklPtmCqpIwrEC3N3XlD9QcnUsUh6qEKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhxhtZOF3iXBEWKCL4Mnxd8VPkIctYC4d17Hz/CWBo++ilT9svR2bNeG9uf9afCVAqYhc/0kwNV2AYC9UdZOL/nyqzS1uFR59p5+bqOhowvvuzfkHMkPhtoeh3JNtQRpoJ0PhxX4pe2ce15A8Bw34zgTFHR49giE+8cBKA/5SAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pgrzjid3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060AAC4CEF7;
	Tue, 11 Nov 2025 10:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762856087;
	bh=iVvrWclPnacklPtmCqpIwrEC3N3XlD9QcnUsUh6qEKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pgrzjid3JTJ2Q3f2jc501HtFoUYlX95mkGMEwYcfxV7QRZhz1UjV/ihkpSFddpzkj
	 5j3QJ52sh8FZ+qYf/QuBKa5G9OecF5gIuhvyChF7k8Un4mlc1RU+y/o4VoXo1FNX5y
	 V5xmfC1ZPNQnpTqOzkoVYxtXMi5SohJirdkJaejEPRBLvl3Er7nDPiCYUO/IAB9dSz
	 oJFw+syCQtrapjvJyBwdGBNJOXCLgyK6+BU5NEpSG+cSaUvIKhrv9qwcuxmeL1p+lg
	 bbDzOBwQnfzSbN2IX2ukBeGeYD1TAfZPPBFTib4cjbVhH0QHmLgLhY+UsYdG7UDw78
	 cNtGo1GjYiiOw==
Date: Tue, 11 Nov 2025 12:14:43 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v2 2/4] RDMA/bnxt_re: Refactor
 bnxt_qplib_create_qp() function
Message-ID: <20251111101443.GM15456@unreal>
References: <20251104072320.210596-1-sriharsha.basavapatna@broadcom.com>
 <20251104072320.210596-3-sriharsha.basavapatna@broadcom.com>
 <20251109092143.GG15456@unreal>
 <CAHHeUGUtZ9b_sSW6Nsfca8Vj_zrVGKgK8eKg+MD+_NbCM6HWzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHHeUGUtZ9b_sSW6Nsfca8Vj_zrVGKgK8eKg+MD+_NbCM6HWzg@mail.gmail.com>

On Mon, Nov 10, 2025 at 08:19:45PM +0530, Sriharsha Basavapatna wrote:
> On Sun, Nov 9, 2025 at 2:51 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, Nov 04, 2025 at 12:53:18PM +0530, Sriharsha Basavapatna wrote:
> > > From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > >
> > > Inside bnxt_qplib_create_qp(), driver currently is doing
> > > a lot of things like allocating HWQ memory for SQ/RQ/ORRQ/IRRQ,
> > > initializing few of qplib_qp fields etc.
> > >
> > > Refactored the code such that all memory allocation for HWQs
> > > have been moved to bnxt_re_init_qp_attr() function and inside
> > > bnxt_qplib_create_qp() function just initialize the request
> > > structure and issue the HWRM command to firmware.
> > >
> > > Introduced couple of new functions bnxt_re_setup_qp_hwqs() and
> > > bnxt_re_setup_qp_swqs() moved the hwq and swq memory allocation
> > > logic there.
> > >
> > > This patch also introduces a change to store the PD id in
> > > bnxt_qplib_qp. Instead of keeping a pointer to "struct
> > > bnxt_qplib_pd", store PD id directly in "struct bnxt_qplib_qp".
> > > This change is needed for a subsequent change in this patch
> > > series. This PD ID value will be used in new DV implementation
> > > for create_qp(). There is no functional change.
> > >
> > > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > > Reviewed-by: Selvin Thyparampil Xavier <selvin.xavier@broadcom.com>
> > > Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
> > > ---
> > >  drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 207 ++++++++++++--
> > >  drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 311 +++++++---------------
> > >  drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  10 +-
> > >  drivers/infiniband/hw/bnxt_re/qplib_res.h |   6 +
> > >  4 files changed, 304 insertions(+), 230 deletions(-)
> >
> > <...>
> >
> > > +free_umem:
> > > +     if (uctx)
> > > +             bnxt_re_qp_free_umem(qp);
> >
> > <...>
> >
> > > +     if (udata)
> > > +             bnxt_re_qp_free_umem(qp);
> >
> > <...>
> >
> > Do you need to have if (..) here?
> > ib_umem_release() does nothing if pointer is NULL.
> Agreed, no need to have that if() check.
> >
> >
> > > +     kfree(sq->swq);
> > > +     sq->swq = NULL;
> >
> > Is this SQ reused?
> SQ is not reused after this clean up, no need to reset the pointer,
> will delete that line.
> >
> > > +     return rc;
> > > +}
> >
> > <...>
> >
> > >  struct bnxt_qplib_qp {
> > > -     struct bnxt_qplib_pd            *pd;
> > > +     u32                             pd_id;
> > >       struct bnxt_qplib_dpi           *dpi;
> > >       struct bnxt_qplib_chip_ctx      *cctx;
> > >       u64                             qp_handle;
> > > @@ -279,6 +279,7 @@ struct bnxt_qplib_qp {
> > >       u8                              wqe_mode;
> > >       u8                              state;
> > >       u8                              cur_qp_state;
> > > +     u8                              is_user;
> >
> > This is already known to IB/core, use rdma_is_kernel_res().
> This one is used in the qplib (fw interface) layer in the driver where
> we don't have the ib context, so I'd prefer to retain it.

My old plan was to rely on restrack for everything related to that,
together with removal of custom book-keeping logic.

This is why mlx5/mlx5 uses rdma_restrack_no_track() for internal objects.

Thanks

> Thanks,
> -Harsha
> >
> > Thanks



