Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6D3602740
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 10:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiJRIlX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 04:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJRIlV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 04:41:21 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3812D1F9
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 01:41:21 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id r13so22282264wrj.11
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 01:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=2VziE37P1bqHO+tU+d49NMcwaeMt0GWBZRdXvBHwlNdQqnxrqRR1M4tlYgrB3q0/xB
         1E/knvwMTimr6irxkwcih7qtqrxFar9bbG8L3xLFtShDS9P78eMF7I37jw8xldWrWHOv
         Ok1qwqi0tvHVAlJ92DzfLm6LHzo+viyJn+PiZMZPK4S9XH/eHm3mChDA1BQL4uWWvTRP
         Wp2hanf79odCas3yqblHcUtAcjYIzjg48YyNpbcgQHW8S/jasBWEABiUliCy7Jdqgi/8
         YcIuRrpnOMobPV9fbbJCMhYLe9IBlxAiPPNRPhA7d9QZBkbGQyAgZ3KS09nGvOYlSPJW
         pdUA==
X-Gm-Message-State: ACrzQf0BeN87FYdm9nDG68qy42p5Jko/LIrb9BwH9S39LApV6JNQ/fdp
        jMHxRqs729N96pmY05chviIuWu/2A1Q=
X-Google-Smtp-Source: AMsMyM4X4UXVSGaN1iWrMUOp8X0WJczJXgvB9wC4O46ECaQ47f7yHz4oEyFD3PiQ7W1CgY3Ypxce+g==
X-Received: by 2002:a5d:5988:0:b0:22e:5a65:1e21 with SMTP id n8-20020a5d5988000000b0022e5a651e21mr1153210wri.338.1666082479607;
        Tue, 18 Oct 2022 01:41:19 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l17-20020a5d6691000000b0022cce7689d3sm12445135wru.36.2022.10.18.01.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 01:41:19 -0700 (PDT)
Message-ID: <53f284d3-0b97-0554-9f64-65e93f73c0c7@grimberg.me>
Date:   Tue, 18 Oct 2022 11:41:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/3] IB/iser: add safety checks for state_mutex lock
Content-Language: en-US
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, jgg@nvidia.com,
        linux-rdma@vger.kernel.org
Cc:     sergeygo@nvidia.com, leonro@nvidia.com
References: <20221016093833.12537-1-mgurtovoy@nvidia.com>
 <20221016093833.12537-3-mgurtovoy@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221016093833.12537-3-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
