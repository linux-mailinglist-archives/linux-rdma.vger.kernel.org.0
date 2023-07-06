Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047047496B8
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jul 2023 09:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjGFHqh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jul 2023 03:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjGFHqh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jul 2023 03:46:37 -0400
Received: from out-8.mta0.migadu.com (out-8.mta0.migadu.com [91.218.175.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18041982
        for <linux-rdma@vger.kernel.org>; Thu,  6 Jul 2023 00:46:35 -0700 (PDT)
Message-ID: <babbab54-f8b3-24a4-56b6-95d8a0db6307@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688629593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSFPEWACQpchhembCD7557WcJ8CIvjd+YhpuCa5eWqc=;
        b=ba7U0BSKt4uErWaG6b2V1oRqFQQBHmB2BivIVGnrj1HW+43NEnz/olQ6k7Mi2mqSzlAqSq
        ejUH2qVH67rYE/yS+Eryyn+v+iqYXv8+2eRQ2d75OUYXE85IxSmxY23/iTA18oh0WQokEf
        MbKxX8QobiIs68j12M+Dw34ZH06YpJo=
Date:   Thu, 6 Jul 2023 15:46:23 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v1] infiniband: irdma: Remove a duplicate assignment in
 irdma_query_ah()
To:     Minjie Du <duminjie@vivo.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "open list:INTEL ETHERNET PROTOCOL DRIVER FOR RDMA" 
        <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230706022704.1260-1-duminjie@vivo.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230706022704.1260-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/7/6 10:27, Minjie Du 写道:
> Delete a duplicate statement from this function implementation.
> 

Please add "Fixes ".

Zhu Yanjun

> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>   drivers/infiniband/hw/irdma/verbs.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index 9c4fe4fa9..a8326a95d 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -4424,7 +4424,6 @@ static int irdma_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr)
>   		ah_attr->grh.traffic_class = ah->sc_ah.ah_info.tc_tos;
>   		ah_attr->grh.hop_limit = ah->sc_ah.ah_info.hop_ttl;
>   		ah_attr->grh.sgid_index = ah->sgid_index;
> -		ah_attr->grh.sgid_index = ah->sgid_index;
>   		memcpy(&ah_attr->grh.dgid, &ah->dgid,
>   		       sizeof(ah_attr->grh.dgid));
>   	}

