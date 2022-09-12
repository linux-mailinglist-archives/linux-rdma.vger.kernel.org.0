Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574E55B61E9
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Sep 2022 21:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiILTwe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Sep 2022 15:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiILTwc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Sep 2022 15:52:32 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CEC40565;
        Mon, 12 Sep 2022 12:52:30 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1274ec87ad5so26355966fac.0;
        Mon, 12 Sep 2022 12:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=wEsvKd6RAZcw3hcTuaRy4gbOUDgxDjPKLjsFQoB060s=;
        b=Rn82ib9dmnK56vc+nt4dxoinLgaglw0FziWYVHM4Q0xJy2WERAxP7mcz1pjDqDcmfS
         qDmCY92k+CQQqyTg4/WhZKd+z3+OvGL4cFsUtNfHm1ApcZMIVAlA7F1QzxdVfY/GEiEo
         onkz62GOXNlZ72sZG1q/GgPKRj6Gl9CO66suq5lPtg2j664ahuEUkoDIaGqYbCCyPy/+
         ufNGKfH94JOkbkKOD7uAIs9ISZm592Oow4tS9h3n8x9JSV18Nxs59hhR++GDkFEvrMi9
         RtVT93uvK8IQawwuXKquCqVElnZy1WAWr8lVIz/6aw4vDjdxOA2OVvCFJVDNXYSwSbBj
         hH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wEsvKd6RAZcw3hcTuaRy4gbOUDgxDjPKLjsFQoB060s=;
        b=pXb+Yd3clr7MSnoMEQOYdP7D3GGxbEO0D8VzMGH+1dnvJWZp0dQv1AyaqnJ5//1oF4
         KAetJj2kfxsHmv3G1sRGnWOx4k7FZRzJxWlbwcyj+9PFYqCg2oook2Wxk9tEC3/uPyyj
         CGNSHmMc4XlPXbJ3S0LJL6jU/gLetgEiq3yBSz/x9Yjk9GEPC8eK5vkWjtRPWCqvKhpj
         xmM//d2LdGuzJGUTAm2GpGDKwlLoUdJZtubIBO1/3JR6eMlo5Aa4NqUxm6Jz5AomMngL
         HH0aNalVQpWa5YO6aGoBmbAqZGC7+LueyRp1gwxg4NMTzijLoy5SGe8qSrRNSwKFmlP5
         IScg==
X-Gm-Message-State: ACgBeo2qO4PeixenuXCyA0sIFu9ccEp+wPjbyOW3ZTZy61q22x35K5I8
        kQr55gl1EsEbC6Gq3UMu6iA=
X-Google-Smtp-Source: AA6agR4tsBAYFbRrZwOEYJnNGS7xtJrv97bGd/pXDoWVPp9q6447Ps8BWVB8O3tqkpmoITv9kFI8YQ==
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id ba11-20020a056870c58b00b0010bd21dad5emr12553749oab.287.1663012349777;
        Mon, 12 Sep 2022 12:52:29 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:9135:3fe0:59b2:4d18? (2603-8081-140c-1a00-9135-3fe0-59b2-4d18.res6.spectrum.com. [2603:8081:140c:1a00:9135:3fe0:59b2:4d18])
        by smtp.gmail.com with ESMTPSA id a18-20020a05683012d200b00636ed80eab8sm5170291otq.4.2022.09.12.12.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 12:52:29 -0700 (PDT)
Message-ID: <4a9f2b42-f230-b951-f03b-588b94cd39a6@gmail.com>
Date:   Mon, 12 Sep 2022 14:52:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 2/7] RDMA/rxe: Convert the triple tasklets to
 workqueues
Content-Language: en-US
To:     "matsuda-daisuke@fujitsu.com" <matsuda-daisuke@fujitsu.com>,
        'Bart Van Assche' <bvanassche@acm.org>,
        Yanjun Zhu <yanjun.zhu@linux.dev>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Cc:     "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
References: <cover.1662461897.git.matsuda-daisuke@fujitsu.com>
 <41e5476f4f14a0b77f4a8c3826e3ef943bf7c173.1662461897.git.matsuda-daisuke@fujitsu.com>
 <0b3366e6-c0ae-7242-5006-b638e629972d@linux.dev>
 <fd1d7c49-a090-e8c7-415b-dfcda94ace9d@acm.org>
 <TYCPR01MB8455D739FC9FB034E3485C87E5449@TYCPR01MB8455.jpnprd01.prod.outlook.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <TYCPR01MB8455D739FC9FB034E3485C87E5449@TYCPR01MB8455.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/12/22 02:58, matsuda-daisuke@fujitsu.com wrote:
> On Mon, Sep 12, 2022 12:09 AM Bart Van Assche wrote:
>> On 9/11/22 00:10, Yanjun Zhu wrote:
>>> I also implemented a workqueue for rxe. IMO, can we add a variable to
>>> decide to use tasklet or workqueue?
>>>
>>> If user prefer using tasklet, he can set the variable to use
>>> tasklet. And the default is tasklet. Set the variable to another
>>> value to use workqueue.
> 
> That's an interesting idea, but I am not sure how users specify it.
> IIRC, tasklets are generated when rdma link is added, typically by 
> executing ' rdma link add' command. I don't think we can add
> an device specific option to the utility(iproute2/rdma).
> 
>>
>> I'm in favor of removing all uses of the tasklet mechanism because of
>> the disadvantages of that mechanism. See also:
>> * "Eliminating tasklets" (https://lwn.net/Articles/239633/).
>> * "Modernizing the tasklet API" (https://lwn.net/Articles/830964/).
>> * Sebastian Andrzej Siewior's opinion about tasklets
>> (https://lore.kernel.org/all/YvovfXMJQAUBsvBZ@linutronix.de/).
> 
> I am also in favor of using workqueues alone not only because of the
> disadvantages above but also to avoid complexity. I would like to know
> if there is anybody who will bothered by the change especially in terms
> of performance.
> 
> Thanks,
> Daisuke
> 
>>
>> Thanks,
>>
>> Bart.
> 

The HPE patch set for work queues (I should send it in) kept the ability to run tasklets or work queues.
The reason was that the change was motivated by a benchmarking exercise and we found that the performance
of tasklets was noticeably better for one IO stream but for 2 or more IO streams work queues were better because we
could place the work on separate cpus. Tasklets have a tendency to bunch up on the same cpu. I am interested in
how Matsuda got better/same performance for work queues.

Bob
