Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF0126D845
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Sep 2020 12:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgIQKBy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Sep 2020 06:01:54 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14936 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgIQKBy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Sep 2020 06:01:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6333b90003>; Thu, 17 Sep 2020 03:00:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 17 Sep 2020 03:01:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 17 Sep 2020 03:01:54 -0700
Received: from [172.27.13.3] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Sep
 2020 10:01:51 +0000
Subject: Re: [PATCH rdma-next 1/4] IB/core: Improve ODP to use
 hmm_range_fault()
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>, <linux-rdma@vger.kernel.org>
References: <20200914113949.346562-1-leon@kernel.org>
 <20200914113949.346562-2-leon@kernel.org>
 <20200916164516.GA11582@infradead.org> <20200916172100.GE3699@nvidia.com>
From:   Yishai Hadas <yishaih@nvidia.com>
Message-ID: <d9b2cb12-0023-475e-ae4a-3d818baff80e@nvidia.com>
Date:   Thu, 17 Sep 2020 13:01:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200916172100.GE3699@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600336825; bh=L0UNx9BNzKcdCEyiJDu1dknNzA8Fs8NmM+6bot8qPuI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:
         Content-Transfer-Encoding:Content-Language:X-Originating-IP:
         X-ClientProxiedBy;
        b=q9jsbA1DEfNLe0+z4H1qRhgeJmY9hjZNwuoXINAAxraEmIctKb+Ve9f8VapZY17QL
         g1rR+CIKyUCtR6wTuZaJMdTAT9ZUjNAfjzWiXxdIiaDIBKr9rIxqeEMX7R5FwiArdH
         TVMWK8QbRcPnqUT+COGup1dooweEBc812YSVXbIg67tjjiC0MzyXsZfjppVz42/Ele
         dIAWBR5CI0qDOzO3PiwgtQfrH6AM8cCw1XWj5dgO7Kl7TV3BULtSz409sN64QqFYMx
         ASqmR7exFKP9xZmezAM4xjMk/UHGv+JXnbJZunN24jrBZRTtW6jdnR1qRK0QwvpfcD
         Cqx3bJUEubQTg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/16/2020 8:21 PM, Jason Gunthorpe wrote:
> On Wed, Sep 16, 2020 at 05:45:16PM +0100, Christoph Hellwig wrote:
>   
>> Note that 0 is a valid DMA address.  I think due the access bit this
>> works, but it is a little subtle..
> It should be checked again carefully.. This looks a bit questionable
> if the flags are what makes it work:
>
> +               dma_addr = dma & ODP_DMA_ADDR_MASK;
> +               if (dma_addr) {

I have changed the check to be on dma, the masking to get the 
dma_address will be just later on so this should be fine even for 
potential valid NULL dma address.
Will be part of V1.

>> But more importantly except for (dma_addr_t)-1 (DMA_MAPPING_ERROR)
>> all dma_addr_t values are valid, so taking more than a single bit
>> from a dma_addr_t is not strictly speaking correct.
> This is the result of dma_map_page(). The HW requires that
> dma_map_page(page_size) returns a DMA address that is page_size
> aligned, even for huge pages.
>
> So at least the last 12 bits of the DMA address are always 0, they can
> be used for flags. This is also the HW representation in the page
> table.
>
> Last time you pointed at this code you agreed this alignment was met,
> is it still OK?
>
> Jason

Yes, this was confirmed by Christoph in next mail.

Thanks,
Yishai

