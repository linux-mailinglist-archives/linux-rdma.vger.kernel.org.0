Return-Path: <linux-rdma+bounces-261-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 727DB804983
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 06:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7F628141F
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 05:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB69D2EF;
	Tue,  5 Dec 2023 05:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eHqqY+rA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E35C181
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 21:53:44 -0800 (PST)
Message-ID: <0b103b8d-3462-42d3-bc06-803c0b6ca153@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701755623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzjIUhOpfaIjSD+vTUTAHKVvbPYzafZthOVKY21wrlc=;
	b=eHqqY+rAza4lLvQA4eVECfLCNipbrY8hQMhBTFn3Rb8eQkzbWIFwhMOo/ii5XRrSZu9yM4
	97lnesTMq7PIEv+x+3E+jrU8YeRMIHKYgefYbIYtc7NbOwjFy4SRQSCU5MgBaOcKhd/wNb
	KN9m4W3zsCVwmphYx0fswwFsyVf4hq4=
Date: Tue, 5 Dec 2023 13:53:35 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v5 2/7] RDMA/rxe: Fix sending of mcast packets
To: Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
 linux-rdma@vger.kernel.org, dsahern@kernel.org,
 "davem@davemloft.net" <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20231205002322.10143-1-rpearsonhpe@gmail.com>
 <20231205002322.10143-3-rpearsonhpe@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20231205002322.10143-3-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add  David S. Miller and  David Ahern.

They are the maintainers in netdev and very familiar with mcast.

Zhu Yanjun

在 2023/12/5 8:23, Bob Pearson 写道:
> Currently the rdma_rxe driver does not send mcast packets correctly.
> It uses the wrong qp number for the packets.
>
> Add a mask bit to indicate that a multicast packet has been locally
> sent and use to set the correct qpn for multicast packets and
> identify mcast packets when sending.
>
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_av.c     |  7 +++++++
>   drivers/infiniband/sw/rxe/rxe_loc.h    |  1 +
>   drivers/infiniband/sw/rxe/rxe_net.c    |  4 +++-
>   drivers/infiniband/sw/rxe/rxe_opcode.h |  2 +-
>   drivers/infiniband/sw/rxe/rxe_recv.c   |  4 ++++
>   drivers/infiniband/sw/rxe/rxe_req.c    | 11 +++++++++--
>   6 files changed, 25 insertions(+), 4 deletions(-)
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
> index cd59666158b1..58c3f3759bf0 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -431,7 +431,9 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
>   
>   	rxe_icrc_generate(skb, pkt);
>   
> -	if (pkt->mask & RXE_LOOPBACK_MASK)
> +	if (pkt->mask & RXE_MCAST_MASK)
> +		err = rxe_send(skb, pkt);
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

