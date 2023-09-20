Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF357A895F
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 18:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbjITQYn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 12:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbjITQYm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 12:24:42 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852179F;
        Wed, 20 Sep 2023 09:24:36 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6c0f3f24c27so23688a34.2;
        Wed, 20 Sep 2023 09:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695227076; x=1695831876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SaOmqbXd2DCDaAkrB2PNTk8wrCfPgeFkve9J27yN4gc=;
        b=k4zVVjFWzaiGPMyTCEwB0xNpAB0YhLAa7f/v6oj+cnVFPVEBg/u/i5gvnzz4gLcdTg
         4zINsHvYSSE8nLO5WElIRNr4VQz/LVEuG4E0zlk7u4kTT5wTQMDAgu6EkRTDVbRbqnBD
         yksPJS4AtQVpaVDrJhT8e7RgjnRbEpt4caMzJP7uRVTAWxOxsMnAXCVue4E4mdNZYgDl
         JDsRcmKKakIIPK4XH+iT+FWQOX61u/lUQiJY5z4Tw344FKUSNa4dQzpHvU64JE5ho3B5
         pZABoAA3j7dInBlD2FFNk3qRAUZWYb8YPraHdKnOkn2nO5mJ9QpMFS/GswgBsiuS9eWu
         9Aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695227076; x=1695831876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SaOmqbXd2DCDaAkrB2PNTk8wrCfPgeFkve9J27yN4gc=;
        b=fHUeTrIZLgePMrvjXjtkXfD0eRtJiWNnaDHlbxJdeEMyYuzT2/eCQt1eOuLk51FxzN
         DhoT0mTFeUM97MSmrD5vqs7pwf8csUIUd1dn2thHzoRk1yzQDlafgobYPxY+TQtA/FeK
         MJwYXCEnzFVctM2JZgvwvubtFHzPP7zmuvHBVnLSf+w6cyu1QbbaGudNuNpThYlCzsOG
         cdO7lkKs8tnr5G7EH6SDdZVK7kx5xSuJdSSN2mIuzpeTF3EPso0ZqSKkio+v0QnF4wKa
         ryGPCnrVYGlEAzQb2xGPTA6AJl3aOzZV5YogDq3cvi6v2RKz6XMwxBVZfJ0UKOlHlrw6
         45gA==
X-Gm-Message-State: AOJu0YwWDi0UxS323ZNQIokehxirIV/q6XFV7Djra4hLP7ZBB/u5Ald5
        okRYuduVWT0TIzhsgZmwzpcqgjYHCSk=
X-Google-Smtp-Source: AGHT+IF2xCtsBnG7ssm+FhNGFwHqn6KO52LAlAEgL9C4WJcUlROr7mO9ReH25Q/ozhyAohHMmpE+RQ==
X-Received: by 2002:a9d:4f13:0:b0:6b7:4a52:a33a with SMTP id d19-20020a9d4f13000000b006b74a52a33amr3125905otl.14.1695227075695;
        Wed, 20 Sep 2023 09:24:35 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:dc02:5dd1:9c21:a1b6? (2603-8081-1405-679b-dc02-5dd1-9c21-a1b6.res6.spectrum.com. [2603:8081:1405:679b:dc02:5dd1:9c21:a1b6])
        by smtp.gmail.com with ESMTPSA id l1-20020a9d7341000000b006bcbffa5167sm6134632otk.76.2023.09.20.09.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 09:24:34 -0700 (PDT)
Message-ID: <afc98035-1bb8-f75c-451a-8e3e39fb74aa@gmail.com>
Date:   Wed, 20 Sep 2023 11:24:33 -0500
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
 <f50beb15-2cab-dfb9-3b58-ea66e7f114a6@gmail.com>
 <fe61fdc5-ca8f-2efc-975d-46b99d66c6f5@linux.dev>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <fe61fdc5-ca8f-2efc-975d-46b99d66c6f5@linux.dev>
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

On 9/19/23 23:22, Zhu Yanjun wrote:
> 
> 在 2023/9/20 2:11, Bob Pearson 写道:
>> On 9/19/23 03:07, Zhu Yanjun wrote:
>>> 在 2023/9/19 12:14, Shinichiro Kawasaki 写道:
>>>> On Sep 16, 2023 / 13:59, Zhu Yanjun wrote:
>>>> [...]
>>>>> On Debian, with the latest multipathd or revert the commit 9b4b7c1f9f54
>>>>> ("RDMA/rxe: Add workqueue support for rxe tasks"), this problem will
>>>>> disappear.
>>>> Zhu, thank you for the actions.
>>>>
>>>>> On Fedora 38, if the commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support
>>>>> for rxe tasks") is reverted, will this problem still appear?
>>>>> I do not have such test environment. The commit is in the attachment,
>>>>> can anyone have a test? Please let us know the test result. Thanks.
>>>> I tried the latest kernel tag v6.6-rc2 with my Fedora 38 test systems. With the
>>>> v6.6-rc2 kernel, I still see the hang. I repeated the blktests test case srp/002
>>>> 30 time or so, then the hang was recreated. Then I reverted the commit
>>>> 9b4b7c1f9f54 from v6.6-rc2, and the hang disappeared. I repeated the blktests
>>>> test case 100 times, and did not see the hang.
>>>>
>>>> I confirmed these results under two multipathd conditions: 1) with Fedora latest
>>>> device-mapper-multipath package v0.9.4, and 2) the latest multipath-tools v0.9.6
>>>> that I built from source code.
>>>>
>>>> So, when the commit gets reverted, the hang disappears as I reported for
>>>> v6.5-rcX kernels.
>>> Thanks, Shinichiro Kawasaki. Your helps are appreciated.
>>>
>>> This problem is related with the followings:
>>>
>>> 1). Linux distributions: Ubuntu, Debian and Fedora;
>>>
>>> 2). multipathd;
>>>
>>> 3). the commits 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks")
>>>
>>> On Ubuntu, with or without the commit, this problem does not occur.
>>>
>>> On Debian, without this commit, this problem does not occur. With this commit, this problem will occur.
>>>
>>> On Fedora, without this commit, this problem does not occur. With this commit, this problem will occur.
>>>
>>> The commits 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks") is from Bob Pearson.
>>>
>>> Hi, Bob, do you have any comments about this problem? It seems that this commit is not compatible with blktests.
>>>
>>> Hi, Jason and Leon, please comment on this problem.
>>>
>>> Thanks a lot.
>>>
>>> Zhu Yanjun
>> My belief is that the issue is related to timing not the logical operation of the code.
>> Work queues are just kernel processes and can be scheduled (if not holding spinlocks)
>> while soft IRQs lock up the CPU until they exit. This can cause longer delays in responding
>> to ULPs. The work queue tasks for each QP are strictly single threaded which is managed by
>> the work queue framework the same as tasklets.
> 
> Thanks, Bob. From you, the workqueue can be scheduled, this can cause longer delays in reponding to ULPs.
> 
> This will cause ULPs to hang. But the tasklet will lock up the CPU until it exits. So the tasklet will repond to
> 
> ULPs in time.
> 
> To this, there are 3 solutins:
> 
> 1). Try to make workqueue respond ULPs in time, this hang problem should be avoided. so this will not cause
> 
> this problem. But from the kernel, workqueue should be scheduled,So it is difficult to avoid this longer delay.
> 
> 
> 2). Make tasklet and workqueue both work in RXE.  We can make one of tasklet or workqueue as the default. The user
> 
> can choose to use tasklet or workqueue via kernel module parameter or sysctl variables. This will cost a lot of time
> 
> and efforts to implement it.
> 
> 
> 3). Revert the commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks"). Shinichiro Kawasaki
> 
> confirmed that this can fix this regression. And the patch is in the attachment.
> 
> 
> Hi, Bob, Please comment.
> 
> Hi, Jason && Leon, please also comment on this.
> 
> Thanks a lot.
> 
>>
>> Earlier in time I have also seen the exact same hang behavior with the siw driver but not
>> recently. Also I have seen sensitivity to logging changes in the hang behavior. These are
> 
> This is a regression to RXE which is caused by the the commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks").
> 
> We should fix it.
> 
> Zhu Yanjun
> 
>> indications that timing may be the cause of the issue.
>>
>> Bob

The verbs APIs do not make real time commitments. If a ULP fails because of response times it is the
problem in the ULP not in the verbs provider.

Bob
