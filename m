Return-Path: <linux-rdma+bounces-5585-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6568D9B39CE
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 19:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 082E3B22DBB
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 18:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081931DFE11;
	Mon, 28 Oct 2024 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oc67mhah"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B934A1D8E16
	for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2024 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141908; cv=none; b=TAQAG95gJe5jYCBOLU+yA4Mu1eT+/6hhykzWicgxct7+imt9QMsGlmDZMRG7Z8zTPemAC7qZZnW/yWrxOZKUmfWjds/YBOfBkUnAP6lVfONpKD5Fxn86NcGi6+mI50nM9wUjfQAWeMQlB+hrxGVdlhfkLBP2zb5gLWOF+tRbMqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141908; c=relaxed/simple;
	bh=7VpcZAjq9BqMbJVfC34eubW+FPr095ShgIw7kLsjgPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjnIIwx1Sijzl4Kqz4yLMeUY/+u+NI9SrBehH4phmp8E4KuZ7ZRtpLbidUGR+pm0iC8YrX2RuLCs/Nw4AXMwBnstSMP0zf0Qnyw5wMsY8ly3UkjRLtSE+gz/YexDock4YOU2Ja4wgCmtCLh5FIMFfVhbZytPB3IKfm+AScAdJms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oc67mhah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11A5C4CEC3;
	Mon, 28 Oct 2024 18:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730141907;
	bh=7VpcZAjq9BqMbJVfC34eubW+FPr095ShgIw7kLsjgPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oc67mhahwnWs6GQb2STrpSK1/r3TNTGmFah78Di2m0uG95dwZiBnf+EVUZWrbKQPY
	 fcLmS6AScMQ3AOXqyx5nNIf0wNR0r7qyLqLVeHKslBzi9jsV4dCPyW587NH8t/OqWO
	 lmozM3RKRAPi+2eUfA+X1JQFTkRq4/hppSbIze1GuXYgWAK7GDicedJFkgvlaxzdNf
	 /+FV1INWIbZVDxnINFWqBOtf4LHumDQDjkb5u+WAImmQQl3hP1P98EKkb9bAEULhbb
	 2DDO/Z/zSVyYrkumLPNveCywVcgLOV0st9fwsn0h3M54lSB5VCHQMmZ5g8G88X72Dm
	 rivoo+nwKJr3w==
Date: Mon, 28 Oct 2024 20:58:22 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH for-next v2 1/4] RDMA/bnxt_re: Add support for optimized
 modify QP
Message-ID: <20241028185822.GJ1615717@unreal>
References: <1728928561-25607-1-git-send-email-selvin.xavier@broadcom.com>
 <1728928561-25607-2-git-send-email-selvin.xavier@broadcom.com>
 <20241028115908.GF1615717@unreal>
 <CA+sbYW0VJEYguxy8aqTk9BiZ0NM1B8GJqC_sF6B+b99FeLaFXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+sbYW0VJEYguxy8aqTk9BiZ0NM1B8GJqC_sF6B+b99FeLaFXg@mail.gmail.com>

On Mon, Oct 28, 2024 at 10:20:00PM +0530, Selvin Xavier wrote:
> On Mon, Oct 28, 2024 at 5:29 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, Oct 14, 2024 at 10:55:58AM -0700, Selvin Xavier wrote:
> > > From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > >
> > > Modify QP improvements are for state transitions
> > > from INIT -> RTR and RTR -> RTS.
> > > In order to support the Modify QP Optimization feature,
> > > the driver is expected to check for the feature support
> > > in the CMDQ_QUERY_FUNC and register its support for this
> > > feature with the FW in CMDQ_INITIALIZE_FIRMWARE.
> > >
> > > Additionally, the driver is required to specify the new
> > > fields and attribute masks for the transitions as follows:
> > > 1. INIT -> RTR:
> > >    - New fields: srq_used, type.
> > >    - enable srq_used when RC QP is configured to use SRQ.
> > >    - set the type based on the QP type.
> > >    - Mandatory masks:
> > >      - RC: CMDQ_MODIFY_QP_MODIFY_MASK_ACCESS,
> > >            CMDQ_MODIFY_QP_MODIFY_MASK_PKEY
> > >      - UD QP and QP1: CMDQ_MODIFY_QP_MODIFY_MASK_PKEY,
> > >                       CMDQ_MODIFY_QP_MODIFY_MASK_QKEY
> > > 2. RTR -> RTS:
> > >    - New fields: type
> > >    - set the type based on the QP type.
> > >    - Mandatory masks:
> > >      - RC: CMDQ_MODIFY_QP_MODIFY_MASK_ACCESS
> > >      - UD QP and QP1: CMDQ_MODIFY_QP_MODIFY_MASK_QKEY
> > >
> > > Reviewed-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
> > > Reviewed-by: Tushar Rane <tushar.rane@broadcom.com>
> > > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > ---
> > >  drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 40 ++++++++++++++++++++++++++++++
> > >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  6 ++++-
> > >  drivers/infiniband/hw/bnxt_re/qplib_res.h  |  5 ++++
> > >  drivers/infiniband/hw/bnxt_re/roce_hsi.h   |  3 +++
> > >  4 files changed, 53 insertions(+), 1 deletion(-)
> >
> > <...>
> >
> > > diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
> > > index 3ec8952..69d50d7 100644
> > > --- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
> > > +++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
> > > @@ -216,6 +216,8 @@ struct cmdq_initialize_fw {
> > >       __le16  flags;
> > >       #define CMDQ_INITIALIZE_FW_FLAGS_MRAV_RESERVATION_SPLIT          0x1UL
> > >       #define CMDQ_INITIALIZE_FW_FLAGS_HW_REQUESTER_RETX_SUPPORTED     0x2UL
> > > +     #define CMDQ_INITIALIZE_FW_FLAGS_DRV_VERSION                     0x4UL
> >
> > Where is this define used?
> We are not using this field now. This is structure fields are copied
> from an autogenerated file. Since we updated this structure, we have
> copied all update to that structure. The value we
> are currently interested in is 0x8UL.
> 
> Do you want me to repost the series after removing the above define?

I will remove it by myself, no need to repost.

Thanks

> >
> > > +     #define CMDQ_INITIALIZE_FW_FLAGS_OPTIMIZE_MODIFY_QP_SUPPORTED    0x8UL
> >
> > Thanks



