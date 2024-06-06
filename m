Return-Path: <linux-rdma+bounces-2936-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B34C8FE444
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 12:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E53A28598C
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 10:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A66E1953B6;
	Thu,  6 Jun 2024 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+xivNkp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6F2194C63;
	Thu,  6 Jun 2024 10:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669767; cv=none; b=G22WSGmrAuZy3Q8CU43aFYzhTonA7Fb+07qCdeWnZt31jLs9g8aPrTP+/il/Ax9OI5EKzY9QVxoMPPWvyZslEujeCAvBbb7WTztn9lHZ2tZpfiltIfJaYP6OWQCjpxkVzV6KR6uCZK5RfEqjaQyMhpGAor1u/Mfj20Ou1fxTDu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669767; c=relaxed/simple;
	bh=qhqknNWVMeNYoWtTdBFYEjniMNaEAVGn4mAJNY/G3To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHCcd+ZEpbZzSYD/fB1m/rkrI1q4YVLMWVckDGSf4mbC+USeZoX70vUeNNdx5WceKYbSzqCajDX7L8z7eK67tTVKETR6l642cYddtPmmMvV7FjXogbPK7nAVuUTF1eEv0Rrzx6K/iCWt/+hGGcpgP9TemoR6egkuJMIEQBBtmG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+xivNkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877A6C4AF0F;
	Thu,  6 Jun 2024 10:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717669766;
	bh=qhqknNWVMeNYoWtTdBFYEjniMNaEAVGn4mAJNY/G3To=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k+xivNkpkyVhP1NuwNn+lsy8+20Ri42Il3zhipU1fxf8wo6vrLJp+Scs92UYJETMc
	 yCkDwht9art5jJTfNiTyj48jjXCFnHkGKkItGnHHJQZVyLWmic+dv1hcIms34EnpPE
	 e9aX73VH7w/YSpHPRVyk22wRauXo2Utv9OLK7svRtI9myoUyJQlJF0cXCT3T53Mn7t
	 zWPFwtuz+tJDbwCPtb+fAkXgMsFK4D5BNENzFAgiaqQsSKXPXhbn+P8W60QYPaGImp
	 gRYNGgW1qglssWl4XPG6ia0iOFkH3qY4FX1y0GJpTlREjlsIpQn5qxyqUzZvAo6Wbu
	 99yoYfX65B+Zw==
Date: Thu, 6 Jun 2024 13:29:21 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Hillf Danton <hdanton@sina.com>
Cc: Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH -rc] workqueue: Reimplement UAF fix to avoid lockdep
 worning
Message-ID: <20240606102921.GE13732@unreal>
References: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org>
 <ZljyqODpCD0_5-YD@slm.duckdns.org>
 <20240531034851.GF3884@unreal>
 <Zl4jPImmEeRuYQjz@slm.duckdns.org>
 <20240604105456.1668-1-hdanton@sina.com>
 <20240604113834.GO3884@unreal>
 <Zl9BOaPDsQBc8hSL@slm.duckdns.org>
 <20240605111055.1843-1-hdanton@sina.com>
 <20240606073801.GA13732@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606073801.GA13732@unreal>

On Thu, Jun 06, 2024 at 10:38:01AM +0300, Leon Romanovsky wrote:
> On Wed, Jun 05, 2024 at 07:10:55PM +0800, Hillf Danton wrote:
> > On Tue, 4 Jun 2024 21:58:04 +0300 Leon Romanovsky <leon@kernel.org>
> > > On Tue, Jun 04, 2024 at 06:30:49AM -1000, Tejun Heo wrote:
> > > > On Tue, Jun 04, 2024 at 02:38:34PM +0300, Leon Romanovsky wrote:
> > > > > Thanks, it is very rare situation where call to flush/drain queue
> > > > > (in our case kthread_flush_worker) in the middle of the allocation
> > > > > flow can be correct. I can't remember any such case.
> > > > >
> > > > > So even we don't fully understand the root cause, the reimplementation
> > > > > is still valid and improves existing code.
> > > > 
> > > > It's not valid. pwq release is async and while wq free in the error path
> > > > isn't. The flush is there so that we finish the async part before
> > > > synchronize error handling. The patch you posted will can lead to double
> > > > free after a pwq allocation failure. We can make the error path synchronous
> > > > but the pwq free path should be updated first so that it stays synchronous
> > > > in the error path. Note that it *needs* to be asynchronous in non-error
> > > > paths, so it's going to be a bit subtle one way or the other.
> > > 
> > > But at that point, we didn't add newly created WQ to any list which will execute
> > > that asynchronous release. Did I miss something?
> > > 
> > Maybe it is more subtle than thought, but not difficult to make the wq
> > allocation path sync. See if the patch could survive your test.
> 
> Thanks, I started to run our tests with Dan's revert.
> https://lore.kernel.org/all/171711745834.1628941.5259278474013108507.stgit@dwillia2-xfh.jf.intel.com/
> 
> As premature results, it fixed my lockdep warnings, but it will take time till I get full confidence.

Don't series fixed reported issue.

Thanks

