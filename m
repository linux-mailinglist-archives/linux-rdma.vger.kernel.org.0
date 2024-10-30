Return-Path: <linux-rdma+bounces-5615-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEC79B646C
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 14:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610BE2811D1
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 13:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED731EABC8;
	Wed, 30 Oct 2024 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPGpAaTH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6281E570E
	for <linux-rdma@vger.kernel.org>; Wed, 30 Oct 2024 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295790; cv=none; b=IHw3wEbrNW1IytW8L4SMw8KQ/NJ55ERnu3supqX8dFt9wF638GC6GsuBWrUrD7J5j2TsrkPeG4ZA5egktO/nuZs4KSdSMZiwxN+XCndGuPOVGvmwRPjIeoJqsytfNvlA5BunjNd8/gE6vAJzuECikBa7Ley0Re3KNKty4HpmZao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295790; c=relaxed/simple;
	bh=p7qbzv6ebfGtMCWqe5GWu3RVrBq+V2Nm1fnO71Fa60k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moRerAkPrkLZ4TY2GkQXydtUOJtVfdtVGp/l3+nL4Kj9DocJf1zn6V8vpFADw7BMxROkQSCnr4fBE4VoZYPgd/R7ROKeZ7kdy6fgAcW2tUPG7v4J193fT/8ZdHFmqX92sbe0Ud1Lg8eJCcbbxYBrKEZAllOTSMcCj52ENYHDqQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPGpAaTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122B2C4CEE3;
	Wed, 30 Oct 2024 13:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730295789;
	bh=p7qbzv6ebfGtMCWqe5GWu3RVrBq+V2Nm1fnO71Fa60k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XPGpAaTHdRyF+3wtzbuytaqAtyo/a8SVgLGxi9ynBL9t51SPOaW97HDNIIjpAzD4+
	 pEweAPbh5kSAn+Tf5nnoe6Tp8JXxPrDjzeDka2Glem+ukyMaJ0k6kzjIWE8jjMA61E
	 69ydiCRjJqFvNk5PjauT7kG+iT6tkYGzRZM7PtmZri3H1aWSbEnG6syLX5yZxANHY5
	 I5RstAm5pi5e/gQ6LW9XIvelUfDB58CtXcwH64NlMap1KtjHs+3xYxQad5QN9gwe4e
	 lWCkH1GYqqnCrbMNPw3ytpGKRxXDOU0djO74NRe9945Eot0z4CzAeHVEvOVjoSQNEo
	 5x2lTIms0Cb3g==
Date: Wed, 30 Oct 2024 15:43:06 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com, kashyap.desai@broadcom.com,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Subject: Re: [PATCH for-next 4/4] RDMA/bnxt_re: Add debugfs hook in the driver
Message-ID: <20241030134306.GA5988@unreal>
References: <1729591916-29134-1-git-send-email-selvin.xavier@broadcom.com>
 <1729591916-29134-5-git-send-email-selvin.xavier@broadcom.com>
 <4766a9e3-205a-4979-33c8-703e1148675c@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4766a9e3-205a-4979-33c8-703e1148675c@hisilicon.com>

On Wed, Oct 30, 2024 at 06:10:18PM +0800, Junxian Huang wrote:
> 
> 
> On 2024/10/22 18:11, Selvin Xavier wrote:
> > From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > 
> > Adding support for a per device debugfs folder for exporting
> > some of the device specific debug information.
> > Added support to get QP info for now. The same folder can be
> > used to export other debug features in future.
> > 
> > Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
> > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/Makefile   |   3 +-
> >  drivers/infiniband/hw/bnxt_re/bnxt_re.h  |   2 +
> >  drivers/infiniband/hw/bnxt_re/debugfs.c  | 141 +++++++++++++++++++++++++++++++
> >  drivers/infiniband/hw/bnxt_re/debugfs.h  |  21 +++++
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c |   4 +
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.h |   1 +
> >  drivers/infiniband/hw/bnxt_re/main.c     |  13 ++-
> >  7 files changed, 183 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/infiniband/hw/bnxt_re/debugfs.c
> >  create mode 100644 drivers/infiniband/hw/bnxt_re/debugfs.h

<...>

> > +static inline const char *bnxt_re_qp_type_str(u8 type)
> > +{
> > +	switch (type) {
> > +	case CMDQ_CREATE_QP1_TYPE_GSI: return "QP1";
> > +	case CMDQ_CREATE_QP_TYPE_GSI: return "QP1";
> > +	case CMDQ_CREATE_QP_TYPE_RC: return "RC";
> > +	case CMDQ_CREATE_QP_TYPE_UD: return "UD";
> > +	case CMDQ_CREATE_QP_TYPE_RAW_ETHERTYPE: return "RAW_ETHERTYPE";
> > +	default: return "Invalid transport type";
> > +	}
> > +}
> > +
> 
> Would it be better to use table-driven approach for these two functions?

No, proposed variant is better as it can be consumed very easily by tools.
Table are good for humans but bad for tooling.

Thanks

