Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A687A998A
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Sep 2023 20:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjIUSPn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Sep 2023 14:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjIUSP0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Sep 2023 14:15:26 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33BC55AFB;
        Thu, 21 Sep 2023 10:17:37 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c328b53aeaso10363605ad.2;
        Thu, 21 Sep 2023 10:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316657; x=1695921457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bUTWTEvhwTmI9spZVufqCsTCajVPfsOh06nRiT/DqSA=;
        b=JTLXo5ErKyB5oDjF3Ae0ABIDCZkD/YjKQ5z6M+UJEaN5Nx30ub8HeZ+z/U6B0IDo4N
         0ReZKpLA/rRju4imdcmKO1Mvi7jp3xsutz6o475vOHh94KS1oRqgr/cdUT39qdJNKZZ7
         u+3YkYj1iKhts3ZK1+h2MK3AJaEIRjuXwEohk2fNKtqET/J3XVC0zo8AZPkGhoGzBWfw
         HuzSx0osPbzMMMNilz76KIFLkUh03TijbzUQfNtmlxvLxOvezbGGOv3E5jJcYTvmWk3A
         bjWD4bg7VWfSGMBnyPr2HeMcl8fQLHuiBRr2qKRLRhS92gQTHyKwyPLlX6r41SviaZGh
         CcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316657; x=1695921457;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUTWTEvhwTmI9spZVufqCsTCajVPfsOh06nRiT/DqSA=;
        b=ikpPY01JakvvODs/iUFw46+i/lNf4po5k8M5fFEMFyistKSLqxswy30QwgRIozgxWQ
         dNRMxOlTfMYaVFuheo+IBLrziVWhPuuqUtOeiFkqsrNEts+jAvYycHH3DHwStztI4tAD
         VYZUeljLhGsoOLyV0d9Hv8ewAZvsYZxoJdRrMR+oyr9u8+c+qoNJISaJmTZTw7mdOshw
         xOBZi2U24Pi/UBp/gOSAAI4VrXKKDhAEbdI+ZthigR7SBONz8eL1n4zVaERtvDndFuyc
         P3P9daZXKoWEr5gCJcuUTpTx9SPHEocztfd54OrOQCZbFfO/kt5rGd6hncEukYDlIC6j
         eEhQ==
X-Gm-Message-State: AOJu0YwTC8NmV06DC6hDhmRF2vZbJimSZ011Kh1DNVxmNbQziHGvivMf
        kRASHSlchhsUa/txefMUmmNHn6UMvnY=
X-Google-Smtp-Source: AGHT+IHJsK2B1N42OTju2WOjLPqH71PpWleq53Hj3J9skkT7LAvWU6Jh9wn4vIVNARWcTwtIv9JYpg==
X-Received: by 2002:a05:6808:1395:b0:3ae:8a9:e44a with SMTP id c21-20020a056808139500b003ae08a9e44amr1468872oiw.31.1695307180191;
        Thu, 21 Sep 2023 07:39:40 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:2790:d0a7:1c4e:2824? (2603-8081-1405-679b-2790-d0a7-1c4e-2824.res6.spectrum.com. [2603:8081:1405:679b:2790:d0a7:1c4e:2824])
        by smtp.gmail.com with ESMTPSA id bx9-20020a0568081b0900b003adcaf28f61sm400680oib.41.2023.09.21.07.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 07:39:39 -0700 (PDT)
Message-ID: <8aff9124-85c0-8e3b-dc35-1017b1540037@gmail.com>
Date:   Thu, 21 Sep 2023 09:39:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     Rain River <rain.1986.08.12@gmail.com>,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
 <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
 <plrbpd5gg32uaferhjj6ibkt4wqybu3v3y32f4rlhvsruc7cu4@2pgrj2542da2>
 <18a3ae8c-145b-4c7f-a8f5-67840feeb98c@acm.org>
 <ab93655f-c187-fdab-6c67-3bfb2d9aa516@gmail.com>
 <9dd0aa0a-d696-a95b-095b-f54d6d31a6ab@linux.dev>
 <d3205633-0cd2-f87e-1c40-21b8172b6da3@linux.dev>
 <nqdsj764d7e56kxevcwnq6qoi6ptuu3bi6ntfakb55vm3toda7@eo3ffzzqrot7>
 <5a4efe6f-d8c6-84ce-377e-eb64bcad706c@linux.dev>
 <f50beb15-2cab-dfb9-3b58-ea66e7f114a6@gmail.com>
 <fe61fdc5-ca8f-2efc-975d-46b99d66c6f5@linux.dev>
 <afc98035-1bb8-f75c-451a-8e3e39fb74aa@gmail.com>
 <6fc3b524-af7d-43ce-aa05-5c44ec850b9b@acm.org>
 <b728f4db-bafa-dd0f-e288-7e3f56e6eae8@gmail.com>
 <02d7cbf2-b17b-488a-b6e9-ebb728b51c94@acm.org>
 <b80dae29-3a7c-f039-bc35-08c6e9f91197@gmail.com>
 <CAJr_XRAy4EHueAP-10=WSEa46j2aQBArdzYsq7OqSqR93Ue+ug@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CAJr_XRAy4EHueAP-10=WSEa46j2aQBArdzYsq7OqSqR93Ue+ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/21/23 09:23, Rain River wrote:
> On Thu, Sep 21, 2023 at 2:53 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> On 9/20/23 12:22, Bart Van Assche wrote:
>>> On 9/20/23 10:18, Bob Pearson wrote:
>>>> But I have also seen the same behavior in the siw driver which is
>>>> completely independent.
>>>
>>> Hmm ... I haven't seen any hangs yet with the siw driver.
>>
>> I was on Ubuntu 6-9 months ago. Currently I don't see hangs on either.
>>>
>>>> As mentioned above at the moment Ubuntu is failing rarely. But it used to fail reliably (srp/002 about 75% of the time and srp/011 about 99% of the time.) There haven't been any changes to rxe to explain this.
>>>
>>> I think that Zhu mentioned commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue
>>> support for rxe tasks")?
>>
>> That change happened well before the failures went away. I was seeing failures at the same rate with tasklets
>> and wqs. But after updating Ubuntu and the kernel at some point they all went away.
> 
> I made tests on the latest Ubuntu with the latest kernel without the
> commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks").
> The latest kernel is v6.6-rc2, the commit 9b4b7c1f9f54 ("RDMA/rxe: Add
> workqueue support for rxe tasks") is reverted.
> I made blktest tests for about 30 times, this problem does not occur.
> 
> So I confirm that without this commit, this hang problem does not
> occur on Ubuntu without the commit 9b4b7c1f9f54 ("RDMA/rxe: Add
> workqueue support for rxe tasks").
> 
> Nanthan
> 
>>
>>>
>>> Thanks,
>>>
>>> Bart.
>>
>>

This commit is very important for several reasons. It is needed for the ODP implementation
that is in the works from Daisuke Matsuda and also for QP scaling of performance. The work
queue implementation scales well with increasing qp number while the tasklet implementation
does not. This is critical for the drivers use in large scale storage applications. So, if
there is a bug in the work queue implementation it needs to be fixed not reverted.

I am still hoping that someone will diagnose what is causing the ULPs to hang in terms of
something missing causing it to wait.

Bob
