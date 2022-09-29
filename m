Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AB25EF9AB
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Sep 2022 18:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbiI2QAH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Sep 2022 12:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbiI2QAC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Sep 2022 12:00:02 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92D137F89
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 08:59:59 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-131ea99262dso25979fac.9
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 08:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=tTF4PxW2wz2nF6Ze1z70ZfcYNSdjW3o/JhtLdvRkw0o=;
        b=AHb5Jlj7C1MttPe9y+ZJ0+NnrLD5jXipWet/ER1FL6HPdfVq+d57/K3+cqyA3yzLQ7
         qgk20/SrWE0CfgSkI6k5/9N8bMYzLrMKS3hFya9V9qih+yxIDDrEbBPO2bKW+gSSm+2V
         chaQmqm2iJuYrhiAG7YX4DkamUZYTep9liWs6AWb5vXCQ+JceU287xpbnU+krtdXm5tB
         LE7ATutYI/YGgJXSlqP2o5QyFd3ojLFL46BqcA+zrb//EGAdzbGzikOKHHjTO1nJ8xdP
         AtpnWeoaxcIh+yjl0AywWboZU619+0gj4aJxftS1FRtmaDy4j6JYztbhzv/qAtb0Uy/b
         OncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tTF4PxW2wz2nF6Ze1z70ZfcYNSdjW3o/JhtLdvRkw0o=;
        b=wfTPCvYQaHol7PSi+lvfBWprbGbqzIRidEs31IhsqQl/7KKgS7+ZKa1xu/u1Nfyrz/
         +BTNI8tjcd1hfAwW3F8nytx20PJ/S/lwgkRUL+VUCb4VkwI43hAKUfmEJ0Z1D3gdnH8M
         Lzvyh4/SNrgzvb0BSe4C1d4zqZXThR/qEII4Lr2FB2eXDiUXnhCCQszgVUvk1j8eZFWB
         f2kOmYfg0X6h26Mv7RsfhbO5gnLLCE6LsUe83UWCLeQKEJymZeE8a7o8c5GAQ9FplZ7f
         sxBA0xSzvRWa5VRNKvBygcVx2sUhcpKIExHsayJoidxbabmauqQ3aXNVo1x8LLJjxMad
         bWbQ==
X-Gm-Message-State: ACrzQf35zP5lGGRSYEebG4oFgSBBbzlbrEt0HtOImKsSVpcrEKU9Yseq
        v4BXIFbY0Xc3hZp/Nfn2lsU=
X-Google-Smtp-Source: AMsMyM4fG7q7kv/gIor2sUzG4rJ+9YuUETe6tlh6hlCLv3FahKCxGuTFMbuWPv4c7kv6b5FKftDjtA==
X-Received: by 2002:a05:6870:b14f:b0:127:d4f1:6a90 with SMTP id a15-20020a056870b14f00b00127d4f16a90mr2221405oal.116.1664467198174;
        Thu, 29 Sep 2022 08:59:58 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:6c9b:432a:3a95:bcf1? (2603-8081-140c-1a00-6c9b-432a-3a95-bcf1.res6.spectrum.com. [2603:8081:140c:1a00:6c9b:432a:3a95:bcf1])
        by smtp.gmail.com with ESMTPSA id er30-20020a056870c89e00b0012b298699dbsm37674oab.1.2022.09.29.08.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 08:59:57 -0700 (PDT)
Message-ID: <ca551719-a05f-1883-35f5-a36791eb96d0@gmail.com>
Date:   Thu, 29 Sep 2022 10:59:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH for-next 00/13] Implement the xrc transport
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
References: <20220917031104.21222-1-rpearsonhpe@gmail.com>
 <YzIyHsRUy4gNeJL8@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <YzIyHsRUy4gNeJL8@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/26/22 18:13, Jason Gunthorpe wrote:
> On Fri, Sep 16, 2022 at 10:10:51PM -0500, Bob Pearson wrote:
>> This patch series implements the xrc transport for the rdma_rxe driver.
>> It is based on the current for-next branch of rdma-linux.
>> The first two patches in the series do some cleanup which is helpful
>> for this effort. The remaining patches implement the xrc functionality.
>> There is a matching patch set for the user space rxe provider driver.
>> The communications between these is accomplished without making an
>> ABI change by taking advantage of the space freed up by a recent
>> patch called "Remove redundant num_sge fields" which is a reprequisite
>> for this patch series.
>>
>> The two patch sets have been tested with the pyverbs regression test
>> suite with and without each set installed. This series enables 5 of
>> the 6 xrc test cases in pyverbs. The ODP case does is currently skipped
>> but should work once the ODP patch series is accepted.
> 
> The ODP patch isn't even on patchworks any more, so it needs
> resending. I can't remember why it needed respin now.
> 
> I'm inclined to apply this without really looking closely at the rxe
> code. If someone has other ideas please chime in. It looks like it
> needs rebasing, yes?

I will do that today and resend if it needs to change.

Bob
> 
> Jason

