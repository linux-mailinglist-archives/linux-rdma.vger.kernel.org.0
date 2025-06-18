Return-Path: <linux-rdma+bounces-11429-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A4BADEF92
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 16:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D8E3A7F9A
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 14:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9681D2EBBA7;
	Wed, 18 Jun 2025 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmfhVi2h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987EB2EAD16;
	Wed, 18 Jun 2025 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257162; cv=none; b=jNdZeOavzfBLq5aI01nclJAL1yYIiovG00pB/dNuQ1WShXzAfXGHCui+tB+uJ/YXoo6pzqLaotwbbA1DBduj0nxAYhIMW5srANri+VeQiJlz74fERct+ybSDoTno1/NTdnUbmycIqDm00InsKBhhCOGwWGz80JF2bRhSUeRrogI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257162; c=relaxed/simple;
	bh=rUMIy7WMDIqMX5nqHFhcWEJhMU/5V3MUoPXR1atiSL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RySqOiCIV4HJGcvZNi7bBmVTCs93W/c1DpILXrRaiqUrsB+Z5o7PictnvFl7MGG2VM15fn3X53y61LxcydNUlli7elGR29ulAf5M+XwdicNAmP7eaGXZKo4RQIWrKDUJwZRT+FMsipGdJ9euAA5SmOR2NeFk7I6+ethMfmN//tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmfhVi2h; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-553bcf41440so4438392e87.3;
        Wed, 18 Jun 2025 07:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750257159; x=1750861959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihCXHRZ1nufqzjmG/TdDihkEo5FvL+VMlNINtJVdES0=;
        b=GmfhVi2huNFHVtMaEdi8TRMLScTcMBjWlZ/iVhiYgo7fBtupUY3VtbFelL+H0rfUFe
         s6v+vYpRSobdxnhL67HDdOmw89NOu36tY9k5ePZ6Fj9H37hlulwBPYpNNqrRwwOrhv6d
         q0/jZ5Qz+UpovPrKe8uut0x2wg4/lVUwokKvdpLUUNtMSGFgeSMawfsccrImMQuQYtqI
         N76XY5GToYiC/IR6/ENsQQ/f4uWwW8Zl7GR1XvRVi+9/ZlUaquP0uXMScMWv/XDicowi
         PfJ5GBzTyCckihP1zBlQFndga+s8Yni5N+OEnikGnAQYMXpOEKwB4fNtpo5Oe8xCeIyg
         OJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750257159; x=1750861959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihCXHRZ1nufqzjmG/TdDihkEo5FvL+VMlNINtJVdES0=;
        b=Ddn+hX+mJeeVQgtkoWADnlsRvrJYcrpnmYYJbm6g2/LgN3KbTS++IVSwqYf1V6DSYL
         j9cp/UuAoMcSBsmZeGUzMEMr+ZR2TlAd/XxaN+6L1t+v2ZcIgo9A/WLFLb5Q8U4KQwxw
         bCYFAEIhcT4hN66f+BLBunGl1108cZeCfnDai+3ERT1beqlDFHnsz0xoDD9ZAS+x7pyr
         A5ZQZP6GrKyNkRAj/6DC7fniKpIDEmZOoCDaELwtg6mLpr8SG8scNrKBw5aaQjZJmtj8
         N+ygjKthZCl6EOmyww5p330RAgJb+1CxhxW8xkL7ikiMbMvHufwMBEm+Wu0hIcMlyeli
         n+jg==
X-Forwarded-Encrypted: i=1; AJvYcCVb0od7qu4hx8ksgEaKkQXYBYleqUYGO7XLxxjpXzZYK0q0Lp6vnTZOharX+fIGo20jbnV5SXV8ubJYqQ==@vger.kernel.org, AJvYcCVevqQ06+Igxa9wy8wUxpfhBVJGTa1z2TOKYmR4NY5Vj7kbPBg8tcLCMoWJLVaJAEGfc9Kj3O3nWPARuQ==@vger.kernel.org, AJvYcCVpI4wyFaY+27IYPS+EMVn8cC6ec8q/DwY8eGAurVRrbgnWO35SfJLHwkgKDuv+cFHP9mwUjkp9UpwqDgg=@vger.kernel.org, AJvYcCXEaQn4r40zauy4OU/1dThrkWlPt7OqoFZeIboomz3ugqwHrClcIOHdOiRk1dqYk+A1FSeXVZHE@vger.kernel.org
X-Gm-Message-State: AOJu0YxqBJSv1ou9NvJ3k1ZkGLfUGfxpRyFHbInH9CEgZ4Isk5Kj02Pq
	GImD94Xm5wXftgPAOMfOSSRg6bCQ+d5N9FshAec79U4B2VhtNktwxM56hFCcGFn3kmLteieBtTh
	9rpwAQn7EaB/gEhTF/DgrE5topDXJDOQ=
X-Gm-Gg: ASbGncuoKMSmYGTqGHud0K3hChy1940esGRs3V6WKzYk9VDmg4XXkrkhzTs0JbNpJzS
	uohX1uoqodGEuFi1tu3uQgq3PjEfK1jSmh1A4tu4E+2qHG1DvaxMwmBX9F6SCRG1gX26j9KCzbI
	jg74X6mHhOtZuNNCCunjYrAGIsqQeRoJNC1rZQ+gOdayw170Up8TCK/vJsieRr24PAbTrF9Slmv
	ziCxg==
X-Google-Smtp-Source: AGHT+IE9LWXuzf5K5WiugQZzr59mWmBCSO8Dngn+hDqQ+L7WD83q+dR609mZpacuubkSA72ZHmRLknqpUnl4K69yegE=
X-Received: by 2002:a05:6512:39c3:b0:553:23f9:bb3b with SMTP id
 2adb3069b0e04-553b6f43089mr4423414e87.49.1750257158310; Wed, 18 Jun 2025
 07:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617122512.21979-1-pranav.tyagi03@gmail.com> <20250618105039.GE1699@horms.kernel.org>
In-Reply-To: <20250618105039.GE1699@horms.kernel.org>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Wed, 18 Jun 2025 20:02:26 +0530
X-Gm-Features: Ac12FXw90DPxRpXgVMbGiXurWYc-LHuM_yqfq7DYOEEK79nbIo_aIr8UtNR_8e8
Message-ID: <CAH4c4j+Cx3gTh0aBjBVJqvZjETR6ijphi=x1rQAy_S9fA48NJw@mail.gmail.com>
Subject: Re: [PATCH] net/smc: replace strncpy with strscpy
To: Simon Horman <horms@kernel.org>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 4:20=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Tue, Jun 17, 2025 at 05:55:12PM +0530, Pranav Tyagi wrote:
> > Replace the deprecated strncpy() with strscpy() as the destination
> > buffer should be NUL-terminated and does not require any trailing
> > NUL-padding.
> >
> > Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> > ---
> >  net/smc/smc_pnet.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> > index b391c2ef463f..b70e1f3179c5 100644
> > --- a/net/smc/smc_pnet.c
> > +++ b/net/smc/smc_pnet.c
> > @@ -370,7 +370,7 @@ static int smc_pnet_add_eth(struct smc_pnettable *p=
nettable, struct net *net,
> >               goto out_put;
> >       new_pe->type =3D SMC_PNET_ETH;
> >       memcpy(new_pe->pnet_name, pnet_name, SMC_MAX_PNETID_LEN);
> > -     strncpy(new_pe->eth_name, eth_name, IFNAMSIZ);
> > +     strscpy(new_pe->eth_name, eth_name, IFNAMSIZ);
>
> Hi Pranav,
>
> I think that because strscpy always results in a NULL terminated string
> the length argument can be increased by one to IFNAMSIZ + 1, matching
> the size of the destination.
>
> But I also think that we can handle this automatically by switching
> to the two-argument version of strscpy() because the destination is an
> array.
>
>         strscpy(new_pe->eth_name, eth_name);
>
> >       rc =3D -EEXIST;
> >       new_netdev =3D true;
> >       mutex_lock(&pnettable->lock);
> > --
> > 2.49.0
> >
>
> --
> pw-bot: changes-requested

Hi,

Thanks for the feedback. Apologies for the oversight.
The size parameter should match the size of the destination.
Anyway, I will now use the two-argument version
send a v2.

Regards
Pranav Tyagi

