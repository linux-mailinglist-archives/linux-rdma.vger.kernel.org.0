Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF79155A528
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jun 2022 01:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiFXX5x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jun 2022 19:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiFXX5v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jun 2022 19:57:51 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD48B8BEED;
        Fri, 24 Jun 2022 16:57:50 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id a11-20020a17090acb8b00b001eca0041455so6306737pju.1;
        Fri, 24 Jun 2022 16:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Pwy5+IbWB0Gv7cf31+Y3t0l2KlHbfsHccSIudADSFZA=;
        b=dO2VxgzjuhENjb08SWTFCW2dp7c3F7RJI7FXzC37Qj91RbWKaahSm7Je6s/aAiWdnh
         dip53YtcXzxUtmNHncaiQkiB+wQiZyxTtjv3K4LFyJFYXEei07B+w+vatXa01clTAnEj
         YSu5tqxIQNwMqQF28n4cnjWePH8nYn6gSBzcC3fRkSzMCxkdk/xrOaNFuBwHa7VkTrWw
         pZ5jfdaGCKojQ+pEdPdnG9BXVESqoz/OOSocZ2wtZEzYQgOgcYXtGTbtRmrdaDeAkJI7
         InGFDSdeg2lU2fqfTAKVWTZySf0AKlMlTte1uBQCKRdHx+E2OtavG81YHJKfOOul7CV1
         ifGw==
X-Gm-Message-State: AJIora801NgmKDfR6+46ipYDuhuliktcR90DB+Vcz79GZsOqLH68KS1J
        o6/4PdTbt5ic6OhKaBbbDeI=
X-Google-Smtp-Source: AGRyM1vrfMPRoCsQiwwllpUlHnR3XspKBPzJw9gXo8CG8CI7JTeV1kEgsSYVg+h/jTnjQwp+E9tUnQ==
X-Received: by 2002:a17:902:8342:b0:16a:39e6:5acd with SMTP id z2-20020a170902834200b0016a39e65acdmr1571816pln.32.1656115070114;
        Fri, 24 Jun 2022 16:57:50 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:4e1:3e2c:e2fe:b5e0? ([2620:15c:211:201:4e1:3e2c:e2fe:b5e0])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a08c300b001ed1444df67sm3491240pjn.6.2022.06.24.16.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 16:57:49 -0700 (PDT)
Message-ID: <0d6ffcec-285a-37f8-5f2f-6a16e3631b92@acm.org>
Date:   Fri, 24 Jun 2022 16:57:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH] RDMA/srp: Fix use-after-free in srp_exit_cmd_priv
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Li Zhijian <lizhijian@fujitsu.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220624040253.1420844-1-lizhijian@fujitsu.com>
 <20220624225908.GA303931@nvidia.com>
 <5a4a42fe-c5c8-63fe-365f-e6c74a279cc2@acm.org>
 <20220624234757.GD4147@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220624234757.GD4147@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/24/22 16:47, Jason Gunthorpe wrote:
> On Fri, Jun 24, 2022 at 04:26:06PM -0700, Bart Van Assche wrote:
>> On 6/24/22 15:59, Jason Gunthorpe wrote:
>>> I don't even understand how get_device() prevents this call chain??
>>>
>>> It looks to me like the problem is srp_remove_one() is not waiting for
>>> or canceling some outstanding work.
>>
>> Hi Jason,
>>
>> My conclusions from the call traces in Li's email are as follows:
>> * scsi_host_dev_release() can get called after srp_remove_one().
>> * srp_exit_cmd_priv() uses the ib_device pointer. If srp_remove_one() is
>> called before srp_exit_cmd_priv() then a use-after-free is triggered.
> 
> Shouldn't srp_remove_one() wait for the scsi_host_dev to complete
> destruction? Clearly it cannot continue to exist once the IB device
> has been removed

That sounds like an interesting approach to me. Li, do you perhaps want 
to implement this approach?

Thanks,

Bart.
