Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75287641153
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Dec 2022 00:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiLBXGj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Dec 2022 18:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbiLBXGj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Dec 2022 18:06:39 -0500
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BF8E2543;
        Fri,  2 Dec 2022 15:06:38 -0800 (PST)
Received: by mail-pf1-f173.google.com with SMTP id 130so6229932pfu.8;
        Fri, 02 Dec 2022 15:06:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yeaYWU+3i8hJhYxbYSjWcKLZ68H+ZM9quUzrKih1bmI=;
        b=PXCMcae2/cyTtwdcdjU5kUBMaPmudQZ/MwFie64nB6UgI1VhyTFh+0HaCIGx9JhyZV
         IO5gYW7W/b1D2QKbndMshTH4imuJtjpv0jyvISTSQackLlEFgNUtNmuV9eRM8iTYqU+x
         Dhfu9hH8DnpfcSpypGIvWGeE1KrRzQjxrQgX5ZoIkHYV2ipmZjMsoqyEbFosN6qEXQXm
         fexxd7AAodtP4xWgQIQgmWGCn33v8Immvwd0VOQLriEgq1sB+RTt/isr0WvfxTaJebUw
         oooiUdonEQW689sJ3ICwxrEakLfOthmX50eMuaVb6v1JUydu1/5qYP49Rlx6WqtXX8Dv
         TklQ==
X-Gm-Message-State: ANoB5pkJ2mU2axCeNEDHhb5cSfTAJzBveYnBAl3l3hclh+APH8Q1/Tji
        EKrLRO9aSwX1swI/34MJ8MUkbk4GDzo=
X-Google-Smtp-Source: AA0mqf7gHE8J1XDK0GDwt+lhWMttnr20CPo9OL9RP4nm8K3/77LyKsZlGKA/931ZqB0Ia44OrXKUxg==
X-Received: by 2002:a05:6a02:187:b0:46b:26a6:51bc with SMTP id bj7-20020a056a02018700b0046b26a651bcmr64720229pgb.204.1670022397719;
        Fri, 02 Dec 2022 15:06:37 -0800 (PST)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id f14-20020aa7968e000000b0056bee23a80bsm5593515pfk.137.2022.12.02.15.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 15:06:36 -0800 (PST)
Message-ID: <feecdae4-6a50-5991-5792-eda44c0a641b@acm.org>
Date:   Fri, 2 Dec 2022 15:06:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 2/2] RDMA/srp: Fix error return code in
 srp_parse_options()
Content-Language: en-US
To:     Wang Yufen <wangyufen@huawei.com>, jgg@ziepe.ca, leon@kernel.org,
        dennis.dalessandro@cornelisnetworks.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, bart.vanassche@wdc.com,
        easwar.hariharan@intel.com
References: <1669953638-11747-1-git-send-email-wangyufen@huawei.com>
 <1669953638-11747-2-git-send-email-wangyufen@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1669953638-11747-2-git-send-email-wangyufen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/1/22 20:00, Wang Yufen wrote:
> In the previous iteration of the while loop, the "ret" may have been
> assigned a value of 0, so the error return code -EINVAL may have been
> incorrectly set to 0. To fix set valid return code before calling to
> goto. Also investigate each case separately as Andy suggessted.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
