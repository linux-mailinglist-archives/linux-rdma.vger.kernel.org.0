Return-Path: <linux-rdma+bounces-7417-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E27B7A284DC
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 08:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76291887FF2
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 07:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7E221C16F;
	Wed,  5 Feb 2025 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITPCaTq0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09522139C9
	for <linux-rdma@vger.kernel.org>; Wed,  5 Feb 2025 07:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738739873; cv=none; b=hHFcSMkg/a56gV2FM1mWEjylFHYYh+hNg13hc8yNNyTNlJffgHwZxPQgxtVjaiKvc5XsnZdzIRHcz63EUxzAqAlVKH2SnO4HCoLVMtePknYL8iv5dex1K56T3DZqMaB3Ci/RJmHCB6WaFj0YsUDtFQwV/Z8K2u0INx2swIx3s9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738739873; c=relaxed/simple;
	bh=FX2Y15qyElX10ALRmpP6BQYoM/Agq3cJiwK49A2F5qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQgmlPxIsCVwHmRf8x6AfaLNNaqvPMVJfruKVrrS6pKtmIzGpNdOSn1CJe2TY/Rt7guPVBmx1Tm/PEniuXvdAuEHeIgshq9qFg0F6ASTkQPr7AzLohGwZwG2fwypu4bP/pJL8xriGqy17lTdEVajsDtOAthfdjfeg4LLV5ymTxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITPCaTq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30BEC4CEE3;
	Wed,  5 Feb 2025 07:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738739873;
	bh=FX2Y15qyElX10ALRmpP6BQYoM/Agq3cJiwK49A2F5qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ITPCaTq0Yx6/Yi2cOJ0G7FXP0WdwZJkmqpmyzDfU1jtR712rqk6SNJ1X/S42ArXAB
	 PaN4bm8CnvUfBJoSdysjF6J5cO9WC5RCoN8ruOy6ESuM2Piutqy95uvNUNas9k3k6s
	 VBjP0aALyEgQrZD1bXrk5qgN+RfY5hFKsUVf9ryVQPqEp/KX34jspnOeLFnLfkHTd/
	 ulAjY/C2LTRA4kJE1aOttBiX61Pv5jZ12GMSOqKRzrLoc3t8S+E/7ceOgnH0nwGYGL
	 ZwheuWJwDC3ddHb9fYHnRypVVKh1dkfWqy01/onXqSOHdtwxiN1jNtaw3h5DJ7dJft
	 uaZ8Buz7BjSeg==
Date: Wed, 5 Feb 2025 09:17:47 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
Subject: Re: [PATCH rdma-rc 2/4] RDMA/bnxt_re: Add sanity checks on rdev
 validity
Message-ID: <20250205071747.GM74886@unreal>
References: <1738657285-23968-1-git-send-email-selvin.xavier@broadcom.com>
 <1738657285-23968-3-git-send-email-selvin.xavier@broadcom.com>
 <20250204114400.GK74886@unreal>
 <CAH-L+nPzuSdKN=WQccTP2crfMp8hSLqq-uTXqw_Ck=sHtWbyEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH-L+nPzuSdKN=WQccTP2crfMp8hSLqq-uTXqw_Ck=sHtWbyEQ@mail.gmail.com>

On Tue, Feb 04, 2025 at 10:10:38PM +0530, Kalesh Anakkur Purayil wrote:
> Hi Leon,
> 
> On Tue, Feb 4, 2025 at 5:14 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, Feb 04, 2025 at 12:21:23AM -0800, Selvin Xavier wrote:
> > > From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > >
> > > There is a possibility that ulp_irq_stop and ulp_irq_start
> > > callbacks will be called when the device is in detached state.
> > > This can cause a crash due to NULL pointer dereference as
> > > the rdev is already freed.
> >
> > Description and code doesn't match. If "possibility" exists, there is
> > no protection from concurrent detach and ulp_irq_stop. If there is such
> > protection, they can't race.
> >
> > The main idea of auxiliary bus is to remove the need to implement driver
> > specific ops.
> 
> There is no race condition here.
> 
> Let me explain the scenario.
> 
> User is doing a devlink reload reinit. As part of that, the Ethernet
> driver first invokes the auxiliary bus suspend callback. The RDMA driver
> will do the unwinding operation and hence rdev will be freed.
> 
> After that, during the devlink sequence, Ethernet driver invokes the
> ulp_irq_stop() callback and this resulted in the NULL pointer
> dereference as the RDMA driver is in detached state and the rdev is
> already freed.

Shouldn't devlink reload completely release all auxiliary drivers?
Why are you keeping BNXT RDMA driver during reload?
BNXT core driver controls reload, it shouldn't call to drivers which
doesn't exist.

> 
> We are trying to address the NULL pointer dereference issue here.

You are hiding bugs and not fixing them.

> 
> The driver specific ops, ulp_irq_stop and ulp_irq_start are required.
> Broadcom Ethernet and RDMA drivers are designed like that to manage
> IRQs between them.
> 
> Hope this clarifies your question.
> >
> > >
> > > Fixes: cc5b9b48d447 ("RDMA/bnxt_re: Recover the device when FW error is detected")
> > > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > ---
> > >  drivers/infiniband/hw/bnxt_re/main.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> > > index c4c3d67..89ac5c2 100644
> > > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > > @@ -438,6 +438,8 @@ static void bnxt_re_stop_irq(void *handle, bool reset)
> > >       int indx;
> > >
> > >       rdev = en_info->rdev;
> > > +     if (!rdev)
> > > +             return;
> >
> > This can be seen as an example why I'm so negative about assigning NULL
> > to the pointers after object is destroyed. Such assignment makes layer
> > violation much easier job to do.
> >
> > Thanks
> >
> > >       rcfw = &rdev->rcfw;
> > >
> > >       if (reset) {
> > > @@ -466,6 +468,8 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
> > >       int indx, rc;
> > >
> > >       rdev = en_info->rdev;
> > > +     if (!rdev)
> > > +             return;
> > >       msix_ent = rdev->nqr->msix_entries;
> > >       rcfw = &rdev->rcfw;
> > >       if (!ent) {
> > > @@ -2438,6 +2442,7 @@ static int bnxt_re_suspend(struct auxiliary_device *adev, pm_message_t state)
> > >       ibdev_info(&rdev->ibdev, "%s: L2 driver notified to stop en_state 0x%lx",
> > >                  __func__, en_dev->en_state);
> > >       bnxt_re_remove_device(rdev, BNXT_RE_PRE_RECOVERY_REMOVE, adev);
> > > +     bnxt_re_update_en_info_rdev(NULL, en_info, adev);
> > >       mutex_unlock(&bnxt_re_mutex);
> > >
> > >       return 0;
> > > --
> > > 2.5.5
> > >
> 
> 
> 
> -- 
> Regards,
> Kalesh AP



