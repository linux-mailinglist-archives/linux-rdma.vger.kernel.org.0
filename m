Return-Path: <linux-rdma+bounces-5616-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A973E9B646D
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 14:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE172811C0
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 13:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E821E9092;
	Wed, 30 Oct 2024 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6YgYv6e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AE43FB31
	for <linux-rdma@vger.kernel.org>; Wed, 30 Oct 2024 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295809; cv=none; b=W239b+0QWJXVWKx8M0YBd6SeyAxHajbQkDuUpEqnXZQvMQ4wdMzh8DqwmnGPqTX1c5qlmD2izY1gqSp+6NOS/EJyqc8u3Irtv6e7v/RMLT7o9fE8Wdzl8Om0CwHJeu0SIqOOVZn86k7tmu73ziu4pGp0c7yRGDY4G5BzkIvUPWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295809; c=relaxed/simple;
	bh=idzsUxjoc34gvHpluCMztp4BpKhagLMk8CdVSEyniro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXTWt/4HcX+u/Ild0izulIwXEFBuC2mj6QEC4DvNjbFBuFJoy06mql0PpXDd6QAzOOhy7NKQxObUiZsNfQYV6t4OWzRKHek8jD6hZ29kj/KsM3sdtVwM8x1QtX+cGoLIhDcWfHZRnMdWZXKFmL/IKrI+AiKv5C+3E5t3RsVASWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6YgYv6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913DBC4CEE3;
	Wed, 30 Oct 2024 13:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730295809;
	bh=idzsUxjoc34gvHpluCMztp4BpKhagLMk8CdVSEyniro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R6YgYv6eJ1W9UiRhKa9ekEYzrC5Ssko1PfyZp+77xcUgRhJIv80gV0qrXafvCjLEH
	 IHvF/UmMRA+KZtyKKAPNo0dq0BwnAkUXcG15E2u3/rc5Ar1k1Iontkby/TjJFy4SL/
	 hLq5tBOei7fjkuVdYUclIs6sC92ijPblZKdwXvXvHKOAtn5fVgfPhVsdmXloaicK0B
	 pJc8S3emD1uUqlz4RqOv6dEEcwlUnSkH2qrnLU8rH9UShqlFG5A9WFaYNxy2tyCh9E
	 Dk5cQNDE7+nUBloOBHGlTMGHGCAhnl3XFAh/L6KjNfFTlF90jlaTavu/FbZ+1gy8+q
	 Uvc9U0fNWuQ5Q==
Date: Wed, 30 Oct 2024 15:43:25 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
	kashyap.desai@broadcom.com
Subject: Re: [PATCH for-next 1/4] RDMA/bnxt_re: Support driver specific data
 collection using rdma tool
Message-ID: <20241030134325.GB5988@unreal>
References: <1729591916-29134-1-git-send-email-selvin.xavier@broadcom.com>
 <1729591916-29134-2-git-send-email-selvin.xavier@broadcom.com>
 <20241029140319.GN1615717@unreal>
 <CA+sbYW1_DSX3g1-Q7YyOYGj2R7nNJVSCeY_GezBnHEQCRvn-Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+sbYW1_DSX3g1-Q7YyOYGj2R7nNJVSCeY_GezBnHEQCRvn-Vg@mail.gmail.com>

On Wed, Oct 30, 2024 at 01:59:06PM +0530, Selvin Xavier wrote:
> On Tue, Oct 29, 2024 at 7:33 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, Oct 22, 2024 at 03:11:53AM -0700, Selvin Xavier wrote:
> > > From: Kashyap Desai <kashyap.desai@broadcom.com>
> > >
> > > Allow users to dump driver specific resource details when
> > > queried through rdma tool. This supports the driver data
> > > for QP, CQ, MR and SRQ.
> > >
> > > Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > > Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > ---
> > >  drivers/infiniband/hw/bnxt_re/main.c | 148 +++++++++++++++++++++++++++++++++++
> > >  1 file changed, 148 insertions(+)
> > >
> > > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> > > index 6715c96..5bed9af 100644
> > > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > > @@ -882,6 +882,146 @@ static const struct attribute_group bnxt_re_dev_attr_group = {
> > >       .attrs = bnxt_re_attributes,
> > >  };
> > >
> > > +static int bnxt_re_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr)
> > > +{
> > > +     struct bnxt_qplib_hwq *mr_hwq;
> > > +     struct nlattr *table_attr;
> > > +     struct bnxt_re_mr *mr;
> > > +
> > > +     table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_DRIVER);
> > > +     if (!table_attr)
> > > +             return -EMSGSIZE;
> > > +
> > > +     mr = container_of(ib_mr, struct bnxt_re_mr, ib_mr);
> > > +     mr_hwq = &mr->qplib_mr.hwq;
> > > +
> > > +     if (rdma_nl_put_driver_string(msg, "owner",
> > > +                                   mr_hwq->is_user ?  "user" : "kernel"))
> >
> > Two comments:
> > 1. There is already a helper function to decide if owner is user or kernel - rdma_is_kernel_res().
> > 2. This print duplicates existing information. The difference between
> > user and kernel can be easily seen by looking on the PID output.
> Got it. I will remove this in the follow up patch.

Thanks

