Return-Path: <linux-rdma+bounces-6383-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5CB9EB029
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 12:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68A1188678F
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 11:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA6519340D;
	Tue, 10 Dec 2024 11:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYSqq9J5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6163A8F7
	for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2024 11:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733831326; cv=none; b=oeOysbszjnQ/cpBYBIRrBYkgQlb8t7dOVDu6wO8cLdzpa9vVU3+Ye3aY3031Iu35ZwJnoOoTYgp27q9e48E/PX1UnCb+mCnnmuxiBcm9npAXDY3i6qfbEcKOBYfsf2uSfx1qOaI65bqG8Z3Zeh3W5GKQGJzl5en+1FsGHqQby/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733831326; c=relaxed/simple;
	bh=BsUA45SVfKryulrQ+oOKUDu5el34CUyL8fh/8G+kTLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2ndQWZT+olXJR5zeGBbC4odkKO6QFm9S4dtrSv+9CmTus8rt9JzUaOSWGr0F5KlAYs8Op47aQ05aJZ3LeJ+8jJu7YHs5b3ZShU1FL7CCrKweuqRYHTop63gMTHJ4v3SYpSHUYaBN+ho4lAlSLM4Bc2m1+PqtHdzXlERp2ihLTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYSqq9J5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5F7C4CED6;
	Tue, 10 Dec 2024 11:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733831326;
	bh=BsUA45SVfKryulrQ+oOKUDu5el34CUyL8fh/8G+kTLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CYSqq9J5lsMBTa4q9ZJxoUTbpwcAarwGlTg9+nv2nCzjwEBOz+VEsaijz0rdlexHt
	 jRPBQHpGNaygrtpLX8kcEI3TBp+OiUfiWrtupCLAmPOzGm4AlFVBSkxicBdL3sz2Tl
	 ypSu6QUl4JkCThSwfdSoTP6C4Zc7d+hdAAwLy+JRZe82whOUpfOntyNzO/b4gaU+Lw
	 kUHIfgcbwnGkH7WyBLs/EsJOA6TzYWrLyU14S+j+DY1ftRTKa9tK0iTB5q5HCxmiMX
	 X54LAsxbcSELKF26e2mNKUw4LQuQgBBIoKdQjSYWdXzmkqSLvMjntvBQTc82l3d4jQ
	 EhLEDJyScj+DQ==
Date: Tue, 10 Dec 2024 13:48:41 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>,
	jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Kashyap Desai <kashyap.desai@broadcom.com>
Subject: Re: [PATCH for-rc 4/5] RDMA/bnxt_re: Fix error recovery sequence
Message-ID: <20241210114841.GE1245331@unreal>
References: <20241204075416.478431-1-kalesh-anakkur.purayil@broadcom.com>
 <20241204075416.478431-5-kalesh-anakkur.purayil@broadcom.com>
 <20241205090716.GU1245331@unreal>
 <CAH-L+nN0C=0ZoJmAgBTbjCUcwoQO00WoUc3d3BKn_tGPdk5UbA@mail.gmail.com>
 <20241205113841.GY1245331@unreal>
 <CA+sbYW21nc0JPs-N0rmR-DgUvX0pydCY_bZXUC57aA0rXUst1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+sbYW21nc0JPs-N0rmR-DgUvX0pydCY_bZXUC57aA0rXUst1A@mail.gmail.com>

On Mon, Dec 09, 2024 at 10:13:23AM +0530, Selvin Xavier wrote:
> On Thu, Dec 5, 2024 at 5:08 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Thu, Dec 05, 2024 at 03:01:25PM +0530, Kalesh Anakkur Purayil wrote:
> > > On Thu, Dec 5, 2024 at 2:37 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Wed, Dec 04, 2024 at 01:24:15PM +0530, Kalesh AP wrote:
> > > > > Fixed to return ENXIO from __send_message_basic_sanity()
> > > > > to indicate that device is in error state. In the case of
> > > > > ERR_DEVICE_DETACHED state, the driver should not post the
> > > > > commands to the firmware as it will time out eventually.
> > > > >
> > > > > Removed bnxt_re_modify_qp() call from bnxt_re_dev_stop()
> > > > > as it is a no-op.
> > > > >
> > > > > Fixes: cc5b9b48d447 ("RDMA/bnxt_re: Recover the device when FW error is detected")
> > > > >
> > > >
> > > > Please don't add blank line here.
> > > Sure, my bad. I missed it. Thanks for pointing it out.
> > > >
> > > > > Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
> > > > > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > > > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > > > ---
> > > > >  drivers/infiniband/hw/bnxt_re/main.c       | 8 +-------
> > > > >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 7 ++++---
> > > > >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h | 3 +++
> > > > >  3 files changed, 8 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> > > > > index b7af0d5ff3b6..c143f273b759 100644
> > > > > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > > > > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > > > > @@ -1715,11 +1715,8 @@ static bool bnxt_re_is_qp1_or_shadow_qp(struct bnxt_re_dev *rdev,
> > > > >
> > > > >  static void bnxt_re_dev_stop(struct bnxt_re_dev *rdev)
> > > > >  {
> > > > > -     int mask = IB_QP_STATE;
> > > > > -     struct ib_qp_attr qp_attr;
> > > > >       struct bnxt_re_qp *qp;
> > > > >
> > > > > -     qp_attr.qp_state = IB_QPS_ERR;
> > > > >       mutex_lock(&rdev->qp_lock);
> > > > >       list_for_each_entry(qp, &rdev->qp_list, list) {
> > > > >               /* Modify the state of all QPs except QP1/Shadow QP */
> > > > > @@ -1727,12 +1724,9 @@ static void bnxt_re_dev_stop(struct bnxt_re_dev *rdev)
> > > > >                       if (qp->qplib_qp.state !=
> > > > >                           CMDQ_MODIFY_QP_NEW_STATE_RESET &&
> > > > >                           qp->qplib_qp.state !=
> > > > > -                         CMDQ_MODIFY_QP_NEW_STATE_ERR) {
> > > > > +                         CMDQ_MODIFY_QP_NEW_STATE_ERR)
> > > > >                               bnxt_re_dispatch_event(&rdev->ibdev, &qp->ib_qp,
> > > > >                                                      1, IB_EVENT_QP_FATAL);
> > > > > -                             bnxt_re_modify_qp(&qp->ib_qp, &qp_attr, mask,
> > > > > -                                               NULL);
> > > > > -                     }
> > > > >               }
> > > > >       }
> > > > >       mutex_unlock(&rdev->qp_lock);
> > > > > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > > > > index 5e90ea232de8..c8e65169f58a 100644
> > > > > --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > > > > +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > > > > @@ -423,8 +423,9 @@ static int __send_message_basic_sanity(struct bnxt_qplib_rcfw *rcfw,
> > > > >       cmdq = &rcfw->cmdq;
> > > > >
> > > > >       /* Prevent posting if f/w is not in a state to process */
> > > > > -     if (test_bit(ERR_DEVICE_DETACHED, &rcfw->cmdq.flags))
> > > > > -             return bnxt_qplib_map_rc(opcode);
> > > > > +     if (RCFW_NO_FW_ACCESS(rcfw))
> > > > > +             return -ENXIO;
> > > > > +
> > > > >       if (test_bit(FIRMWARE_STALL_DETECTED, &cmdq->flags))
> > > > >               return -ETIMEDOUT;
> > > > >
> > > > > @@ -493,7 +494,7 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
> > > > >
> > > > >       rc = __send_message_basic_sanity(rcfw, msg, opcode);
> > > > >       if (rc)
> > > > > -             return rc;
> > > > > +             return rc == -ENXIO ? bnxt_qplib_map_rc(opcode) : rc;
> > > > >
> > > > >       rc = __send_message(rcfw, msg, opcode);
> > > > >       if (rc)
> > > > > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > > > > index 88814cb3aa74..4f7d800e35c3 100644
> > > > > --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > > > > +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > > > > @@ -129,6 +129,9 @@ static inline u32 bnxt_qplib_set_cmd_slots(struct cmdq_base *req)
> > > > >
> > > > >  #define RCFW_MAX_COOKIE_VALUE                (BNXT_QPLIB_CMDQE_MAX_CNT - 1)
> > > > >  #define RCFW_CMD_IS_BLOCKING         0x8000
> > > > > +#define RCFW_NO_FW_ACCESS(rcfw)                                              \
> > > > > +     (test_bit(ERR_DEVICE_DETACHED, &(rcfw)->cmdq.flags) ||          \
> > > > > +      pci_channel_offline((rcfw)->pdev))
> > > >
> > > > There is some disconnection between description and implementation.
> > > > ERR_DEVICE_DETACHED is set when device is suspended, at this stage all
> > > > FW commands should stop already and if they are not, bnxt_re has bugs
> > > > in cleanup path. It should flush/cancel/e.t.c and not randomly test some
> > > > bit.
> > > Yes, the device is in reset state. All outstanding firmware commands
> > > are suspended. We do not want to post any new commands to firmware in
> > > the recovery teardown path. Any commands sent to firmware at this
> > > point will time out.
> > > To avoid that, before posting the command driver checks the state and
> > > returns early.
> >
> > I understand that. Please reread my sentence "all FW commands should stop
> > already and if they are not, bnxt_re has bugs in cleanup path.", and answer
> > is how is it possible to get FW commands during restore.
> Hi Leon,
> 
> Not sure if I also got your point correctly. Once the error recovery
> gets initiated, we
> unregister the ib device in the suspend path. During the ib_unregister_device,
> we get verb commands to destroy the QP, CQs etc. We want to prevent sending the
> new commands to FW for all these operations. We also want to avoid sending
> any resource creation commands from the stack while the device is
> getting re-initialized

The thing is that during ib_unregister_device nothing external to driver
is going to be sent to FW.

> This is a common check that prevents more commands from the stack down
> to Firmware.
> 
> >
> > > >
> > > > In addition, pci_channel_offline() in driver which doesn't manage PCI
> > > > device looks strange to me. It should be part of bnxt core and not
> > > > related to IB.
> > > The bnxt_re driver also has a firmware communication channel where it
> > > writes to BAR to issue firmware commands. When the PCI channel is
> > > offline, any commands issued from the driver will time out eventually.
> > > To prevent that we added this extra check to detect that condition early.
> >
> > This micro optimization where you check in some random place for pci channel
> > status is not correct.
> Will remove pci_channel_offline check and come up with some other
> mechanism to handle this case.
> >
> > Thanks
> >
> > >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > >  #define HWRM_VERSION_DEV_ATTR_MAX_DPI  0x1000A0000000DULL
> > > > >  /* HWRM version 1.10.3.18 */
> > > > > --
> > > > > 2.31.1
> > > > >
> > >
> > >
> > >
> > > --
> > > Regards,
> > > Kalesh A P
> >
> >



