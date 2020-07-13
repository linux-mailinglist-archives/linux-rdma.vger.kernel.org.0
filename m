Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F186021D197
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2020 10:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgGMIWI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Jul 2020 04:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgGMIWI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Jul 2020 04:22:08 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A4CC061755
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2020 01:22:08 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so12414384wmi.3
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2020 01:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FPD/zFisBkLfnD2TVhTW80eadaDRnskkbPfzWMd9aZg=;
        b=YvuK75iQc97K0fl38g7tXHK+Gyym/I3Jkpe45vTyCAE7INcLo8gqiAcH1eyWZadcn7
         v2ujhBwyL9LuY4uDZkYR7f7JTxribnnD+4riXO2vPIQbHYFZOYFj7gjeCc6EpY63JDOW
         ASK0nOGrSaf6lNDOd8OV4j+IKmdqyqBtCkig6tnvGTAKD82skkH1oTbzbWLkUOyIksEh
         SwoM7iD8AwyLqvOKoRyjU6SMvP8/wnBi03MgKq8seYcAXzzCeA0xUwmchEMV6ajHZAlP
         rr+q728Wd2mbfPEByskEgDLPxY2muGK9WPFnL4CfyTHlppMW4npr/I/SfKJ0iTrbm1mx
         kHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FPD/zFisBkLfnD2TVhTW80eadaDRnskkbPfzWMd9aZg=;
        b=tsTxMdbXjjdAfJwvwFBvAGXnHZRKMzXdgBobPKB0mZAbVUF+QL5pxeedYxtzK3eTl3
         22/tps79zRLyD73Zo8VwITeESl4Ja/r1P1gABFfG+E7z1schEoP4uJ15CT6cyHijNKSJ
         53uRS9zr5ygeftIoMrRo7jqGXqZVA/Nrw7E4OXCWXgtZU64Om8CQpeKeAJthy4DdX94D
         oS/foURslUu0fgATQ49JbgVGBylhsOdAbxk1dlaE1pZjPRNJzmClAN6TegUkEYvKtUee
         WgRFYvMpbCAp+mkzwIRrbQvlak0Jj+DJc6C0dmhPwEVOEYxYTuqjinkxI4DDw4HEaz14
         UpcA==
X-Gm-Message-State: AOAM53012DG/ny8cS6BXUT0abZB+gVF5HyzkCaqtqQ0y1jJomWK+V3Wa
        dyBKabMPlHrsH73ywtLSOks=
X-Google-Smtp-Source: ABdhPJxy4LMBril0J41w4R5Lq7DjQh9CWbuQ3qPiNHKGDhy4IT2ECnlCIAIMiAwW2sCTp7/NQv66Dg==
X-Received: by 2002:a1c:28c4:: with SMTP id o187mr17004243wmo.62.1594628526867;
        Mon, 13 Jul 2020 01:22:06 -0700 (PDT)
Received: from kheib-workstation ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id i6sm11212880wrp.92.2020.07.13.01.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 01:22:06 -0700 (PDT)
Date:   Mon, 13 Jul 2020 11:22:03 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-rc v1 0/4] RDMA/providers: Set max_pkey attribute
Message-ID: <20200713082203.GA793133@kheib-workstation>
References: <20200706091119.367697-1-kamalheib1@gmail.com>
 <20200707161247.GA1375440@nvidia.com>
 <20200707191324.GA463589@kheib-workstation>
 <20200708232815.GP23676@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708232815.GP23676@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 08, 2020 at 08:28:15PM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 07, 2020 at 10:13:24PM +0300, Kamal Heib wrote:
> > On Tue, Jul 07, 2020 at 01:12:47PM -0300, Jason Gunthorpe wrote:
> > > On Mon, Jul 06, 2020 at 12:11:15PM +0300, Kamal Heib wrote:
> > > > This patch set makes sure to set the max_pkeys attribute to the providers
> > > > that aren't setting it or not setting it correctly.
> > > > 
> > > > v1: Drop the efa patch and target for-rc.
> > > > 
> > > > Kamal Heib (4):
> > > >   RDMA/siw: Set max_pkeys attribute
> > > >   RDMA/cxgb4: Set max_pkeys attribute
> > > >   RDMA/i40iw: Set max_pkeys attribute
> > > >   RDMA/usnic: Fix reported max_pkeys attribute
> > > 
> > > Why should iwarp have a 1 pkey value?
> > > 
> > > Jason
> > 
> > That is a good question :-)
> > 
> > My Idea in this patchset was to match between the reported pkey_tbl_len and
> > the max_pkeys attribute that the providers expose.
> > 
> > But after taking a deeper look now, I see that the RDMA core requires
> > from all providers to implement the query_pkey() callback, which before
> > [1] commit that will cause the provider driver not to load. For IB
> > providers the requirement make sense, also for RoCE providers, because
> > there is a requirement by the RoCE Spec to support the default PKey, For
> > iwarp providers, This doesn't make sense and I think that they decided to
> > do the same as RoCE and to avoid the driver load failure.
> > 
> > Probably, The requirement from the RDMA core needs to be changed and
> > the query_pkey() callback needs to be removed from the iwarp providers,
> > Thoughts?
> 
> Sure
> 
> But then the pkey table size is 0 right?
>

Correct, also there are required changes in the RDMA core:
1- Avoid exposing the pkeys sysfs entries for the iwarp providers.
2- Avoid allocating the pkey cache for the iwarp providers.

I've started this work and I hope to post patches in the upcoming days.

Thanks,
Kamal

> Jason
