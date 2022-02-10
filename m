Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E464B120B
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Feb 2022 16:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbiBJPtx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Feb 2022 10:49:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243757AbiBJPtx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Feb 2022 10:49:53 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E24BBAF
        for <linux-rdma@vger.kernel.org>; Thu, 10 Feb 2022 07:49:53 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id d18-20020a9d51d2000000b005a09728a8c2so4087550oth.3
        for <linux-rdma@vger.kernel.org>; Thu, 10 Feb 2022 07:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WVkwfPNwg7xGaw1L9J03iZpsTdqxGmaiOrI0W3JdsPM=;
        b=XX9l2w5JUlgKIaugClVjh2gxxlkyqThr6eQoAfncCmmj5YGDfGXLoAFWuBk+qCk/fo
         7QrdPd9gi8bQIx0gAulq3JNAn1heX1vyJz2fHLfjI96FPU7MRxzConvTOphI9UrpKF//
         DVbPpBrpyvL6OQBrhNbIci9zv056j0XwzNsum4OJYw6AcA1twRMQnxaxY0SMlkBXJvA0
         cASdBPvup49hWKXlzRQkxgj8aTVFX6/vkFIXtcuW5RNOBBKfyW2QBqp1khXhghR/s66V
         U/ddZIe6Xj5Q5DITofE7tcGm8TSux0NzIIrfp4Jtv/EKvT3koaJU9ae+5KOjmTaMyMsF
         cAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WVkwfPNwg7xGaw1L9J03iZpsTdqxGmaiOrI0W3JdsPM=;
        b=pcdTUwu/PeLiwUZjbxIlAbdbZw3bZwexxp6wTz35UR+10qWuSQsHBpcYITeVeZmxIM
         dTBBTtCTigyJTVejBghD+vJtt+Oe0YIMdD/3lBvAiz38lkIVoKBWFkhsZKprjJromsiw
         GAqoNPo4ANYDxkoM/7pi7zttZwvzkRyi5frhpv6lRVxf4x2gFJlSELIGfgR/6MkyAmCj
         ZzYmaEMHITDnB7B8VWyNL8NWG05yzsbxzy9gM+wMhKdS2nXkVwg/NgHaNrw4G5ouQK4R
         5+q78+rdNYgX+3teY2QznanJihPxGC6xNMJ/T7nMSyuD6H+i24MX/C6F1wesmhb/EYZH
         hUDQ==
X-Gm-Message-State: AOAM5304iEGLdrxon/j+zs8VkaZIi82lBo5SA4WNcMNceb8ZMIMgpMZw
        N3hMSt5iZ/7A+sADxoEidXoCQSEj03Q=
X-Google-Smtp-Source: ABdhPJyRspV9pIXPRKS0XnNJ5a23YSx9OVo3/HMiEnDfL46dUNakmPsPCxrWt3letPidW/G3eY/iiw==
X-Received: by 2002:a05:6830:4420:: with SMTP id q32mr3107878otv.24.1644508191019;
        Thu, 10 Feb 2022 07:49:51 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:a322:3674:4a4a:9441? (2603-8081-140c-1a00-a322-3674-4a4a-9441.res6.spectrum.com. [2603:8081:140c:1a00:a322:3674:4a4a:9441])
        by smtp.gmail.com with ESMTPSA id eh38sm3760747oab.36.2022.02.10.07.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 07:49:50 -0800 (PST)
Message-ID: <cd90c0e1-0327-4f0b-1b38-489fd18cf9d5@gmail.com>
Date:   Thu, 10 Feb 2022 09:49:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] RDMA/rxe: Replace write_lock_bh with
 write_lock_irqsave in __rxe_drop_index
Content-Language: en-US
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20220210073655.42281-1-guoqing.jiang@linux.dev>
 <20220210073655.42281-3-guoqing.jiang@linux.dev>
 <CAD=hENd6GiLggA5L9p_jQk9MA4ckh3vNB=EKXZ6BZxKrgNCoAg@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CAD=hENd6GiLggA5L9p_jQk9MA4ckh3vNB=EKXZ6BZxKrgNCoAg@mail.gmail.com>
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

On 2/10/22 08:16, Zhu Yanjun wrote:
> On Thu, Feb 10, 2022 at 3:37 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>>
>> Same as __rxe_add_index, the lock need to be fully IRQ safe, otherwise
>> below calltrace appears.
>>
I had the impression that NAPI ran on a soft IRQ and the rxe tasklets are also on soft IRQs. So at least in theory spin_lock_bh() should be sufficient. Can someone explain where the hard interrupt is coming from that we need to protect. There are other race conditions in current rxe that may also be the cause of this. I am trying to get a patch series accepted to deal with those.

Bob
