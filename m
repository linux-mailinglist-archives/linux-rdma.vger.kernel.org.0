Return-Path: <linux-rdma+bounces-19245-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AnOKkPk2mn26wgAu9opvQ
	(envelope-from <linux-rdma+bounces-19245-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 02:16:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C733E21A3
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 02:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BAB9302768C
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 00:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F55292B4B;
	Sun, 12 Apr 2026 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWtbW6m0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFC0283FEF
	for <linux-rdma@vger.kernel.org>; Sun, 12 Apr 2026 00:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775952933; cv=pass; b=ECBh9WZwICZZ7HYW9YqwLo1SX14HqnKBpKCFtmnDfOKEbiPy0pBWo3Bz7wN8BNsokOqtSBZFiDAF1q3a0VQzbyv3vFJQ/m4ij5GpE5TMFM7oiIdgtqlGGr2/uL1Ypxv34+TmltCDptSWVBoa9zIHak42ZUVGGpBSk2d0fkvZ91w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775952933; c=relaxed/simple;
	bh=CmZGUTedxvErfz78jHYNYnI+6tTt3jotKf5C2gH4HaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZE+eu+qo2KXQkki6C28x+IfSJdjzrY0PIJx4exoiCJcE9nqtCt9HauRb5dJDzuxoBc7YvWf84lmQIOhT0Fbfyn7yHPw7A9bVZzjDKrh8r0IiMFJcAV8Dx3kp7nKGjX3tnKj7EN0qkD4i+v9gWZg3rKg4dSyt3nVjli+CyqcuM7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWtbW6m0; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1279eced0b9so4640049c88.0
        for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 17:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775952930; cv=none;
        d=google.com; s=arc-20240605;
        b=G5HkLWaFh//rQyCW0VknKb13vmt6CvVPJ+WjYfP0liNNWjAPo/ra7BIm9fyxlXMe6m
         s0j+4aVpg1PrW3HwgG9XhMZi/F5A+IQIQ0E3dleQq6T0O0PNptVlhEgAEFpYVnpLp27P
         +D4AzfR/LhR1crsCQuu3jJjq0zxkDmSbY88ExNjqFRWihcBmpBr9Cb5ry9PU3cTYzlq/
         zEVaPT2ZbfPJKSggtAF3bVXhKcYHyibBb5tn834g/V20Xu/KnaAPE8DBtMigdgZwnmgg
         VKnI2J/PCQN+vuo36T467imRA8+94hKgvw9HcSIDqv73POd/uf21ARfzxEHiUEkRjDyf
         eN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cN47XabAe60/l8o1Y3f8/W10xem877OmeoIlTzFDP5Y=;
        fh=cfkO+usEUs4alSbVocBQhqU/J6epe6wQbar8knrPhzA=;
        b=bLkXI89t14jLj+8dQnyVDQblPVL1C/6D91ennLdEVqYIGlaeBMk6ByTpchq0YIE/Gi
         zu3ij0EuoowFiJbNOSNgXx0+csOuUaH9X6XVrsSwc+0IiTlclSQq3rWZjoR2CDEQ9u3R
         QQbHsYmbjdcL+jbcbAhmStmQ8abhpbm81D+mFtapkY4SMxuZzRS3wwXa2Wrr0Tu9SR6M
         EZRMmcic1Cr3JZ3oB1+JGD2sHExIuvo1kwX5Z+iiaF5jb5ia8bRTC9vH8HuEowhhg7aM
         fxmTHo9jIV5pyL1wyOJ/zLnH9ja50prr6SaL2B59N/0zMnjDLtxi4KSOGohlUTFr9sak
         jHMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775952930; x=1776557730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cN47XabAe60/l8o1Y3f8/W10xem877OmeoIlTzFDP5Y=;
        b=WWtbW6m0FkFagck99/qkv0N3zZBBdt8R5ky24ZHbh+r16LBl2R+/xN2iopIgy1LXou
         7qdSdEEHGrrbvyIZV4qyqoXZ4BBy6tZnOrFRBSOi23ywegFicUj8rfVFS3iFksT7i5cM
         8n4gi7WGxv+tel1nT+kAgw4hayYxJl2342BzqNCPUejk0qCftF6WhrtLkZk1w/uJluHF
         MnBy6NEaOdTop1xF0xV60q7Ah5iXTpXbxsg0ig9515rU83WrjpvRIEwm6K7Ir0zVzSuA
         zJ6wfekQrZaMr8exQV0JpFGqC4MvPaV3Tx+iXC6/Eow4J435BYEIryuI8crUf83BCgR+
         Oy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775952930; x=1776557730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cN47XabAe60/l8o1Y3f8/W10xem877OmeoIlTzFDP5Y=;
        b=mD4ifx1/weNq2QJSzT7fFZ4fAaY5JY9iTOn1DHRyV19s281Tbbf9ZVR3F/9ZMp6PN8
         tn4OMKlJbuBdKtSPv9ErU2gM8cjVkP1oFS4O2Z37RJV6+Kv6Ys+2ZYaOp1thLQyD1jjg
         RqtUgQXb0N8KXL3lHa9k3Y1Xw861Varr0HhEtEZW66y/R5OS8Y2X7sacbW6XxoyzYJ+I
         3vkNQaKN+uoi5WPE77mCAr7Wzos/+O0B7WcGJZ2/kjUumcG5DW8zL3FvgSQY7VJBefD7
         rxnuBJqLOGhDwe04X1MyueJQhOmFzvIQ3nAJsoZdFGjfWkG8Y5np/vaeAuCZLF50Et3o
         fh6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXicJcMf1QKsz0l6F7H8grX9UC0niVRn8vMcUVYFx880WiROJfgVtGE99IA+J0vW47nURVw4MqxCsOZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzBK2mGXHCWN4bSlvmTcz+jmoEdVrkQ3YDyRga1Z2CPSAsZqQ33
	MXSzGeBjYOW0il+/KeAE07DGXbl210zdh4KqlOXByinRmsaodvAPwLFrgludtx6ERTDIMCU5N3w
	HCyP6KXQBA/1QuY8/a/wQ8dKdAAiKXOc=
X-Gm-Gg: AeBDiesvXTTp2+ohWzjWeC4EkxDpbvn/o9402EqQjXPjeyZzpmUavdF607oeroqRzjQ
	LMu8WFABDVMyQd48iMgTFvALAUZRsUtFaeIuhaQfQBggNsbsTrJKwlKEFvxrrhoTmoIAYOLsAfe
	iBEfdm6OIwV93KhChLZDHXqQ4VnCJfGCjo+Jl1wP4mU8PNLfpWMAHVkBFwvznZbUFkRAizbA5QO
	RlOaVTfpPqZHT6ndhd6yVKqG0vLAj4dNQKLF3TK4nJmDUQk9bwKORNvTkIPEXHn5ED2D8iGQGkE
	Q1AdhAU=
X-Received: by 2002:a05:7022:790:b0:12c:8b9:71f7 with SMTP id
 a92af1059eb24-12c34eeb715mr4553437c88.24.1775952930140; Sat, 11 Apr 2026
 17:15:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410015336.7353-1-prathameshdeshpande7@gmail.com> <c30f21a3-5a27-43fb-957d-107775b00faf@nvidia.com>
In-Reply-To: <c30f21a3-5a27-43fb-957d-107775b00faf@nvidia.com>
From: prathamesh deshpande <prathameshdeshpande7@gmail.com>
Date: Sun, 12 Apr 2026 01:15:12 +0100
X-Gm-Features: AQROBzANFPTqvpmn7u2azZ01KYmXw0rBHGp7wlUf4BAl0HcvZMwTXNSWCUa335s
Message-ID: <CAJr+Z9mbQUgiKPEvTc1ASYo_sLjLFm6Fn78SsK9hZZzrpWGAhQ@mail.gmail.com>
Subject: Re: [PATCH v3] net/mlx5: Fix OOB access and stack information leak in
 PTP event handling
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Richard Cochran <richardcochran@gmail.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19245-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,vger.kernel.org,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34C733E21A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Carolina,

Thanks for the feedback. I have just submitted v4 which addresses this
by checking the pin index against MAX_PIN_NUM.

Thanks,
Prathamesh


On Sat, Apr 11, 2026 at 12:35=E2=80=AFPM Carolina Jubran <cjubran@nvidia.co=
m> wrote:
>
>
> On 10/04/2026 4:53, Prathamesh Deshpande wrote:
> > In mlx5_pps_event(), several critical issues were identified during
> > review by Sashiko:
> >
> > 1. The 'pin' index from the hardware event was used without bounds
> >     checking to index 'pin_config' and 'pps_info->start', leading to
> >     potential out-of-bounds memory access.
> > 2. 'ptp_event' was not zero-initialized. Since it contains a union,
> >     assigning a timestamp partially leaves the 'ts_raw' field with
> >     uninitialized stack memory, which can leak kernel data or
> >     corrupt time sync logic in hardpps().
> > 3. A NULL 'pin_config' could be dereferenced if initialization failed.
> > 4. 'clock->ptp' could be NULL if ptp_clock_register() failed.
> >
> > Fix these by zero-initializing the event struct, adding a bounds
> > check against n_pins, and adding appropriate NULL guards.
> >
> > Fixes: 7c39afb394c7 ("net/mlx5: PTP code migration to driver core secti=
on")
> > Suggested-by: Carolina Jubran <cjubran@nvidia.com>
> > Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
> > ---
> > v3:
> > - Fix union corruption by using a local timestamp variable [Sashiko].
> > - Validate pin index against n_pins with WARN_ON_ONCE [Carolina].
> > - Remove redundant pin < 0 check and cleanup TODO comment.
> > v2:
> > - Zero-initialize ptp_event to prevent stack information leak [Sashiko]=
.
> > - Add bounds check for hardware pin index to prevent OOB access [Sashik=
o].
> > - Add NULL guard for pin_config to handle initialization failures [Sash=
iko].
> > - Add NULL check for clock->ptp as originally intended.
> >
> >   .../net/ethernet/mellanox/mlx5/core/lib/clock.c | 17 ++++++++++++----=
-
> >   1 file changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/driv=
ers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> > index bd4e042077af..674dd048a6b8 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> > @@ -1164,16 +1164,22 @@ static int mlx5_pps_event(struct notifier_block=
 *nb,
> >                                                              pps_nb);
> >       struct mlx5_core_dev *mdev =3D clock_state->mdev;
> >       struct mlx5_clock *clock =3D mdev->clock;
> > -     struct ptp_clock_event ptp_event;
> > +     struct ptp_clock_event ptp_event =3D {};
> >       struct mlx5_eqe *eqe =3D data;
> >       int pin =3D eqe->data.pps.pin;
> >       unsigned long flags;
> >       u64 ns;
> >
> > +     if (!clock->ptp_info.pin_config)
> > +             return NOTIFY_OK;
> > +
> > +     if (WARN_ON_ONCE(pin >=3D clock->ptp_info.n_pins))
> > +             return NOTIFY_OK;
>
>
> Sorry if my previous comment wasn't clear enough.
>
>
> The firmware will never report a pin higher than n_pins, thats not the
> concern
>
> here. if future hardware reports n_pins > 8, checking against n_pins
> would still
>
> allow OOB access on those arrays. The check should compare against
> MAX_PIN_NUM
>
> instead, since thats the actual hard limit of the driver's data
> structures. and if a new
>
> device supports more than 8 pins, the WARN_ON_ONCE would let us know we n=
eed
>
> to update the driver.
>
>
> Thanks,
>
> Carolina
>


--=20
Thanks and Regards,
Prathamesh Deshpande

