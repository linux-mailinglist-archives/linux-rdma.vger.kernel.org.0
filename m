Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76BF3F4F6C
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 19:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhHWRWK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 13:22:10 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:37936 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231172AbhHWRWK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Aug 2021 13:22:10 -0400
Received: from [192.168.1.18] ([90.126.253.178])
        by mwinf5d72 with ME
        id l5MQ2500M3riaq2035MQKm; Mon, 23 Aug 2021 19:21:26 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 23 Aug 2021 19:21:26 +0200
X-ME-IP: 90.126.253.178
Subject: Re: [PATCH] RDMA: switch from 'pci_' to 'dma_' API
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        aditr@vmware.com, pv-drivers@vmware.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <259e53b7a00f64bf081d41da8761b171b2ad8f5c.1629634798.git.christophe.jaillet@wanadoo.fr>
 <20210823165902.GB984782@nvidia.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <aeaf3067-59cf-5973-be17-3224de566ff8@wanadoo.fr>
Date:   Mon, 23 Aug 2021 19:21:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210823165902.GB984782@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Le 23/08/2021 à 18:59, Jason Gunthorpe a écrit :
> On Sun, Aug 22, 2021 at 02:24:44PM +0200, Christophe JAILLET wrote:
>> The wrappers in include/linux/pci-dma-compat.h should go away.
>>
>> The patch has been generated with the coccinelle script below.
>>
>> It has been hand modified to use 'dma_set_mask_and_coherent()' instead of
>> 'pci_set_dma_mask()/pci_set_consistent_dma_mask()' when applicable.
>> This is less verbose.
>>
>> It has been compile tested.
>>
[...]
>>
>> This patch is mostly mechanical and compile tested. I hope it is ok to
>> update the "drivers/infiniband/hw/" directory all at once.
> 
> I think I would have preferred to see the more tricky
> dma_set_mask_and_coherent() conversion as its own patch, but it looks
> OK

Hi, I agree, but as I already answered to another reviewer:

"
When I started this task proposed by Christoph Hellwig ([1]), their were 
150 files using using 'pci_set_dma_mask()' ([2]). Many of them were good 
candidate for using 'dma_set_mask_and_coherent()' but this 
transformation can not easily be done by coccinelle because it depends 
on the way the code has been written.

So, I decided to hand modify and include the transformation in the many 
patches have sent to remove this deprecated API.
Up to now, it has never been an issue.

I *DO* know that it should have been a 2 steps process but this clean-up 
was too big for me (i.e. 150 files) and doing the job twice was 
discouraging.

My first motivation was to remove the deprecated API. Simplifying code 
and using 'dma_set_mask_and_coherent()' when applicable was just a bonus.

[...]

[1]: https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
[2]: https://elixir.bootlin.com/linux/v5.8/A/ident/pci_set_dma_mask
"

> 
>> ---
>>   drivers/infiniband/hw/hfi1/pcie.c             | 11 ++-------
>>   drivers/infiniband/hw/hfi1/user_exp_rcv.c     | 13 +++++------
>>   drivers/infiniband/hw/mthca/mthca_eq.c        | 21 +++++++++--------
>>   drivers/infiniband/hw/mthca/mthca_main.c      | 15 ++----------
>>   drivers/infiniband/hw/mthca/mthca_memfree.c   | 23 +++++++++++--------
>>   drivers/infiniband/hw/qib/qib_file_ops.c      | 12 +++++-----
>>   drivers/infiniband/hw/qib/qib_init.c          |  4 ++--
>>   drivers/infiniband/hw/qib/qib_user_pages.c    | 12 +++++-----
>>   .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    | 14 +++--------
>>   9 files changed, 51 insertions(+), 74 deletions(-)
> 
> Applied to for-next, thanks

So thanks for your understanding and accepting this proposal as-is.

CJ


> 
> Jason
> 

