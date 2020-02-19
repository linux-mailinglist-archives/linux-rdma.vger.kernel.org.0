Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6E90163D6A
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 08:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgBSHLe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 02:11:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:49340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgBSHLe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Feb 2020 02:11:34 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9250A208C4;
        Wed, 19 Feb 2020 07:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582096294;
        bh=oDjE/RBeAB2w4AAck4+ZQfqyryDBYOG5f7XbNx05Hm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Np0Dz+34A0rtTMJUs6yUZi0wRoEGRPbmqqyhOIN/CC9wcjBQ8lay6lBAhY4GUg2ms
         7Be42kDo3LX9kHnIDN0AzvdFexYfYG3JXJuGVEuCYSf8mpWQ+uoTOtD36kr4SVwS4S
         4IXpnzi6lPYWDCoImdKk6f0mjw4/DCxKu8NQYr5Q=
Date:   Wed, 19 Feb 2020 09:11:29 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Honggang LI <honli@redhat.com>,
        Gal Pressman <galpress@amazon.com>
Subject: Re: RDMA device renames and node description
Message-ID: <20200219071129.GD15239@unreal>
References: <5ae69feb-5543-b203-2f1b-df5fe3bdab2b@intel.com>
 <20200218140444.GB8816@unreal>
 <1fcc873b-3f67-2325-99cc-21d90edd2058@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fcc873b-3f67-2325-99cc-21d90edd2058@intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 18, 2020 at 12:11:47PM -0500, Dennis Dalessandro wrote:
> On 2/18/2020 9:04 AM, Leon Romanovsky wrote:
> > On Fri, Feb 14, 2020 at 01:13:53PM -0500, Dennis Dalessandro wrote:
> > > Was there any discussion on the upgrade scenario for existing deployments as
> > > far as device-rename changing node descriptions?
> > >
> > > If someone is running an older version of rdma-core they are going to have a
> > > certain set of node descriptions for each node. This could be in logs, or
> > > configuration databases, who knows what. Now if they upgrade to a new
> > > version of rdma-core their node descriptions all automatically change out
> > > from under them by default.
> > >
> > > Of course the admin could disable the rename prior to upgrade and as Leon
> > > pointed out previously the upgrade won't remove the disablement file. The
> > > problem is they would have to know to do that ahead of time.
> >
> > Dennis,
> >
> > It was discussed and the conclusion was that most if not all users are
> > using one of two upgrade and strategy.
>
> Do you have a pointer to a thread I can read, I apparently missed it?

First, we started to talk about it even before patches were sent.
See this summary from LPC 2017:
 * the sysadmin will be able to disable this for "backward support"
https://lore.kernel.org/linux-rdma/20170917125603.GA5788@mtr-leonro.local/
Second, during the submission too, just need to continue to google it :)

>
> > First option is to rely on distro and every distro behaves differently
> > in such cases, some of them won't change anything till their last user
> > dies :) and others more dynamic with more up-to-date packages already
> > adopted our default.
>
> This is the issue I see. The problem is when the distro doesn't know any
> better and pulls in a new rdma-core and breaks things unintentionally. Up to
> date is good, but up to date that brings with it what is essentially an ABI
> breakage is not.

ABI breakage is a strong word, luckily enough it is not defined at all.
We never considered dmesg prints, device names, device ordering as an
ABI. You can't rely on debug features too, they can disappear too.

So the bottom line, the expectation that distro should fix all broken
software before enabling device renaming and their bugs are not excuse
to declare ABI breakage.

>
> > Second option is to use numerous OFED stacks, which are expected to
> > provide full upgrade to all components which will work smoothly.
>
> Yeah I'm sure OFED will handle things for themselves.

At the end, OFED stacks behave like "mini-distros", so if they manage to
handle it, distro should do the same.

Thanks
