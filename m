Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B4455B4AA
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jun 2022 02:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiF0Adz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jun 2022 20:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiF0Ady (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 26 Jun 2022 20:33:54 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82722AC7
        for <linux-rdma@vger.kernel.org>; Sun, 26 Jun 2022 17:33:53 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u189so10938991oib.4
        for <linux-rdma@vger.kernel.org>; Sun, 26 Jun 2022 17:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7asA7yGg3sLhI2UfT1r2XB2K+jx/oENgcYs2g28wNGs=;
        b=KiwiNXiXl6Hlc/rvwmhpn06E5UUrk6/WIxqM5PQLi5oUHq0+5knzuAoobT75hltmii
         lUtUCHKcd7k7rbI3PRv9Tcb496BhpJ6vLL0cxt2SRUEWpH1c0smA26xrAUxnyaIuaGLM
         Ql0BFbz7RIXhZ9Nq+iywSvMRDqwa2yQHN6SOHJcbFb+c0ZS6ITl9eS2NuvgQJcJjJ9PC
         3KcVnt9+HIq/L8+ktVPTaUlmn8fZOeTL/KIdw2cMxBsbXNXFkbAz7xSeo3WdJW7Wnzns
         HBxowmBdyIKLKwlgt9XHATCZkzbcci27IkZ9ZtL9XHyac/gquUpSECXbbONzdWR/USXO
         6Dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7asA7yGg3sLhI2UfT1r2XB2K+jx/oENgcYs2g28wNGs=;
        b=lGTqtCOFyeAesTJ1YZ3/hF9QmRMKU3Jnr22+C4JUgF83UOBCDY+4nxoDQ+6R6Y95m7
         vTjy1sL+uMe84LN1gLenEPjpOSStlj1jSOeXnkTFKqnzAC1crAr4qXjXQeLkJGNEOcYx
         v3R2VVuYRfmzewQfS2HM3Jiy2/Ot5h6JFIZnA2YeJbcHT2ZCty791GxDAmFKHyn2nHFS
         kmnjlb6j2KdISWZAT8WHpFUVhXEMeogJaNCXS7QuwRPZMzrQsszKUGOr1noBW4yynzel
         yGRi0nPwh4NbFfuej/2782/2rAfYkHXXmXkkX33mrciG0IZ8V0mZV9C6+cJVJLnOtOIM
         qABA==
X-Gm-Message-State: AJIora+cqI44cOA0ZFDCNc0hwT7xwVq+iMTRaHLIKRH5aCSfGeJDueb4
        MsNPrAkuqDyLBZDifEb2xfDTe/Ro/wg=
X-Google-Smtp-Source: AGRyM1taePuTRebgeRlJUzEqH65KC/3DgUIwAXXuxOBdzDvyIuYIeDyRWYSQsS7iZdELVqMLeX2KIg==
X-Received: by 2002:a05:6808:ed0:b0:331:9af7:e69c with SMTP id q16-20020a0568080ed000b003319af7e69cmr9396279oiv.76.1656290033088;
        Sun, 26 Jun 2022 17:33:53 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:7f25:2769:1033:f8c1? (2603-8081-140c-1a00-7f25-2769-1033-f8c1.res6.spectrum.com. [2603:8081:140c:1a00:7f25:2769:1033:f8c1])
        by smtp.gmail.com with ESMTPSA id w70-20020acaad49000000b003351fa55a58sm4562866oie.16.2022.06.26.17.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 17:33:52 -0700 (PDT)
Message-ID: <98517c19-13b7-0ab4-ef53-7e59ac1ff0e6@gmail.com>
Date:   Sun, 26 Jun 2022 19:33:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] RDMA/rxe: Split rxe_invalidate_mr into local and
 remote versions
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>, haris iqbal <haris.phnx@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        zyjzyj2000@gmail.com, haris.iqbal@ionos.com,
        Jinpu Wang <jinpu.wang@ionos.com>, aleksei.marov@ionos.com
References: <20220616140908.666092-1-haris.phnx@gmail.com>
 <CAE_WKMypM1pTCpQV_yJUwa9DzVZnB9grCM=kiVt_6m3HD98eiA@mail.gmail.com>
 <20220624200250.GC23621@ziepe.ca>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220624200250.GC23621@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/24/22 15:02, Jason Gunthorpe wrote:
> On Wed, Jun 22, 2022 at 04:12:01PM +0200, haris iqbal wrote:
>> On Thu, Jun 16, 2022 at 4:09 PM Md Haris Iqbal <haris.phnx@gmail.com> wrote:
>>>
>>> Currently rxe_invalidate_mr does invalidate for both local ops, and remote
>>> ones. This means that MR being invalidated is compared with rkey for both,
>>> which is incorrect. For local invalidate, comparison should happen with
>>> lkey, and for the remote one, it should happen with rkey.
>>>
>>> This commit splits the rxe_invalidate_mr into local and remote versions.
>>> Each of them does comparison the right way as described above (with lkey
>>> for local, and rkey for remote).
>>>
>>> Fixes: 3902b429ca14 ("RDMA/rxe: Implement invalidate MW operations")
>>> Cc: rpearsonhpe@gmail.com
>>> Signed-off-by: Md Haris Iqbal <haris.phnx@gmail.com>
> 
>> ping.
> 
> The commit message makes sense to me - is anyone else working on rxe
> going to test or review this patch?
> 
> There are now many patches for rxe that I would like the rxe community
> to mutually review/test/ack.
> 
> Jason

I have reviewed this patch. Haris and I discussed it after v1 and we agreed to
this for v2.

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
