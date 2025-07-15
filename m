Return-Path: <linux-rdma+bounces-12179-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB441B05279
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 09:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1486D4A689F
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 07:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A96926D4F9;
	Tue, 15 Jul 2025 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkHVkiX4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEAB26560D
	for <linux-rdma@vger.kernel.org>; Tue, 15 Jul 2025 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563649; cv=none; b=NYFN2VtyNFBPPoLKN/ojjtrDq9jpUoaevZx0W3Y/2PyQwG8Q/argwp693B/kZ0WfoWQv5i8r3wVpf/hk7GfXmfJbrImzDjPupFw1ApHvyeWT00MV1a7598KlO6YDWn2FnqdUk0Rg8Heo72QncoEb/gyX9LIHvUqP5PG+5CXFUHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563649; c=relaxed/simple;
	bh=9aLUyTcdw2vvDPrPPq6ZrCQZq8ktxwr2QvVHwzW2RoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXqCIpL4lcAP4EyNTch78uubMlC9Qj6dHbQViL4xhReYIm/MXkSD7aRSC4FaBvQPCdAkCAvbI2BPSSKszmVorN9+EhgMJrol9jNmqEY+Bavh7KKA1dbM3HWzUi8K7fI/tLxHzHRhAXTdNOGJdt8JpdZmnOAtpOnbdj1P7fKMmaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkHVkiX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A32EC4CEE3;
	Tue, 15 Jul 2025 07:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752563649;
	bh=9aLUyTcdw2vvDPrPPq6ZrCQZq8ktxwr2QvVHwzW2RoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NkHVkiX4kP7S5vdbh17ybbfQWd0Esz5Warxm0SYaFY2XBbbj3jpnj+vgOKjtwTFam
	 jWVASwO2TUFqHHkwvXa9/mox6DmjeAtaw5LO7NJ869L2Vj3WpUoNj2SvWwqSKL1YSt
	 ag0InccDrFQ+zOOi3q550imZGlnAZIMKy2aM6fieozdZ3dccZ2tf6G3PbbZEnjXerz
	 dgon6jwf+Ozi0bWy93o5WFo5DMYbaIOAnfGdBQpLFx5x3FITpYqa02wj9ZuMIXkDHJ
	 e+uvSay4yabYQCbTlzWL4iOzk0EsKRJNDODZoScQvI/sGISZ3zOc9MyRQwtOD94LR3
	 5In9R0xRN3P6Q==
Date: Tue, 15 Jul 2025 10:14:04 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 4/8] IB/core: Add UVERBS_METHOD_REG_MR on
 the MR object
Message-ID: <20250715071404.GD5882@unreal>
References: <cover.1752388126.git.leon@kernel.org>
 <10def41b658ca56f28f77472e3460a802ee09053.1752388126.git.leon@kernel.org>
 <20250714163301.GE2067380@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714163301.GE2067380@nvidia.com>

On Mon, Jul 14, 2025 at 01:33:01PM -0300, Jason Gunthorpe wrote:
> On Sun, Jul 13, 2025 at 09:37:25AM +0300, Leon Romanovsky wrote:
> > From: Yishai Hadas <yishaih@nvidia.com>
> > +DECLARE_UVERBS_NAMED_METHOD(
> > +	UVERBS_METHOD_REG_MR,
> > +	UVERBS_ATTR_IDR(UVERBS_ATTR_REG_MR_HANDLE,
> > +			UVERBS_OBJECT_MR,
> > +			UVERBS_ACCESS_NEW,
> > +			UA_MANDATORY),
> > +	UVERBS_ATTR_IDR(UVERBS_ATTR_REG_MR_PD_HANDLE,
> > +			UVERBS_OBJECT_PD,
> > +			UVERBS_ACCESS_READ,
> > +			UA_MANDATORY),
> > +	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_REG_MR_IOVA,
> > +			   UVERBS_ATTR_TYPE(u64),
> > +			   UA_MANDATORY),
> > +	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_REG_MR_LENGTH,
> > +			   UVERBS_ATTR_TYPE(u64),
> > +			   UA_MANDATORY),
> > +	UVERBS_ATTR_FLAGS_IN(UVERBS_ATTR_REG_MR_ACCESS_FLAGS,
> > +			     enum ib_access_flags,
> > +			     UA_MANDATORY),
> 
> Another patch is needed to fix this, we should be scrubbing these
> issues when doing new api conversions:
> 
> include/rdma/ib_verbs.h:enum ib_access_flags {
> 
> Needs to be in the uapi headers.

Let's do it as followup patch in next cycle.

Thanks

> 
> Jason

