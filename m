Return-Path: <linux-rdma+bounces-5271-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD88993274
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 18:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0606F1F23A01
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 16:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4F11D9673;
	Mon,  7 Oct 2024 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAnzfgRA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D21B1D4159;
	Mon,  7 Oct 2024 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317142; cv=none; b=dTciAgkiQdrYXaPLD3wwI69wZS7Mc2LxIlPa4rYULvIsSPpZ4ribqxF59p97K/GV+7Cx/AgjvDjzC/VCJ/C3f3gO5G1D12EBAklOaswT0IHK04TPWZOAeiVsvLCr4AJNgJ92NV6qXoImIQUOcm5vCqdv0POPFUPJa/PpXTfXHW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317142; c=relaxed/simple;
	bh=Wik2ZNckPsF3bment4+YQxfrCjOk2EqgG9bLXnQpZp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcrF+E6ZzY56WQA2oq8n6BIDarkzBzOZI3ruoeplqTeGzXzQUson0MlX2Bv/LQ8cl8KNR3TpY3xig77GJ226aNV8mJkSJLCluEovTkWZMCL+g5HW5d9IIJhKlQ2CYOGnQngWyO99PAID8qCw7nRilSLQude3nkUhwBXQkO4gIIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAnzfgRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23545C4CEC6;
	Mon,  7 Oct 2024 16:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728317142;
	bh=Wik2ZNckPsF3bment4+YQxfrCjOk2EqgG9bLXnQpZp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XAnzfgRA40dAcCSLxtt5xrFfF+8+8a6jRCyBwnogoHgazr/dLvckNs5p/I+it6em7
	 E0GlHz0M2mQSICLhvYMmLo1FxvqfyWMp+gqpvW8+pk3hfA24INtHl/u+nTTBf0KoTi
	 GOdqszfe5xlY5YDB9IOtT4lmCPN/jIVPBGjp3WD/BsYp64pK0S89s3OHlIQkmwKqrE
	 8Axz5Eb3SKCeUr1NnkJESZLX8WAQ6bmpAFGxntYE9duU/NpH5G+5ozqkDv9AIPO4mD
	 8zAuZFdmqoS8p5lYnW7InFHi8UtLYdhJft6gHix1okDvIulyVUzEh2aV0jm/erVBDH
	 UqTsp0yMR5wGw==
Date: Mon, 7 Oct 2024 19:05:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: maorg@nvidia.com, bharat@chelsio.com, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: of c4iw_fill_res_qp_entry
Message-ID: <20241007160534.GA25819@unreal>
References: <Zv_4qAxuC0dLmgXP@gallifrey>
 <20241006140558.GF4116@unreal>
 <ZwKehJ34PzNN6FQx@gallifrey>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwKehJ34PzNN6FQx@gallifrey>

On Sun, Oct 06, 2024 at 02:28:20PM +0000, Dr. David Alan Gilbert wrote:
> * Leon Romanovsky (leon@kernel.org) wrote:
> > On Fri, Oct 04, 2024 at 02:16:08PM +0000, Dr. David Alan Gilbert wrote:
> > > Hi,
> > >   One of my scripts noticed that c4iw_fill_res_qp_entry is not called
> > > anywhere; It came from:
> > > 
> > > commit 5cc34116ccec60032dbaa92768f41e95ce2d8ec7
> > > Author: Maor Gottlieb <maorg@mellanox.com>
> > > Date:   Tue Jun 23 14:30:38 2020 +0300
> > > 
> > >     RDMA: Add dedicated QP resource tracker function
> > >     
> > > I was going to send a patch to deadcode it, but is it really a bug and
> > > it should be assigned in c4iw_dev_ops in cxgb4/provider.c ?
> > > 
> > > (Note I know nothing about the innards of your driver, I'm just spotting
> > > the unused function).
> 
> Thanks for the reply,
> 
> > It is a bug, something like that should be done.
> 
> Ah good I spotted; out of curiosity, what would be the symptom?

User will run "rdma resource show qp -d" and won't get any vendor
specific information.

> 
> I don't have the hardware to test this, can I suggest that you send that patch?

Sure, will do.

> 
> Dave
> 
> > diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
> > index 10a4c738b59f..e059f92d90fd 100644
> > --- a/drivers/infiniband/hw/cxgb4/provider.c
> > +++ b/drivers/infiniband/hw/cxgb4/provider.c
> > @@ -473,6 +473,7 @@ static const struct ib_device_ops c4iw_dev_ops = {
> >         .fill_res_cq_entry = c4iw_fill_res_cq_entry,
> >         .fill_res_cm_id_entry = c4iw_fill_res_cm_id_entry,
> >         .fill_res_mr_entry = c4iw_fill_res_mr_entry,
> > +       .fill_res_qp_entry = c4iw_fill_res_qp_entry,
> >         .get_dev_fw_str = get_dev_fw_str,
> >         .get_dma_mr = c4iw_get_dma_mr,
> >         .get_hw_stats = c4iw_get_mib,
> > (END)
> > 
> > 
> > > 
> > > Thoughts?
> > > 
> > > Dave
> > > -- 
> > >  -----Open up your eyes, open up your mind, open up your code -------   
> > > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> > > \        dave @ treblig.org |                               | In Hex /
> > >  \ _________________________|_____ http://www.treblig.org   |_______/
> > > 
> > 
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/

