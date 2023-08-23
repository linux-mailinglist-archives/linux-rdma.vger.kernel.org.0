Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7127850BB
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Aug 2023 08:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjHWGgK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Aug 2023 02:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjHWGgK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Aug 2023 02:36:10 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB952E57;
        Tue, 22 Aug 2023 23:36:07 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bb97f2c99cso82207691fa.0;
        Tue, 22 Aug 2023 23:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692772566; x=1693377366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGtuHtCCLVYwNgMT4zJu3xA4UjsVJX2rb4nujo4KnIg=;
        b=JJG+slDAzqNwM7+E0zdj5aSXQDqaH029/Qn6i5NMlV0V0j6eFvmcVjYlNphDHDqDH7
         sO+0ehjpcqVtvzZAR5mJjz/0JzHfB8dpffDNKL0lkBF/mzVv6NTHaPyqfdET8mmF2+QV
         vF/dDYW5JPFFocS2l7Vgc9sguCV4bOmCxIdpE4MwnnWCUd4rrIw2ejEsUUxJtaV+eQFK
         ACvNnVj6QVeynObRFgvpk0iaot4GLpRdsGJBttc+7Q3wu9ZOZGFjSAxIjWQlyhvEp0Wm
         YMCrkthpzEKU4QMF5MQiHEt4hdhjkNpSabIy/Moxng2jhv9VFCytLIU/ax5j8uZhhMpf
         PCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692772566; x=1693377366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGtuHtCCLVYwNgMT4zJu3xA4UjsVJX2rb4nujo4KnIg=;
        b=fhgRd0aU+DGGAic+8LXDyJLC/ggjWS7iCS9skrCiw1+Rxp5CVfs2QSXir++Iu35Z6F
         jlYPurBC0Sax09uM7aAEMjOLxESRKhD0Szo5g/iAdh5MFqYbyP67dY5gMgUXtfa4o1vi
         X/5NRbQ79EsHXd9xamHjYw8rb0eF+8uzamyez7WZdryukf2dKVznVZ9CwIFEFhvkYKc3
         OtVvqbGRM93nCqz5eX84wjXTmXEl5Jco4p04ds2/vd94FTuoQRXfobroJgIiIWF3GiC4
         O3gNEbxfsuwmpmQS7etiiwWmPlYel26K4iftugSpyhMgZwFcoh2BLRAhQC0YLpDNB3gl
         z33g==
X-Gm-Message-State: AOJu0YxKhlgD2UJAzFOA2lL+ctN3iEL08W76JfRuJ8hBsLvWrtwQkwXh
        3+jOvTiP39UyeHub2d24mho0sjTkvEyLy/n/RnghOyuieK6F2/Vh
X-Google-Smtp-Source: AGHT+IHAo74JKtR/n+1K/n0uWMuaTEGw2pTrpbwcgdBTrrcnx6zrllkLQaCEykJOD40pKEDi/VC+hN3wxLTaN8ZsZqg=
X-Received: by 2002:a2e:b1c4:0:b0:2b9:3883:a765 with SMTP id
 e4-20020a2eb1c4000000b002b93883a765mr8890064lja.31.1692772565681; Tue, 22 Aug
 2023 23:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230823021306.170901-1-lizhijian@fujitsu.com>
 <ba7f496c-b0af-6532-76c7-08eedea886ce@linux.dev> <54f43b58-4986-f2c3-7488-ecaf150b1e79@fujitsu.com>
In-Reply-To: <54f43b58-4986-f2c3-7488-ecaf150b1e79@fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 23 Aug 2023 14:35:53 +0800
Message-ID: <CAD=hENcGfS0++mTTX4z-YT3SAx=5OYyqSf89=AkOCD9+SrUtag@mail.gmail.com>
Subject: Re: [PATCH 1/2] RDMA/rxe: add missing newline to rxe_set_mtu message
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, pmladek@suse.com,
        senozhatsky@chromium.org, Steven Rostedt <rostedt@goodmis.org>,
        john.ogness@linutronix.de
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
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

On Wed, Aug 23, 2023 at 2:25=E2=80=AFPM Zhijian Li (Fujitsu)
<lizhijian@fujitsu.com> wrote:
>
>
>
> On 23/08/2023 14:12, Zhu Yanjun wrote:
> > =E5=9C=A8 2023/8/23 10:13, Li Zhijian =E5=86=99=E9=81=93:
> >> A newline help flushing message out.
> >
> > rxe_info_dev will finally call printk to output information.
> >
> > In this link https://github.com/torvalds/linux/blob/master/Documentatio=
n/core-api/printk-basics.rst,
> > "
> > All printk() messages are printed to the kernel log buffer, which is a =
ring buffer exported to userspace through /dev/kmsg. The usual way to read =
it is using dmesg.
> > "
> > Do you mean that a new line will help the kernel log buffer flush messa=
ge out?
>
> Yeah, the message will be buffered until it is full or it meets a newline=
.

Add PRINTK reviewers:

Petr Mladek <pmladek@suse.com>
Sergey Senozhatsky <senozhatsky@chromium.org>
Steven Rostedt <rostedt@goodmis.org>
 John Ogness <john.ogness@linutronix.de>

This is about printk. They can decide this commit.

Zhu Yanjun

>
>
>
> >
> > Zhu Yanjun
> >>
> >> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> >> ---
> >>   drivers/infiniband/sw/rxe/rxe.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/r=
xe/rxe.c
> >> index 54c723a6edda..cb2c0d54aae1 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe.c
> >> @@ -161,7 +161,7 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int=
 ndev_mtu)
> >>       port->attr.active_mtu =3D mtu;
> >>       port->mtu_cap =3D ib_mtu_enum_to_int(mtu);
> >> -    rxe_info_dev(rxe, "Set mtu to %d", port->mtu_cap);
> >> +    rxe_info_dev(rxe, "Set mtu to %d\n", port->mtu_cap);
> >>   }
> >>   /* called by ifc layer to create new rxe device.
> >
