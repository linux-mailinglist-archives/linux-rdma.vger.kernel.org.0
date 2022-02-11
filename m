Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117CB4B2DC3
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Feb 2022 20:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242047AbiBKTgK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Feb 2022 14:36:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbiBKTgK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Feb 2022 14:36:10 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A110BCF2
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 11:36:08 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id r15-20020a4ae5cf000000b002edba1d3349so11579744oov.3
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 11:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=curP1aZqFF+PSWieLU2NNBkGK3lte7rSB2Wz5GiDNb0=;
        b=HC5/6Xyyd5w4w0jbWihFU9mhL8D3ZhDZ8gHK5oZp2PAZIjsDR22xZShLIz1ewxd52m
         HO9ZVhT8iOebdaUI2fFXTV9A1rRuucI1AWtxEJYLnFUe/FF0AiDev8Wh05o+6N8p+y9w
         nZ9VJRvmCF8mIv8BCe3iQ61wq73mtOfPDDlsrHDavVv4iGtBcGdRugC7SCg2xkip6eip
         dzOs06PmHnIxbpvlJsxYLNYROYYJagLF7OzKRHm4dk538pEIMKU1NWrRT1sWHi6AGtcX
         8IOfEGbEWtt8Wrbw6fBkanEZmay50fGs52wXpjR6LkotfcJ/Cw41ejAH82Ln3jux3o5N
         jCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=curP1aZqFF+PSWieLU2NNBkGK3lte7rSB2Wz5GiDNb0=;
        b=ikGfp21r3hJ37cLEQQpZEhYu8OSKFhBdSjhekL9UC9vslVc8BWJ3IB4/YwtOCuhqiC
         HvwAaJsEMKXIuSePZCV63a1Yjf/kMazE3l2fs4vYDsOXUb8SjgeRNLT6E9gr7oBmxQq5
         F6LxMBMNQuymBHigEoan2xyBUkxfyGzFXgSsPsTfijeDHgHv8guNHcyK2g6YM23vL2eZ
         FCbNRTcfm/5LBJtSG4DEhEfLfVIrTxDwVm/mIF6L2awZ7qCU1RDNucmggQej1U9xWb2z
         /DxCaX9aFetMP4DIMyaMlZjh2aLIKwjSSBikGq5XnMtIfQGocPm/aVQV6v0cNqgCQSPD
         G3yA==
X-Gm-Message-State: AOAM5316uCFiVUczMP9QH2S6Zw93+BBKbi5uU5IYf9FkfVu2f6L7Rkw8
        q3Os8n48Qc/iCzUzi9E+9EggrB5IQlU=
X-Google-Smtp-Source: ABdhPJzc9Q5T7XopqPg3PW/2492880UXfJYcUTursnUCvw9/pBOtoKg82L1qcdX3uKK0/ZFiGNqEZA==
X-Received: by 2002:a05:6870:36c5:: with SMTP id u5mr662494oak.150.1644608168029;
        Fri, 11 Feb 2022 11:36:08 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:4354:ebed:9b2:4ca2? (2603-8081-140c-1a00-4354-ebed-09b2-4ca2.res6.spectrum.com. [2603:8081:140c:1a00:4354:ebed:9b2:4ca2])
        by smtp.gmail.com with ESMTPSA id n66sm9745260oif.35.2022.02.11.11.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 11:36:07 -0800 (PST)
Message-ID: <a34545c4-dd47-2613-e08a-cfbc3ce0d32c@gmail.com>
Date:   Fri, 11 Feb 2022 13:36:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH for-next v11 08/11] RDMA/rxe: Add code to cleanup mcast
 memory
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220208211644.123457-1-rpearsonhpe@gmail.com>
 <20220208211644.123457-9-rpearsonhpe@gmail.com>
 <20220211184301.GA576950@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220211184301.GA576950@nvidia.com>
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

On 2/11/22 12:43, Jason Gunthorpe wrote:
> On Tue, Feb 08, 2022 at 03:16:42PM -0600, Bob Pearson wrote:
>> Well behaved applications will free all memory allocated by multicast
>> but programs which do not clean up properly can leave behind allocated
>> memory when the rxe driver is unloaded. This patch walks the red-black
>> tree holding multicast group elements and then walks the list of attached
>> qp's freeing the mca's and finally the mcg's.
> 
> How does this happen? the ib core ensures that all uobjects are
> destroyed, so if something is still in the rb tree here it means that
> an earlier uobject destruction leaked it
> 
> Jason

The mc_grp and mc_elem objects are not rdma-core uobjects. So their memory
is allocated by the rxe driver. They get created by ib_attach_mcast and destroyed
by ib_detach_mcast. If an application crashes without calling a matching
ib_detach_mcast for each attachment the driver would have leaked the memory.
This patch fixes that.

Bob
