Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE6A526F3A
	for <lists+linux-rdma@lfdr.de>; Sat, 14 May 2022 09:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiENDZn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 May 2022 23:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiENDZm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 May 2022 23:25:42 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F60D37A35
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 20:25:38 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-f165bc447fso2912852fac.6
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 20:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=BMfPvl5SQdQMkYauG5CPc8rGsPOlXD2VCPPE3c9urZA=;
        b=DDcQNabOZQZUtp0zrmWqtXS5sF6P4//cC49RH8B87fAwXyna0vZKel9qjGPHtNr3cu
         tzuI5R3Qz2kIDY69vU09mXhXqN1C4zStX8AZoDR6MHj060fgrtFFzXfWaECa3zmpO0Zn
         OUKEryKapXugqeKrEBHcJPAqqpLDJE7ReehbrVdalY/9OdDcHpQZ1yu3cVUiXji65omx
         GauNduiOsouwGtQSOQluInNWQ8thz/XsaT2Ew7x3UTMdyhtAVKKf0rmFrbZUVX0rabaf
         t4RsUk1jltKIY4UpOPHxpeAHgR3ZN+eFAWuCWnNiLD8GBlCvnncW447XIARdZTP8+XfT
         Htfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BMfPvl5SQdQMkYauG5CPc8rGsPOlXD2VCPPE3c9urZA=;
        b=wCKtvWuRubOQIWK9y+YuQU1alInoe9Z9+Yt02b1lmPlzlu5lV0nuJGZ75mvwhUZUGX
         NLynCQ1K3vpyvhxEVJQ1VTErsLkbWlF1cfZYD32Jl/9KT2vddXDYI+Na2+bvoPV9FArd
         civuhkDWGC8JfscS/KCFyGxyCOQApIVYlpP1mNRh3C8l9uyjB+4kyNVs8Z6RC5ESlPdi
         zuqJSYRMun6Gwx3c0W2RVZ92+cSyUzh6tcvSardVR+DFy0mZtamKOf2iPXWQNZR3ghll
         tME8mSTfRrvB0Rs2S0GrIcL9yDTVG5+UA5ZQOulq9tnQuH4j1FT/tHVAKnfnKz8+GP5o
         /3fA==
X-Gm-Message-State: AOAM531wL079tmyqLbjMb2BxVmLcJdLRU2jM2Uaha3HPWhYhhvFz48Ot
        gPReD1JPttdaIlA05yp+nFo=
X-Google-Smtp-Source: ABdhPJxcQQJ+ZX9oR+7EK5VtufIovSS3QX+tc+iTRij6XChACL3nUeXwkQpX5Ycaj4a9lkuOAEfEnQ==
X-Received: by 2002:a05:6870:89a8:b0:de:dcc3:b737 with SMTP id f40-20020a05687089a800b000dedcc3b737mr9724284oaq.227.1652498737572;
        Fri, 13 May 2022 20:25:37 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:7fc0:37e:f57e:caea? (2603-8081-140c-1a00-7fc0-037e-f57e-caea.res6.spectrum.com. [2603:8081:140c:1a00:7fc0:37e:f57e:caea])
        by smtp.gmail.com with ESMTPSA id v2-20020a056870310200b000e686d1386csm1883625oaa.6.2022.05.13.20.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 20:25:37 -0700 (PDT)
Message-ID: <160f61a6-5313-d949-7c6e-3baeeefb8f37@gmail.com>
Date:   Fri, 13 May 2022 22:25:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix rnr retry behavior
Content-Language: en-US
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220512194901.76696-1-rpearsonhpe@gmail.com>
 <e587f531-0650-1548-1fe0-04d0152a5082@linux.dev>
 <36f6e476-9762-6d39-e167-abb8dcc9f2bb@linux.dev>
 <25c4e1f7-54eb-456b-8020-b3b1e24a9ecb@gmail.com>
 <f3010b22-4c8c-9a9d-16ad-2341a76dbb68@linux.dev>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <f3010b22-4c8c-9a9d-16ad-2341a76dbb68@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/13/22 21:30, Yanjun Zhu wrote:
> 
> 在 2022/5/14 2:22, Bob Pearson 写道:
>> On 5/13/22 08:38, Yanjun Zhu wrote:
>>>
>>> 在 2022/5/13 10:40, Yanjun Zhu 写道:
>>>> 在 2022/5/13 3:49, Bob Pearson 写道:
>>>>> Currently the completer tasklet when it sets the retransmit timer or the
>>>>> nak timer sets the same flag (qp->req.need_retry) so that if either
>>>>> timer fires it will attempt to perform a retry flow on the send queue.
>>>>> This has the effect of responding to an RNR NAK at the first retransmit
>>>>> timer event which does not allow for the requested rnr timeout.
>>>>>
>>>>> This patch adds a new flag (qp->req.need_rnr_timeout) which, if set,
>>>>> prevents a retry flow until the rnr nak timer fires.
>>>>>
>>>>> This patch fixes rnr retry errors which can be observed by running the
>>>>> pyverbs test suite 50-100X. With this patch applied they do not occur.
>>>> Do you mean that running run_tests.py for 50-100times can reproduce this bug? I want to reproduce this problem.
>>> Running run_tests.py for 50-100times, I can not reproduce this problem
>> I went back and looked. The occasionally failing test case is:
>>
>>     test_rdmacm_async_traffic_external_qp
>>
>> This test is normally skipped for rxe because of a hack in <path to rdma-core>/tests/base.py. I sent you
>> a patch that enables these tests a few days ago.
> 
> What is the patch? Can you send me it again?

diff --git a/tests/base.py b/tests/base.py

index 93568c7f..03b5601e 100644

--- a/tests/base.py

+++ b/tests/base.py

@@ -245,10 +245,11 @@ class RDMATestCase(unittest.TestCase):

         self._add_gids_per_port(ctx, dev, self.ib_port)

 

     def _get_ip_mac(self, dev, port, idx):

-        if not os.path.exists('/sys/class/infiniband/{}/device/net/'.format(dev)):

-            self.args.append([dev, port, idx, None, None])

-            return

-        net_name = self.get_net_name(dev)

+        #if not os.path.exists('/sys/class/infiniband/{}/device/net/'.format(dev)):

+            #self.args.append([dev, port, idx, None, None])

+            #return

+        #net_name = self.get_net_name(dev)

+        net_name = "enp0s3"

         try:

             ip_addr, mac_addr = self.get_ip_mac_address(net_name)

         except (KeyError, IndexError):


Save this to a file (e.g. net_name.patch) and type git apply net_name.patch.

Before doing this change "enp0s3" to the correct name for the Ethernet adapter you are
using in your system. tests/base.py assumes that all roce devices have a file with a path

/sys/class/infiniband/rxe0/device/net/

But this is not always the case and rxe does not have that path. This breaks all the
rdmacm test cases in pyverbs.

> 
> And what is the symptoms when this problem occurs?

When I run

# sudo ./build/bin/run_tests -k test_rdmacm_async_traffic_external_qp several times

I will eventually see an rnr timeout error. You may not have this experience but you
can add print statements to the retransmit_timer and rnr_timer routines in rxe_comp.c
and rxe_req.c respectively. You should see that without the below patch you will
never see the rnr_timer fire and you will see lots of retransmit_timer fires.

The current code responds to the retry timer by initiating a send queue retry and
the test will usually pass if it has sent an RNR NAK and tear down the rnr timer
before it have a chance to fire.

Bob
> 
> I want to check if I can reproduce this problem.
> 
> 
> Thanks and Regards,
> 
> Zhu Yanjun

Thanks

Bob
> 
>>
>> It randomly causes an rnr retry about 1/3 of the time. Most of these are repaired by the retry timer
>> going off. A few ~1-2% are not.
>>
>> Bob
>>> Zhu Yanjun
>>>
>>>> Thanks a lot.
>>>> Zhu Yanjun
>>>>
>>>>> Link: https://lore.kernel.org/linux-rdma/a8287823-1408-4273-bc22-99a0678db640@gmail.com/
>>>>> Fixes: 8700e3e7c485 ("Soft RoCE (RXE) - The software RoCE driver")
>>>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>>>> ---
>>>>>    drivers/infiniband/sw/rxe/rxe_comp.c  | 4 +---
>>>>>    drivers/infiniband/sw/rxe/rxe_qp.c    | 1 +
>>>>>    drivers/infiniband/sw/rxe/rxe_req.c   | 6 ++++--
>>>>>    drivers/infiniband/sw/rxe/rxe_verbs.h | 1 +
>>>>>    4 files changed, 7 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
>>>>> index 138b3e7d3a5f..bc668cb211b1 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
>>>>> @@ -733,9 +733,7 @@ int rxe_completer(void *arg)
>>>>>                    if (qp->comp.rnr_retry != 7)
>>>>>                        qp->comp.rnr_retry--;
>>>>> -                qp->req.need_retry = 1;
>>>>> -                pr_debug("qp#%d set rnr nak timer\n",
>>>>> -                     qp_num(qp));
>>>>> +                qp->req.need_rnr_timeout = 1;
>>>>>                    mod_timer(&qp->rnr_nak_timer,
>>>>>                          jiffies + rnrnak_jiffies(aeth_syn(pkt)
>>>>>                            & ~AETH_TYPE_MASK));
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>>>>> index 62acf890af6c..1c962468714e 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>>>>> @@ -513,6 +513,7 @@ static void rxe_qp_reset(struct rxe_qp *qp)
>>>>>        atomic_set(&qp->ssn, 0);
>>>>>        qp->req.opcode = -1;
>>>>>        qp->req.need_retry = 0;
>>>>> +    qp->req.need_rnr_timeout = 0;
>>>>>        qp->req.noack_pkts = 0;
>>>>>        qp->resp.msn = 0;
>>>>>        qp->resp.opcode = -1;
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
>>>>> index ae5fbc79dd5c..770ae4279f73 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe_req.c
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
>>>>> @@ -103,7 +103,8 @@ void rnr_nak_timer(struct timer_list *t)
>>>>>    {
>>>>>        struct rxe_qp *qp = from_timer(qp, t, rnr_nak_timer);
>>>>> -    pr_debug("qp#%d rnr nak timer fired\n", qp_num(qp));
>>>>> +    qp->req.need_retry = 1;
>>>>> +    qp->req.need_rnr_timeout = 0;
>>>>>        rxe_run_task(&qp->req.task, 1);
>>>>>    }
>>>>> @@ -624,10 +625,11 @@ int rxe_requester(void *arg)
>>>>>            qp->req.need_rd_atomic = 0;
>>>>>            qp->req.wait_psn = 0;
>>>>>            qp->req.need_retry = 0;
>>>>> +        qp->req.need_rnr_timeout = 0;
>>>>>            goto exit;
>>>>>        }
>>>>> -    if (unlikely(qp->req.need_retry)) {
>>>>> +    if (unlikely(qp->req.need_retry && !qp->req.need_rnr_timeout)) {
>>>>>            req_retry(qp);
>>>>>            qp->req.need_retry = 0;
>>>>>        }
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>>> index e7eff1ca75e9..ab3186478c3f 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>>> @@ -123,6 +123,7 @@ struct rxe_req_info {
>>>>>        int            need_rd_atomic;
>>>>>        int            wait_psn;
>>>>>        int            need_retry;
>>>>> +    int            need_rnr_timeout;
>>>>>        int            noack_pkts;
>>>>>        struct rxe_task        task;
>>>>>    };
>>>>>
>>>>> base-commit: c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a

