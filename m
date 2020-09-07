Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9934D25F3F3
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 09:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgIGH3P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 03:29:15 -0400
Received: from verein.lst.de ([213.95.11.211]:47986 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgIGH3P (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Sep 2020 03:29:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A348F68BEB; Mon,  7 Sep 2020 09:29:12 +0200 (CEST)
Date:   Mon, 7 Sep 2020 09:29:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/4] lib/scatterlist: Refactor
 sg_alloc_table_from_pages
Message-ID: <20200907072912.GA19875@lst.de>
References: <20200903121853.1145976-1-leon@kernel.org> <20200903155434.1153934-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903155434.1153934-1-leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 03, 2020 at 06:54:34PM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@nvidia.com>
> 
> Currently, sg_alloc_table_from_pages doesn't support dynamic chaining of
> SG entries. Therefore it requires from user to allocate all the pages in
> advance and hold them in a large buffer. Such a buffer consumes a lot of
> temporary memory in HPC systems which do a very large memory registration.
> 
> The next patches introduce API for dynamically allocation from pages and
> it requires us to do the following:
>  * Extract the code to alloc_from_pages_common.
>  * Change the build of the table to iterate on the chunks and not on the
>    SGEs. It will allow dynamic allocation of more SGEs.
> 
> Since sg_alloc_table_from_pages allocate exactly the number of chunks,
> therefore chunks are equal to the number of SG entries.

Given how few users __sg_alloc_table_from_pages has, what about just
switching it to your desired calling conventions without another helper?
