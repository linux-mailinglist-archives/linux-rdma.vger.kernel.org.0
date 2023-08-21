Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1D0782A66
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Aug 2023 15:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjHUNYD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Aug 2023 09:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjHUNYC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Aug 2023 09:24:02 -0400
Received: from out-23.mta1.migadu.com (out-23.mta1.migadu.com [95.215.58.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD338F
        for <linux-rdma@vger.kernel.org>; Mon, 21 Aug 2023 06:24:01 -0700 (PDT)
Message-ID: <b14d64e6-5972-c0eb-36a5-a35cbd004b9a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692624238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=psE5SfPJmT/trhqjxTkTOJ5J0mt82Sper+BIpMZjGSQ=;
        b=Dsvjs18p3zdJUzgNPwkjTE8I5Ud54Fvm5w1OwHOMw3WFl65xZtBA2K6+N3QPxpxKSuyDym
        +QNv2vBUmxRsPwySxeZO8FFSZGkCUIruHlmWfoYsbWjGcu5FOoT+j6yR1+GiVwv8gIZe/h
        QpHYkP4ISkDKG3K8WN2YDafa0PxiqN8=
Date:   Mon, 21 Aug 2023 21:23:52 +0800
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH V2 3/3] RDMA/siw: Call llist_reverse_order in siw_run_sq
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20230821084743.6489-1-guoqing.jiang@linux.dev>
 <20230821084743.6489-4-guoqing.jiang@linux.dev>
 <SN7PR15MB575541C91E91623AC6D70B3A991EA@SN7PR15MB5755.namprd15.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <SN7PR15MB575541C91E91623AC6D70B3A991EA@SN7PR15MB5755.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 8/21/23 20:00, Bernard Metzler wrote:
>
>> -----Original Message-----
>> From: Guoqing Jiang <guoqing.jiang@linux.dev>
>> Sent: Monday, 21 August 2023 10:48
>> To: Bernard Metzler <BMT@zurich.ibm.com>; jgg@ziepe.ca; leon@kernel.org
>> Cc: linux-rdma@vger.kernel.org
>> Subject: [EXTERNAL] [PATCH V2 3/3] RDMA/siw: Call llist_reverse_order in
>> siw_run_sq
>>
>> We can call the function to get fifo list.
>>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>> ---
>>   drivers/infiniband/sw/siw/siw_qp_tx.c | 12 +-----------
>>   1 file changed, 1 insertion(+), 11 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c
>> b/drivers/infiniband/sw/siw/siw_qp_tx.c
>> index 4b292e0504f1..eb3d438828e2 100644
>> --- a/drivers/infiniband/sw/siw/siw_qp_tx.c
>> +++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
>> @@ -1229,17 +1229,7 @@ int siw_run_sq(void *data)
>>   			break;
>>
>>   		active = llist_del_all(&tx_task->active);
>> -		/*
>> -		 * llist_del_all returns a list with newest entry first.
>> -		 * Re-order list for fairness among QP's.
>> -		 */
>> -		while (active) {
>> -			struct llist_node *tmp = active;
>> -
>> -			active = llist_next(active);
>> -			tmp->next = fifo_list;
>> -			fifo_list = tmp;
>> -		}
>> +		fifo_list = llist_reverse_order(active);
>>   		while (fifo_list) {
>>   			qp = container_of(fifo_list, struct siw_qp, tx_list);
>>   			fifo_list = llist_next(fifo_list);
>> --
>> 2.35.3
> Oh yes, that function already exists. Many thanks!
> I'd keep the comment, since it might be not obvious why we
> reverse the list.

Ok, will add them back.

> Acked-by: Bernard Metzler <bmt@zurich.ibm.com>

Appreciate for your review!

Thanks,
Guoqing
