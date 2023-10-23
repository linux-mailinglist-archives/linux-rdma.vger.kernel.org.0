Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10DC7D40CE
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 22:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjJWUVV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Oct 2023 16:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjJWUVU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Oct 2023 16:21:20 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF3FD78
        for <linux-rdma@vger.kernel.org>; Mon, 23 Oct 2023 13:21:17 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6be0277c05bso2866068b3a.0
        for <linux-rdma@vger.kernel.org>; Mon, 23 Oct 2023 13:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698092477; x=1698697277;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bxw3jzJwO9hmj28i0I0nXnjE0C5hyJJsgs7Un+Fj7Uk=;
        b=jYTDWRV2w/CsI04NEq++qt2aanwt6ONx+oOvZX89hhWZW+5wFAwPN3BBJ21XTofifh
         FOJdC7fBWMgMNN/qXsFmwi64M24Hx56pNDn4pP1fQdNMG/TKEWuMmyfiNL4WFSEdIyIU
         jhGVf6LONHM9h0WJQ6Yricumtt+Kj8+UosmlaC8hK3Z6fMQYQT9VCj6S+d9tu9ap/xqI
         GaU2UfjNY/uUONk0dYgIkApP3nMtzXAzEFkJVsLv0Kj0jBY7//R3PCt/9uAwBDmhcXsG
         SFlL2y+PJv1BfYDxb0tslee/F1K4DtG18WTQC47eQQvCefI2C2VKoNpr2ghxlHs6Zt1z
         cOBg==
X-Gm-Message-State: AOJu0YxAhNtl4T+L73KEKuBl4QLfSWgbWRm+RqxNrxh+SquQtvYON6w6
        I7msJuIazTaSfC75hAoJ05tzeR6LYr0=
X-Google-Smtp-Source: AGHT+IHYAdOUxBuZQ9f7cWZUrkjSgrb9IxU7LZOob59G6oogJU6Gxs5HKUjiHKbYWpqtkF5f8XxpCA==
X-Received: by 2002:a05:6a21:1a3:b0:16b:7602:15b1 with SMTP id le35-20020a056a2101a300b0016b760215b1mr792871pzb.12.1698092477303;
        Mon, 23 Oct 2023 13:21:17 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:14f9:170e:9304:1c4e? ([2620:15c:211:201:14f9:170e:9304:1c4e])
        by smtp.gmail.com with ESMTPSA id ay3-20020a17090b030300b00278f1512dd9sm7706295pjb.32.2023.10.23.13.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 13:21:16 -0700 (PDT)
Message-ID: <53ede78a-f73d-44cd-a555-f8ff36bd9c55@acm.org>
Date:   Mon, 23 Oct 2023 13:21:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: srp/002 hang in blktests
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
References: <b549a186-9c80-47e7-a54c-cd64d8cae9b7@gmail.com>
 <06229821-6d93-4f74-95ef-af352f101b7f@acm.org>
 <3e2191b7-56de-4654-936e-46fbc5828122@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <3e2191b7-56de-4654-936e-46fbc5828122@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 10/23/23 11:29, Bob Pearson wrote:
> Lots of work. Thanks!! Did you mean 6.6 instead of 6.5? I assume
> you are running an Ubuntu 23.10 VM and not bare metal while I am
> not.

Yes, I meant 6.6 instead of 6.5. I'm indeed running Ubuntu 23.10 inside 
a VM. BTW, the test is still running and has just reached 231 iterations
...

Thanks,

Bart.


