Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1D839FCC2
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 18:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbhFHQsV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 12:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbhFHQsU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 12:48:20 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D77C061574
        for <linux-rdma@vger.kernel.org>; Tue,  8 Jun 2021 09:46:15 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id c13so16595510oib.13
        for <linux-rdma@vger.kernel.org>; Tue, 08 Jun 2021 09:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4pDzDQ7eESWqACnZmKQVD0BCk6pLqxQ/pVvZM1s2HLU=;
        b=PWU0sgCR4lBz8rzI3tZd8X8gIHstbrt2EWqy8RcdAk4etfkrFFncy74f7wSnWlo17x
         2qnF7DZEmlnHlX2jT9ijCXoLbcGwJAm0FcwcoIvp0KoP+kKljsj8UKE4J8ptgFKFoh1O
         WrtKBAnsaQZqiSp4JdC8z4XTN/5NIJ3TiuybExSGVOIi6+99ILV7HGDwirIsu6C5ghDD
         mYZKxXWwBArHCd7Hqy8GXfEFxrnMpqtgnA5jogyB9/LxXoGe4fdIDRQAWMRiG4N8D/yq
         AuZxpURtp/phj/zvc95T4Yw3g1ydmaPllnY7GediKfynKk75Owy5uviXcW8CFs4RTbFb
         2KCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4pDzDQ7eESWqACnZmKQVD0BCk6pLqxQ/pVvZM1s2HLU=;
        b=EQM5cGT+iluUt9fauPt07wEmXk3yoledh9bjbaV5/+3fkA8zTKO6da3FAwv78XZBn/
         xUqC9pUAJ/PEizEmAptcIedUy5RyrCqWiGWDZGgLG3nOCeJoKn1nRREfqpBLZPZ5j6J/
         jp7Wg94WdK5dPEs9ZrYVY+35qpbsVdsax0B0HwE6tXLCkCn4MF60Zy77GPyGj2aaLXAK
         urBPnfkVO5gHGkNjpeTnrMsf2+QX80U8qVCg+OJjSegEOJt2WOD9QG0ZmJXFmovE9mgY
         EZd7SZyWXBFcdfXaI7kR7f8FU9lzA83v+r7qatx9ta6qB7LfRTc6+eTdXGrEFsWqfl9L
         BLcA==
X-Gm-Message-State: AOAM533W12N8jMrB6gKZmltS+XjZLC2tEKJKvoWLyhxbEKL3MJjQx7oB
        hao6y7gxQyj7PdtQSBaoy0IdJWh07Pk=
X-Google-Smtp-Source: ABdhPJwXAveyvIPZsC2CxLxrMz0XKr/ydqTOaJM7qf0Fv6OE1cQKA2fnePcoUN2b4FW37xmpWWniwg==
X-Received: by 2002:aca:bb46:: with SMTP id l67mr3446003oif.74.1623170774498;
        Tue, 08 Jun 2021 09:46:14 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:e53f:9e9b:cd17:cd87? (2603-8081-140c-1a00-e53f-9e9b-cd17-cd87.res6.spectrum.com. [2603:8081:140c:1a00:e53f:9e9b:cd17:cd87])
        by smtp.gmail.com with ESMTPSA id f7sm2917686oot.36.2021.06.08.09.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 09:46:14 -0700 (PDT)
Subject: Re: [Bug Report] RDMA/core: test_qpex.py attempts invalid MW bind
 operation
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <8d329494-6653-359b-91aa-31ac9dc8122c@gmail.com>
 <YL704NdV9F15CDtQ@unreal> <474ad554-574c-120e-97ba-b617e346f14d@gmail.com>
 <YL8SbuEHsyioU/Ne@unreal>
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
Message-ID: <a430c9aa-80db-6c06-568f-3cd09b9f1a59@gmail.com>
Date:   Tue, 8 Jun 2021 11:46:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YL8SbuEHsyioU/Ne@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/8/2021 1:47 AM, Leon Romanovsky wrote:
> On Mon, Jun 07, 2021 at 11:54:29PM -0500, Pearson, Robert B wrote:
>> On 6/7/2021 11:41 PM, Leon Romanovsky wrote:
>>> On Mon, Jun 07, 2021 at 04:50:20PM -0500, Pearson, Robert B wrote:
>>>> sorry/this time without the HTML.
>>>>
>>>> ======================================================================
>>>> ERROR: test_qp_ex_rc_bind_mw (tests.test_qpex.QpExTestCase)
>>>> Verify bind memory window operation using the new post_send API.
>>>> ----------------------------------------------------------------------
>>>> Traceback (most recent call last):
>>>>     File "/home/rpearson/src/rdma-core/tests/test_qpex.py", line 292, in
>>>> test_qp_ex_rc_bind_mw
>>>>       u.poll_cq(server.cq)
>>>>     File "/home/rpearson/src/rdma-core/tests/utils.py", line 538, in poll_cq
>>>>       raise PyverbsRDMAError('Completion status is {s}'.
>>>> pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Memory window
>>>> bind error. Errno: 6, No such device or address
>>>>
>>>> This test attempts to bind a type 2 MW to an MR that does not have bind mw
>>>> access set and expects the test to succeed.
>>> Does the test break after your MW series? Or will it break not-merged
>>> code yet?
>>>
>>> Generally speaking, we expect that developers run rdma-core tests and
>>> fixed/extend them prior to the submission.
>>>
>>> Thanks
>>>
>>>> Bob Pearson
>> Nope. I don't have real RNICs at home to test. But (see my note to Zhu) the
>> non extended APIs do set the access flags correctly and the extended test
>> case does not. The wr_bind_mw() function can't fix this for the test case.
>> It has to set the access flags when it creates the MR and it didn't. It is
>> possible that mlx5 doesn't check the bind access flag but that seems
>> unlikely.
> mlx5 devices support MW 1 & 2 and kernel checks that only these types
> can be accepted from the user space. This is why mlx5 doesn't need to
> check access flags again.
>
>     903 static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
>     904 {
>
> ....
>
>     927         if (cmd.mw_type != IB_MW_TYPE_1 && cmd.mw_type != IB_MW_TYPE_2) {
>     928                 ret = -EINVAL;
>     929                 goto err_put;
>     930         }
>
>
> Thanks

You check the type in alloc_mw but you only check the MR access flags if 
MW_DEBUG is set which is not by default. So you would fail a negative 
test which we sort of currently have. The second bug in the test which 
we found this morning is not correctly setting the op flags in the 
create_qp_ex call. According to the man page only the extended 
operations set in the op flags are 'implemented' for that QP. Apparently 
mlx5 goes ahead and populates them. Makes more sense to me since the API 
as described is kind of overwrought and dumb.

Bob

