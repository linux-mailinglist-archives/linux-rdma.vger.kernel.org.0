Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D18C609550
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Oct 2022 20:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiJWSFk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Oct 2022 14:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiJWSFj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Oct 2022 14:05:39 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8205B4D81F;
        Sun, 23 Oct 2022 11:05:36 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id y72so8825238oia.3;
        Sun, 23 Oct 2022 11:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vIkYcAuPNC2VZr6XaUkofhf+zx2CPN+Q3gq7bfVVVgs=;
        b=VsYKXxm6CHaiX7K0eZCBPSinJHT5CS1DpO5xKAxZtl5m3onGgfI6XLFNVK80bwQfUh
         P9Cc2YGKGX51Hv5eAYHzx7g2EzarZRw3FbnV5lMkBVHLdKR8qxKHP7s38JzNXHl8AErZ
         +Exsj1o9K6pLbZHiJUkZ+fVVoj1hqNMrUt9veLfWnuB3iwgoHuQhnFDZXftpX4yeX6ZS
         KMpgN0kqP/VGVUtcU+vVzn6zSgMIEEg2ay8VRvPc2dBr6sKpCuMX8P8Xie/dX5vIcu/4
         NIGZ1ABBPD0+iJFoMvDQpICH6EUF6ZZfcWIQUeMzt0rFJ0EDaSDb9Y5IzBBZYlXGw7z6
         IbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vIkYcAuPNC2VZr6XaUkofhf+zx2CPN+Q3gq7bfVVVgs=;
        b=CbiwfTM5720UAHGjgOKgFLPU4pkaTee+TzKCXozOozg4TLrmsX+23yR5rAV/UUINqZ
         86VOCEu9TG/OKYRNPXCgfdOZukiB+eRhEGsC1H92dShAd7edy2QLEF0k+uX4cVax9/A+
         E8wQb5PciCbxS37X4OssQoIj/tIywETV1dZDQEUKtrfqNo+ocED/I8Z1bO79ebIeA/q4
         RefEGaSba0sHtsx5uv8kqnnEquNYolzYfvrYGi7hAUbpzCJoCgF4LXmk4SugAYBbzelR
         8t0Jj69iDAykwlpUjmTpBvIocsG2OTZ+W4DkUZAvnK4/4p1sRYUJGBxT9QiWt0u5QmGC
         K4FA==
X-Gm-Message-State: ACrzQf1LK5ea9FmfYqSm72EM9z95W23Ywy2sODnBp35xrLYxXdFDaLL7
        /QCKnns71cxkFrG72aFMgac=
X-Google-Smtp-Source: AMsMyM5PSsB0AcGAdGpyC3coarqx8OUdSt76jr0koLYMpbPyZ/A7bhAuuH5WiKYhSnGWuaDCLQDnbw==
X-Received: by 2002:a05:6808:171b:b0:34d:444a:fc1e with SMTP id bc27-20020a056808171b00b0034d444afc1emr29013446oib.85.1666548335793;
        Sun, 23 Oct 2022 11:05:35 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:1e0:e60:c33:b344? (2603-8081-140c-1a00-01e0-0e60-0c33-b344.res6.spectrum.com. [2603:8081:140c:1a00:1e0:e60:c33:b344])
        by smtp.gmail.com with ESMTPSA id em40-20020a0568705ba800b001226d2100f2sm13037314oab.33.2022.10.23.11.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 11:05:35 -0700 (PDT)
Message-ID: <30ff25c4-ce66-eac4-eaa2-64c0db203a19@gmail.com>
Date:   Sun, 23 Oct 2022 13:05:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [for-next PATCH v2 1/2] RDMA/rxe: Remove unnecessary mr testing
Content-Language: en-US
To:     Li Zhijian <lizhijian@fujitsu.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1666338764-2-1-git-send-email-lizhijian@fujitsu.com>
 <1666338764-2-2-git-send-email-lizhijian@fujitsu.com>
 <CAD=hENeGMKri0nYMtcu98K2j3D+ZBkxO6fFX5cvvyJsEghrrmQ@mail.gmail.com>
 <1846f2e1-ff13-5fa2-240f-fd7749921ce2@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <1846f2e1-ff13-5fa2-240f-fd7749921ce2@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/21/22 20:09, Li Zhijian wrote:
> 
> 
> On 21/10/2022 22:39, Zhu Yanjun wrote:
>> On Fri, Oct 21, 2022 at 3:53 PM Li Zhijian <lizhijian@fujitsu.com> wrote:
>>> Before the testing, we already passed it to rxe_mr_copy() where mr could
>>> be dereferenced. so this checking is not exactly correct.
>>>
>>> I tried to figure out the details how/when mr could be NULL, but failed
>>> at last. Add a WARN_ON(!mr) to that path to tell us more when it
>>> happends.
>> If I get you correctly, you confronted a problem,
> Not exactly,  I removed the mr checking since i think this checking is not correct.
> the newly added WARN_ON(!mr) is the only once place where the mr can be NULL but not handled correctly.
> At least with/without this patch, once WARN_ON(!mr) is triggered, kernel will go something wrong.
> 
> so i want to place this  WARN_ON(!mr) to point to the problem.
> 
> Thanks
> Zhijian
> 
>>   but you can not figure it out.
>> So you send it upstream as a patch?
>>
>> I am not sure if it is a good idea.
>>
>> Zhu Yanjun
>>
>>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>>> ---
>>>   drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
>>> index ed5a09e86417..218c14fb07c6 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>>> @@ -778,6 +778,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>>          if (res->state == rdatm_res_state_new) {
>>>                  if (!res->replay) {
>>>                          mr = qp->resp.mr;
>>> +                       WARN_ON(!mr);
>>>                          qp->resp.mr = NULL;
>>>                  } else {
>>>                          mr = rxe_recheck_mr(qp, res->read.rkey);
>>> @@ -811,8 +812,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>>
>>>          rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
>>>                      payload, RXE_FROM_MR_OBJ);
>>> -       if (mr)
>>> -               rxe_put(mr);
>>> +       rxe_put(mr);
>>>
>>>          if (bth_pad(&ack_pkt)) {
>>>                  u8 *pad = payload_addr(&ack_pkt) + payload
>>> -- 
>>> 2.31.1
>>>
> 

Li is correct that the only way mr could be NULL is if qp->resp.mr == NULL. So the
'if (mr)' is not needed if that is the case. The read_reply subroutine is reached
from a new rdma read operation after going through check_rkey or from a previous
rdma read operations from get_req if qp->resp.res != NULL or from a duplicate request
where the previous responder resource is found. In all these cases the mr is set.
Initially in check_rkey where if it can't find the mr it causes an RKEY_VIOLATION.
Thereafter the rkey is stored in the responder resources and looked up for each
packet to get an mr or cause an RKEY_VIOLATION. So the mr can't be NULL. I think
you can leave out the WARN and just drop the if (mr).

Bob

