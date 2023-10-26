Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7A27D8AE1
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Oct 2023 23:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344764AbjJZVso (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 17:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344860AbjJZVsn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 17:48:43 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4548DDC
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 14:48:41 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ca72f8ff3aso11813895ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 14:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698356861; x=1698961661;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xBEXPJf7tMHYWl+JoHWXx5+TdN83WmNP3Ny+LhlpYdE=;
        b=S8fOm/U5SHNLIz4UQmV8aP1A5xkERyXZIM6CWyVc7iF5tOHBPSOxou0be87xauxdWH
         vretJvvFerfc2QF9lzF8wTR+kyxM3CYx5VNxAGpq3XaAVhVx+cMSSPxvL+L8q9+NIsCa
         tH7TnzSlEnhX2jO6lpN9m4U6iEutAe6ozZMLsFfjwDB4tiVvRHYAiKD7dDy8eM8+cLPP
         1ZiG2u88yBrrCk9wudPgKacmLEzfIrY0x3HMforOSrkjC+O7MBC3few6ahBhPSHXrkCD
         wSgzh6Q7wgBKrr90HkGszQEuiTz8Q2x8obFxTg+hoyrMD/MZeu3n+f3RumLLxk5iLlkF
         GB+w==
X-Gm-Message-State: AOJu0YyxepsvPfRTHDzUmzfowk72JYv80mxSSFBcP9HCz18bCnkWnnyR
        fFMWMbAPGbt+vgXRR7xnk8I=
X-Google-Smtp-Source: AGHT+IF8GlDjhCTAo6k0V9B8I2/TpcDh1zx2BqxOD4qndWr6SSeVauHOsxeoZFVLOALgAVKlR3UmTQ==
X-Received: by 2002:a17:902:ab1b:b0:1ca:b820:74ed with SMTP id ik27-20020a170902ab1b00b001cab82074edmr822407plb.14.1698356860630;
        Thu, 26 Oct 2023 14:47:40 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:de84:df0e:e310:eaf1? ([2620:15c:211:201:de84:df0e:e310:eaf1])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ea8400b001c9e4eb6676sm150008plb.192.2023.10.26.14.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 14:47:40 -0700 (PDT)
Message-ID: <fa4fab22-4d59-43f8-883c-d5a70a69a964@acm.org>
Date:   Thu, 26 Oct 2023 14:47:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with 64k
 page size
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
References: <20231013011803.70474-1-yanjun.zhu@intel.com>
 <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <a6e4efa6-0623-4afa-9b57-969aaf346081@fujitsu.com>
 <20231020140139.GF691768@ziepe.ca>
 <6c57cf0d-c7a7-4aac-9eb2-d8bb1d832232@fujitsu.com>
 <CAHj4cs86fFi+1LMMAzjcdGg1g1gbQwy6QgksC0kYVmNgghLV_w@mail.gmail.com>
 <1ffaeaa4-4ac2-4531-8e0c-586e13c14c97@fujitsu.com>
 <366da960-6036-49c5-ad47-3ae3f4e55452@fujitsu.com>
 <8f705223-6fde-4b29-880b-570349f40db8@fujitsu.com>
 <143f03b7-08ba-411c-a7ad-580141c06cfe@acm.org>
 <20231026134300.GV691768@ziepe.ca>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231026134300.GV691768@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/26/23 06:43, Jason Gunthorpe wrote:
> On Thu, Oct 26, 2023 at 06:28:37AM -0700, Bart Van Assche wrote:
>> If the rxe driver only supports mr.page_size == PAGE_SIZE, does this
>> mean that RXE_PAGE_SIZE_CAP should be changed from
>> 0xfffff000 into PAGE_SHIFT?
> 
> Yes

Bob, do you plan to convert the above change into a patch or do you
perhaps expect me to do that?

Thanks,

Bart.

