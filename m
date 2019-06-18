Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9027A49665
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 02:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfFRApL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jun 2019 20:45:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38825 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfFRApL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jun 2019 20:45:11 -0400
Received: by mail-qt1-f194.google.com with SMTP id n11so13206444qtl.5
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jun 2019 17:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xyVcNd9oooqBQ01pz08myANSFTdx0SwnrW4fjYnawJM=;
        b=EbwbRCaTtFd2OjM2jNOG+48iONnisGaulMgt8GBSlGmHHmNOKbiX/pQ5UIlGAp8yUz
         vNA1zIvWXYK1S4TWgK+86NqYoCUVC/0ZevX6IRfWzWSNvQ8g+Og+/8wxKQstLAZ+revM
         VL5EZh1MRj6Ew8rlA3u8Y12VqUKY0LSaNX6vUqI1xIiehSserEbesl80q+pA69T5mmHc
         9ILTNBce92/Mo7e4Kup6uNkn8cC7R1Ht2U5myxg80c8SBX/Bf59IAzM3jiTwz6+ORmYB
         TG1ZP8xw47a6bZF6oV577gILRTEpeuB3t1687rIrkCR/XgY0ASSrboWRYKGE3cjxdvtm
         1zGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xyVcNd9oooqBQ01pz08myANSFTdx0SwnrW4fjYnawJM=;
        b=k66OEriIaAWzNOdGkGlIiKJxpuPwTJfXmQarTISZNZL4Lfq6sjgqDZGy+iD2j+jYlh
         Z53OyL0sPh+Ed503OWV7QKQZtLlr07kSX+DNAyeq8zwFXwoxX3P1XO+qeS2Ym/DgP1Th
         zkJwn0H4Lm1/Ubyo+KJHCV2eqsxTFXyNopnyO4/yr8IESfDBx/lsSPof+eAikDZ9zHb6
         HdmWWTrv42ZujcrYEKEhVQdyCjrE77vc5nstvo4Se7tutUz79sdh3W0mX/g+JPoo/Ycr
         605NGkMBZNyNyWRB384cj/ayJFXAqgafGkbvPiFIvIK4DebpAJTw4l8g9jBB3Rt3Iib+
         uamw==
X-Gm-Message-State: APjAAAULUElpwu0k54wOx5JCbf78KZ4UUNVI9fA+mqRtDGTgu3Q7rslr
        JuzdE2vJlKfY/7vgTTpdZv+y8Q==
X-Google-Smtp-Source: APXvYqwWPeoiWiUq38eemfOuoOnFZtRLG1ij33tWBeptCPrHnF05gR5s5sk1ou0VyceV16bnn7ukkQ==
X-Received: by 2002:ac8:2763:: with SMTP id h32mr99156393qth.350.1560818710425;
        Mon, 17 Jun 2019 17:45:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z57sm9460981qta.62.2019.06.17.17.45.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 17:45:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hd2FJ-0000ob-FF; Mon, 17 Jun 2019 21:45:09 -0300
Date:   Mon, 17 Jun 2019 21:45:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 hmm 11/12] mm/hmm: Remove confusing comment and logic
 from hmm_release
Message-ID: <20190618004509.GE30762@ziepe.ca>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-12-jgg@ziepe.ca>
 <20190615142106.GK17724@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615142106.GK17724@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 15, 2019 at 07:21:06AM -0700, Christoph Hellwig wrote:
> On Thu, Jun 13, 2019 at 09:44:49PM -0300, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > 
> > hmm_release() is called exactly once per hmm. ops->release() cannot
> > accidentally trigger any action that would recurse back onto
> > hmm->mirrors_sem.
> 
> In linux-next amdgpu actually calls hmm_mirror_unregister from its
> release function.  That whole release function looks rather sketchy,
> but we probably need to sort that out first.

Does it? I see this:

static void amdgpu_hmm_mirror_release(struct hmm_mirror *mirror)
{
        struct amdgpu_mn *amn = container_of(mirror, struct amdgpu_mn, mirror);

        INIT_WORK(&amn->work, amdgpu_mn_destroy);
        schedule_work(&amn->work);
}

static struct hmm_mirror_ops amdgpu_hmm_mirror_ops[] = {
        [AMDGPU_MN_TYPE_GFX] = {
                .sync_cpu_device_pagetables = amdgpu_mn_sync_pagetables_gfx,
                .release = amdgpu_hmm_mirror_release
        },
        [AMDGPU_MN_TYPE_HSA] = {
                .sync_cpu_device_pagetables = amdgpu_mn_sync_pagetables_hsa,
                .release = amdgpu_hmm_mirror_release
        },
};


Am I looking at the wrong thing? Looks like it calls it through a work
queue should should be OK..

Though very strange that amdgpu only destroys the mirror via release,
that cannot be right.

Jason
