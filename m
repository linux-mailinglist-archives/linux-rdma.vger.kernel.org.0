Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D014F8954
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 00:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbiDGVlf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Apr 2022 17:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiDGVl3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Apr 2022 17:41:29 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A0C2D1D1
        for <linux-rdma@vger.kernel.org>; Thu,  7 Apr 2022 14:39:27 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id a19so2535405oie.7
        for <linux-rdma@vger.kernel.org>; Thu, 07 Apr 2022 14:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Jjht++UEXxstIbrzG1cvm0U/5VPCgZvfGiY920Aimb0=;
        b=DUyIi9AhMZzrFXhNPTAdmXaJqvpSrQGVDqPrSsaVvYE4LvAmLrxZTPxottJ5ATJgRD
         fnFtTayAM/cjVSmZ3jQ6MAeUt8BXKuhVczV58DWcrIhAL+UO2XzzWqbRrZqXFqX8pIVv
         iVrDD3nnZS52dV+XLJL7W906ONBiD3CuNxHsfXxtRywyri3hD2PKDVngSL46JE8vs3uG
         S5f5VNwrzyQ5wT3/ygmmg5jZPLEnz6E/h0PzLeASlb7WN+iFWAq+tRkk6lJKBirrLFmr
         qIbgebJjzgDfzF3dKBRk47UyydPBcYCoSL+yjpfrxl+M0XMToChj/qsljdsvsado9+35
         mtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Jjht++UEXxstIbrzG1cvm0U/5VPCgZvfGiY920Aimb0=;
        b=VNUHpcVGjsv5bWdCEIhMYQAJnK2Q3X034IMwmMECplhwtmzPPW1ok4dh+WrJGAGkH9
         uv23b3RKGmd77cB2i3jzSOctMiaU7FEGymtl0RJmfacd4xqu+jCJcYwQs8wwDisOvPWR
         DjRnk0quHfSEzRQA+UP8ONnoDnJCspu4ZTWd4bXRsPwpssU8kdvWpdW/57NYlNcCzYpv
         j2/mD6ynbH1FeZA1uFGzVF19Y1PF2CpsI7Qh0jhMEEK6pC9cmbUzdW6Sii0RP1/7Rbh/
         NXbSxcDvXCU0OvTyqf2lbkDjn/WNJ/k2jQFRxnk3IWzNeWzOcxQ8HXhczfMLg0FtM9MW
         hj4w==
X-Gm-Message-State: AOAM532nCTPeONYfvHAEMw4xlKG9Xe2T4FDHpojc7XOS19LTjTdO4sp8
        DuNo14RhsZLwtQkC2HkvcYfun9Dspts=
X-Google-Smtp-Source: ABdhPJxMSIs7/K1wfdK+YEmOeF+Dt8P9M31aFSqaVuocIHLajeSjaIF+7UpPc05AUXxotfPnIi9E/w==
X-Received: by 2002:a05:6808:ec5:b0:2f7:4019:53be with SMTP id q5-20020a0568080ec500b002f7401953bemr6705795oiv.176.1649367566173;
        Thu, 07 Apr 2022 14:39:26 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:203d:1c92:96e5:569a? (2603-8081-140c-1a00-203d-1c92-96e5-569a.res6.spectrum.com. [2603:8081:140c:1a00:203d:1c92:96e5:569a])
        by smtp.gmail.com with ESMTPSA id z10-20020a0568301daa00b005ce0f36dd81sm8259215oti.12.2022.04.07.14.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 14:39:25 -0700 (PDT)
Message-ID: <5c806f62-d258-7860-4b6b-416adc603879@gmail.com>
Date:   Thu, 7 Apr 2022 16:39:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] RDMA/rxe: Generate a completion on error after getting
 a wqe
Content-Language: en-US
To:     Xiao Yang <yangx.jy@fujitsu.com>, leon@kernel.org, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org
References: <20220331120245.314614-1-yangx.jy@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220331120245.314614-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/31/22 07:02, Xiao Yang wrote:
> Current rxe_requester() doesn't generate a completion on error after
> getting a wqe. Fix the issue by calling rxe_completer() on error.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index ae5fbc79dd5c..01ae400e5481 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -648,26 +648,24 @@ int rxe_requester(void *arg)
>  		psn_compare(qp->req.psn, (qp->comp.psn +
>  				RXE_MAX_UNACKED_PSNS)) > 0)) {
>  		qp->req.wait_psn = 1;
> -		goto exit;
> +		goto qp_op_err;
>  	}
This isn't an error. What is happening is the requester has advanced too far into the
work request queue compared to what has been completed. So it sets a flag and exits the
loop. When the completer finishes another completion it will reschedule the requester.
RXE_MAX_UNACKED_PSNS is 128 so only 128 packets are allowed in the network without
seeing an ack.
>  
>  	/* Limit the number of inflight SKBs per QP */
>  	if (unlikely(atomic_read(&qp->skb_out) >
>  		     RXE_INFLIGHT_SKBS_PER_QP_HIGH)) {
>  		qp->need_req_skb = 1;
> -		goto exit;
> +		goto qp_op_err;
>  	}
This also is not an error. Here there is a limit on the number SKBs in flight.
The SKBs are consumed by the ethernet driver when the packet is put on the wire.
This prevents the driver from using too much memory when the NIC is paused.
>  
>  	opcode = next_opcode(qp, wqe, wqe->wr.opcode);
> -	if (unlikely(opcode < 0)) {
> -		wqe->status = IB_WC_LOC_QP_OP_ERR;
> -		goto exit;
> -	}
This really is an error, but one that shouldn't happen under normal
circumstances since it implies an illegal operation. Like attempting
a write on a UD QP. Or causing an invalid opcode sequence.
> +	if (unlikely(opcode < 0))
> +		goto qp_op_err;
>  
>  	mask = rxe_opcode[opcode].mask;
>  	if (unlikely(mask & RXE_READ_OR_ATOMIC_MASK)) {
>  		if (check_init_depth(qp, wqe))
> -			goto exit;
> +			goto qp_op_err;
>  	}
This isn't an error. It means that someone posted a read/atomic operation
and there are too many pending read/atomic operations pending. You just need
to wait for one of them to complete so it is another pause.
>  
>  	mtu = get_mtu(qp);
> @@ -706,26 +704,26 @@ int rxe_requester(void *arg)
>  	av = rxe_get_av(&pkt, &ah);
>  	if (unlikely(!av)) {
>  		pr_err("qp#%d Failed no address vector\n", qp_num(qp));
> -		wqe->status = IB_WC_LOC_QP_OP_ERR;
>  		goto err_drop_ah;
>  	}
This is an error. It could happen if the address handle referred to by
the WR is not longer valid. There should always be an address vector but
there may or may not be an address handle if the AV comes from a connected
QP or not.
>  
>  	skb = init_req_packet(qp, av, wqe, opcode, payload, &pkt);
>  	if (unlikely(!skb)) {
>  		pr_err("qp#%d Failed allocating skb\n", qp_num(qp));
> -		wqe->status = IB_WC_LOC_QP_OP_ERR;
>  		goto err_drop_ah;
>  	}
>  
>  	ret = finish_packet(qp, av, wqe, &pkt, skb, payload);
>  	if (unlikely(ret)) {
>  		pr_debug("qp#%d Error during finish packet\n", qp_num(qp));
> +		if (ah)
> +			rxe_put(ah);
>  		if (ret == -EFAULT)
>  			wqe->status = IB_WC_LOC_PROT_ERR;
>  		else
>  			wqe->status = IB_WC_LOC_QP_OP_ERR;
>  		kfree_skb(skb);
> -		goto err_drop_ah;
> +		goto err;
>  	}
Not sure the point of this. 
>  
>  	if (ah)
> @@ -751,8 +749,7 @@ int rxe_requester(void *arg)
>  			goto exit;
>  		}
>  
> -		wqe->status = IB_WC_LOC_QP_OP_ERR;
> -		goto err;
> +		goto qp_op_err;
>  	}
>  
>  	update_state(qp, wqe, &pkt);
> @@ -762,6 +759,9 @@ int rxe_requester(void *arg)
>  err_drop_ah:
>  	if (ah)
>  		rxe_put(ah);
> +
> +qp_op_err:
> +	wqe->status = IB_WC_LOC_QP_OP_ERR;
>  err:
>  	wqe->state = wqe_state_error;
>  	__rxe_do_task(&qp->comp.task);

Near as I can tell all you did was turn a few pauses into errors which is wrong
and otherwise move things around. What were you trying to solve here?

Bob
