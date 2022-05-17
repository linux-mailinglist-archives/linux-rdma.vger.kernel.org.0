Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A6252A613
	for <lists+linux-rdma@lfdr.de>; Tue, 17 May 2022 17:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbiEQPV6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 May 2022 11:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiEQPV5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 May 2022 11:21:57 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1720912AB2
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 08:21:55 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id i66so22619991oia.11
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 08:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xeyQAaAEWFA52W3CWgN0CSmYYnfgfl1GmFQlDCCaVwM=;
        b=oX5y9nS8jgeBOnTx81dSSDk+rGRKuk1nwPYjy6ESs5DBs1gC9L1x65dAFMgtTFsGxD
         x9F5ZNcrJs0Yl4Bcr2WIx5Z+Ljg041mfPz1n1ovuUdB8KCc97jbgDmUzUV8leM+rH3oS
         w+3bZt/p8cjcrzaNaJUVbhuqMIfNlQlnRVGy+IPaPZjlvqJCiXQixn99Q1smAJMBsjM3
         E7cF+dbPZy223d4ZCKH1x8/v0Zz9Tk5Pu50Sjz9YLabu2VKWv1QvJ1F8ur/RefehUV0E
         oNJN92SBB6bJLioFYA1tknYxxW+hDqJwHJvJbpTrfyW1AO0YvrXQHSA9WWnIIESZAqq0
         9CZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xeyQAaAEWFA52W3CWgN0CSmYYnfgfl1GmFQlDCCaVwM=;
        b=UEIdaGVo0RTEoelrC+nE2xmISreaW4lsbq7uRicraLxwE9nn/92nLlntcUztD7TVvv
         nKHqLmr+eMEgzILcGQXB6MucgIl2BtwKV7wU7FAVORpmZZSk1FPmMq+MknhmHCnUKD5U
         DOGIJSsoCpiTiJ9rnmOS58izc3ERUoST1hhBNwMaWJ81NeMhZQlTGixjOeuITEeuF/Gm
         hSrZGOiBnz6kxUgtg+ngFord7wz6oUnww2sm3mjG772YpMeGJvjecpkwmFZLVZoLMHAU
         l25TcNH+t0KwDG3dXZ6Xt741u9XL391abk4sxS/XyWTdVqUiBl9q2snEDjbq1ITqI3qF
         3hSQ==
X-Gm-Message-State: AOAM532X1vWH0mDjKv3nVA+U6TsKe8L+M0DxrB+xz6BdcA6+gWkxd+yc
        aakwVa+DTZwSEwultLvAp/li+4SjBTg=
X-Google-Smtp-Source: ABdhPJz04OoXH6DUFUYUoJhBJtoYwE6RVDGV3KBG6mJ7LsrBVRU02iLB0/BTJDXCfGX5Akjk2ZlvNw==
X-Received: by 2002:a05:6808:f90:b0:326:e17a:2a68 with SMTP id o16-20020a0568080f9000b00326e17a2a68mr15837208oiw.59.1652800914420;
        Tue, 17 May 2022 08:21:54 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:d310:a4f5:635f:2e00? (2603-8081-140c-1a00-d310-a4f5-635f-2e00.res6.spectrum.com. [2603:8081:140c:1a00:d310:a4f5:635f:2e00])
        by smtp.gmail.com with ESMTPSA id a14-20020a05680804ce00b00325cda1ffbasm4853037oie.57.2022.05.17.08.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 08:21:54 -0700 (PDT)
Message-ID: <ad81fbce-0b8c-c49f-00d5-c8c2678a5779@gmail.com>
Date:   Tue, 17 May 2022 10:21:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Apparent regression in blktests since 5.18-rc1+
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        Douglas Gilbert <dgilbert@interlog.com>
References: <e7c31ebb-60c0-cd57-2009-5e9383ecc472@gmail.com>
 <cf8b9980-3965-a4f6-07e0-d4b25755b0db@acm.org>
 <4b0153c7-a8e9-98de-26ae-d421434a116d@linux.dev>
 <20220507012952.GH49344@nvidia.com>
 <81571bbb-c5d2-9b68-765d-f004eb7ba6fd@linux.dev>
 <43c2fed8-699f-19fe-81fa-c5f5b4af646f@gmail.com>
 <4c3439c3-6279-804f-63b2-99d8529e5d3d@acm.org>
 <b2908c39-636a-1cba-db22-838640385d84@gmail.com>
 <529dbb0a-0b75-9752-62a3-a1235565aa1a@acm.org>
 <66379f8e-c7ab-1daf-b2a8-19d0368e229f@gmail.com>
 <7b8f7d5c-cda5-a160-b988-186b371a6e4d@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <7b8f7d5c-cda5-a160-b988-186b371a6e4d@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/12/22 22:40, Bart Van Assche wrote:
> On 5/12/22 17:41, Bob Pearson wrote:
>> OK thanks. I don't exactly know how to merge "the latest master branch". I did merge the tag v5.18-rc2 and am now trying
>> v5.18-rc4. As far as I can tell rc6 is the latest branch. When I tried to merge the git repo it didn't work.
> 
> Hmm ... what didn't work? Merging or running blktests?
> 
> Anyway, this is how I merge Linus' latest branch:
> 
> $ git remote add origin \
>     git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> $ git fetch origin
> $ git merge origin/master
> 
> I also found which commit I merged from the master branch (see also my email from May 7):
> $ git merge 4b97bac0756a
> 
> Thanks,
> 
> Bart.

Thanks Bart. I was able to follow your steps above. But unfortunately not much has changed.
I still see hangs in siw (with no code changes by me) and also in rxe (but here I have
fixed some lockdep warnings so it will run in a debug kernel.) There are two test cases that
cause the most problems. srp/002 and srp/011. 011 always fails solidly. 002 sometimes hangs and
sometimes completes but with failed status. The rest of the tests all pass.

Both tests hang at a line that looks like
	scsi host6: ib_srp: Already connected to target port with id_ext=...

When 002 completes but fails there are 14 second gaps at some of the same lines in the trace.
This has the feel of the earlier problem with the 3 minute timeout that was fixed by the
patch (revert ... scsi_debug.c) that you sent and is applied here.

I really don't know how to make progress here. If anyone knows what is happening at the
already connected lines let me know. They seem normal except for the long gaps and hangs
when they occur.

Thanks, Bob
