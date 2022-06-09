Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BF15441BA
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jun 2022 05:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbiFIDAO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jun 2022 23:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiFIDAL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jun 2022 23:00:11 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F1F91;
        Wed,  8 Jun 2022 20:00:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VFpXHXO_1654743606;
Received: from 30.43.106.59(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VFpXHXO_1654743606)
          by smtp.aliyun-inc.com;
          Thu, 09 Jun 2022 11:00:07 +0800
Message-ID: <604ea67b-fa8e-0e36-0adf-2940facfe4ee@linux.alibaba.com>
Date:   Thu, 9 Jun 2022 11:00:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] RDMA/erdma: signedness bug in erdma_request_vectors()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kai Shen <kaishen@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <YqCoWrAXeGHPvTfO@kili>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <YqCoWrAXeGHPvTfO@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 6/8/22 9:47 PM, Dan Carpenter wrote:
> The dev->attrs.irq_num variable is a u32 so the error handling won't
> work.  In this code we are passing "1" as the minimum number of IRQs and
> if it cannot allocate the minimum number of IRQs then the function
> returns -ENOSPC.  This means that it cannot return 0 here.
> 
> Fix the signedness bug by using a "int ret;" and preserve the error
> code instead of always returning -ENOSPC.
> 
> Fixes: d4d7a22521c9 ("RDMA/erdma: Add the erdma module")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Since this bug is found in the initial upstream patch of our new
driver, I would squash your changes into the relevant patch in our next
version patch set to make the commit history cleaner.

Thanks,
Cheng Xu
