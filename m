Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33ADB7AF18A
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 19:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjIZRF6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 13:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjIZRF5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 13:05:57 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE29CE5;
        Tue, 26 Sep 2023 10:05:50 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-69101022969so8263045b3a.3;
        Tue, 26 Sep 2023 10:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695747950; x=1696352750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ciyIL3UJ+mFPGzRDJSNW4K/Q77//MQkL34dUxJQCXb8=;
        b=ZbvuumQrF3ab4ygjnENd6ng7xo/yb++PfJmlX9DsEeffs5yTJkLuSBn22pUuHjaHem
         EOuuCgG2HBq1v3F3DBtqaSgsRdTrqkJE8rhCeJS2sidntU/q5Mn4ZMZ/u8Q5fzpkVI23
         lXAbuvOXpehNc1hizM0+FMmiSBdh6QPE0XtXYdZkN/OHLQ2cZodQHh1LdG/iYML4EP9P
         3L8BRFuu/QT2JAW1+wgHzyJFlbPkqOpbg/EHvIah0zq+G3aRUdDt5xqXK42qtqHTrJvR
         QR3qMyQTwpiWDnXDoBt+EhFXsnc1KLVJIOnspOYIapnJFHqVIUH8fKCeoN92XLlX1kuJ
         6lSw==
X-Gm-Message-State: AOJu0YwKQhDfa9b9Dd1ZGUl93HBBB7FGkj1O08WPzHO688n4mB9YVWPl
        PHzG+h2zsp5AZwI7r8K2trQ=
X-Google-Smtp-Source: AGHT+IEJIczeDGpprRAJrao9yQ5dyRTC3m9+JVYk2bI5mNQlLSsr1U2DxP+wrQAKbvyim9J7gAkmIw==
X-Received: by 2002:a05:6a00:1ace:b0:691:da6:47a with SMTP id f14-20020a056a001ace00b006910da6047amr12656670pfv.31.1695747949820;
        Tue, 26 Sep 2023 10:05:49 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a80d:6f65:53d4:d1bf? ([2620:15c:211:201:a80d:6f65:53d4:d1bf])
        by smtp.gmail.com with ESMTPSA id x17-20020aa793b1000000b006884549adc8sm10213146pff.29.2023.09.26.10.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 10:05:48 -0700 (PDT)
Message-ID: <d3c05064-a88b-4719-a390-6bf9ae01fba5@acm.org>
Date:   Tue, 26 Sep 2023 10:05:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org, rpearsonhpe@gmail.com,
        matsuda-daisuke@fujitsu.com, shinichiro.kawasaki@wdc.com,
        linux-scsi@vger.kernel.org, Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
References: <20230922163231.2237811-1-yanjun.zhu@intel.com>
 <169572143704.2702191.3921040309512111011.b4-ty@kernel.org>
 <20230926140656.GM1642130@unreal>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230926140656.GM1642130@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/26/23 07:06, Leon Romanovsky wrote:
> On Tue, Sep 26, 2023 at 12:43:57PM +0300, Leon Romanovsky wrote:
>>
>> On Fri, 22 Sep 2023 12:32:31 -0400, Zhu Yanjun wrote:
>>> This reverts commit 9b4b7c1f9f54120940e243251e2b1407767b3381.
>>>
>>> This commit replaces tasklet with workqueue. But this results
>>> in occasionally pocess hang at the blktests test case srp/002.
>>> After the discussion in the link[1], this commit is reverted.
>>>
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/1] Revert "RDMA/rxe: Add workqueue support for rxe tasks"
>>        https://git.kernel.org/rdma/rdma/c/e710c390a8f860
> 
> I applied this patch, but will delay it for some time with a hope that
> fix will arrive in the near future.

Thank you Leon. With this revert applied on top of the rdma for-next branch, I
don't see the KASAN complaint anymore that I reported yesterday. I think this
is more evidence that the KASAN complaint was caused by the RXE driver.

Bart.
