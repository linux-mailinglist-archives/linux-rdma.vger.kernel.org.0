Return-Path: <linux-rdma+bounces-2355-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830858C0572
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 22:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2B12812FE
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 20:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60656131190;
	Wed,  8 May 2024 20:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSZyA/tB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1116E131183;
	Wed,  8 May 2024 20:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715199425; cv=none; b=aLbd8WPsstjTjZGQ/GUSLvw3uSkyI4LVRn6RzDXzmliLGEHFvyAq0hLk79gx6U/CVlKjqKTO5OOKMJGw5Wcjt98sSVzG5Q0OHqQA9dvzZzLCZ6tgNp6vk+wBRWt5hQodhCw7TOqa/nM8El+QfIRi05x1DYBQ4dukOfTHjyd68sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715199425; c=relaxed/simple;
	bh=AeePNuL7SFwUOG4gPSg8rwAm8IPCSABF4FYA1EDT90I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVrTaJ82txG5Q7Jv5Zyw3s7BVZlRFhvMLQ3RcCuGwPFkOUaxtGGQW498PvPOl5oGxoZaBBIGHOaS+avYEGRRUBIDWrRNxSMyBgzBKPbkjI6aDWx/Nlr9JUh7Rk5wOmZpP7BQp7pPELf3Y33l7Iu2IL8vQKo8Fq7IyXjSqpN204w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSZyA/tB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13308C113CC;
	Wed,  8 May 2024 20:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715199424;
	bh=AeePNuL7SFwUOG4gPSg8rwAm8IPCSABF4FYA1EDT90I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OSZyA/tB5lOjpS4LC/9SY0EU+oSR2ADLqzy+2Oxxm/z6SO+lSeYqArptx9zIchIXk
	 UiNicWJF1t0rqW+/75aVsY9qju7Ua4/12VQZiJiUlaEiH4nP7dtm6m8nHPMJVkL/e7
	 dT4l7ucoWkMp4DEZQmkg02x4F/I3bajuOdqHxt96PxG7vcQGPSxmIVSWWk4UWM2Npy
	 5j8C7jHMtngGG50t8cy9/OfatYDYYOm8fCYKK5P4uKlv6Q2FcvJcfql94ojXTASiir
	 Unt1u5D51eAHSMTj76PGlYkMWXCG+OJIRRO2EgobbMJJ0WcJKSBDeElVhnooiXnVGX
	 evN2ku1af2CsA==
Date: Wed, 8 May 2024 21:16:54 +0100
From: Simon Horman <horms@kernel.org>
To: Allen <allen.lkml@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Allen Pais <apais@linux.microsoft.com>, netdev@vger.kernel.org,
	jes@trained-monkey.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, kda@linux-powerpc.org,
	cai.huoqing@linux.dev, dougmill@linux.ibm.com, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com, nnac123@linux.ibm.com,
	tlfalcon@linux.ibm.com, cooldavid@cooldavid.org,
	marcin.s.wojtas@gmail.com, mlindner@marvell.com,
	stephen@networkplumber.org, nbd@nbd.name, sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com, lorenzo@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	borisp@nvidia.com, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, louis.peens@corigine.com,
	richardcochran@gmail.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acenic@sunsite.dk,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-mediatek@lists.infradead.org, oss-drivers@corigine.com,
	linux-net-drivers@amd.com
Subject: Re: [PATCH 1/1] [RFC] ethernet: Convert from tasklet to BH workqueue
Message-ID: <20240508201654.GA2248333@kernel.org>
References: <20240507190111.16710-1-apais@linux.microsoft.com>
 <20240507190111.16710-2-apais@linux.microsoft.com>
 <Zjp/kgBE2ddjV044@shell.armlinux.org.uk>
 <CAOMdWSKfkT4K9MAOn-rL44pycHPhVDj4CtiYkru5y_s0S-sPeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMdWSKfkT4K9MAOn-rL44pycHPhVDj4CtiYkru5y_s0S-sPeQ@mail.gmail.com>

On Tue, May 07, 2024 at 12:27:10PM -0700, Allen wrote:
> On Tue, May 7, 2024 at 12:23 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Tue, May 07, 2024 at 07:01:11PM +0000, Allen Pais wrote:
> > > The only generic interface to execute asynchronously in the BH context is
> > > tasklet; however, it's marked deprecated and has some design flaws. To
> > > replace tasklets, BH workqueue support was recently added. A BH workqueue
> > > behaves similarly to regular workqueues except that the queued work items
> > > are executed in the BH context.
> > >
> > > This patch converts drivers/ethernet/* from tasklet to BH workqueue.
> >
> > I doubt you're going to get many comments on this patch, being so large
> > and spread across all drivers. I'm not going to bother trying to edit
> > this down to something more sensible, I'll just plonk my comment here.
> >
> > For the mvpp2 driver, you're only updating a comment - and looking at
> > it, the comment no longer reflects the code. It doesn't make use of
> > tasklets at all. That makes the comment wrong whether or not it's
> > updated. So I suggest rather than doing a search and replace for
> > "tasklet" to "BH blahblah" (sorry, I don't remember what you replaced
> > it with) just get rid of that bit of the comment.
> >
> 
>  Thank you Russell.
> 
>  I will get rid of the comment. If it helps, I can create a patch for each
> driver. We did that in the past, with this series, I thought it would be
> easier to apply one patch.

Hi Allen and Russell,

My 2c worth:

* In general non bug-fix patches for networking code should be targeted at
  net-next. This means that they should include net-next in the subject,
  and be based on that tree.

  Subject: [PATCH net-next] ...

* This series does not appear to apply to net-next

* This series appears to depend on code which is not present in net-next.
  f.e. disable_work_sync

* The Infiniband patches should probably be submitted separately
  to the relevant maintainers

* As this patch seems to involve many non-trivial changes
  it seems to me that it would be best to break it up somehow.
  To allow proper review.

* Patch-sets for net-next should be limited to 15 patches,
  so perhaps multiple sequential batches would be a way forwards.

Link: https://docs.kernel.org/process/maintainer-netdev.html

