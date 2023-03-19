Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9ED06C0214
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Mar 2023 14:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCSNg2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Mar 2023 09:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjCSNg2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 Mar 2023 09:36:28 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842BD10B;
        Sun, 19 Mar 2023 06:36:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Ve8VpRZ_1679232982;
Received: from 30.0.143.175(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0Ve8VpRZ_1679232982)
          by smtp.aliyun-inc.com;
          Sun, 19 Mar 2023 21:36:22 +0800
Message-ID: <167179d0-e1ea-39a8-4143-949ad57294c2@linux.alibaba.com>
Date:   Sun, 19 Mar 2023 21:36:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] RDMA/erdma: Fix exception handling in
 erdma_accept_newconn()
Content-Language: en-US
To:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kai Shen <kaishen@linux.alibaba.com>,
        Leon Romanovsky <leon@kernel.org>,
        Yang Li <yang.lee@linux.alibaba.com>
Cc:     cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <f0f96f74-21d1-f5bf-1086-1c3ce0ea18f5@web.de>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <f0f96f74-21d1-f5bf-1086-1c3ce0ea18f5@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 3/19/23 4:15 AM, Markus Elfring wrote:
> Date: Sat, 18 Mar 2023 21:08:58 +0100
> 

<...>

> +disassoc_socket:
> +    erdma_socket_disassoc(new_s);
> +    sock_release(new_s);
> +    new_cep->state = ERDMA_EPSTATE_CLOSED;
> +    erdma_cancel_mpatimer(new_cep);
> +put_cep:
> +    erdma_cep_put(new_cep);> +    new_cep->sock = NULL;

Thanks, but this causes an use-after-free issue because new_cep will be
released after last erdma_cep_put being called.

Cheng Xu

>  }
>  
>  static int erdma_newconn_connected(struct erdma_cep *cep)
