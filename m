Return-Path: <linux-rdma+bounces-1280-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E512B871EF5
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Mar 2024 13:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228821C21939
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Mar 2024 12:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313805A793;
	Tue,  5 Mar 2024 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iu2yUmHZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2F25A113;
	Tue,  5 Mar 2024 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641251; cv=none; b=gbB3gmTOJk4/emt5czqURxYapSk660KQMOliIfv3Sqg1bmsNHU4LAP12VmhW2jdTrRrn/0LJRcpy0VLC8lqBEv5dNB9YXCI5XQW+o8d2i89D4leckYBZO+9i/v3weBJr3C8RfkwELXMTLxo0SrjCylv8csBb0ykaBr1372QHwts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641251; c=relaxed/simple;
	bh=b/V8QZQ90qh52ZOvATUY3nOcUQbP87GPE1R0pV3RkcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pm5ArWWoEzDONvkmRq9/RhgVAY5XYDtBd3RSSf6ThhhUVjLmThs8nji8J6R8xbWTuuZs4j0tojIZN4BLMnngHwDb8anRewS6cYy+DNYEa+Pn5ssaef7Z1yh1XQTPYiC+1UpIE+iUKX+3G3MFNkeqR9BNX/T+vydDThYr9nhDSj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iu2yUmHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0878C433F1;
	Tue,  5 Mar 2024 12:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709641250;
	bh=b/V8QZQ90qh52ZOvATUY3nOcUQbP87GPE1R0pV3RkcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iu2yUmHZqlMHA4KA+EJe1igW0PU9y/0cWh8vx2XGqplmorVji00fJLEFi5e9w/j3B
	 C0WTyCh1vlkVP+R6uJjV5lJnj+hxniDNA5dit6AmsUq6D6J0j9HlcNLpXYHXNIScSt
	 3Skgef8tGjOFslSVVaNBw3FqEtUHI4NmGjLT0Dx7VP6la+cDiImaWL9mPEHeh2ZnIP
	 dqiUMKe56IunvAhjWmpbYh9g+HN3yPuTtQQH2DVGXR1co2TtlvVbgtig2M7WBE98f+
	 mdLalGVkMlKoSAWhaFWX0+nD3VaTl11oCh0t8mTVqaCaWpPUr2eXC/+CaqbqbEykNZ
	 9eVonUATrflYg==
Date: Tue, 5 Mar 2024 12:20:45 +0000
From: Simon Horman <horms@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, rds-devel@oss.oracle.com,
	santosh.shilimkar@oracle.com,
	syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] net/rds: fix WARNING in rds_conn_connect_if_down
Message-ID: <20240305122045.GB2357@kernel.org>
References: <20240304170707.GJ403078@kernel.org>
 <tencent_A0E364097003A96459B76B577166D5F36505@qq.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_A0E364097003A96459B76B577166D5F36505@qq.com>

On Tue, Mar 05, 2024 at 08:12:03AM +0800, Edward Adam Davis wrote:
> On Mon, 4 Mar 2024 17:07:07 +0000, Simon Horman wrote:
> > > If connection isn't established yet, get_mr() will fail, trigger connection after
> > > get_mr().
> > > 
> > > Fixes: 584a8279a44a ("RDS: RDMA: return appropriate error on rdma map failures") 
> > > Reported-and-tested-by: syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > ---
> > >  net/rds/rdma.c | 3 +++
> > >  net/rds/send.c | 6 +-----
> > >  2 files changed, 4 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/net/rds/rdma.c b/net/rds/rdma.c
> > > index fba82d36593a..a4e3c5de998b 100644
> > > --- a/net/rds/rdma.c
> > > +++ b/net/rds/rdma.c
> > > @@ -301,6 +301,9 @@ static int __rds_rdma_map(struct rds_sock *rs, struct rds_get_mr_args *args,
> > >  			kfree(sg);
> > >  		}
> > >  		ret = PTR_ERR(trans_private);
> > > +		/* Trigger connection so that its ready for the next retry */
> > > +		if (ret == -ENODEV)
> > > +			rds_conn_connect_if_down(cp->cp_conn);
> > 
> > Hi Edward,
> > 
> > Elsewhere in this function it is assumed that cp may be NULL.
> > Does that need to be taken into account here too?
> Don't worry about this, if it is NULL, the get_mr() return value will not be -ENODEV.

Thanks, understood.

