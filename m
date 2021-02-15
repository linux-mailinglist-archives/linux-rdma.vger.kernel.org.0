Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F188531B555
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Feb 2021 07:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhBOF74 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Feb 2021 00:59:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhBOF74 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 15 Feb 2021 00:59:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03F5E64DF0;
        Mon, 15 Feb 2021 05:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613368755;
        bh=EonwgAHrRanf76J8ZfBEbPw7uCyuCYF12uyxcrwu5zU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QeN/Tor2NB/TNcKIdHn0tpVnmh2qpt70kgqeOJ+eVPlFj+cmhPylAXlD/mUxc0bF2
         Ru90oTOTQAU57L8eYtWTpoxts1828LDdZ/nE/YLgKqJz2rsce+xinWv/JI5tPpY0SP
         ySJq7k7EgzkO888ySLWkPaJuZEpM+qB/I6vo2p9dJ7Um6yq7+VFFRG8WgPAwYRD3du
         BUtlhCWOCR6Piw8PsSIXukYuas7zMib8Fp3w1JbeftwZCtkVDUDtBNw34HECKXeVj0
         eXrBYkEzBELGlRqknZ/vrE+2KXLNRi2NPCviWG1WIJGLcbc7WeFT0wJIAo0zaUnFZK
         wfQwE15DMpmSQ==
Date:   Mon, 15 Feb 2021 07:59:11 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix ib_device reference counting
 (again)
Message-ID: <YCoNr/GmLREWUlf0@unreal>
References: <20210214222630.3901-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210214222630.3901-1-rpearson@hpe.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Feb 14, 2021 at 04:26:31PM -0600, Bob Pearson wrote:
> Three errors occurred in the fix referenced below.
>
> 1) The on and off again 'if (skb)' got dropped but was really
> needed in rxe_rcv_mcast_pkt() to prevent calling ib_device_put()
> on the non-error path.
>
> 2) Extending the reference taken by rxe_get_dev_from_net() in
> rxe_udp_encap_recv() until each skb is freed was not matched by
> a reference in the loopback path resulting in underflows.
>
> 3) In rxe_comp.c the function free_pkt() did not clear skb which
> triggered a warning at done: and could possibly at exit: in
> rxe_completer(). The WARN_ONCE() calls are not required at done:
> and only in one place before going to exit.
>
> This patch fixes these errors.
>
> Fixes: 899aba891cab ("RDMA/rxe: Fix FIXME in rxe_udp_encap_recv()")
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_comp.c | 5 +++--
>  drivers/infiniband/sw/rxe/rxe_net.c  | 7 ++++++-
>  drivers/infiniband/sw/rxe/rxe_recv.c | 6 ++++--
>  3 files changed, 13 insertions(+), 5 deletions(-)


diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 8a48a33d587b..29cb0125e76f 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -247,6 +247,11 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 	else if (skb->protocol == htons(ETH_P_IPV6))
 		memcpy(&dgid, &ipv6_hdr(skb)->daddr, sizeof(dgid));

+	if (!ib_device_try_get(&rxe->ib_dev)) {
+		kfree_skb(skb);
+		return;
+	}
+
 	/* lookup mcast group corresponding to mgid, takes a ref */
 	mcg = rxe_pool_get_key(&rxe->mc_grp_pool, &dgid);
 	if (!mcg)
@@ -274,10 +279,6 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 		 */
 		if (mce->qp_list.next != &mcg->qp_list) {
 			per_qp_skb = skb_clone(skb, GFP_ATOMIC);
-			if (WARN_ON(!ib_device_try_get(&rxe->ib_dev))) {
-				kfree_skb(per_qp_skb);
-				continue;
-			}
 		} else {
 			per_qp_skb = skb;
 			/* show we have consumed the skb */
