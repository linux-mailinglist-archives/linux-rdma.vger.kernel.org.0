Return-Path: <linux-rdma+bounces-1423-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E58087AFC8
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Mar 2024 19:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6451F2D9C5
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Mar 2024 18:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B7561695;
	Wed, 13 Mar 2024 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDm/2mZB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B1D62141;
	Wed, 13 Mar 2024 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350169; cv=none; b=R4NBRnvFHdEz4bri9yPSR4GCBXs3zLoek5C9PP4er6WGQJKsLaEMMHVEGrLn8H97f1NStzMng654L2HP2ZrvKN2XeuRxB4aLfhRVQeH1TWFIaPiAk9ryuxSUUao2vMy4kuIoxvZuBdDjmqqrMr4PrCM1nlZ2oVAqqlKD15Xv5lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350169; c=relaxed/simple;
	bh=+0ELk9KyA7j5R9h8vQwZ4rMn6FfpbqQnPsppTRu/Qt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDO3eazaJd7vCa1PBtxzyIn6uryOdB01GwmOB237pZd9CEqNNOHRH9uQDGA7Z9mLYVm8gRdxbExs3MZ5oT/E7jAhzNj/bhSTus6Ohn8zYgM9Zw19tnR1RKRdO7RUPipxjdP3yJ5DMqhs321NNsXE73WWpGioj6ibEQEjzS83dME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDm/2mZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57E2C433F1;
	Wed, 13 Mar 2024 17:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710350169;
	bh=+0ELk9KyA7j5R9h8vQwZ4rMn6FfpbqQnPsppTRu/Qt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fDm/2mZBsV4emEweBDJadyOeB9HUk8urOwqjWUzUijkWMRyvUTpli1i8AW52p6tt9
	 iQn87mRjvONfLAYkjeT4ZikEaqOCRjnJaUgXsTk4nvqjTxx3OTrKbs2plrIUaWeahA
	 +lRMRxs4VN/YyfniNVtSZ8E/wLbkYjcaQKuS7A9v93+aj2OM5MxFm0HYgx7JeZlbUh
	 ev38tdhngedD9u62vHXdliHoQi11UgVhBWrnXNDy1oaZaHVlpGwNHbLPDRj7O0gwk1
	 dPkqTnIu3IHmUAnOUoUPO8UBo7A5KIX7VSz1uOCbyGO6QRJFV4cg3Y/BflzVjmDGLE
	 CQFblhZt72ZJw==
Date: Wed, 13 Mar 2024 19:16:04 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, keescook@chromium.org,
	"open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] IB/hfi1: allocate dummy net_device dynamically
Message-ID: <20240313171604.GB12921@unreal>
References: <20240313103311.2926567-1-leitao@debian.org>
 <20240313104252.GA12921@unreal>
 <20240313065526.10c6217b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313065526.10c6217b@kernel.org>

On Wed, Mar 13, 2024 at 06:55:26AM -0700, Jakub Kicinski wrote:
> On Wed, 13 Mar 2024 12:42:52 +0200 Leon Romanovsky wrote:
> > > PS: this diff needs d160c66cda0ac8614 ("net: Do not return value from
> > > init_dummy_netdev()") in order to apply and build cleanly.  
> > 
> > We are in merge window now, so if Dennis approves, I will apply it
> > after the merge window
> 
> Can we do a shared branch? We don't want to wait full release cycle
> for a single driver outside of netdev.

No problem, I will create a branch based on -rc1 for it.

Thanks

