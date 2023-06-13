Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F23C72E8E0
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jun 2023 18:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjFMQ4v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jun 2023 12:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbjFMQyu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Jun 2023 12:54:50 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C61D19B1
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 09:54:48 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b2bdca0884so3934876a34.2
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 09:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686675287; x=1689267287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sZORTh8xIPRA1aMXp8e4PNhbcXb5NKORexcYHkJET00=;
        b=I4Mb48KGJSqorUBSUM71iFEYuz2W/WV0KHCj8RVGBFWOZt4D+wnF9P0DzVF5EqS9Fl
         yTYJi22j8hR58zmEBVrUxhxC/Ww2/Ro/dXCwbIGOzpXZ8G2VbNwkgkmUhRG9T4yLCkPR
         16vpA7XvTORCDMNinRFAgzh5Jywd0w7/c5E5EzYHV4s7GU/j0PaTBYHSNDOgFwkW5gW7
         3OD5S6/vTfFDl61b6h4gNPvD96S9b//i7L3hquTJo3qteEtCpttsH9wlewszfgyIWh5U
         XupB9xt491xGotdVF/TiR/Jq1tAkO4xt/U8mH6e7dAopWnYDZ/d6Gt4rs0Jb/GdToyQk
         q4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686675287; x=1689267287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sZORTh8xIPRA1aMXp8e4PNhbcXb5NKORexcYHkJET00=;
        b=JxVb8TjcCcFiHFu+/MkZUHl1fcpL4hnOqwnF5M1cf6RhfuepTQ9H840nIWhK0VQPpp
         qiqqpDF5pp9CUbDq9+sfQifuTUQRyr8YpdmQvmR1sLPjLoSoBrTBTFLK500oKap5nchI
         OogIpCdjszSeLZWLuoixNqyAcfcdA8CZeUB1Lf9BgedHay60A2IcOfEeY9JRh3lNOtHu
         kB22uNT4A/gQhFXRGfT6mQNOjg7pO1DszmPo5x95qCo5zcggYaSCvasz5qci1JlCP40N
         Ija/GUfeAaSh3qUvTPd4ZjiZgVTqOPs/4oLD0uoIa/2rAqTT/mnfSnNkz+Yr9NVf3PRo
         AD9A==
X-Gm-Message-State: AC+VfDwnkK12LmBL1tQ2iQNlm67VjvNevvB+5waUpivw1BlaZ2/ClLPl
        9wlOAZdejRklVHS/UwZvGWN3KGe/Bw0=
X-Google-Smtp-Source: ACHHUZ7Mgx+cK8LxI0Vl4WChtaesXY/tMKxqistlutlX4lK7Gi4hvlzhLkNvmid+ligLS9FCrRouig==
X-Received: by 2002:a05:6830:3a0a:b0:6a6:6121:dc60 with SMTP id di10-20020a0568303a0a00b006a66121dc60mr9386438otb.10.1686675287327;
        Tue, 13 Jun 2023 09:54:47 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:b626:4062:16bc:9b1? (2603-8081-140c-1a00-b626-4062-16bc-09b1.res6.spectrum.com. [2603:8081:140c:1a00:b626:4062:16bc:9b1])
        by smtp.gmail.com with ESMTPSA id b5-20020a056830104500b006b169acf1b5sm4954514otp.63.2023.06.13.09.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 09:54:46 -0700 (PDT)
Message-ID: <2c854bc5-40c4-aea7-c220-981938a01b6e@gmail.com>
Date:   Tue, 13 Jun 2023 11:54:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Bug report in reg_user_mr in exe
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <80328b20-9c5d-afe8-0ff4-a7eb05c8fb4f@gmail.com>
 <ZIieuVnhnGP8RGQw@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <ZIieuVnhnGP8RGQw@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/13/23 11:52, Jason Gunthorpe wrote:
> On Tue, Jun 13, 2023 at 11:26:55AM -0500, Bob Pearson wrote:
>> Jason,
>>
>> Recently the code in rxe_reg_user_mr was changed to check if the driver supported the
>> access flags. Since the rxe driver does nothing about relaxed ordering. I assumed that the
>> driver didn't support that option but it turns out that this breaks the perf tests which
>> request relaxed ordering by default.
> 
> Sounds like rxe is checking the flags wrong, there is a set of
> optional access flags that should be ignored by the driver.
> 
> Jason

OK. That's easy. I'm just embarrassed I broke ib_send_bw.
So mask off the optional ones and check the rest?

Bob
