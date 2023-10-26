Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C2E7D7D34
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Oct 2023 09:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjJZHCm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 03:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZHCm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 03:02:42 -0400
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [IPv6:2001:41d0:203:375::b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E430191
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 00:02:39 -0700 (PDT)
Message-ID: <daadc08a-9b00-b7a9-0c03-d8764ddabb88@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698303758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5NR5AR8tsv29iZQrVJCrO4rE6l9w1vt8CHO3hEvOotQ=;
        b=kLBn7/T46gxLQALPKAIeZgIxnsVIJUYsWGdJaqjJtZV4xzI5zSX/7GunNefLfohQ11wPBm
        TPh+Pjnm8gsrAEUif7zQQam8OJhJdrnIkoI7nB0i4S7khJuxCnhPZwKUisIMAuAP6eA83j
        On+ti3MljJiKBaEVlzR+6P2Q74oeRMo=
Date:   Thu, 26 Oct 2023 15:02:35 +0800
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH V2 00/20] Cleanup for siw
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20231013020053.2120-1-guoqing.jiang@linux.dev>
 <SN7PR15MB575586FBFD184670B5893C3A99DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <SN7PR15MB575586FBFD184670B5893C3A99DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bernard,

On 10/25/23 21:37, Bernard Metzler wrote:
>> -----Original Message-----
>> From: Guoqing Jiang<guoqing.jiang@linux.dev>
>> Sent: Friday, October 13, 2023 4:01 AM
>> To: Bernard Metzler<BMT@zurich.ibm.com>;jgg@ziepe.ca;leon@kernel.org
>> Cc:linux-rdma@vger.kernel.org
>> Subject: [EXTERNAL] [PATCH V2 00/20] Cleanup for siw
>>
>> V2 changes:
>> 1. address W=1 warning in patch 12 and 19 per the report from lkp.
>> 2. add one more patch (20th).
>>
>> Hi,
>>
>> This series aim to cleanup siw code, please review and comment!
>>
>> Thanks,
>> Guoqing
>>
>> Guoqing Jiang (20):
>>    RDMA/siw: Introduce siw_get_page
>>    RDMA/siw: Introduce siw_srx_update_skb
>>    RDMA/siw: Use iov.iov_len in kernel_sendmsg
>>    RDMA/siw: Remove goto lable in siw_mmap
>>    RDMA/siw: Remove rcu from siw_qp
>>    RDMA/siw: No need to check term_info.valid before call
>>      siw_send_terminate
>>    RDMA/siw: Also goto out_sem_up if pin_user_pages returns 0
>>    RDMA/siw: Factor out siw_generic_rx helper
>>    RDMA/siw: Introduce SIW_STAG_MAX_INDEX
>>    RDMA/siw: Add one parameter to siw_destroy_cpulist
>>    RDMA/siw: Introduce siw_cep_set_free_and_put
>>    RDMA/siw: Introduce siw_free_cm_id
>>    RDMA/siw: Simplify siw_qp_id2obj
>>    RDMA/siw: Simplify siw_mem_id2obj
>>    RDMA/siw: Cleanup siw_accept
>>    RDMA/siw: Remove siw_sk_assign_cm_upcalls
>>    RDMA/siw: Fix typo
>>    RDMA/siw: Only check attrs->cap.max_send_wr in siw_create_qp
>>    RDMA/siw: Introduce siw_destroy_cep_sock
>>    RDMA/siw: Update comments for siw_qp_sq_process
>>
>>   drivers/infiniband/sw/siw/siw.h       |   9 +-
>>   drivers/infiniband/sw/siw/siw_cm.c    | 154 +++++++++++---------------
>>   drivers/infiniband/sw/siw/siw_main.c  |  30 +++--
>>   drivers/infiniband/sw/siw/siw_mem.c   |  22 ++--
>>   drivers/infiniband/sw/siw/siw_qp.c    |   2 +-
>>   drivers/infiniband/sw/siw/siw_qp_rx.c |  84 ++++++--------
>>   drivers/infiniband/sw/siw/siw_qp_tx.c |  39 +++----
>>   drivers/infiniband/sw/siw/siw_verbs.c |  23 +---
>>   8 files changed, 144 insertions(+), 219 deletions(-)
>>
>>
>> base-commit: 964168970cef5f5b738fae047e6de2107842feb7
>> --
>> 2.35.3
> Hi Guoqing,
> Thanks for the effort! I like most of it.
>
> And, sorry, I saw I started my review with version 1 of your
> patches. Luckily it does not have functional differences to
> v2.

Thanks a lot for your review! I have replied  them separately.

> But I expect a version 3 anyway.

No problem, will do it.

> I currently do not have access to physical machines to check and
> run the more complex patches. I hope to do that (patch 08,10,12,15)
> tomorrow when back in office.

More check and running test with physical machines would be great :).
I have run some tests (blktests and xfstests) in VM against nvme host
which connected to nvme target through siw.

Thanks,
Guoqing
