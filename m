Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57FB34648B
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Mar 2021 17:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhCWQLO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Mar 2021 12:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbhCWQKm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Mar 2021 12:10:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0F3C061574
        for <linux-rdma@vger.kernel.org>; Tue, 23 Mar 2021 09:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cX03isNxkN4vUrWwAEsgU7MPkZp3w1M3zDMPZuSVs84=; b=nGOP2mVBhcb7juY8o+hSR+uhVc
        pP4+ZqT/eN5DvR07jjLjBqiED6LC3trefDGE5ureAq81MRrl7eG89RcBY452U9oM0D1nZc0CXyAFZ
        OwOACnJveWZLvVGG4sq1/i25wh2yOttRkn3UPlBFfI2fp+8ZRs5LFKrTTQXAeAlzerr+LIOBd54Jg
        ciduIGbpAdXha93RYKQbWHtYu366/CEuYShjPA25FJCMia1T0SJ+/PDlde4Q/w22QFt69O+CrvBXW
        cGPt4uHvzpsiO3HBjVfrjNZPMomsEYUUKR/E3btsePsmtRN5NpAZTxBVmRHaRU8XzRMUk15D6KCTM
        ejkxiZzw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOjYj-00AFtf-BI; Tue, 23 Mar 2021 16:07:23 +0000
Date:   Tue, 23 Mar 2021 16:07:09 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Rimmer, Todd" <todd.rimmer@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH RFC 0/9] A rendezvous module
Message-ID: <20210323160709.GA2444111@infradead.org>
References: <20210319194446.GA2356281@nvidia.com>
 <BL0PR11MB3299928351B241FAAC76E760F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319202627.GC2356281@nvidia.com>
 <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319205432.GE2356281@nvidia.com>
 <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
 <BL0PR11MB329976F1C41951957E2DBE79F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210323153041.GA2434215@infradead.org>
 <20210323154626.GH2356281@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323154626.GH2356281@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 23, 2021 at 12:46:26PM -0300, Jason Gunthorpe wrote:
> What Todd is alluding to here is the hacky DMABUF alternative that is
> in the NVIDIA GPU driver - which HPC networking companies must support
> if they want to interwork with the NVIDIA GPU.
> 
> Every RDMA vendor playing in the HPC space has some out-of-tree driver
> to enable this. :(

I can only recommende everone to buy from a less fucked up GPU or
accelerator vendor.  We're certainly going to do everything we can to
discourage making life easier for people who insist on doing this
stupidest possible thing.
