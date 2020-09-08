Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65063261DCA
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Sep 2020 21:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbgIHTm1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Sep 2020 15:42:27 -0400
Received: from verein.lst.de ([213.95.11.211]:53187 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730890AbgIHPwt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Sep 2020 11:52:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B629F68B05; Tue,  8 Sep 2020 17:52:28 +0200 (CEST)
Date:   Tue, 8 Sep 2020 17:52:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Maor Gottlieb <maorg@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/4] lib/scatterlist: Refactor
 sg_alloc_table_from_pages
Message-ID: <20200908155228.GA13593@lst.de>
References: <20200903121853.1145976-1-leon@kernel.org> <20200903155434.1153934-1-leon@kernel.org> <20200907072912.GA19875@lst.de> <2a4b0211-c7a0-2a82-1335-7ed935b92aa2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a4b0211-c7a0-2a82-1335-7ed935b92aa2@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 07, 2020 at 03:32:31PM +0300, Maor Gottlieb wrote:
>
> On 9/7/2020 10:29 AM, Christoph Hellwig wrote:
>> On Thu, Sep 03, 2020 at 06:54:34PM +0300, Leon Romanovsky wrote:
>>> From: Maor Gottlieb <maorg@nvidia.com>
>>>
>>> Currently, sg_alloc_table_from_pages doesn't support dynamic chaining of
>>> SG entries. Therefore it requires from user to allocate all the pages in
>>> advance and hold them in a large buffer. Such a buffer consumes a lot of
>>> temporary memory in HPC systems which do a very large memory registration.
>>>
>>> The next patches introduce API for dynamically allocation from pages and
>>> it requires us to do the following:
>>>   * Extract the code to alloc_from_pages_common.
>>>   * Change the build of the table to iterate on the chunks and not on the
>>>     SGEs. It will allow dynamic allocation of more SGEs.
>>>
>>> Since sg_alloc_table_from_pages allocate exactly the number of chunks,
>>> therefore chunks are equal to the number of SG entries.
>> Given how few users __sg_alloc_table_from_pages has, what about just
>> switching it to your desired calling conventions without another helper?
>
> I tried it now. It didn't save a lot.  Please give me your decision and if 
> needed I will update accordingly.

Feel free to keep it for now, we can sort this out later.
