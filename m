Return-Path: <linux-rdma+bounces-6711-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 834BC9FB317
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Dec 2024 17:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884DF18835C0
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Dec 2024 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CDE1B3931;
	Mon, 23 Dec 2024 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6+qaUqA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E7D1B0F27
	for <linux-rdma@vger.kernel.org>; Mon, 23 Dec 2024 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734972141; cv=none; b=HC9Lrb3qXdb5HOOX0XFgeFRLoHlxAcJuuYiDc32MQay8MOn82VCcnY8CE+JCoNkp1jaTdLBrGa86wzguZPHOkBWCSyENGpqxiHLzRazrtg9nmgenUVTFD7nF90ZHl4WRoQhPqk2LZ82oTcxCQBGZ591CEN+hrzrIXjjEEirdEQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734972141; c=relaxed/simple;
	bh=u/edG+f7fciSpLlmXn9IJoDrVQcOsCsT4S9jjTn0Vhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNDxdhAsC6YdgDydRbpJpqyycSJfk+MZXHRBLyrK8h1+6qoYQHnWLETiULCvW9RQqRzJljeD+ZMLvz5aS+JPvX03kPQxvBX650DZvrx/ATJ4Au26A0ms3ftkG3JLrEpPEd35Rhn6lNi0A6lfphcJcuRasSBPKShifzE0Au/8TzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6+qaUqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C0BC4CED3;
	Mon, 23 Dec 2024 16:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734972139;
	bh=u/edG+f7fciSpLlmXn9IJoDrVQcOsCsT4S9jjTn0Vhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p6+qaUqAnDfnHQfgzXdwxEvLsLDQgbjk5gr3JCr9F44W4uibpz6vdmrajZhaM7wW0
	 g8qiRCpBuo5bt4dFVKjJiWjRsh7rke+C938AmELjDI6jVh0XYlREvfl8xvGwohy7UM
	 pPpKMejiU/JS+VMhrGFXKovuei5gJHBp7sqpKIwS9XEkLLlwE7A+KurOF+8Q6XJVc3
	 zykQLE9KIj1aXzk/AaZLsu0mShGuNuSeakg3a4lMYoUCCwaez9k2MIhdU7mQ8dc17d
	 BaRMqqY63zL05IdhoES6I+D/6+KsrG6mHBnc3/ti8h0o+us8f5rUuCKtVlbvdyvzZK
	 vMiaHApEK0Nqw==
Date: Mon, 23 Dec 2024 18:42:15 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	Kashyap Desai <kashyap.desai@broadcom.com>
Subject: Re: [PATCH for-rc v2] RDMA/bnxt_re: Fix error recovery sequence
Message-ID: <20241223164215.GB171473@unreal>
References: <20241220075920.1566165-1-kalesh-anakkur.purayil@broadcom.com>
 <20241223150033.GA171473@unreal>
 <CAH-L+nPAkBggkMx1VVwLs4xSRZZLuidoHT77doKJSw1KWSPT8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH-L+nPAkBggkMx1VVwLs4xSRZZLuidoHT77doKJSw1KWSPT8A@mail.gmail.com>

On Mon, Dec 23, 2024 at 09:12:53PM +0530, Kalesh Anakkur Purayil wrote:
> Regards,
> Kalesh AP
> 
> 
> On Mon, 23 Dec 2024 at 8:30 PM, Leon Romanovsky <leon@kernel.org> wrote:
> 
> > On Fri, Dec 20, 2024 at 01:29:20PM +0530, Kalesh AP wrote:
> > > Fixed to return ENXIO from __send_message_basic_sanity()
> > > to indicate that device is in error state. In the case of
> > > ERR_DEVICE_DETACHED state, the driver should not post the
> > > commands to the firmware as it will time out eventually.
> > >
> > > Removed bnxt_re_modify_qp() call from bnxt_re_dev_stop()
> > > as it is a no-op.
> > >
> > > Fixes: cc5b9b48d447 ("RDMA/bnxt_re: Recover the device when FW error is
> > detected")
> > > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > > Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> > > Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > ---
> > > V2: No changes since v1 and is just a resend.
> > > V1:
> > https://patchwork.kernel.org/project/linux-rdma/patch/20241204075416.478431-5-kalesh-anakkur.purayil@broadcom.com/
> > > ---
> > >  drivers/infiniband/hw/bnxt_re/main.c       | 8 +-------
> > >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 7 ++++---
> > >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h | 3 +++
> > >  3 files changed, 8 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/hw/bnxt_re/main.c
> > b/drivers/infiniband/hw/bnxt_re/main.c
> > > index b7af0d5ff3b6..c143f273b759 100644
> > > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > > @@ -1715,11 +1715,8 @@ static bool bnxt_re_is_qp1_or_shadow_qp(struct
> > bnxt_re_dev *rdev,
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
> > > @@ -1727,12 +1724,9 @@ static void bnxt_re_dev_stop(struct bnxt_re_dev
> > *rdev)
> > >                       if (qp->qplib_qp.state !=
> > >                           CMDQ_MODIFY_QP_NEW_STATE_RESET &&
> > >                           qp->qplib_qp.state !=
> > > -                         CMDQ_MODIFY_QP_NEW_STATE_ERR) {
> > > +                         CMDQ_MODIFY_QP_NEW_STATE_ERR)
> > >                               bnxt_re_dispatch_event(&rdev->ibdev,
> > &qp->ib_qp,
> > >                                                      1,
> > IB_EVENT_QP_FATAL);
> > > -                             bnxt_re_modify_qp(&qp->ib_qp, &qp_attr,
> > mask,
> > > -                                               NULL);
> > > -                     }
> > >               }
> > >       }
> > >       mutex_unlock(&rdev->qp_lock);
> > > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > > index 5e90ea232de8..c8e65169f58a 100644
> > > --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > > +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > > @@ -423,8 +423,9 @@ static int __send_message_basic_sanity(struct
> > bnxt_qplib_rcfw *rcfw,
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
> > > @@ -493,7 +494,7 @@ static int __bnxt_qplib_rcfw_send_message(struct
> > bnxt_qplib_rcfw *rcfw,
> > >
> > >       rc = __send_message_basic_sanity(rcfw, msg, opcode);
> > >       if (rc)
> > > -             return rc;
> > > +             return rc == -ENXIO ? bnxt_qplib_map_rc(opcode) : rc;
> > >
> > >       rc = __send_message(rcfw, msg, opcode);
> > >       if (rc)
> > > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > > index 88814cb3aa74..4f7d800e35c3 100644
> > > --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > > +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > > @@ -129,6 +129,9 @@ static inline u32 bnxt_qplib_set_cmd_slots(struct
> > cmdq_base *req)
> > >
> > >  #define RCFW_MAX_COOKIE_VALUE                (BNXT_QPLIB_CMDQE_MAX_CNT
> > - 1)
> > >  #define RCFW_CMD_IS_BLOCKING         0x8000
> > > +#define RCFW_NO_FW_ACCESS(rcfw)
> >       \
> > > +     (test_bit(ERR_DEVICE_DETACHED, &(rcfw)->cmdq.flags) ||          \
> > > +      pci_channel_offline((rcfw)->pdev))
> >
> > You promised me that this patch handles races, so how is this
> > pci_channel_offline() check protected?
> >
> > Thansk
> 
> Hi Leon,
> 
> Sorry, I may be missing something here.
> Could you help me understand what is the race condition here? I can then
> internally discuss with the team based on your input.

pci_channel_offline() is placed completely randomly here. There is no
guarantee that PCI card won't be offline immediately after this check.

Thanks


> 
> Regards,
> Kalesh AP
> 
> >
> >
> > >
> > >  #define HWRM_VERSION_DEV_ATTR_MAX_DPI  0x1000A0000000DULL
> > >  /* HWRM version 1.10.3.18 */
> > > --
> > > 2.43.5
> > >
> >



