Return-Path: <linux-rdma+bounces-3478-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0776F916A1F
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 16:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82DB28128D
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 14:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2028B14A604;
	Tue, 25 Jun 2024 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TC5foLy4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6324BE71
	for <linux-rdma@vger.kernel.org>; Tue, 25 Jun 2024 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325165; cv=none; b=dbdmjiEXzQsE/CL5jRbmaXjlue9Q3I2QtrOYjz8oytV3LJ7l+Pryk6qhbBlgqGmQOKHoRpfn64LJ8VCSh3gO1I4XqXW4WMD2ROdGKvoSynZGtvvHcT+pcxgU+DSXZw9moaT4iBmLZIzyihTQCM+h+I46+TfzYm3WL2aPwdSQkY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325165; c=relaxed/simple;
	bh=eaHIkMuHSA2gLpuC6XMsGSNYT09+5biAkwS398g+RDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZOLgj62xJ6+9Cb6xAT7mE5+9Fr/24cSBESpf96YKqYRFJwTIEl2eL4ZG3oXVCZgx2OCrXm0BRYy6wj6SCSG7kiCNU7QXOIcYqU2DK9Zz19U861kLYy1Pm+b4XEuzDDAczaQQF3Ap3jVaI2qhojRpnq9ERcVAjhLDFtVVSSsLMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TC5foLy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F384CC32781;
	Tue, 25 Jun 2024 14:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719325165;
	bh=eaHIkMuHSA2gLpuC6XMsGSNYT09+5biAkwS398g+RDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TC5foLy4cJjGEdq/weo2QKlLWf7htGdLkVo6epShJwSDRBlNzJZU0d39EZqPrJEdn
	 KXkjK7zULjczSrCoAqzhpojrcvv5VxXDgR1fAUyWw7ipp1cz2egxhHnexe6EL6P9lJ
	 ndINupypDu/c5TWFeqImIbQRWYGQxZec/84kGdLmhuotUeiug/AUCdMN4XWzQOBhFY
	 apbI2tcGzRyit7VmkQnWY5z1/YQtvUG+XVHBUJDggTZck8VRN3sTfdHHbL3ON4TISo
	 X+kflqiGJ/oGo7G5OUuozQNCgqN97hYvJvaZlK5TBSM2Ho8y2ddDpQz4qcht4Q/WtA
	 y86wEIwW00/+g==
Date: Tue, 25 Jun 2024 17:19:21 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: Gal Pressman <gal.pressman@linux.dev>, jgg@nvidia.com,
	linux-rdma@vger.kernel.org, sleybo@amazon.com, matua@amazon.com,
	Firas Jahjah <firasj@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next 4/5] RDMA/efa: Move type conversion helpers to
 efa.h
Message-ID: <20240625141921.GL29266@unreal>
References: <20240624160918.27060-1-mrgolin@amazon.com>
 <20240624160918.27060-5-mrgolin@amazon.com>
 <1c1f22fd-10fb-4fc6-a4a7-f167013b60c3@linux.dev>
 <99b2acde-bb35-4de9-9d1f-d52e69e81bce@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99b2acde-bb35-4de9-9d1f-d52e69e81bce@amazon.com>

On Tue, Jun 25, 2024 at 02:21:39PM +0300, Margolin, Michael wrote:
> On 6/25/2024 9:33 AM, Gal Pressman wrote
> 
> > On 24/06/2024 19:09, Michael Margolin wrote:
> > > Move ib_ to efa_ types conversion functions to have them near the types
> > > definitions and to reduce code in efa_verbs.c.
> > > 
> > > Reviewed-by: Firas Jahjah <firasj@amazon.com>
> > > Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
> > > Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> > The idea was to not expose these functions in the h file as they are not
> > used outside of efa_verbs.c.
> 
> I know but it's a driver internal header and it also makes sense to have the
> cast from the base type near the definition.

We put in header file things which are used in multiple files. It is not
the case here. Let's try to avoid code churn without real gain behind it.

Thanks

> 
> Michael
> 

