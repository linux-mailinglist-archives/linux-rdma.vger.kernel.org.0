Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4ED55F0BD
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jun 2022 23:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiF1V4O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jun 2022 17:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiF1V4O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jun 2022 17:56:14 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0DC1AF1C;
        Tue, 28 Jun 2022 14:56:13 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id c205so13200181pfc.7;
        Tue, 28 Jun 2022 14:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pWelTq6EwN56QbJGveF4saWXx8x5SzMztkDjtuePWmo=;
        b=Y5nVIPDnwws3+DibmU8OVMqeaaG8d5lb14hm3FcRyQXR6/N4qaV+FHIyje+UE1r36B
         yyV0ZJ4jCt+lqL0oKw8XnumaT4fpY4EfR2f0b+d4jkq4e+DO4zhkmYJBi3QHrvOp+OH0
         uKwYTPsQX4BRMrpithLqB+zccP+8kvZAKqKgaFo2UJi7E4R8kJE684bfI8ygTX8lblWE
         481dd0zFLmZ8XgkJQ/q7qiZ48w5P/Q+XISjfwJAd3kqUVH/0XPoa5/UTQYxQn18tw0Pb
         0mBTy5SUyN3/SLRCZVaNxNqyqxGnsSe8QHys7M7aGvtjqIn9ZENvCTLMDXwD3NxYlMlY
         ZWwA==
X-Gm-Message-State: AJIora9tskAC3Lu7AO2ymu6szjabs6MLMgIWNv74AZDN7D3GzfCjvcWc
        QZxrfU4bQXgG3NvrCa3yOHc=
X-Google-Smtp-Source: AGRyM1siu9bfq6SiHtW1/mutIkn/vmbrZLnwoXPu3Cu6+nFlYYd2MTNkAcoYt1fFa64lPtl+vJg6NQ==
X-Received: by 2002:a05:6a00:18a7:b0:51b:c63f:1989 with SMTP id x39-20020a056a0018a700b0051bc63f1989mr6824988pfh.49.1656453373150;
        Tue, 28 Jun 2022 14:56:13 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902758200b0016a058b7547sm9629449pll.294.2022.06.28.14.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 14:56:12 -0700 (PDT)
Message-ID: <c9a8d74b-40c1-cc0c-6b21-0cec7d69ed8e@acm.org>
Date:   Tue, 28 Jun 2022 14:56:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH] RDMA/srp: Fix use-after-free in srp_exit_cmd_priv
Content-Language: en-US
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220624040253.1420844-1-lizhijian@fujitsu.com>
 <20220624225908.GA303931@nvidia.com>
 <5a4a42fe-c5c8-63fe-365f-e6c74a279cc2@acm.org>
 <20220624234757.GD4147@nvidia.com>
 <343aa894-796f-181e-1691-15cb8659ab06@fujitsu.com>
 <41517c0e-acde-25ce-b4d0-7a32499009f3@acm.org>
 <12bca306-e113-a459-c29f-e36785bdf08f@fujitsu.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <12bca306-e113-a459-c29f-e36785bdf08f@fujitsu.com>
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

On 6/27/22 21:41, lizhijian@fujitsu.com wrote:
> Awesome, It works for me.
> 
> Tested-by: Li Zhijian<lizhijian@fujitsu.com>

Thanks for having tested this patch :-) This patch has been posted on the
linux-scsi mailing list. See also
https://lore.kernel.org/linux-scsi/20220628175612.2157218-1-bvanassche@acm.org/T/#u

Bart.
