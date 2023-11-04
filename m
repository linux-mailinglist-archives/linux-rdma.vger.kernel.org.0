Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAA97E0F58
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Nov 2023 13:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjKDMbE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 4 Nov 2023 08:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKDMbD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 4 Nov 2023 08:31:03 -0400
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C665194
        for <linux-rdma@vger.kernel.org>; Sat,  4 Nov 2023 05:30:59 -0700 (PDT)
Message-ID: <ee0ee8e1-d9ff-4938-80fe-148d4c367770@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699101058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9pRr5mABA6T7OcEkaLgDfgJXKtKov0K2hPInUKyfyM=;
        b=gvJQHa8Jair2LxR7MQLG13QnhG3Zl1hPU4UBvD/NYBPbyE1ELrVatrFl5p69KTcbmcUNrR
        YqTAqTHQsB8bUrUbXgngL2O63rir9OvxwKe6PAJqTwadOIbHQau260HR/OE4OC3T9e9AAW
        T+aslqcYYjtpBxL33UBmkRDzxoaWD10=
Date:   Sat, 4 Nov 2023 20:30:50 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next 2/6] RDMA/rxe: Handle loopback of mcast packets
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        linux-rdma@vger.kernel.org
References: <20231103204324.9606-1-rpearsonhpe@gmail.com>
 <20231103204324.9606-3-rpearsonhpe@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20231103204324.9606-3-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/11/4 4:43, Bob Pearson 写道:
> Add a mask bit to indicate that a multicast packet has been locally
> sent and use to set the correct qpn for multicast packets.
> 
> Add code to rxe_xmit_packet() to correctly handle multicast packets
> which must be sent on the wire and also duplicated to any local qps
> which may belong the multicast group, but not including the sender.
> 
> Fixes: 6090a0c4c7c6 ("RDMA/rxe: Cleanup rxe_mcast.c")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_av.c     |  7 +++++++
>   drivers/infiniband/sw/rxe/rxe_loc.h    |  1 +
>   drivers/infiniband/sw/rxe/rxe_net.c    | 25 ++++++++++++++++++++++++-
>   drivers/infiniband/sw/rxe/rxe_opcode.h |  2 +-
>   drivers/infiniband/sw/rxe/rxe_recv.c   |  4 ++++
>   drivers/infiniband/sw/rxe/rxe_req.c    | 11 +++++++++--
>   6 files changed, 46 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
> index 4ac17b8def28..022173eb5d75 100644
> --- a/drivers/infiniband/sw/rxe/rxe_av.c
> +++ b/drivers/infiniband/sw/rxe/rxe_av.c
> @@ -7,6 +7,13 @@
>   #include "rxe.h"
>   #include "rxe_loc.h"
>   
> +bool rxe_is_mcast_av(struct rxe_av *av)
> +{
> +	struct in6_addr *daddr = (struct in6_addr *)av->grh.dgid.raw;
> +
> +	return rdma_is_multicast_addr(daddr);
> +}
> +
>   void rxe_init_av(struct rdma_ah_attr *attr, struct rxe_av *av)
>   {
>   	rxe_av_from_attr(rdma_ah_get_port_num(attr), av, attr);
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 3d2504a0ae56..62b2b25903fc 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -8,6 +8,7 @@
>   #define RXE_LOC_H
>   
>   /* rxe_av.c */
> +bool rxe_is_mcast_av(struct rxe_av *av);
>   void rxe_init_av(struct rdma_ah_attr *attr, struct rxe_av *av);
>   int rxe_chk_ah_attr(struct rxe_dev *rxe, struct rdma_ah_attr *attr);
>   void rxe_av_from_attr(u8 port_num, struct rxe_av *av,
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index cd59666158b1..2fad56fc95e7 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -412,6 +412,27 @@ static int rxe_loopback(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>   	return 0;
>   }
>   
> +/* for a multicast packet must send remotely and looback to any local qps
> + * that may belong to the mcast group
> + */

https://www.kernel.org/doc/html/v4.15/process/coding-style.html
Please follow the preferred style for long (multi-line) comments in the 
above link.

Zhu Yanjun

> +static int rxe_loop_and_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
> +{
> +	struct sk_buff *cskb;
> +	int err, loc_err = 0;
> +
> +	if (atomic_read(&pkt->rxe->mcg_num)) {
> +		loc_err = -ENOMEM;
> +		cskb = skb_clone(skb, GFP_KERNEL);
> +		if (cskb)
> +			loc_err = rxe_loopback(cskb, pkt);
> +	}
> +
> +	err = rxe_send(skb, pkt);
> +	if (loc_err)
> +		err = loc_err;
> +	return err;
> +}
> +
>   int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
>   		    struct sk_buff *skb)
>   {
> @@ -431,7 +452,9 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
>   
>   	rxe_icrc_generate(skb, pkt);
>   
> -	if (pkt->mask & RXE_LOOPBACK_MASK)
> +	if (pkt->mask & RXE_MCAST_MASK)
> +		err = rxe_loop_and_send(skb, pkt);
> +	else if (pkt->mask & RXE_LOOPBACK_MASK)
>   		err = rxe_loopback(skb, pkt);
>   	else
>   		err = rxe_send(skb, pkt);
> diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.h b/drivers/infiniband/sw/rxe/rxe_opcode.h
> index 5686b691d6b8..c4cf672ea26d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_opcode.h
> +++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
> @@ -85,7 +85,7 @@ enum rxe_hdr_mask {
>   	RXE_END_MASK		= BIT(NUM_HDR_TYPES + 11),
>   
>   	RXE_LOOPBACK_MASK	= BIT(NUM_HDR_TYPES + 12),
> -
> +	RXE_MCAST_MASK		= BIT(NUM_HDR_TYPES + 13),
>   	RXE_ATOMIC_WRITE_MASK   = BIT(NUM_HDR_TYPES + 14),
>   
>   	RXE_READ_OR_ATOMIC_MASK	= (RXE_READ_MASK | RXE_ATOMIC_MASK),
> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
> index 5861e4244049..7153de0799fc 100644
> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> @@ -217,6 +217,10 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>   	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
>   		qp = mca->qp;
>   
> +		/* don't reply packet to sender if locally sent */
> +		if (pkt->mask & RXE_MCAST_MASK && qp_num(qp) == deth_sqp(pkt))
> +			continue;
> +
>   		/* validate qp for incoming packet */
>   		err = check_type_state(rxe, pkt, qp);
>   		if (err)
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index d8c41fd626a9..599bec88cb54 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -442,8 +442,12 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
>   			(pkt->mask & (RXE_WRITE_MASK | RXE_IMMDT_MASK)) ==
>   			(RXE_WRITE_MASK | RXE_IMMDT_MASK));
>   
> -	qp_num = (pkt->mask & RXE_DETH_MASK) ? ibwr->wr.ud.remote_qpn :
> -					 qp->attr.dest_qp_num;
> +	if (pkt->mask & RXE_MCAST_MASK)
> +		qp_num = IB_MULTICAST_QPN;
> +	else if (pkt->mask & RXE_DETH_MASK)
> +		qp_num = ibwr->wr.ud.remote_qpn;
> +	else
> +		qp_num = qp->attr.dest_qp_num;
>   
>   	ack_req = ((pkt->mask & RXE_END_MASK) ||
>   		(qp->req.noack_pkts++ > RXE_MAX_PKT_PER_ACK));
> @@ -809,6 +813,9 @@ int rxe_requester(struct rxe_qp *qp)
>   		goto err;
>   	}
>   
> +	if (rxe_is_mcast_av(av))
> +		pkt.mask |= RXE_MCAST_MASK;
> +
>   	skb = init_req_packet(qp, av, wqe, opcode, payload, &pkt);
>   	if (unlikely(!skb)) {
>   		rxe_dbg_qp(qp, "Failed allocating skb\n");

