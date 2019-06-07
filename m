Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1342038A74
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 14:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfFGMgu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 08:36:50 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42464 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728750AbfFGMgt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 08:36:49 -0400
Received: by mail-qk1-f196.google.com with SMTP id b18so1095352qkc.9
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 05:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=U9t6ZQ44UYTUT/2bmYoJaPHlaVA4zF3kDc6HTj92QLY=;
        b=GHaZaDHn+WrXy9wAWUNhR98Z2ZnPQcEwHBA0fNreTeMFXYMI0TLIdk30sXIfGaoz6Z
         2Wm1tuJvJYWlqm5H0fGGQz48oT3T8YpadC8btMOQB92/NfQmMva+TJZd6EYG9aWCgG26
         VHxwQ3DfM5qDIlpn7ZQApr/l2ZVC97Wts0DZMciAn9C59MY+B2uE/S8xHsY80afFLUwE
         fVTvzqyFZhI3ahb8xUOy+dvzr4y8fvz0m08BooWKjV0QROJkrcKdRBobe7fC7zZwdrvn
         wdtfrz0yNTz3DcVP1O7PZIY5gTipTaSJOWppd9hp9gzmpCYl6I49MMbnYyuKQtl1CqSP
         QnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=U9t6ZQ44UYTUT/2bmYoJaPHlaVA4zF3kDc6HTj92QLY=;
        b=V+wIL4Pd34vQE75TqBHhQwQRuccHc6iaKKF1wOfW+Zp6h37Kdg8WOlMkQNA/lfh7GJ
         H3BXdX6hDe/5R9ES0zk+Y2VXLqasbEpvp471rjIgVaxEyeYN/e5rRK+r5R82+HdwSOk1
         AwU4iEp6+PXY/AVhvO4Q3oOtNS/K5OAba0ILveuEBIO4ujxB9ln8w3VlL2cSPia4w9lA
         yOljagolEiqRfHXurfU4Bz2ruLJSphRyRSBbxqD1hjbftXAxtT4DhL8zk3/Fu6+9LCP4
         0sM1XPtO56GUYXVao4Wlpdkcoo50jwebl6EAKDkoYjj+MsXYB3yRNguRJ/4Q+qRg1inS
         UqIQ==
X-Gm-Message-State: APjAAAWOmP+PX3MIOY1Ypw4ZqurHe53hS/1Fkji43GhPysLJnkO0KUek
        NOnmuIN1aauxq/Wq3aSyAdAPyw==
X-Google-Smtp-Source: APXvYqypoZ+b6025sI65OH/L42IdhXMlYJe+1m7dJypoBd+4mL7LK+2bgSIQr1nAwsZ9NZSKGMrcsw==
X-Received: by 2002:a37:6601:: with SMTP id a1mr42814748qkc.282.1559911008855;
        Fri, 07 Jun 2019 05:36:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id w143sm960651qka.22.2019.06.07.05.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 05:36:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZE6x-00073H-NM; Fri, 07 Jun 2019 09:36:47 -0300
Date:   Fri, 7 Jun 2019 09:36:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 hmm 03/11] mm/hmm: Hold a mmgrab from hmm to mm
Message-ID: <20190607123647.GC14802@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-4-jgg@ziepe.ca>
 <48fcaa19-6ac3-59d0-cd51-455abeca7cdb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48fcaa19-6ac3-59d0-cd51-455abeca7cdb@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 06, 2019 at 07:44:58PM -0700, John Hubbard wrote:
> On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > 
> > So long a a struct hmm pointer exists, so should the struct mm it is
> > linked too. Hold the mmgrab() as soon as a hmm is created, and mmdrop() it
> > once the hmm refcount goes to zero.
> > 
> > Since mmdrop() (ie a 0 kref on struct mm) is now impossible with a !NULL
> > mm->hmm delete the hmm_hmm_destroy().
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> > v2:
> >  - Fix error unwind paths in hmm_get_or_create (Jerome/Jason)
> >  include/linux/hmm.h |  3 ---
> >  kernel/fork.c       |  1 -
> >  mm/hmm.c            | 22 ++++------------------
> >  3 files changed, 4 insertions(+), 22 deletions(-)
> > 
> > diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> > index 2d519797cb134a..4ee3acabe5ed22 100644
> > +++ b/include/linux/hmm.h
> > @@ -586,14 +586,11 @@ static inline int hmm_vma_fault(struct hmm_mirror *mirror,
> >  }
> >  
> >  /* Below are for HMM internal use only! Not to be used by device driver! */
> > -void hmm_mm_destroy(struct mm_struct *mm);
> > -
> >  static inline void hmm_mm_init(struct mm_struct *mm)
> >  {
> >  	mm->hmm = NULL;
> >  }
> >  #else /* IS_ENABLED(CONFIG_HMM_MIRROR) */
> > -static inline void hmm_mm_destroy(struct mm_struct *mm) {}
> >  static inline void hmm_mm_init(struct mm_struct *mm) {}
> >  #endif /* IS_ENABLED(CONFIG_HMM_MIRROR) */
> >  
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index b2b87d450b80b5..588c768ae72451 100644
> > +++ b/kernel/fork.c
> > @@ -673,7 +673,6 @@ void __mmdrop(struct mm_struct *mm)
> >  	WARN_ON_ONCE(mm == current->active_mm);
> >  	mm_free_pgd(mm);
> >  	destroy_context(mm);
> > -	hmm_mm_destroy(mm);
> 
> 
> This is particularly welcome, not to have an "HMM is special" case
> in such a core part of process/mm code. 

I would very much like to propose something like 'per-net' for struct
mm, as rdma also need to add some data to each mm to make it's use of
mmu notifiers work (for basically this same reason as HMM)

Thanks,
Jason
