Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625323AE1C2
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 04:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhFUDBK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Jun 2021 23:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhFUDBK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Jun 2021 23:01:10 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA15C061574
        for <linux-rdma@vger.kernel.org>; Sun, 20 Jun 2021 19:58:55 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id s17so9599791oij.11
        for <linux-rdma@vger.kernel.org>; Sun, 20 Jun 2021 19:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QrjPxA/RcPV8xJsx9koNl5aT9CJl68Bx5MlSWxRwGsQ=;
        b=AVZ/oLEpZEKqW/0bkiyNc0F6y7M+HN0oHj9+ImlmZRv0MF0nQh/huT93KdIY27fS0j
         Li9ieIm3iof8cUYTL5vz8Z9oVhtCg4+eMlJmsdPA1rgTxOTZyGmUdgB/kFFNKNLPMxQr
         ORqVouXxmBP0EOR5X2FhhvcgfdEdpQSKQmf6fIHPZdbK0WCNE0BF9Cypi+eNArq89uH/
         XAN4DPA4t2hSdMUudb58h+BGBlc9ptLYnk4eZ6GVQnpf3kCvr+Ay2umaTHauZsBVLg+r
         UPb3FSUfruO3ubdj36Y692uwMWQBs8EGkbOrr7zTQUwgVYTcmLk0Hai7BnDSX09ST5Fb
         NASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QrjPxA/RcPV8xJsx9koNl5aT9CJl68Bx5MlSWxRwGsQ=;
        b=H7EqSgDRE2pQ5dYyM/Ahpb98ODBwxIO/EaCv21zfxsdo5YktxipCwIv0aNXpRXruik
         mWbPXjMbWeqiUewf+aBWXVQp07Kh4uZ+6IFki9GNx8ZLgAA8LTXg6LwHs+MgLkeFCaOV
         6uj6Qj6+Zi1Jp24K1MloYzUcaBi2Kg49CYFIXzQEuZD6p8Qnp9yF5ajBCVmIEBr/hyS0
         QqM3o485x2PYtjBT+yeOTrm+i9CKsOIWbmnhG4eXNrQgU46CT0LftCZ6U8KRsHS3cr9f
         oazRyT2m7qb0LP4gwVpW/d1+e/7BOM8V13H49nuwBGZtTY3FpWZrPdiMuABB+P+0UzHZ
         uyGg==
X-Gm-Message-State: AOAM532CrQF6D/FCr2ghFOvykHC9IVHm8nuOZOLPIZY9ajjaBXpOVHzb
        38lN75TjZXMcJGlpCbidQsn1MXmwsLORWusUepI=
X-Google-Smtp-Source: ABdhPJw9Laz1wu3wiGnCXptBi9KvZD6yN8fL1dM2fm6W51UZAWO7gUiXkiVZeoRbIl7p9ofTaKamkfWhDoLuyX/0yTg=
X-Received: by 2002:aca:a9c9:: with SMTP id s192mr21963424oie.163.1624244335260;
 Sun, 20 Jun 2021 19:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210618045742.204195-1-rpearsonhpe@gmail.com>
 <20210618045742.204195-7-rpearsonhpe@gmail.com> <CAD=hENfOFHUrSFws0ipYmrcQ803uFNmK9rPNLt-hPWpXndsLSQ@mail.gmail.com>
 <4ecf3073-b107-03cf-2072-e9d0f8cbff44@gmail.com> <CAD=hENdbzWgCfV3fwi7iJUGMTqzq1Ocukk_krbGiPQVi-7EP6Q@mail.gmail.com>
 <5c6fcd23-b508-18d6-69b4-d446def47a0a@gmail.com>
In-Reply-To: <5c6fcd23-b508-18d6-69b4-d446def47a0a@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 21 Jun 2021 10:58:44 +0800
Message-ID: <CAD=hENeARoiiVFWHGqP2HV_t7dFJHQeUL=3=uh6XM3mdVfUHRg@mail.gmail.com>
Subject: Re: [PATCH for-next 6/6] RDMA/rxe: Fix redundant skb_put_zero
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 21, 2021 at 4:21 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> On 6/20/21 9:07 AM, Zhu Yanjun wrote:
> > On Fri, Jun 18, 2021 at 11:32 PM Bob Pearson <rpearsonhpe@gmail.com> wr=
ote:
> >>
> >> On 6/18/21 3:02 AM, Zhu Yanjun wrote:
> >>> On Fri, Jun 18, 2021 at 1:00 PM Bob Pearson <rpearsonhpe@gmail.com> w=
rote:
> >>>>
> >>>> rxe_init_packet() in rxe_net.c calls skb_put_zero() to reserve space
> >>>> for the payload and zero it out. All these bytes are then re-written
> >>>> with RoCE headers and payload. Remove this useless extra copy.
> >>>
> >>> The paylen seems to be a variable, that is, the length of pkt->hdr is=
 not fixed.
> >>>
> >>> Can you confirm that all the pkt->hdr are re-writtenwith RoCE headers
> >>> and payload?
> >>
> >> Yes. rxe_init_packet() is called twice, once from rxe_req.c for reques=
t packets and once from rxe_resp.c for response packets.
> >> In rxe_req.c in init_req_packet() paylen is set to
> >>
> >>     paylen =3D rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SI=
ZE
> >>
> >> which is the correct size of the packet from the UDP header to the fra=
me FCS i.e. the UDP payload. rxe_opcode[opcode] is a table that includes th=
e length of the all the RoCE headers for a given opcode which does vary. Pa=
yload is the RoCE payload and pad is the number of pad bytes required to ex=
tend the payload to a multiple of 4 bytes. RXE_ICRC_SIZE is the 4 bytes for=
 the RoCE invariant CRC. It requires some checking but all the headers are =
fully written, the payload is fully copied from the client and the pad and =
ICRC bytes are also written. In rxe_resp.c paylen is set to the same value.
> >
> > Too complicated assignment.
> > So I prefer to skb_put_zero.
>
> My goal here is to improve the performance of rxe. This one line adds an =
extra memory copy on every sent message. Without the skb_put_zero it passes=
 all the tests and works correctly. What are you worried about exactly?

Please show us the performance data.

Thanks
Zhu Yanjun

>
> Bob
> >
> > Zhu Yanjun
> >>
> >> There are two potential issues here 1) Is the intended packet sent to =
the destination, and 2) is there a possibility that information can leak fr=
om the kernel to the outside. The above addresses 1). 2) requires the assum=
ption that the NIC is not examining data outside of the proper data area in=
 the skb and doing something with it. But you have a worse problem there si=
nce the NIC has DMA access to all of kernel memory and can send any packet =
it likes.
> >>
> >> Bob Pearson
> >>
> >>> Zhu Yanjun
> >>>
> >>>>
> >>>> Fixes: ecb238f6a7f3 ("IB/cxgb4: use skb_put_zero()/__skb_put_zero")
> >>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >>>> ---
> >>>>  drivers/infiniband/sw/rxe/rxe_net.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniban=
d/sw/rxe/rxe_net.c
> >>>> index 178a66a45312..6605ee777667 100644
> >>>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> >>>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> >>>> @@ -470,7 +470,7 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *=
rxe, struct rxe_av *av,
> >>>>
> >>>>         pkt->rxe        =3D rxe;
> >>>>         pkt->port_num   =3D port_num;
> >>>> -       pkt->hdr        =3D skb_put_zero(skb, paylen);
> >>>> +       pkt->hdr        =3D skb_put(skb, paylen);
> >>>>         pkt->mask       |=3D RXE_GRH_MASK;
> >>>>
> >>>>  out:
> >>>> --
> >>>> 2.30.2
> >>>>
> >>
>
