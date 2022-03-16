Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0724DB4AC
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 16:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357248AbiCPPQM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Mar 2022 11:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357181AbiCPPPu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Mar 2022 11:15:50 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366536210D
        for <linux-rdma@vger.kernel.org>; Wed, 16 Mar 2022 08:14:08 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id i204so291783wma.5
        for <linux-rdma@vger.kernel.org>; Wed, 16 Mar 2022 08:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HtyDttG7u1nDcBHjdf9QxUujwSCKEsPwo/qmWSsABZ8=;
        b=KUjUhl8gQMd9UF0DZ1T0R9DJUQ4yH7upIqGxDDTqkwJ0jHiRjpkp6SF3ShAjwL7wVy
         GLsLRkBxjXNuGLdzfMlO/t7j0ZTtMBCpGRxsWAidgD5w4g5Omz1NXmOXalO7NBXn2M67
         hLgUcImj6KXxLXlWkhZt34SRB9JrVlnzm5OAGyQdl13XqlrlCh7zmrveeVhwoejH7Q5h
         WFMb0UKcJcTZhLtt1oPpCLbrD+Or6J1u23uzlfYf17/PU34D3uc4/59IJ1n1v5YO4KXu
         x3fXNse6l9mH29OXxPHwQ8wZJLMWYZ2KLIz2BJu2JkSAdIiaMH6CM6pQbG0B3mpeNgEj
         KiZQ==
X-Gm-Message-State: AOAM533K3IA+9MrzUbm0OkABQocq9nJoqqE1ckgl45YTaAJDWGKxGtB8
        XnMnS8Uk9RNHp6M0JGPpECw=
X-Google-Smtp-Source: ABdhPJx0uqCNhEtzg7LROpUd4yadA/aqG27vHreblglMW75/xZJnHjRRmMl/qasjCkqVW7HHLfwJ7A==
X-Received: by 2002:a05:600c:19c6:b0:38c:712d:f1c7 with SMTP id u6-20020a05600c19c600b0038c712df1c7mr142310wmq.126.1647443646815;
        Wed, 16 Mar 2022 08:14:06 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d11-20020a056000186b00b00203d45bfbc7sm2138642wri.7.2022.03.16.08.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 08:14:06 -0700 (PDT)
Message-ID: <f3e1200b-1375-0a5e-7b56-3c1565576cf5@grimberg.me>
Date:   Wed, 16 Mar 2022 17:14:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/4] IB/iser: fix error flow in case of registration
 failure
Content-Language: en-US
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
Cc:     oren@nvidia.com, sergeygo@nvidia.com, israelr@nvidia.com,
        leonro@nvidia.com
References: <20220308145546.8372-1-mgurtovoy@nvidia.com>
 <20220308145546.8372-5-mgurtovoy@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220308145546.8372-5-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> During READ/WRITE preparation, in case of failure in memory registration
> using iser_reg_mem_fastreg we must unmap previously mapped iser task.
> 
> Reviewed-by: Sergey Gorenko <sergeygo@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

Looks good,
Acked-by: Sagi Grimberg <sagi@grimberg.me>

Doesn't this need a fixes tag?
