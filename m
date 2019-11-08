Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3264F4069
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2019 07:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfKHGdL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Nov 2019 01:33:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfKHGdK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Nov 2019 01:33:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sfdfvBL2vL+6/zKzcRD8BS56fyubhIZ+MnB63+Whqww=; b=FyyBMRXg7xjEFz//LRCdOwL18
        hKB/D3F1bPGKiHdQWF5m35XG4E3WD+6E0CxgvcikgS5iRvO035mZUNmAfQsrTxXbipkMtN7Csh82U
        TkXb00nbArvJ4o9o1oSsuBXDYKdWjjL+gFeJdHZim38W2w/ASDOrOw7R4zUEvGcf9P4Zly7OuHtXi
        R2b9mpCV+5doe05qxCME3B/ZrpaUGvMjyxA/fTYrGvV7sgs0phhNbJEtc/O73szxHJx/zSNnzUmhw
        WnNF01/JTBJLgMj7/spP8/IEmmGPsj93eGRwYEwNwsz/7/7UlAROrdUCayb+qrzFziI1mB1Ncy4fZ
        vWBdHpcGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSxpO-0004uP-RP; Fri, 08 Nov 2019 06:33:02 +0000
Date:   Thu, 7 Nov 2019 22:33:02 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2 02/15] mm/mmu_notifier: add an interval tree notifier
Message-ID: <20191108063302.GA18778@infradead.org>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-3-jgg@ziepe.ca>
 <35c2b322-004e-0e18-87e4-1920dc71bfd5@nvidia.com>
 <20191107200604.GB21728@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107200604.GB21728@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 07, 2019 at 08:06:08PM +0000, Jason Gunthorpe wrote:
> > 
> > enum mmu_range_notifier_event {
> > 	MMU_NOTIFY_RELEASE,
> > };
> > 
> > ...assuming that we stay with "mmu_range_notifier" as a core name for this 
> > whole thing.
> > 
> > Also, it is best moved down to be next to the new MNR structs, so that all the
> > MNR stuff is in one group.
> 
> I agree with Jerome, this enum is part of the 'struct
> mmu_notifier_range' (ie the description of the invalidation) and it
> doesn't really matter that only these new notifiers can be called with
> this type, it is still part of the mmu_notifier_range.
> 
> The comment already says it only applies to the mmu_range_notifier
> scheme..

In fact the enum is entirely unused.  We might as well just kill it off
entirely.
