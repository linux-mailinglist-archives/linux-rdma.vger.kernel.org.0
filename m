Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF3F52A5CF
	for <lists+linux-rdma@lfdr.de>; Tue, 17 May 2022 17:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243212AbiEQPPJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 May 2022 11:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242418AbiEQPPJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 May 2022 11:15:09 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48A845501
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 08:15:07 -0700 (PDT)
Message-ID: <f3a827f0-69bd-7bae-21cf-02a88063d39d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652800506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GLTLzbqsVYc9lieOGX6EFWjrboSr2mUjCRip872wLCs=;
        b=bV2zzQLLL4eiwkwRVkmEX/AVLf+NEX8aZA9XeSPIG9AIVNx+9YBNBujT/CC65pKaXmPmIJ
        9Y1Dr7yQDFcSz4ZHS5h9DBxaMXeawMTFFytAp8Dx7ZtrBlJTHJkFddrzQnBEq6UuhuU3qc
        96kCFDUMagjWMgfCh5/jJYC1kFgsCJs=
Date:   Tue, 17 May 2022 23:14:56 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Compact the function
 free_rd_atomic_resource
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
References: <20220517190800.122757-1-yanjun.zhu@linux.dev>
 <c9e99081-f6aa-0167-77ff-57533b107e90@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <c9e99081-f6aa-0167-77ff-57533b107e90@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/5/17 22:51, Bob Pearson 写道:
> On 5/17/22 14:08, yanjun.zhu@linux.dev wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> Compact the function and move it to the header file.
> I have two issues with this patch.
>
> There is no advantage of having an inline function in a header file
> that is only called once. The compiler is perfectly capable of (and does)
> inlining a static function in a .c file if only called once. This just
> makes the code harder to read.

When this function is put into the header file, this function can be 
included into the caller function file.

The compiler does not need to call this function in different file. In 
theory, this can increase

the compile speed.

Why do you insist on putting this function in .c file?

Zhu Yanjun

>
> There is a patch in for-rc that gets rid of read.mr in favor of an rkey.
> This patch is out of date.
>
> Bob
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_loc.h  | 11 ++++++++++-
>>   drivers/infiniband/sw/rxe/rxe_qp.c   | 15 ++-------------
>>   drivers/infiniband/sw/rxe/rxe_resp.c |  4 ++--
>>   3 files changed, 14 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
>> index 409efeecd581..6517b4f104b1 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
>> @@ -145,7 +145,16 @@ static inline int rcv_wqe_size(int max_sge)
>>   		max_sge * sizeof(struct ib_sge);
>>   }
>>   
>> -void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res);
>> +static inline void free_rd_atomic_resource(struct resp_res *res)
>> +{
>> +	if (res->type == RXE_ATOMIC_MASK) {
>> +		kfree_skb(res->atomic.skb);
>> +	} else if (res->type == RXE_READ_MASK) {
>> +		if (res->read.mr)
>> +			rxe_drop_ref(res->read.mr);
>> +	}
>> +	res->type = 0;
>> +}
>>   
>>   static inline void rxe_advance_resp_resource(struct rxe_qp *qp)
>>   {
>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>> index 5f270cbf18c6..b29208852bc4 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>> @@ -126,24 +126,13 @@ static void free_rd_atomic_resources(struct rxe_qp *qp)
>>   		for (i = 0; i < qp->attr.max_dest_rd_atomic; i++) {
>>   			struct resp_res *res = &qp->resp.resources[i];
>>   
>> -			free_rd_atomic_resource(qp, res);
>> +			free_rd_atomic_resource(res);
>>   		}
>>   		kfree(qp->resp.resources);
>>   		qp->resp.resources = NULL;
>>   	}
>>   }
>>   
>> -void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res)
>> -{
>> -	if (res->type == RXE_ATOMIC_MASK) {
>> -		kfree_skb(res->atomic.skb);
>> -	} else if (res->type == RXE_READ_MASK) {
>> -		if (res->read.mr)
>> -			rxe_drop_ref(res->read.mr);
>> -	}
>> -	res->type = 0;
>> -}
>> -
>>   static void cleanup_rd_atomic_resources(struct rxe_qp *qp)
>>   {
>>   	int i;
>> @@ -152,7 +141,7 @@ static void cleanup_rd_atomic_resources(struct rxe_qp *qp)
>>   	if (qp->resp.resources) {
>>   		for (i = 0; i < qp->attr.max_dest_rd_atomic; i++) {
>>   			res = &qp->resp.resources[i];
>> -			free_rd_atomic_resource(qp, res);
>> +			free_rd_atomic_resource(res);
>>   		}
>>   	}
>>   }
>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
>> index c369d78fc8e8..923a71ff305c 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>> @@ -663,7 +663,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>   		 */
>>   		res = &qp->resp.resources[qp->resp.res_head];
>>   
>> -		free_rd_atomic_resource(qp, res);
>> +		free_rd_atomic_resource(res);
>>   		rxe_advance_resp_resource(qp);
>>   
>>   		res->type		= RXE_READ_MASK;
>> @@ -977,7 +977,7 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
>>   	}
>>   
>>   	res = &qp->resp.resources[qp->resp.res_head];
>> -	free_rd_atomic_resource(qp, res);
>> +	free_rd_atomic_resource(res);
>>   	rxe_advance_resp_resource(qp);
>>   
>>   	skb_get(skb);
