Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0BB3B7DEA
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jun 2021 09:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhF3HUK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Jun 2021 03:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbhF3HUK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Jun 2021 03:20:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDECFC061766;
        Wed, 30 Jun 2021 00:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AmLWm8f1+xjYGNy9dtQzaNaqp/ZZfO73MYaUMsPh1Dg=; b=F8b+pRoMBgZQhdcjcephjDNsSI
        VA/3Xojz0o/TRMdjW+z7a/VKUfEThgnYdDQaUcXc4PejZicM3AxahMUxxLqkGboHXMP29hAd5ThOl
        Ut2N2h7kiLB3fYN9IkffojJT7nZ3varaq5I4oZyrJPNNx7pC7QEtI75+5oVoOgwTEjajRzSeKXdgZ
        ZeJB4jzuhqkMY/QmAvbpQR78Q60mh0OKr3Mm3QpU2Sj3nL/cJtuPLXgSvGhtFoQ4sgl0p94E3w6IS
        pBQfqFXCTEtDx91plZxAtTNyTIqBMPHiPdiWcMQhZFYvkmgv4XIBEGO6shDHjz2vX+YtN5EX5o59f
        HDi2xZWQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyUSb-0051uJ-FJ; Wed, 30 Jun 2021 07:16:48 +0000
Date:   Wed, 30 Jun 2021 08:16:37 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next v1 1/2] lib/scatterlist: Fix wrong update of
 orig_nents
Message-ID: <YNwaVTT0qmQdxaZz@infradead.org>
References: <cover.1624955710.git.leonro@nvidia.com>
 <dadb01a81e7498f6415233cf19cfc2a0d9b312f2.1624955710.git.leonro@nvidia.com>
 <YNwIL4OguRO/CH6K@infradead.org>
 <YNwPX7BxPl22En9U@unreal>
 <YNwQLV87aBdclTYe@infradead.org>
 <YNwW83ZpXZSSPDfM@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNwW83ZpXZSSPDfM@unreal>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 30, 2021 at 10:02:11AM +0300, Leon Romanovsky wrote:
> Another possible solution is to change __sg_alloc_table()/__sg_alloc_table_from_pages
> to return total_nents and expect from the users to store it internally and pass
> it later to the __sg_free_table().
> 
> Something like that.

Yes, that sounds pretty reasonable.
