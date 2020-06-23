Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F466206707
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2020 00:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387725AbgFWWNh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 18:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388171AbgFWWNg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jun 2020 18:13:36 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4C2C061755
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jun 2020 15:13:35 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m2so18281085otr.12
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jun 2020 15:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0ZGDNOSDA1Ta3hgcxRzaAOGyEheiE8Jvv+zjE+Mj6/w=;
        b=fI6rkREdBOXiWQhJfInIzRJF7zpcxrfUpkbR7wS6uFp1jIy/srpIpWCY2qhR8SlvJM
         E9xvsRSEuDYKViPPM35jShY2ry/XhUUMfYpJa9F42ZAf+3HnD68PPN/LWw0vhxeX+umr
         qEMqwgKep73f2cLlFdLlz3jj8N3/5WFnj0bpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0ZGDNOSDA1Ta3hgcxRzaAOGyEheiE8Jvv+zjE+Mj6/w=;
        b=QtmNsvEVSpjam7wrdYqWxbkVSYtu83Tp+DxUMlqNUKoP1/Ert1fM+kNHWBvuZZQMWf
         xPyWax3golN8emGjRE9VvJoiBc4OU5GzcwK85caRdK+JyUymKKlIcAn4JiPxsrLzDjtv
         x2Bwm2zlHHTs1Vkvn/T1kJhRAbYw2XzJXg+MbdGUvAz7TO6XIsdx+h7n7ePOQGjzRDa2
         vs+dytXpk0okV7JRQuUSZZG5Afdfnugae9C5BeFphQooDIgrTVQlAckXaQSEPICbOk57
         9xRs5THGE7fvKxcstJc/mZFu3figvsW1YHyvlZePF/doUe/tbZsmLZQlzpzYSDEWwlA1
         A8lQ==
X-Gm-Message-State: AOAM530whszExmpQ5klYSJH6wonncAJ3ofRn9zpHvjnJN3QyXB/prGd/
        EjALKEHyj1w09K/KrfHeOyH+YLPuhDy99F+PPXCvbg==
X-Google-Smtp-Source: ABdhPJwPmQOfovNfpWZFRMIarIw+GC3JzL8nOeU25adQ547Jc0j/YgtfLS4GnLCbiFY0QLcY9IzMa6Nlpo7Cz+8cT/8=
X-Received: by 2002:a05:6830:2017:: with SMTP id e23mr12956621otp.303.1592950414566;
 Tue, 23 Jun 2020 15:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200604081224.863494-2-daniel.vetter@ffwll.ch>
 <20200610194101.1668038-1-daniel.vetter@ffwll.ch> <20200621174205.GB1398@lca.pw>
 <CAKMK7uFZAFVmceoYvqPovOifGw_Y8Ey-OMy6wioMjwPWhu9dDg@mail.gmail.com>
 <20200621200103.GV20149@phenom.ffwll.local> <20200623161754.GA1140@lca.pw>
In-Reply-To: <20200623161754.GA1140@lca.pw>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 24 Jun 2020 00:13:23 +0200
Message-ID: <CAKMK7uH90-k12KMHE0pWN6G_aCTr=YNhQsqoaAJC5FHygnf96g@mail.gmail.com>
Subject: Re: [PATCH] mm: Track mmu notifiers in fs_reclaim_acquire/release
To:     Qian Cai <cai@lca.pw>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 23, 2020 at 6:18 PM Qian Cai <cai@lca.pw> wrote:
>
> On Sun, Jun 21, 2020 at 10:01:03PM +0200, Daniel Vetter wrote:
> > On Sun, Jun 21, 2020 at 08:07:08PM +0200, Daniel Vetter wrote:
> > > On Sun, Jun 21, 2020 at 7:42 PM Qian Cai <cai@lca.pw> wrote:
> > > >
> > > > On Wed, Jun 10, 2020 at 09:41:01PM +0200, Daniel Vetter wrote:
> > > > > fs_reclaim_acquire/release nicely catch recursion issues when
> > > > > allocating GFP_KERNEL memory against shrinkers (which gpu drivers=
 tend
> > > > > to use to keep the excessive caches in check). For mmu notifier
> > > > > recursions we do have lockdep annotations since 23b68395c7c7
> > > > > ("mm/mmu_notifiers: add a lockdep map for invalidate_range_start/=
end").
> > > > >
> > > > > But these only fire if a path actually results in some pte
> > > > > invalidation - for most small allocations that's very rarely the =
case.
> > > > > The other trouble is that pte invalidation can happen any time wh=
en
> > > > > __GFP_RECLAIM is set. Which means only really GFP_ATOMIC is a saf=
e
> > > > > choice, GFP_NOIO isn't good enough to avoid potential mmu notifie=
r
> > > > > recursion.
> > > > >
> > > > > I was pondering whether we should just do the general annotation,=
 but
> > > > > there's always the risk for false positives. Plus I'm assuming th=
at
> > > > > the core fs and io code is a lot better reviewed and tested than
> > > > > random mmu notifier code in drivers. Hence why I decide to only
> > > > > annotate for that specific case.
> > > > >
> > > > > Furthermore even if we'd create a lockdep map for direct reclaim,=
 we'd
> > > > > still need to explicit pull in the mmu notifier map - there's a l=
ot
> > > > > more places that do pte invalidation than just direct reclaim, th=
ese
> > > > > two contexts arent the same.
> > > > >
> > > > > Note that the mmu notifiers needing their own independent lockdep=
 map
> > > > > is also the reason we can't hold them from fs_reclaim_acquire to
> > > > > fs_reclaim_release - it would nest with the acquistion in the pte
> > > > > invalidation code, causing a lockdep splat. And we can't remove t=
he
> > > > > annotations from pte invalidation and all the other places since
> > > > > they're called from many other places than page reclaim. Hence we=
 can
> > > > > only do the equivalent of might_lock, but on the raw lockdep map.
> > > > >
> > > > > With this we can also remove the lockdep priming added in 66204f1=
d2d1b
> > > > > ("mm/mmu_notifiers: prime lockdep") since the new annotations are
> > > > > strictly more powerful.
> > > > >
> > > > > v2: Review from Thomas Hellstrom:
> > > > > - unbotch the fs_reclaim context check, I accidentally inverted i=
t,
> > > > >   but it didn't blow up because I inverted it immediately
> > > > > - fix compiling for !CONFIG_MMU_NOTIFIER
> > > > >
> > > > > Cc: Thomas Hellstr=C3=B6m (Intel) <thomas_os@shipmail.org>
> > > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > > > > Cc: linux-mm@kvack.org
> > > > > Cc: linux-rdma@vger.kernel.org
> > > > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > > >
> > > > Replying the right patch here...
> > > >
> > > > Reverting this commit [1] fixed the lockdep warning below while app=
lying
> > > > some memory pressure.
> > > >
> > > > [1] linux-next cbf7c9d86d75 ("mm: track mmu notifiers in fs_reclaim=
_acquire/release")
> > >
> > > Hm, then I'm confused because
> > > - there's not mmut notifier lockdep map in the splat at a..
> > > - the patch is supposed to not change anything for fs_reclaim (but th=
e
> > > interim version got that wrong)
> > > - looking at the paths it's kmalloc vs kswapd, both places I totally
> > > expect fs_reflaim to be used.
> > >
> > > But you're claiming reverting this prevents the lockdep splat. If
> > > that's right, then my reasoning above is broken somewhere. Someone
> > > less blind than me having an idea?
> > >
> > > Aside this is the first email I've typed, until I realized the first
> > > report was against the broken patch and that looked like a much more
> > > reasonable explanation (but didn't quite match up with the code
> > > paths).
> >
> > Below diff should undo the functional change in my patch. Can you pls t=
est
> > whether the lockdep splat is really gone with that? Might need a lot of
> > testing and memory pressure to be sure, since all these reclaim paths
> > aren't very deterministic.
>
> No, this patch does not help but reverting the whole patch still fixed
> the splat.

Ok I tested this. I can't use your script to repro because
- I don't have a setup with xfs, and the splat points at an issue in xfs
- reproducing lockdep splats in shrinker callbacks is always a bit tricky

So instead I made a quick test to validate whether the fs_reclaim
annotations work correctly, and nothing has changed:

+       printk("GFP_NOFS block\n");
+       fs_reclaim_acquire(GFP_NOFS);
+       printk("allocate atomic\n");
+       kfree(kmalloc(16, GFP_ATOMIC));
+       printk("allocate noio\n");
+       kfree(kmalloc(16, GFP_NOIO));

The below two calls to kmalloc are wrong, but the current annotations
don't track __GFP_IO and other levels, only __GFP_FS. So no lockdep
splats here.

+       printk("allocate nofs\n");
+       kfree(kmalloc(16, GFP_NOFS));
+       printk("allocate kernel\n");
+       kfree(kmalloc(16, GFP_KERNEL));
+       fs_reclaim_release(GFP_NOFS);
+
+
+       printk("GFP_KERNEL block\n");
+       fs_reclaim_acquire(GFP_KERNEL);
+       printk("allocate atomic\n");
+       kfree(kmalloc(16, GFP_ATOMIC));
+       printk("allocate noio\n");
+       kfree(kmalloc(16, GFP_NOIO));
+       printk("allocate nofs\n");
+       kfree(kmalloc(16, GFP_NOFS));

This allocation is buggy, and should splat. This is the case for both
with my patch, and with my patch reverted.

+       printk("allocate kernel\n");
+       kfree(kmalloc(16, GFP_KERNEL));
+       fs_reclaim_release(GFP_KERNEL);

I also looked at the paths in your lockdep splat in xfs, this is
simply GFP_KERNEL vs a shrinker reclaim in kswapd.

Summary: Everything is working as expected, there's no change in the
lockdep annotations.

I really think the problem is that either your testcase doesn't hit
the issue reliably enough, or that you're not actually testing the
same kernels and there's some other changes (xfs most likely, but
really it could be anywhere) which is causing this regression. I'm
rather convinced now after this test that it's not my stuff.

Thanks, Daniel

>
> > -Daniel
> >
> > ---
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index d807587c9ae6..27ea763c6155 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4191,11 +4191,6 @@ void fs_reclaim_acquire(gfp_t gfp_mask)
> >               if (gfp_mask & __GFP_FS)
> >                       __fs_reclaim_acquire();
> >
> > -#ifdef CONFIG_MMU_NOTIFIER
> > -             lock_map_acquire(&__mmu_notifier_invalidate_range_start_m=
ap);
> > -             lock_map_release(&__mmu_notifier_invalidate_range_start_m=
ap);
> > -#endif
> > -
> >       }
> >  }
> >  EXPORT_SYMBOL_GPL(fs_reclaim_acquire);
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
