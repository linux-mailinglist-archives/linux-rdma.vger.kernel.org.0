Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3790401753
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Sep 2021 09:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbhIFHyh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Sep 2021 03:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbhIFHyg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Sep 2021 03:54:36 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53819C061575
        for <linux-rdma@vger.kernel.org>; Mon,  6 Sep 2021 00:53:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so3783690pjr.1
        for <linux-rdma@vger.kernel.org>; Mon, 06 Sep 2021 00:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rlaLLiMPNdX6nNJMxLikoTvHO7/HZLWVppl3vRWfr5k=;
        b=BtRbsXztmfeZlr2eUdjZKt9p9ijpkUx2lzClwVoY2p+cL5DtkINv+VBUC5HA/0cC9U
         D+V/ARnbijw3EDe9D/Izm9eF4TSs48nFdOzd7Dzb0DRdEDzMvrilQT/45YqLDvI/KZm3
         EKIZbEdYvh+6Q8g9b1LVCi46LqynSrdTq3gKN8T41M+M/8AHFRhEeMxhcpCke0jqb8hl
         HmprZ8o2b/bicn7KWMqYz2cIWuUquUsmouoVYz/0ODP0ca6tXyD6CKjaHIW9UiIxQ3iF
         bgGeWnoEIkP+G0lZh7l4+wWcJPj24POIMG/kb/ORG7yh4+pOOhUgnLL9Z/sW/Xn4row+
         cddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rlaLLiMPNdX6nNJMxLikoTvHO7/HZLWVppl3vRWfr5k=;
        b=UWctDB5CENpMhmG2BwkDgxhFzqas7Ucd1SR6hsZcOHHhftGE5JOdptJwc5rJK3G/Ar
         yisg34rW55FvFiI5l9PEnJnjct68bBI+fbz+IH0/yxJjIs0BSSLZZv1rn/feaGnEY1F7
         4f1rtOevqSxbPE4EtsT/Fm4+3ij6Yb9MkvJoagidac8C7pWRmFdRtlyOywcLQAEoFlgm
         iyQLb00dVOQT446N1OW+IegrWG70W6CCLDRNup1mDWvYk7FSP8PNJdRGfGoCwybSYFED
         3tVBD8o12owM1Cyp8pioPzf+zmFLVNRj12dKMra7Xfs6H4KVZMPplWfZTiLr/pm5PIIc
         ++Pg==
X-Gm-Message-State: AOAM530hKg85fHP3AXTuFwVVlafvfMnT3DoGlHIKV2Ad9TUkCxnOu2IU
        hle+b7jz9EfNarExVnwilSsRlg==
X-Google-Smtp-Source: ABdhPJxa7VODnGLnMj+iLcEo8Wj2OTDHWE5rnzJIJ+Lx07zI/gpZnKfxGEBWVVe5i46jYcdr7xG+3g==
X-Received: by 2002:a17:90b:105:: with SMTP id p5mr12902957pjz.183.1630914811820;
        Mon, 06 Sep 2021 00:53:31 -0700 (PDT)
Received: from smtpclient.apple ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id g11sm7027760pgn.41.2021.09.06.00.53.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Sep 2021 00:53:31 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: [PATCH] RDMA/rxe: Fix wrong port_cap_flags
From:   Junji Wei <weijunji@bytedance.com>
In-Reply-To: <CAD=hENcbvs3_Mu7tjTPfrj8h1xTDb03y-5bACU3cckOpmPJveg@mail.gmail.com>
Date:   Mon, 6 Sep 2021 15:53:26 +0800
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, xieyongji@bytedance.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <DB1899F3-88A0-44A2-8F44-A380D625A98F@bytedance.com>
References: <20210831083223.65797-1-weijunji@bytedance.com>
 <CAD=hENcbvs3_Mu7tjTPfrj8h1xTDb03y-5bACU3cckOpmPJveg@mail.gmail.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> On Sep 6, 2021, at 3:21 PM, Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>=20
> On Tue, Aug 31, 2021 at 4:32 PM Junji Wei <weijunji@bytedance.com> =
wrote:
>>=20
>> The port->attr.port_cap_flags should be set to enum
>> ib_port_capability_mask_bits in ib_mad.h,
>> not RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP.
>>=20
>> Signed-off-by: Junji Wei <weijunji@bytedance.com>
>> ---
>> drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h =
b/drivers/infiniband/sw/rxe/rxe_param.h
>> index 742e6ec93686..b5a70cbe94aa 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_param.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
>> @@ -113,7 +113,7 @@ enum rxe_device_param {
>> /* default/initial rxe port parameters */
>> enum rxe_port_param {
>>        RXE_PORT_GID_TBL_LEN            =3D 1024,
>> -       RXE_PORT_PORT_CAP_FLAGS         =3D =
RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP,
>> +       RXE_PORT_PORT_CAP_FLAGS         =3D IB_PORT_CM_SUP,
>=20
> RXE_PORT_PORT_CAP_FLAGS         =3D IB_PORT_CM_SUP |
> RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP,
>=20
> Is it better?
>=20
> Zhu Yanjun

I don=E2=80=99t think so.

Because RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP(0x800000)
means IB_PORT_BOOT_MGMT_SUP(1 << 23) in ib_mad.h.
RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP should be used for
port=E2=80=99s core_cap_flags.

>=20
>>        RXE_PORT_MAX_MSG_SZ             =3D 0x800000,
>>        RXE_PORT_BAD_PKEY_CNTR          =3D 0,
>>        RXE_PORT_QKEY_VIOL_CNTR         =3D 0,
>> --
>> 2.30.1 (Apple Git-130)
>>=20

