Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B355526C767
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 20:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgIPSZn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 14:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbgIPSZl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Sep 2020 14:25:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8437C06174A
        for <linux-rdma@vger.kernel.org>; Wed, 16 Sep 2020 11:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xtQ+1715STAkkCJDsrU38iK8sSOVdk2k/EA7Pwj/LMM=; b=eD1hDZPekUY532fEp5wbp7EQKT
        1QLBifiLRUUvETIsVQwrhDWTy3yEGHVnTkTi6wBehxg+sPXD4P1OlyIyWf2GmQ6ha7KKS0/ZorS2e
        FePiqY3J1gKdwStTZEb8pVmQOexgt+MxOHr9yx7Foks9XKrjaNKQWPcxY6RCBkI+LWnqW7SXoOffb
        wJAhNArUrtMlN5/teTHAtgfl2m9xX9VC5BVgrmtQwKQWSCNrB/6B0uCjESRdiCV4vpaLHZymEK6ek
        6HA/l6jdcHe9whEDDY6IpORaEoojKMNH/hNCi6N9WCri/oG71jP22NJ2uO+xwHq7EPEBlgRGhZODk
        PzcTh+1Q==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIc7P-000266-E1; Wed, 16 Sep 2020 18:25:23 +0000
Date:   Wed, 16 Sep 2020 19:25:23 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 2/4] IB/core: Enable ODP sync without faulting
Message-ID: <20200916182523.GA7233@infradead.org>
References: <20200914113949.346562-1-leon@kernel.org>
 <20200914113949.346562-3-leon@kernel.org>
 <20200916164706.GB11582@infradead.org>
 <20200916181911.GL486552@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916181911.GL486552@unreal>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 16, 2020 at 09:19:11PM +0300, Leon Romanovsky wrote:
> On Wed, Sep 16, 2020 at 05:47:06PM +0100, Christoph Hellwig wrote:
> > > +		if (fault) {
> > > +			/*
> > > +			 * Since we asked for hmm_range_fault() to populate pages,
> >
> > Totally pointless line over 80 characters.
> 
> checkpatch.pl was updated to allow 100 symbols.

checkpatch.pl doesn't matter, it is in fact pretty silly.  The coding
style document says:

"The preferred limit on the length of a single line is 80 columns.

Statements longer than 80 columns should be broken into sensible chunks,
unless exceeding 80 columns significantly increases readability and does
not hide information."

and that absolutely is not the case here, you could trivially move the
last word into the next line and would not even increase the line count.
