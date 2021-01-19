Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A852FB898
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 15:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391379AbhASNRj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 08:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392509AbhASMLT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jan 2021 07:11:19 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8C9C0613CF
        for <linux-rdma@vger.kernel.org>; Tue, 19 Jan 2021 04:10:39 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id a109so19571558otc.1
        for <linux-rdma@vger.kernel.org>; Tue, 19 Jan 2021 04:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rvLcj47wbvsEM4oNtyLyL1A/ZhjZDK7riJI3XfjoYYI=;
        b=PVfLutae93zyGj7b+TtlfW8z+EEXJ4TdGunEjDjKjTshN7SEFvLNbXr5B8r4A7F0vo
         HwlaSOOrocwE5YMAFyeLD/BeUle8TLAYU4lkxBcP0d7PvExwXyDUGUY+e1jsCR3DC1bG
         dtOtD8VUZ6rXSojzxyU7oeFtiU0vE8Aj7GO/8nKeKuyv6+FlV81ZtPka5gI+AvcQiW1L
         sWLj1j4J2J22GwwIc9g+gLq+2O0dujwu3pDFUO101aOjwpR+SAQAPVPiX8t3FKYp8BK0
         QGV/2/JgI295eBs4dntwTlEdgk3/xx69zt0ao5dtSTh72nHUAsVwQ7JLMdI63uX8pwWt
         ufhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rvLcj47wbvsEM4oNtyLyL1A/ZhjZDK7riJI3XfjoYYI=;
        b=YZwCxdMoRkeeigLzH77xg52rXkk3RDjjxRJ9hE6fqshNi++4OVApnN1kMMvYn63A+r
         +pnbtz+fa3W7TEPay/Q4slZDICFAkOCXTFOiI4ptvuEv1NsN13Ge/9y43HKc72kBcp/W
         MVxWHvH5/MoFReRjSa+8QoAxOlzQrXNTZFeqlgAAnIRc5WPiSa6VtdmomndrtcuKLXGJ
         1P/Yxi5HsKyWBGsZFQOSMFp4dJ0WJb/xLyugIfQneEw9TByExwYP7NYi0YAxalJ9cHyd
         ylrSfec14y3hN56pBKSmXg5qZwEa4wshLKQOveIAWrDr5EQUv6XNls8iFh6V3yaPSwfm
         7V0w==
X-Gm-Message-State: AOAM532qJkLjxBhhOZLPaqp9VbOURxuBAZcjrfnF844gFnUdCRrZXdm0
        +6DUEYR+EyijSE8t0j+/aDFQ1U9ywWJvLXuIljE/R1VdwvE=
X-Google-Smtp-Source: ABdhPJymo8PGkgKHzs4nHpPvfmL+BcdywmtwamuJeDAGf+YnfhSZaeTtKH3RFWGKuENzdqOMDclCbSmCoX1Avwf4ZTM=
X-Received: by 2002:a05:6830:3482:: with SMTP id c2mr3237793otu.59.1611058238679;
 Tue, 19 Jan 2021 04:10:38 -0800 (PST)
MIME-Version: 1.0
References: <20210119105644.2658-1-mwilck@suse.com>
In-Reply-To: <20210119105644.2658-1-mwilck@suse.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 19 Jan 2021 20:10:27 +0800
Message-ID: <CAD=hENfrUJGeUGUfb6t6o3d8J_5ONMPfx3Gae8=xwrhq0DBKwg@mail.gmail.com>
Subject: Re: [PATCH] Revert "RDMA/rxe: Remove VLAN code leftovers from RXE"
To:     mwilck@suse.com
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mohammad Heib <goody698@gmail.com>,
        Vijay Immanuel <vijayi@attalasystems.com>,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 19, 2021 at 6:57 PM <mwilck@suse.com> wrote:
>
> From: Martin Wilck <mwilck@suse.com>
>
> This reverts commit b2d2440430c0fdd5e0cad3efd6d1c9e3d3d02e5b.
>
> It's true that creating rxe on top of 802.1q interfaces doesn't work.
> Thus, commit fd49ddaf7e26 ("RDMA/rxe: prevent rxe creation on top of vlan interface")
> was absolutely correct.
>
> But b2d2440430c0 was incorrect assuming that with this change,
> RDMA and VLAN don't work togehter at all. It just has to be
> set up differently. Rather than creating rxe on top of the VLAN
> interface, rxe must be created on top of the physical interface.
> RDMA then works just fine through VLAN interfaces on top of that
> physical interface, via the "upper device" logic.

I read this commit log for several times. I can not get you.
Can you show me by an example?

Zhu Yanjun

>
> I've tested this mainly with NVMe over RDMA and rping, but I don't
> see why it wouldn't work just as well for other protocols. If there
> are real issues, I'd like to know.
>
> b2d2440430c0 broke this setup deliberately and should thus be
> reverted.
>
> Fixes: b2d2440430c0 ("RDMA/rxe: Remove VLAN code leftovers from RXE")
>
> Cc: Zhu Yanjun <zyjzyj2000@gmail.com>
> Cc: Mohammad Heib <goody698@gmail.com>
> Cc: Vijay Immanuel <vijayi@attalasystems.com>
> Cc: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
> Signed-off-by: Martin Wilck <mwilck@suse.com>
>
> ---
> Note: I'm currently not subscribed to linux-rdma.
>
> ---
>  drivers/infiniband/sw/rxe/rxe_net.c  | 18 ++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_resp.c |  5 +++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index c4b06ced30a7..34bef7d8e6b4 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -8,6 +8,7 @@
>  #include <linux/if_arp.h>
>  #include <linux/netdevice.h>
>  #include <linux/if.h>
> +#include <linux/if_vlan.h>
>  #include <net/udp_tunnel.h>
>  #include <net/sch_generic.h>
>  #include <linux/netfilter.h>
> @@ -19,6 +20,18 @@
>
>  static struct rxe_recv_sockets recv_sockets;
>
> +struct device *rxe_dma_device(struct rxe_dev *rxe)
> +{
> +       struct net_device *ndev;
> +
> +       ndev = rxe->ndev;
> +
> +       if (is_vlan_dev(ndev))
> +               ndev = vlan_dev_real_dev(ndev);
> +
> +       return ndev->dev.parent;
> +}
> +
>  int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
>  {
>         int err;
> @@ -153,9 +166,14 @@ static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
>  {
>         struct udphdr *udph;
>         struct net_device *ndev = skb->dev;
> +       struct net_device *rdev = ndev;
>         struct rxe_dev *rxe = rxe_get_dev_from_net(ndev);
>         struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
>
> +       if (!rxe && is_vlan_dev(rdev)) {
> +               rdev = vlan_dev_real_dev(ndev);
> +               rxe = rxe_get_dev_from_net(rdev);
> +       }
>         if (!rxe)
>                 goto drop;
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 5a098083a9d2..c7e3b6a4af38 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -872,6 +872,11 @@ static enum resp_states do_complete(struct rxe_qp *qp,
>                         else
>                                 wc->network_hdr_type = RDMA_NETWORK_IPV6;
>
> +                       if (is_vlan_dev(skb->dev)) {
> +                               wc->wc_flags |= IB_WC_WITH_VLAN;
> +                               wc->vlan_id = vlan_dev_vlan_id(skb->dev);
> +                       }
> +
>                         if (pkt->mask & RXE_IMMDT_MASK) {
>                                 wc->wc_flags |= IB_WC_WITH_IMM;
>                                 wc->ex.imm_data = immdt_imm(pkt);
> --
> 2.29.2
>
