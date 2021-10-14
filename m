Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D991242DF5D
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Oct 2021 18:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhJNQpq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Oct 2021 12:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbhJNQpq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Oct 2021 12:45:46 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB45CC061755
        for <linux-rdma@vger.kernel.org>; Thu, 14 Oct 2021 09:43:40 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so9074474otb.1
        for <linux-rdma@vger.kernel.org>; Thu, 14 Oct 2021 09:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ZoXRBu1KoAkoz4DAnGzN2/tSYWvjsTEoBtnwscWZ/Rw=;
        b=MY+37dNwZ9FLFiTf8HU8jJgN5DOIe9WG0MI+ldoeqf3VJV6lvnfBWb0/H5tETwFnaA
         wCpc+zM7lGryGZCA1rMYSrS7NhIyrllxQV2m7bmuzx9umHw4+AYhf3VBcidz8Zenp0Xp
         lYYzrRV4KC4Ccc2aKfcVFu8nMU7uJNxxU0yRiL4tIu6Bm8QVQX9f7JriARreqxvSdAsw
         5JP/lJdWqIG0nBPXAiHlyvmwy8N4rRxAUMgd6jFYLFurWe6u5G0lDx2hx386MtuTnAHG
         1H7MuBXROXilKNpPVxDjfVniKca2fppBR4oJ1qpe2SSy2Z06jY6rOnAGizl+c2DLD23u
         8YjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZoXRBu1KoAkoz4DAnGzN2/tSYWvjsTEoBtnwscWZ/Rw=;
        b=Rx/qZXK17XHeg25400mdC/ewqNCDFq8ZBgS+E/KF/On3aktGk8z6FuKZPg6xwsCuSN
         3WHsaMbRD7sKum+OoNW6PXUvG92qDQ73vOV5ctxAuxxEF7FF7mNAxSTQ56uUdHbXVAXx
         5JSmfdUGDUvepKF9b+QF+zWJP7AviP7JwVhjurhpsllvBeEImc63K/fUujdKzCAUKUUA
         8UCt6xaDXeP3VW4NOWA0SH4gmI+tlESWMrkOu3kQi8Ik6WpnUmtTIInyHqBwdG+mUIPE
         OnQp7ZaeYIewodqBvLqq2JNWIquot7jucxa+xEN07MIALqEUfaHknCAMnBSPstSSCUS3
         ZPDg==
X-Gm-Message-State: AOAM531m16mZDyemvAZ6sY/hfpXrfRynJm3/aSnANCVHX7cjHpmpIf+e
        o/t+SXWy9rsMVCpTuFIvckE49M8d0Lo=
X-Google-Smtp-Source: ABdhPJwTKRfGinExx7TB+2PJmh0laBtCGk5ld2XIS96mbbwYha1HLMgDStoHtM7aP0FdAhFPQC4cfA==
X-Received: by 2002:a9d:4b83:: with SMTP id k3mr3576722otf.294.1634229820180;
        Thu, 14 Oct 2021 09:43:40 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:487b:eaab:6345:1a9? (2603-8081-140c-1a00-487b-eaab-6345-01a9.res6.spectrum.com. [2603:8081:140c:1a00:487b:eaab:6345:1a9])
        by smtp.gmail.com with ESMTPSA id r4sm642264oti.27.2021.10.14.09.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 09:43:39 -0700 (PDT)
Subject: Re: Bad behavior by rdma-core ?
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <414e99de-9b1b-edcc-4547-f8002adecd69@gmail.com>
 <3bda5d0b-dc04-7640-b832-867858ef7a12@gmail.com>
Message-ID: <11f8d34c-5ad1-f6b3-18c8-c3edd906f171@gmail.com>
Date:   Thu, 14 Oct 2021 11:43:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3bda5d0b-dc04-7640-b832-867858ef7a12@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/14/21 11:14 AM, Bob Pearson wrote:
> On 10/14/21 9:57 AM, Bob Pearson wrote:
>> I have been chasing a bug in the rxe driver seen in the python tests (test_cq_events_ud).
>> The following occurs
>>
>> 	The first time I execute this test it creates two AHs which are allocated by
>> 	rdma-core and passed to rxe_create_ah. The test attempts to destroy them
>> 	(i.e. rxe_destroy_ah is called in the provider driver) but rdma-core does not
>> 	destroy them (i.e. rxe_destroy_ah is not called in the kernel).
>>
>> 	The rxe driver saves the AV state and some metadata for these AHs and keeps it
>> 	since it thinks they are still active.
>>
>> 	The second or third time I execute this test two new AHs are created by
>> 	rxe_create_ah but the memory passed in from rdma-core is the same as the first
>> 	test. I.e. it has recycled them but they are still active in the driver so
>> 	the result is chaos.
>>
>> Somehow rdma-core thinks it has destroyed the AHs but it does not call down to the
>> driver. This only occurs for AHs AFAIK.
>>
>> Bob 
>>
> 
> The cause seems simple enough.
> 
> In uverbs_cmd.c ib_uverbs_create_ah() calls rdma_create_user_ah() which
> eventually calls device->ops.create_user_ah() or device->ops.create_ah().
> 
> But ib_uverbs_destroy_ah does *not* call rdma_uverbs_destroy_ah() it just
should be                                  rdma_destroy_user_ah()
> deletes the object.
> 

