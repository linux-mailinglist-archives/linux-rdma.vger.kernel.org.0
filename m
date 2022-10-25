Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B6F60CEC0
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Oct 2022 16:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbiJYORM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Oct 2022 10:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiJYORK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Oct 2022 10:17:10 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7771BBEDC
        for <linux-rdma@vger.kernel.org>; Tue, 25 Oct 2022 07:16:14 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-13b23e29e36so14975167fac.8
        for <linux-rdma@vger.kernel.org>; Tue, 25 Oct 2022 07:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I5wXH9B+8/6By8VpWNUxLUv/cRivdANtBJL0tx32rFk=;
        b=ZIt4ual8K27MHimH6EUbNV+GUPyI97PCdN6dEmUVRsAzm12AZnNxHzEbdiI0Ha59wM
         /UwZpe4v2kmYDL2j+VwLCOi0SOR6QI0vhauN7pLFedPUz98ueVtm8PO4HbTkqmAeYC9/
         +Z8FmP9n1RqM8MWItyxYmibuUnZV0/hys0LsgPsM7Zgd4WuvNZmJ3Ig+gAyr32iDAXUY
         xzqUMILAA/0GreIDps4wcYxbCMglZPWPN9Idyjlo2Nn1iSllzIyCesNOlWo7uG8nDc5A
         kq/3wC7OPMqT7T+xa0U3e5E29eOhWFAIGkohRVjZRQPvdKJhaxzYgjHbWs/65EhBIjnT
         /u2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5wXH9B+8/6By8VpWNUxLUv/cRivdANtBJL0tx32rFk=;
        b=B7yH8vKj2XGow6H79f1wKhwIyGbbjzPjMEHrDoP+2e3vHRBaUqYWl/VAD3zNUWDhdf
         twu5psxYvZsAFQP4yWrO4XCXCd9m1Ndhd83LHajdP+5GT/GTH/xZyRVw8eA2hpwWVgzD
         tT9ZYSTH6JLU0/8HIRCYdxoO+i83F8SJFZjVSCcrx0BgUGO1HykqmcFuCAVdQ+sWN5+C
         NaH3n5olh4ymYfVxENnftgcb+IYGaCs7tE1Y0JRL3bdA5+yeYhCV1jnJqxoT1S2PykpU
         dGIxtlfpP1x2yYu67eCYSWcdiCt+2AnFlIJ+r55so/hR4AbQlDhZANoBIe14lC0WKIG/
         P1oA==
X-Gm-Message-State: ACrzQf1q+LtUt2QyTWyjyWn8tya+h93cI5p5zJWy9Rsmn6twukg2rCcb
        6UQA9cnvVN9secFzS4BcA4w=
X-Google-Smtp-Source: AMsMyM7YXWcVg4h5N4Hg0Fmbys17/r4l1BcJH+tttqDBwZZihyqjkVfI2qRDbTEizet8f0gMrQDSNA==
X-Received: by 2002:a05:6870:61d5:b0:13b:f4f1:5c1a with SMTP id b21-20020a05687061d500b0013bf4f15c1amr1337930oah.153.1666707373873;
        Tue, 25 Oct 2022 07:16:13 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:5979:2555:99aa:7129? (2603-8081-140c-1a00-5979-2555-99aa-7129.res6.spectrum.com. [2603:8081:140c:1a00:5979:2555:99aa:7129])
        by smtp.gmail.com with ESMTPSA id l6-20020a4acf06000000b0044df311eee1sm1151998oos.33.2022.10.25.07.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 07:16:13 -0700 (PDT)
Message-ID: <3b3a8404-fcce-b8d3-bdfa-5867f0674fcd@gmail.com>
Date:   Tue, 25 Oct 2022 09:16:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH for-next v2 07/18] RDMA/rxe: Make task interface pluggable
Content-Language: en-US
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "jhack@hpe.com" <jhack@hpe.com>,
        "ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "haris.phnx@gmail.com" <haris.phnx@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20221021200118.2163-1-rpearsonhpe@gmail.com>
 <20221021200118.2163-8-rpearsonhpe@gmail.com>
 <TYCPR01MB845555580019B2DFF6A969F6E5319@TYCPR01MB8455.jpnprd01.prod.outlook.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <TYCPR01MB845555580019B2DFF6A969F6E5319@TYCPR01MB8455.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/25/22 03:02, Daisuke Matsuda (Fujitsu) wrote:
> On Sat, Oct 22, 2022 5:01 AM Bob Pearson wrote:
>>
>> Make the internal interface to the task operations pluggable and
>> add a new 'inline' type.
> 
> I do not see why we need the new 'inline' type. It may be technically
> possible to add it, but is there any situation where it is useful?
> With the new mode, It will take longer for softirq (NET_RX_SOFTIRQ)
> to complete its work, and that can cause a negative effect on the system
> as a whole.
> 
The one and only place where it makes sense in production is for the completer
task for UD QPs. In the original rxe code it was called inline from the requester.
Later that sort of got blurred and sometimes it was called inline and sometimes as
a tasklet. For benchmarking and testing it is useful to have other options to
check. In my world, HPC, storage use cases are typically all consuming when active
and we will try anything to see what gives the best performance and not worry too
much about the effect on other jobs. I am also interested in trying threaded interrupts
which are described as another alternative to tasklets.

Bob
