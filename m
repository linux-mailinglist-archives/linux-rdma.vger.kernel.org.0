Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC150539547
	for <lists+linux-rdma@lfdr.de>; Tue, 31 May 2022 19:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbiEaRMG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 May 2022 13:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245372AbiEaRMF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 May 2022 13:12:05 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAA970369
        for <linux-rdma@vger.kernel.org>; Tue, 31 May 2022 10:12:03 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-f2cbceefb8so19162562fac.11
        for <linux-rdma@vger.kernel.org>; Tue, 31 May 2022 10:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5KMX3Bq/AhY8bhWITrWM/c8jF9GBlV2IsVGYAJEVry4=;
        b=JB3lnTfiQWhVe4tRQgGHuBMe3Axvn6pN8Cw6pq2MXBb+iFPND/52/aFCk7dQvjVHqf
         Q9B1thzLj924PDP66DFycsX6qiV4oY2d37lgQ/YckOIPabBFASgOq3uMtlXc4UE5zz5H
         0Y1TsIzc6iuTZNtyHK2U+bG6UqYw60/jfNNNJkdDzhH5KZaQ2C77ez2RWJYi1BxFo5ea
         SFOfHd3n7olt/4LN5Kcin6nqP8i/+LkuY8OEKb3HLLztWA+uD9akL02Ms5gNwOnJdK23
         PkU+QcliHUiZolLcjeEg3yhx40i7bhHXdnxgbIaj3QLLty2+NSEnEOt9zIybpejVkoQa
         W3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5KMX3Bq/AhY8bhWITrWM/c8jF9GBlV2IsVGYAJEVry4=;
        b=ZeG2XKk4CmZihUlkjbFkysTk/vzOV5Io+kbH18VR7A4hoSPJo2+CDYUl2RuFrC6ZzV
         eeceOX2J6SYi09Vyo4t5AxAQ4NrZB+/UGoZP57Hn51x7yHPvBoE6aymlgF/vX3NIPPbt
         B+4ca+fF3ieKL5olEsMEYgcuz5ZuUpKGBH1Mqn7p60oobegOJOnVIGo2KgvbLC4B5AfZ
         oEnoeQ/W8q8CrACDMj6Bd9FifhcQN80zDcoZCYj9bu2Mx6e1dA2nNfYY44dsWzY+mzI9
         qBuaSVwr531A+K5qGgxlQa1gZEEc99IOY5klRzsDkurlqqYqU1uOdVAe85pcpywEAZCQ
         /Jig==
X-Gm-Message-State: AOAM532cQ0v1QUAaKP5K3vzkc4zMWm0VMti3oU7p+IvKYkF+6r80hnD2
        FFC/9N0Lu63ouHG73Nshp6I=
X-Google-Smtp-Source: ABdhPJzhGLqwxFbQ+Ho33AfZanUlImaWVX0TQI5TwF7tJB3Z2hdJ3Pm4bVof8eXdLnlRxb0f9DAF1Q==
X-Received: by 2002:a05:6870:d296:b0:f1:f953:7ab7 with SMTP id d22-20020a056870d29600b000f1f9537ab7mr14456817oae.189.1654017123212;
        Tue, 31 May 2022 10:12:03 -0700 (PDT)
Received: from [192.168.0.27] (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id e20-20020a05680809b400b0032b958e1c5esm5852717oig.58.2022.05.31.10.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 10:12:02 -0700 (PDT)
Message-ID: <bb958406-14a1-e785-a525-9c1d5132f10e@gmail.com>
Date:   Tue, 31 May 2022 12:12:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: RDME/rxe: Fast reg with local access rights and invalidation for
 that MR
Content-Language: en-US
To:     Haris Iqbal <haris.iqbal@ionos.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aleksei Marov <aleksei.marov@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>
References: <CAJpMwyjL4iWSSLh_pgWEqLT7oCLgMAFCAdZTJ0w1Rv-gkDNDFQ@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CAJpMwyjL4iWSSLh_pgWEqLT7oCLgMAFCAdZTJ0w1Rv-gkDNDFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/30/22 06:05, Haris Iqbal wrote:
> Hi Bob,
> 
> I have a query. After the following patch,
> 
> https://marc.info/?l=linux-rdma&m=163163776430842&w=2
> 
> If I send a IB_WR_REG_MR wr with flag set to IB_ACCESS_LOCAL_WRITE,
> rxe will set the mr->rkey to 0 (mr->lkey will be set to the key I send
> in wr).
> 
> Afterwards, If I have to invalidate that mr with IB_WR_LOCAL_INV,
> setting the .ex.invalidate_rkey to the key I sent previously in the
> IB_WR_REG_MR wr, the invalidate would fail with the following error.
> 
> rkey (%#x) doesn't match mr->rkey
> (function rxe_invalidate_mr)
> 
> Is this desired behaviour? If so, how would I go about invalidating
> the above MR?
> 
> Regards
> -Haris

I think that the first behavior is correct. If you don't do this then the
MR is open for RDMA operations which you didn't allow.

The second behavior is more interesting. If you are doing a send_with_invalidate
from a remote node then no reason you should allow the remote node to do
anything to the MR since it didn't have access to begin with. For a local invalidate MR
If you read the IBA it claims that local invalidate operations should provide
the lkey, rkey and memory handle as parameters to the operation and that the
lkey should be invalidated and the rkey if there is one should be invalidated. But
ib_verbs.h only has one parameter labeled rkey.

The rxe driver follows most other providers and always makes the lkey and rkey the same
if there is an rkey else the rkey is set to zero. So rxe_invalidate_mr should compare
to the lkey and not the rkey for local invalidate. And then move the MR to the FREE state.

This is a bug. Fortunately the majority of use cases for physical memory regions are
for RDMA access.

Feel free to submit a patch or I will if you don't care to. The rxe_invalidate_mr() subroutine
needs have a new parameter since it is shared by local and remote invalidate operations and
they need to behave differently. Easiest is to have an lkey and rkey parameter. The local
operation would set the lkey and the remote operation the rkey.

Bob
