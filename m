Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC207D5860
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Oct 2023 18:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343880AbjJXQb1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Oct 2023 12:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343892AbjJXQb0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Oct 2023 12:31:26 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDC693
        for <linux-rdma@vger.kernel.org>; Tue, 24 Oct 2023 09:31:24 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1c9a1762b43so39162205ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 24 Oct 2023 09:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698165083; x=1698769883;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUSUTyAbuWT+P92768BKYcxPW5p/tEFYJboDQvLFMVM=;
        b=G5ZW//AFcvmUxvlnaZsmH+Qwjd6sL0mgyPLf57xbGVDTEjf4uswe3SzjS1peMC1ihX
         qYFvOgDy9eXNCIfF/0DpvODjJDdIh0he5vaQJVzihR3cTAR8t8TJaGkvWhQkrHsi7q8Y
         P3KtqTzdZq+87PAlz+WyanJD6RwjHugNjWKONdclMOWYhkNRG4mIcUcGPtRCfH8RcoBS
         MUtv175a6ix0N72/c8QVo0pWp4RA+ChUkQID41lkU8xBhAm4iBahn0sdcC7G+NcbJ1fh
         Kfrtv7IJoijdsVSaPoVYUPz8dzYCDQO3XrpAirsPSAUMPCmBuOXYxPtekGMiDUONIr1q
         YjhA==
X-Gm-Message-State: AOJu0Yy9Dld8FdlRTK/F4MSj6LXtpQ1rQzVqeXdlOzPffFwGIgLSOLEu
        9gBM/jOGrdH3w6jJECPmwryanWJUFwo=
X-Google-Smtp-Source: AGHT+IH+gsxhnytbIUb7uNx6wX85h6LUUXtucEuz3Q537spLaiCSTB15flc8nGEITX5o2Vtf1VH1QQ==
X-Received: by 2002:a17:902:d081:b0:1b8:a19e:a3d3 with SMTP id v1-20020a170902d08100b001b8a19ea3d3mr10559969plv.52.1698165083509;
        Tue, 24 Oct 2023 09:31:23 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:b089:b200:3b6d:bf8? ([2620:15c:211:201:b089:b200:3b6d:bf8])
        by smtp.gmail.com with ESMTPSA id g10-20020a1709026b4a00b001a80ad9c599sm7609277plt.294.2023.10.24.09.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 09:31:21 -0700 (PDT)
Message-ID: <119304fc-a61d-4567-8d23-edb69676fad5@acm.org>
Date:   Tue, 24 Oct 2023 09:31:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: srp/002 hang in blktests
Content-Language: en-US
From:   Bart Van Assche <bvanassche@acm.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
References: <b549a186-9c80-47e7-a54c-cd64d8cae9b7@gmail.com>
 <06229821-6d93-4f74-95ef-af352f101b7f@acm.org>
 <3e2191b7-56de-4654-936e-46fbc5828122@gmail.com>
 <53ede78a-f73d-44cd-a555-f8ff36bd9c55@acm.org>
 <b4071c0b-aebe-4fdf-a788-442215e17d88@gmail.com>
 <f561804c-41c8-48af-ab2b-45f54bd117b6@acm.org>
In-Reply-To: <f561804c-41c8-48af-ab2b-45f54bd117b6@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/23/23 13:59, Bart Van Assche wrote:
> On 10/23/23 13:41, Bob Pearson wrote:
>> On 10/23/23 15:21, Bart Van Assche wrote:
>>> On 10/23/23 11:29, Bob Pearson wrote:
>>>> Lots of work. Thanks!! Did you mean 6.6 instead of 6.5? I assume
>>>> you are running an Ubuntu 23.10 VM and not bare metal while I am
>>>> not.
>>>
>>> Yes, I meant 6.6 instead of 6.5. I'm indeed running Ubuntu 23.10 
>>> inside a VM. BTW, the test is still running and has just reached 231 
>>> iterations
>>> ...
>>
>> Very good news! Maybe we can let rxe out of the doghouse.
> 
> Is there perhaps a misunderstanding? I ran my tests with the soft-iWARP 
> driver. Did you run your tests with the RXE driver?

(replying to my own email)

With the RXE driver I see a hang after 143 iterations in the same VM
(Ubuntu 23.10 VM, v6.6-rc7 kernel with kernel debugging disabled). No
SRP paths are available so the hang is not caused by a multipathd bug:

# lsscsi
[0:0:0:0]    cd/dvd  QEMU     QEMU DVD-ROM     2.5+  /dev/sr0
[6:0:0:0]    disk    Linux    scsi_debug       0191  /dev/sda

I couldn't obtain more information because kernel debugging is disabled.
But it is suspicious that this hang happens with the RXE driver and not
with the soft-iWARP driver.

Bart.

