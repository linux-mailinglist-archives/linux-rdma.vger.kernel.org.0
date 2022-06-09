Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DB7544182
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jun 2022 04:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbiFICc2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jun 2022 22:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiFICc1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jun 2022 22:32:27 -0400
Received: from out199-3.us.a.mail.aliyun.com (out199-3.us.a.mail.aliyun.com [47.90.199.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B722F31DD9
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jun 2022 19:32:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VFpU7Lf_1654741940;
Received: from 30.43.106.59(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VFpU7Lf_1654741940)
          by smtp.aliyun-inc.com;
          Thu, 09 Jun 2022 10:32:21 +0800
Message-ID: <b1908852-9dee-1ff2-e46d-4c1fc6667c22@linux.alibaba.com>
Date:   Thu, 9 Jun 2022 10:32:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [bug report] RDMA/erdma: Add verbs implementation
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-rdma@vger.kernel.org
References: <YqCcf36CtN3IwXpo@kili>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <YqCcf36CtN3IwXpo@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 6/8/22 8:56 PM, Dan Carpenter wrote:
> Hello Cheng Xu,
> 
> The patch c4612e83c14b: "RDMA/erdma: Add verbs implementation" from
> May 23, 2022, leads to the following Smatch static checker warning:
> 
> 	drivers/infiniband/hw/erdma/erdma_verbs.c:111 create_qp_cmd()
> 	error: uninitialized symbol 'resp0'.
> 
> drivers/infiniband/hw/erdma/erdma_verbs.c
>      100                 req.sq_buf_addr = user_qp->sq_mtt.mtt_entry[0];
>      101                 req.rq_buf_addr = user_qp->rq_mtt.mtt_entry[0];
>      102
>      103                 req.sq_db_info_dma_addr = user_qp->sq_db_info_dma_addr;
>      104                 req.rq_db_info_dma_addr = user_qp->rq_db_info_dma_addr;
>      105         }
>      106
>      107         err = erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req, sizeof(req), &resp0,
>      108                                   &resp1);
> 
> The erdma_post_cmd_wait() function does not initialize erdma_post_cmd_wait()
> on the error paths.

Oh, I knew this before: since erdma_post_cmd_wait returns error, the qp
's resource will destroy soon, the uninitialized value of resp0 will
influence nothing. So here I reduce a condition judgement.

Anyway, I will fix it to eliminate the static checker warning.


> Also it returns comp_wait->comp_status which is a u8.  I guess that's
> some kind of custom error code.  Mixing kernel and custom error codes
> is dangerous.  I think it's a bug in this case.
> 

I will fix it in the next version of our patches.

Thanks,
Cheng Xu


