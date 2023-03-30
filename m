Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257146D074F
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 15:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjC3NwA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 09:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjC3Nv7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 09:51:59 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233C45598
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 06:51:55 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so8175156wmq.3
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 06:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680184313; x=1682776313;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=dx+C2QiGXfNqHR7M1cuV5zjunaU96hGhvjBl3bER+U1xOQDbetM/jF7kj5XKawmLD1
         HA71Ur1bf+TVjngyqn46d9d67dz2gDABVueV3a8SL9XdIo2dwpP0Q8HrEHq7IYfAKRrh
         xMMe4U1W4XbDraKEO40ySXzzkrUcPvAz7qmq9Z7bFv2IhiZcjoSoOAxjEiGVPktWtjm2
         DiAapTK7kz3/Mtyi03rlF4PSb1dji+x9fJayRxiAuWNMsm3yMiVID5y93Mkot4mTrCZd
         44cZJUpDD0XtxRqX0cHoeJ4hMH8tMKnfTl1JNPmHzAx3H1HklOrEEpavaHmlWTUPS1Yg
         AljA==
X-Gm-Message-State: AAQBX9eafRdhD4jLUJq4S2Jyo/oQ29Sir/fEX2LO11/QYaJaMSPTFEQx
        QjLLhlJNRXdz3Mnay4maM+M=
X-Google-Smtp-Source: AKy350Y/IlypsBm7tsBXwT/rNGGpVX1QsdnpnymCT01grApKSTONb1djLyZjom0qOp9v2x4s4dtRYQ==
X-Received: by 2002:a05:600c:1d13:b0:3e8:7ca3:8424 with SMTP id l19-20020a05600c1d1300b003e87ca38424mr1987468wms.1.1680184313541;
        Thu, 30 Mar 2023 06:51:53 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id p5-20020a1c7405000000b003eb596cbc54sm5969551wmc.0.2023.03.30.06.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 06:51:53 -0700 (PDT)
Message-ID: <82ed8b38-c659-05d5-b140-0323747f7f36@grimberg.me>
Date:   Thu, 30 Mar 2023 16:51:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/3] IB/iser: remove unused macros
Content-Language: en-US
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, leonro@nvidia.com,
        linux-rdma@vger.kernel.org, jgg@nvidia.com
Cc:     israelr@nvidia.com, oren@nvidia.com, sergeygo@nvidia.com
References: <20230330131333.37900-1-mgurtovoy@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230330131333.37900-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
