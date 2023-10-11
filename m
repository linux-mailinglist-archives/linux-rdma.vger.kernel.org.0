Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A887C5E1B
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Oct 2023 22:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjJKUOV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Oct 2023 16:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjJKUOU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Oct 2023 16:14:20 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B67C9E;
        Wed, 11 Oct 2023 13:14:19 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-57bca5b9b0aso130393eaf.3;
        Wed, 11 Oct 2023 13:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697055258; x=1697660058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UyrDKbQbQXjK5vQijZ8YmBb/LLkPFwbG1s6YyJYCsU4=;
        b=ThPZmb8Y6bbwUyhWfV2168Df39yOh5Gd878zDzVXBcaz9e7LHYBMMiDnDcdMRFp+N2
         mhlokFaUvOU/73ulBg7aIcH6GjSILeL+D5VAZdBboYqmYl19RCiMgu5bB0oTiCbQ7njc
         wyccO5L1QhXrLKKLc5lM+g+Lu0Px9B8ds1bgg77mTVGO05jS2M+j7sGeIFsEAxemnMwq
         wnMvNd4VuYhR0FkyM9jwnc1LwalX29XBLyszAx2xOm+HhmxfE5xdOYvuDHhOmiKRpJhh
         S/+2jKF3zBA9BnQqRhsRjvj2PLs/kOWlYBZvSJOkBIuI+3I1lCpSfxMyOqVeUDu+bLjR
         EEwA==
X-Gm-Message-State: AOJu0YwQwltMNtk3XVUv/ZR7YTPe/gOD9aoVfMYroFalF11XZQjiQQXt
        COS/O3kyaD/X8ttn4GzOTBo=
X-Google-Smtp-Source: AGHT+IF+/54bkfGA6p2kLavPUsjZOJSTA4L5c3OacQSDXhxltp2wxOy6CaL1OHWFnt9YlpQt33obDg==
X-Received: by 2002:a05:6358:880e:b0:143:8e40:917b with SMTP id hv14-20020a056358880e00b001438e40917bmr24041025rwb.9.1697055258483;
        Wed, 11 Oct 2023 13:14:18 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:19de:6b54:16fe:c022? ([2620:15c:211:201:19de:6b54:16fe:c022])
        by smtp.gmail.com with ESMTPSA id t28-20020aa7939c000000b0068a46cd4120sm10470937pfe.199.2023.10.11.13.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 13:14:18 -0700 (PDT)
Message-ID: <70191324-018e-4cfe-9c1d-0bd3d17fb437@acm.org>
Date:   Wed, 11 Oct 2023 13:14:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>, Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Zhu Yanjun' <yanjun.zhu@linux.dev>,
        Leon Romanovsky <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Zhu Yanjun <yanjun.zhu@intel.com>
References: <2fcef3c8-808e-8e6a-b23d-9f1b3f98c1f9@linux.dev>
 <552f2342-e800-43bc-b859-d73297ce940f@acm.org>
 <20231004183824.GQ13795@ziepe.ca>
 <c0665377-d2be-e4b6-3d25-727ef303d26e@linux.dev>
 <20231005142148.GA970053@ziepe.ca>
 <6a730dad-9d81-46d9-8adc-764d00745b01@acm.org>
 <a8453889-3f5f-49ff-89f2-ec0ef929d915@linux.dev>
 <OS3PR01MB9865F9BEB1A90DDCAEEBFC8BE5CDA@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <20231010160919.GC55194@ziepe.ca>
 <a4808fa6-5bd5-4a64-a437-6a7e89ca7e9f@acm.org>
 <20231011155104.GF55194@ziepe.ca>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231011155104.GF55194@ziepe.ca>
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

On 10/11/23 08:51, Jason Gunthorpe wrote:
> If we revert it then rxe will probably just stop development
> entirely. Daisuke's ODP work will be blocked and if Bob was able to
> fix it he would have done so already. Which mean's Bobs ongoing work
> is lost too.

If Daisuke's work depends on the RXE changes then Daisuke may decide
to help with the RXE changes.

Introducing regressions while refactoring code is not acceptable.

I don't have enough spare time to help with the RXE driver.

Thanks,

Bart.

