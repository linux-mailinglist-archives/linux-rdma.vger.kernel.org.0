Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A08335578C
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 17:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbhDFPTA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 11:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbhDFPTA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 11:19:00 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF115C06174A
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 08:18:50 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id g15so15314711qkl.4
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 08:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G/b70PAqbrKDzn6Wt8FjanRHLuWI8TfADKSy5ywtY2A=;
        b=D74g8bAGxCooSUzMq4HvZOTm9DxzI6W+QVj0hTgzO0+q9yw2ObqKaQOCD7pfgGDcNW
         hTGpAe67ToiEeulAqAjvXnJxQRrk7aXjbgd7ldeL2c79uLNs0vqtPuaOYYO5NdVcDKaM
         5ET1NJwd5/hK5Jxb/xnNhSBSu1DPme2WIj7x38EVYuZvp2F21Kp768i7hL1n0OHN2v4i
         JurIzZ0k/xPG70zY4Wj13VHgR0+MRwek7odfbdhkxJm9a1oGm3s7Bv0KJeNYuOA0fowH
         kFmJ9iKAPQkIQo7Qa7vWz0UdGapqnCXRhOdAWOtpJCM85w4JOawm0Zm4WtjLKLQ5lRXm
         6PeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G/b70PAqbrKDzn6Wt8FjanRHLuWI8TfADKSy5ywtY2A=;
        b=GP1R4l7lSOZu3IRdtetwdgfHMJ68suSq+qlzPTMPcuhWQ20iV9RXz6QWihlXY6gJ6A
         HbLN7YfeDZ31A/ISCSPOAOJs/OwNkO6exMpsCmcUg4Hog6LZOvmPIcmhkEMX9PvkTbJe
         ObGm1qEuayupmLq72WxhjDBOorGqAoAlWWi578XRCYj8OKqW/O4oEBhwNSQgcaSshOQK
         w0CipZPIybQvNCGFTShC79vLbmCktOkNZkxz9jM8F/DBjRywUnLm3X5yYaOly5vXxz3I
         HMrQFf99vSZKQFYFaPnNpXU8QTIHUPv3p07RojK/BglWrBL7DSwPS+kLXU/1mcsXi8Zc
         0FfA==
X-Gm-Message-State: AOAM5301MU65Jv0KNW3SpzTPt0G2XV60Do8sviiIUspnvsPMaN8JAx9u
        1180uckkkfkX4npASwdSgXlP5w==
X-Google-Smtp-Source: ABdhPJx9FOGyqaLt2DgfD/MNeTITFAdBZLfTpUblxDOjP7+nyYZ8aA5qb4Q6BPS8qQSQiivjXR5rew==
X-Received: by 2002:a37:44e:: with SMTP id 75mr29518218qke.150.1617722329547;
        Tue, 06 Apr 2021 08:18:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id a138sm16148272qkg.29.2021.04.06.08.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 08:18:48 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lTnTc-001AAH-9Y; Tue, 06 Apr 2021 12:18:48 -0300
Date:   Tue, 6 Apr 2021 12:18:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next] RDMA/nldev: Add copy-on-fork attribute to get
 sys command
Message-ID: <20210406151848.GB227011@ziepe.ca>
References: <20210405114722.98904-1-galpress@amazon.com>
 <YGr7EajqXvSGyZfy@unreal>
 <d8ec4f81-25a6-7243-12c4-af4f5b64a27f@amazon.com>
 <YGsFHWU8Hqd5LADT@unreal>
 <9c4cda63-f4bb-2e32-d370-983c5722bd12@amazon.com>
 <20210405221532.GC7721@ziepe.ca>
 <YGwDQNg3poUONNkv@unreal>
 <59404383-87bd-aeb9-0816-d0846c4b4862@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59404383-87bd-aeb9-0816-d0846c4b4862@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 06, 2021 at 05:31:38PM +0300, Gal Pressman wrote:
> On 06/04/2021 9:44, Leon Romanovsky wrote:
> > On Mon, Apr 05, 2021 at 07:15:32PM -0300, Jason Gunthorpe wrote:
> >> On Mon, Apr 05, 2021 at 04:09:39PM +0300, Gal Pressman wrote:
> >>> On 05/04/2021 15:39, Leon Romanovsky wrote:
> >>>> On Mon, Apr 05, 2021 at 03:15:18PM +0300, Gal Pressman wrote:
> >>>>> On 05/04/2021 14:57, Leon Romanovsky wrote:
> >>>>>> On Mon, Apr 05, 2021 at 02:47:21PM +0300, Gal Pressman wrote:
> >>>>>>> The new attribute indicates that the kernel copies DMA pages on fork,
> >>>>>>> hence libibverbs' fork support through madvise and MADV_DONTFORK is not
> >>>>>>> needed.
> >>>>>>>
> >>>>>>> The introduced attribute is always reported as supported since the
> >>>>>>> kernel has the patch that added the copy-on-fork behavior. This allows
> >>>>>>> the userspace library to identify older vs newer kernel versions.
> >>>>>>> Extra care should be taken when backporting this patch as it relies on
> >>>>>>> the fact that the copy-on-fork patch is merged, hence no check for
> >>>>>>> support is added.
> >>>>>>
> >>>>>> Please be more specific, add SHA-1 of that patch and wrote the same
> >>>>>> comment near "err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK,
> >>>>>> 1);" line.
> >>>>>>
> >>>>>> Thanks
> >>>>>
> >>>>> Should I put the original commit here? There were quite a lot of bug fixes and
> >>>>> followups that are required.
> >>>>
> >>>> IMHO, the last commit SHA will be enough, the one that has working
> >>>> functionality from your POV.
> >>>
> >>> OK, so that would be:
> >>> 4eae4efa2c29 ("hugetlb: do early cow when page pinned on src mm")
> >>
> >> No, lets put them all
> > 
> > The more data the better chance that it will be missed.
> > It is much saner to add last commit.
> 
> I can gather a list of commits, but I'm not sure I'm aware of every single
> commit that's needed to make this work properly, there's a chance some will be
> missed.

I think it is just the two groups from Peter Xu

Jason
