Return-Path: <linux-rdma+bounces-3913-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E80669383A7
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jul 2024 09:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1982B20E24
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jul 2024 07:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BFF79DE;
	Sun, 21 Jul 2024 07:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4G00I3G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473B733E1;
	Sun, 21 Jul 2024 07:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721545564; cv=none; b=Wp9c/F3ROOXT1GMp5zyqz5BS0STMa2TwMdkyWsTMDF8sei+nHJRWSffacC9s0JAp8+wmHEJlEV6w+fA0YtuO7miQscknEtGzhxrYyfF9EBQ2KzWG9uiRQp6AdL4HRCYMZOwxKrR9qgIHqjmIK5L2Li8nIzmlc9eFjZAyUlole4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721545564; c=relaxed/simple;
	bh=JcNXcRaea8TKhma2pE70uqrsVbqr9Glz8MXnp7nl3iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=me691ukM9dNDp95zISyvl5r337aMEEly+lrMkdzlp8t7+uNmr0MMWeesAH37IJJvTT4P4hZcXqHuze81qb3dHRdBx8B1HOG32+abWU9Hvy0QIr5Ib6xtrGVuvoe1N+7luwaCBrLsawTmccx5lGg5ZJW0CzxEqpC4mJPWaQYQdm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4G00I3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D47CC116B1;
	Sun, 21 Jul 2024 07:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721545562;
	bh=JcNXcRaea8TKhma2pE70uqrsVbqr9Glz8MXnp7nl3iE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l4G00I3G3eI5ce7R2EFdSVzHmFxyBO35lbkFAPBUsYUvicIL0F8zKi397/I7NF66R
	 SkPpK3SgWAWNK1RLD70KXXirfi++2NYDhGuqxbij1Amaw8srWyCW7IiYocb/2IBQf4
	 39jwzEQE42XaW5O80mIhgnCPXkMwd1gPdmOADbynntxTXLe265hm6LCX/YS/yy7PYg
	 QoDn7eTSb4DAp9+LS2+BFesjK3cyNcdAWmoXWo7m0C8Tqmf5BxMML08YgT3m0d0d5Q
	 Jtt+4smibflY3VdTcUkEjL+bYWQT/gvzkqHWGOFnD/ZsLU9yrBhcw/ybebn4MmJ8H9
	 0/sC2dXYF6BiA==
Date: Sun, 21 Jul 2024 10:05:57 +0300
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
Message-ID: <20240721070557.GE1265781@unreal>
References: <20240531233307.302571-1-linux@treblig.org>
 <2442cae88ee4a5f7ba46bb0158735634fa82a305.camel@oracle.com>
 <ZpsEof3hxKGQBmqF@gallifrey>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpsEof3hxKGQBmqF@gallifrey>

On Sat, Jul 20, 2024 at 12:28:17AM +0000, Dr. David Alan Gilbert wrote:
> * Allison Henderson (allison.henderson@oracle.com) wrote:
> > On Sat, 2024-06-01 at 00:33 +0100, linux@treblig.org wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > 
> > > 'rds_ib_dereg_odp_mr' has been unused since the original
> > > commit 2eafa1746f17 ("net/rds: Handle ODP mr
> > > registration/unregistration").
> > > 
> > > Remove it.
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > 
> > This patch looks fine to me, the struct is indeed unused at this point.
> > Thanks for the clean up!
> > 
> > Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
> 
> Hi,
>   Does anyone know who might pick this one up - I don't think
> it's in -next yet?

1. We are in merge window and this patch is not a bug fix, so it should
   wait until the next merge window.
2. Title should be net/rds ... and not RDMA/rds ...
3. netdev is closed right now, so it should be resubmitted after next merge
   window ends.

Thanks

