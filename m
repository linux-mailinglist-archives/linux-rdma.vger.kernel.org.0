Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6551C6DC738
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Apr 2023 15:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjDJNQw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Apr 2023 09:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjDJNQw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Apr 2023 09:16:52 -0400
X-Greylist: delayed 409 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Apr 2023 06:16:50 PDT
Received: from out-60.mta1.migadu.com (out-60.mta1.migadu.com [95.215.58.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9DA4ECF
        for <linux-rdma@vger.kernel.org>; Mon, 10 Apr 2023 06:16:50 -0700 (PDT)
Message-ID: <28516715-ed06-6ac2-d65c-551da18997a9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1681132197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/tPs1OQ8BAAD3WNg9n0ExU1NJO7zY3G3mT/LDJNv6Cw=;
        b=bCF5ERnUV3owlJNw3RXQ0XoYAsibhHBQI/w3BB4oJyA2k/VpnpcSFa4Cx0F91cdMR6SMTv
        gg4KjNIA4ZyhUWrATKFgHa5H7eitSGlVfQDfAEa9FX4MnvA1To/owPydpuUHD4wbrRFQnO
        rBkRCURrSytHMzEatRbSkSlyGaUnvYw=
Date:   Mon, 10 Apr 2023 21:09:52 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next 1/3] RDMA/rtrs: Remove duplicate cq_num
 assignment
Content-Language: en-US
To:     Li Zhijian <lizhijian@fujitsu.com>, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <1681108984-2-1-git-send-email-lizhijian@fujitsu.com>
 <1681108984-2-2-git-send-email-lizhijian@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <1681108984-2-2-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 4/10/23 14:43, Li Zhijian wrote:
> line 1701 and 1713 are duplicate:
>> 1701         cq_num = max_send_wr + max_recv_wr;
>   1702         /* alloc iu to recv new rkey reply when server reports flags set */
>   1703         if (clt_path->flags & RTRS_MSG_NEW_RKEY_F || con->c.cid == 0) {
>   1704                 con->rsp_ius = rtrs_iu_alloc(cq_num, sizeof(*rsp),
>   1705                                               GFP_KERNEL,
>   1706                                               clt_path->s.dev->ib_dev,
>   1707                                               DMA_FROM_DEVICE,
>   1708                                               rtrs_clt_rdma_done);
>   1709                 if (!con->rsp_ius)
>   1710                         return -ENOMEM;
>   1711                 con->queue_num = cq_num;
>   1712         }
>> 1713         cq_num = max_send_wr + max_recv_wr;
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   drivers/infiniband/ulp/rtrs/rtrs-clt.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 80abf45a197a..c2065fc33a56 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1710,7 +1710,6 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
>   			return -ENOMEM;
>   		con->queue_num = cq_num;
>   	}
> -	cq_num = max_send_wr + max_recv_wr;
>   	cq_vector = con->cpu % clt_path->s.dev->ib_dev->num_comp_vectors;
>   	if (con->c.cid >= clt_path->s.irq_con_num)
>   		err = rtrs_cq_qp_create(&clt_path->s, &con->c, max_send_sge,

Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>

Thanks,
Guoqing
