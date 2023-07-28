Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254FE766C3B
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jul 2023 13:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjG1L5q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jul 2023 07:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjG1L5q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Jul 2023 07:57:46 -0400
Received: from out-90.mta0.migadu.com (out-90.mta0.migadu.com [91.218.175.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0439A0
        for <linux-rdma@vger.kernel.org>; Fri, 28 Jul 2023 04:57:44 -0700 (PDT)
Message-ID: <eded8d1e-3df1-7bb4-8788-ac0e5155c9a3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690545462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sQpR1Iqc9PCuHAGj8rxCGgi8myknWwwplbMcEeUXW30=;
        b=bYK+G02yv4NbP5VoKQ2mP7TH4ujKWGCZgQ+yVG3iWCZiRCFWa0caQq7S/T4XrD/aaNvkfs
        6CeuyldtvS1/WoCrKqvwSx6NLnvIta9kz+LnIh8x/jewxTu4jCy3O6u2PlcOEYfjn8re48
        Pz79e8DY3wUMPsEuIMaIx1QIWRkmThI=
Date:   Fri, 28 Jul 2023 19:57:36 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/siw: Fix tx thread initialization.
Content-Language: en-US
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, leon@kernel.org
References: <20230728114418.124328-1-bmt@zurich.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <20230728114418.124328-1-bmt@zurich.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 7/28/23 19:44, Bernard Metzler wrote:
> Immediately removing the siw module after insertion may
> crash in siw_stop_tx_thread(), if the according thread did
> not yet had a chance to initialize its wait queue and
> siw_stop_tx_thread() tries to wakeup that thread. Initializing
> the threads state before spwaning it fixes it.
>
> Reported-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>   drivers/infiniband/sw/siw/siw.h       |  3 +-
>   drivers/infiniband/sw/siw/siw_main.c  | 40 ++----------------------
>   drivers/infiniband/sw/siw/siw_qp_tx.c | 44 +++++++++++++++++++++++----
>   3 files changed, 43 insertions(+), 44 deletions(-)

It works for me.

Tested-by: Guoqing Jiang <guoqing.jiang@linux.dev>

Thanks,
Guoqing
