Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14F27AF307
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 20:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbjIZSeN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 14:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbjIZSeM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 14:34:12 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F7E10A;
        Tue, 26 Sep 2023 11:34:06 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-57babef76deso2990472eaf.0;
        Tue, 26 Sep 2023 11:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695753245; x=1696358045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1mu1Bd3YR/EVNf3MxOCAO473xXr4bjv6njd4p5rKank=;
        b=ehsDr7yokwSJ8P72RFWmHAq4UAp5wDxBDXNb2kmfs3mgzmfV8U8GTJ1ySggIyLamT3
         6UYkxAvLLmS2DlRMT2Bu9uvOyI9hwkaGDpURhu++8N7S1NsnNpqmItbg5+L6KJA8f9zu
         yS2r0a9YY3z/fmdjMt2NJlVwoMe+httAdxir2nIhCAuEx6+skthxJyStJWLcBKqNeYkf
         oRe6BOAS/AJNqNMFUKARGyub9jc8sO8DTka9OtdMXO9RD2tzTQjdisAOj1Tc/Pb9Aom1
         xnsqvmam86lKa5tsK4/w5g6k5YgiSybbUJLZ1kxT9gjnfq2qIOyDHY1lXwPbkQtgw1il
         zKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695753245; x=1696358045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1mu1Bd3YR/EVNf3MxOCAO473xXr4bjv6njd4p5rKank=;
        b=kpzZ9dDGOkSymr+cs0gWI9c8SVEIJ70nPIfxw1MpNAMrEXOifWJzCdR7ehB+COgvIu
         QgNE/o7XxBg2yObZVc8W32kzPm/7irBs08kzu9u7A5fAuApXT5kw0VoEQNryK15S6FGv
         3QiusryYyDFNti3HpgZF/xjm2OWCagJyVANm3R8JusqB8987GgjzCHhpDweshb+xrpIt
         HyVOIOGPG+CQ/wagBq5H2ZsugDiTpWLyDSrwGBO4q7elkXYQWUElVhopJLvWgds3fO2k
         xIr9rUfZIgjBjBIeLU9KXEDhz0/b/Ht+JquinyJ+bEqLiwwH83S3xZF5NpMDXPl1WIZK
         bT+w==
X-Gm-Message-State: AOJu0YzO+cURsw344M4JLx5idI4U2dfjQIdS28DaycAedlk+QtreCe4c
        OUM7WKT1JLQ/0faTs9dgVbw=
X-Google-Smtp-Source: AGHT+IFp32R9gGtQLbbRIrsHPq6wNzP6FDQVHmOUjphw+hTJygV8C9o3zjrgZzxYbw2bSesaNK2Hjw==
X-Received: by 2002:a4a:2552:0:b0:57b:8e13:93c3 with SMTP id v18-20020a4a2552000000b0057b8e1393c3mr10037793ooe.1.1695753245125;
        Tue, 26 Sep 2023 11:34:05 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:1db2:43c5:5dfd:1642? (2603-8081-1405-679b-1db2-43c5-5dfd-1642.res6.spectrum.com. [2603:8081:1405:679b:1db2:43c5:5dfd:1642])
        by smtp.gmail.com with ESMTPSA id w8-20020a4aa448000000b0057b7edcb118sm1677689ool.32.2023.09.26.11.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 11:34:04 -0700 (PDT)
Message-ID: <b7b365e3-dd11-bc66-dace-05478766bf41@gmail.com>
Date:   Tue, 26 Sep 2023 13:34:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
To:     Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        matsuda-daisuke@fujitsu.com, shinichiro.kawasaki@wdc.com,
        linux-scsi@vger.kernel.org, Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
References: <20230922163231.2237811-1-yanjun.zhu@intel.com>
 <169572143704.2702191.3921040309512111011.b4-ty@kernel.org>
 <20230926140656.GM1642130@unreal>
 <d3c05064-a88b-4719-a390-6bf9ae01fba5@acm.org>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <d3c05064-a88b-4719-a390-6bf9ae01fba5@acm.org>
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

On 9/26/23 12:05, Bart Van Assche wrote:
> On 9/26/23 07:06, Leon Romanovsky wrote:
>> On Tue, Sep 26, 2023 at 12:43:57PM +0300, Leon Romanovsky wrote:
>>>
>>> On Fri, 22 Sep 2023 12:32:31 -0400, Zhu Yanjun wrote:
>>>> This reverts commit 9b4b7c1f9f54120940e243251e2b1407767b3381.
>>>>
>>>> This commit replaces tasklet with workqueue. But this results
>>>> in occasionally pocess hang at the blktests test case srp/002.
>>>> After the discussion in the link[1], this commit is reverted.
>>>>
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>> [1/1] Revert "RDMA/rxe: Add workqueue support for rxe tasks"
>>>        https://git.kernel.org/rdma/rdma/c/e710c390a8f860
>>
>> I applied this patch, but will delay it for some time with a hope that
>> fix will arrive in the near future.
> 
> Thank you Leon. With this revert applied on top of the rdma for-next branch, I
> don't see the KASAN complaint anymore that I reported yesterday. I think this
> is more evidence that the KASAN complaint was caused by the RXE driver.
> 
> Bart.

Bart,

I am working to try to reproduce the KASAN warning. Unfortunately, so far I am not able to see it
in Ubuntu + Linus' kernel (as you described) on metal. The config file is different but copies
the CONFIG_KASAN_xxx exactly as yours. With KASAN enabled it hangs on every iteration of srp/002
but without a KASAN warning. I am now building an openSuSE VM for qemu and will see if that
causes the warning.

Thanks for the support,

Bob

