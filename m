Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0EE5753BC
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jul 2022 19:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiGNRFw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jul 2022 13:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240426AbiGNRFs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jul 2022 13:05:48 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A9366AE8
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 10:05:43 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id n12-20020a9d64cc000000b00616ebd87fc4so1616356otl.7
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 10:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uXrJbc7in3m1THWV7Am6vClx+ChTicOsEKsPNGhcq0E=;
        b=Dtb7wqPzxKrJrgcP2PSeBwwR3LxAmfTml6bpaau5bYtWw1OpZSfRAfq8q+YxknwUMV
         WDBSM1sGmUZunSsXWTNhpotDM5KGwg08pWZcIZeLtpa12b8kcE3RWoCnxoIurZlGLlvO
         9dw0rqBBCx7g1Y30pLp8M4Yl34vqjkmwkLMWis8Z7vjrDMB6K2NvL9YU0hYu8kozBO1U
         gM6nwOWZ0+gdverhYy50xzVOSztS+SxFElk5wKLJO/NqUuvVfwyCAARurPfwg3ZAXKle
         t+grB9q+enWf/XIw+E+8+pa+H454pPTt+ekCdAd1lZcRNkF9O5jIqPEf/+Cs/m382nCF
         xLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uXrJbc7in3m1THWV7Am6vClx+ChTicOsEKsPNGhcq0E=;
        b=fs1ZxR6VjYrrVbV22jeuhEbuTJzvcNHidt7YwJzttalU8huMJ2+umbQDOnIRIASqh5
         RFcRQEwVZxS9Q3y56d1yQHRPyXeSNI+vh6OZ3C4Q1DmS5LT8lcniNhY12O0o181G8CSh
         PSmMDL9NsPgDZYxo/XoFm5MuRzpREl5VDWrz0wUgNOyKlhLxAt+1AGqAspLfJCpgMc8Q
         ymDK4G3fL40uKWSSou4W1KPazSowadl/RkcVaam1DTdPi0qMMtXiiH9PlJWXwQ+XdzzQ
         2hwsljJgt79VE2XB2CLvbBn0E6xMnkINowG/AbOqIWjiHQw9XOH5f2ik2wUkgl1pzjVH
         iQhQ==
X-Gm-Message-State: AJIora/rT9YNv5Lr+4Ze7qRJ/JrNfoz47pL3AhrDwsnqU8FP5cEbZkYL
        uEzrkZ+2c/V2OOVpTFOW9oU=
X-Google-Smtp-Source: AGRyM1sASPjuwvoSrgRDKSIkq455GWT91Ja8iZsjmhxr3NyFQRNvo+/WMOjuKZNunylJf85MCwTDTQ==
X-Received: by 2002:a9d:2941:0:b0:61c:7216:e3ee with SMTP id d59-20020a9d2941000000b0061c7216e3eemr3008332otb.280.1657818342933;
        Thu, 14 Jul 2022 10:05:42 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:e02a:9936:8f26:4598? (2603-8081-140c-1a00-e02a-9936-8f26-4598.res6.spectrum.com. [2603:8081:140c:1a00:e02a:9936:8f26:4598])
        by smtp.gmail.com with ESMTPSA id v23-20020acaac17000000b00338461861b4sm823824oie.28.2022.07.14.10.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 10:05:41 -0700 (PDT)
Message-ID: <c9221de5-805e-1a2f-5084-dbbe785bf80d@gmail.com>
Date:   Thu, 14 Jul 2022 12:05:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] RDMA/rxe: Rename rxe_atomic_reply to atomic_reply
Content-Language: en-US
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "Pearson, Robert B" <robert.pearson2@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     "leon@kernel.org" <leon@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
References: <20220705114603.6768-1-yangx.jy@fujitsu.com>
 <20220705114603.6768-2-yangx.jy@fujitsu.com>
 <MW4PR84MB23075C8A422D7C87C5F0C4B7BC809@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
 <1e81e77d-f5d4-3f23-49fc-9e147dd68d46@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <1e81e77d-f5d4-3f23-49fc-9e147dd68d46@fujitsu.com>
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

On 7/6/22 07:14, yangx.jy@fujitsu.com wrote:
> On 2022/7/6 15:38, Pearson, Robert B wrote:
>> Generally over time I have been adding a rxe_ prefix to all searchable names static or non static.
>> This avoids collisions with similar names in other drivers with e.g. ctags. I agree a unified naming
>> Scheme is good but would like to see one with a common prefix for subroutine names.
> Hi Bob,
> 
> I think it's hard to use unique name in all drivers. I saw that all 
> functions called by different qp states don't use the rxe_ prefix in 
> rxe_responders so just remove the rxe_ prefix. We can drop the patch if 
> you don't agree with this change.
> 
> Best Regards,
> Xiao Yang

I fought on your side of this argument with Zhu a while back but now I am completely on his side.
Linux has a lot of lines and generic subroutine names will very often collide all over the place.
The better answer is to add rxe_ not remove it. It's not super critical so I have been doing it as
a background task whenever I touch a piece of code. If you get the urge to make things more consistent
feel free to do that but by adding a prefix and not deleting it.

Bob
