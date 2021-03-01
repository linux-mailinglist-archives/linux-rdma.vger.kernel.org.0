Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EF832783B
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Mar 2021 08:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhCAHZK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Mar 2021 02:25:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:58888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232348AbhCAHZJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 1 Mar 2021 02:25:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B1BF64DEF;
        Mon,  1 Mar 2021 07:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614583468;
        bh=x5+rbdvf440sXTb9ylvn2G1zbpkV+ORrnaZhOAm2BYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QGjoDF/SldGKVRQvLdWjsa9aRqmh/P08+CQZegfnSDRoCM7bjck9fo+EfEYIiHVKO
         rLyIpHMXlPE5rhn9pKLw87hXjtFw1JaZn964c0UQECldhhvcTn87qxGQOQazjFGVam
         hydmseeNzcu8EHHyHD/DWx4kxhFoTWu/5rHelwe8K1G5qNDp9dCxVbCGSZZnNUH5Iw
         YQ0uJmHwCDkty1wdro4+A9cFORk0r5HSPEnV05huVp4HA066QaLBV3qbWAcyFfHhjC
         N/+8hcBlM+lc4B0cf2ziDaDkukYi3bQHUu0xvFeeMXZM67TwjbZM6U+RXta4sTFF+F
         GvFP189gIcPTQ==
Date:   Mon, 1 Mar 2021 09:24:24 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, Frank Zago <frank.zago@hpe.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix ib_device reference counting
 (again)
Message-ID: <YDyWqLuRw33mU63D@unreal>
References: <20210214222630.3901-1-rpearson@hpe.com>
 <48dcbdc5-35a3-2fe3-3e3d-bff37c2d8053@gmail.com>
 <20210226233301.GA4247@nvidia.com>
 <3165add7-518d-9485-fa12-6d7822ed9165@gmail.com>
 <YDoGJIcB6SB/7LPj@unreal>
 <db406802-25a8-bda8-6add-4b75057eec96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db406802-25a8-bda8-6add-4b75057eec96@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Feb 28, 2021 at 11:04:08AM -0600, Bob Pearson wrote:
> On 2/27/21 2:43 AM, Leon Romanovsky wrote:
> > On Fri, Feb 26, 2021 at 06:02:39PM -0600, Bob Pearson wrote:
> >> On 2/26/21 5:33 PM, Jason Gunthorpe wrote:
> >>> On Fri, Feb 26, 2021 at 05:28:41PM -0600, Bob Pearson wrote:
> >>>> Just a reminder. rxe in for-next is broken until this gets done.
> >>>> thanks
> >>>
> >>> I was expecting you to resend it? There seemed to be some changes
> >>> needed
> >>>
> >>> https://patchwork.kernel.org/project/linux-rdma/patch/20210214222630.3901-1-rpearson@hpe.com/
> >>>
> >>> Jason
> >>>
> >> OK. I see. I agreed to that complaint when the kfree was the only thing in the if {} but now I have to call ib_device_put() *only* in the error case not if there wasn't an error. So no reason to not put the kfree_skb() in there too and avoid passing a NULL pointer. It should stay the way it is.
> >
> > First, I posted a diff which makes this if() redundant.
> > Second, the if () before kfree() is checked by coccinelle and your
> > "should stay the way it is" will be marked as failure in many CIs,
> > including ours.
> >
> > Thanks
> >
> >>
> >> bob
>
> Leon,
>
> I am not sure we are talking about the same if statement. You wrote
>
> ...
> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
> index 8a48a33d587b..29cb0125e76f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> @@ -247,6 +247,11 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>  	else if (skb->protocol == htons(ETH_P_IPV6))
>  		memcpy(&dgid, &ipv6_hdr(skb)->daddr, sizeof(dgid));
>
> +	if (!ib_device_try_get(&rxe->ib_dev)) {
> +		kfree_skb(skb);
> +		return;
> +	}
> +
>  	/* lookup mcast group corresponding to mgid, takes a ref */
>  	mcg = rxe_pool_get_key(&rxe->mc_grp_pool, &dgid);
>  	if (!mcg)
> @@ -274,10 +279,6 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>  		 */
>  		if (mce->qp_list.next != &mcg->qp_list) {
>  			per_qp_skb = skb_clone(skb, GFP_ATOMIC);
> -			if (WARN_ON(!ib_device_try_get(&rxe->ib_dev))) {
> -				kfree_skb(per_qp_skb);
> -				continue;
> -			}
>  		} else {
>  			per_qp_skb = skb;
>  			/* show we have consumed the skb */
> ...
>
> which I don't understand.
>
> When a received packet is delivered to the rxe driver in rxe_net.c in rxe_udp_encap_recv() rxe_get_dev_from_net() is called which gets a pointer to the ib_device (contained in rxe_dev) and also takes a reference on the ib_device. This pointer is stored in skb->cb[] so the reference needs to be held until the skb is freed. If the skb has a multicast address and there are more than one QPs belonging to the multicast group then new skbs are cloned in rxe_rcv_mcast_pkt() and each has a pointer to the ib_device. Since each skb can have quite different lifetimes they each need to carry a reference to ib_device to protect against having it deleted out from under them. You suggest adding one more reference outside of the loop regardless of how many QPs, if any, belong to the multicast group. I don't see how this can be correct.
>
> In any case this is *not* the if statement that is under discussion in the patch. That one has to do with an error which can occur if the last QP in the list (which gets the original skb in the non-error case) doesn't match or isn't ready to receive the packet and it fails either check_type_state() or check_keys() and falls out of the loop. Now the reference to the ib_device needs to be let go and the skb needs to be freed but only if this error occurs. In the normal case that all happens when the skb if done being processed after calling rxe_rcv_pkt().
>
> So the discussion boils down to whether to type
>
> ...
> err1:
> 	kfree_skb(skb);
> 	if (unlikely(skb))
> 		ib_device_put(&rxe->ib_dev);
>
> or
>
> err1:
> 	if (unlikely(skb)) {
> 		kfree_skb(skb);
> 		ib_device_put(&rxe->ib_dev);
> 	}
>
> Here the normal non-error path has skb == NULL and the error path has skb set to the originally delivered packet. The second choice is much clearer as it shows the intent and saves the wasted trip to kfree_skb() for every packet.

Can you please configure your mail client so your replies won't be one
long unreadable lines? It will help us to read your replies and we will
be able to answer them separately.

Once the rxe_rcv_mcast_pkt() is called, the device and SKB are already
"connected" each one to another, so I don't understand the claims about
different lifetimes. It is not the "if ()", but the whole idea that every
SKB increments reference counter sounds very strange.

All QPs, mcast groups and SKB points to the same ib_dev and even one
refcount is enough to ensure that it won't vanish. This is why it is
enough to call ib_device_try_get() at the beginning of this function.

Also the combination of ib_device_get() together with unlikely() to save
kfree call can't be right either.

Thanks

>
> bob
