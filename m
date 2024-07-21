Return-Path: <linux-rdma+bounces-3916-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5690893848D
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jul 2024 14:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7A62813E8
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jul 2024 12:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09666160877;
	Sun, 21 Jul 2024 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxzg1xjC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0665C8C7;
	Sun, 21 Jul 2024 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721563586; cv=none; b=o+ml9MUAED3uO/fwDsr6AJbhOoVuBE4AI//Vn2pBjOjliNAQP2b29c7hi4G6hXE7Qsd8ZIk4iF0DY+FUNpX4y0LUE1n1Q3ATYoOEQemIH/AOvAnHtdcRQ17Z05lrwHC3pSHTwtMuJOLl8p/59HP3UZP4QuiVFjG1e0v8oKNhupc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721563586; c=relaxed/simple;
	bh=lH8MLWsyj/GfHZ1cGgbxLLjN9i+tP95cTbyDRww3gxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIxuOzULBPQ5M5AOb2j1nWcDjyGRNMiQtGkuwb63XZwU5oziKkqTvl9lnz3/9Uw35xS/7yxRRadUgjoE6gZj+Aoq6riKVcA+5pOngr3JQew7aYvAMaLe3TvAlT8PqHMMlv4kkSAba85kW1OXbB7QlUPlen6QuGlWc5AVqJSrSjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxzg1xjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0636C116B1;
	Sun, 21 Jul 2024 12:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721563585;
	bh=lH8MLWsyj/GfHZ1cGgbxLLjN9i+tP95cTbyDRww3gxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mxzg1xjC9QDIUsCgdBPE9dMsePzZnaQxd4ZtNJgl77xNJvQQRN7V3P6HYn4Yyetgv
	 YoK9Q+IeGvZBAakaYeU6ZZ+VJjNKcGc0kyAAi85GWAr8zyKxDw3ZjZR9g578qvrGeN
	 oWX/enJ0B7HLpNDrCFpQ+avpJQ7q3Xketo02x8Da0silj1q/JxykrIUArxIzG0dMxU
	 ZKdwB4BSssthseEIte+urm3RWhSb7vriAs6ALOaXaXL3gFutu1p1MhufGnBu4KIwnX
	 JOAn0nlGWn2HLF18tlblvZdxiFrMbnMXtMvLiVcaEudl6trPbYWNZm1iWL5kRZoK5u
	 mag/uPyl7uphw==
Date: Sun, 21 Jul 2024 15:06:20 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Allison Henderson <allison.henderson@oracle.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/rds: remove unused struct 'rds_ib_dereg_odp_mr'
Message-ID: <20240721120620.GF1265781@unreal>
References: <20240531233307.302571-1-linux@treblig.org>
 <2442cae88ee4a5f7ba46bb0158735634fa82a305.camel@oracle.com>
 <ZpsEof3hxKGQBmqF@gallifrey>
 <20240721070557.GE1265781@unreal>
 <Zpzq2cPc8rS-OUdW@gallifrey>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zpzq2cPc8rS-OUdW@gallifrey>

On Sun, Jul 21, 2024 at 11:02:49AM +0000, Dr. David Alan Gilbert wrote:
> * Leon Romanovsky (leon@kernel.org) wrote:
> > On Sat, Jul 20, 2024 at 12:28:17AM +0000, Dr. David Alan Gilbert wrote:
> > > * Allison Henderson (allison.henderson@oracle.com) wrote:
> > > > On Sat, 2024-06-01 at 00:33 +0100, linux@treblig.org wrote:
> > > > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > > > 
> > > > > 'rds_ib_dereg_odp_mr' has been unused since the original
> > > > > commit 2eafa1746f17 ("net/rds: Handle ODP mr
> > > > > registration/unregistration").
> > > > > 
> > > > > Remove it.
> > > > > 
> > > > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > > > 
> > > > This patch looks fine to me, the struct is indeed unused at this point.
> > > > Thanks for the clean up!
> > > > 
> > > > Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
> > > 
> > > Hi,
> > >   Does anyone know who might pick this one up - I don't think
> > > it's in -next yet?
> > 
> > 1. We are in merge window and this patch is not a bug fix, so it should
> >    wait until the next merge window.
> 
> Yeh I did wonder; it was posted and reviewed back at the start of June.
> 
> > 2. Title should be net/rds ... and not RDMA/rds ...
> 
> OK, I can easily fix that.
> 
> > 3. netdev is closed right now, so it should be resubmitted after next merge
> >    window ends.
> 
> When you say 'resubmitted' - you mean reposted to the lists with the amended
> title? Or what?

Yes, reposted to the netdev@ ML with the correct title.

Thanks

> 
> Dave
> 
> > Thanks
> > 
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/

