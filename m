Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2BA197480
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2020 08:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgC3G2L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Mar 2020 02:28:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgC3G2L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Mar 2020 02:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CAVk4o7a9QdE9f5V4Rob2eu2jcOd66eTyjHi8aMLFJM=; b=qF8rnTCqYw1CmyXWeEB8U/VHeQ
        XumxbijNgxczjzUD7L0LAqp/ww3lgm+Ye59Di8yB/bkzXvBFwDT80jEFEoXu/+2Ksvpva91VQl3SC
        2qtkTcuRHBfO/qtfxRN6TuVphJQPWBkSL7mMCltfE00kTI8S9vGvhreOor/Rco6yLiodc0WAAj4PZ
        2foGx/iMTT7SrCR5nOIdsWuW+x4hgK4soR+xdmtOJ3JFnkcEa6cnsskdsFvVUXb6ncwS54bWKpS0A
        08aTAZ6FCaK5nhzBoNhJc9ar9BOsR5PQVYX1VjjMsKaSd2VdSgbBwYoWe+L1CImI+62ILlFEZFsTq
        669dqpPA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jInu1-000667-R8; Mon, 30 Mar 2020 06:28:05 +0000
Date:   Sun, 29 Mar 2020 23:28:05 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
        "rpenyaev@suse.de" <rpenyaev@suse.de>,
        "pankaj.gupta@cloud.ionos.com" <pankaj.gupta@cloud.ionos.com>
Subject: Re: [PATCH v11 15/26] block: reexport bio_map_kern
Message-ID: <20200330062805.GA21989@infradead.org>
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-16-jinpu.wang@cloud.ionos.com>
 <15f25902-1f5a-a542-a311-c1e86330834b@acm.org>
 <20200328082953.GB16355@infradead.org>
 <bbba2682-0221-4173-9d00-b42d4f91f3b8@acm.org>
 <20200329150524.GA13909@infradead.org>
 <BYAPR04MB4965BA89446761D2C3D414D386CA0@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965BA89446761D2C3D414D386CA0@BYAPR04MB4965.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 29, 2020 at 06:08:31PM +0000, Chaitanya Kulkarni wrote:
> > which bio_map_kerl is the wrong interfac given that it
> > uses bio_add_pc_page.  Read, write and other non-passthrough requests
> > must use bio_add_page instead.
> >
> 
> Since rw are most common operations, it'd be nice to have a helper
> function for REQ_OP_[READ|WRITE] to map and submit bio from data buffer
> with chaining to avoid code duplication in each driver which based on 
> the bio_add_page().
> 
> I'd be happy to send a patch for that if that is acceptable.

Well, there aren't a whole lot of driver submitting bios - it's mostly
file systems, and those often use shared code and/or have very specific
requirements.

I've started to factor some reasonably common code into self-contained
helpers with recent XFS work: xlog_map_iclog_data and xfs_rw_bdev.
Both could probably move to the block layer with a little more work,
but we'll have to be careful and actually find enough suitable users.
