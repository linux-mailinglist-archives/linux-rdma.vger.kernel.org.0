Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1854F8936
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 00:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiDGVIa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Apr 2022 17:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiDGVI0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Apr 2022 17:08:26 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BCE179B35
        for <linux-rdma@vger.kernel.org>; Thu,  7 Apr 2022 14:06:25 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-dacc470e03so7750019fac.5
        for <linux-rdma@vger.kernel.org>; Thu, 07 Apr 2022 14:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dd5DRgc2EveXnvcDaW4LW50OX9zjWgwetBfurWWlPEA=;
        b=XaeIO9bBDCIGqIVNvpgOBtFRGkEtBrgHa9jSzvB/qKoPxbMyAUxTtczBuUhBjO5r1F
         4oxlmNiOpLedWos/nrt45ULE99686QdHXadg27B+JG4KCsDOEM/EPs0XMjFTdHbcbQCY
         iCv+M8loL2ZFRvTozX0dKpaCH+v1N1PV4MQMRluxCekGltrtcDxthF/gNJab3hYl3eyl
         1/5hEN8aG42B6Amy/w9nIAUZZQaW0KOqzCGrXgX4zT57IRZqxwUZMXcwQ5+f8EGJCrN+
         4Z1NZgy1t6ZDfBd/qOVDUmYAAg6vhq8XM3F4LkZvKGX5xGRcaduW5Wwtk7vi2VuOOlzK
         +KGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dd5DRgc2EveXnvcDaW4LW50OX9zjWgwetBfurWWlPEA=;
        b=XEJ3JreLX7oF+cmJQ+PmS+aolJ5h582wmsyLz2W+CQjvBWhtm1jhuFBHQSdS5CTUTO
         ONy7NQsZVJWrCLFL8IIxOlH6V6/RFtNpwCcpV70an/a9i99O1vaS+GlK1Q3Km3Hf+MGP
         5azHctr0GhzoV/mZ7xjDM6VpBnk1g+7Kukdok49s/DMLm/0GA00z4MpLxvm1ybeTBxNf
         J92SYgGZj+DGJ2xIacYGmEPwHb7a/phR898TbJ3hR+biX6Z0Vc9uEg63RX4mA1+x39lW
         XH1Z62d1xlSm3nPjG0DwGaV6O2Rgi88Sse8s7eFYqWcUXhqogpRbBQQqNtacBjvcM65v
         epig==
X-Gm-Message-State: AOAM532v9L//tbpO9wyvMMNViBJ4ty2NZ7BSxEbwc6DPl1O0naALjisM
        gUGlOO7dvryTFFNZNTWySRs=
X-Google-Smtp-Source: ABdhPJy2+KaeZ09XI2GHipJtqbuAveYy5T9W8CzlQO3tXArTeCsjTJ92YAZezxM0vxiUJID7GNhaPA==
X-Received: by 2002:a05:6871:822:b0:e2:10ff:b84e with SMTP id q34-20020a056871082200b000e210ffb84emr6984799oap.103.1649365584756;
        Thu, 07 Apr 2022 14:06:24 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:203d:1c92:96e5:569a? (2603-8081-140c-1a00-203d-1c92-96e5-569a.res6.spectrum.com. [2603:8081:140c:1a00:203d:1c92:96e5:569a])
        by smtp.gmail.com with ESMTPSA id bc35-20020a05682016a300b00324e9bf46adsm1749032oob.41.2022.04.07.14.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 14:06:24 -0700 (PDT)
Message-ID: <ca8722e6-db2d-0ab1-b8af-0932017df23e@gmail.com>
Date:   Thu, 7 Apr 2022 16:06:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [bug report] rdma_rxe: WARNING: inconsistent lock state,
 inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>
References: <CAHj4cs-MT13RiEsWXUAcX_H5jEtjsebuZgSeUcfptNVuELgjYQ@mail.gmail.com>
 <1c16f053-0183-8343-9b36-62027c7260a8@acm.org>
 <CAFc_bgZ5oYtK2doybVT5fhrU+Ut-RfPT+g2z1bbf9V3jTtRTUg@mail.gmail.com>
 <d80141c8-04ee-e6ed-34d8-5cf43b49fd55@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <d80141c8-04ee-e6ed-34d8-5cf43b49fd55@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/7/22 14:49, Bart Van Assche wrote:
> On 4/7/22 12:15, Robert Pearson wrote:
>> I would say it is very possible. There was a period when the pool
>> locks were switched to _bh spinlocks but that was later reversed back
>> to _irqsave locks which cleaned up some failures.
>> I don't know which version Yi Zhang was using. The root cause of this
>> bug was caused by
>> librdmacm making verbs API calls while holding _irqsave locks which I
>> didn't figure out until later.
> 
> Hi Bob,
> 
> I can reproduce the issue Yi reported with kernel v5.18-rc1. Please let me know if you need any additional information to reproduce this issue.
> 
> Thanks,
> 
> Bart.

From your note I can't figure out what you are running. Can you give me more details about the failing test case?

Bob
