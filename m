Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC877D4123
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 22:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjJWUll (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Oct 2023 16:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjJWUlk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Oct 2023 16:41:40 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F70D7C
        for <linux-rdma@vger.kernel.org>; Mon, 23 Oct 2023 13:41:38 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1dd1714b9b6so2692063fac.0
        for <linux-rdma@vger.kernel.org>; Mon, 23 Oct 2023 13:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698093698; x=1698698498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RAJBO02V2/gNYroD3iSZOWQrcldDR8SnsawoRe1zwIY=;
        b=hP9/WuG864F66wIO/RTuWRLRPlWBDg+ME/CSCwGqEQAQreVDygOD3niInlok4lx6jX
         m5CYuOyrmoyXV4muOFhvCWtvQjRhHGam5u+FoKEcYFILpmbf9QrYaLWRwORylsUtzvsn
         bs3oVfo2x3UvaooxZE3p9YFDYnYgPg35luod+PFe2pz4gI8vxVrfPK06QbrE7azkjw9C
         3j8ncg9xZppKnYGn29B/BpsYtV2j0WF4iuhNVDKbSSkbLdf5ySe970dQcxwY+PNUFDJS
         bExciDziSfrytsJR0FApbCcUh8pOXxeVD36JL60h3xx1vX8fBgcpn9akf5YQstiM5jbI
         cy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698093698; x=1698698498;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAJBO02V2/gNYroD3iSZOWQrcldDR8SnsawoRe1zwIY=;
        b=TFGklXutwqQzEqZv8yXltOCS2DVdr1AdwpxDJeZDNw04NvUXNqo8U9YUj/hpDhLktl
         4aR3hGSKViyd2XGWuB0WpKeC6xmez59qgA1+qYyuVMvsmnyz0In/6vcWdk7iSNbIh0qO
         sBgs3T7kLmjZmDAWXltwPOnUiIOPLmPxzCgd0CyO7E1RT2t/sggs6agyGNRb04SL3fin
         UQdLw4kyZNj8lagIHdaOzfwUa0wwDnQIJrnHGJTQLOIpk5dr1nzG4MhlqqmBfCth2mVH
         OlQqkeCkjkna2VhG1FvdkoFdMTtnYbvA1aNAPGAi0ZzWKIUsIibFRoXGXPVNsUwA0/j6
         8uEQ==
X-Gm-Message-State: AOJu0YwiM+hxhtVLSc6ow2SORTmQ6meF/1sGsAsUEiXQJ6kUWEjhA0jI
        n4wLRUxff03v2wQnSbM7aSi1Aax06AicBA==
X-Google-Smtp-Source: AGHT+IEP8IB1BCgAWzqhna+XwXfWIY45iE8fsg520hkwMmgmIxTCP5HF1GWUeWvG5ausZx5Y+Wy9+w==
X-Received: by 2002:a05:6870:9e90:b0:1e9:9c04:9ca4 with SMTP id pu16-20020a0568709e9000b001e99c049ca4mr14096759oab.41.1698093698143;
        Mon, 23 Oct 2023 13:41:38 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:2301:d8a4:1c8f:de7? (2603-8081-1405-679b-2301-d8a4-1c8f-0de7.res6.spectrum.com. [2603:8081:1405:679b:2301:d8a4:1c8f:de7])
        by smtp.gmail.com with ESMTPSA id ni8-20020a056871348800b001e96eba5abdsm1816533oac.26.2023.10.23.13.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 13:41:37 -0700 (PDT)
Message-ID: <b4071c0b-aebe-4fdf-a788-442215e17d88@gmail.com>
Date:   Mon, 23 Oct 2023 15:41:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: srp/002 hang in blktests
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
References: <b549a186-9c80-47e7-a54c-cd64d8cae9b7@gmail.com>
 <06229821-6d93-4f74-95ef-af352f101b7f@acm.org>
 <3e2191b7-56de-4654-936e-46fbc5828122@gmail.com>
 <53ede78a-f73d-44cd-a555-f8ff36bd9c55@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <53ede78a-f73d-44cd-a555-f8ff36bd9c55@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 10/23/23 15:21, Bart Van Assche wrote:
> 
> On 10/23/23 11:29, Bob Pearson wrote:
>> Lots of work. Thanks!! Did you mean 6.6 instead of 6.5? I assume
>> you are running an Ubuntu 23.10 VM and not bare metal while I am
>> not.
> 
> Yes, I meant 6.6 instead of 6.5. I'm indeed running Ubuntu 23.10 inside 
> a VM. BTW, the test is still running and has just reached 231 iterations
> ...

Very good news! Maybe we can let rxe out of the doghouse.

Bob
