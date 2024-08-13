Return-Path: <linux-rdma+bounces-4345-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3FE950171
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2024 11:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A213E1C24754
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2024 09:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE07417C7CC;
	Tue, 13 Aug 2024 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="aNeSmAfF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9C08BF3
	for <linux-rdma@vger.kernel.org>; Tue, 13 Aug 2024 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542182; cv=none; b=F+4CkUVvM9oobesY6MHitYfJPHLHXVKdznnRDHlOCryuDMh2WrukzkiNbYsH3BZMYeEP3acZs5UQDPPhh/HjUTxBtyX4az+O0rrs+gjY9o9Wwcfl3SaaXV9iw2v0DA8J72Vn64HpdMYxGhAiMtjR8oLIpj+XZ3Tu7+QTLJjHTjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542182; c=relaxed/simple;
	bh=D24UnhFeahm4Oz7T1ngC4p+6IkAj23zGxYjf8U+DvKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OiR/C+Qi3Px8CunXhU5mi0bUD7CQLoiChh9Z+aaVaTsIImzxXuvIta9Dm13uWD9L+nr4rVgbeVihCEXPNizSxs2cJW+YA5UxqxTUYFzbvG2QpCQd4Eg8A5KO1jyOjr2LfVt73O0qD1FOjt8/uIlPVTKGwSD34mXpMuGPDYWUWDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=aNeSmAfF; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ef2fbf1d14so58613051fa.1
        for <linux-rdma@vger.kernel.org>; Tue, 13 Aug 2024 02:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1723542178; x=1724146978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4vpT4ArLnTLpW1v/74TcziBo65ja1HawLY/uNEz5WU=;
        b=aNeSmAfFpXKCFrMW498J4YZuMZlLMmVqAfUlpX0cITSh+ZHHqAMTEKRZEtuUgwmUH5
         myfdVJAmYhfJ1Wqn0Ob/lhjtKPDour3+pqJU8MA0xtLnHyomFtINUHOmKubkpBPUQO5I
         lKL3y/kWmApACoRQ+HEVlBBIZS3rv47rsU97/a9giaGbRHEUFP3z4ByK4l9aEyPTkI92
         ft+u5/Zap9x0mxck8X3Thga+0U+n93dtrjaqYSYReQO/0yBWf4ls0S5YSY/D7gLTN3mw
         r8DzAwX/5QczCRp2iCEc8y/LzDlB3ggZrCl91jdj4iSpXOhFcGwMsvWU363PQH0tb06E
         2EUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723542178; x=1724146978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4vpT4ArLnTLpW1v/74TcziBo65ja1HawLY/uNEz5WU=;
        b=NpAD1WBUEeuoQxplHsJyRs9Er0jwZymim/WjjgBC7xi2gaOEb4gEDdce7FySEL4oWH
         FdA//PAETP+1Q4UIvKShZcNcrFG5rxqhZGct1arAz1ZgOkmFAc7uJj3CRMVpy83BjMqe
         T5HYbJsDUbB1alkTn+8oknFjHl36b46UyvtRWlIEkJGKOkL5w7KtJApG1JpUkLM4EzhN
         c/+odCd4XzLo3nrKAtUrvCzRWkiozng8daPZUFsCOaZLzN58XPLOwxGFDUj41cS9df/J
         p5w0IQK1VbG+nXHuJ1nvM3FnynztmYo+nEEJM+ebYvokk9osb+d8o4nHFrOFaZV4S/uR
         0Dhw==
X-Gm-Message-State: AOJu0Yzt2tCV/+P6y4RuCei2DZliqnzwtXaUXGaYAT9kMT3NeArcGm9L
	xwrMKgn2eA6F3sz5iO6VqqS3ZuZ+GqcuCkSSaNX4n3eUo82hk7MNDaCB5GHHqg4sBtV95QZNOLV
	xi1P2l+v4yZGCF8VQEcnMLhHwpOhY+l7Lb+u8jg==
X-Google-Smtp-Source: AGHT+IHX1XKvx1jIBHWG8OcCMlJqtWZjt/Q+DCCr+t1FRkAED1H0etWorTdqbqtxx6k59HuHz/JmvA2t8PSxPcT2KMs=
X-Received: by 2002:a05:651c:b22:b0:2ee:df8f:652d with SMTP id
 38308e7fff4ca-2f2b8ec7dfamr5462301fa.2.1723542177550; Tue, 13 Aug 2024
 02:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809131538.944907-1-haris.iqbal@ionos.com>
 <20240809131538.944907-2-haris.iqbal@ionos.com> <20240811083830.GB5925@unreal>
 <CAJpMwyjksJakyZVvf_jWwrnvbpV_T=jjAKgXG5k0ZCGyoZx_Rg@mail.gmail.com>
 <20240812103433.GC12060@unreal> <CAJpMwyjgNnCb4D8D_hHm5sQAzwLurPig=MzLdNtScVU2CzvMQA@mail.gmail.com>
 <20240812105942.GD12060@unreal> <CAJpMwyh7ytEawa=Yzg8CM=QZROvoBY70unhFvJdbAW9BU+xoUg@mail.gmail.com>
 <20240812121520.GF12060@unreal>
In-Reply-To: <20240812121520.GF12060@unreal>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Tue, 13 Aug 2024 11:42:45 +0200
Message-ID: <CAJpMwyjUh=VUoHU_MJqnLwV2qHR-Xyd4rCcF6EpdNfGWZ==yXA@mail.gmail.com>
Subject: Re: [PATCH for-next 01/13] RDMA/rtrs-srv: Make rtrs_srv_open fail if
 its a second call
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org, jgg@ziepe.ca, 
	jinpu.wang@ionos.com, Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 2:15=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Mon, Aug 12, 2024 at 01:17:11PM +0200, Haris Iqbal wrote:
> > On Mon, Aug 12, 2024 at 12:59=E2=80=AFPM Leon Romanovsky <leon@kernel.o=
rg> wrote:
> > >
> > > On Mon, Aug 12, 2024 at 12:39:06PM +0200, Haris Iqbal wrote:
> > > > On Mon, Aug 12, 2024 at 12:34=E2=80=AFPM Leon Romanovsky <leon@kern=
el.org> wrote:
> > > > >
> > > > > On Mon, Aug 12, 2024 at 12:16:19PM +0200, Haris Iqbal wrote:
> > > > > > On Sun, Aug 11, 2024 at 10:38=E2=80=AFAM Leon Romanovsky <leon@=
kernel.org> wrote:
> > > > > > >
> > > > > > > On Fri, Aug 09, 2024 at 03:15:26PM +0200, Md Haris Iqbal wrot=
e:
> > > > > > > > Do not allow opening RTRS server if it is already in use an=
d print
> > > > > > > > proper error message.
> > > > > > >
> > > > > > > 1. How is it even possible? I see only one call to rtrs_srv_o=
pen() and
> > > > > > > it is happening when the driver is loaded.
> > > > > >
> > > > > > rtrs_srv_open() is NOT called during RTRS driver load. It is ca=
lled
> > > > > > during RNBD driver load, which is a client which uses RTRS.
> > > > > > RTRS server currently works with only a single client. Hence if=
, while
> > > > > > in use by RNBD, another driver wants to use RTRS and calls
> > > > > > rtrs_srv_open(), it should fail.
> > > > >
> > > > > =E2=9E=9C  kernel git:(rdma-next) =E2=9C=97 git grep rtrs_srv_ope=
n
> > > > > drivers/block/rnbd/rnbd-srv.c:  rtrs_ctx =3D rtrs_srv_open(&rtrs_=
ops, port_nr); <---- SINGLE CALL
> > > > > drivers/block/rnbd/rnbd-srv.c:          pr_err("rtrs_srv_open(), =
err: %pe\n", rtrs_ctx);
> > > > > drivers/infiniband/ulp/rtrs/rtrs-srv.c: * rtrs_srv_open() - open =
RTRS server context
> > > > > drivers/infiniband/ulp/rtrs/rtrs-srv.c:struct rtrs_srv_ctx *rtrs_=
srv_open(struct rtrs_srv_ops *ops, u16 port)
> > > > > drivers/infiniband/ulp/rtrs/rtrs-srv.c:EXPORT_SYMBOL(rtrs_srv_ope=
n);
> > > > > drivers/infiniband/ulp/rtrs/rtrs.h:struct rtrs_srv_ctx *rtrs_srv_=
open(struct rtrs_srv_ops *ops, u16 port);
> > > > >
> > > > >   807 static int __init rnbd_srv_init_module(void)
> > > > >   808 {
> > > > >   809         int err =3D 0;
> > > > >   810
> > > > >   811         BUILD_BUG_ON(sizeof(struct rnbd_msg_hdr) !=3D 4);
> > > > >   812         BUILD_BUG_ON(sizeof(struct rnbd_msg_sess_info) !=3D=
 36);
> > > > >   813         BUILD_BUG_ON(sizeof(struct rnbd_msg_sess_info_rsp) =
!=3D 36);
> > > > >   814         BUILD_BUG_ON(sizeof(struct rnbd_msg_open) !=3D 264)=
;
> > > > >   815         BUILD_BUG_ON(sizeof(struct rnbd_msg_close) !=3D 8);
> > > > >   816         BUILD_BUG_ON(sizeof(struct rnbd_msg_open_rsp) !=3D =
56);
> > > > >   817         rtrs_ops =3D (struct rtrs_srv_ops) {
> > > > >   818                 .rdma_ev =3D rnbd_srv_rdma_ev,
> > > > >   819                 .link_ev =3D rnbd_srv_link_ev,
> > > > >   820         };
> > > > >   821         rtrs_ctx =3D rtrs_srv_open(&rtrs_ops, port_nr);
> > > > >   822         if (IS_ERR(rtrs_ctx)) {
> > > > >   823                 pr_err("rtrs_srv_open(), err: %pe\n", rtrs_=
ctx);   <---- ALREADY PRINTED ERROR
> > > > >   824                 return PTR_ERR(rtrs_ctx);
> > > > >   825         }
> > > > >
> > > > >   ...
> > > > >
> > > > >   843 module_init(rnbd_srv_init_module); <---- SINGLE CALL
> > > > >
> > > > > Upstream code has only on RNBD and one RTRS.
> > > >
> > > > Yes. But they are different drivers. RTRS as a stand-alone ULP does
> > > > not know about RNBD or for that matter any other client driver, whi=
ch
> > > > may use it, either out of tree or in the future. If RTRS can serve
> > > > only a single client, then it should should have protection for
> > > > multiple calls to *_open().
> > >
> > > For now, there is only one upstream client and server.
> >
> > In my understanding, its the general rule of abstraction that this
> > type of limitation is handled where it exists.
>
> We have such protection and it is called "monolithic kernel".
>
> >
> > >
> > > I want to remind you that during initial submission of RTR code, the
> > > feedback was that this ULP shouldn't exist in first place and right
> > > thing to do it is to use NVMe over fabrics.
> > >
> > > So chances that we will have real out-of-tree client are very low.
> >
> > One reason for us to write this patch is that we are working on
> > another client which uses RTRS. We could have kept this change
> > out-of-tree, but frankly, it felt right to add this protection.
>
> So once you will have this client upstream, we can discuss this change.

Okay

>
> Thanks

