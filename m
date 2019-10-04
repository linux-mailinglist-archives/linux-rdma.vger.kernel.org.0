Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4606CBFFE
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 18:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389936AbfJDQDw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 12:03:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389131AbfJDQDw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 12:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6bnnMnywYc1KPMDxc8Uzb+dKxSoXRZCe+CE3Bai6Kig=; b=UtT5E80fTfG3N3Zhy/JcUm0s9
        6fAQ+GfAQ1fWDBVlo4KlV/uXeLNhhh2xwUmdjTM2lFq/54r+Kuo3J+GcgzVx9ge+yDsxlA3wcS5Tj
        6TSx6InmuT8BRMhmzFleM0ykBWvU72vyMh9sS01g1CuKImZltMQFUG5iWqiX7iZoG/ZVs9sMorDk0
        MdRkZxZqgvULDXblBpojXUTTrVWrS/ikRT48b0y6P8ofphz3Z7VJMROz69AWXbOdXOtpPOidh1Wz/
        0UUubi6OQAcZbPltXYZDJmlXKugsL20OQsnIcgCAPENPzN+eVej+PIhBO/4vGlujvnPMjZ/6zPdNe
        o9FOXgO1g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGQ3X-00030a-VP; Fri, 04 Oct 2019 16:03:47 +0000
Date:   Fri, 4 Oct 2019 09:03:47 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH -next 00/11] lib/interval-tree: move to half closed
 intervals
Message-ID: <20191004160347.GH32665@bombadil.infradead.org>
References: <20191003201858.11666-1-dave@stgolabs.net>
 <20191004002609.GB1492@ziepe.ca>
 <CANN689G3chM1FjFPdCNm9_OQxazs7YP1PuZLpqGtq=qzaZ0Hbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANN689G3chM1FjFPdCNm9_OQxazs7YP1PuZLpqGtq=qzaZ0Hbw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 04, 2019 at 06:15:11AM -0700, Michel Lespinasse wrote:
> My take is that this (Davidlohr's) patch series does not necessarily
> need to be applied all at once - we could get the first change in
> (adding the interval_tree_gen.h header), and convert the first few
> users, without getting them all at once, as long as we have a plan for
> finishing the work. So, if you have cleanups in progress in some of
> the files, just tell us which ones and we can leave them out from the
> first pass.

Since we have users which do need to use the full ULONG_MAX range
(as pointed out by Christian Koenig), I don't think adding a second
implementation which is half-open is a good idea.  It'll only lead to
confusion.
