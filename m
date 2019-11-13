Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 956CBFB202
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2019 15:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfKMOA2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Nov 2019 09:00:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60568 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfKMOA2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Nov 2019 09:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=adngPJXgwQt4HnabNO8PYDHJI
        9XDvXMPFMJ0nAf8jLSUnIc7oJjq7hj9309jqBcntoSa240myTigHuwnQGs0iqEGT8hlDKMu4XsFGT
        WqOta0NrY2wa+/GduBxhXPMI5vwJ3T41ieydi8ci/ctcAM+j0hhd1B4VsZ9TRM09QEHwe0gda49Uw
        Z9s3TwDGhO4Mw5GlwJwEXcX+Vnq3/Y2TJLQkbtBj/Q6EiBR6SNqNQXFxJtYg1jvvdV+QXWKVyNOEM
        /g+4gFFRz0l/lUe+EUUU3O5+fKP/5WOy5R7LXN2V74ABznHQFUnaJJiJXtLWj9iIMo2sj58WX+WzJ
        YGuSvg1uQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUtC4-0002lu-0C; Wed, 13 Nov 2019 14:00:24 +0000
Date:   Wed, 13 Nov 2019 06:00:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
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
        nouveau@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 03/14] mm/hmm: allow hmm_range to be used with a
 mmu_interval_notifier or hmm_mirror
Message-ID: <20191113140023.GC20531@infradead.org>
References: <20191112202231.3856-1-jgg@ziepe.ca>
 <20191112202231.3856-4-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112202231.3856-4-jgg@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
