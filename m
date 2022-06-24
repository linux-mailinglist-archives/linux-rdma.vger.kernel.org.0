Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC57855A4C6
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jun 2022 01:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiFXX0K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jun 2022 19:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXX0J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jun 2022 19:26:09 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1640D81530;
        Fri, 24 Jun 2022 16:26:09 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id r1so3309523plo.10;
        Fri, 24 Jun 2022 16:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lzbd439a0AH9s5v7J1HqFQrBqbp6L4thaAYy/6dD0Yg=;
        b=mKFyMbpW3Djss0w9C54g9NRVfWPGgn7ZCdeGFTCXJETN8x6b9AGHxYuqI2JABcrs41
         EPmA9vyNQRWGPOxvsX1sSaosyCFoLPPZfFE70jHVc0TvLjEK55jYgeH71j0wK9JTrKDB
         ubjEAu3BgyQjaLn1nw5M//Id8UrZcXcGMvGhwQMOetl57lJ723WbZs2297MdDzjIyPDa
         BIC+O0XCjTbYtR/a8CTwgnxQXXlSfBm1K/kND+i8R4pG1HX4ugRrryR3e9+38/BhZngq
         0vlpR5PJGddBDGPCz++A6lO9T22xLk+QexONMd3Yr0KKZDaoumUdAdpcZWsXvoOJHiKb
         VNrQ==
X-Gm-Message-State: AJIora/TcgSrcNFwjtKjL/RANESAA4dwPaznU/NnM1qLEfOngIb/HOMF
        rmkgkestpbk37YT+VzITp7I=
X-Google-Smtp-Source: AGRyM1vGeTj4pZks5wNU8NnkhYzjHbXShLs9KiTB65zBx/JPn3w/thDnN0GBoW6t20uvorML2rEgpw==
X-Received: by 2002:a17:90b:3a89:b0:1ec:93d2:f47d with SMTP id om9-20020a17090b3a8900b001ec93d2f47dmr1378634pjb.139.1656113168309;
        Fri, 24 Jun 2022 16:26:08 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:4e1:3e2c:e2fe:b5e0? ([2620:15c:211:201:4e1:3e2c:e2fe:b5e0])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902bd8500b001640beeebf1sm2301901pls.268.2022.06.24.16.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 16:26:07 -0700 (PDT)
Message-ID: <5a4a42fe-c5c8-63fe-365f-e6c74a279cc2@acm.org>
Date:   Fri, 24 Jun 2022 16:26:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH] RDMA/srp: Fix use-after-free in srp_exit_cmd_priv
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Li Zhijian <lizhijian@fujitsu.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220624040253.1420844-1-lizhijian@fujitsu.com>
 <20220624225908.GA303931@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220624225908.GA303931@nvidia.com>
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

On 6/24/22 15:59, Jason Gunthorpe wrote:
> I don't even understand how get_device() prevents this call chain??
> 
> It looks to me like the problem is srp_remove_one() is not waiting for
> or canceling some outstanding work.

Hi Jason,

My conclusions from the call traces in Li's email are as follows:
* scsi_host_dev_release() can get called after srp_remove_one().
* srp_exit_cmd_priv() uses the ib_device pointer. If srp_remove_one() is 
called before srp_exit_cmd_priv() then a use-after-free is triggered.

Is calling get_device() and put_device() on the struct ib_device an 
acceptable way to fix this? If so, I recommend to insert a get_device() 
call after the scsi_add_host() call and put_device() calls after the two 
scsi_remove_host() calls instead of merging the patch at the start of 
this email thread.

Thanks,

Bart.
