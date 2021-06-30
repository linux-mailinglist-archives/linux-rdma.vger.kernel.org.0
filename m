Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7456C3B7D74
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jun 2021 08:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhF3Gge (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Jun 2021 02:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhF3Gge (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Jun 2021 02:36:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A7BC061766;
        Tue, 29 Jun 2021 23:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s7sfPSKomuf1f0Wmri9pkg7H5FgMkGeqUuukUkPYBw4=; b=bDxkUfCB9DBNCSJ5pKDUiiLE0c
        I3P40JU98JOtXN1eHqyJRrtQSb4BB9NqNa6V5k2n6RCFnDpPYBeqwHj3FiKrzCBBJGS2ObiEUbyhS
        ozyaQwbKrd1erV7NHHssqMaABAL5h6cNYLsq9i6vHNZJNxtIcKiGZyd7sZGCNotgoQ+JCBkiPc4oR
        vSmWidy1mlt+8vLxjL6J8pnZlhynoLLAz6lM45O7Og7clkhps4OD0tSwz1YaoY7zIR3YezD0bsB+o
        6GR7eKmu3XDGK+QIhq6LKTMOdalq/ovZ5XZEpmHiLZ48YfrphXtHRxFZGFBMd+q424ei1UuDqcD+Y
        BU3nKJjA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyTmf-004zWT-AC; Wed, 30 Jun 2021 06:33:23 +0000
Date:   Wed, 30 Jun 2021 07:33:17 +0100
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
Message-ID: <YNwQLV87aBdclTYe@infradead.org>
References: <cover.1624955710.git.leonro@nvidia.com>
 <dadb01a81e7498f6415233cf19cfc2a0d9b312f2.1624955710.git.leonro@nvidia.com>
 <YNwIL4OguRO/CH6K@infradead.org>
 <YNwPX7BxPl22En9U@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNwPX7BxPl22En9U@unreal>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 30, 2021 at 09:29:51AM +0300, Leon Romanovsky wrote:
> On Wed, Jun 30, 2021 at 06:59:11AM +0100, Christoph Hellwig wrote:
> > On Tue, Jun 29, 2021 at 11:40:01AM +0300, Leon Romanovsky wrote:
> > > 2. Add a new field total_nents to reflect the total number of entries
> > >    in the table. This is required for the release flow (sg_free_table).
> > >    This filed should be used internally only by scatterlist.
> > 
> > No, please don't bloat the common structure.
> 
> Somehow we need to store that total_nents value and our internal
> proposal was to wrap sg_table with another private structure that is
> visible in lib/scatterlist.c only.
> 
> Something like that:
> struct sg_table_private {
>   struct sg_table table;
>   unsigned int total_nents;
> };
> 
> But it looks awkward.

Well, the important point is that we only need it for the new
way of collapsing, appending allocations.  We should not burden
it on all other users.
