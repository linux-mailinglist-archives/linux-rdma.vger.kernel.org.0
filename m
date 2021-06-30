Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2E13B7D1B
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jun 2021 07:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhF3GCT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Jun 2021 02:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhF3GCS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Jun 2021 02:02:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3FBC061766;
        Tue, 29 Jun 2021 22:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nFNxLUAvWfNTtWGxP+XvQJ2mzZBCSlv+blczOMbhtrw=; b=R0N55prAO3zLbTqQhgAmx003Sw
        aeqDP/5/F3mlOSHmZtockBl+26v3UsBc3Yw8VzZbXMHjS7wMJlVxoDR+PsPxTTdY4sN4hi/zykiq6
        BRIXUSl1ofEXw9zQL1oyuNorLtTNEnYMM9aIG66eKVIGV5RYi0Gcs0Ks79CYqRIH8xBMzYpC3WjRF
        U/NsOAlzbExbSEIJeh6FbeTk3+LuV8y0pqbGU6rs9Yf9jr1BJYZ1mwNcMz++CJ+QpwmdQFZMOzsw7
        CuB9b3eNbhIV0v7TyvfYLBJ61q56heSjvCdLHYwIXBKPPg440cJvSLmYyylID9d2HFINfFyr1awlx
        5qU0SVHQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyTFf-004xig-Mb; Wed, 30 Jun 2021 05:59:17 +0000
Date:   Wed, 30 Jun 2021 06:59:11 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next v1 1/2] lib/scatterlist: Fix wrong update of
 orig_nents
Message-ID: <YNwIL4OguRO/CH6K@infradead.org>
References: <cover.1624955710.git.leonro@nvidia.com>
 <dadb01a81e7498f6415233cf19cfc2a0d9b312f2.1624955710.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dadb01a81e7498f6415233cf19cfc2a0d9b312f2.1624955710.git.leonro@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 29, 2021 at 11:40:01AM +0300, Leon Romanovsky wrote:
> 2. Add a new field total_nents to reflect the total number of entries
>    in the table. This is required for the release flow (sg_free_table).
>    This filed should be used internally only by scatterlist.

No, please don't bloat the common structure.

> +	/* The fields below should be used internally only by
> +	 * scatterlist implementation.
> +	 */

And this is not the way kernel comments work.
