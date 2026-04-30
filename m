Return-Path: <linux-rdma+bounces-19759-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFZ6EH+m8mlTtQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19759-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 02:46:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCF449BD3D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 02:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 480B3301CDB7
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 00:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C881DE4E0;
	Thu, 30 Apr 2026 00:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bFHKfhEB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A75D81ACA
	for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2026 00:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777510011; cv=pass; b=ls0VUA5BbPAtKiglX4Cj2MEq/wOqjv5QogYbhCtEnU+eOloKquHF5DdpksIIz2/m9F23H03grgOYUGryPC98nOnZfbKmoNh6DSzdhIoYWJ+wwPZbyd90YcWIFgsowVrOW5yIfBlO3Uc/vY2nST11RezXFCRjshXB5saQuSFSjrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777510011; c=relaxed/simple;
	bh=ul1Zy1snP6dGvbj0jfQTlj3grDtk6aI6ACOEOPqZJq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itVa6oGywz1TWZ8WwBHk2GtNtSc3WJCXlG2QF/jxyqlgZ23UeklF80YF1LgFG5kxZVf3vX1y5v35i6SmblzqHdkbGbU9uCcSbeSgft1atZS+zI8NKZzqzCQoUbf158cfV15/K4iEoNhUjjXzt9iqtRXWIH57hzFeXb8ccDck4jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bFHKfhEB; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so4998a12.0
        for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2026 17:46:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777510008; cv=none;
        d=google.com; s=arc-20240605;
        b=IO8jXYbFfSnpfZwpohfL55sl+efltvtrcxIhnX/b/u0d2bPw1w+NDDvKciOs8dM5aC
         4iQZHC81+CaFsr0W3pxhn0lYRUQId77UdPJSwiMeRgDSl1F1j3IDZ/0kgiAEFGtd+NO9
         dYMR2XhdWFeVfd5nT/Mk/LEJJ1N7HbCd2uPqsdKPTJrzna7dfLA+gAuMK4TERo6ACkhK
         i8/Fp7IZETWdNW4nwyYc9m1GEZ1G+qUjlBL8eYdsli8N4UBiZLSLPjdCfCWML22hDWsZ
         i/4Bpb3Xxwf4cBkW9p6MPaFDPFZRpdbxQLC4zMM5FmzdgFAOt9z0NV/NTqaj+ElEzOt1
         djBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ul1Zy1snP6dGvbj0jfQTlj3grDtk6aI6ACOEOPqZJq4=;
        fh=HOdKcv/yHZRwihUkqexGcFQxDOO/mMOXY+aqTOn4FRo=;
        b=Wly7zOU75XLG5KSj8pA+u/s5Gnj4KjXkIZNK9RxORRbMNJlKFC6kAbdGj6M5Xn0Wim
         RXgGhuNFw6umUkK/A3ItVNKF63zAhCXcXSktVME7zdZynN29C2+3aaBrMNpxA9O6YSod
         5JAlwbuK4rhQL3P7HOEk02EEZ3d0kPdt+jqiyBistwV9OejPasqgF19WL4F9GaG+cn4Q
         l5bNwEApWwFWx6Ngpvx5fGm0EbGUbAHka8ydbDjczag4gDrsHMiqVnPe1X1OHAAjeHfE
         65XfEDJZU5zvil3la8iWIxhmn4NlLL+P7/xv10DCkCZz4cnN1IEni1/AI5Gk6x+7XaXJ
         7idA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777510008; x=1778114808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ul1Zy1snP6dGvbj0jfQTlj3grDtk6aI6ACOEOPqZJq4=;
        b=bFHKfhEB3epEwHZELSGK8pzpESc+ReEP/Q0p2RB4au3eVfTaJOKnMlob6r1Y/J2bmA
         nx8dIrHt84cqeybsSu816Hp/kV2DIT+6SpMt9o5EZwahkmqcSeEMAwh4fUzDPQ9lY15h
         kNUFhtg/JpDHCAUZ8mkKAKUoYLU6xiCPujGCWwQc2fO3UtoDGEtPQ2/wpe5JeAaQqrXr
         6tKEVS7mGXkElqaZugnuOjVgkHpESlNr+kVyd6lieId9Ju9K7ZzkeAvnK74EOajYn5ay
         qLXCF6OH02bTpAPq1it/r2rvGCiJ9VdRXQ/b/R0Ol7V27O/8Q0n8F4Ox4yn2RPrXXZol
         cNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777510008; x=1778114808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ul1Zy1snP6dGvbj0jfQTlj3grDtk6aI6ACOEOPqZJq4=;
        b=H7IZFQ/wtr/TMr81tnD3mxrUXpOatdIFPyXIYhbEPZ+A4mkZzjW+X66Oa3g3Yc7i0f
         XhVIHZcI8YohDw0Al8TmiuwFG0+5TTrPDDIY5zwsfGjuGYVD3nyoFl2BNXnyxgu5EL/g
         /yIIbQYkqHjgWqJ56i05dJb1tA/HDf0qnnxq51VoSn5BizLjMEE60NhR+aFz0up8MgRk
         kd6biQavwM91nXT2Y141oFOwS0y/a9wgozN7W9Ael45L9ouSxSZ0kLFOIEl8CGlTmDJc
         ay17if9CWJXL2GzkA98hRUElpviB0FcArQvxnGhPv5I9Win19muZa3J74q2kMAYpP012
         YZ2A==
X-Forwarded-Encrypted: i=1; AFNElJ+5J1A1vUjT83SXeHNDSScxF/KAbKQf/jDsGax6MzYxgJX24QaDD68NuC9D73j6qtEV2K6AMsnsMm9y@vger.kernel.org
X-Gm-Message-State: AOJu0YwvjGNr4sX2nuRXLHnRFqSeTPUO7Qmaijzb6hAMgAlhHUSTBm9o
	5jGGG/A//3gFsVRBD0Z5Bo1g08flVsHaHTyxt/c0/Jmz/s3JVq1ONhdE8NWxI3xsOSW3VXiMa/c
	mK7skLLlrUX//JLIIjXKuRwnqlDVvOBN5nLf1vy43
X-Gm-Gg: AeBDievE7g3KndByV/bbgJR9SkOwBm/VbInUh/N7KLrm/1EKPrL9t0ylns/ysTMLSeT
	lPNtklPjxwd2ZqCtC2dwm2ZydNV/ILNRY2uIxukOOMVmeQrUnErxC2Jcf15wwkSUgITUsV1teyr
	Ku9PnbfT2OfCthmnzm42T9JFR0cZYxURmZhm4eJCQLPTQbRe4TxeENSfLpdM7UYRDJ6GNbVjt9y
	qaA5opVtzVtvCH8AH0vLPIV2rqEThCxhVtHXNrZWzxgVHojW877W2jjlSuPMLxss0D9bO7OkQuP
	gUmBC9p5xVAfbEXjkku9fO3XFLSpAcJdwh/Oc2Q72FphS7U3EE01C/zXJMRC2Xqi6kFB/TbFp12
	sgJY3EGpkgWqyVboVbSuoMvuE
X-Received: by 2002:aa7:d652:0:b0:672:117e:55d4 with SMTP id
 4fb4d7f45d1cf-67b4e8723ccmr24146a12.0.1777510008054; Wed, 29 Apr 2026
 17:46:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-mlx5_vxlan-v1-1-cf666d042618@google.com> <20260428184631.40f1f1b7@kernel.org>
In-Reply-To: <20260428184631.40f1f1b7@kernel.org>
From: Marc Harvey <marcharvey@google.com>
Date: Wed, 29 Apr 2026 17:46:36 -0700
X-Gm-Features: AVHnY4Jy0fMk6_hGAzUjMixNh5ciOoMan99mjD7l3RRXz0YY4qnAzi7cmOjDKis
Message-ID: <CANkEMgkBnuRfurKcFEUAZcJcX1XYSnHbBozZGP8DpnKq--tWbw@mail.gmail.com>
Subject: Re: [PATCH net-next] net/mlx5: Add MLX5_VXLAN config option
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: ADCF449BD3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19759-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 6:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 28 Apr 2026 22:44:34 +0000 Marc Harvey wrote:
> > Currently, there is no way to disable mlx5 vxlan offloading if vxlan
> > is enabled. We've (possibly) seen some minor udp rr and udp stream
> > regressions when enabling vxlan, and want a way to disable this
> > offloading. Also coupling vxlan offloading with vxlan enablement
> > generally limits the flexability of vxlan setups.
> >
> > Add a new config option for mlx5 vxlan offloading specifically, so
> > that users can use vxlan without automatically opting in to the
> > offloading.
> >
> > To keep the same behavior as before, the new config option is enabled
> > by default if vxlan is enabled.
>
> Can we delay init of whatever makes the device slow down until the
> first vxlan port is registered? A kconfig level optimization of this
> sort will have rather limited applicability.

There would still be the problem of wanting to use vxlan without vxlan
offload. Agree that a kconfig might not be ideal, but it is currently
guarded by a kconfig that offers no choice to opt out.

