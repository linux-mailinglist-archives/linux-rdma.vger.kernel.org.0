Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE99D7D414A
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 23:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjJWU7k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Oct 2023 16:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJWU7k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Oct 2023 16:59:40 -0400
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF7F9D
        for <linux-rdma@vger.kernel.org>; Mon, 23 Oct 2023 13:59:38 -0700 (PDT)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-564b6276941so2964232a12.3
        for <linux-rdma@vger.kernel.org>; Mon, 23 Oct 2023 13:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698094778; x=1698699578;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGnWpvtqUI0UJUFwbqlImZnkJ/qsDB05bgKbbS/nCpE=;
        b=e5vhueTSNW2jS/h7x4LLBTCowC3pNnQBcJAx8nrWrj8qlCYmGhIoAx8Xe48D03aORA
         UncxR2HhTaXvG+QqZupJhY2a9PYTZFkCyjURL3wIuhqepLTLjcP5l1aziVvVmF39fi01
         GHBDKaQTbGQpWuJhJMJCRK57RpE0M17zWBB0PO0DyuN+cPpO6BUhKObMzkJkv27Wy8AB
         fnaiI6zxwQbGJSNU5/lu3yyyFR3ypMkrVRsOhJOV32qPVojYqXPoYYc2fsrPC5FY7rz3
         8/KsxEOylFK5ZB4GG+nMvH+5Q2yC4o0E9L+W/CRj4D08lC5JMDmx/iZh9+xPp3X6xb7E
         FwLQ==
X-Gm-Message-State: AOJu0YxFRgWjnVr6+lkA6i2HDHtbWoV7WwqA0DhyaJe/2gAWuLqeAqTF
        MOZBab9BHLMfJHFuA4kF9l+/ZGUTCYM=
X-Google-Smtp-Source: AGHT+IFts/CtXN0yjEknykyc6SEr9n8T+j4wlzHHCPzhSQ3uDCEZSzsQqGLKxQwO3+JxvnDoyD2OuQ==
X-Received: by 2002:a17:902:e88f:b0:1c7:23c9:a7db with SMTP id w15-20020a170902e88f00b001c723c9a7dbmr10831582plg.26.1698094777913;
        Mon, 23 Oct 2023 13:59:37 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:14f9:170e:9304:1c4e? ([2620:15c:211:201:14f9:170e:9304:1c4e])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b001b0358848b0sm6353690plr.161.2023.10.23.13.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 13:59:37 -0700 (PDT)
Message-ID: <f561804c-41c8-48af-ab2b-45f54bd117b6@acm.org>
Date:   Mon, 23 Oct 2023 13:59:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: srp/002 hang in blktests
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
References: <b549a186-9c80-47e7-a54c-cd64d8cae9b7@gmail.com>
 <06229821-6d93-4f74-95ef-af352f101b7f@acm.org>
 <3e2191b7-56de-4654-936e-46fbc5828122@gmail.com>
 <53ede78a-f73d-44cd-a555-f8ff36bd9c55@acm.org>
 <b4071c0b-aebe-4fdf-a788-442215e17d88@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b4071c0b-aebe-4fdf-a788-442215e17d88@gmail.com>
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

On 10/23/23 13:41, Bob Pearson wrote:
> On 10/23/23 15:21, Bart Van Assche wrote:
>> On 10/23/23 11:29, Bob Pearson wrote:
>>> Lots of work. Thanks!! Did you mean 6.6 instead of 6.5? I assume
>>> you are running an Ubuntu 23.10 VM and not bare metal while I am
>>> not.
>>
>> Yes, I meant 6.6 instead of 6.5. I'm indeed running Ubuntu 23.10 
>> inside a VM. BTW, the test is still running and has just reached 231 
>> iterations
>> ...
> 
> Very good news! Maybe we can let rxe out of the doghouse.

Is there perhaps a misunderstanding? I ran my tests with the soft-iWARP 
driver. Did you run your tests with the RXE driver?

Thanks,

Bart.

