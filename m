Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906405BFF45
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Sep 2022 15:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiIUNyE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Sep 2022 09:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiIUNyD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Sep 2022 09:54:03 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC417F124
        for <linux-rdma@vger.kernel.org>; Wed, 21 Sep 2022 06:54:03 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id q35-20020a17090a752600b002038d8a68fbso10323491pjk.0
        for <linux-rdma@vger.kernel.org>; Wed, 21 Sep 2022 06:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3pBCm2JqPO7gQu2+G3Q2IBYmvQ9QFul6U2M8qt+vfKU=;
        b=KUaPXcBxDYkWhYB/YQSgkP0H0V+8n5yL+AAT5IVZYuh8OGBixXr/+B8jhR06XYz4Vk
         9NIafdU5K94A23ZqDn9tEGlkwXvuy2JPVlo1ge7vkhIg7KOPJ39wRguvwgVuU+68hGZ1
         fRASMDbJxI6jeKNg7Utm7fSHSU2HQYKi3oZdwAZ554xmJx7fUc2eVCGyNYxokuy8ChCy
         XOjtPQKDMN0D/VizwsfSvofWfxVwk+3CHJutHb5RsE1bRmg1AQKoR8/LiScfU26XzI2K
         r6o/kLWrGMEbxOAd/HGmY5ec1AHANHo20f+sDjHtdiO4A7vB6sLSQs9zRcLivbC8Rt1/
         G7OA==
X-Gm-Message-State: ACrzQf06gcDip7KGS2SGndbXG8jMLONAVuS9578RmrSvy4XOQorapAqP
        LebM96QExBVpaOlCmV6sKDZuxQyVg6A=
X-Google-Smtp-Source: AMsMyM7bondsr6FQgHPDZRtNPZ/fsWEfgJRnyQ9mFLUwYtuPPQn30SC0hjJz9qc8ihzvvShs6TRGxg==
X-Received: by 2002:a17:90b:164d:b0:202:69b3:1002 with SMTP id il13-20020a17090b164d00b0020269b31002mr9445164pjb.86.1663768442652;
        Wed, 21 Sep 2022 06:54:02 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id m24-20020a634c58000000b00439920bfcbdsm1875013pgl.46.2022.09.21.06.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 06:54:01 -0700 (PDT)
Message-ID: <5fd7c3b7-855c-13a7-6ff3-073b36508b09@acm.org>
Date:   Wed, 21 Sep 2022 06:54:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH rdma-next] RDMA/srp: Support more than 255 rdma ports
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mikhael Goikhman <migo@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Bloch <mbloch@nvidia.com>, Shay Drory <shayd@nvidia.com>
References: <7d80d8844f1abb3a54170b7259f0a02be38080a6.1663747327.git.leonro@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <7d80d8844f1abb3a54170b7259f0a02be38080a6.1663747327.git.leonro@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/21/22 01:03, Leon Romanovsky wrote:
> Currently ib_srp module does not support devices with more than 256
> ports. Switch from u8 to u32 to fix the problem.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
