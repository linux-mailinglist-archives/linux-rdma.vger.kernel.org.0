Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693E75257BC
	for <lists+linux-rdma@lfdr.de>; Fri, 13 May 2022 00:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359132AbiELWZV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 May 2022 18:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbiELWZU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 May 2022 18:25:20 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54D728134A
        for <linux-rdma@vger.kernel.org>; Thu, 12 May 2022 15:25:19 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d17so6278757plg.0
        for <linux-rdma@vger.kernel.org>; Thu, 12 May 2022 15:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iS6pfvkyC9MIU1H7Ss9Q+7R874owU8BIihvHM/W+wCM=;
        b=1zObovhHDW1/ib3iKdKktArgIMmV2OepIa9Y8cOY+yS5bX3pmLXweJg5JVVAu2XmPc
         /AVO2pf5dLgJUTRJIkSslAxco0REliU8OzfcPHqOcgtOuYTx+GKCLdlO1ScqLT1ByAr+
         +MGkCr67GrsHWV6F2LfnURwaWNE1plBaWh/6MOHzMoP72BmOxTt9KBxb5eBHjI2TJbNM
         hvGqGnyMk6qyGAns9IO4SHCLs/erqKhW/uG4flSVAWjffqPpCGXxJfadyIclJL1WHbYB
         4ogZUZtvvQbWKCw+MC3BVxl02lbYnxZEbAZVsuTC6RIzTvRZ/Z9YCDnsmVM6BeJvbnDR
         SgZQ==
X-Gm-Message-State: AOAM530YMPFvC6ZvRML3tIpw3rMazrAy/Q845TUntuyocErIMz7ZitRM
        OzoF/3TcxUH5/zjV2mVYyws=
X-Google-Smtp-Source: ABdhPJz3wXs1fn4cKLneackWd7T144I3blHKpXJK8hK2jHUyGIATeSlu+MfrH8yE4cHJUT12NlweSg==
X-Received: by 2002:a17:90b:380b:b0:1dc:6d24:76ff with SMTP id mq11-20020a17090b380b00b001dc6d2476ffmr13008385pjb.42.1652394318959;
        Thu, 12 May 2022 15:25:18 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:da9f:3995:9dca:fbf7? ([2620:15c:211:201:da9f:3995:9dca:fbf7])
        by smtp.gmail.com with ESMTPSA id em11-20020a17090b014b00b001d952b8f728sm2292948pjb.2.2022.05.12.15.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 15:25:18 -0700 (PDT)
Message-ID: <529dbb0a-0b75-9752-62a3-a1235565aa1a@acm.org>
Date:   Thu, 12 May 2022 15:25:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Apparent regression in blktests since 5.18-rc1+
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Yanjun Zhu <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
References: <e7c31ebb-60c0-cd57-2009-5e9383ecc472@gmail.com>
 <cf8b9980-3965-a4f6-07e0-d4b25755b0db@acm.org>
 <4b0153c7-a8e9-98de-26ae-d421434a116d@linux.dev>
 <20220507012952.GH49344@nvidia.com>
 <81571bbb-c5d2-9b68-765d-f004eb7ba6fd@linux.dev>
 <43c2fed8-699f-19fe-81fa-c5f5b4af646f@gmail.com>
 <4c3439c3-6279-804f-63b2-99d8529e5d3d@acm.org>
 <b2908c39-636a-1cba-db22-838640385d84@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b2908c39-636a-1cba-db22-838640385d84@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/12/22 14:57, Bob Pearson wrote:
> I am trying to reproduce your result. What version of Linus' tree did you use?
> rdma for-next is 5.18-rc1+
> rdma for-rc is 5.18-rc6 (as of earlier today) which is an official tag. Not sure if there is an advanced one from that.

Hi Bob,

That must have been one of the most recent versions at the time I wrote 
my email. Does the exact version matter? The test results I reported 
should be identical for Linus' latest master branch.

Thanks,

Bart.

