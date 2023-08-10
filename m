Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE76776D6B
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Aug 2023 03:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjHJBOZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Aug 2023 21:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHJBOY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Aug 2023 21:14:24 -0400
Received: from out-93.mta1.migadu.com (out-93.mta1.migadu.com [95.215.58.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E209F1BD
        for <linux-rdma@vger.kernel.org>; Wed,  9 Aug 2023 18:14:23 -0700 (PDT)
Message-ID: <cf3a252d-ec2e-de29-56d3-ef37d4aa1600@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691630062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BJZSZQwJPhMYTnO0b0j2YO1PgS4DGwGd1Cv+OS7lzwI=;
        b=AmGjn5Zy6eBG+PMU2oEIzErgq1j8g2yaRb/jO/NLoa2nLBXz4YLLOsQsuFz4DkLw4tt2ak
        EB3NK6LZ1hL178qZix0e9qbDcR1GOsVfaxohj8+VCapa3B1Q4rvHKAC2lMpJs9pTFDt4H9
        alHCleD3PSuCWniC2y59lGNsIwIkfXI=
Date:   Thu, 10 Aug 2023 09:14:16 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 0/5] Fix potential issues for siw
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     bmt@zurich.ibm.com, leon@kernel.org, linux-rdma@vger.kernel.org
References: <20230727140349.25369-1-guoqing.jiang@linux.dev>
 <ZNPjQ0mknxtO6Fwa@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <ZNPjQ0mknxtO6Fwa@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 8/10/23 03:04, Jason Gunthorpe wrote:
> On Thu, Jul 27, 2023 at 10:03:44PM +0800, Guoqing Jiang wrote:
>> Hi,
>>
>> Several issues appeared if we rmmod siw module after failed to insert
>> the module (with manual change like below).
>>
>> --- a/drivers/infiniband/sw/siw/siw_main.c
>> +++ b/drivers/infiniband/sw/siw/siw_main.c
>> @@ -577,6 +577,7 @@ static __init int siw_init_module(void)
>>          if (rv)
>>                  goto out_error;
>>
>> +       goto out_error;
>>          rdma_link_register(&siw_link_ops);
>>
>> Basically, these issues are double free, use before initalization or
>> null pointer dereference. For more details, pls review the individual
>> patch.
>>
>> Thanks,
>> Guoqing
>>
>> Guoqing Jiang (5):
>>    RDMA/siw: Set siw_cm_wq to NULL after it is destroyed
>>    RDMA/siw: Ensure siw_destroy_cpulist can be called more than once
>>    RDMA/siw: Initialize siw_link_ops.list
>>    RDMA/siw: Set siw_crypto_shash to NULL after it is freed
>>    RDMA/siw: Don't call wake_up unconditionally in siw_stop_tx_thread
> What is the status of this series? Bernards fix for some of this was
> already merged and this doesn't apply, so regardless it needs
> resending.

After Bernard's fix was already merged, and other patches are not needed
since it is impossible to trigger them in real life. So pls just ignore this
series.

Thanks,
Guoqing
