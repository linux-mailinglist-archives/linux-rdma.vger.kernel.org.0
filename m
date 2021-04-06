Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81513355700
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 16:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242305AbhDFOug (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 10:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239488AbhDFOuf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 10:50:35 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C462C06174A
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 07:50:27 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id fn8so2411985qvb.5
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 07:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Udu99LkYhmlSO/AIrZC06Ukv3zyKyNDGi0Q3e4BjWaw=;
        b=KI2q+9oNHl2xSWF9Amz6/hIcgjO6Rsh8v6lILdVQrkOhCaupqn8Rfz9ojHl23ARa7i
         CP4yAE8MeCQe+nVRUnu8HwF4SdASSh1zeeqX1tpAXegBR6qfu7VbXQ+wqyDezEOinwft
         8AWN2bxk40MFFwmssep7dWTtrSazMItiHW+ejvFPLj0r4omPq2FYPwixqlkCjQHzzmFS
         rIIlEENsaoMgNpN2KFDulFSTJUPCQr0Q6rSMFqHZMExKJPQSL/JwvxCX+FNVy+eDiM6n
         q/awocTKHu1xN3L0LJgocuW2ATUk5L4ncqIh0bazesu2tRZJXxAy9iy/kBUEn1VUM0QF
         otKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Udu99LkYhmlSO/AIrZC06Ukv3zyKyNDGi0Q3e4BjWaw=;
        b=ZuCpBI9NTHd+sG7PiC76X3TOpTffc1rbd+t/sq8zVrWLuoPiMkdIysar90/cum2+Yb
         W6xMlxG/LBEfF0+b6OIQns5ZEr35iuppWo9spz5b5TXItstl1/ZtLvIDFbNhtbwHGG1s
         dEOEQg7Ck0OqRInV5gAG/eWC+0ixaLIFmtneQHFZCa3Ro0f9q7Jx7UmDlBoOIDiXqDTi
         QoGehZBoZWJkehiJCnyctAqi5itTNK8acukah/2kYN0i1dAE7yICTOXdIx95VZMU/yAR
         029o/xCi9fm6ibsuffYDJ2oQ6ra5KDe2iy2phhzE2AFhgKkD5VO7nKSACO9vQdZhWxQ7
         W6lg==
X-Gm-Message-State: AOAM53240xowjE74TI+QImh5UMHL48Vd8mIx5nfLNc+YzUQTf5nOzmi1
        r2boc1kZ5T2QGESjHAmXBOroGQ==
X-Google-Smtp-Source: ABdhPJw7nCwHd74btqZ6io/SUz2009qH7Usgutwqh8Zrx6T7OpSTTh/C08KIM448zFIu6DNDgJCjJg==
X-Received: by 2002:a05:6214:e8f:: with SMTP id hf15mr9677971qvb.18.1617720626640;
        Tue, 06 Apr 2021 07:50:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id u21sm14937913qtq.11.2021.04.06.07.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 07:50:26 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lTn29-0019Qm-Kk; Tue, 06 Apr 2021 11:50:25 -0300
Date:   Tue, 6 Apr 2021 11:50:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Gal Pressman <galpress@amazon.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next] RDMA/nldev: Add copy-on-fork attribute to get
 sys command
Message-ID: <20210406145025.GA227011@ziepe.ca>
References: <20210405114722.98904-1-galpress@amazon.com>
 <YGr7EajqXvSGyZfy@unreal>
 <d8ec4f81-25a6-7243-12c4-af4f5b64a27f@amazon.com>
 <YGsFHWU8Hqd5LADT@unreal>
 <9c4cda63-f4bb-2e32-d370-983c5722bd12@amazon.com>
 <20210405221532.GC7721@ziepe.ca>
 <YGwDQNg3poUONNkv@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGwDQNg3poUONNkv@unreal>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 06, 2021 at 09:44:16AM +0300, Leon Romanovsky wrote:
> On Mon, Apr 05, 2021 at 07:15:32PM -0300, Jason Gunthorpe wrote:
> > On Mon, Apr 05, 2021 at 04:09:39PM +0300, Gal Pressman wrote:
> > > On 05/04/2021 15:39, Leon Romanovsky wrote:
> > > > On Mon, Apr 05, 2021 at 03:15:18PM +0300, Gal Pressman wrote:
> > > >> On 05/04/2021 14:57, Leon Romanovsky wrote:
> > > >>> On Mon, Apr 05, 2021 at 02:47:21PM +0300, Gal Pressman wrote:
> > > >>>> The new attribute indicates that the kernel copies DMA pages on fork,
> > > >>>> hence libibverbs' fork support through madvise and MADV_DONTFORK is not
> > > >>>> needed.
> > > >>>>
> > > >>>> The introduced attribute is always reported as supported since the
> > > >>>> kernel has the patch that added the copy-on-fork behavior. This allows
> > > >>>> the userspace library to identify older vs newer kernel versions.
> > > >>>> Extra care should be taken when backporting this patch as it relies on
> > > >>>> the fact that the copy-on-fork patch is merged, hence no check for
> > > >>>> support is added.
> > > >>>
> > > >>> Please be more specific, add SHA-1 of that patch and wrote the same
> > > >>> comment near "err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK,
> > > >>> 1);" line.
> > > >>>
> > > >>> Thanks
> > > >>
> > > >> Should I put the original commit here? There were quite a lot of bug fixes and
> > > >> followups that are required.
> > > > 
> > > > IMHO, the last commit SHA will be enough, the one that has working
> > > > functionality from your POV.
> > > 
> > > OK, so that would be:
> > > 4eae4efa2c29 ("hugetlb: do early cow when page pinned on src mm")
> > 
> > No, lets put them all
> 
> The more data the better chance that it will be missed.
> It is much saner to add last commit.

I don't know, there is alot of automation here we need to ensure that
none of it triggers unless all the required commits are present. I
would list all the tops of all the 'fixes' chains.

> > And email Sasha to see if there is a magic text we can add to prevent
> > auto backporting
> 
> Don't add Fixes, maybe?

Then it randomly AI matches on the commit text and we loose even the
protection of the fixes lines

Jason
