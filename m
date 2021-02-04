Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABEC3100D4
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 00:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhBDXkV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 18:40:21 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14856 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhBDXkR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Feb 2021 18:40:17 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601c85480000>; Thu, 04 Feb 2021 15:37:44 -0800
Received: from MacBook-Pro-10.local (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Feb
 2021 23:37:44 +0000
Subject: Re: [PATCH 1/4] mm/gup: add compound page list iterator
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Joao Martins <joao.m.martins@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        "Matthew Wilcox" <willy@infradead.org>
References: <20210203220025.8568-1-joao.m.martins@oracle.com>
 <20210203220025.8568-2-joao.m.martins@oracle.com>
 <955dbe68-7302-a8bc-f0b5-e9032d7f190e@nvidia.com>
 <20210204195355.GO4247@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <2919605d-f00f-4a07-8420-6b6d0a42081a@nvidia.com>
Date:   Thu, 4 Feb 2021 15:37:43 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210204195355.GO4247@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612481864; bh=LZBSTf8xjFioVk+xSfpLI1dtz0FjIjVaquLfChu0CyU=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=Oa17G4uClE/0l17rXVcqb9R0YXdIyNZ6Mbn8DQXHa3eOR3lVtJ5CKZMhg+Nmy9p6Q
         lKMf0uig/fJ8Hsg9O80poVjSeHBvugVTw+gKnlYoIk7xNVeVcFaKbJ6IKymV3I3KTw
         h25i1finFISPvrDmje2JnjHU1yBBQhduMygimB4M2ty1j9Y9/BV5CUZ1x6pI+afDR0
         Jrv11zMX+So1JSPknhcVjX/7uFSzewiLfvqmYnaHxHSFQ4Zf2pWZDTrBgwkLvGg8ae
         KCpCJ+UqVpnX2DitbizPmjKKKQ1KXUXY7AI1/gypCzg2TklpkSvx5M+XZs1vIxB9qe
         DzSwtMC3+lx0Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/4/21 11:53 AM, Jason Gunthorpe wrote:
> On Wed, Feb 03, 2021 at 03:00:01PM -0800, John Hubbard wrote:
>>> +static inline void compound_next(unsigned long i, unsigned long npages,
>>> +				 struct page **list, struct page **head,
>>> +				 unsigned int *ntails)
>>> +{
>>> +	if (i >= npages)
>>> +		return;
>>> +
>>> +	*ntails = count_ntails(list + i, npages - i);
>>> +	*head = compound_head(list[i]);
>>> +}
>>> +
>>> +#define for_each_compound_head(i, list, npages, head, ntails) \
>>
>> When using macros, which are dangerous in general, you have to worry about
>> things like name collisions. I really dislike that C has forced this unsafe
>> pattern upon us, but of course we are stuck with it, for iterator helpers.
>>
>> Given that we're stuck, you should probably use names such as __i, __list, etc,
>> in the the above #define. Otherwise you could stomp on existing variables.
> 
> Not this macro, it after cpp gets through with it all the macro names
> vanish, it can't collide with variables.
> 

Yes, I guess it does just vaporize, because it turns all the args into
their substituted values. I was just having flashbacks from similar cases
I guess.

> The usual worry is you might collide with other #defines, but we don't
> seem to worry about that in the kernel
> 

Well, I worry about it a little anyway. haha :)


thanks,
-- 
John Hubbard
NVIDIA
