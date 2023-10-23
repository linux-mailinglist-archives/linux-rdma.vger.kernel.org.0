Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B7B7D3EF3
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 20:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjJWSSS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Oct 2023 14:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbjJWSSL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Oct 2023 14:18:11 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD03D8E
        for <linux-rdma@vger.kernel.org>; Mon, 23 Oct 2023 11:18:09 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6bee11456baso2777895b3a.1
        for <linux-rdma@vger.kernel.org>; Mon, 23 Oct 2023 11:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698085089; x=1698689889;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5yA1VrtkEFLjoX+BPtsqCfLCbiPhncsCTQbrxfk0mG0=;
        b=n3u7CmREoZhjauvBdXy2F+fM1H+3qWeixxvgWI3duN5VTYFKp9DeLgHVCL5yXTWuCk
         nsa/UGaFX9ZdXXVTB2+mcrjOyopWPGTZnnd0hyGIhKU0UdHIbq5fH7KOataHMHoDBX/v
         eJqA10Vwag33wR2aOzUD3a2NBdLpoJBnUXDGk2lUQ5xaZggiTH2AY819RFHcmJF1JnVH
         qIbdMlPeFOwmBM7/ozUg/KZgdfU+boAfBTklerDBJY1NgCFqHUOAbO9pnav3opQ8lpP5
         CDoa8FvLje7bWBwjSxTHNz7xt62nKHS0av2Dg1Qcis4Ldn+lcxtmuCvCo9P1pbiKLUIb
         RCWA==
X-Gm-Message-State: AOJu0YyL+AaWBZiDuOkGPkHNdRk26yPlXfXsaw7Bve7gGE21qTZkFe9V
        5X2VQNK42qkzanTtc7lZGgE=
X-Google-Smtp-Source: AGHT+IFXLCCNPCDI8Ngs1iCIkCL0NaoKBt10O9zxiovFtG/sUnJXBFP/e5pPJE6jUzG+TaYN2SkL7Q==
X-Received: by 2002:a05:6a20:1606:b0:17b:62ae:a8aa with SMTP id l6-20020a056a20160600b0017b62aea8aamr473883pzj.6.1698085088852;
        Mon, 23 Oct 2023 11:18:08 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:14f9:170e:9304:1c4e? ([2620:15c:211:201:14f9:170e:9304:1c4e])
        by smtp.gmail.com with ESMTPSA id d6-20020aa797a6000000b006b225011ee5sm6414999pfq.6.2023.10.23.11.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 11:18:07 -0700 (PDT)
Message-ID: <06229821-6d93-4f74-95ef-af352f101b7f@acm.org>
Date:   Mon, 23 Oct 2023 11:18:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: srp/002 hang in blktests
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>, linux-rdma@vger.kernel.org
References: <b549a186-9c80-47e7-a54c-cd64d8cae9b7@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b549a186-9c80-47e7-a54c-cd64d8cae9b7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 10/20/23 15:48, Bob Pearson wrote:
> Latest efforts. I completely reinstalled my machine. New Ubuntu 23.10 
> including multipath-tools-0.9.4-5ubuntu3, new rdma-linux git clone, new 
> blktests clone, etc. (Lost lots of Thunderbird state.) Ran srp/002 a few 
> times. It still hung on the third try. The dmsetup hack you sent still 
> un-hangs the stuck run.

Hi Bob,

Thanks for the detailed report. I installed Ubuntu 23.10 server into a
new VM and also all packages that are needed to build the kernel and run
blktests. This is how I ran the srp/002 test:

# (cd .../blktests && i=0 && while true; do ((i++)); echo ==== $i; 
./check srp/002; done)

With kernel v6.5-rc7, 40 iterations ran fine without triggering any
hang. I haven't found any kernel commits between v6.5-rc3 and v6.5-rc7
that could explain a behavior change for the SRP tests so I'm not sure
why we are seeing different results on our test setups ...

Thanks,

Bart.
