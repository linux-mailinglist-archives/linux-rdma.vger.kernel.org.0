Return-Path: <linux-rdma+bounces-5944-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FCD9C5588
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 12:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAEE5B23CB5
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 10:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1E2213142;
	Tue, 12 Nov 2024 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ha0TQiuX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C4E214406
	for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2024 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407676; cv=none; b=FVBhoJPje2b8PM9Gk2Lvdb4OSNbBJmVfqSqfBz4Yamldn/owHpomo4uDBNjc72sGucW+USEdEMqOSlH94NGvsX9mBtgXpKUx5vBjhLPTr6qB68jB81DMUrlFAXq1Fs1ur/2h/pTcLwD/MEZvL6ekkkzZp/Zg73R62juFpKGFzCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407676; c=relaxed/simple;
	bh=5lVLdqMk3VgIc+loDggCqz+av+37IoPPL4KzOPwYXDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liYfAiX2rfnR0GC1idlSz9+S8SMkZR3WY9btRl/fkYej5t6Pu9zCj/sOnEkMe5iDhhfzTNdYP+BzOXtebCH0DiMO/c/tY5UtmyYn+mlrICpR83Bw0CxmpEQzczrgortUYyqt1XRwplZxrsqOmkrkqPwbKBF5aD32I+/tpat4nTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ha0TQiuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFB6C4CEDA;
	Tue, 12 Nov 2024 10:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407676;
	bh=5lVLdqMk3VgIc+loDggCqz+av+37IoPPL4KzOPwYXDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ha0TQiuX7F9hC3egdlnZLW8AG6egITA2hm/4WCPpMm0zbthi+ySuSUp+9T7lYn0gT
	 ddu/Aj7I5tElokQORVx3hEKBBhAk73cramWTl77B7wADxlQP94Bm6J59ymgBy3kWTP
	 f9ShxCtguOFByHWrie9Ng34fR0NxbC99O3SaXW1elDweGxWmgvS9zJBsVycHjLu9+V
	 ch5T11aPWq9JAHY6QR0LtAmprUR/AwQFm9jtIrsoRT2mE5U/4r3j5GTC1x1iHdqZjp
	 mSxDAtMByKiGbWNe0gmkT9NXH01ZwGRNVXWbV+Foq/gVng7C+gj/1bO4+lWfEx7xMm
	 6zuWWl2oKI0jQ==
Date: Tue, 12 Nov 2024 12:34:29 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: Michael Chan <michael.chan@broadcom.com>, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [rdma-next 5/5] RDMA/bnxt_re: Add new function to setup NQs
Message-ID: <20241112103429.GK71181@unreal>
References: <1731055359-12603-1-git-send-email-selvin.xavier@broadcom.com>
 <1731055359-12603-6-git-send-email-selvin.xavier@broadcom.com>
 <20241112081746.GI71181@unreal>
 <CA+sbYW2BAUXLyk0Fa_hmXoQ1e7Ocmj-jw41JNBmjJQupimaD8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+sbYW2BAUXLyk0Fa_hmXoQ1e7Ocmj-jw41JNBmjJQupimaD8Q@mail.gmail.com>

On Tue, Nov 12, 2024 at 02:55:12PM +0530, Selvin Xavier wrote:
> +Michael Chan
> 
> On Tue, Nov 12, 2024 at 1:47 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Fri, Nov 08, 2024 at 12:42:39AM -0800, Selvin Xavier wrote:
> > > From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > >
> > > Move the logic to setup and enable NQs to a new function.
> > > Similarly moved the NQ cleanup logic to a common function.
> > > Introdued a flag to keep track of NQ allocation status
> > > and added sanity checks inside bnxt_re_stop_irq() and
> > > bnxt_re_start_irq() to avoid possible race conditions.
> > >
> > > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > ---
> > >  drivers/infiniband/hw/bnxt_re/bnxt_re.h |   2 +
> > >  drivers/infiniband/hw/bnxt_re/main.c    | 204 +++++++++++++++++++-------------
> > >  2 files changed, 123 insertions(+), 83 deletions(-)
> >
> > <...>
> >
> > >
> > > +     rtnl_lock();
> > > +     if (test_and_clear_bit(BNXT_RE_FLAG_SETUP_NQ, &rdev->flags))
> > > +             bnxt_re_clean_nqs(rdev);
> > > +     rtnl_unlock();
> >
> > <...>
> >
> > > +             rtnl_lock();
> > >               bnxt_qplib_free_ctx(&rdev->qplib_res, &rdev->qplib_ctx);
> > >               bnxt_qplib_disable_rcfw_channel(&rdev->rcfw);
> > >               type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
> > >               bnxt_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id, type);
> > > +             rtnl_unlock();
> >
> > Please don't add rtnl_lock() to drivers in RDMA subsystem. BNXT driver
> > is managed through netdev and it is there all proper locking should be
> > done.
> The main reason for bnxt_re to take the rtnl is because of the MSIx
> resource configuration.
> This is because the NIC driver is dynamically modifying the MSIx table
> when the number
> of ring change  or ndo->open/close is invoked. So we stop and restart
> the interrupts of RoCE also with rtnl held.

rtnl_lock is a big kernel lock, which blocks almost everything in the netdev.
In your case, you are changing one device configuration and should use
your per-device locks. Even in the system with more than one BNXT device,
the MSI-X on one device will influence other "innocent" devices.

> >
> > Please work to remove existing rtnl_lock() from bnxt_re_update_en_info_rdev() too.
> > IMHO that lock is not needed after your driver conversion to auxbus.
> This check is also to synchronize between the irq_stop and restart
> implementation between
> bnxt_en and bnxt_re driver and roce driver unload.
> 
>  We will review this locking and see if we can handle it. But it is a
> major design change in both L2
> and roce drivers.

You are adding new rtnl_lock and not moving it from one place to
another, so this redesign should be done together with this new
feature.

Thanks

> >
> > Thanks



