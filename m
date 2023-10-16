Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F284D7C9D5F
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Oct 2023 04:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjJPCXN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Oct 2023 22:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjJPCXN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Oct 2023 22:23:13 -0400
Received: from out-201.mta1.migadu.com (out-201.mta1.migadu.com [95.215.58.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3E0AB
        for <linux-rdma@vger.kernel.org>; Sun, 15 Oct 2023 19:23:11 -0700 (PDT)
Message-ID: <16e04d5b-a860-0d67-19f7-9efeedebf704@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697422987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I0XyxhpdLNmNOn2gRxOqHSHgBWiUys/lWFvxBQjTWMU=;
        b=B7V5zCKzUFPSikN147QKlCLHMwm/1lI0nX6Wp1e6PHfcUgcnkgSAtt7cPIhEudj1Lo3bb2
        zXKYFBAJRbwvjQXplC+YmfgR9T4/RqE9I+OaEHP19H1fSb4BvztgSji76msKCmAJztzX7x
        H6kdsBonu9kVlqQve7srNGyU59UizQc=
Date:   Mon, 16 Oct 2023 10:22:59 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 00/19] Cleanup for siw
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
 <SN7PR15MB5755F8C0177A3D305F98C2E699D2A@SN7PR15MB5755.namprd15.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <SN7PR15MB5755F8C0177A3D305F98C2E699D2A@SN7PR15MB5755.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi  Bernard,

On 10/13/23 23:45, Bernard Metzler wrote:
>> -----Original Message-----
>> From: Guoqing Jiang <guoqing.jiang@linux.dev>
>> Sent: Monday, October 9, 2023 9:18 AM
>> To: Bernard Metzler <BMT@zurich.ibm.com>; jgg@ziepe.ca; leon@kernel.org
>> Cc: linux-rdma@vger.kernel.org
>> Subject: [EXTERNAL] [PATCH 00/19] Cleanup for siw
>>
>> Hi,
>>
>> This series aim to cleanup siw code, please review and comment!
>>
>> Thanks,
>> Guoqing
>>
>> Guoqing Jiang (19):
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
>>
>>   drivers/infiniband/sw/siw/siw.h       |   9 +-
>>   drivers/infiniband/sw/siw/siw_cm.c    | 154 +++++++++++---------------
>>   drivers/infiniband/sw/siw/siw_main.c  |  30 +++--
>>   drivers/infiniband/sw/siw/siw_mem.c   |  22 ++--
>>   drivers/infiniband/sw/siw/siw_qp.c    |   2 +-
>>   drivers/infiniband/sw/siw/siw_qp_rx.c |  84 ++++++--------
>>   drivers/infiniband/sw/siw/siw_qp_tx.c |  34 +++---
>>   drivers/infiniband/sw/siw/siw_verbs.c |  23 +---
>>   8 files changed, 142 insertions(+), 216 deletions(-)
>>
>> --
>> 2.35.3
> Hi Guoqing,
>
> I'll have a look later next week. Currently on vacation.
> Thanks, Bernard.

No hurry, enjoy your vacation first :)

BTW, v2 is here.

https://lore.kernel.org/linux-rdma/20231013020053.2120-1-guoqing.jiang@linux.dev/T/#t

Thanks,
Guoqing
