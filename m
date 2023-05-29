Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48747714EE3
	for <lists+linux-rdma@lfdr.de>; Mon, 29 May 2023 19:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjE2RUM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 May 2023 13:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE2RUL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 May 2023 13:20:11 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B54FAB
        for <linux-rdma@vger.kernel.org>; Mon, 29 May 2023 10:20:10 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-39831cb47c6so1163387b6e.2
        for <linux-rdma@vger.kernel.org>; Mon, 29 May 2023 10:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685380809; x=1687972809;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tKHvbgdSlt80lgWkqXJFhTQj8qozxs0n+wq2xAkxMEc=;
        b=MeDFXJzVru2tcSnmzIxleirURjVNuv/ne9hFXVdRLqtANF8xwvd/3/HZcMZ3b/D8iP
         HBrFqBRJ4WBsgPRrFDxj2XnfY6tsdUF8IopglS0J4yIC1MeTz/pHqVV/A+itlMo3+DHq
         OW4QfcT+oQ3FKg1vJCVayXDcLK4X5OokLNz+2L1+tmAkF2NFj8Tqnl/b2+KXujq6NEtC
         wO+4j0pjiO91l0fbOfsH/Q/5S7ovt2gAl5vNCXLnu6LeYgDcR3zXPyNYG4nqFpljV+fP
         DkYokFWXmS/SQvkPXpgSWEPqSO9/QiUHZZbM//nDurnU/htNu673iWlRj/p32b1NyJ3b
         cF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685380809; x=1687972809;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tKHvbgdSlt80lgWkqXJFhTQj8qozxs0n+wq2xAkxMEc=;
        b=IIU0AcZCNJktUm0Z7HpiYA190EoX4n5N8sH9vfRaAsxj86oqRJVtilYsIs3z2zrTHz
         dUZ5Pk3L3ku9zCqshEg8mG0QYeEJXLtQCsltsD8BczkdDZk7zXWChqI72h3QjRJyucGQ
         zCyr92v63U2eUdrkEYwPODOGdWzdPYfLXDbDk510NDtM7ZuPgecKFkSgzWXc2/Co/3so
         YwuRwy7wnWD92VXD9q+jZmelZziHrz4mBoK/eBIcan/XvpHSFpeA7/kPqDgPVSKXkqJh
         S+ts7LsCRXRusP0Mx/rc4/FT1YokP2SZQYyu0E3zbdWiFIpJe5slN1shX9y6H4Gcqw5Z
         ShsA==
X-Gm-Message-State: AC+VfDy7Hi42OjyVpQSec9BHxzqrDMH2wPP39+0SgYSJP8svrF2gOLPb
        5okvykd8Egyu5rxN+rjFgwun8eXdyHKdrA==
X-Google-Smtp-Source: ACHHUZ71+jXg53MtgbDz+pbHCnZomLEaAJdCykRYccWtJRS9JJMpItRB1tzhN6+jWni2noM9uxaSyg==
X-Received: by 2002:a05:6808:140f:b0:398:f48:eb4 with SMTP id w15-20020a056808140f00b003980f480eb4mr6993171oiv.36.1685380809291;
        Mon, 29 May 2023 10:20:09 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:bd71:7fe:392d:ac1f? (2603-8081-140c-1a00-bd71-07fe-392d-ac1f.res6.spectrum.com. [2603:8081:140c:1a00:bd71:7fe:392d:ac1f])
        by smtp.gmail.com with ESMTPSA id t12-20020a4ae9ac000000b005555797999dsm4350776ood.17.2023.05.29.10.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 10:20:08 -0700 (PDT)
Message-ID: <27279077-ddb6-7060-97ac-ae36f5575d3d@gmail.com>
Date:   Mon, 29 May 2023 12:20:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC] tests: Fix test_mr_rereg_pd
Content-Language: en-US
To:     Edward Srouji <edwards@nvidia.com>, idok@nvidia.com,
        jgg@nvidia.com, linux-rdma@vger.kernel.org
References: <20230525042517.14657-1-rpearsonhpe@gmail.com>
 <4efc60d6-e281-031c-16ba-ba0f18384513@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <4efc60d6-e281-031c-16ba-ba0f18384513@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/29/23 05:48, Edward Srouji wrote:
> I see that the traffic() function used in this test posts just one receive/send WR each iteration.
> Meaning that once the first CQE with error occurs, there are no more CQEs left to drain.
I believe it is the receive WQEs that are getting flushed.
> 
> If that is the case, I'm not sure why you still see stray completions in the CQ.
> 
> On 5/25/2023 7:25 AM, Bob Pearson wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> This patch adds a util method drain_cq which drains out
>> the cq associated with a client or server. This is then
>> added to the method restate_qps in tests/test_mr.py.
>> This allows correct operation when recovering test state
>> from an error which may have also left stray completions
>> in the cqs before resetting the qps for use.
>>
>> Fixes: 4bc72d894481 ("tests: Add rereg MR tests")
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>   tests/test_mr.py |  2 ++
>>   tests/utils.py   | 14 ++++++++++++++
>>   2 files changed, 16 insertions(+)
>>
>> diff --git a/tests/test_mr.py b/tests/test_mr.py
>> index 534df46a..73dfbff2 100644
>> --- a/tests/test_mr.py
>> +++ b/tests/test_mr.py
>> @@ -109,6 +109,8 @@ class MRTest(RDMATestCase):
>>           self.server.qp.to_rts(self.server_qp_attr)
>>           self.client.qp.modify(QPAttr(qp_state=e.IBV_QPS_RESET), e.IBV_QP_STATE)
>>           self.client.qp.to_rts(self.client_qp_attr)
>> +        u.drain_cq(self.client.cq)
>> +        u.drain_cq(self.server.cq)
>>
>>       def test_mr_rereg_access(self):
>>           self.create_players(MRRes)
>> diff --git a/tests/utils.py b/tests/utils.py
>> index a1dfa7d8..f6966b1a 100644
>> --- a/tests/utils.py
>> +++ b/tests/utils.py
>> @@ -672,6 +672,20 @@ def poll_cq_ex(cqex, count=1, data=None, sgid=None):
>>       finally:
>>           cqex.end_poll()
> Keep two blank lines before and after module-level function definition (PEP-8 convention)
>> +def drain_cq(cq):
>> +    """
>> +    Drain completions from a CQ.
>> +    :param cq: CQ to drain
>> +    :return: None
>> +    """
>> +    channel = cq.comp_channel
>> +    while 1:
>> +        if channel:
>> +            channel.get_cq_event(cq)
>> +            cq.req_notify()
>> +        nc, tmp_wcs = cq.poll(1)
> 
> tmp_wcs is unused. You can do this instead:
> 
> nc, _ = cq.poll(1)
> 
>> +        if nc == 0:
>> +            break
>>
>>   def validate(received_str, is_server, msg_size):
>>       """
>> -- 
>> 2.39.2
>>

Thanks, I can fix those.

Bob

