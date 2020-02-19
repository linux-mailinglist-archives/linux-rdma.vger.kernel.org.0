Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D18B1647E8
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 16:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgBSPKZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 10:10:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:33206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbgBSPKY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Feb 2020 10:10:24 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E2CB24670;
        Wed, 19 Feb 2020 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582125024;
        bh=xLL278GIyij/GkvhFTHaCaGNDPurHFnFXUIIkxthb0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DrphVWCvF4RrhgBGgw4AJTbOpgkathfN6FxsOB3SrPmTmBVZAdUOCC9aFTVx7t25V
         vGnPtNioFY9+sHN83TANls0oIqnfqfL+anFg3Zja7Rdbjl+xXji+N8yWKsdTyeEchq
         81WUuG7FLJdtTvoONVAZ3q1u1BzPEgQpRfnf8D1A=
Date:   Wed, 19 Feb 2020 17:10:19 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Honggang LI <honli@redhat.com>
Subject: Re: RDMA device renames and node description
Message-ID: <20200219151019.GN15239@unreal>
References: <5ae69feb-5543-b203-2f1b-df5fe3bdab2b@intel.com>
 <20200218140444.GB8816@unreal>
 <1fcc873b-3f67-2325-99cc-21d90edd2058@intel.com>
 <20200219071129.GD15239@unreal>
 <bea50739-918b-ae6f-5fac-f5642c56f1da@intel.com>
 <67915d24-149a-e940-1f0b-a173eb4aca84@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67915d24-149a-e940-1f0b-a173eb4aca84@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 19, 2020 at 04:35:40PM +0200, Gal Pressman wrote:
> On 19/02/2020 16:14, Dennis Dalessandro wrote:
> > On 2/19/2020 2:11 AM, Leon Romanovsky wrote:
> >> On Tue, Feb 18, 2020 at 12:11:47PM -0500, Dennis Dalessandro wrote:
> >>> On 2/18/2020 9:04 AM, Leon Romanovsky wrote:
> >>>> On Fri, Feb 14, 2020 at 01:13:53PM -0500, Dennis Dalessandro wrote:
> >> ABI breakage is a strong word, luckily enough it is not defined at all.
> >> We never considered dmesg prints, device names, device ordering as an
> >> ABI. You can't rely on debug features too, they can disappear too.
> >
> > Agree, it is a strong word and we can call it what you want. The point is you
> > should be able to rely on the node description not being changed out from under
> > you unnecessarily though. We aren't talking about a debug feature here but a
> > core feature to real world deployments.
> >
> > Could you envision a patch to a user space library that just changes a devices
> > hostname to something that was HW specific because it makes scripting easier? I
> > contend that in some cases the node description remaining constant is just as
> > important.
> >
> >> So the bottom line, the expectation that distro should fix all broken
> >> software before enabling device renaming and their bugs are not excuse
> >> to declare ABI breakage.
> >
> > Again, call it what you want, but you can't deny this change to force the rename
> > by default has not broken things. For the record I'm not even talking about PSM2
> > here. There are other, more far reaching implications.
>
> It's not just PSM2, it broke our libfabric provider and apparently MVAPICH as well:
> http://mailman.cse.ohio-state.edu/pipermail/mvapich-discuss/2020-January/006960.html
>
> Regarding the issue you described, why not disable the rename on the upgrade
> path and only enable it for fresh installations?

Good suggestion, at least in theory, it can be done for the RPMs. Just
need to be careful to distinguish upgrades from pre-v24 versions and
post-v24 versions.

Thanks
