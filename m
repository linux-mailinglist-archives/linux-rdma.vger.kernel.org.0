Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F79401882
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Sep 2021 11:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240302AbhIFJAq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Sep 2021 05:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbhIFJAq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Sep 2021 05:00:46 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9E5C061575;
        Mon,  6 Sep 2021 01:59:41 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id i3-20020a056830210300b0051af5666070so8010995otc.4;
        Mon, 06 Sep 2021 01:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LqSLG5ZPk91B6JFp4r8jCHL8UoHhs5q40yu5Rw5etOk=;
        b=DmBW5CBlkPnwghvjY/YpusahPPK+YQAIw8STwr2hveBuKcxO5oEQt0paIOOBVNmEuF
         Pv8X1l5o3YNxmIhiLPbU8ygcp+67EWv7d+2ox0EAxSFttIPKg2GWuB5lyg6OodD3YDT1
         KrcqtVcxLwYODgNCYChPPoHsSAenrFYbdBMnBy2bgMsTa28ro1v84m8x/SuNipXUBZCA
         S4Zz+VDCLgqT2P8/iGuWP4U2ZYt0DnjSAFxj+DTFV4wILTVvAmSvvRhBXCG4EZ+/1vKR
         2JeSp+zW02WmlySUlEoN3m8K4u8TLyKAobcQCp3vd76mKIu4SNFW3xD5+zV7Mb7OR//c
         e0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LqSLG5ZPk91B6JFp4r8jCHL8UoHhs5q40yu5Rw5etOk=;
        b=EMp/WALd6sRcdonpXYr9ag8Mo+6pvUbwXFpPNFXy1puw7+sWt8yJpXIPbq8SZM2q+R
         BbCJM/jKANp/di2bobQUD/m1wzIuyKxAAI+BiMZgI92pUG0mIQcSZD4YeKNsYYR7PHmJ
         iY9mA+PyG1aMroIXU1TMoHfk9IKkGG/gCOuGf05KBZ/4VmOfWBYRrK4Wx4LCIqn28wJv
         akdM2ra9nHDn8dNl7ogqn6T50aft+q8wsRcPEEUt/njYmhDxaXu6i8R+H16n5PYWnItf
         /2D4dufUaQMrZO0gvkC5Ah4w6lwW6pbi0VwQTK2XRIooburEFXi2zbxUBiI+D7Vt1DMG
         cMnA==
X-Gm-Message-State: AOAM5304OGgButepkQnPSQyldx1K/viW6Y0ysSIqkRbALq1jNPNLd6A+
        3TC5ubd/K5k5BP+JSABfqfu/1ycdJzIH9WLeH5Y=
X-Google-Smtp-Source: ABdhPJwN2Wjmz82MULF0kH4slO0/rDJQhPy1RUKF80i+AkY2kLaUqMejCYUun2pokWu7bQydtmN9oqsPIml6EjGMxF0=
X-Received: by 2002:a05:6830:2904:: with SMTP id z4mr10303034otu.121.1630918781240;
 Mon, 06 Sep 2021 01:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210831083223.65797-1-weijunji@bytedance.com>
 <CAD=hENcbvs3_Mu7tjTPfrj8h1xTDb03y-5bACU3cckOpmPJveg@mail.gmail.com> <DB1899F3-88A0-44A2-8F44-A380D625A98F@bytedance.com>
In-Reply-To: <DB1899F3-88A0-44A2-8F44-A380D625A98F@bytedance.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 6 Sep 2021 16:59:30 +0800
Message-ID: <CAD=hENdGj2EkazVRRj3H-bO0psCAEVvTF-iEhaRTXS_KNf2Bkg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Fix wrong port_cap_flags
To:     Junji Wei <weijunji@bytedance.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, xieyongji@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 6, 2021 at 3:53 PM Junji Wei <weijunji@bytedance.com> wrote:
>
>
> > On Sep 6, 2021, at 3:21 PM, Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
> >
> > On Tue, Aug 31, 2021 at 4:32 PM Junji Wei <weijunji@bytedance.com> wrot=
e:
> >>
> >> The port->attr.port_cap_flags should be set to enum
> >> ib_port_capability_mask_bits in ib_mad.h,
> >> not RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP.
> >>
> >> Signed-off-by: Junji Wei <weijunji@bytedance.com>
> >> ---
> >> drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniban=
d/sw/rxe/rxe_param.h
> >> index 742e6ec93686..b5a70cbe94aa 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_param.h
> >> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> >> @@ -113,7 +113,7 @@ enum rxe_device_param {
> >> /* default/initial rxe port parameters */
> >> enum rxe_port_param {
> >>        RXE_PORT_GID_TBL_LEN            =3D 1024,
> >> -       RXE_PORT_PORT_CAP_FLAGS         =3D RDMA_CORE_CAP_PROT_ROCE_UD=
P_ENCAP,
> >> +       RXE_PORT_PORT_CAP_FLAGS         =3D IB_PORT_CM_SUP,
> >
> > RXE_PORT_PORT_CAP_FLAGS         =3D IB_PORT_CM_SUP |
> > RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP,
> >
> > Is it better?
> >
> > Zhu Yanjun
>
> I don=E2=80=99t think so.
>
> Because RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP(0x800000)
> means IB_PORT_BOOT_MGMT_SUP(1 << 23) in ib_mad.h.
> RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP should be used for
> port=E2=80=99s core_cap_flags.

Sure. Thanks

Zhu Yanjun

>
> >
> >>        RXE_PORT_MAX_MSG_SZ             =3D 0x800000,
> >>        RXE_PORT_BAD_PKEY_CNTR          =3D 0,
> >>        RXE_PORT_QKEY_VIOL_CNTR         =3D 0,
> >> --
> >> 2.30.1 (Apple Git-130)
> >>
>
