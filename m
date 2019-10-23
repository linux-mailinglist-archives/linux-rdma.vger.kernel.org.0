Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 202ABE155C
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 11:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390367AbfJWJJE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 05:09:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39281 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390802AbfJWJJE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 05:09:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id a11so5092616wra.6
        for <linux-rdma@vger.kernel.org>; Wed, 23 Oct 2019 02:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=I3CdxrHaNyHyRZEG1FuNTtm7TdLvAqPyeGgl25NH314=;
        b=MOj/ylauwCVvu9XlWustyHzaSLBCLB0r8SxcpbGt/WNTTA+W3Eilry/hQ3LwrBxwyx
         gPOiRymXCK2dsCqO5dOhpdZklU2lV9U4UJv9kLSbljZH7tQDvZUYhNl9OO0bjpWmAYUq
         m7WRQS+woMs4MAqmlMSC3ZrjaNArF8FIbkVWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=I3CdxrHaNyHyRZEG1FuNTtm7TdLvAqPyeGgl25NH314=;
        b=ZgLP/xsPakIQtrcBjtbskR2uBPM8tjxSgG/yRPr7u2jcNDQ8qfkHZ+KcE1Kiauz+QY
         du03LEmXK39Dk5WW53u2z1c+Fqn1nkgYMUqLFM83pkBra+uXJVQ81oyg18FL9Fah/XDu
         B6J6SizUngJP/oru64yzYZpL5lkZOkbRkZsF6wMVHaSL2Dp6BXGqE+5JvGzYmIDUueZb
         thgdfUaqKQdBP90lTqTY7z7RWfHoSR5SuXHFVPK2PIcybF/lv37YbrB9kfAXquT7iSuF
         YK9VjaA+52DvV/nbpbShJq5Rt02oEFXmwEMIlkpC7lkusCZJ3KlA5dDkTp9VHVxSZoCI
         h1lQ==
X-Gm-Message-State: APjAAAXdwwSv4OaUPpxRuA45GPG5qS5EfOSzH8qmUeTr//zWmCcVbmjA
        Ikbra3HpR3Rg/CAJYVYFLd8jMw==
X-Google-Smtp-Source: APXvYqxBlWiMbV68z/4WCdyBIn/eYixlaxzfRL2TT2uj5JcOqKaRJpFzViyC4G1k4Zqgafht+vBoZw==
X-Received: by 2002:adf:f192:: with SMTP id h18mr7782727wro.148.1571821741491;
        Wed, 23 Oct 2019 02:09:01 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id a189sm7456296wma.2.2019.10.23.02.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 02:09:00 -0700 (PDT)
Date:   Wed, 23 Oct 2019 11:08:58 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Yang, Philip" <Philip.Yang@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
Message-ID: <20191023090858.GV11828@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@mellanox.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Yang, Philip" <Philip.Yang@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
References: <2df298e2-ee91-ef40-5da9-2bc1af3a17be@gmail.com>
 <2046e0b4-ba05-0683-5804-e9bbf903658d@amd.com>
 <d6bcbd2a-2519-8945-eaf5-4f4e738c7fa9@amd.com>
 <20191018203608.GA5670@mellanox.com>
 <f7e34d8f-f3b0-b86d-7388-1f791674a4a9@amd.com>
 <20191021135744.GA25164@mellanox.com>
 <e07092c3-8ccd-9814-835c-6c462017aff8@amd.com>
 <20191021151221.GC25164@mellanox.com>
 <20191022075735.GV11828@phenom.ffwll.local>
 <20191022150109.GF22766@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022150109.GF22766@mellanox.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 22, 2019 at 03:01:13PM +0000, Jason Gunthorpe wrote:
> On Tue, Oct 22, 2019 at 09:57:35AM +0200, Daniel Vetter wrote:
> 
> > > The unusual bit in all of this is using a lock's critical region to
> > > 'protect' data for read, but updating that same data before the lock's
> > > critical secion. ie relying on the unlock barrier to 'release' program
> > > ordered stores done before the lock's own critical region, and the
> > > lock side barrier to 'acquire' those stores.
> > 
> > I think this unusual use of locks as barriers for other unlocked accesses
> > deserves comments even more than just normal barriers. Can you pls add
> > them? I think the design seeems sound ...
> > 
> > Also the comment on the driver's lock hopefully prevents driver
> > maintainers from moving the driver_lock around in a way that would very
> > subtle break the scheme, so I think having the acquire barrier commented
> > in each place would be really good.
> 
> There is already a lot of documentation, I think it would be helpful
> if you could suggest some specific places where you think an addition
> would help? I think the perspective of someone less familiar with this
> design would really improve the documentation

Hm I just meant the usual recommendation that "barriers must have comments
explaining what they order, and where the other side of the barrier is".
Using unlock/lock as a barrier imo just makes that an even better idea.
Usually what I do is something like "we need to order $this against $that
below, and the other side of this barrier is in function()." With maybe a
bit more if it's not obvious how things go wrong if the orderin is broken.

Ofc seqlock.h itself skimps on that rule and doesn't bother explaining its
barriers :-/

> I've been tempted to force the driver to store the seq number directly
> under the driver lock - this makes the scheme much clearer, ie
> something like this:
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index 712c99918551bc..738fa670dcfb19 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -488,7 +488,8 @@ struct svm_notifier {
>  };
>  
>  static bool nouveau_svm_range_invalidate(struct mmu_range_notifier *mrn,
> -                                        const struct mmu_notifier_range *range)
> +                                        const struct mmu_notifier_range *range,
> +                                        unsigned long seq)
>  {
>         struct svm_notifier *sn =
>                 container_of(mrn, struct svm_notifier, notifier);
> @@ -504,6 +505,7 @@ static bool nouveau_svm_range_invalidate(struct mmu_range_notifier *mrn,
>                 mutex_lock(&sn->svmm->mutex);
>         else if (!mutex_trylock(&sn->svmm->mutex))
>                 return false;
> +       mmu_range_notifier_update_seq(mrn, seq);
>         mutex_unlock(&sn->svmm->mutex);
>         return true;
>  }
> 
> 
> At the cost of making the driver a bit more complex, what do you
> think?

Hm, spinning this further ... could we initialize the mmu range notifier
with a pointer to the driver lock, so that we could put a
lockdep_assert_held into mmu_range_notifier_update_seq? I think that would
make this scheme substantially more driver-hacker proof :-)

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
