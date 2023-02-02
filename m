Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E82687418
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 04:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjBBDp5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Feb 2023 22:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjBBDp4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Feb 2023 22:45:56 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571DE64D8D
        for <linux-rdma@vger.kernel.org>; Wed,  1 Feb 2023 19:45:55 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-16332831ed0so927918fac.10
        for <linux-rdma@vger.kernel.org>; Wed, 01 Feb 2023 19:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJPH1OcHqZQAXfaf3+boEMFGeGmTxTlilgM/lky6vms=;
        b=KivRD87q5ke1pXY3JCVEhNXkHWdTjGteqNPyH8BYBiKzvG13RWXCV/9gYYkOmRGboX
         8QTViuffWsVjQdSNTE5ytt9XqCgAmi36mt13jyjI0hJ5XwLwk85NyU/wSuiOCs4U9JOn
         y9nLm/vHy9NmI/Su5O0/MTHzqCgMA/pYYUPLWxadZnuBm11ELRnrTOyQd4yo8BaeQEBu
         7WJ41MsioI1RmFs5ZqUnFGGvRkH0z6tB56rjepWdjd95FAmhZcBzOJKjij8YzVqR55ZP
         bPxxsme9c/BCTY7C5+Rrkeg84pkAiZV3ugox2NoMZAjCtTc2SmCs9DvYm+BG2Q31GXz2
         sPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJPH1OcHqZQAXfaf3+boEMFGeGmTxTlilgM/lky6vms=;
        b=2aLZD8/OMbSSAWlvJRfJE9q29ilqUszEO4VMq6WOrOuLMFI6zxB4feZXCxBqMcPQVq
         wXHOc08tVB58AUO+Q2Kx32RLRdBw1/vlTLN7vf70wSqHr/cDKM8aRZMvRPeHbyRF221i
         6M/Yld+VGdTiKN71Zrr1u5Q6wBR1YWxOmh5Q8PhJWub6mvuu9oB/GVQzHn6t7nc0dViJ
         Q2RRRiG0nq8tTBWRV1+WixzvfU/4hjkb0SV/9PAP6qsny9fpI1AX9Ofn8mSl3A49Zjh0
         hiADNaPGKycpg6hpmDZZhnA0sMgrTHERiSy+28B3oDsU3SJFiadaFMVO/SU7IrjaS6a7
         P6Hg==
X-Gm-Message-State: AO0yUKVIORaCBYuXpTMdtGQkk14ImEdftjhwjTYdcyUk2Eqke4pxtBxT
        TBk2yEeloFNhoTf0ZckYqX6FySdKTcXZAQ==
X-Google-Smtp-Source: AK7set+7WZi+WC9JtBTNZkJLhh6MXWuR3feOrqZnnJFj/ggjQLzinVPLilTbmh0PezD2Azi/wPIHfg==
X-Received: by 2002:a05:6871:609:b0:15f:c992:93d7 with SMTP id w9-20020a056871060900b0015fc99293d7mr2520180oan.37.1675309554678;
        Wed, 01 Feb 2023 19:45:54 -0800 (PST)
Received: from [192.168.0.27] (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id s63-20020acaa942000000b003789c7e30basm1931281oie.27.2023.02.01.19.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 19:45:54 -0800 (PST)
Message-ID: <0cb0e3e1-de90-3267-5a84-082321a10d9d@gmail.com>
Date:   Wed, 1 Feb 2023 21:45:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH for-next v3] Subject: RDMA/rxe: Handle zero length rdma
Content-Language: en-US
To:     Tom Talpey <tom@talpey.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20230127210938.30051-1-rpearsonhpe@gmail.com>
 <TYCPR01MB845509B0DBC0BBCF1CC8DB73E5D19@TYCPR01MB8455.jpnprd01.prod.outlook.com>
 <24a30a4b-ab51-b24a-7976-eeefabb99619@talpey.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <24a30a4b-ab51-b24a-7976-eeefabb99619@talpey.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/1/23 09:38, Tom Talpey wrote:
> On 2/1/2023 6:06 AM, Daisuke Matsuda (Fujitsu) wrote:
>> On Sat, Jan 28, 2023 6:10 AM Bob Pearson wrote:
>>>
>>> Currently the rxe driver does not handle all cases of zero length
>>> rdma operations correctly. The client does not have to provide an
>>> rkey for zero length RDMA operations so the rkey provided may be
>>> invalid and should not be used to lookup an mr.
>>>
>>> This patch corrects the driver to ignore the provided rkey if the
>>> reth length is zero and make sure to set the mr to NULL. In read_reply()
>>> if length is zero rxe_recheck_mr() is not called. Warnings are added in
>>> the routines in rxe_mr.c to catch NULL MRs when the length is non-zero.
>>>
>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>> ---
>>
>> When I applied this change, a testcase in rdma-core failed as shown below:
>> ======================================================================
>> ERROR: test_qp_ex_rc_flush (tests.test_qpex.QpExTestCase)
>> ----------------------------------------------------------------------
>> Traceback (most recent call last):
>>    File "/root/rdma-core/tests/test_qpex.py", line 258, in test_qp_ex_rc_flush
>>      raise PyverbsError(f'Unexpected {wc_status_to_str(wcs[0].status)}')
>> pyverbs.pyverbs_error.PyverbsError: Unexpected Remote access error
>>
>> ----------------------------------------------------------------------
>>
>> In my opinion, your change makes sense within the range of traditional
>> RDMA operations, but conflicts with the new RDMA FLUSH operation.
>> Responder cannot access the target MR because of invalid rkey. The
>> root cause is written in IBA Annex A19, especially 'oA19-2'.
>> We thus cannot set qp->resp.rkey to 0 in qp_resp_from_reth().
>>
>> Do you have anything to say about this? > Li Zhijian
>>
>> Thanks,
>> Daisuke Matsuda
> 
> I'm confused too, Bob can you point to the section of the spec
> that allows the rkey to be zero? It's my understanding that
> a zero-length RDMA Read must always check for access, even
> though no data is actually fetched. That would not be possible
> without an rkey.
> 
> Tom.
> 
Tom, Daisuke,

C9-88: For an HCA responder using Reliable Connection service, for
each zero-length RDMA READ or WRITE request, the R_Key shall not be
validated, even if the request includes Immediate data.

Further I have seen the pyverbs test suite sending a totally bogus rkey on a zero length rdma read. That was the impetus for me looking at this.

Daisuke has a different issue since flush is a different operation than read or write.
I need to look into what a zero length flush means.

Bob


