Return-Path: <linux-rdma+bounces-5362-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D632998420
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 12:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6A21F250FD
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 10:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA561A0737;
	Thu, 10 Oct 2024 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k87p0cbY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE35A47A60
	for <linux-rdma@vger.kernel.org>; Thu, 10 Oct 2024 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728557290; cv=none; b=lPSbsBbdhGJoeJ+NLIfU7dl9xqOKzbEqa2ih934w8pE70J6fWTep+ZWck//nSMdLIGDoQ1wtca0GOyjkimtbhiAG1ZT/IxAN/R85ApcT40i4BIeUM+UIYUPHZCpbv7UgY0ThMx2+v9QTDWgahO/PHVCJZoTNKDxEMeWOR1aG6XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728557290; c=relaxed/simple;
	bh=ziDm9WsGzPh3OVzTdXYdHoD2rmcyT4qj4JiE7va0ys8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCjho6Jlr51KrNr0agDKL7VnsdbblmtBQ9251QZ7jmM1fn1Ije5e+yeJvB2hutqmWhFcO5ZERqddu1fXKzxwRerNJifZ3eJPsrIIYM32j0QBP8xaMdE7T+5Js8RCvEyYZpB4HgSU9hL/+P+QvaPZCUSu314uihkbVseyBJJG/K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k87p0cbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDDAC4CEC5;
	Thu, 10 Oct 2024 10:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728557290;
	bh=ziDm9WsGzPh3OVzTdXYdHoD2rmcyT4qj4JiE7va0ys8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k87p0cbYySIFN+wmVi5OkD2Gnm1x1v7WIeOy7khZb0ptN00wuNOadsI2NAjEbHXOc
	 fEdsdlXF6oh0Ur9zdxROJ3QkiaK+T0kbkqOxeX1ZS/p9o5SoUVLrfyvz/x+CnmqEML
	 H3mKyBa0KPW4RhexlS9wIRXK616hu9Nlb06TZQD0Nc7PeTTNYGzcl9CtYJC58doA7E
	 Ahearpnwu4sQ/6x15w87/qAOcGGl5LpWYUC8CZQ79e7i+WmAZS8Oy/hEgDKTklnN6F
	 8fGUtZl7ANnN094NKPQ1gPraVK26BnEWfSNB1zydqMB6DLdSFOjsd8qY15OOGe3JD+
	 TAYESj23imV1Q==
Date: Thu, 10 Oct 2024 13:48:04 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tian Xin <tianx@yunsilicon.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 0/6] Add Yunsilicon User Space RoCE Driver
Message-ID: <20241010104804.GF29736@unreal>
References: <20241010081049.1448826-1-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010081049.1448826-1-tianx@yunsilicon.com>

On Thu, Oct 10, 2024 at 04:10:43PM +0800, Tian Xin wrote:
> This series of patches adds the user-space RoCE driver for the Yunsilicon MS/MC series smart NICs.
> Please review and apply.

You should post and make sure that kernel patches are accepted before
asking to apply user-space patches.

Thanks

