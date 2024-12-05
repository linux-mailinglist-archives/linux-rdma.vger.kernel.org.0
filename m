Return-Path: <linux-rdma+bounces-6272-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ADD9E541A
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 12:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D99E1881852
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 11:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15176207641;
	Thu,  5 Dec 2024 11:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tY+Y8coP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6204206F28
	for <linux-rdma@vger.kernel.org>; Thu,  5 Dec 2024 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398726; cv=none; b=lMsEJrtp7XCWKf++4Bb5xDHZJjJiPZsf1NhnxHH362Hs4jZOy9AswyokVRZa8I3+rvPAI8is9ydf2wudx3eLqInDavzBOeW5X6TVpsVoocKKri8p17X4UDORw10OsssBA3/gPbBANUgncdTUNhR2AI9OOV9CaG0NgWwj8ThU6d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398726; c=relaxed/simple;
	bh=gGtX5l4S4qocfUaVYdM2l3KFWehm923wYl4XbZBRTN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxGqI2ZffNiy6BlLwQp9HaOD2pPbaulN9zf98w6XNW4QH5Dsx4v0Haghxa6Ad2S0WuoBrmo69fe+Io5IbYAM7+ICNs+2582OvPEX78O0p5tbgK/3hUwN0tSrJjU6rvtZuk+8cYWslIU1nxzSuBsjRCxJ32eKu8uVDoLCSEx+zik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tY+Y8coP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0766C4CED1;
	Thu,  5 Dec 2024 11:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733398726;
	bh=gGtX5l4S4qocfUaVYdM2l3KFWehm923wYl4XbZBRTN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tY+Y8coPo8NA/brF3jsTRqTQrj1r6dbpK1/BlVXBA6yJWKGzYXa7Dvi+AeEQb9Civ
	 pQd/QN1sg5PgXPLDLBRkuN8QSU8T49TqbY/NRb/kAt+NrR9FbOGCXT5fV6idTwHmuO
	 JUFEZ4HPAMJzhQaDN2FFuZB0U8XS2ZREoNg+v4/STCufT24cgbOuDgJdjm2GTJcjrl
	 BI7cz//kfUEPCAE64/Aa5UPFrx198WXO4RnO7b8b5yiy+Aiw0+RqPVxSdEhdzS7Kzr
	 TYX66mSp2qugbd0uuU5iDLzkOh7hikmHficIS96FAFOg4tYxAogVeo9gVwtxj81CSd
	 HdyQyPA5aY2wA==
Date: Thu, 5 Dec 2024 13:38:41 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	Kashyap Desai <kashyap.desai@broadcom.com>
Subject: Re: [PATCH for-rc 4/5] RDMA/bnxt_re: Fix error recovery sequence
Message-ID: <20241205113841.GY1245331@unreal>
References: <20241204075416.478431-1-kalesh-anakkur.purayil@broadcom.com>
 <20241204075416.478431-5-kalesh-anakkur.purayil@broadcom.com>
 <20241205090716.GU1245331@unreal>
 <CAH-L+nN0C=0ZoJmAgBTbjCUcwoQO00WoUc3d3BKn_tGPdk5UbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH-L+nN0C=0ZoJmAgBTbjCUcwoQO00WoUc3d3BKn_tGPdk5UbA@mail.gmail.com>

On Thu, Dec 05, 2024 at 03:01:25PM +0530, Kalesh Anakkur Purayil wrote:
> On Thu, Dec 5, 2024 at 2:37 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Wed, Dec 04, 2024 at 01:24:15PM +0530, Kalesh AP wrote:
> > > Fixed to return ENXIO from __send_message_basic_sanity()
> > > to indicate that device is in error state. In the case of
> > > ERR_DEVICE_DETACHED state, the driver should not post the
> > > commands to the firmware as it will time out eventually.
> > >
> > > Removed bnxt_re_modify_qp() call from bnxt_re_dev_stop()
> > > as it is a no-op.
> > >
> > > Fixes: cc5b9b48d447 ("RDMA/bnxt_re: Recover the device when FW error is detected")
> > >
> >
> > Please don't add blank line here.
> Sure, my bad. I missed it. Thanks for pointing it out.
> >
> > > Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
> > > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > ---
> > >  drivers/infiniband/hw/bnxt_re/main.c       | 8 +-------
> > >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 7 ++++---
> > >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h | 3 +++
> > >  3 files changed, 8 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> > > index b7af0d5ff3b6..c143f273b759 100644
> > > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > > @@ -1715,11 +1715,8 @@ static bool bnxt_re_is_qp1_or_shadow_qp(struct bnxt_re_dev *rdev,
> > >
> > >  static void bnxt_re_dev_stop(struct bnxt_re_dev *rdev)
> > >  {
> > > -     int mask = IB_QP_STATE;
> > > -     struct ib_qp_attr qp_attr;
> > >       struct bnxt_re_qp *qp;
> > >
> > > -     qp_attr.qp_state = IB_QPS_ERR;
> > >       mutex_lock(&rdev->qp_lock);
> > >       list_for_each_entry(qp, &rdev->qp_list, list) {
> > >               /* Modify the state of all QPs except QP1/Shadow QP */
> > > @@ -1727,12 +1724,9 @@ static void bnxt_re_dev_stop(struct bnxt_re_dev *rdev)
> > >                       if (qp->qplib_qp.state !=
> > >                           CMDQ_MODIFY_QP_NEW_STATE_RESET &&
> > >                           qp->qplib_qp.state !=
> > > -                         CMDQ_MODIFY_QP_NEW_STATE_ERR) {
> > > +                         CMDQ_MODIFY_QP_NEW_STATE_ERR)
> > >                               bnxt_re_dispatch_event(&rdev->ibdev, &qp->ib_qp,
> > >                                                      1, IB_EVENT_QP_FATAL);
> > > -                             bnxt_re_modify_qp(&qp->ib_qp, &qp_attr, mask,
> > > -                                               NULL);
> > > -                     }
> > >               }
> > >       }
> > >       mutex_unlock(&rdev->qp_lock);
> > > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > > index 5e90ea232de8..c8e65169f58a 100644
> > > --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > > +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > > @@ -423,8 +423,9 @@ static int __send_message_basic_sanity(struct bnxt_qplib_rcfw *rcfw,
> > >       cmdq = &rcfw->cmdq;
> > >
> > >       /* Prevent posting if f/w is not in a state to process */
> > > -     if (test_bit(ERR_DEVICE_DETACHED, &rcfw->cmdq.flags))
> > > -             return bnxt_qplib_map_rc(opcode);
> > > +     if (RCFW_NO_FW_ACCESS(rcfw))
> > > +             return -ENXIO;
> > > +
> > >       if (test_bit(FIRMWARE_STALL_DETECTED, &cmdq->flags))
> > >               return -ETIMEDOUT;
> > >
> > > @@ -493,7 +494,7 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
> > >
> > >       rc = __send_message_basic_sanity(rcfw, msg, opcode);
> > >       if (rc)
> > > -             return rc;
> > > +             return rc == -ENXIO ? bnxt_qplib_map_rc(opcode) : rc;
> > >
> > >       rc = __send_message(rcfw, msg, opcode);
> > >       if (rc)
> > > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > > index 88814cb3aa74..4f7d800e35c3 100644
> > > --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > > +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > > @@ -129,6 +129,9 @@ static inline u32 bnxt_qplib_set_cmd_slots(struct cmdq_base *req)
> > >
> > >  #define RCFW_MAX_COOKIE_VALUE                (BNXT_QPLIB_CMDQE_MAX_CNT - 1)
> > >  #define RCFW_CMD_IS_BLOCKING         0x8000
> > > +#define RCFW_NO_FW_ACCESS(rcfw)                                              \
> > > +     (test_bit(ERR_DEVICE_DETACHED, &(rcfw)->cmdq.flags) ||          \
> > > +      pci_channel_offline((rcfw)->pdev))
> >
> > There is some disconnection between description and implementation.
> > ERR_DEVICE_DETACHED is set when device is suspended, at this stage all
> > FW commands should stop already and if they are not, bnxt_re has bugs
> > in cleanup path. It should flush/cancel/e.t.c and not randomly test some
> > bit.
> Yes, the device is in reset state. All outstanding firmware commands
> are suspended. We do not want to post any new commands to firmware in
> the recovery teardown path. Any commands sent to firmware at this
> point will time out.
> To avoid that, before posting the command driver checks the state and
> returns early.

I understand that. Please reread my sentence "all FW commands should stop
already and if they are not, bnxt_re has bugs in cleanup path.", and answer
is how is it possible to get FW commands during restore.

> >
> > In addition, pci_channel_offline() in driver which doesn't manage PCI
> > device looks strange to me. It should be part of bnxt core and not
> > related to IB.
> The bnxt_re driver also has a firmware communication channel where it
> writes to BAR to issue firmware commands. When the PCI channel is
> offline, any commands issued from the driver will time out eventually.
> To prevent that we added this extra check to detect that condition early.

This micro optimization where you check in some random place for pci channel
status is not correct.

Thanks

> 
> >
> > Thanks
> >
> > >
> > >  #define HWRM_VERSION_DEV_ATTR_MAX_DPI  0x1000A0000000DULL
> > >  /* HWRM version 1.10.3.18 */
> > > --
> > > 2.31.1
> > >
> 
> 
> 
> -- 
> Regards,
> Kalesh A P



