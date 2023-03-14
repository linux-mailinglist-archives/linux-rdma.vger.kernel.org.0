Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3096B91AF
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Mar 2023 12:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjCNLeN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Mar 2023 07:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjCNLeM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Mar 2023 07:34:12 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA02C7D9D
        for <linux-rdma@vger.kernel.org>; Tue, 14 Mar 2023 04:34:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VdsD04E_1678793646;
Received: from 30.221.99.181(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VdsD04E_1678793646)
          by smtp.aliyun-inc.com;
          Tue, 14 Mar 2023 19:34:07 +0800
Message-ID: <560200e2-0428-4743-6af5-01df785c76db@linux.alibaba.com>
Date:   Tue, 14 Mar 2023 19:34:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH for-next v2 2/2] RDMA/erdma: Support non-4K page size in
 doorbell allocation
Content-Language: en-US
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
References: <20230307102924.70577-1-chengyou@linux.alibaba.com>
 <20230307102924.70577-3-chengyou@linux.alibaba.com>
 <20230314102313.GB36557@unreal>
 <5b0cc34d-a185-d9b4-c312-27bc959d929d@linux.alibaba.com>
In-Reply-To: <5b0cc34d-a185-d9b4-c312-27bc959d929d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 3/14/23 7:31 PM, Cheng Xu wrote:
> 
> 
> On 3/14/23 6:23 PM, Leon Romanovsky wrote:
>> On Tue, Mar 07, 2023 at 06:29:24PM +0800, Cheng Xu wrote:
>>> Doorbell resources are exposed to userspace by mmap. The size unit of mmap
>>> is PAGE_SIZE, previous implementation can not work correctly if PAGE_SIZE
>>> is not 4K. We support non-4K page size in this commit.
>>
>> Why do you need this information in rdma-core?
>> Can you use sysconf(_SC_PAGESIZE) there to understand the page size like
>> other providers?
>>
> 
> I don't expose PAGE_SIZE to userspace in this patchset, but the *offset* in
> PAGE of the DBs:
> 
> diff --git a/include/uapi/rdma/erdma-abi.h b/include/uapi/rdma/erdma-abi.h
> index b7a0222f978f..57f8942a3c56 100644
> --- a/include/uapi/rdma/erdma-abi.h
> +++ b/include/uapi/rdma/erdma-abi.h
> @@ -40,10 +40,13 @@ struct erdma_uresp_alloc_ctx {
>  	__u32 dev_id;
>  	__u32 pad;
>  	__u32 sdb_type;
> -	__u32 sdb_offset;
> +	__u32 sdb_entid;
>  	__aligned_u64 sdb;
>  	__aligned_u64 rdb;
>  	__aligned_u64 cdb;
> +	__u32 sdb_off;
> +	__u32 rdb_off;
> +	__u32 cdb_off;
>  };
> 
> Our doorbell space is aligned to 4096
> 

Please ignore these two response. There is something wrong with my Thunderbird:
When I press ctrl + s, it send the email, not save it.

Sorry for this.

Cheng Xu

> 
> 
>> Thanks
