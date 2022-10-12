Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB9D5FC944
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Oct 2022 18:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJLQ24 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Oct 2022 12:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiJLQ2g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Oct 2022 12:28:36 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64318C90C1
        for <linux-rdma@vger.kernel.org>; Wed, 12 Oct 2022 09:28:35 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-132af5e5543so20019630fac.8
        for <linux-rdma@vger.kernel.org>; Wed, 12 Oct 2022 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NMRl9qhg3NK7A8OZLqXT8yUoZYEWjpFKewA84TmTlG0=;
        b=Md0dSDVfSolhfbdq/jD8xiR05uYFZXgOprULMubw/WjimhlfLlsEaDZ1frocBJsVyW
         xyt/No3S/ZyTn33+T+cPDokmObskf8BavXYNWcB8hlhwQ4WZsUZHE39RwhiT06xzMn93
         qgPt+0Qz997Q9XL5l9+AVCWIiie2r9zOKATzt/pcF4bgXUqgdRWbmedZYd+YmmBH3uv7
         0gDWMw+9KYk974YBa/914uJNqLcJ2WvK7n79HAz0LLqgPl2M1U27PLj60/zLZ9viDtcy
         d03Lb+8PJDhtP/+C8FjBwJMcDDboATdkuxVluzqkpE6LriPoKt8e1HR+Ixq4JrDZg4mC
         eIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NMRl9qhg3NK7A8OZLqXT8yUoZYEWjpFKewA84TmTlG0=;
        b=U+h8exA8/5xuKs/ff5cXzD4bTgcWhinoL8g7NCqObVkYDejD5awlAiBd4kM2KcEmmd
         8LicGoTuCA8TYzbNR7xBProdOQpEBldT/OJQXo0vVmBLtzTrFE7g8UKz6eORnlewsIIu
         KXxSR/tTaSh03DLNIOg5eacHgFfi7lhp6CxZl8XsUa5dCzch8urDLOJxVxajNbmI2pwF
         1sisUfJ4uGkN94Dj5b8WD0dlE8rPFc0xUO6669+EvTP+aubKnlTzvj7TzebFRoQQqhmT
         m9J0TwJ7sPsTAqq6VvC9ip304UkKytfaZr/j3SgktTt1moeFz7Ta0mvcfQC1mm7U5o4D
         26Sg==
X-Gm-Message-State: ACrzQf1NgvLzHmCPvtCmZz5QeUDOS+ds5BXuJX3tqUlzN3tjMU80dvzk
        6sDGIjQom2GmOGwhNkSHrik=
X-Google-Smtp-Source: AMsMyM6vnucq4x2NU28+Z0c9iQN81LeOS8mbmdDip08Rr8qx/RJZC0Av7DKvrCdZhLm55dBdNbjNvA==
X-Received: by 2002:a05:6870:f215:b0:12c:e0d8:8631 with SMTP id t21-20020a056870f21500b0012ce0d88631mr2974615oao.180.1665592114775;
        Wed, 12 Oct 2022 09:28:34 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:8ea3:cb1b:ceb1:d1a3? (2603-8081-140c-1a00-8ea3-cb1b-ceb1-d1a3.res6.spectrum.com. [2603:8081:140c:1a00:8ea3:cb1b:ceb1:d1a3])
        by smtp.gmail.com with ESMTPSA id c38-20020a05687047a600b0012779ba00fesm1417117oaq.2.2022.10.12.09.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 09:28:34 -0700 (PDT)
Message-ID: <ec131623-075c-f94f-3051-4a2c28cd5902@gmail.com>
Date:   Wed, 12 Oct 2022 11:28:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: RDMA/rxe: Receive wqe flush error completions on qp error
Content-Language: en-US
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
References: <3867f7a8-80ab-f3ee-e631-63756fefb82e@gmail.com>
 <BAF00661-DBC5-4B74-9BA7-FC17BBDEDC59@oracle.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <BAF00661-DBC5-4B74-9BA7-FC17BBDEDC59@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/12/22 11:26, Haakon Bugge wrote:
> 
> 
>> On 12 Oct 2022, at 18:17, Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> Currently the rxe driver flushes the send queue on a transition of the qp to the error state and completes these wqes with flush errors but does not do this for the receive queue. The IBA spec requires that this happens. Is there a reason why this wasn't done or does it just not come up in practice?
> 
> It does of course happen in practise using HW HCAs. The ULP or user-space process need to free the resources used by the recv WRs. And it does so by receiving the work-completions (which in this case is FLUSHED_IN_ERROR).
> 
> 
> Thxs, Håkon
> 

That is what I expected. I will try to fix this.

Bob
