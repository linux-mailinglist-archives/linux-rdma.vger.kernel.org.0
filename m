Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F303ADEF8
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jun 2021 16:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhFTOJd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Jun 2021 10:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhFTOJd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Jun 2021 10:09:33 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74768C061574
        for <linux-rdma@vger.kernel.org>; Sun, 20 Jun 2021 07:07:19 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id m137so16965897oig.6
        for <linux-rdma@vger.kernel.org>; Sun, 20 Jun 2021 07:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4SlhO1PvuF2dcc2VOREqy44XyEkIxK8ONyNilvW9yGU=;
        b=OR11mr8aKLnGUO8WaFvUwc4kdbMOAtHTQbyaIHM3LFElwHe1Zh/e78ejyAXE0dGvlU
         WhKpswoUk231FidNIfH3wRBBkVQyJ7A9Wjxiz5RbPOAe85RPJyCDMB4QGc7z4IKQxc5P
         7JqSVYTr8ogrdhWsxtZqLV7g8JPf7T83oOc5MywB4O/3bS9oxBYGRAIWdFKQYX5Z3smR
         dQMVUZa47K2hBTj+fW5iDi45Ec5oSE4rk0z1XF3Ky98NfYO7SxWV+QfjbTuq5whzLR5X
         +mBpGS6+OYuIHTZhJVqibYPsc6pjYES1tn4AgKX1EMufT29jiHgeOP1ZMS4iglwlSYT8
         9vlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4SlhO1PvuF2dcc2VOREqy44XyEkIxK8ONyNilvW9yGU=;
        b=ZH1uetXOwOaXGM8w7m8Ea9k6j/KLyObjFOET7i2clXDeM/hY4cIpFnRT8Y4Jqc7zAe
         8B0QzVfJMGFLKogApXuiqsN4KiwICHFRUjwxwYBb8VsKNTIP1wDSgCZFSMN912MglqRO
         Ym/tUQw0CKh69D3yEHwoNKmRA43StPRK4bFLttVDPQK1MTu2xNlxKWdAaW7VVe/QDFf+
         dr1jQQcy/KWD53zZU4eeoVasw5buuH/bWCUSvYSy9DvHiclhEpQM+tMqPuiapiIs4PLY
         QWLoO4AKgGGdSlFc8vbIazz5jEgTmqwRucVokXZMaxRCZGu363W/kX9NKG0s/IJ/GKwX
         4SQQ==
X-Gm-Message-State: AOAM5316LvmZNB0J50FoamNWk+k+vQTTigmZRdoT5XYanKzyQJycrtO9
        pwqCD9HE5GFzNtEd3w8n4811rfXjnMFvrIDj+eg=
X-Google-Smtp-Source: ABdhPJyRt1d2dJbVQhQ6zqesAglkURYhnxAP6pOw9msMKQBSBJ0+AoRUJMkkjQWnC0G+z4AMO10mf2rRxJCpN4f/AeQ=
X-Received: by 2002:a54:400c:: with SMTP id x12mr20831463oie.89.1624198038891;
 Sun, 20 Jun 2021 07:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210618045742.204195-1-rpearsonhpe@gmail.com>
 <20210618045742.204195-7-rpearsonhpe@gmail.com> <CAD=hENfOFHUrSFws0ipYmrcQ803uFNmK9rPNLt-hPWpXndsLSQ@mail.gmail.com>
 <4ecf3073-b107-03cf-2072-e9d0f8cbff44@gmail.com>
In-Reply-To: <4ecf3073-b107-03cf-2072-e9d0f8cbff44@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sun, 20 Jun 2021 22:07:07 +0800
Message-ID: <CAD=hENdbzWgCfV3fwi7iJUGMTqzq1Ocukk_krbGiPQVi-7EP6Q@mail.gmail.com>
Subject: Re: [PATCH for-next 6/6] RDMA/rxe: Fix redundant skb_put_zero
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 18, 2021 at 11:32 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> On 6/18/21 3:02 AM, Zhu Yanjun wrote:
> > On Fri, Jun 18, 2021 at 1:00 PM Bob Pearson <rpearsonhpe@gmail.com> wro=
te:
> >>
> >> rxe_init_packet() in rxe_net.c calls skb_put_zero() to reserve space
> >> for the payload and zero it out. All these bytes are then re-written
> >> with RoCE headers and payload. Remove this useless extra copy.
> >
> > The paylen seems to be a variable, that is, the length of pkt->hdr is n=
ot fixed.
> >
> > Can you confirm that all the pkt->hdr are re-writtenwith RoCE headers
> > and payload?
>
> Yes. rxe_init_packet() is called twice, once from rxe_req.c for request p=
ackets and once from rxe_resp.c for response packets.
> In rxe_req.c in init_req_packet() paylen is set to
>
>     paylen =3D rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE
>
> which is the correct size of the packet from the UDP header to the frame =
FCS i.e. the UDP payload. rxe_opcode[opcode] is a table that includes the l=
ength of the all the RoCE headers for a given opcode which does vary. Paylo=
ad is the RoCE payload and pad is the number of pad bytes required to exten=
d the payload to a multiple of 4 bytes. RXE_ICRC_SIZE is the 4 bytes for th=
e RoCE invariant CRC. It requires some checking but all the headers are ful=
ly written, the payload is fully copied from the client and the pad and ICR=
C bytes are also written. In rxe_resp.c paylen is set to the same value.

Too complicated assignment.
So I prefer to skb_put_zero.

Zhu Yanjun
>
> There are two potential issues here 1) Is the intended packet sent to the=
 destination, and 2) is there a possibility that information can leak from =
the kernel to the outside. The above addresses 1). 2) requires the assumpti=
on that the NIC is not examining data outside of the proper data area in th=
e skb and doing something with it. But you have a worse problem there since=
 the NIC has DMA access to all of kernel memory and can send any packet it =
likes.
>
> Bob Pearson
>
> > Zhu Yanjun
> >
> >>
> >> Fixes: ecb238f6a7f3 ("IB/cxgb4: use skb_put_zero()/__skb_put_zero")
> >> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >> ---
> >>  drivers/infiniband/sw/rxe/rxe_net.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/=
sw/rxe/rxe_net.c
> >> index 178a66a45312..6605ee777667 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> >> @@ -470,7 +470,7 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rx=
e, struct rxe_av *av,
> >>
> >>         pkt->rxe        =3D rxe;
> >>         pkt->port_num   =3D port_num;
> >> -       pkt->hdr        =3D skb_put_zero(skb, paylen);
> >> +       pkt->hdr        =3D skb_put(skb, paylen);
> >>         pkt->mask       |=3D RXE_GRH_MASK;
> >>
> >>  out:
> >> --
> >> 2.30.2
> >>
>
