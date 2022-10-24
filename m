Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD8160B0D2
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 18:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiJXQKe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 12:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiJXQIC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 12:08:02 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6951A059;
        Mon, 24 Oct 2022 07:59:13 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-13bd19c3b68so1436150fac.7;
        Mon, 24 Oct 2022 07:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hjz8bfnpew79ZK8vxKr8F3Y29vbDTiYYKxcDrc9E2rE=;
        b=WKzItRFYYJvKjCYdAJ9Dn+CKQizfYq11tawq+IaVBWHg6P56xw4D9gnJbV41ja1N+F
         ZIOHovpsaOqjrJ10wLjS1bML9SEOHkfA473jfL7rdQ48pUwiu2T0hAaJrSuIgK8zStCJ
         0YbLOOW4XFM7oEvd9YQ9zMqMC+Yq1e5n59viwXug5LxftXSpmlCzkGcf73kFELvqGume
         EEvFZjbwkSLfs61sBbOG+QMHVSiej2gsp6iYt7OTlTxIL3rmPLPX8AvHi6+jVxAC5zDZ
         rrM0sfV/rAqYNKkAi39wJGi+kCjHJL4rSPCI8utqaQZc+Zto8AIRSBFQSg3ARXa/9EUz
         wQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hjz8bfnpew79ZK8vxKr8F3Y29vbDTiYYKxcDrc9E2rE=;
        b=jtPEiUZFjC3dWGyQUXNyfGX7NMzMfOln+Zvz/9vXIa7TarHdCKbFG1eu+gyUZ3JNvJ
         SiudbB3zJrKTtJHzwT52n5DpirNIGJLkcNeSUiDjCmb2xHLS1Qa9xP2+nxJAvLEC8mYz
         6RXkGT4XZ2HiRCR+97fvPHX9Wlaudpna0kkV5ZowwKUFMTo6VERC5TFQgkPfCU8wdFDs
         fYZQT4AlnA1/Lq/H8zg4CcFYJbU74HZ9XEhjuSrdygvXlS8ov4k9pyhd7tguH5ZFFLI4
         zLX4Uxlndez7WTvuMNmZBbXwcoIksDM4hAj6EpNA3WV2S1XW9Sv8fwlnTjucKUy/1W9e
         b+qQ==
X-Gm-Message-State: ACrzQf1mhENnWmMkKPeJTvYB9QUenKar5iSAU6NKkP+W2oW93f5TxIWx
        i6uNAHJtI8IFtW+2Rf+mI0Dmfe77ztY=
X-Google-Smtp-Source: AMsMyM48qWKTfa8EaimzOq+53CXFI8+wt7lxY2MQY4Uj9q+eXCklIdRES1zdZi+aMDLXPhnbk0u6Cw==
X-Received: by 2002:a05:6808:1189:b0:353:f1e2:9afa with SMTP id j9-20020a056808118900b00353f1e29afamr31443204oil.287.1666620944670;
        Mon, 24 Oct 2022 07:15:44 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:1e0:e60:c33:b344? (2603-8081-140c-1a00-01e0-0e60-0c33-b344.res6.spectrum.com. [2603:8081:140c:1a00:1e0:e60:c33:b344])
        by smtp.gmail.com with ESMTPSA id r3-20020a9d7503000000b006618e23df48sm4412495otk.39.2022.10.24.07.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 07:15:44 -0700 (PDT)
Message-ID: <1eb6d3c8-63ed-afa2-4887-494b43582f91@gmail.com>
Date:   Mon, 24 Oct 2022 09:15:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH for-next v3 2/2] RDMA/rxe: Fix mr leak in RESPST_ERR_RNR
Content-Language: en-US
To:     Li Zhijian <lizhijian@fujitsu.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <1666582315-2-1-git-send-email-lizhijian@fujitsu.com>
 <20221024052049.20577-1-lizhijian@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20221024052049.20577-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/24/22 00:20, Li Zhijian wrote:
> rxe_recheck_mr() will increase mr's ref_cnt, so we should call rxe_put(mr)
> to drop mr's ref_cnt in RESPST_ERR_RNR to avoid below warning:
> [  633.447883] WARNING: CPU: 0 PID: 4156 at drivers/infiniband/sw/rxe/rxe_pool.c:259 __rxe_cleanup+0x1df/0x240 [rdma_rxe]
> ...
> [  633.509482] Call Trace:
> [  633.510246]  <TASK>
> [  633.510962]  rxe_dereg_mr+0x4c/0x60 [rdma_rxe]
> [  633.512123]  ib_dereg_mr_user+0xa8/0x200 [ib_core]
> [  633.513444]  ib_mr_pool_destroy+0x77/0xb0 [ib_core]
> [  633.514763]  nvme_rdma_destroy_queue_ib+0x89/0x240 [nvme_rdma]
> [  633.516230]  nvme_rdma_free_queue+0x40/0x50 [nvme_rdma]
> [  633.517577]  nvme_rdma_teardown_io_queues.part.0+0xc3/0x120 [nvme_rdma]
> [  633.519204]  nvme_rdma_error_recovery_work+0x4d/0xf0 [nvme_rdma]
> [  633.520695]  process_one_work+0x582/0xa40
> [  633.522987]  ? pwq_dec_nr_in_flight+0x100/0x100
> [  633.524227]  ? rwlock_bug.part.0+0x60/0x60
> [  633.525372]  worker_thread+0x2a9/0x700
> [  633.526437]  ? process_one_work+0xa40/0xa40
> [  633.527589]  kthread+0x168/0x1a0
> [  633.528518]  ? kthread_complete_and_exit+0x20/0x20
> [  633.529792]  ret_from_fork+0x22/0x30
> 
> CC: Bob Pearson <rpearsonhpe@gmail.com>
> Fixes: 8a1a0be894da ("RDMA/rxe: Replace mr by rkey in responder resources")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> V2: remove mr testing
> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index b02639cf8cba..41250154a478 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -806,8 +806,10 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>  
>  	skb = prepare_ack_packet(qp, &ack_pkt, opcode, payload,
>  				 res->cur_psn, AETH_ACK_UNLIMITED);
> -	if (!skb)
> +	if (!skb) {
> +		rxe_put(mr);
>  		return RESPST_ERR_RNR;
> +	}
>  
>  	rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
>  		    payload, RXE_FROM_MR_OBJ);

This is correct. Good catch. Needs cleanup per Leon otherwise it's good.

Bob
