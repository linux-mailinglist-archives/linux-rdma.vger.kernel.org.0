Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E997A56D9
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 03:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjISBMD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 21:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjISBMD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 21:12:03 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452D810D;
        Mon, 18 Sep 2023 18:11:57 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bf5bf33bcdso86083371fa.0;
        Mon, 18 Sep 2023 18:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695085915; x=1695690715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvoF1Qw+q6TvKf1SE6Dx7dnaeUaKsSadPs/P09r1WUw=;
        b=EOnCfRPuUBBDAtrx9wkCBWGpYhRjsjTc79mutokM/NrKxSEW92nqnHzDNwItmUSbGo
         fousiVPkp4DFKEfCvewpNx5ep7FLAXi5BnNdVYVcFr+gQ47HHUyYt0Xd8CiKhfqliv8b
         ygmm0PF3EP39CNeL6kcjsuXg0ZFr6Vhsi352/G5HZ+t3m9Ee1u6sQUW3jNpkhI3Qlal3
         xFondGhH+tnnzlCVDHH4t45CJy5+9qh4pcRIK7TBO0xz69t5qQO1VFrkVDT9ufHmRAvO
         YmltGYvBovji6e5ODoItXAs/7EYgCKQfoAQbCouKxafNa9Hu6Ovj84ZQ8Y44Sv7QW+q/
         yViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695085915; x=1695690715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvoF1Qw+q6TvKf1SE6Dx7dnaeUaKsSadPs/P09r1WUw=;
        b=P2k+e/8mYsR+GDxC2irGweWRIFQ+nW3nOUqLE68uvC9Dzne6oQVEATmVi9ahzn05Xh
         nCG0QzaxJnQ/weUlQzl9uIvK1Q6+6FCId5EkAC4xJDJu73qSq2rqFf5S701yAZIdtUqH
         KapCZgCNPdOrZhhG8r3V3PihNbhTCcRCtYchydls5ziX3oNhGgxsFsmi+Q3aMwgvZMOY
         b8HoEiXFXg9+iktI1NChSG6qVR1Ynwfyiwi/gOAJU55pb+6MonRY576Tp07fX9LuruCw
         MyySgyJTqlDgXs0yU+nt8dlKUEI710ga8WL9hbodAjWjlRLTGWPbiReBNWNSKJyZV/80
         GXIA==
X-Gm-Message-State: AOJu0YxMU6utCEISlVH1Gw1qjBfnnGbwCm5lxF9bD1DxrAK+YtLJQvHW
        5F76ZONA4qwZeF3aXWG3APqKGXgzRcRhCVsAcA4=
X-Google-Smtp-Source: AGHT+IFcfEmlWpgpUmeXJo6mrzzzv1IOhX2CMxAkKGsbnfG+XC8gCH86lUAzbuQmmLv3QVZ3TuX5dqUao0LBXF0Flts=
X-Received: by 2002:a2e:94c9:0:b0:2bf:7dac:a41 with SMTP id
 r9-20020a2e94c9000000b002bf7dac0a41mr8955176ljh.13.1695085915251; Mon, 18 Sep
 2023 18:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230918020543.473472-1-lizhijian@fujitsu.com>
 <20230918020543.473472-2-lizhijian@fujitsu.com> <20230918123710.GD103601@unreal>
 <4dce179f-f808-0a18-7e9e-9877964d67e4@fujitsu.com>
In-Reply-To: <4dce179f-f808-0a18-7e9e-9877964d67e4@fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 19 Sep 2023 09:11:43 +0800
Message-ID: <CAD=hENfcbgNQxb2N1qXJa0pYkF_AYB2aua0smadwkgHtYXfeAw@mail.gmail.com>
Subject: Re: [PATCH for-next v3 2/2] RDMA/rxe: Call rxe_set_mtu after rxe_register_device
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 19, 2023 at 8:57=E2=80=AFAM Zhijian Li (Fujitsu)
<lizhijian@fujitsu.com> wrote:
>
>
>
> On 18/09/2023 20:37, Leon Romanovsky wrote:
> > On Mon, Sep 18, 2023 at 10:05:43AM +0800, Li Zhijian wrote:
> >> rxe_set_mtu() will call rxe_info_dev() to print message, and
> >> rxe_info_dev() expects dev_name(rxe->ib_dev->dev) has been assigned.
> >>
> >> Previously since dev_name() is not set, when a new rxe link is being
> >> added, 'null' will be used as the dev_name like:
> >>
> >> "(null): rxe_set_mtu: Set mtu to 1024"
> >>
> >> Move rxe_register_device() earlier to assign the correct dev_name
> >> so that it can be read by rxe_set_mtu() later.
> >
> > I would expect removal of that print line instead of moving
> > rxe_register_device().
>
>
> I also struggled with this point. The last option is keep it as it is.
> Once rxe is registered, this print will work fine.

I delved into the source code. About moving rxe_register_device, I
could not find any harm to the driver.
So I think this is also a solution to this problem.

Zhu Yanjun

>
> Thanks
> Zhijian
>
>
> >
> > Thanks
> >
> >>
> >> And it's safe to do such change since mtu will not be used during the
> >> rxe_register_device()
> >>
> >> After this change, the message becomes:
> >> "rxe_eth0: rxe_set_mtu: Set mtu to 4096"
> >>
> >> Fixes: 9ac01f434a1e ("RDMA/rxe: Extend dbg log messages to err and inf=
o")
> >> Reviewed-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> >> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> >> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> >> ---
> >>   drivers/infiniband/sw/rxe/rxe.c | 5 ++++-
> >>   1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/r=
xe/rxe.c
> >> index a086d588e159..8a43c0c4f8d8 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe.c
> >> @@ -169,10 +169,13 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned i=
nt ndev_mtu)
> >>    */
> >>   int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev=
_name)
> >>   {
> >> +    int ret;
> >> +
> >>      rxe_init(rxe);
> >> +    ret =3D rxe_register_device(rxe, ibdev_name);
> >>      rxe_set_mtu(rxe, mtu);
> >>
> >> -    return rxe_register_device(rxe, ibdev_name);
> >> +    return ret;
> >>   }
> >>
> >>   static int rxe_newlink(const char *ibdev_name, struct net_device *nd=
ev)
> >> --
> >> 2.29.2
> >>
