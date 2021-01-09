Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB972F043B
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Jan 2021 00:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbhAIXBY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 9 Jan 2021 18:01:24 -0500
Received: from mail-1.ca.inter.net ([208.85.220.69]:60552 "EHLO
        mail-1.ca.inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbhAIXBY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 9 Jan 2021 18:01:24 -0500
Received: from localhost (offload-3.ca.inter.net [208.85.220.70])
        by mail-1.ca.inter.net (Postfix) with ESMTP id 9D28D2EA01D;
        Sat,  9 Jan 2021 18:00:42 -0500 (EST)
Received: from mail-1.ca.inter.net ([208.85.220.69])
        by localhost (offload-3.ca.inter.net [208.85.220.70]) (amavisd-new, port 10024)
        with ESMTP id RP9EYr1UqlHY; Sat,  9 Jan 2021 17:47:42 -0500 (EST)
Received: from [192.168.48.23] (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail-1.ca.inter.net (Postfix) with ESMTPSA id 1599B2EA0BD;
        Sat,  9 Jan 2021 18:00:42 -0500 (EST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v5 4/4] scatterlist: add sgl_memset()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, bostroesser@gmail.com, bvanassche@acm.org,
        ddiss@suse.de
References: <20201228234955.190858-1-dgilbert@interlog.com>
 <20201228234955.190858-5-dgilbert@interlog.com>
 <20210107174629.GC504133@ziepe.ca>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <9b727a9a-eb58-ab20-f42b-aa9c9e90a49a@interlog.com>
Date:   Sat, 9 Jan 2021 18:00:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210107174629.GC504133@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021-01-07 12:46 p.m., Jason Gunthorpe wrote:
> On Mon, Dec 28, 2020 at 06:49:55PM -0500, Douglas Gilbert wrote:
>> The existing sg_zero_buffer() function is a bit restrictive. For
>> example protection information (PI) blocks are usually initialized
>> to 0xff bytes. As its name suggests sgl_memset() is modelled on
>> memset(). One difference is the type of the val argument which is
>> u8 rather than int. Plus it returns the number of bytes (over)written.
>>
>> Change implementation of sg_zero_buffer() to call this new function.
>>
>> Reviewed-by: Bodo Stroesser <bostroesser@gmail.com>
>> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
>>   include/linux/scatterlist.h |  3 ++
>>   lib/scatterlist.c           | 65 +++++++++++++++++++++++++------------
>>   2 files changed, 48 insertions(+), 20 deletions(-)
>>
>> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
>> index 71be65f9ebb5..70d3f1f73df1 100644
>> +++ b/include/linux/scatterlist.h
>> @@ -333,6 +333,9 @@ bool sgl_compare_sgl_idx(struct scatterlist *x_sgl, unsigned int x_nents, off_t
>>   			 struct scatterlist *y_sgl, unsigned int y_nents, off_t y_skip,
>>   			 size_t n_bytes, size_t *miscompare_idx);
>>   
>> +size_t sgl_memset(struct scatterlist *sgl, unsigned int nents, off_t skip,
>> +		  u8 val, size_t n_bytes);
>> +
>>   /*
>>    * Maximum number of entries that will be allocated in one piece, if
>>    * a list larger than this is required then chaining will be utilized.
>> diff --git a/lib/scatterlist.c b/lib/scatterlist.c
>> index 9332365e7eb6..f06614a880c8 100644
>> +++ b/lib/scatterlist.c
>> @@ -1038,26 +1038,7 @@ EXPORT_SYMBOL(sg_pcopy_to_buffer);
>>   size_t sg_zero_buffer(struct scatterlist *sgl, unsigned int nents,
>>   		       size_t buflen, off_t skip)
>>   {
>> -	unsigned int offset = 0;
>> -	struct sg_mapping_iter miter;
>> -	unsigned int sg_flags = SG_MITER_ATOMIC | SG_MITER_TO_SG;
>> -
>> -	sg_miter_start(&miter, sgl, nents, sg_flags);
>> -
>> -	if (!sg_miter_skip(&miter, skip))
>> -		return false;
>> -
>> -	while (offset < buflen && sg_miter_next(&miter)) {
>> -		unsigned int len;
>> -
>> -		len = min(miter.length, buflen - offset);
>> -		memset(miter.addr, 0, len);
>> -
>> -		offset += len;
>> -	}
>> -
>> -	sg_miter_stop(&miter);
>> -	return offset;
>> +	return sgl_memset(sgl, nents, skip, 0, buflen);
>>   }
>>   EXPORT_SYMBOL(sg_zero_buffer);
> 
> May as well make this one liner a static inline in the header. Just
> rename this function to sgl_memset so the diff is clearer

Yes, fine. I can roll a new version.

Doug Gilbert


