Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365C11D31F4
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2020 15:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgENN5z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 May 2020 09:57:55 -0400
Received: from p3plsmtpa06-07.prod.phx3.secureserver.net ([173.201.192.108]:49957
        "EHLO p3plsmtpa06-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbgENN5z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 May 2020 09:57:55 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 May 2020 09:57:55 EDT
Received: from [192.168.0.78] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id ZEFvjVG1wo9BxZEFwjKHM4; Thu, 14 May 2020 06:50:36 -0700
X-CMAE-Analysis: v=2.3 cv=YLzhNiOx c=1 sm=1 tr=0
 a=ugQcCzLIhEHbLaAUV45L0A==:117 a=ugQcCzLIhEHbLaAUV45L0A==:17
 a=IkcTkHD0fZMA:10 a=CbDCq_QkAAAA:8 a=Z109AbiFsV3ZPQfyLloA:9 a=QEXdDO2ut3YA:10
 a=1qrBK16LubpBFNPVNq2M:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH] IB/iser: Remove support for FMR memory registration
To:     Max Gurtovoy <maxg@mellanox.com>,
        Alexey Lyashkov <umka@cloudlinux.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Israel Rukshin <israelr@mellanox.com>, sagi@grimberg.me,
        jgg@mellanox.com, linux-rdma@vger.kernel.org, dledford@redhat.com,
        sergeygo@mellanox.com
References: <1589299739-16570-1-git-send-email-israelr@mellanox.com>
 <20200512171633.GO4814@unreal> <5b8b0b51-83e3-06c2-9b99-dec0862c0e5b@acm.org>
 <49391e02-803b-f705-b00e-e48efd278759@mellanox.com>
 <0C22D41B-89CD-4B2D-B514-8EA06F2233D7@cloudlinux.com>
 <f6d970e6-2373-e070-40fb-9db82c136e4b@mellanox.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <a8cfa205-ec0e-bfd1-2d5c-0c76ae568326@talpey.com>
Date:   Thu, 14 May 2020 09:50:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f6d970e6-2373-e070-40fb-9db82c136e4b@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCOHFASTRqt8mY4OLIY5MMBcUMVoefFS2jGlwZehQzmZy/yehfI42YZiDrfpFuGyhjDMfhY38r6k/lSiZlcjqzJ/aYQergaSl1tOqKVYe05MQ53PoOUD
 iEkUD7+w6ih2cSDi/F+9pXzYVGpepThD7w5QHJgCzO5dHlLR9273bqyMcGtS6b4ezzZlrG4tg9XbTHu5l9ylYa2lpDI7/42pVDq8FoyQVCulpbfdYyZPrCg/
 OrPoJKXWb+w/c8yr3qQxyQrTCEElka0wCJgAOxoIVnouDR/b5jFhqH7FPvet6liP/NlGNigfuozoSCb0ewgzpZjsrbIKr/ocUDLkpxgvWEvqzbcowkMxMZiY
 qKLwWPv+bns2A4d7QCsE1vmthHCbTxbRbaNJuj0Aj8rLT77mO0Zn096w/bRSbjqPo7obX6DYd5sBVvyg+iBZER1GCGY47g==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/14/2020 6:50 AM, Max Gurtovoy wrote:
> 
> On 5/14/2020 1:09 PM, Alexey Lyashkov wrote:
>> CX3 with fast registration isn’t stable enough.
>> I was make this change for Lustre for year or two ago, but it was 
>> reverted by serious bugs.
>>
> I'm not aware of any issues there.
> 
> You can always report it on the mailing list.

Just as a data point, NFS/RDMA and SMB Direct both use FRWR exclusively,
and have been working well at >>100K IOPS over CX3 and all others.

Tom.


>> Alex
>>> 13 мая 2020 г., в 11:43, Max Gurtovoy <maxg@mellanox.com 
>>> <mailto:maxg@mellanox.com>> написал(а):
>>>
>>>
>>> On 5/12/2020 11:09 PM, Bart Van Assche wrote:
>>>> On 2020-05-12 10:16, Leon Romanovsky wrote:
>>>>> On Tue, May 12, 2020 at 07:08:59PM +0300, Israel Rukshin wrote:
>>>>>> FMR is not supported on most recent RDMA devices (that use fast 
>>>>>> memory
>>>>>> registration mechanism). Also, FMR was recently removed from NFS/RDMA
>>>>>> ULP.
>>>>>>
>>>>>> Signed-off-by: Israel Rukshin <israelr@mellanox.com 
>>>>>> <mailto:israelr@mellanox.com>>
>>>>>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com 
>>>>>> <mailto:maxg@mellanox.com>>
>>>>>> ---
>>>>>>  drivers/infiniband/ulp/iser/iscsi_iser.h     |  79 +----------
>>>>>>  drivers/infiniband/ulp/iser/iser_initiator.c |  19 ++-
>>>>>>  drivers/infiniband/ulp/iser/iser_memory.c    | 188 
>>>>>> ++-------------------------
>>>>>>  drivers/infiniband/ulp/iser/iser_verbs.c     | 126 
>>>>>> +++---------------
>>>>>>  4 files changed, 40 insertions(+), 372 deletions(-)
>>>>> Can we do an extra step and remove FMR from srp too?
>>>> Which HCA's will be affected by removing FMR support? Or in other 
>>>> words,
>>>> when did (Mellanox) HCA's start supporting fast memory registration? 
>>>> I'm
>>>> asking this because there is a tradition in the Linux kernel not to
>>>> remove support for old hardware unless it is pretty sure that nobody is
>>>> using that hardware anymore.
>>>
>>> ConnectX-3 and above supports fast memory registrations.
>>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>> Bart.
>>
> 
> 
