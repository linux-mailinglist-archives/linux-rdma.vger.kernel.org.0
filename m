Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E001572B46
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Jul 2022 04:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiGMCYW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Jul 2022 22:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiGMCYV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Jul 2022 22:24:21 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD6C26AC4
        for <linux-rdma@vger.kernel.org>; Tue, 12 Jul 2022 19:24:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VJBdVK7_1657679057;
Received: from 30.157.170.70(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VJBdVK7_1657679057)
          by smtp.aliyun-inc.com;
          Wed, 13 Jul 2022 10:24:17 +0800
Message-ID: <6f7a778e-26a8-2037-b92e-7997a37a74ae@linux.alibaba.com>
Date:   Wed, 13 Jul 2022 10:24:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH for-next v12 00/11] Elastic RDMA Adapter (ERDMA) driver
Content-Language: en-US
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
References: <20220711131316.3449-1-chengyou@linux.alibaba.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20220711131316.3449-1-chengyou@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 7/11/22 9:13 PM, Cheng Xu wrote:
> Hello all,
> 
> This v12 patch set introduces the Elastic RDMA Adapter (ERDMA) driver,
> which released in Apsara Conference 2021 by Alibaba. The PR of ERDMA
> userspace provider has already been created [1].
> 

As Greg said in mana_ib, that new drivers should not use OpenIB license.
I found that some files in erdma have the same issue.

I will update our license to "GPLv2 or BSD-3-Clause" in next version.

Sorry for disturbing all.

Cheng Xu

