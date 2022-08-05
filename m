Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8620658AF25
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Aug 2022 19:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbiHERsi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Aug 2022 13:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241030AbiHERsf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Aug 2022 13:48:35 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018837644D
        for <linux-rdma@vger.kernel.org>; Fri,  5 Aug 2022 10:48:34 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id h188so3363995oia.13
        for <linux-rdma@vger.kernel.org>; Fri, 05 Aug 2022 10:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=m2ROGEIOivYD/IId/yqZDbBx2A5cEFLsy4G4EN/b2L8=;
        b=pp+2VkM7f8SrNvY0jtAeuetOYJ0rwEf+cmlXbFcxmtPs15aXHOrfMlC4+qBJYWs/+k
         4kDLYo4cSsatkKp7nvFi7cuY8k90Imj3Rx7PzwJrRoRv1gojnzi3eIgqfh7KIClRUN4I
         WboQWuNiJcDGjeiORr7wVrPuNZ6Grz/H2R8dZhUpchZQWNqnhFgey13+GDbDiuriAt11
         V7Xq8BULvj7thCTfJiUcIRp/DuxmFQCQRYPn7dLkirNlfOQE1oNPZpl1pqydCKwkqMSN
         6kh0oem48Mz/K6U0sAj2PegMiGEnIkNW86vxPbFS9WZl2fX3hOeYBtHcmd/JABKiZVMk
         OWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=m2ROGEIOivYD/IId/yqZDbBx2A5cEFLsy4G4EN/b2L8=;
        b=g/Zdv/n+IyTPERHHUu4wT6pozrXQZty6vyBbC8p8B795MDSyEmoQtorCFtMDwJ1x6M
         cb2WVXQaRR5BS2lqbkmZORER7qx87QSJyNAqBKpf0Zg23xyURQ0AinkiLPL3wy8HUWq6
         WAs+7hxvG0u11DJooHM+Mx7ix+VtAeMu8tvYKBeRhXWEuSnw2+mC6at2zMO9OdJqBsdZ
         01QDfaQ7RZPaeRiXZ8zRKTSmT9fFLwjWpI+fFw+aq0CHjCKRL8skMkBMFg5CnTGquWNp
         jnT4IQ1WqMAO0CllVOeEcKI3T9oOWrpecOfRxKlY03kLH5tLo1vo4Hkjo6YlA5DWdFx+
         gwWg==
X-Gm-Message-State: ACgBeo21nGeYkFk3ask4o623vV22yGrYCNiBJwJSKMhIDd2CwTFNhShR
        hqBE+MgdjLR8BeqMAOVezsg=
X-Google-Smtp-Source: AA6agR7HVX2+hJ55WFnq2Em+hlTypGpbLsijRT+hIpr9eoVQbv7Id4L4+9lrzQA9w6/Zm5PC9vRVcg==
X-Received: by 2002:a05:6808:148e:b0:33a:9bd2:7f17 with SMTP id e14-20020a056808148e00b0033a9bd27f17mr6932917oiw.123.1659721713338;
        Fri, 05 Aug 2022 10:48:33 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:bd0a:ecc8:60c4:4ecc? (2603-8081-140c-1a00-bd0a-ecc8-60c4-4ecc.res6.spectrum.com. [2603:8081:140c:1a00:bd0a:ecc8:60c4:4ecc])
        by smtp.gmail.com with ESMTPSA id bb20-20020a056820161400b00435954f91ddsm794356oob.28.2022.08.05.10.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 10:48:32 -0700 (PDT)
Message-ID: <cf1c298c-11bb-e072-8f5e-ff4aad4963c2@gmail.com>
Date:   Fri, 5 Aug 2022 12:48:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 for-next] RDMA/rxe: Fix error paths in MR alloc
 routines
Content-Language: en-US
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jhack@hpe.com" <jhack@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20220804043731.3737-1-rpearsonhpe@gmail.com>
 <5db7d9d6-5c7a-90f6-4848-4e348a0630af@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <5db7d9d6-5c7a-90f6-4848-4e348a0630af@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/5/22 02:08, lizhijian@fujitsu.com wrote:
> Bob
> 
> It does fix the panic.
> 
> TBH i'm not a big fan with you patches style, you didn't make the smallest patch.
> You made a lots of extra cleanups and coding style fixes which is good to me in logical
> but it make patches massive. that would take people more attention to have a review.
> 
> I'd like a smallest fix + extra cleanup if needed, the decision is up to the maintainers :)
> 
> 
> 
Li,

OK. I'll split it up. I'm ambivalent on goto's. Some days I like them and some I don't. No logical reason.
In this particular case I was concerned with making absolutely sure that the cleanups balanced out.
So I touched all that code in passing. Now that it works. I can reduce the change.

Bob
