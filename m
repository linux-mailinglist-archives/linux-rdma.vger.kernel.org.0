Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8136552B0E3
	for <lists+linux-rdma@lfdr.de>; Wed, 18 May 2022 05:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiERDlp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 May 2022 23:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiERDlo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 May 2022 23:41:44 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7022649
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 20:41:40 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-f1d2ea701dso1117679fac.10
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 20:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :references:to:from:in-reply-to:content-transfer-encoding;
        bh=urezTpjTq6ZcibeyCY5NQkSfulh9xF0GjxngAmJ7wWo=;
        b=iLCJ4BPpbCPciqLytfVh3/I7Q55XSXNZmTE775Q6bzF317U+Vc/PqNCHiJPEQU4flr
         JGiUmId4D0fUjMapHFAReworJKBbSCb2p5yOmstU6U1ASzGtK7JcAwNPIswJrmqf85AE
         9TfzFLtclftwYTo3ObI41ZfW/yV77AVgoEUFdBoR4ivoMi3oipGvOgrbIyPJrdTT/LeK
         +sZOz3GpM9jZpptlltbV5L4aaCtotffwij4eM7/37HmlXJ/WbCtiSp9uj08riMVDFxd+
         XYgFUZT1KQpGGdMwfXj9haPOwU09+eFu9QT2eugYD9UfIFuqosUJ1WHtOrEiJstjvUrq
         eBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:references:to:from:in-reply-to
         :content-transfer-encoding;
        bh=urezTpjTq6ZcibeyCY5NQkSfulh9xF0GjxngAmJ7wWo=;
        b=WjLBsO58R//qxoULk3JCG1+xxYbFj/U1fJ7tANuGCUzXiCpEBFKUwZFr9ghUdHkFHV
         FgDP7msrwKYeN3mXjv23W8vd1a4qcbwpYW9SRWBHJ06vSH+NcsIAa4PJpStrFZpu5NBE
         MJhIT4t8wM2oRaA1nktu9FMUoVpByOGXtpNF3FnRDF6p4WVqb7isNy8KmEBTjAdiofbO
         CXd1FJTxoyrZd+oSs5sBsY38k+diXS8gkYLEb3WKVsn2hi1TxwsmAFqm9W8oAU6tuSHc
         +RAgs0+hf4qWK9+vYvG8uen4YJFrQDhj9kh2uEjbVSage5h5FHYQQ/c5q45bO2+qLw6S
         NSHQ==
X-Gm-Message-State: AOAM531b9iP0LO9hIbnmdjTjEMX9kidaV0WlTuRwRZw63iEmiD8P5XhU
        GBP4FKJBFqJCSmMjOy1FVRfrMt68NRU=
X-Google-Smtp-Source: ABdhPJxW/jnPuzUkkXIHD36JvP+VJT1/a/IX4KkOyE9UNv8GVqsNOEdsLCbevFIVx40aQ4kt+vE97A==
X-Received: by 2002:a05:6870:c1d5:b0:ed:986c:3e64 with SMTP id i21-20020a056870c1d500b000ed986c3e64mr14928325oad.222.1652845291812;
        Tue, 17 May 2022 20:41:31 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:471c:e880:a07:cbc1? (2603-8081-140c-1a00-471c-e880-0a07-cbc1.res6.spectrum.com. [2603:8081:140c:1a00:471c:e880:a07:cbc1])
        by smtp.gmail.com with ESMTPSA id q5-20020a9d6305000000b0060603221251sm441242otk.33.2022.05.17.20.41.31
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 20:41:31 -0700 (PDT)
Message-ID: <0793a5bf-e984-94e7-2389-86dfa38729e2@gmail.com>
Date:   Tue, 17 May 2022 22:41:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Fwd: Bug in pyverbs for test_qp_ex_rc_bind_mw
Content-Language: en-US
References: <9c9bbda0-4134-207c-96cb-eb594aab40d4@gmail.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <9c9bbda0-4134-207c-96cb-eb594aab40d4@gmail.com>
X-Forwarded-Message-Id: <9c9bbda0-4134-207c-96cb-eb594aab40d4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org




-------- Forwarded Message --------
Subject: Re: Bug in pyverbs for test_qp_ex_rc_bind_mw
Date: Tue, 17 May 2022 22:41:08 -0500
From: Bob Pearson <rpearsonhpe@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>, Edward Srouji <edwards@nvidia.com>, Leon Romanovsky <leon@kernel.org>

On 5/17/22 21:57, Bob Pearson wrote:
> test_qp_ex_rc_bind_mw has an error in that the new_rkey is computed from the old mr rkey and not the old mw rkey.
> The following lines
> 
> 	mw = MW(server.pd, mw_type=e.IBV_MW_TYPE_2)
> 	...
> 	new_rkey = inc_rkey(server.mr.rkey)
> 	server.qp.wr_bind_mw(mw, new_rkey, bind_info)
> 
> will compute a new rkey with the same index as mr and a key portion that is one larger than mr modulo 256.
> This is passed to wr_bind_mw which expects a parameter with a new key portion of the mw (not the mr).
> The memory windows implementation in rxe generates a random initial rkey for mw and for bind_mw it
> checks that the new 8 bit key is different than the old key. Since the mr and mw are random wrt each other
> we expect that the new key will match the old key approx 1 out of 256 test runs which will cause an error
> which is just what I see.
> 
> The correct code should be
> 
> 	new_key = inc_rkey(<old mw.rkey>)
> 
> which will guarantee that it is always different than the previous key. The problem is I can't figure out
> how to compute the rkey from the mw or I would submit a patch.
> 
> Bob
> 

If in test_qpex.py I type

print("mw = ", mw)
print("mr = ", self.server.mr)

I get

mw = MW:
Rkey		: 12345678
Handle		: 4
MW Type		: IBV_MW_TYPE_2

mr = MR
lkey		: 432134
rkey		: 432134
length		: 1024
buf		: 9403912345678
handle		: 2

The difference is the colon ':' after MW and caps.

I can refer to mr.rkey as self.server.mr.rkey no problem

but mw.Rkey doesn't work. Neither does mw.rkey or anything else I have thought of.

I hate python. Just hate it.

Bob
