Return-Path: <linux-rdma+bounces-6840-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3A2A02695
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 14:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC873A2426
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 13:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1161DC04C;
	Mon,  6 Jan 2025 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvcL/hyH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7674C1D86F1
	for <linux-rdma@vger.kernel.org>; Mon,  6 Jan 2025 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736170324; cv=none; b=hju5bTVA03+IJjZ7SAHM5tXrTc/Q/kDb3pIFCbC947u0dcwCeoJTWgXxvEJSqLJmF95gkH2ulhSpU4n7zZpIZn4vCj0WHyF0QgOO4Cu5UVDFVyhaRutXEbhCiD/sg5TWZHJ/sJvdVSgt4Hesr+YwhmX9IGirAKwKrGdMVGqyB4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736170324; c=relaxed/simple;
	bh=HgPGqFPsW3irZTnVSRPzUireH4pw21/23XErXs4Iuys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMGrD2CiGDBnHfh/8cptO6LfY1e+D3VR7iGVvU8w1ToiVDUbZAdHmtg6VccZAqhinYFfcNicfe6UBVtRgLajVw4AgSgff+JEBjgKoJnBhCv6QcZ4LKKBeC2Tu+2K5V8bB/ZOIJ2s1+d0VD8f/1LFwI+dRug5QtHJEEZflAJzaEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvcL/hyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E157C4CED2;
	Mon,  6 Jan 2025 13:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736170324;
	bh=HgPGqFPsW3irZTnVSRPzUireH4pw21/23XErXs4Iuys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvcL/hyH/K+7oFrjJ80ygPaiMCg+WkR2W+r30yl3hKxs9uZhLxyU2eeHViSZHuQ2u
	 f3Dxd5f8LWoj7JHj+7UUId4vfMvJwHk0sqIhzpculxh7s+/iLcIjb69aOSkv0C9U+G
	 eht9vjrMme6QebO16SaWluHZPeSTvELlaGu1xPGx1FdhCB6wfqIHYwxT2Et/uSBuF4
	 oxLUjV2J3OWx+F3Om7H91iHWCP7ozpqYLFYLEWfRPuYVLzGzXHUhm/2GfN506Q/bGT
	 YwmJbomnG2MnQD3OBL/6m3HoxwrQLLNox+K13wljnHTWYSTNmxmDoxcmj1llcJmML6
	 Us2F6Xic3ZDqQ==
Date: Mon, 6 Jan 2025 15:31:59 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	michael.chan@broadcom.com
Subject: Re: [PATCH for-next v2 0/4] RDMA/bnxt_re: Support for FW async event
 handling
Message-ID: <20250106133159.GA468445@unreal>
References: <20250106095349.2880446-1-kalesh-anakkur.purayil@broadcom.com>
 <CAH-L+nN=OoLpfOFjEFJx_ehyBRj+zYY3woQZhOdS0gxAfJzpsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH-L+nN=OoLpfOFjEFJx_ehyBRj+zYY3woQZhOdS0gxAfJzpsw@mail.gmail.com>

On Mon, Jan 06, 2025 at 03:43:47PM +0530, Kalesh Anakkur Purayil wrote:
> Hi Leon,
> 
> I missed to copy netdev maintainers and ML. One of the patches in the
> series is for Broadcom bnxt driver.
> 
> I will resend the series.

Great, thanks

> 
> On Mon, Jan 6, 2025 at 3:31 PM Kalesh AP
> <kalesh-anakkur.purayil@broadcom.com> wrote:
> >
> > This patch series adds support for FW async event handling
> > in the bnxt_re driver.
> >
> > V1->V2:
> > 1. Rebased on top of the latest "for-next" tree.
> > 2. Split Patch#1 into 2 - one for Ethernet driver changes and
> >    another one for RDMA driver changes.
> > 3. Addressed Leon's comments on Patch#1 and Patch #3.
> > V1: https://lore.kernel.org/linux-rdma/1725363051-19268-1-git-send-email-selvin.xavier@broadcom.com/T/#t
> >
> > Patch #1:
> > 1. Removed BNXT_EN_FLAG_ULP_STOPPED state check from bnxt_ulp_async_events().
> >    The ulp_ops are protected by RCU. This means that during bnxt_unregister_dev(),
> >    Ethernet driver set the ulp_ops pointer to NULL and do RCU sync before return
> >    to the RDMA driver.
> >    So ulp_ops and the pointers in ulp_ops are always valid or NULL when the
> >    Ethernet driver references ulp_ops. ULP_STOPPED is a state and should be
> >    unrelated to async events. It should not affect whether async events should
> >    or should not be passed to the RDMA driver.
> > 2. Changed Author of Ethernet driver changes to Michael Chan.
> > 3. Removed unnecessary export of function bnxt_ulp_async_events.
> >
> > Patch #3:
> > 1. Removed unnecessary flush_workqueue() before destroy_workqueue()
> > 2. Removed unnecessary NULL assignment after free.
> > 3. Changed to use "ibdev_xxx" and reduce level of couple of logs to debug.
> >
> > Please review and apply.
> >
> > Regards,
> > Kalesh
> >
> > Kalesh AP (3):
> >   RDMA/bnxt_re: Add Async event handling support
> >   RDMA/bnxt_re: Query firmware defaults of CC params during probe
> >   RDMA/bnxt_re: Add support to handle DCB_CONFIG_CHANGE event
> >
> > Michael Chan (1):
> >   bnxt_en: Add ULP call to notify async events
> >
> >  drivers/infiniband/hw/bnxt_re/bnxt_re.h       |   3 +
> >  drivers/infiniband/hw/bnxt_re/main.c          | 156 ++++++++++++++++++
> >  drivers/infiniband/hw/bnxt_re/qplib_fp.h      |   2 +
> >  drivers/infiniband/hw/bnxt_re/qplib_sp.c      | 113 +++++++++++++
> >  drivers/infiniband/hw/bnxt_re/qplib_sp.h      |   3 +
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   1 +
> >  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  28 ++++
> >  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |   1 +
> >  8 files changed, 307 insertions(+)
> >
> > --
> > 2.43.5
> >
> 
> 
> -- 
> Regards,
> Kalesh AP



