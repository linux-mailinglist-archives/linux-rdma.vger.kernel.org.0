Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E632C7A6A7A
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 20:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjISSMG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Sep 2023 14:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjISSMG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Sep 2023 14:12:06 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D83D8F;
        Tue, 19 Sep 2023 11:11:56 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-573921661a6so3450471eaf.1;
        Tue, 19 Sep 2023 11:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695147116; x=1695751916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EpolQSnynorSkLR4MKF0xH2DyyIUKJh04TziLNWeL8s=;
        b=RL1KEHBl6aeV3ze3Nu+ktRg9FHvpqoyBnmzQIP0OeAIjx96w1+QgCB5UbOYjZulutM
         UI/okbnRiqmWoboVR1oZd8hwW39wApuDpLTxYUra2KcKogeaI63ZQt7BXatUtvseydLi
         CVS3K70KbElQwjpZA/47QyvOrWWj/8MSOVkhNMrVrUHXZMEEBnfZfzd/rziJ0C4qwD2p
         EZJW/bRBhHCDXyA2C2l+oa0nBPVONe6qfmgKq4sSR0vdPnTd/piG2c2xhv5nS1/vwajX
         JBLsqJkUqntRnaP5BqsgDWAIxZDeLP33mvs5WhaXfdaQJp2lsVrKXN6z1FE6kSGkdnCm
         eMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695147116; x=1695751916;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpolQSnynorSkLR4MKF0xH2DyyIUKJh04TziLNWeL8s=;
        b=O+lym6raQgnrB/aEllu8DfQadMdxNAsEPkvecWEvokdstlIP+hnMmNMWLkYZkubhvF
         xTyYDXvAFg9h3vR2OEVQTDG2vaoYcPSPjeUN69JksrUHIosLiQ2oIci4sJB6fwAKAb4z
         T+Vx0g8oTofwqV8O/1LKO2Rv8FSF114VEDVAJYqAgBl+mFYDs6fxxojbd3BSQ+wJOCnG
         qBzn9xVywRxZ2J+1rHajmw/m9jYUc9Q/b3LQpBXbmFHeFWnGQUuiULubCu7IkWF8qCKR
         enhY/bNh6j/Ixh+6b/BY7uo8h5cBowO25MSVGM3b/SBKCpES3pVM9KgQOthCg5HIOnMm
         ikjw==
X-Gm-Message-State: AOJu0Ywz3shhgbZ00VsLk2J+EcTsdMKbTM+eeTIHJdVogyzN2YFv8BXK
        PSYo2FKxgmFjz3eskYdddZ8=
X-Google-Smtp-Source: AGHT+IFT+b/dcs+E5G/IencVhkBBLWOSR/P6icSf6yCKJhZl47TfsRC+1f8qsvDeAfTbFoXFGMeimA==
X-Received: by 2002:a4a:dfa3:0:b0:573:2ac5:43b4 with SMTP id k3-20020a4adfa3000000b005732ac543b4mr452120ook.5.1695147115721;
        Tue, 19 Sep 2023 11:11:55 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:b0bb:fc45:82b2:7448? (2603-8081-1405-679b-b0bb-fc45-82b2-7448.res6.spectrum.com. [2603:8081:1405:679b:b0bb:fc45:82b2:7448])
        by smtp.gmail.com with ESMTPSA id v17-20020a4a9751000000b00573f5173a57sm5902486ooi.23.2023.09.19.11.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 11:11:55 -0700 (PDT)
Message-ID: <f50beb15-2cab-dfb9-3b58-ea66e7f114a6@gmail.com>
Date:   Tue, 19 Sep 2023 13:11:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [bug report] blktests srp/002 hang
To:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com>
 <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
 <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
 <plrbpd5gg32uaferhjj6ibkt4wqybu3v3y32f4rlhvsruc7cu4@2pgrj2542da2>
 <18a3ae8c-145b-4c7f-a8f5-67840feeb98c@acm.org>
 <ab93655f-c187-fdab-6c67-3bfb2d9aa516@gmail.com>
 <9dd0aa0a-d696-a95b-095b-f54d6d31a6ab@linux.dev>
 <d3205633-0cd2-f87e-1c40-21b8172b6da3@linux.dev>
 <nqdsj764d7e56kxevcwnq6qoi6ptuu3bi6ntfakb55vm3toda7@eo3ffzzqrot7>
 <5a4efe6f-d8c6-84ce-377e-eb64bcad706c@linux.dev>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <5a4efe6f-d8c6-84ce-377e-eb64bcad706c@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/19/23 03:07, Zhu Yanjun wrote:
> 在 2023/9/19 12:14, Shinichiro Kawasaki 写道:
>> On Sep 16, 2023 / 13:59, Zhu Yanjun wrote:
>> [...]
>>> On Debian, with the latest multipathd or revert the commit 9b4b7c1f9f54
>>> ("RDMA/rxe: Add workqueue support for rxe tasks"), this problem will
>>> disappear.
>>
>> Zhu, thank you for the actions.
>>
>>> On Fedora 38, if the commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support
>>> for rxe tasks") is reverted, will this problem still appear?
>>> I do not have such test environment. The commit is in the attachment,
>>> can anyone have a test? Please let us know the test result. Thanks.
>>
>> I tried the latest kernel tag v6.6-rc2 with my Fedora 38 test systems. With the
>> v6.6-rc2 kernel, I still see the hang. I repeated the blktests test case srp/002
>> 30 time or so, then the hang was recreated. Then I reverted the commit
>> 9b4b7c1f9f54 from v6.6-rc2, and the hang disappeared. I repeated the blktests
>> test case 100 times, and did not see the hang.
>>
>> I confirmed these results under two multipathd conditions: 1) with Fedora latest
>> device-mapper-multipath package v0.9.4, and 2) the latest multipath-tools v0.9.6
>> that I built from source code.
>>
>> So, when the commit gets reverted, the hang disappears as I reported for
>> v6.5-rcX kernels.
> Thanks, Shinichiro Kawasaki. Your helps are appreciated.
> 
> This problem is related with the followings:
> 
> 1). Linux distributions: Ubuntu, Debian and Fedora;
> 
> 2). multipathd;
> 
> 3). the commits 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks")
> 
> On Ubuntu, with or without the commit, this problem does not occur.
> 
> On Debian, without this commit, this problem does not occur. With this commit, this problem will occur.
> 
> On Fedora, without this commit, this problem does not occur. With this commit, this problem will occur.
> 
> The commits 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks") is from Bob Pearson.
> 
> Hi, Bob, do you have any comments about this problem? It seems that this commit is not compatible with blktests.
> 
> Hi, Jason and Leon, please comment on this problem.
> 
> Thanks a lot.
> 
> Zhu Yanjun

My belief is that the issue is related to timing not the logical operation of the code.
Work queues are just kernel processes and can be scheduled (if not holding spinlocks)
while soft IRQs lock up the CPU until they exit. This can cause longer delays in responding
to ULPs. The work queue tasks for each QP are strictly single threaded which is managed by
the work queue framework the same as tasklets.

Earlier in time I have also seen the exact same hang behavior with the siw driver but not
recently. Also I have seen sensitivity to logging changes in the hang behavior. These are
indications that timing may be the cause of the issue.

Bob
