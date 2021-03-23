Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FA3346319
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Mar 2021 16:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbhCWPih (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Mar 2021 11:38:37 -0400
Received: from casper.infradead.org ([90.155.50.34]:58580 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbhCWPiZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Mar 2021 11:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3GARnYBw5Kz0ipLY2QfKLoYum46obRcrSAZe3Epq6KU=; b=R5ixmDzJpShlwhZu8wkdYqf8gP
        AGiN71zkNBb2fqQUNktobslH1nHvqlhrlbIyy1W8IO98z6NevwLoT1s6mVNscB48r4NRIdM/qPlNC
        ZGzoLFhaER2ON+bjzLD9Vhzxivfr2q4BodAmHgK5onkrogGksI05rlPdB4K0v6XzDPCO1rcCY8Nom
        +uc4yfMBe8/xPpqpGOxKHvjlF4rDIfQLEg9pUi17DMN49mik4fEM3riy+6kc57iOnhRYyzlwpOlUg
        +duMPGnYGIFL7xtNuj4xLZ9I/o5mKXDUoQk3cKWAt7q0fgbX4Od8DnteDddtg+Inl9xBeKnUaq0Rg
        B8A7lPDw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOj3s-00AEA4-OV; Tue, 23 Mar 2021 15:35:25 +0000
Date:   Tue, 23 Mar 2021 15:35:16 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        "Rimmer, Todd" <todd.rimmer@intel.com>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH RFC 0/9] A rendezvous module
Message-ID: <20210323153516.GC2434215@infradead.org>
References: <20210319202627.GC2356281@nvidia.com>
 <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319205432.GE2356281@nvidia.com>
 <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
 <BL0PR11MB329976F1C41951957E2DBE79F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <be96ccbb-17b7-27e3-a4f2-5b2cc4184ecc@cornelisnetworks.com>
 <YFcKTjU9JSMBrv0x@unreal>
 <bc56284b-f517-2770-16ec-b98d95caea6f@cornelisnetworks.com>
 <20210321164504.GS2356281@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210321164504.GS2356281@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 21, 2021 at 01:45:04PM -0300, Jason Gunthorpe wrote:
> > We should be trying to get things upstream, not putting up walls when people
> > want to submit new drivers. Calling code "garbage" [1] is not productive.
> 
> Putting a bunch of misaligned structures and random reserved fields
> *is* garbage by the upstream standard and if I send that to Linus I'll
> get yelled at.

And when this is for out of tree crap it is per the very definition of
the word garbage.  If I was in your position I would not waste any time
on such an utterly disrespectful submission that violates all the
community rules.
