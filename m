Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23C8CE8A2C
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 14:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388665AbfJ2N7j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 09:59:39 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43211 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388453AbfJ2N7j (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Oct 2019 09:59:39 -0400
Received: by mail-qk1-f193.google.com with SMTP id a194so12279712qkg.10
        for <linux-rdma@vger.kernel.org>; Tue, 29 Oct 2019 06:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8jOH6aTboFzH2FE5ebDVzGbVS8tkTfz/e6O//bI0tkY=;
        b=TOjiKaf4drtV5ldH8zR3DdZRftx4pfyMK7aX+WxF+hP7GAklHNLQJLB3u6THZAuUwq
         2J8U2Z8jfa4RHHqJi86VA8XDEEftIwINME4Xcqo7Lwf5TfQ/5CHndbgRjMZBi7ltmTD/
         9/OIdOP+IKZBXBOnw95rEg1RRCcplq0VveMXmbgEcrW0nIfOMVnpZGUZJC/dcmVtrcLp
         GnztoS4X7Cig0PpARFdiBQAFwuPsNE3oq28XslCe7YAiytEpFuhH3cYXFITze125lBn3
         w8SiavcWCCYZB5EGHirP4nTYv97GbqlF/YYAtwW9ZFYvfLIJ06XZktP4ccL77Rn8KbAv
         rdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8jOH6aTboFzH2FE5ebDVzGbVS8tkTfz/e6O//bI0tkY=;
        b=g62PPq3NAoo46CIQcUOsFfkylpEV7xyX05dU/I6W8RpQ6K4yr7oNpxgLAfOLqgLGKe
         VpDv4Y7bfh56h6VQ2j1OTM3fWKmFNgY4hqtPbV0iJbnCc+2S4Dg6YdSMGlwoiE/QiNVD
         QW/6ZUw1ZDiiMv5VE1P8vJqGR59FLjYNvkknV8Jq++ePJsndXmYdRRrUjUYAjgecU7La
         UgZZkhjyShRftQMqobrFOuyOdSZGC2rr3oraOSI35gAyS94B+udj/lysGX8CJ3WMX6tN
         rCo8bbN7dEqwX514k8ZAcQ6+Iin3BVmICJz034fuxBSmEsqfk6jmaoI5RQItGX376ZZN
         MKpA==
X-Gm-Message-State: APjAAAWhkmvk6roDXpXUAjHS/hgIvOtFSET+UMXGjyZRMilEkyrlV/3j
        n0QaRNNE5mMZWF+p2LHxkum36g==
X-Google-Smtp-Source: APXvYqw2t3qlIvqK+Izwy8tw608BKfVw2jgQ/Y0rREEshgcaboVymXi/nbliXAwFtIZ8GNBEqxuwOw==
X-Received: by 2002:a05:620a:8cb:: with SMTP id z11mr15146993qkz.72.1572357577964;
        Tue, 29 Oct 2019 06:59:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id p188sm7446102qkb.33.2019.10.29.06.59.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 06:59:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPS24-0005x3-D2; Tue, 29 Oct 2019 10:59:36 -0300
Date:   Tue, 29 Oct 2019 10:59:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 13/15] drm/amdgpu: Use mmu_range_insert instead of
 hmm_mirror
Message-ID: <20191029135936.GD6128@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-14-jgg@ziepe.ca>
 <bc44f331-5448-ddc0-ecc3-d0ccb92e11a4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc44f331-5448-ddc0-ecc3-d0ccb92e11a4@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 29, 2019 at 07:51:30AM +0000, Koenig, Christian wrote:
> > +static bool amdgpu_mn_invalidate_gfx(struct mmu_range_notifier *mrn,
> > +				     const struct mmu_notifier_range *range)
> >   {
> > -	struct amdgpu_bo *bo;
> > +	struct amdgpu_bo *bo = container_of(mrn, struct amdgpu_bo, notifier);
> > +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> >   	long r;
> >   
> > -	list_for_each_entry(bo, &node->bos, mn_list) {
> > -
> > -		if (!amdgpu_ttm_tt_affect_userptr(bo->tbo.ttm, start, end))
> > -			continue;
> > -
> > -		r = dma_resv_wait_timeout_rcu(bo->tbo.base.resv,
> > -			true, false, MAX_SCHEDULE_TIMEOUT);
> > -		if (r <= 0)
> > -			DRM_ERROR("(%ld) failed to wait for user bo\n", r);
> > -	}
> > +	/* FIXME: Is this necessary? */
> 
> Most likely not.
> 
> Christian.
> 
> > +	if (!amdgpu_ttm_tt_affect_userptr(bo->tbo.ttm, range->start,
> > +					  range->end))
> > +		return true;

So is the bo->tbo.mem.num_pages == bo->tbo.ttm.num_pages always?

And userptr can't be zero here, or at least it doesn't matter if it is?

> > +static bool amdgpu_mn_invalidate_hsa(struct mmu_range_notifier *mrn,
> > +				     const struct mmu_notifier_range *range)
> >   {
> > -	struct amdgpu_mn *amn = container_of(mirror, struct amdgpu_mn, mirror);
> > -	unsigned long start = update->start;
> > -	unsigned long end = update->end;
> > -	bool blockable = mmu_notifier_range_blockable(update);
> > -	struct interval_tree_node *it;
> > -
> > -	/* notification is exclusive, but interval is inclusive */
> > -	end -= 1;
> > -
> > -	/* TODO we should be able to split locking for interval tree and
> > -	 * amdgpu_mn_invalidate_node
> > -	 */
> > -	if (amdgpu_mn_read_lock(amn, blockable))
> > -		return -EAGAIN;
> > -
> > -	it = interval_tree_iter_first(&amn->objects, start, end);
> > -	while (it) {
> > -		struct amdgpu_mn_node *node;
> > -
> > -		if (!blockable) {
> > -			amdgpu_mn_read_unlock(amn);
> > -			return -EAGAIN;
> > -		}
> > +	struct amdgpu_bo *bo = container_of(mrn, struct amdgpu_bo, notifier);
> > +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> >   
> > -		node = container_of(it, struct amdgpu_mn_node, it);
> > -		it = interval_tree_iter_next(it, start, end);
> > +	/* FIXME: Is this necessary? */
> > +	if (!amdgpu_ttm_tt_affect_userptr(bo->tbo.ttm, range->start,
> > +					  range->end))
> > +		return true;
> >   
> > -		amdgpu_mn_invalidate_node(node, start, end);
> > -	}

This one too right?

Jason
