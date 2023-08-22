Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59DB784544
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 17:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbjHVPUU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 11:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbjHVPUT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 11:20:19 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E081BE;
        Tue, 22 Aug 2023 08:20:17 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1bc8a2f71eeso29462605ad.0;
        Tue, 22 Aug 2023 08:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692717617; x=1693322417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5P9BwwYkA33/B2ZcfvbxAaA6ffyt2wVBdKLXgh3t5MU=;
        b=XY+Sbr4tKnhRgdZWTops/Uvsy0KggbGec+8f+smgIK+d5kwmZ2gPojFfQAqPWn67AE
         I3yk1rw66ITK9ln6xXEus8vAKd7BEowVCJmZ0Mn1iedVOeakROJOwLW8p274pf15xzGa
         rZCDNhI8Ph4kHo8xohNCPf1hePh9NAf86sWhhq6b9bF6wrjNf/UL4RAGEuJSqLM+oYuz
         OMGJkbf0L7u8LnHNwfWZrQrv0cSzjaYbqwXjRQlJ+WuryRPb5e5XhHQB5L1z4Y5O5NcN
         7jeTIuP8Uk/PoyBfjO2Hu9OjjoUQrdSN2SbTGnU9ZRaJF7IBcwD5XMWKC2Be0+iIWqpO
         Gjjg==
X-Gm-Message-State: AOJu0Yw/XIZyO51CBlPV7XFHvb5eeRmiSjqkl6Kc4ovN/asGlH6aJ0TS
        a0Zo6aWi5ppIwSg5UnVQiFGdxoKxTB8=
X-Google-Smtp-Source: AGHT+IGUw08fbRcL3y3OqZMC573hu/fdt0/l4uMGCv/vpbZXKPt1EskD+nixO9LpaBNoEFmR3HPwcw==
X-Received: by 2002:a17:902:76c1:b0:1bd:be34:cf5e with SMTP id j1-20020a17090276c100b001bdbe34cf5emr7249577plt.10.1692717616741;
        Tue, 22 Aug 2023 08:20:16 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:88be:bf57:de29:7cc? ([2620:15c:211:201:88be:bf57:de29:7cc])
        by smtp.gmail.com with ESMTPSA id c15-20020a170903234f00b001b9be3b94d3sm9187017plh.140.2023.08.22.08.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 08:20:16 -0700 (PDT)
Message-ID: <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
Date:   Tue, 22 Aug 2023 08:20:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com>
 <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/22/23 03:18, Shinichiro Kawasaki wrote:
> CC+: Bart,
> 
> On Aug 21, 2023 / 20:46, Bob Pearson wrote:
> [...]
>> Shinichiro,
> 
> Hello Bob, thanks for the response.
> 
>>
>> I have been aware for a long time that there is a problem with blktests/srp. I see hangs in
>> 002 and 011 fairly often.
> 
> I repeated the test case srp/011, and observed it hangs. This hang at srp/011
> also can be recreated in stable manner. I reverted the commit 9b4b7c1f9f54
> then observed the srp/011 hang disappeared. So, I guess these two hangs have
> same root cause.
> 
>> I have not been able to figure out the root cause but suspect that
>> there is a timing issue in the srp drivers which cannot handle the slowness of the software
>> RoCE implemtation. If you can give me any clues about what you are seeing I am happy to help
>> try to figure this out.
> 
> Thanks for sharing your thoughts. I myself do not have srp driver knowledge, and
> not sure what clue I should provide. If you have any idea of the action I can
> take, please let me know.

Hi Shinichiro and Bob,

When I initially developed the SRP tests these were working reliably in
combination with the rdma_rxe driver. Since 2017 I frequently see issues when
running the SRP tests on top of the rdma_rxe driver, issues that I do not see
if I run the SRP tests on top of the soft-iWARP driver (siw). How about
changing the default for the SRP tests from rdma_rxe to siw and to let the
RDMA community resolve the rdma_rxe issues?

Thanks,

Bart.

