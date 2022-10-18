Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077E260273D
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 10:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJRIlO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 04:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiJRIlN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 04:41:13 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DF3F580
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 01:41:12 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id w18so22297659wro.7
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 01:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=uMSXr50NQEEnurFhu7YDJBTfDKIr6P51TV+cgYDgsF6RAwFZbhq95gZ/CdP3S8hC/t
         IdihCefZ8NcACxOAE5HModvU87YCKRnqopgJ6wfBgRZZOBOy1kqqebUTJKXGXqcH3Eng
         MzanM3NRb+0B0pSzXgG3pQFyz+nDA1Lk5jT/mKjH4Zrimv4kmb23wGXM2com1to1mPvD
         hB7nVq5gAvqz/VUnPufaO+7wuzPGfOm9sYBb3HKnvTfO4e8MDbw4hiHHTN8l3/cfHkI8
         Bm/WFF2EyyAm061RcjtbqIYBFRqZjQTqDjbMgzXH3tpSkaqjHfQ1AAJSxOOXLHabiiUC
         NeKg==
X-Gm-Message-State: ACrzQf1dPc3Gx10ygoTM0Yxs2/A8XFzAYsDXgCZEjrBqdqWWA4cb7fLd
        /2FDr3hIvQWAbwUuIcqZ7QM=
X-Google-Smtp-Source: AMsMyM4xIjovFc4cD9GbzMztOUfI5PGwrzcn4Co8tRi1urH0n7vt1B+Pgru64Cgdm9X4utbpYhNZ+g==
X-Received: by 2002:a05:6000:1102:b0:22e:529:a43d with SMTP id z2-20020a056000110200b0022e0529a43dmr1139806wrw.412.1666082470706;
        Tue, 18 Oct 2022 01:41:10 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o36-20020a05600c512400b003c6edc05159sm10830495wms.1.2022.10.18.01.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 01:41:10 -0700 (PDT)
Message-ID: <494212b4-fb1e-5d24-eba4-f5e988e0dac3@grimberg.me>
Date:   Tue, 18 Oct 2022 11:41:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/3] IB/iser: open code iser_conn_state_comp_exch
Content-Language: en-US
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, jgg@nvidia.com,
        linux-rdma@vger.kernel.org
Cc:     sergeygo@nvidia.com, leonro@nvidia.com
References: <20221016093833.12537-1-mgurtovoy@nvidia.com>
 <20221016093833.12537-2-mgurtovoy@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221016093833.12537-2-mgurtovoy@nvidia.com>
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
