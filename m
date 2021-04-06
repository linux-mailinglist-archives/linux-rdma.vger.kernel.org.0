Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0D9354D14
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 08:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237484AbhDFGo2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 02:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237387AbhDFGo1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Apr 2021 02:44:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B749F6136A;
        Tue,  6 Apr 2021 06:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617691460;
        bh=eS/qyh+aXP/iR02eDRU5U4TRmTcncs6V+T1jG5leuOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJbwaK+7FkacyLhrxfvHf3iSUKtHdy1+RRslUzN8ktqxTextUHMGQRirDnNzc4CnP
         aHi4oqsUbLnrVw2I6byP7eS5+YwSG72kDVnB1XbL9qXeHhBy+6qvCvmlja4Xuv1VEl
         b7v73B30Vd8PJHog1q7s07NFSEyOyt5KhU1J4kgS3cecsEq6lX1oDwoWlIPfNykmpW
         MKAiQylPBxxjSzKAe6NKwFWgdkbrHGwnFGcWrJQ9f8E90aJgzAD7B+auU3MVl4PKKI
         QEYJxNWImhMYD8Egxt8Ylvhi9cQiapeUkhb8N7C8pHFBMq5xyIdfLPoggaSxWGByj9
         JDvDuXsg9502g==
Date:   Tue, 6 Apr 2021 09:44:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Gal Pressman <galpress@amazon.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next] RDMA/nldev: Add copy-on-fork attribute to get
 sys command
Message-ID: <YGwDQNg3poUONNkv@unreal>
References: <20210405114722.98904-1-galpress@amazon.com>
 <YGr7EajqXvSGyZfy@unreal>
 <d8ec4f81-25a6-7243-12c4-af4f5b64a27f@amazon.com>
 <YGsFHWU8Hqd5LADT@unreal>
 <9c4cda63-f4bb-2e32-d370-983c5722bd12@amazon.com>
 <20210405221532.GC7721@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405221532.GC7721@ziepe.ca>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 05, 2021 at 07:15:32PM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 05, 2021 at 04:09:39PM +0300, Gal Pressman wrote:
> > On 05/04/2021 15:39, Leon Romanovsky wrote:
> > > On Mon, Apr 05, 2021 at 03:15:18PM +0300, Gal Pressman wrote:
> > >> On 05/04/2021 14:57, Leon Romanovsky wrote:
> > >>> On Mon, Apr 05, 2021 at 02:47:21PM +0300, Gal Pressman wrote:
> > >>>> The new attribute indicates that the kernel copies DMA pages on fork,
> > >>>> hence libibverbs' fork support through madvise and MADV_DONTFORK is not
> > >>>> needed.
> > >>>>
> > >>>> The introduced attribute is always reported as supported since the
> > >>>> kernel has the patch that added the copy-on-fork behavior. This allows
> > >>>> the userspace library to identify older vs newer kernel versions.
> > >>>> Extra care should be taken when backporting this patch as it relies on
> > >>>> the fact that the copy-on-fork patch is merged, hence no check for
> > >>>> support is added.
> > >>>
> > >>> Please be more specific, add SHA-1 of that patch and wrote the same
> > >>> comment near "err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK,
> > >>> 1);" line.
> > >>>
> > >>> Thanks
> > >>
> > >> Should I put the original commit here? There were quite a lot of bug fixes and
> > >> followups that are required.
> > > 
> > > IMHO, the last commit SHA will be enough, the one that has working
> > > functionality from your POV.
> > 
> > OK, so that would be:
> > 4eae4efa2c29 ("hugetlb: do early cow when page pinned on src mm")
> 
> No, lets put them all

The more data the better chance that it will be missed.
It is much saner to add last commit.

> 
> And I'd mark them with a Fixes: and a huge comment saying not to
> backport this and that the Fixes lines exist to *prevent* tooling from
> wrongly backporting to kernels that cannot support this.
> 
> And email Sasha to see if there is a magic text we can add to prevent
> auto backporting

Don't add Fixes, maybe?


> 
> > Which I now realize for-next isn't rebased on top of it yet, so these patches
> > should be applied after rebasing to v5.12-rc5.
> 
> I will sort it out
> 
> Jason
