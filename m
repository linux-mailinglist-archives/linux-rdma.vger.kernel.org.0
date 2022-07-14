Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B69F5752AF
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jul 2022 18:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239000AbiGNQYU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jul 2022 12:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239053AbiGNQYO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jul 2022 12:24:14 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795501FCEE
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 09:24:13 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10c8e8d973eso3057133fac.5
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 09:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=E+ud+eVwjpqXP6wthSzb1i7O4/fFJxGDv6+IV1ZWU1I=;
        b=pRbJi5LAkLD9FnhGR1UsTtUwkdJNKfegtJ+kO6EZYV3DrF5+19UVuW8Zdmf9PI4RQ8
         V2M8iEC/g7vjYsrvfEcvHzXTYV1VNSMOALbqGY963sGX6dCm3sWNx1osAZam09DCy36G
         ZxekPVS15d1xjTY6+sieF/EDOmSf27DnL11kqCeV9bMfakInkUeZKuM/QmUQsCm4eFib
         NLJ5Y9hN+/5odhP0kIOQ5KOjQsCOAhKD3lNC/4cRefKm9gXhSxFKxae6lsKbM156q7UK
         RkPClnPrrqTgXoN714zIjIa9Ee7bWMNJReNQnhycVDg7y8oSnCMUndq4bF8nwYTEADE+
         w69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E+ud+eVwjpqXP6wthSzb1i7O4/fFJxGDv6+IV1ZWU1I=;
        b=RDq6DgS5yRO/uxLrvAs9F71eRjJkx622nDo7mg1kFL/95Br8+zKyhUdvaUCG7g8IhL
         Oa2QIXz6uTAt0nRDZIDyf+SAmDKV77KXJ5gQaIXRlpLLTtRQ6NW74reBqR8jgNAvG7gj
         Nn364hFGg6413xK43QoX4+WC70RQzISooX7wmsmxJ4DZxU3n5zi6A0GNy0iYCYEpwn0u
         NLoOxjpg2R29rBL42+hF40iQuWF9UkF4Pfpx9G01eErLdcpxqHx5DozOUtvA7hvHeJv2
         xZcArR0cC9qAa4oKC+AJjF2hLAmQMzcY9f0koRjDAsOjODySDq5WAfv3F+HUZtmupvoy
         ltOQ==
X-Gm-Message-State: AJIora+QLTOjrjkec+qjgybUxFF4GrywMzRWKooOb/c38foFGlmKGKJJ
        CGu+QKyrwmoAub/CTqzmoTU=
X-Google-Smtp-Source: AGRyM1sroVTESdjurIsZK6NB/SUkgv+CQbRLz0TX2YLQ+FFp0yHrDOSUs/mYmHsOGJ5I5eTE76sBxQ==
X-Received: by 2002:a05:6871:808:b0:101:dcbb:4e6e with SMTP id q8-20020a056871080800b00101dcbb4e6emr4793699oap.166.1657815852845;
        Thu, 14 Jul 2022 09:24:12 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:e02a:9936:8f26:4598? (2603-8081-140c-1a00-e02a-9936-8f26-4598.res6.spectrum.com. [2603:8081:140c:1a00:e02a:9936:8f26:4598])
        by smtp.gmail.com with ESMTPSA id bu27-20020a0568300d1b00b0061b8653b0c9sm846390otb.22.2022.07.14.09.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 09:24:12 -0700 (PDT)
Message-ID: <f6c8167c-649e-decf-ca10-3bcd8cc24deb@gmail.com>
Date:   Thu, 14 Jul 2022 11:24:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH] RDMA/rxe: Remove unused qp parameter
Content-Language: en-US
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
References: <20220708013934.5022-1-yangx.jy@fujitsu.com>
 <dfb4b44a-41de-3149-1e8c-98c66b603eb5@fujitsu.com>
 <ef65f814-1ba5-ab16-0d55-bf804e2c9e49@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <ef65f814-1ba5-ab16-0d55-bf804e2c9e49@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/7/22 22:54, yangx.jy@fujitsu.com wrote:
> On 2022/7/8 9:57, Yang, Xiao/杨 晓 wrote:
>> Hi All,
>>
>> Is there anyone who can receive my new patches from Linux RDMA mail list?
>> [PATCH] RDMA/rxe: Remove unused qp parameter
>> [PATCH v5 0/2] RDMA/rxe: Add RDMA Atomic Write operation
>>
>> I have sent them to Linux RDMA mail list but they cannot be shown on:
>> https://lore.kernel.org/linux-rdma/
> 
> Sorry, my smtp server doesn't work. I will resend them shortly.
> 
> Best Regards,
> Xiao Yang
>>
>> Best Regards,
>> Xiao Yang
>>
>> On 2022/7/8 9:39, Xiao Yang wrote:
>>> The qp parameter in free_rd_atomic_resource() has become
>>> unused so remove it directly.
>>>
>>> Fixes: 15ae1375ea91 ("RDMA/rxe: Fix qp reference counting for atomic 
>>> ops")
>>> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
>>> ---
>>>   drivers/infiniband/sw/rxe/rxe_loc.h  | 2 +-
>>>   drivers/infiniband/sw/rxe/rxe_qp.c   | 6 +++---
>>>   drivers/infiniband/sw/rxe/rxe_resp.c | 2 +-
>>>   3 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h 
>>> b/drivers/infiniband/sw/rxe/rxe_loc.h
>>> index 0e022ae1b8a5..336164843db4 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
>>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
>>> @@ -145,7 +145,7 @@ static inline int rcv_wqe_size(int max_sge)
>>>           max_sge * sizeof(struct ib_sge);
>>>   }
>>> -void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res);
>>> +void free_rd_atomic_resource(struct resp_res *res);
>>>   static inline void rxe_advance_resp_resource(struct rxe_qp *qp)
>>>   {
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c 
>>> b/drivers/infiniband/sw/rxe/rxe_qp.c
>>> index 8355a5b1cb60..9ecb98150e0e 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>>> @@ -120,14 +120,14 @@ static void free_rd_atomic_resources(struct 
>>> rxe_qp *qp)
>>>           for (i = 0; i < qp->attr.max_dest_rd_atomic; i++) {
>>>               struct resp_res *res = &qp->resp.resources[i];
>>> -            free_rd_atomic_resource(qp, res);
>>> +            free_rd_atomic_resource(res);
>>>           }
>>>           kfree(qp->resp.resources);
>>>           qp->resp.resources = NULL;
>>>       }
>>>   }
>>> -void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res)
>>> +void free_rd_atomic_resource(struct resp_res *res)
>>>   {
>>>       res->type = 0;
>>>   }
>>> @@ -140,7 +140,7 @@ static void cleanup_rd_atomic_resources(struct 
>>> rxe_qp *qp)
>>>       if (qp->resp.resources) {
>>>           for (i = 0; i < qp->attr.max_dest_rd_atomic; i++) {
>>>               res = &qp->resp.resources[i];
>>> -            free_rd_atomic_resource(qp, res);
>>> +            free_rd_atomic_resource(res);
>>>           }
>>>       }
>>>   }
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c 
>>> b/drivers/infiniband/sw/rxe/rxe_resp.c
>>> index 265e46fe050f..28033849d404 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>>> @@ -562,7 +562,7 @@ static struct resp_res *rxe_prepare_res(struct 
>>> rxe_qp *qp,
>>>       res = &qp->resp.resources[qp->resp.res_head];
>>>       rxe_advance_resp_resource(qp);
>>> -    free_rd_atomic_resource(qp, res);
>>> +    free_rd_atomic_resource(res);
>>>       res->type = type;
>>>       res->replay = 0;

This is correct.

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
