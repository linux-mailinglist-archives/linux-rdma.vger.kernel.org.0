Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD4B39FC22
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 18:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhFHQO2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 12:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbhFHQOQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 12:14:16 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC755C061574
        for <linux-rdma@vger.kernel.org>; Tue,  8 Jun 2021 09:12:23 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id x196so21644184oif.10
        for <linux-rdma@vger.kernel.org>; Tue, 08 Jun 2021 09:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=oadCazXCM7IWsEhczy3bu9J37MHuni3+MwD9NGANI5s=;
        b=QvFjyzedfQwer7501FLfAE9PuwsrzUFk0Cs+qDjeAlBXRKVFjMA0J1zXF7TZqPtjmx
         6Ii4klpZZu5gKdU1VWKm//cFpbiplo1QrkilJmRo0r7JC7Mqw+2KYURLEv9/m5tX8XLZ
         g9MsXnTPfvN78n2wBnv7JKd/CUExuNKUuCCQcUfgRsnCGJiszzg/jkoRCZ8nLPcRMiMl
         TtLD6ULf3G9zi4wQPrhNF6urzdu3gNvicOpPZqH6jphEDTPzAHc3PsUByhcsQqZo94Pi
         cgL1vQHA+wrDZIpo3gnja0fLmDUqUjelaoTFKISbIutPcbvBk5D9HrTPDrT7ZpPfVocz
         oOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oadCazXCM7IWsEhczy3bu9J37MHuni3+MwD9NGANI5s=;
        b=tw5D0jF0QwOM6x+SPNTAT7sd+8bwEPt6vCTpI0/JCv6nUuXWoVr+EMyS+/GZYVD1nr
         IepQVyMzPRkiZhTlN6SWtnkAjPz7Pl0gymEyhdEnqt9MC2mqGspk//sbp7SjYlF6+snM
         l+YcfRIRbSUkGBYffmvSXLwoHc6w4uw0DI8iDPvJqvZ56DtDuvpQpN4/klURN6IYiy3g
         5ghb3lV7of74KJbGpTzUZyFvyXPJpd+0vK/KslLQTGFmhAGxjt102WHvAcYLJVgwkn0A
         B3SqaMA/Kp3iTPh+i9qBnD38iH2cl5aXx9HF99V43kpJH8clVlSIkEiMO3g88wHEZGcR
         TvPA==
X-Gm-Message-State: AOAM533HldKLFg2Achx4ADQ0XaKBTkwsXk5ltwO3vTu8L3Gq6QLapoHC
        GddOKnmZSJzPPKYrqCLogzIRFD38Kpc=
X-Google-Smtp-Source: ABdhPJz9U2hm5nftbjAOjNFvgFUHtO7G0Phpyz5EBrKpZa/Kd7Peh1QC1xzN2nawMpGReqzkgBeX9Q==
X-Received: by 2002:aca:42c6:: with SMTP id p189mr3271337oia.36.1623168742802;
        Tue, 08 Jun 2021 09:12:22 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:e53f:9e9b:cd17:cd87? (2603-8081-140c-1a00-e53f-9e9b-cd17-cd87.res6.spectrum.com. [2603:8081:140c:1a00:e53f:9e9b:cd17:cd87])
        by smtp.gmail.com with ESMTPSA id f25sm844230oto.26.2021.06.08.09.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 09:12:22 -0700 (PDT)
Subject: Re: [Bug Report] RDMA/core: test_qpex.py attempts invalid MW bind
 operation
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
To:     Edward Srouji <edwards@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <8d329494-6653-359b-91aa-31ac9dc8122c@gmail.com>
 <YL704NdV9F15CDtQ@unreal> <474ad554-574c-120e-97ba-b617e346f14d@gmail.com>
 <YL8SbuEHsyioU/Ne@unreal> <591f489c-882b-de37-eb1f-d39a71fcbd05@nvidia.com>
 <bee1cfd7-09f1-5420-b09f-b6eb9de897e9@gmail.com>
Message-ID: <90cbdee5-c1f6-0373-8d09-c28e3ad7a6c8@gmail.com>
Date:   Tue, 8 Jun 2021 11:12:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <bee1cfd7-09f1-5420-b09f-b6eb9de897e9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/8/2021 10:54 AM, Pearson, Robert B wrote:
>
> On 6/8/2021 6:53 AM, Edward Srouji wrote:
>>
>> On 6/8/2021 9:47 AM, Leon Romanovsky wrote:
>>> On Mon, Jun 07, 2021 at 11:54:29PM -0500, Pearson, Robert B wrote:
>>>> On 6/7/2021 11:41 PM, Leon Romanovsky wrote:
>>>>> On Mon, Jun 07, 2021 at 04:50:20PM -0500, Pearson, Robert B wrote:
>>>>>> sorry/this time without the HTML.
>>>>>>
>>>>>> ====================================================================== 
>>>>>>
>>>>>> ERROR: test_qp_ex_rc_bind_mw (tests.test_qpex.QpExTestCase)
>>>>>> Verify bind memory window operation using the new post_send API.
>>>>>> ---------------------------------------------------------------------- 
>>>>>>
>>>>>> Traceback (most recent call last):
>>>>>>     File "/home/rpearson/src/rdma-core/tests/test_qpex.py", line 
>>>>>> 292, in
>>>>>> test_qp_ex_rc_bind_mw
>>>>>>       u.poll_cq(server.cq)
>>>>>>     File "/home/rpearson/src/rdma-core/tests/utils.py", line 538, 
>>>>>> in poll_cq
>>>>>>       raise PyverbsRDMAError('Completion status is {s}'.
>>>>>> pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is 
>>>>>> Memory window
>>>>>> bind error. Errno: 6, No such device or address
>>>>>>
>>>>>> This test attempts to bind a type 2 MW to an MR that does not 
>>>>>> have bind mw
>>>>>> access set and expects the test to succeed.
>>
>> You're right, looks like a test bug. I'll send a fix upstream.
>>
>> Can you please confirm that this solves your issue:
> Well I get further. I am hitting a seg fault in python at
>
>         client.qp.wr_rdma_write(new_key, server.mr.buf)
>
> in test_qp_ex_rc_bind_mw.
>
> I'm trying to track it down. I'm not very familiar with python and 
> don't know how to run the test under gdb.
>
> Thanks for the fix.
>
> Bob

OK got it. In the setup for the test you write

     class QpExRCBindMw(RCResources):
         def create_qps(self):
             create_qp_ex(self, e.IBV_QPT_RC, e.IBV_QP_EX_WITH_BIND_MW)

         def create_mr(self):
             self.mr = u.create_custom_mr(self, e.IBV_ACCESS_REMOTE_WRITE |
                             e.IBV_ACCESS_MW_BIND)

which asks for qp_ex->wr_bind_mw() to be set but later in the test you write

     client.qp.wr_rdma_write(new_key, server.mr.buf)

which calls qp_ex->wr_rdma_write() which is not set causing the seg 
fault. I think you should have written

             create_qp_ex(self, e.IBV_QPT_RC, e.IBV_QP_EX_WITH_BIND_MW | 
e.IBV_QP_EX_WITH_RDMA_WRITE)

since you need both extended QP operations.

Bob

>
>>
>> diff --git a/tests/test_qpex.py b/tests/test_qpex.py
>> index 4b58260f..c2d67ee8 100644
>> --- a/tests/test_qpex.py
>> +++ b/tests/test_qpex.py
>> @@ -149,7 +149,7 @@ class QpExRCBindMw(RCResources):
>>          create_qp_ex(self, e.IBV_QPT_RC, e.IBV_QP_EX_WITH_BIND_MW)
>>
>>      def create_mr(self):
>> -        self.mr = u.create_custom_mr(self, e.IBV_ACCESS_REMOTE_WRITE)
>> +        self.mr = u.create_custom_mr(self, e.IBV_ACCESS_REMOTE_WRITE 
>> | e.IBV_ACCESS_MW_BIND)
>>
>>>>> Does the test break after your MW series? Or will it break not-merged
>>>>> code yet?
>>>>>
>>>>> Generally speaking, we expect that developers run rdma-core tests and
>>>>> fixed/extend them prior to the submission.
>>>>>
>>>>> Thanks
>>>>>
>>>>>> Bob Pearson
>>>> Nope. I don't have real RNICs at home to test. But (see my note to 
>>>> Zhu) the
>>>> non extended APIs do set the access flags correctly and the 
>>>> extended test
>>>> case does not. The wr_bind_mw() function can't fix this for the 
>>>> test case.
>>>> It has to set the access flags when it creates the MR and it 
>>>> didn't. It is
>>>> possible that mlx5 doesn't check the bind access flag but that seems
>>>> unlikely.
>>> mlx5 devices support MW 1 & 2 and kernel checks that only these types
>>> can be accepted from the user space. This is why mlx5 doesn't need to
>>> check access flags again.
>>>
>>>     903 static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
>>>     904 {
>>>
>>> ....
>>>
>>>     927         if (cmd.mw_type != IB_MW_TYPE_1 && cmd.mw_type != 
>>> IB_MW_TYPE_2) {
>>>     928                 ret = -EINVAL;
>>>     929                 goto err_put;
>>>     930         }
>>>
>>>
>>> Thanks
>>
>> I see that mlx5 checks the access flags in userspace only if MW_DEBUG 
>> is turned on (in set_bind_wr()).
>>
>> I guess that's for the sake of performance, as it's part of the data 
>> path.
>>
>>>> Bob
>>>>
