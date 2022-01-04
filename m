Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29526483990
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 02:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiADBBE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 20:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiADBBE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 20:01:04 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71E8C061761;
        Mon,  3 Jan 2022 17:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Rpq0CasVOhIvJE1oC2pxrzGmHvQGWTE5PPcm0QZMADc=; b=GBLyUbsC/eU3mQmLF9zxPK9mZ6
        /A6jOPQ/lbM8cJU5p7YBGY9gFpYMkuCf+qYY4WnUvtZYhZSbhsSjiJFGE2TxR0YJJjNgqKalXFRrO
        1FCgVK6pHghM5RQA1JjHrDIVl+aSn+lhmA1+kgns029M+isGZN+FUZ6V1wHRB3h9T6zkMg9TVP+wt
        mh7kB8fm/42KhECMApSAewtHquwOtXp8oLqxDZLagIY2vWIKUZHC9v/H96GhdCPfJYro52J6z6kcV
        uipLwIpmp32CgQNkUfe3U1SrR2pVOSBgxtLm+tAT1AM2UXD9UVB7XpE7Fjket73xpXlIm5YiJZERG
        YjK0C1jQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4YC8-005Ba4-Ig; Tue, 04 Jan 2022 01:00:56 +0000
Message-ID: <50fa4eca-ce74-431f-8497-273d2c5956f2@infradead.org>
Date:   Mon, 3 Jan 2022 17:00:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 2/2] IB/rdmavt: modify rdmavt/qp.c for UML
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-rdma@vger.kernel.org, linux-um@lists.infradead.org
References: <20220102070623.24009-1-rdunlap@infradead.org>
 <20220103230445.GA2592848@nvidia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220103230445.GA2592848@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 1/3/22 15:04, Jason Gunthorpe wrote:
> On Sat, Jan 01, 2022 at 11:06:23PM -0800, Randy Dunlap wrote:
>> When building rdmavt for ARCH=um, qp.c has a build error on a reference
>> to the x86-specific cpuinfo field 'x86_cache_size'. This value is then
>> used to determine whether to use cacheless_memcpy() or not.
>> Provide a fake value to LLC for CONFIG_UML. Then provide a separate
>> verison of cacheless_memcpy() for CONFIG_UML that is just a plain
>> memcpy(), like the calling code uses.
>>
>> Prevents these build errors:
>>
>> ../drivers/infiniband/sw/rdmavt/qp.c: In function ‘rvt_wss_llc_size’:
>> ../drivers/infiniband/sw/rdmavt/qp.c:88:23: error: ‘struct cpuinfo_um’ has no member named ‘x86_cache_size’; did you mean ‘x86_capability’?
>>   return boot_cpu_data.x86_cache_size;
>>
>> ../drivers/infiniband/sw/rdmavt/qp.c: In function ‘cacheless_memcpy’:
>> ../drivers/infiniband/sw/rdmavt/qp.c:100:2: error: implicit declaration of function ‘__copy_user_nocache’; did you mean ‘copy_user_page’? [-Werror=implicit-function-declaration]
>>   __copy_user_nocache(dst, (void __user *)src, n, 0);
>>
>> Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>  drivers/infiniband/sw/rdmavt/qp.c |   12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> +++ linux-next-20211224/drivers/infiniband/sw/rdmavt/qp.c
>> @@ -84,10 +84,15 @@ EXPORT_SYMBOL(ib_rvt_state_ops);
>>  /* platform specific: return the last level cache (llc) size, in KiB */
>>  static int rvt_wss_llc_size(void)
>>  {
>> +#if !defined(CONFIG_UML)
>>  	/* assume that the boot CPU value is universal for all CPUs */
>>  	return boot_cpu_data.x86_cache_size;
>> +#else /* CONFIG_UML */
>> +	return 1024;	/* fake 1 MB LLC size */
>> +#endif
>>  }
>>  
>> +#if !defined(CONFIG_UML)
>>  /* platform specific: cacheless copy */
>>  static void cacheless_memcpy(void *dst, void *src, size_t n)
>>  {
>> @@ -99,6 +104,13 @@ static void cacheless_memcpy(void *dst,
>>  	 */
>>  	__copy_user_nocache(dst, (void __user *)src, n, 0);
>>  }
>> +#else
>> +/* for CONFIG_UML, this is just a plain memcpy() */
>> +static void cacheless_memcpy(void *dst, void *src, size_t n)
>> +{
>> +	memcpy(dst, src, n);
>> +}
>> +#endif
> 
> memcpy is not the same thing as __copy_user - the hint is in the
> __user cast..
> 
> It should by copy_from_user(), I think, and this is all just somehow
> broken to not check the return code.

Thanks.

> Why are you trying to make a HW driver compile on UML? Is there any
> way to even use a driver like this in a UML environment?

I'm just trying to clean up lots of UML build errors.
I'm quite happy just making the driver depend on !UML.

UML maintainers, what do you think?

Thanks again.

-- 
~Randy
