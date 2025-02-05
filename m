Return-Path: <linux-rdma+bounces-7422-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89502A286FE
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 10:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1679E164008
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 09:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B4D22A7FC;
	Wed,  5 Feb 2025 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHugkrdy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7922A805
	for <linux-rdma@vger.kernel.org>; Wed,  5 Feb 2025 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738749140; cv=none; b=PV/L2VVG1l2kBy1YFNv/1mQh0qn88XHMUmglTp+pXx/NFsVwXLYC5SSxurKG5eUeKt1mKEehu0sEqwBxXrAyKPnfIM50hRbshmSHs6MrBNEebBpmDLZTgh1kt3x8DfFYAi8PxssonE2iaG1dXxmWpWptsiIqLuMwxh0OpqjhGyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738749140; c=relaxed/simple;
	bh=faYw2DvGRI2P/COBPhzZrow0gkvrNiRHvpOmOOv2mzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXhndLopwHYXgFGayuOoHHQUCRJx2qcP4f+ffzAJZ4Y9GYW7eOEaJ/WUBXYPvPb8CN6jTBbMotuA+XtH6AC3lEMcErJ+vrwPcn1LQrDe6t0e2/OMJlPL5NikdvBOJ/8AJTxXJepMsvAAiH9syv9vMYa1VkJkrnz+h3nG6TjTOLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHugkrdy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39D8C4CED1;
	Wed,  5 Feb 2025 09:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738749139;
	bh=faYw2DvGRI2P/COBPhzZrow0gkvrNiRHvpOmOOv2mzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NHugkrdy0NAzURJNvJA5MA8bcvDp0yCX4JxnnIHPIONqgpPrTQssSmKYXjArPXUeC
	 pi+nxzUlx6D2DgJQwqGQbvlMNaS6WPhWALQ2W2F3QcFjfHEf2LVGayRnKKEayhRwCj
	 wdhn2zm+/dqKZLHXdIaO5PgFJlcDET5j4OaqzjBRHVhkLvCDkR50lq9nLIxdyB0uIc
	 DGJWjY0OvDvRo0ZEcod7NL1R9hmZ4qjv5Qbgq1BNjnsz04LsXQnm8MdWPJhAyvRtF1
	 ND8aMdbvwLW1bAC1uT5NOAhiADYhvuwNsUt1YqmoLxz/Ufx92gqOZlRxxHfA/zl1mv
	 rrim8ZpBVWP5g==
Date: Wed, 5 Feb 2025 11:52:15 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
Subject: Re: [PATCH rdma-rc 2/4] RDMA/bnxt_re: Add sanity checks on rdev
 validity
Message-ID: <20250205095215.GN74886@unreal>
References: <1738657285-23968-1-git-send-email-selvin.xavier@broadcom.com>
 <1738657285-23968-3-git-send-email-selvin.xavier@broadcom.com>
 <20250204114400.GK74886@unreal>
 <CAH-L+nPzuSdKN=WQccTP2crfMp8hSLqq-uTXqw_Ck=sHtWbyEQ@mail.gmail.com>
 <20250205071747.GM74886@unreal>
 <CAH-L+nM6+-v6dvgzA6UDhgbhjysr55BJ859N5aWWXNEm4k+EDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH-L+nM6+-v6dvgzA6UDhgbhjysr55BJ859N5aWWXNEm4k+EDw@mail.gmail.com>

On Wed, Feb 05, 2025 at 01:54:14PM +0530, Kalesh Anakkur Purayil wrote:
> Hi Leon,
> 
> On Wed, Feb 5, 2025 at 12:47 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, Feb 04, 2025 at 10:10:38PM +0530, Kalesh Anakkur Purayil wrote:
> > > Hi Leon,
> > >
> > > On Tue, Feb 4, 2025 at 5:14 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Tue, Feb 04, 2025 at 12:21:23AM -0800, Selvin Xavier wrote:
> > > > > From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > > > >
> > > > > There is a possibility that ulp_irq_stop and ulp_irq_start
> > > > > callbacks will be called when the device is in detached state.
> > > > > This can cause a crash due to NULL pointer dereference as
> > > > > the rdev is already freed.
> > > >
> > > > Description and code doesn't match. If "possibility" exists, there is
> > > > no protection from concurrent detach and ulp_irq_stop. If there is such
> > > > protection, they can't race.
> > > >
> > > > The main idea of auxiliary bus is to remove the need to implement driver
> > > > specific ops.
> > >
> > > There is no race condition here.
> > >
> > > Let me explain the scenario.
> > >
> > > User is doing a devlink reload reinit. As part of that, the Ethernet
> > > driver first invokes the auxiliary bus suspend callback. The RDMA driver
> > > will do the unwinding operation and hence rdev will be freed.
> > >
> > > After that, during the devlink sequence, Ethernet driver invokes the
> > > ulp_irq_stop() callback and this resulted in the NULL pointer
> > > dereference as the RDMA driver is in detached state and the rdev is
> > > already freed.
> >
> > Shouldn't devlink reload completely release all auxiliary drivers?
> > Why are you keeping BNXT RDMA driver during reload?
> 
> That is the current design. BNXT core Ethernet driver will not destroy
> the auxiliary device for RDMA, but just calls the suspend callback. As
> a result, RDMA driver will remains loaded and remains registered with
> the Ethernet driver instance.

This is wrong.

> > BNXT core driver controls reload, it shouldn't call to drivers which
> > doesn't exist.
> Since the RDMA driver instance is registered with Ethernet driver,
> core Ethernet driver invokes the callback.
> >
> > >
> > > We are trying to address the NULL pointer dereference issue here.
> >
> > You are hiding bugs and not fixing them.
> 
> Yes, but this change is critical for the current design of the driver.

Please fix it once and for all by doing proper reload sequence.
I warned you that setting NULLs to pointers hide bugs.
https://lore.kernel.org/linux-rdma/20250114112555.GG3146852@unreal/

Thanks

> >
> > >
> > > The driver specific ops, ulp_irq_stop and ulp_irq_start are required.
> > > Broadcom Ethernet and RDMA drivers are designed like that to manage
> > > IRQs between them.
> > >
> > > Hope this clarifies your question.
> > > >
> > > > >
> > > > > Fixes: cc5b9b48d447 ("RDMA/bnxt_re: Recover the device when FW error is detected")
> > > > > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > > > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > > > ---
> > > > >  drivers/infiniband/hw/bnxt_re/main.c | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > >
> > > > > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> > > > > index c4c3d67..89ac5c2 100644
> > > > > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > > > > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > > > > @@ -438,6 +438,8 @@ static void bnxt_re_stop_irq(void *handle, bool reset)
> > > > >       int indx;
> > > > >
> > > > >       rdev = en_info->rdev;
> > > > > +     if (!rdev)
> > > > > +             return;
> > > >
> > > > This can be seen as an example why I'm so negative about assigning NULL
> > > > to the pointers after object is destroyed. Such assignment makes layer
> > > > violation much easier job to do.
> > > >
> > > > Thanks
> > > >
> > > > >       rcfw = &rdev->rcfw;
> > > > >
> > > > >       if (reset) {
> > > > > @@ -466,6 +468,8 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
> > > > >       int indx, rc;
> > > > >
> > > > >       rdev = en_info->rdev;
> > > > > +     if (!rdev)
> > > > > +             return;
> > > > >       msix_ent = rdev->nqr->msix_entries;
> > > > >       rcfw = &rdev->rcfw;
> > > > >       if (!ent) {
> > > > > @@ -2438,6 +2442,7 @@ static int bnxt_re_suspend(struct auxiliary_device *adev, pm_message_t state)
> > > > >       ibdev_info(&rdev->ibdev, "%s: L2 driver notified to stop en_state 0x%lx",
> > > > >                  __func__, en_dev->en_state);
> > > > >       bnxt_re_remove_device(rdev, BNXT_RE_PRE_RECOVERY_REMOVE, adev);
> > > > > +     bnxt_re_update_en_info_rdev(NULL, en_info, adev);
> > > > >       mutex_unlock(&bnxt_re_mutex);
> > > > >
> > > > >       return 0;
> > > > > --
> > > > > 2.5.5
> > > > >
> > >
> > >
> > >
> > > --
> > > Regards,
> > > Kalesh AP
> >
> >
> 
> 
> -- 
> Regards,
> Kalesh AP



