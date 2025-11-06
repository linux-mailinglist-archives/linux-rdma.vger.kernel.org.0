Return-Path: <linux-rdma+bounces-14283-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E409AC3B2E2
	for <lists+linux-rdma@lfdr.de>; Thu, 06 Nov 2025 14:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F07104E5BBA
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Nov 2025 13:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE18A30EF6C;
	Thu,  6 Nov 2025 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bgV11jk8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6361411DE
	for <linux-rdma@vger.kernel.org>; Thu,  6 Nov 2025 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435051; cv=none; b=f1hsVMs1iWzbhexSQozZWW2E3XZudDzCT1LaguDdR66TxhX7MPybnuiWznvEbqOSv2O07lcl8kbEDcmAPDF1VUKztQ1CiE/DbxsU1DVf9ULynU3/v8N8+S8UBekEtDYbFCTMnVHkkCWQev6HlKrcE4mlsIhICWSSQX3Sp/GS5L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435051; c=relaxed/simple;
	bh=8xyayUNeX27WinogYM/STcDgXHhgPSZqFVuRAY979CU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPqCAm/u66SXANK2Z8zHJ3+x57FiFPYu0HObFc9YRGJc8q0vqW2dhL/xYFnTN0DTFvfb7uqn4VeNvtQC/GyiS+07x6kWeH/fM9ksaIEnJuESIiJxk9d0tvRhs0IsxLR11+T2faUWYGfXkcQrVZvWnSi+jLnzoiT+aiyI6vtltxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bgV11jk8; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ed75832448so7517731cf.2
        for <linux-rdma@vger.kernel.org>; Thu, 06 Nov 2025 05:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762435049; x=1763039849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yKqqA00jwTc/irIUDNF5NewMs+/9jewFrwR1l5Pykk=;
        b=bgV11jk8QoNsIbL82roahyKlhtYwGQ3Qcrzog2usjpeA6WcdA6jXVATLPLyqHdWXng
         MYymRswIReG/mABBRLgtxA9mJUzY3au35c3b5N8gc/a+/JvXHK6Or0L8Cdlo8TB2+HRI
         2GzOQP4qirU80Vwvo9hVkdkL2YcRsqanDkikuv9z7XRBCsurV54xzIDmcfSbT3FMW2F4
         i3qP/WHPFQNrEmESWGMos6UVDEEpOkZLyp++MeHWM1EIRg+YhO2ZJd0kbWLRLJXt7wkU
         GXbFUymwBz1bFNySGLzXI64qktUf+r6fNr6dbRHSJXZWuYWNWeY6IkpEvt/Rw2nN1l5j
         VTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435049; x=1763039849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yKqqA00jwTc/irIUDNF5NewMs+/9jewFrwR1l5Pykk=;
        b=qukM+nRC6ES+p8BMpF0U1H12bWXoFp8WHB+Nn5glqoDoybiR5QJaL9KqfWXDDz25Mw
         /XG4moxvCfCZbv5y/dNW1WFz5QHVmvmDbyDmNGrP2pUa2KUWqJj1b3HgagFWosONZ5MK
         Va4z0IZnI6HHF5bDBkC0mj4IcR2/W2z3E8KfVP2ae/njN33B3p9gMn8s1Cnilr4f2gSl
         sYEuS2DwkUyItnFdSbb9JpC/HW+pS2oODkfK3ISxhQ9bgIcUaoXili9EoqgYTx8LGnEw
         5mWCxbiUndCmnZYWCA2G4zRQQLtrGU56IwLxnhYBteuRMcH8BAzQhB/prOLvNttFoz/c
         lPfg==
X-Forwarded-Encrypted: i=1; AJvYcCXfzBQySZek3ZaGhLIozy1MR6ps+mdn+sRqTgK6GPmzXUaJvNKwCEiMh8Ok5bWxwJkKwdF7eaXVRdX4@vger.kernel.org
X-Gm-Message-State: AOJu0YwGJNolZEdmQzTKG+tYK7tl74Drv6SKEspTikizMikzXrqjAFs3
	83llohyKYtHqxcJkBf0SQ7qHijuR2Vj9GPdsVASy8AbJOiWtig92toIYv0D9kk2caZJgnpoVt8d
	CR7SSwskd2tWOk/MOm+6Wr0OZRx9SAOSVTMvx6edI
X-Gm-Gg: ASbGncugXincWSwujE5UlYImCdgysZTQgrCpes7hWz9KETEmY2vS0qziUy5UkNKISq9
	Kc71sbueEBfSz/C1hFnBbbPLUqbQPAs5q2v+P82LoGyi8McauPBj5U5iAsRGyt8/ECvvA/GoC2w
	z1M7OkFElunHKqeWBji5nAHiIcukRubAnFk67lQcfbbmWEWnWPB7AmvLselRWbynqzG+A1QIuOb
	HX2J+LKSpwoI/h02DbWxUBGtApnBxaVGr3xZG8Va6R9bhOOjNbRt1kxN88hBM0veIbBp7wSvZSW
	8FnS9g==
X-Google-Smtp-Source: AGHT+IHoVZY32WaUUPLhhY4TIgToxdwsHfeGByBPVatw4n/WThQoOgUxSF+0rV1ygA7KDRf83XJehc/SzmchYE2halI=
X-Received: by 2002:a05:622a:4a09:b0:4ed:5ed:2527 with SMTP id
 d75a77b69052e-4ed72330515mr88050901cf.3.1762435048365; Thu, 06 Nov 2025
 05:17:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029131235.GA3903@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20251031162611.2a981fdf@kernel.org> <82bcd959-571e-42ce-b341-cbfa19f9f86d@linux.microsoft.com>
 <20251105161754.4b9a1363@kernel.org> <bb692420-25f9-4d6e-a68b-dd83c8f4be10@linux.microsoft.com>
In-Reply-To: <bb692420-25f9-4d6e-a68b-dd83c8f4be10@linux.microsoft.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Nov 2025 05:17:17 -0800
X-Gm-Features: AWmQ_bkBBaZsd-rIT26BTjS7cW1vwvaDIkKAjz7m89rgLrJMPIY3CSG-aBEvnJU
Message-ID: <CANn89iJ8QKbwFfLUExJvB1SJCu7rVCw_drD3f=rOU84FNvaPZg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: mana: Handle SKB if TX SGEs exceed
 hardware limit
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: Jakub Kicinski <kuba@kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, pabeni@redhat.com, longli@microsoft.com, 
	kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com, 
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com, 
	dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com, 
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	gargaditya@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 5:01=E2=80=AFAM Aditya Garg
<gargaditya@linux.microsoft.com> wrote:
>
> On 06-11-2025 05:47, Jakub Kicinski wrote:
> > On Wed, 5 Nov 2025 22:10:23 +0530 Aditya Garg wrote:
> >>>>            if (err) {
> >>>>                    (void)skb_dequeue_tail(&txq->pending_skbs);
> >>>> +          mana_unmap_skb(skb, apc);
> >>>>                    netdev_warn(ndev, "Failed to post TX OOB: %d\n", =
err);
> >>>
> >>> You have a print right here and in the callee. This condition must
> >>> (almost) never happen in practice. It's likely fine to just drop
> >>> the packet.
> >>
> >> The logs placed in callee doesn't covers all the failure scenarios,
> >> hence I feel to have this log here with proper status. Maybe I can
> >> remove the log in the callee?
> >
> > I think my point was that since there are logs (per packet!) when the
> > condition is hit -- if it did in fact hit with any noticeable frequency
> > your users would have complained. So handling the condition gracefully
> > and returning BUSY is likely just unnecessary complexity in practice.
> >
>
> In this, we are returning tx_busy when the error reason is -ENOSPC, for
> all other errors, skb is dropped.
> Is it okay requeue only for -ENOSPC cases or should we drop the skb?

I would avoid NETDEV_TX_BUSY like the plague.
Most drivers get it wrong (including mana)
Documentation/networking/driver.rst

Please drop the packet.

>
> > The logs themselves I don't care all that much about. Sure, having two
> > lines for one error is a bit unclean.
> >
> >>> Either way -- this should be a separate patch.
> >>>
> >> Are you suggesting a separate patch altogether or two patch in the sam=
e
> >> series?
> >
> > The changes feel related enough to make them a series, but either way
> > is fine.
>
> Regards,
> Aditya
>

