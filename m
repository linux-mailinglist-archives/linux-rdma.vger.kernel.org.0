Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D2139FB45
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 17:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhFHP4L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 11:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhFHP4K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 11:56:10 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3811AC061787
        for <linux-rdma@vger.kernel.org>; Tue,  8 Jun 2021 08:54:07 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so20753847otp.4
        for <linux-rdma@vger.kernel.org>; Tue, 08 Jun 2021 08:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nAHDGZo+ET5udZGSL9YURShWFPIzAJCWEa6dw9Q6IFE=;
        b=t7AnIg8QOhFb8UZkmeuA8UriBHjCcQI8sNuTZmzcmerROOGacskCo1ZXy8AyPRvAnf
         k39SIF7eTa/ghbqtmeuefXnDbOe93nBGRlZEEfBr5j5LozdPhOL2PJYpKWiUx7rhLY/d
         5QfO5kV+tchDDQSMnDFASC/D6T/R5OkgMw0jFE6UyzQpvmYNwgTwyTFTQ6IdfxJq/vvi
         /8rYglpmtUIzFHZ0WnVw9AzlZHSE2fcfi6ykHb/gedv0C2VPuWgXpCsYmTJYoS07iF7o
         mlDuLbNcgxaJSySBWj++pJe/GSp9Jsh/Ov2puciX1VPuEAuzNDBGbpDICZr6wdvnSbui
         w5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nAHDGZo+ET5udZGSL9YURShWFPIzAJCWEa6dw9Q6IFE=;
        b=m3D0vIxd4LPZd5nqPABSCB/zS6L/WhF/HytN4iw1nIKnOJ7V4SFqUDY2/krJUoSHxY
         vStsnkZ3X06rzQsdhk7bZoM5txqtdcLqNGCIpLEOE/+6vatuXv6sAfcluNx8kuZrp90O
         oFqu9ePsbh3GVxa+QK/3239ApHNVrlpA84XiEz2/TqUTNR25+axU87OxnDCg2iNptlqy
         +TimPj8V0g6BFkRnSUiVV4jj8zekyI7ewzOqvTajX+GfNVJ0gAAMP3mOojkY6/iTg5Fl
         8lSu3Mf2fVXj+Vldgm0eLZ+uhSMFVncH66JWOlLlcQRYcLozSgBbBMlDxZ6m3vzqg2pu
         Y9jw==
X-Gm-Message-State: AOAM530noYOcq7wQSZTYYSvfazvl5UmQ/wju0Fd4xBUbkxZQlxFkeniI
        gqUkyRFmXdPRdnvonGXLY2hXPxfMgJ4=
X-Google-Smtp-Source: ABdhPJwWYcpJdfFCE6wXDL2Df8jzvrU4jFG2HqdVinsrYtmZ+Dq/kztifiEpXsGnm4Ek3Ot8bk4kDw==
X-Received: by 2002:a05:6830:792:: with SMTP id w18mr11177728ots.210.1623167646249;
        Tue, 08 Jun 2021 08:54:06 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:e53f:9e9b:cd17:cd87? (2603-8081-140c-1a00-e53f-9e9b-cd17-cd87.res6.spectrum.com. [2603:8081:140c:1a00:e53f:9e9b:cd17:cd87])
        by smtp.gmail.com with ESMTPSA id w6sm3138569otj.5.2021.06.08.08.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 08:54:05 -0700 (PDT)
Subject: Re: [Bug Report] RDMA/core: test_qpex.py attempts invalid MW bind
 operation
To:     Edward Srouji <edwards@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <8d329494-6653-359b-91aa-31ac9dc8122c@gmail.com>
 <YL704NdV9F15CDtQ@unreal> <474ad554-574c-120e-97ba-b617e346f14d@gmail.com>
 <YL8SbuEHsyioU/Ne@unreal> <591f489c-882b-de37-eb1f-d39a71fcbd05@nvidia.com>
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
Message-ID: <bee1cfd7-09f1-5420-b09f-b6eb9de897e9@gmail.com>
Date:   Tue, 8 Jun 2021 10:54:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <591f489c-882b-de37-eb1f-d39a71fcbd05@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/8/2021 6:53 AM, Edward Srouji wrote:
>
> On 6/8/2021 9:47 AM, Leon Romanovsky wrote:
>> On Mon, Jun 07, 2021 at 11:54:29PM -0500, Pearson, Robert B wrote:
>>> On 6/7/2021 11:41 PM, Leon Romanovsky wrote:
>>>> On Mon, Jun 07, 2021 at 04:50:20PM -0500, Pearson, Robert B wrote:
>>>>> sorry/this time without the HTML.
>>>>>
>>>>> ====================================================================== 
>>>>>
>>>>> ERROR: test_qp_ex_rc_bind_mw (tests.test_qpex.QpExTestCase)
>>>>> Verify bind memory window operation using the new post_send API.
>>>>> ---------------------------------------------------------------------- 
>>>>>
>>>>> Traceback (most recent call last):
>>>>>     File "/home/rpearson/src/rdma-core/tests/test_qpex.py", line 
>>>>> 292, in
>>>>> test_qp_ex_rc_bind_mw
>>>>>       u.poll_cq(server.cq)
>>>>>     File "/home/rpearson/src/rdma-core/tests/utils.py", line 538, 
>>>>> in poll_cq
>>>>>       raise PyverbsRDMAError('Completion status is {s}'.
>>>>> pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is 
>>>>> Memory window
>>>>> bind error. Errno: 6, No such device or address
>>>>>
>>>>> This test attempts to bind a type 2 MW to an MR that does not have 
>>>>> bind mw
>>>>> access set and expects the test to succeed.
>
> You're right, looks like a test bug. I'll send a fix upstream.
>
> Can you please confirm that this solves your issue:
Well I get further. I am hitting a seg fault in python at

         client.qp.wr_rdma_write(new_key, server.mr.buf)

in test_qp_ex_rc_bind_mw.

I'm trying to track it down. I'm not very familiar with python and don't 
know how to run the test under gdb.

Thanks for the fix.

Bob

>
> diff --git a/tests/test_qpex.py b/tests/test_qpex.py
> index 4b58260f..c2d67ee8 100644
> --- a/tests/test_qpex.py
> +++ b/tests/test_qpex.py
> @@ -149,7 +149,7 @@ class QpExRCBindMw(RCResources):
>          create_qp_ex(self, e.IBV_QPT_RC, e.IBV_QP_EX_WITH_BIND_MW)
>
>      def create_mr(self):
> -        self.mr = u.create_custom_mr(self, e.IBV_ACCESS_REMOTE_WRITE)
> +        self.mr = u.create_custom_mr(self, e.IBV_ACCESS_REMOTE_WRITE 
> | e.IBV_ACCESS_MW_BIND)
>
>>>> Does the test break after your MW series? Or will it break not-merged
>>>> code yet?
>>>>
>>>> Generally speaking, we expect that developers run rdma-core tests and
>>>> fixed/extend them prior to the submission.
>>>>
>>>> Thanks
>>>>
>>>>> Bob Pearson
>>> Nope. I don't have real RNICs at home to test. But (see my note to 
>>> Zhu) the
>>> non extended APIs do set the access flags correctly and the extended 
>>> test
>>> case does not. The wr_bind_mw() function can't fix this for the test 
>>> case.
>>> It has to set the access flags when it creates the MR and it didn't. 
>>> It is
>>> possible that mlx5 doesn't check the bind access flag but that seems
>>> unlikely.
>> mlx5 devices support MW 1 & 2 and kernel checks that only these types
>> can be accepted from the user space. This is why mlx5 doesn't need to
>> check access flags again.
>>
>>     903 static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
>>     904 {
>>
>> ....
>>
>>     927         if (cmd.mw_type != IB_MW_TYPE_1 && cmd.mw_type != 
>> IB_MW_TYPE_2) {
>>     928                 ret = -EINVAL;
>>     929                 goto err_put;
>>     930         }
>>
>>
>> Thanks
>
> I see that mlx5 checks the access flags in userspace only if MW_DEBUG 
> is turned on (in set_bind_wr()).
>
> I guess that's for the sake of performance, as it's part of the data 
> path.
>
>>> Bob
>>>
