Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC57B7D5962
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Oct 2023 19:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbjJXRGK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Oct 2023 13:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343970AbjJXRGI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Oct 2023 13:06:08 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7395310E6
        for <linux-rdma@vger.kernel.org>; Tue, 24 Oct 2023 10:06:02 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6ce327458a6so2401974a34.1
        for <linux-rdma@vger.kernel.org>; Tue, 24 Oct 2023 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698167161; x=1698771961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ixIFJNzNxM/SU9QgAXO8brOR+1FmxuxnfimAWZmkI4Q=;
        b=jKa+U2jVYyl6PBLB0SFYWtkfyY7/NWnfrlAjbC8jFhtQYwv5s3azOsgTGPqDJwna1M
         YFuoQC4t9AriPUwiKs4Y7rDBgG8zjzUYmgofSs7rd9Fh+ZMPVAnUNfhtCjcv7O1BZzrW
         Ltx4dFGMrXdlWHEwLoROKi6tQCPwhiA/YVdoA/PFZbTdKxvE5IVGbRTTQmtw94F/8IzU
         L/vN20eGoSJB4ybOBrSfby/p+DiyqGd+OJVOI+Hb3OK5XVeR3JrAFuf0jwamBoOjUui4
         FGXyv3+sXE5dOsrQtOTPcPumrd3889dx5ueXz+oMU2TTJPxJsCNty9mMkdurbW1izeSM
         uoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698167161; x=1698771961;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ixIFJNzNxM/SU9QgAXO8brOR+1FmxuxnfimAWZmkI4Q=;
        b=bDx96FJA1jlGoq+EKk0SCGTUkd2CvccdAKvhNg891tPf/doIMYyrNxu/XsDNaCdia9
         FgqcOE33mpha/IvlDNcFgPHc7SLGeW1DUJ+Yf6p6NT4pHqgWQC7FZB0jpHsF3T2COvJr
         ooLJBt5cGtvVPk9oYD058QT6Kj66lT9BVXCyhzMHLNUq3jQB7Aqp59A74uZ+4A4+lq5p
         ltdaTR6gl6drp8FYwaRHAF9WYu9ef+FEWMR0T59+FRA1NVv+wzuL6gBv6ro/Bht/7c5G
         BYcv2bJk5eYl7jKtgtaV9J9k5rRVORHx/yFCQV+Tnz+qubLH5vn8kpsZesahU4FKQOY1
         mMnA==
X-Gm-Message-State: AOJu0YyEDTqn/vXRZo0fQo/OwObRfTh5oPXikwccJ2XZ2jXDq7qVXOXd
        0NzELfMLII1VWUy1DXn+Ezk=
X-Google-Smtp-Source: AGHT+IEBfQ67p9KEhBwc9u+6E46phVebo01ED8USkVQQrya+zJkU2+8r5vrYVDvbOiMfkQ79YF+tRg==
X-Received: by 2002:a05:6830:4104:b0:6b7:564d:f368 with SMTP id w4-20020a056830410400b006b7564df368mr8157483ott.5.1698167161606;
        Tue, 24 Oct 2023 10:06:01 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:2301:d8a4:1c8f:de7? (2603-8081-1405-679b-2301-d8a4-1c8f-0de7.res6.spectrum.com. [2603:8081:1405:679b:2301:d8a4:1c8f:de7])
        by smtp.gmail.com with ESMTPSA id d13-20020a056830138d00b006b89dafb721sm1912311otq.78.2023.10.24.10.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 10:06:01 -0700 (PDT)
Message-ID: <b7d14c57-9d3c-46c6-adb1-a3d892b9a634@gmail.com>
Date:   Tue, 24 Oct 2023 12:05:59 -0500
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
 <b4071c0b-aebe-4fdf-a788-442215e17d88@gmail.com>
 <f561804c-41c8-48af-ab2b-45f54bd117b6@acm.org>
 <119304fc-a61d-4567-8d23-edb69676fad5@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <119304fc-a61d-4567-8d23-edb69676fad5@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 10/24/23 11:31, Bart Van Assche wrote:
> On 10/23/23 13:59, Bart Van Assche wrote:
>> On 10/23/23 13:41, Bob Pearson wrote:
>>> On 10/23/23 15:21, Bart Van Assche wrote:
>>>> On 10/23/23 11:29, Bob Pearson wrote:
>>>>> Lots of work. Thanks!! Did you mean 6.6 instead of 6.5? I assume
>>>>> you are running an Ubuntu 23.10 VM and not bare metal while I am
>>>>> not.
>>>>
>>>> Yes, I meant 6.6 instead of 6.5. I'm indeed running Ubuntu 23.10 
>>>> inside a VM. BTW, the test is still running and has just reached 231 
>>>> iterations
>>>> ...
>>>
>>> Very good news! Maybe we can let rxe out of the doghouse.
>>
>> Is there perhaps a misunderstanding? I ran my tests with the 
>> soft-iWARP driver. Did you run your tests with the RXE driver?
> 
> (replying to my own email)
> 
> With the RXE driver I see a hang after 143 iterations in the same VM
> (Ubuntu 23.10 VM, v6.6-rc7 kernel with kernel debugging disabled). No
> SRP paths are available so the hang is not caused by a multipathd bug:
> 
> # lsscsi
> [0:0:0:0]    cd/dvd  QEMU     QEMU DVD-ROM     2.5+  /dev/sr0
> [6:0:0:0]    disk    Linux    scsi_debug       0191  /dev/sda
> 
> I couldn't obtain more information because kernel debugging is disabled.
> But it is suspicious that this hang happens with the RXE driver and not
> with the soft-iWARP driver.
> 
> Bart.
> 

Bart,

Very interesting. But, 143 is a new record for rxe. Your siw results are
consistent with what I saw. I only saw siw hangs with the debug kernel.

Bob
