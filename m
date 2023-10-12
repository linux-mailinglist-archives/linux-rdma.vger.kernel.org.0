Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AD77C71B1
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Oct 2023 17:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbjJLPio (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Oct 2023 11:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjJLPin (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Oct 2023 11:38:43 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA4FC6;
        Thu, 12 Oct 2023 08:38:42 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6c0b8f42409so722457a34.0;
        Thu, 12 Oct 2023 08:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697125122; x=1697729922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fQsZLjycUl+urrXsHz/1jrROvxxrkNzW4ZQyWKE/Drs=;
        b=ZaN5lXqo4OJBjQGTp7oLfXVXne+knZViDVdvm8uIkfu7sf25E9qaVDF2lwmAmgWY0s
         JnFHx/o/VaTWzT7baQAx5xWWvpMyKDzlLLrL2MdbLeHXhuhLcIcxnS7vZplGabuvQqtV
         +DcMUWvDg6tgklYus4EuMaOFVW34PaSyUHWO+RiUc23l8oaCxB4Bi6AWaE94VtxFH399
         2izl8+dFvQVzwfoIgG0sihfwJTjitIytsvXIWcPpARgUa2Vo2+XRj6mv2At23KbLhvFp
         W1oPCLY8qcspRiVrV6kG5pOT4NuoLS9esbktJH1B0cqeFVA72IbeXspgSv2xoILDLJEn
         Ps7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697125122; x=1697729922;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQsZLjycUl+urrXsHz/1jrROvxxrkNzW4ZQyWKE/Drs=;
        b=nrNw9l3Zz9q5JFtYUZ5IVQPacDSBhJNgGbzdtZUB5DpHQBF3Bu6nNzk/pCAZsujH4s
         VtlP7OXk5eWp/EjT0IfISKio1ElCK79NTrA0IBn1uwpGIpvsU3FoJ0TqEIqxzDjssN/b
         5agAuEV6Ygf6W5WO0aJD21OaLFxVzcbmILj3hzHIxhrQa+BfX+BrPuOcS5Fk9+dXyycg
         nViuTXOkJIU3dV1LYBN4y+AWgx6MwtwEVBwIR5/6pJwEh0FDIp+mAcZAB6L1tiJGww3k
         j0EKF4kyzAxkt9ulK2Qhk3gmlBy9FtZLT48KGhdvt5FKK94s3VMsnSqlWFjkSxiZHDnL
         StHg==
X-Gm-Message-State: AOJu0YxaMAUSCAOqavIwMiVdoHh1bP1r8fSlq7phuyPvEbSfHROkxe5z
        +2Zl35Q2Nmf6MwU3BJglm28=
X-Google-Smtp-Source: AGHT+IGoAOkLQsca0vD7Og6sKBQe//S6LKK5mmMD7ypyaH9Dlm/CmutTzYed/TTEp0MaxG0fRceFkQ==
X-Received: by 2002:a05:6830:1b6e:b0:6b8:f730:7ab4 with SMTP id d14-20020a0568301b6e00b006b8f7307ab4mr26779263ote.0.1697125121850;
        Thu, 12 Oct 2023 08:38:41 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:658d:e60e:7bda:b251? (2603-8081-1405-679b-658d-e60e-7bda-b251.res6.spectrum.com. [2603:8081:1405:679b:658d:e60e:7bda:b251])
        by smtp.gmail.com with ESMTPSA id x21-20020a9d6d95000000b006c65f431799sm341934otp.23.2023.10.12.08.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 08:38:41 -0700 (PDT)
Message-ID: <b3a8d1f8-512c-4520-8841-06d54f483f4f@gmail.com>
Date:   Thu, 12 Oct 2023 10:38:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
To:     Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        Leon Romanovsky <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Zhu Yanjun <yanjun.zhu@intel.com>
References: <20231004183824.GQ13795@ziepe.ca>
 <c0665377-d2be-e4b6-3d25-727ef303d26e@linux.dev>
 <20231005142148.GA970053@ziepe.ca>
 <6a730dad-9d81-46d9-8adc-764d00745b01@acm.org>
 <a8453889-3f5f-49ff-89f2-ec0ef929d915@linux.dev>
 <OS3PR01MB9865F9BEB1A90DDCAEEBFC8BE5CDA@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <20231010160919.GC55194@ziepe.ca>
 <a4808fa6-5bd5-4a64-a437-6a7e89ca7e9f@acm.org>
 <20231011155104.GF55194@ziepe.ca>
 <70191324-018e-4cfe-9c1d-0bd3d17fb437@acm.org>
 <20231011231201.GH55194@ziepe.ca>
 <fe0fbdd9-93a2-4478-b1ef-9b2420c0d76e@linux.dev>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <fe0fbdd9-93a2-4478-b1ef-9b2420c0d76e@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/12/23 06:49, Zhu Yanjun wrote:
> 在 2023/10/12 7:12, Jason Gunthorpe 写道:
>> On Wed, Oct 11, 2023 at 01:14:16PM -0700, Bart Van Assche wrote:
>>> On 10/11/23 08:51, Jason Gunthorpe wrote:
>>>> If we revert it then rxe will probably just stop development
>>>> entirely. Daisuke's ODP work will be blocked and if Bob was able to
>>>> fix it he would have done so already. Which mean's Bobs ongoing work
>>>> is lost too.
>>>
>>> If Daisuke's work depends on the RXE changes then Daisuke may decide
>>> to help with the RXE changes.
>>>
>>> Introducing regressions while refactoring code is not acceptable.
>>
>> Generally, but I don't view rxe as a production part of the kernel so
>> I prefer to give time to resolve it.
>>
>>> I don't have enough spare time to help with the RXE driver.
> 
> commit 11ab7cc7ee32d6c3e16ac74c34c4bbdbf8f99292
> Author: Bart Van Assche <bvanassche@acm.org>
> Date:   Tue Aug 22 09:57:07 2023 -0700
> 
>     Change the default RDMA driver from rdma_rxe to siw
> 
>     Since the siw driver is more stable than the rdma_rxe driver, change the
>     default into siw. See e.g.
> 
> https://lore.kernel.org/all/c3d1a966-b9b0-d015-38ec-86270b5045fc@acm.org/.
> 
>     Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>     Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 
> 
>>
>> Nor I
>>
>> Jason
> 
All,

I have spent the past several weeks working on trying to resolve this issue. The one thing I can say
for sure is that the failures or their rates are very sensitive to small timing changes. I totally agree
Jason that the bug has always been there and most of the suggested changes are just masking or unmasking
it. I have been running under all the kernel lock checking I can set and have not seen any warnings
so I doubt the error is a deadlock. My suspicion remains that the root cause of the hang is loss of
a completion or a timeout before a late completion leading to the transport state machine death. There
are surely other bugs in the driver and they may show up in parallel with this hang. I see the hang
consistently from 1-2% to 30-40% of the time when running srp/002 depending on various changes I have
tried but I have not been able to reproduce the KASAN bug yet. Because the hang is easy to reproduce
I have focused on that.

Bob
