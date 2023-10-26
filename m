Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BCD7D7CEF
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Oct 2023 08:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjJZGiY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 02:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjJZGiX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 02:38:23 -0400
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFF3AC
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 23:38:20 -0700 (PDT)
Message-ID: <f229bac8-9054-f040-4d43-41d2ec7a1daf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698302299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/j9X3wezhUuV1o5A/+ELdIGPdRkdoq2ilvdn84sroXs=;
        b=Q65ThSmO+fw79vxka80YDEB4mjAhaK3fxoRYRFCBuZrSzq7YqjueU/4qpizkZZon4PkELz
        3lY4LCqLlf1EoKS5k0u/eBU5bNVnd2veo+u+4hQhCLRKAMV5uNnnNyJvQn+1ZGNAanqTNN
        mYqL48XxBK88WXb8nL8xqhhnk/HnW4Q=
Date:   Thu, 26 Oct 2023 14:38:12 +0800
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH 04/19] RDMA/siw: Remove goto lable in siw_mmap
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
 <20231009071801.10210-5-guoqing.jiang@linux.dev>
 <SN7PR15MB575501E02141D857B6A9E48699DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <SN7PR15MB575501E02141D857B6A9E48699DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 10/25/23 20:38, Bernard Metzler wrote:
>> -----Original Message-----
>> From: Guoqing Jiang<guoqing.jiang@linux.dev>
>> Sent: Monday, October 9, 2023 9:18 AM
>> To: Bernard Metzler<BMT@zurich.ibm.com>;jgg@ziepe.ca;leon@kernel.org
>> Cc:linux-rdma@vger.kernel.org
>> Subject: [EXTERNAL] [PATCH 04/19] RDMA/siw: Remove goto lable in siw_mmap
>>
>> Remove unnecessary label since the failure case only need to
>> print warning message.
> I think you suggest removing it since the code falls through to the
> useless label anyway and not since it prints a warning.

Yes, exactly, sorry for the confusion. Will rephrase it to

"Let's remove it since the failure case only falls through
to the useless label."

>> Signed-off-by: Guoqing Jiang<guoqing.jiang@linux.dev>
>> ---
>>   drivers/infiniband/sw/siw/siw_verbs.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
>> b/drivers/infiniband/sw/siw/siw_verbs.c
>> index c5c27db9c2fe..dcd69fc01176 100644
>> --- a/drivers/infiniband/sw/siw/siw_verbs.c
>> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
>> @@ -66,12 +66,9 @@ int siw_mmap(struct ib_ucontext *ctx, struct
>> vm_area_struct *vma)
>>   	entry = to_siw_mmap_entry(rdma_entry);
>>
>>   	rv = remap_vmalloc_range(vma, entry->address, 0);
>> -	if (rv) {
>> +	if (rv)
>>   		pr_warn("remap_vmalloc_range failed: %lu, %zu\n", vma->vm_pgoff,
>>   			size);
>> -		goto out;
>> -	}
>> -out:
>>   	rdma_user_mmap_entry_put(rdma_entry);
>>
>>   	return rv;
>> --
>> 2.35.3
> Thanks, makes sense!
>
> Acked-by: Bernard Metzler<bmt@zurich.ibm.com>

Thank you!

Guoqing
