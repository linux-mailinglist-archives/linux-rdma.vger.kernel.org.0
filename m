Return-Path: <linux-rdma+bounces-4881-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226789753DC
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 15:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5544F1C22DCC
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 13:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258ED19F118;
	Wed, 11 Sep 2024 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD2mCaFU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D74190667;
	Wed, 11 Sep 2024 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061123; cv=none; b=sHlFhzEFyj1/KR8okyzDFOkckoXWtUNWurgTVjodAxvzA0b5KVifxK7nllljSMDsZy3mNblkjaHad4QXu35xL5qIiAijVlcD7XPx1q54poeIEvYA+x9NC5I/Gq95fAHcOm/Yf+Euy+HiQI/2tjzyYh7IS0xKc0CRYwt8WS5wrX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061123; c=relaxed/simple;
	bh=k5YPF6kGF8BqiPNEKQ5nlgqmQy5tRXcTGJJ7u+mTjyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpsY40KnUOpxDPIzjoASFehkMUtoDi1fmGxxU8xp2Q/yil31u5nDGmqMklArlR6Hb5pQ9csPC3JUC2omQqhRPFU4+iNctCkhwLmAR4b+bydZZqo5m2A+8OKWr+WU5Ukxd0VWpPN/aQrJjRR41YTRNimpY+hkFe49H1ZJ+46ltE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD2mCaFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC21C4CEC5;
	Wed, 11 Sep 2024 13:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726061123;
	bh=k5YPF6kGF8BqiPNEKQ5nlgqmQy5tRXcTGJJ7u+mTjyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CD2mCaFUMJ889pUmwOMM5zeXqToz4b5yModnE68iNxNSVWYNTpFDnraC6k6Bc0IuJ
	 wgTPLW5Z+36yghUzTQVlPUaN0f+YO+caIIiIcs7NNlfzTmRwESQa6i7jZXKEpNgqCn
	 9Cy9DTq5vZAQPPqn/HyMDdJqP9hlI05sc8sGK4AY0IMonS/97fMJBndyW5TwoYnTQq
	 fUtgEMaUvonT1tRwtxvdZ1CoS3Yse5Xq41H0X+OW+UpTa2Gr+7kP9V5z85P/FCOJK2
	 xexOW0l3IJKjiVFR5HQeD4bWgvByU/aRHM7LQf56FDXfJnqWC5NieW0Fh7RN5oqMkX
	 3msHdyvxilVYw==
Date: Wed, 11 Sep 2024 16:25:17 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next 3/9] RDMA/hns: Fix cpu stuck caused by printings
 during reset
Message-ID: <20240911132517.GH4026@unreal>
References: <20240906093444.3571619-1-huangjunxian6@hisilicon.com>
 <20240906093444.3571619-4-huangjunxian6@hisilicon.com>
 <20240910130946.GA4026@unreal>
 <4c202653-1ad7-d885-55b7-07c77a549b09@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c202653-1ad7-d885-55b7-07c77a549b09@hisilicon.com>

On Wed, Sep 11, 2024 at 09:34:19AM +0800, Junxian Huang wrote:
> 
> 
> On 2024/9/10 21:09, Leon Romanovsky wrote:
> > On Fri, Sep 06, 2024 at 05:34:38PM +0800, Junxian Huang wrote:
> >> From: wenglianfa <wenglianfa@huawei.com>
> >>
> >> During reset, cmd to destroy resources such as qp, cq, and mr may
> >> fail, and error logs will be printed. When a large number of
> >> resources are destroyed, there will be lots of printings, and it
> >> may lead to a cpu stuck. Replace the printing functions in these
> >> paths with the ratelimited version.
> > 
> > At lease some of them if not most should be deleted.
> > 
> 
> Hi Leon,I wonder if there is a clear standard about whether printing
> can be added?

I don't think so, but there are some guidelines that can help you to do it:
1. Don't print error messages in the fast path.
2. Don't print error messages if other function down in the stack already
   printed it.
3. Don't print error messages if it is possible to trigger them from
unprivileged user.
...

> 
> Thanks,
> Junxian
> 
> > Thanks

