Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F056787D38
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Aug 2023 03:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjHYBgX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Aug 2023 21:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbjHYBgQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Aug 2023 21:36:16 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8775B10F4;
        Thu, 24 Aug 2023 18:36:14 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-573449a364fso43793eaf.1;
        Thu, 24 Aug 2023 18:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692927374; x=1693532174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z/J0omGWWqNb2lMsShSCKML3nG38sMLDItX9/6kkpSM=;
        b=ghwdi/pUKZINdZz2l4kfv1QyLxUqEhgfgr8IJJo6b5eZ0kwOieHyM5MNoU9H9j7UzG
         4NXvZjcAt76qgk0QTG26Zmcd6s4+ACtZjY7EFiEJjurtbtk/I9JLahHGLnEBctXtUT+Z
         UIDh85mlxaZBUy9Im/pysgl0ZxuwuCPU2E5NcuU4xupT3qWT1MbqBIeup56eeTK2qeMQ
         OTy3JNmxLs/ksuIdCgLxd0BRO3FhK99aI9iqg+uObOYhU5snQ4Lb8ztbS2QgP26y/lHB
         r/pNCgVleD/t0uz860UO9lMfi+dfa+UJdVtaBFwOgG0vBFAfNx2GofDNofYSsrMNFYnD
         eD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692927374; x=1693532174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/J0omGWWqNb2lMsShSCKML3nG38sMLDItX9/6kkpSM=;
        b=g+JX/jsVnl3sg+B0MsphfB9FqSNvHj7TjLilbZStuLTed90RR2HDlXm8c/QLLiTjdn
         x++0G7CNp83pO5X3StyAq7cREVfoXwfxuOP3zp47EWPL+Uk0zkIO2mXa4qEyYgFZBW2G
         7L0ng3Dmp079WXNH01keLxEC8ICS3noFlIxEt4Xlej049lFcWcXXMTJZrQN1VRDeCjke
         RzOX65AoEjzfhBDD3/PJtINCracMIv2Bjcv2CeG17omeiXHsVzWvX/8WcDxloE7NIIRB
         r7gji/PnAeX0uv/UhE57bYXF49BQ0KX1fkIqQXy1z7nSdWSk710AbRvoQocO/yJH8LBk
         Shpg==
X-Gm-Message-State: AOJu0YyE4GGQMOHO5ANUT2GCzf02tBxtff/ZHIeOIytyiYgoUTjPspXS
        lLL9gHSpL+te7qeNTf4B4ok=
X-Google-Smtp-Source: AGHT+IEuBSZOsPDKl0FcnEcAoJvcly+KdDFrwj4aOrUCmbM3HJNWs6imVkiloelWBirEoZ7IpQ7gRQ==
X-Received: by 2002:a05:6870:330a:b0:1bf:e1e9:a320 with SMTP id x10-20020a056870330a00b001bfe1e9a320mr1691589oae.13.1692927373767;
        Thu, 24 Aug 2023 18:36:13 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:16dd:44f3:4ece:f186? (2603-8081-140c-1a00-16dd-44f3-4ece-f186.res6.spectrum.com. [2603:8081:140c:1a00:16dd:44f3:4ece:f186])
        by smtp.gmail.com with ESMTPSA id z43-20020a056870c22b00b001cd04c355d8sm169721oae.29.2023.08.24.18.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 18:36:13 -0700 (PDT)
Message-ID: <783a432a-1875-d508-741d-ccc1277bb67a@gmail.com>
Date:   Thu, 24 Aug 2023 20:36:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com>
 <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
 <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
 <plrbpd5gg32uaferhjj6ibkt4wqybu3v3y32f4rlhvsruc7cu4@2pgrj2542da2>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <plrbpd5gg32uaferhjj6ibkt4wqybu3v3y32f4rlhvsruc7cu4@2pgrj2542da2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/24/23 20:11, Shinichiro Kawasaki wrote:
> On Aug 22, 2023 / 08:20, Bart Van Assche wrote:
>> On 8/22/23 03:18, Shinichiro Kawasaki wrote:
>>> CC+: Bart,
>>>
>>> On Aug 21, 2023 / 20:46, Bob Pearson wrote:
>>> [...]
>>>> Shinichiro,
>>>
>>> Hello Bob, thanks for the response.
>>>
>>>>
>>>> I have been aware for a long time that there is a problem with blktests/srp. I see hangs in
>>>> 002 and 011 fairly often.
>>>
>>> I repeated the test case srp/011, and observed it hangs. This hang at srp/011
>>> also can be recreated in stable manner. I reverted the commit 9b4b7c1f9f54
>>> then observed the srp/011 hang disappeared. So, I guess these two hangs have
>>> same root cause.
>>>
>>>> I have not been able to figure out the root cause but suspect that
>>>> there is a timing issue in the srp drivers which cannot handle the slowness of the software
>>>> RoCE implemtation. If you can give me any clues about what you are seeing I am happy to help
>>>> try to figure this out.
>>>
>>> Thanks for sharing your thoughts. I myself do not have srp driver knowledge, and
>>> not sure what clue I should provide. If you have any idea of the action I can
>>> take, please let me know.
>>
>> Hi Shinichiro and Bob,
>>
>> When I initially developed the SRP tests these were working reliably in
>> combination with the rdma_rxe driver. Since 2017 I frequently see issues when
>> running the SRP tests on top of the rdma_rxe driver, issues that I do not see
>> if I run the SRP tests on top of the soft-iWARP driver (siw). How about
>> changing the default for the SRP tests from rdma_rxe to siw and to let the
>> RDMA community resolve the rdma_rxe issues?
> 
> If it takes time to resolve the issues, it sounds a good idea to make siw driver
> default, since it will make the hangs less painful for blktests users. Another
> idea to reduce the pain is to improve srp/002 and srp/011 to detect the hangs
> and report them as failures.
> 
> Having said that, some discussion started on this thread for resolution
> (thanks!) I would wait for a while and see how long it will take for solution,
> and if the actions on blktests side are valuable or not.

Did you see Bart's comment about srp not working with older versions of multipathd?
He is currently not seeing any hangs at all.

Bob
