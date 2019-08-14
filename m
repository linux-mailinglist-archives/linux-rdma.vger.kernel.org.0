Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA868DE82
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2019 22:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfHNUO1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Aug 2019 16:14:27 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5567 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfHNUO1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Aug 2019 16:14:27 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d546ba40000>; Wed, 14 Aug 2019 13:14:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 14 Aug 2019 13:14:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 14 Aug 2019 13:14:26 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 14 Aug
 2019 20:14:24 +0000
Subject: Re: [PATCH v3 hmm 01/11] mm/mmu_notifiers: hoist
 do_mmu_notifier_register down_write to the caller
To:     Jason Gunthorpe <jgg@ziepe.ca>, <linux-mm@kvack.org>
CC:     Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>,
        <intel-gfx@lists.freedesktop.org>,
        Gavin Shan <shangw@linux.vnet.ibm.com>,
        Andrea Righi <andrea@betterlinux.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20190806231548.25242-1-jgg@ziepe.ca>
 <20190806231548.25242-2-jgg@ziepe.ca>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <1391be01-932c-68ca-0160-e08ed2a0243d@nvidia.com>
Date:   Wed, 14 Aug 2019 13:14:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190806231548.25242-2-jgg@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565813668; bh=l693Dsnz2cNYZkVUIa0hGWj4gZqviofo6oB5vcHDRgE=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=R5LCsQ2RGYP/aRbOOTYVqp3+mNbaFthG3djuEbE/Q5RcS9mR/XTArigIkLJIJcoUm
         2K4ojNSONT0DPE3p48KuDCnr8/b/xkcFIsjgMnEh2A4XHosGTEQqAsOIgDIYpKjhA6
         rkPNvw30YaNhLDpHwnvQ22Rq+l1U9m2Nr7cxGupNe9zheNvIiYxkmouASaeFKHn1Ne
         hfrZ3XyWn84qlbZhdg2Z+7hrQwZnGR5tn9y+gosmO+PTqodnJTwNCIDxM/tYLWvgwz
         yiPA4kvRNQ0JR0eN4UhFvOmVWdRm65jh/bJrrdWl3KFGl5AiupxGl6Jnjo5KFXd1mW
         QlJuphdrdgDvw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 8/6/19 4:15 PM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> This simplifies the code to not have so many one line functions and extra
> logic. __mmu_notifier_register() simply becomes the entry point to
> register the notifier, and the other one calls it under lock.
> 
> Also add a lockdep_assert to check that the callers are holding the lock
> as expected.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Nice clean up.
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
