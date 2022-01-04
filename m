Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88602483D9E
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 09:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiADIEW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 03:04:22 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:36264 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiADIEW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jan 2022 03:04:22 -0500
Received: from [192.168.18.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1n4ena-0007Sc-Pj; Tue, 04 Jan 2022 08:04:07 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1n4enW-0011Es-J8; Tue, 04 Jan 2022 08:04:00 +0000
Subject: Re: [PATCH 2/2] IB/rdmavt: modify rdmavt/qp.c for UML
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-rdma@vger.kernel.org, linux-um@lists.infradead.org
References: <20220102070623.24009-1-rdunlap@infradead.org>
 <20220103230445.GA2592848@nvidia.com>
 <50fa4eca-ce74-431f-8497-273d2c5956f2@infradead.org>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <6c083f0d-4fea-6339-71ca-6e8fb524e1c0@cambridgegreys.com>
Date:   Tue, 4 Jan 2022 08:03:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <50fa4eca-ce74-431f-8497-273d2c5956f2@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 04/01/2022 01:00, Randy Dunlap wrote:
> 
> 
> On 1/3/22 15:04, Jason Gunthorpe wrote:
>> On Sat, Jan 01, 2022 at 11:06:23PM -0800, Randy Dunlap wrote:
>>> When building rdmavt for ARCH=um, qp.c has a build error on a reference
>>> to the x86-specific cpuinfo field 'x86_cache_size'. This value is then
>>> used to determine whether to use cacheless_memcpy() or not.
>>> Provide a fake value to LLC for CONFIG_UML. Then provide a separate
>>> verison of cacheless_memcpy() for CONFIG_UML that is just a plain
>>> memcpy(), like the calling code uses.
>>>
>>> Prevents these build errors:
>>>
>>> ../drivers/infiniband/sw/rdmavt/qp.c: In function ‘rvt_wss_llc_size’:
>>> ../drivers/infiniband/sw/rdmavt/qp.c:88:23: error: ‘struct cpuinfo_um’ has no member named ‘x86_cache_size’; did you mean ‘x86_capability’?
>>>    return boot_cpu_data.x86_cache_size;
>>>
>>> ../drivers/infiniband/sw/rdmavt/qp.c: In function ‘cacheless_memcpy’:
>>> ../drivers/infiniband/sw/rdmavt/qp.c:100:2: error: implicit declaration of function ‘__copy_user_nocache’; did you mean ‘copy_user_page’? [-Werror=implicit-function-declaration]
>>>    __copy_user_nocache(dst, (void __user *)src, n, 0);
>>>
>>> Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>   drivers/infiniband/sw/rdmavt/qp.c |   12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> +++ linux-next-20211224/drivers/infiniband/sw/rdmavt/qp.c
>>> @@ -84,10 +84,15 @@ EXPORT_SYMBOL(ib_rvt_state_ops);
>>>   /* platform specific: return the last level cache (llc) size, in KiB */
>>>   static int rvt_wss_llc_size(void)
>>>   {
>>> +#if !defined(CONFIG_UML)
>>>   	/* assume that the boot CPU value is universal for all CPUs */
>>>   	return boot_cpu_data.x86_cache_size;
>>> +#else /* CONFIG_UML */
>>> +	return 1024;	/* fake 1 MB LLC size */
>>> +#endif
>>>   }
>>>   
>>> +#if !defined(CONFIG_UML)
>>>   /* platform specific: cacheless copy */
>>>   static void cacheless_memcpy(void *dst, void *src, size_t n)
>>>   {
>>> @@ -99,6 +104,13 @@ static void cacheless_memcpy(void *dst,
>>>   	 */
>>>   	__copy_user_nocache(dst, (void __user *)src, n, 0);
>>>   }
>>> +#else
>>> +/* for CONFIG_UML, this is just a plain memcpy() */
>>> +static void cacheless_memcpy(void *dst, void *src, size_t n)
>>> +{
>>> +	memcpy(dst, src, n);
>>> +}
>>> +#endif
>>
>> memcpy is not the same thing as __copy_user - the hint is in the
>> __user cast..
>>
>> It should by copy_from_user(), I think, and this is all just somehow
>> broken to not check the return code.
> 
> Thanks.
> 
>> Why are you trying to make a HW driver compile on UML? Is there any
>> way to even use a driver like this in a UML environment?
> 
> I'm just trying to clean up lots of UML build errors.
> I'm quite happy just making the driver depend on !UML.
> 
> UML maintainers, what do you think?
> 
> Thanks again.
> 

I would suggest that we just !UML this driver.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
