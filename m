Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494EA327865
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Mar 2021 08:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhCAHmQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Mar 2021 02:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhCAHmE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Mar 2021 02:42:04 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93467C061786
        for <linux-rdma@vger.kernel.org>; Sun, 28 Feb 2021 23:42:50 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id d9so15552866ote.12
        for <linux-rdma@vger.kernel.org>; Sun, 28 Feb 2021 23:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JwnvZBaeYdZxqvTIAy768N5ZmX/7eWn11v/aHyKaP1U=;
        b=q6kYnTnrhP3XLfvxdAC4r4WExE9B5BpHEkAJBe7hLDA3F6puMTV6vwL8LVkBBR4H+G
         9yBLHjqtCQwMiRIVabecLvSV59s4EiXSqHsMWoytusgedprV5pvY0991P71tVcqhwSAz
         ZCLK51xWhwzGvFk4sclChhumaqxnm0Tziromq7B3w2vNdbiLt+YPvv8RdggP8Zsqf/E3
         y5HVig1qnibuTPbCS2fkxcQfbKNech0uwTQj1FEg/XdyL3ZxPtXuP9E9aqrKSkGNGaf5
         ZjnmL+3/NB1IDNZIRisk4DscLEn2FWhofWFMPfhRinBIF00hSD6vapEsHSq4n7Oc4pan
         I2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JwnvZBaeYdZxqvTIAy768N5ZmX/7eWn11v/aHyKaP1U=;
        b=R/t+ccvQt790gKDwnPLVCu226zKq6phXV1S65xpXb19920ENBPE5X8ph20sjaw7J/Y
         H7dlf+kGElodb47h+Gm1cZq/p5rUg6GUNjJTVNGM21r7NLbV3T5uKl2i7eoXLGeGp0Vu
         Go2Wi7vxBONdcNMJvlrAIjandq1dSjDu+ujtZhaRf1f6o70kmF8+ffQMLCjaQ9avUMsi
         CC4lohbRXD2EuOMaFYMG0yYFMLZ3xWOWXVA6+aOBcsq6VcVqnlGPhoAJ72hurXxK3vvC
         WpNuJPf4R6iPDY/nnWjf9YG1lQ6PR4ZD4dg2TbckJCQkzWQJe3RXnS7iSmjX6/BPabsp
         Qt4A==
X-Gm-Message-State: AOAM531sMBBGdsmayXiy1bH4loVQbNCciyzEcB7rwLwIZp8L0evUwTB6
        +rNzY0hHhVHffwNlsIwe1mW+LJxSAk7kEt9S/lA=
X-Google-Smtp-Source: ABdhPJzTBuSqF3kp8+y4yNlANSGCKJ8iDeGL1C0vYQUWEtiaVIiagM15SToY/pFxUkzuWoFnDy+BcuV4uBzJX/U3yQg=
X-Received: by 2002:a05:6830:130d:: with SMTP id p13mr12516380otq.53.1614584569971;
 Sun, 28 Feb 2021 23:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20210214222630.3901-1-rpearson@hpe.com> <48dcbdc5-35a3-2fe3-3e3d-bff37c2d8053@gmail.com>
 <20210226233301.GA4247@nvidia.com> <3165add7-518d-9485-fa12-6d7822ed9165@gmail.com>
 <YDoGJIcB6SB/7LPj@unreal> <db406802-25a8-bda8-6add-4b75057eec96@gmail.com>
In-Reply-To: <db406802-25a8-bda8-6add-4b75057eec96@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 1 Mar 2021 15:42:39 +0800
Message-ID: <CAD=hENdKVD_HUaauXp5ObOuGuL_h8YSG2zsK5sZ9fsp81iraGw@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix ib_device reference counting (again)
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Frank Zago <frank.zago@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 1, 2021 at 1:04 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
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
> >>> https://patchwork.kernel.org/project/linux-rdma/patch/20210214222630.=
3901-1-rpearson@hpe.com/
> >>>
> >>> Jason
> >>>
> >> OK. I see. I agreed to that complaint when the kfree was the only thin=
g in the if {} but now I have to call ib_device_put() *only* in the error c=
ase not if there wasn't an error. So no reason to not put the kfree_skb() i=
n there too and avoid passing a NULL pointer. It should stay the way it is.
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
> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw=
/rxe/rxe_recv.c
> index 8a48a33d587b..29cb0125e76f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> @@ -247,6 +247,11 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, s=
truct sk_buff *skb)
>         else if (skb->protocol =3D=3D htons(ETH_P_IPV6))
>                 memcpy(&dgid, &ipv6_hdr(skb)->daddr, sizeof(dgid));
>
> +       if (!ib_device_try_get(&rxe->ib_dev)) {
> +               kfree_skb(skb);
> +               return;
> +       }
> +
>         /* lookup mcast group corresponding to mgid, takes a ref */
>         mcg =3D rxe_pool_get_key(&rxe->mc_grp_pool, &dgid);
>         if (!mcg)
> @@ -274,10 +279,6 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, s=
truct sk_buff *skb)
>                  */
>                 if (mce->qp_list.next !=3D &mcg->qp_list) {
>                         per_qp_skb =3D skb_clone(skb, GFP_ATOMIC);
> -                       if (WARN_ON(!ib_device_try_get(&rxe->ib_dev))) {
> -                               kfree_skb(per_qp_skb);
> -                               continue;
> -                       }
>                 } else {
>                         per_qp_skb =3D skb;
>                         /* show we have consumed the skb */
> ...
>
> which I don't understand.
>
> When a received packet is delivered to the rxe driver in rxe_net.c in rxe=
_udp_encap_recv() rxe_get_dev_from_net() is called which gets a pointer to =
the ib_device (contained in rxe_dev) and also takes a reference on the ib_d=
evice. This pointer is stored in skb->cb[] so the reference needs to be hel=
d until the skb is freed. If the skb has a multicast address and there are =
more than one QPs belonging to the multicast group then new skbs are cloned=
 in rxe_rcv_mcast_pkt() and each has a pointer to the ib_device. Since each=
 skb can have quite different lifetimes they each need to carry a reference=
 to ib_device to protect against having it deleted out from under them. You=
 suggest adding one more reference outside of the loop regardless of how ma=
ny QPs, if any, belong to the multicast group. I don't see how this can be =
correct.
>
> In any case this is *not* the if statement that is under discussion in th=
e patch. That one has to do with an error which can occur if the last QP in=
 the list (which gets the original skb in the non-error case) doesn't match=
 or isn't ready to receive the packet and it fails either check_type_state(=
) or check_keys() and falls out of the loop. Now the reference to the ib_de=
vice needs to be let go and the skb needs to be freed but only if this erro=
r occurs. In the normal case that all happens when the skb if done being pr=
ocessed after calling rxe_rcv_pkt().
>
> So the discussion boils down to whether to type
>
> ...
> err1:
>         kfree_skb(skb);
>         if (unlikely(skb))
>                 ib_device_put(&rxe->ib_dev);
>
> or
>
> err1:
>         if (unlikely(skb)) {
>                 kfree_skb(skb);
>                 ib_device_put(&rxe->ib_dev);
>         }
>
> Here the normal non-error path has skb =3D=3D NULL and the error path has=
 skb set to the originally delivered packet. The second choice is much clea=
rer as it shows the intent and saves the wasted trip to kfree_skb() for eve=
ry packet.

Placing kfree_skb in a if (skb) test is not good.

Zhu Yanjun
>
> bob
