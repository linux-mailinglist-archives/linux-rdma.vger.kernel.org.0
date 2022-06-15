Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5877454C64D
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 12:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345138AbiFOKez (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 06:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346566AbiFOKeb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 06:34:31 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D8513EA3
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 03:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=From:To:Date:Message-ID:CC;
        bh=Lse+lm8rSlaaio6GnYPJAHb88djrZ1ncPLKMrIvgWfE=; b=XOwagD9+3VuvNSmz9x+L55uUb0
        wn3LusaEXCDV/G0CC7leZKI8kH6FM8I8EFxdVUq7soVJI0qgM82BdowwjgrYJfARWpvDh074CU8Uv
        jlv3Yxqwehdol3+B3R94BTD5k43Gb9YUzphNSliKWUTJI12xR2mIZz27EzO3em+qJyOi9sniArQ2Z
        PiVEdv4jPzTJKHIJM6YHBw2IVhsyKnxtXjkjMBi1aSJiFsBK7u6O+XXIFmLr0+7ARR668BFePVxgB
        XkSx+QlPnA1TxOKAYMQvH4W9ie+eLX7jjzO3zog+fCZWRWUTSJ5L/mnsootH6nmdT5VToz9OvGMrH
        PoivcmN5UEHfnWGRtg7EOnVKpkyBlJT5NawGCwA5gjBBuZd5N087Wnm/oh4K6spQZ/yo2qjZ8BX8p
        F15BWEb7zjgN6Lyp+6jH0d/X9zqIfLoz2NuJMAdwT9tmyissp4bcRjEdSuGV1r03viAj6PfGBHlDd
        lVYztPqXoJRs2E2XwG3yXHI2;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1o1QLz-005q0O-V8; Wed, 15 Jun 2022 10:34:28 +0000
Message-ID: <6a4cbd89-ca94-aee4-9fa1-cbcfa365a68c@samba.org>
Date:   Wed, 15 Jun 2022 12:34:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 5/7] rdma/siw: start mpa timer before calling
 siw_send_mpareqrep()
Content-Language: en-US
To:     Cheng Xu <chengyou@linux.alibaba.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        linux-rdma@vger.kernel.org
References: <cover.1655248086.git.metze@samba.org>
 <505a18c83a283963174c9e567ce73d055e26ec7b.1655248086.git.metze@samba.org>
 <070fc3c2-69ec-9ad0-1bf5-8aa97d1564df@linux.alibaba.com>
From:   Stefan Metzmacher <metze@samba.org>
In-Reply-To: <070fc3c2-69ec-9ad0-1bf5-8aa97d1564df@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Cheng,
> On 6/15/22 4:40 PM, Stefan Metzmacher wrote:
>> The mpa timer will also span the non-blocking connect
>> in the final patch.
>>
>> Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>> Signed-off-by: Stefan Metzmacher <metze@samba.org>
>> Cc: Bernard Metzler <bmt@zurich.ibm.com>
>> Cc: linux-rdma@vger.kernel.org
>> ---
>>   drivers/infiniband/sw/siw/siw_cm.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
>> index b19a2b777814..3fee1d4ef252 100644
>> --- a/drivers/infiniband/sw/siw/siw_cm.c
>> +++ b/drivers/infiniband/sw/siw/siw_cm.c
>> @@ -1476,6 +1476,11 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
>>           cep->mpa.hdr.params.pd_len = pd_len;
>>       }
>> +    rv = siw_cm_queue_work(cep, SIW_CM_WORK_MPATIMEOUT);
>> +    if (rv != 0) {
>> +        goto error;
>> +    }
>> +
>>       cep->state = SIW_EPSTATE_AWAIT_MPAREP;
> 
> Here starts the MPA timer, but the cep->state is SIW_EPSTATE_CONNECTING.
> 
> Consider the case when the connection timeout: the MPA timeout handler
> will release resources if cep->state is SIW_EPSTATE_AWAIT_MPAREP and
> SIW_EPSTATE_AWAIT_MPAREQ, not including SIW_EPSTATE_CONNECTING.
> 
> I think you should handle this case in the MPA timeout handler: report
> a cm event and set release_cep with 1. Otherwise it will cause resource
> leak.

Yes, you're right.

I've actually fixed it in the rest of the patchset I have.
It seems I need to pull in a few more patches into the first chunk.

metze
