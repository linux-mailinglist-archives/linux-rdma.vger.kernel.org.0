Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664BA5A7909
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 10:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiHaI1v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Aug 2022 04:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiHaI1u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Aug 2022 04:27:50 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611499A9C0
        for <linux-rdma@vger.kernel.org>; Wed, 31 Aug 2022 01:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1661934467; i=@fujitsu.com;
        bh=7eVzmoC8WWDKCKzEUhswgWlfuy9hj/uOC/Yiv3Q6ly0=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=rfD9IQ+OgDNkRhsTHdAfNKq4pFX3S5wr6AHlw1XoTfZe+Y9A708rMmsdh2+oC1kjH
         02e0/SwmMM9UMli9c/uEGilfQarb01ncooyoC2/Eouo/DqAIsPuujQfuvqt+RJpbg+
         VHzcofOBY8m86rv7PhwY5NdPPtxh1DUFL9dndWWNHwP0Sdc1Vf9Y9lkbemlh2SgJSq
         c0sH/H6fE+69d9Dspi68ZUQYfx5f/Jw4dTzUJS5QUMJ8jh5oVOTT+rXLW2GV/MumRo
         02BfDIPUvVBnewYI5bf9jX3b6p6clL9cZY+Go14dnJtGAbIxhn3aicLLQmLJEFl8IN
         xoGjwPq2h4aFQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRWlGSWpSXmKPExsViZ8MxSbdZmj/
  ZYPMaAYsr//YwWrQsusJm8exQL4vFl6nTmC3OH+tnd2D12DnrLrvHrl2N7B69ze/YPD5vkgtg
  iWLNzEvKr0hgzWjb8Ia14KZQxZdvq9kbGPfwdzFycQgJbGGUaDv6mQXCWcEkcXX/V1YIZzujx
  M3VB4AcDg5eATuJCf+1uxg5OVgEVCVe79jDBmLzCghKnJz5hAXEFhWIkHj4aBKYLSzgK3F1aS
  MziM0sIC5x68l8JpCZIgKNjBLfv78GaxYSsJRYtPcaK4jNJqAhca/lJiOIzSlgJdG1/x0rRLO
  FxOI3B9khbHmJ7W/ngA2VEFCUONL5lwXCrpRo/fALylaTuHpuE/MERqFZSO6bheSOWUjGzkIy
  dgEjyypGq6SizPSMktzEzBxdQwMDXUNDU10TXSNjS73EKt1EvdRS3fLU4hJdQ73E8mK91OJiv
  eLK3OScFL281JJNjMCYSilmeb+Dsanvp94hRkkOJiVR3lpu/mQhvqT8lMqMxOKM+KLSnNTiQ4
  wyHBxKErxGEkA5waLU9NSKtMwcYHzDpCU4eJREeKulgNK8xQWJucWZ6RCpU4yKUuK8M8WBEgI
  giYzSPLg2WEq5xCgrJczLyMDAIMRTkFqUm1mCKv+KUZyDUUmYVwNkPE9mXgnc9FdAi5mAFj9c
  wg2yuCQRISXVwORy5+pP31P1G76m3NHleBxfXji11GP5v7srFHK0LnndVjZO6NH9K5ta57te/
  WtWpFnVl2R3Ee58i0qx09IPlGVf8bm9CL7GqbG/Jfj4l7utWb0ClZ5lwsy3LcOtFqxjXTtj54
  Y7bvz8iQYT0uSuly288ppxs1mr1IQSX2WrW3Jy9w68eNW88HLBKrZFZ05cFfum/erOwwNdKzi
  87JY4KTinZuZXvGI8VPOh1XvBXy3Nd/vFdws7t7XlH56yoUWMdZ36xSC9W/9UDE/tebUxPevG
  lYuxGUz9NqGy57+q6EfcvedvGMNw9Ge1Z3VUauxs7YD+F1PTCzI81jw6qvN0Z9nn5eHmNvGCD
  W9YZ5RoK7EUZyQaajEXFScCAEhUYGCkAwAA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-8.tower-591.messagelabs.com!1661934467!23440!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7338 invoked from network); 31 Aug 2022 08:27:47 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-8.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 31 Aug 2022 08:27:47 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id D535B100078;
        Wed, 31 Aug 2022 09:27:46 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id BC4A21000C2;
        Wed, 31 Aug 2022 09:27:46 +0100 (BST)
Received: from [10.167.226.45] (10.167.226.45) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 31 Aug 2022 09:27:44 +0100
Message-ID: <5d54aa2b-b712-125f-1210-1b2a731af67f@fujitsu.com>
Date:   Wed, 31 Aug 2022 16:26:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH for-next v2] RDMA/rxe: Fix resize_finish() in rxe_queue.c
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>, <jgg@nvidia.com>,
        <zyjzyj2000@gmail.com>, <jhack@hpe.com>,
        <linux-rdma@vger.kernel.org>
References: <20220825221446.6512-1-rpearsonhpe@gmail.com>
From:   Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <20220825221446.6512-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 26/08/2022 06:14, Bob Pearson wrote:
> Currently in resize_finish() in rxe_queue.c there is a loop which
> copies the entries in the original queue into a newly allocated queue.
> The termination logic for this loop is incorrect. The call to
> queue_next_index() updates cons but has no effect on whether the
> queue is empty. So if the queue starts out empty nothing is copied
> but if it is not then the loop will run forever. This patch changes
> the loop to compare the value of cons to the original producer index.
>
> Fixes: ae6e843fe08d0 ("RDMA/rxe: Add memory barriers to kernel queues")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> v2
>     Fixed typo. Should have replaced all original 'prod' by 'new_prod'
> ---
>   drivers/infiniband/sw/rxe/rxe_queue.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
> index dbd4971039c0..d6dbf5a0058d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_queue.c
> +++ b/drivers/infiniband/sw/rxe/rxe_queue.c
> @@ -112,23 +112,25 @@ static int resize_finish(struct rxe_queue *q, struct rxe_queue *new_q,
>   			 unsigned int num_elem)
>   {
>   	enum queue_type type = q->type;
> +	u32 new_prod;
>   	u32 prod;
>   	u32 cons;
>   
>   	if (!queue_empty(q, q->type) && (num_elem < queue_count(q, type)))
>   		return -EINVAL;
>   
> -	prod = queue_get_producer(new_q, type);
> +	new_prod = queue_get_producer(new_q, type);
> +	prod = queue_get_producer(q, type);
>   	cons = queue_get_consumer(q, type);
>   
> -	while (!queue_empty(q, type)) {
> -		memcpy(queue_addr_from_index(new_q, prod),
> +	while ((prod - cons) & q->index_mask) {
The termination condition is correct, but below logic is more readable alternative?

count = queue_count(q, type)
while (count--) {
...
}

Otherwise,
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>


> +		memcpy(queue_addr_from_index(new_q, new_prod),
>   		       queue_addr_from_index(q, cons), new_q->elem_size);
> -		prod = queue_next_index(new_q, prod);
> +		new_prod = queue_next_index(new_q, new_prod);
>   		cons = queue_next_index(q, cons);
>   	}
>   
> -	new_q->buf->producer_index = prod;
> +	new_q->buf->producer_index = new_prod;
>   	q->buf->consumer_index = cons;
>   
>   	/* update private index copies */
>
> base-commit: 2c34bb6dea481fa11048e26ffd1ce7400dbc2105

