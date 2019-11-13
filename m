Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6781FB208
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2019 15:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfKMOBk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Nov 2019 09:01:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfKMOBk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Nov 2019 09:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1umyAol6qJ52sj688B0QitsfoTQEqbkW4R/EnVJiSfk=; b=gExlmud2ECMJ7KIWs1/XfgJUw
        WIAuxAr096JG6EEc9OvgImYcFSTOylwO20r1g7Z9LKWQ/nQaViBB7UDy3S/XK8/qo+lIz18G2mAwl
        GdTMpKKIqVtjo+fCUGfTLIaQQKeHyan8+FVhGa+4OnOvxz/wEP/PiIUpFuGgpYqztbmMAWQt014OL
        qdKLsQz/tTd+dNbmegRtIpYBQdCOJ+nvfdVTACdnAuNFLKMNsgOOxBun79fFb9olojNKy/62z5gWb
        eaRch/3EAvpaMZBUIjefF996PjPjNnqWcbzVYUHv0pMLESGMVSxXxVRhrSfcvLoljEXpDW3oblocv
        XjhksirCQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUtDD-0002t4-Um; Wed, 13 Nov 2019 14:01:35 +0000
Date:   Wed, 13 Nov 2019 06:01:35 -0800
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
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v3 04/14] mm/hmm: define the pre-processor related parts
 of hmm.h even if disabled
Message-ID: <20191113140135.GD20531@infradead.org>
References: <20191112202231.3856-1-jgg@ziepe.ca>
 <20191112202231.3856-5-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112202231.3856-5-jgg@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Christoph Hellwig <hch@lst.de>
