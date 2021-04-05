Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E334B35488F
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 00:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbhDEWPt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Apr 2021 18:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241392AbhDEWPl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Apr 2021 18:15:41 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A0BC061788
        for <linux-rdma@vger.kernel.org>; Mon,  5 Apr 2021 15:15:34 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id j1so2819480qvp.6
        for <linux-rdma@vger.kernel.org>; Mon, 05 Apr 2021 15:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rchmC29ABgpAP3S8xWjnZS9TbzxCNBsLZjClrgjBsgM=;
        b=m+Vz33tChLqT7kT1xEdM19fzXbWAf7QJUb5vUXZ+xC38oFhkEN53d0E8nrLfXT1PwK
         YzNadmJe2XzEQ9Q3J4gtX7hn+FaFMXJ7lw2FNIKL1z/XCGa3VFQ2NefwV9pw8iYFO/Z9
         ToM8aDL973aHGoMVf7ODBXdXiLu11TDcwO+EtFERQuYCmHT3eeooyFRDE0Gbqhb4yuRe
         q4zgXzmVzTy5aP6/Tcnjb3V6ML2lTBvHLhDjJulEJWzWyx0D06o3zd7/jWl5EfBD4dMw
         mAmmg1LXwtk2rZ34QJpd4+Hc/EHa+/7nvXOsNfMIz5sj7b8HRD6OlOmTcSYHgTzR2PRK
         /TNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rchmC29ABgpAP3S8xWjnZS9TbzxCNBsLZjClrgjBsgM=;
        b=f+SXAHEdKaJoVXEW+ucpMcex2KqF+NYYcFbQe77gHp3fCCfKHDdneJHEOySzXFPYEb
         CQLkjwxu7++OMQqtNwe7FPSokARdFhfwygMqq2zd7naJgXw722X684cwNPB6FJCBmsIB
         3DVM6pxQQVck4YlzeNqUjz3ZeH0Xm2XyzNWN/z5oS9qac+blvpryNIaTh86cOiqBshoK
         gDLbayYA2CgYMJf5v1KZmh1ioKBU/egrgyzoA0MSiSRFCWsXuLEd8aq0kapDsTD8i/Nz
         zkGzGhV9NoFRfvIQtU8P5J31xrGku9kCefh1DkwzWSOGhznf53m71QP+0eM7n9WbRTO7
         /UWg==
X-Gm-Message-State: AOAM5335axudeVsikd5w98cS7C5PXZ37+NR0eQt9mwwuKkK5IqI2SF6N
        ICZ5IOkUD9m4E9o0dKgUD9H1Fw==
X-Google-Smtp-Source: ABdhPJxK/Q19W4wdXne0TU8yaOgE7aregCqYQmfWZpQbWqkh+/xrtUjAf3nCZmPK5vNr4L3HQ5a7Pg==
X-Received: by 2002:ad4:5ec9:: with SMTP id jm9mr25729429qvb.24.1617660934039;
        Mon, 05 Apr 2021 15:15:34 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id x14sm11584227qkn.98.2021.04.05.15.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 15:15:33 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lTXVM-000veX-6V; Mon, 05 Apr 2021 19:15:32 -0300
Date:   Mon, 5 Apr 2021 19:15:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next] RDMA/nldev: Add copy-on-fork attribute to get
 sys command
Message-ID: <20210405221532.GC7721@ziepe.ca>
References: <20210405114722.98904-1-galpress@amazon.com>
 <YGr7EajqXvSGyZfy@unreal>
 <d8ec4f81-25a6-7243-12c4-af4f5b64a27f@amazon.com>
 <YGsFHWU8Hqd5LADT@unreal>
 <9c4cda63-f4bb-2e32-d370-983c5722bd12@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c4cda63-f4bb-2e32-d370-983c5722bd12@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 05, 2021 at 04:09:39PM +0300, Gal Pressman wrote:
> On 05/04/2021 15:39, Leon Romanovsky wrote:
> > On Mon, Apr 05, 2021 at 03:15:18PM +0300, Gal Pressman wrote:
> >> On 05/04/2021 14:57, Leon Romanovsky wrote:
> >>> On Mon, Apr 05, 2021 at 02:47:21PM +0300, Gal Pressman wrote:
> >>>> The new attribute indicates that the kernel copies DMA pages on fork,
> >>>> hence libibverbs' fork support through madvise and MADV_DONTFORK is not
> >>>> needed.
> >>>>
> >>>> The introduced attribute is always reported as supported since the
> >>>> kernel has the patch that added the copy-on-fork behavior. This allows
> >>>> the userspace library to identify older vs newer kernel versions.
> >>>> Extra care should be taken when backporting this patch as it relies on
> >>>> the fact that the copy-on-fork patch is merged, hence no check for
> >>>> support is added.
> >>>
> >>> Please be more specific, add SHA-1 of that patch and wrote the same
> >>> comment near "err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK,
> >>> 1);" line.
> >>>
> >>> Thanks
> >>
> >> Should I put the original commit here? There were quite a lot of bug fixes and
> >> followups that are required.
> > 
> > IMHO, the last commit SHA will be enough, the one that has working
> > functionality from your POV.
> 
> OK, so that would be:
> 4eae4efa2c29 ("hugetlb: do early cow when page pinned on src mm")

No, lets put them all

And I'd mark them with a Fixes: and a huge comment saying not to
backport this and that the Fixes lines exist to *prevent* tooling from
wrongly backporting to kernels that cannot support this.

And email Sasha to see if there is a magic text we can add to prevent
auto backporting

> Which I now realize for-next isn't rebased on top of it yet, so these patches
> should be applied after rebasing to v5.12-rc5.

I will sort it out

Jason
