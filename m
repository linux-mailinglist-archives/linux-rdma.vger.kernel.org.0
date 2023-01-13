Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526F4668F9C
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jan 2023 08:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbjAMHx5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Jan 2023 02:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjAMHx4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Jan 2023 02:53:56 -0500
Received: from out-65.mta0.migadu.com (out-65.mta0.migadu.com [IPv6:2001:41d0:1004:224b::41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4676C59530
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jan 2023 23:53:55 -0800 (PST)
Message-ID: <ec0e983b-15fb-e43f-90e2-d4f79d27298a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1673596433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CJxeeSc3qQrOJLMjTK8T/8vYCXW4ZeXCWrjeCq9A1J0=;
        b=qnukT8iyfmEX70BRRAwnkgLN9F6bWePzWFC8UrbiRJX2XnxJFe/vfNCUIF2r2jdGhB/NTO
        lkDMXP5gSL+cEb2gMB60A7JZpZ0BkFP7AXJDSgXQCoS9vHR7/3+igfbBX3zZ4BkWZMcGaj
        S1jOuImh2EZ3jTd+CMPIjBcH2uHWW+Q=
Date:   Fri, 13 Jan 2023 15:53:46 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] infiniband: sw: rxe: Add NULL checks for qp->resp.mr
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        TOTE Robot <oslab@tsinghua.edu.cn>
References: <20230113023527.728725-1-baijiaju1990@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230113023527.728725-1-baijiaju1990@gmail.com>
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

在 2023/1/13 10:35, Jia-Ju Bai 写道:
> In a previous commit 3282a549cf9b, qp->resp.mr could be NULL. Moreover,
> in many functions, qp->resp.mr is checked before its dereferences.
> However, in some functions, this variable is not checked, and thus NULL
> checks should be added.

IMO， we should analyze the code snippet one by one.
And it is not good to add "NULL check" without futher investigations.

Zhu Yanjun
> 
> These results are reported by a static tool written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> ---
>   drivers/infiniband/sw/rxe/rxe_resp.c | 47 ++++++++++++++++------------
>   1 file changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index c74972244f08..2eafa1667a9e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -621,11 +621,13 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
>   	int	err;
>   	int data_len = payload_size(pkt);
>   
> -	err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
> -			  payload_addr(pkt), data_len, RXE_TO_MR_OBJ);
> -	if (err) {
> -		rc = RESPST_ERR_RKEY_VIOLATION;
> -		goto out;
> +	if (qp->resp.mr) {
> +		err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
> +				  payload_addr(pkt), data_len, RXE_TO_MR_OBJ);
> +		if (err) {
> +			rc = RESPST_ERR_RKEY_VIOLATION;
> +			goto out;
> +		}
>   	}
>   
>   	qp->resp.va += data_len;
> @@ -699,11 +701,13 @@ static enum resp_states process_flush(struct rxe_qp *qp,
>   		start = res->flush.va;
>   		length = res->flush.length;
>   	} else { /* level == IB_FLUSH_MR */
> -		start = mr->ibmr.iova;
> -		length = mr->ibmr.length;
> +		if (mr) {
> +			start = mr->ibmr.iova;
> +			length = mr->ibmr.length;
> +		}
>   	}
>   
> -	if (res->flush.type & IB_FLUSH_PERSISTENT) {
> +	if (mr && res->flush.type & IB_FLUSH_PERSISTENT) {
>   		if (rxe_flush_pmem_iova(mr, start, length))
>   			return RESPST_ERR_RKEY_VIOLATION;
>   		/* Make data persistent. */
> @@ -742,7 +746,7 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
>   		qp->resp.res = res;
>   	}
>   
> -	if (!res->replay) {
> +	if (!res->replay && mr) {
>   		if (mr->state != RXE_MR_STATE_VALID) {
>   			ret = RESPST_ERR_RKEY_VIOLATION;
>   			goto out;
> @@ -793,15 +797,17 @@ static enum resp_states do_atomic_write(struct rxe_qp *qp,
>   	int payload = payload_size(pkt);
>   	u64 src, *dst;
>   
> -	if (mr->state != RXE_MR_STATE_VALID)
> +	if (mr && mr->state != RXE_MR_STATE_VALID)
>   		return RESPST_ERR_RKEY_VIOLATION;
>   
>   	memcpy(&src, payload_addr(pkt), payload);
>   
> -	dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
> -	/* check vaddr is 8 bytes aligned. */
> -	if (!dst || (uintptr_t)dst & 7)
> -		return RESPST_ERR_MISALIGNED_ATOMIC;
> +	if (mr) {
> +		dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
> +		/* check vaddr is 8 bytes aligned. */
> +		if (!dst || (uintptr_t)dst & 7)
> +			return RESPST_ERR_MISALIGNED_ATOMIC;
> +	}
>   
>   	/* Do atomic write after all prior operations have completed */
>   	smp_store_release(dst, src);
> @@ -1002,13 +1008,14 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>   		return RESPST_ERR_RNR;
>   	}
>   
> -	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
> -			  payload, RXE_FROM_MR_OBJ);
> -	if (mr)
> +	if (mr) {
> +		err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
> +				  payload, RXE_FROM_MR_OBJ);
>   		rxe_put(mr);
> -	if (err) {
> -		kfree_skb(skb);
> -		return RESPST_ERR_RKEY_VIOLATION;
> +		if (err) {
> +			kfree_skb(skb);
> +			return RESPST_ERR_RKEY_VIOLATION;
> +		}
>   	}
>   
>   	if (bth_pad(&ack_pkt)) {

