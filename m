Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0955067C239
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jan 2023 02:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbjAZBQP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Jan 2023 20:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjAZBQO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Jan 2023 20:16:14 -0500
Received: from out-117.mta0.migadu.com (out-117.mta0.migadu.com [91.218.175.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18C8552A8
        for <linux-rdma@vger.kernel.org>; Wed, 25 Jan 2023 17:16:13 -0800 (PST)
Message-ID: <e59c54bf-03f7-2e27-2162-91dc3f896123@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674695771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=amkR7oURj6hbd0nzV9AYIS42y8HGbdM74GIR9caHQF8=;
        b=DzGmegic0xwE61Qg+VVpQYaUebJxIp6B4TwUZCSArTZWKseNatJtlQaf3cBMJrRUiAoj+3
        /T6zFGceZitCp0UGfoj0brD2L+Dvp/Sv2WGnC8I1AftK0xcIA5n+6AcKNPTWdnf265xp6l
        dHSbDVj2yva2N830qkZZFE/n4wVzckU=
Date:   Thu, 26 Jan 2023 09:16:05 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv3 for-next 0/4] RDMA/irdma: Refactor irdma_reg_user_mr
 function
To:     Zhu Yanjun <yanjun.zhu@intel.com>, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
References: <20230116193502.66540-1-yanjun.zhu@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230116193502.66540-1-yanjun.zhu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/1/17 3:34, Zhu Yanjun 写道:
> V2->V3: 1) Use netdev reverse Christmas tree rule;
> 	2) Return 0 instead of err;
> 	3) Remove unnecessary brackets;
> 	4) Add an error label in error handler;
> 	5) Initialize the structured variables;

Hi, Leon

Follow your advice, I made this patches.
Please check it.

Zhu Yanjun

>   
> V1->V2: Thanks Saleem, Shiraz.
>          1) Remove the unnecessary variable initializations;
>          2) Get iwdev by to_iwdev;
> 	3) Use the label free_pble to handle errors;
> 	4) Validate the page size before rdma_umem_for_each_dma_block
> 
> Split the shared source codes into several new functions for future use.
> No bug fix and new feature in this commit series.
> 
> The new functions are as below:
> 
> irdma_reg_user_mr_type_mem
> irdma_alloc_iwmr
> irdma_free_iwmr
> irdma_reg_user_mr_type_qp
> irdma_reg_user_mr_type_cq
> 
> These functions will be used in the dmabuf feature.
> 
> Zhu Yanjun (4):
>    RDMA/irdma: Split MEM handler into irdma_reg_user_mr_type_mem
>    RDMA/irdma: Split mr alloc and free into new functions
>    RDMA/irdma: Split QP handler into irdma_reg_user_mr_type_qp
>    RDMA/irdma: Split CQ handler into irdma_reg_user_mr_type_cq
> 
>   drivers/infiniband/hw/irdma/verbs.c | 270 +++++++++++++++++-----------
>   1 file changed, 168 insertions(+), 102 deletions(-)
> 

