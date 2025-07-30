Return-Path: <linux-rdma+bounces-12546-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E8FB1651E
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jul 2025 19:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D46A541845
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jul 2025 17:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F107132122;
	Wed, 30 Jul 2025 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFQAPWG2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0DA1DF754;
	Wed, 30 Jul 2025 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753895055; cv=none; b=McJfmCVR7dVsI8RnuD7Ch97Xp96/p9Zb0ntfzSb2vI7IWJd5Hps1+GKesvqIugyI3fg7MkuEueIFVf3pOY7JfHiyc8dFtzO7OGZRR+65rTYtEQQBYr7BN4beOH86VwyYYsPtiKhf12ps/MqWubhiEuTqbhnPwjKwpty7jjz3tss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753895055; c=relaxed/simple;
	bh=+QUDwLPZIg0LN5TyszhHKw6UwXV/A9IUfssaxUmjgUs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=I6gBvmMgkiEThpnuWfyuMpiqXaJHGYOKpUPrWQrYlbNfk+whynYzmT8VfsrQmT0IbRIADeS1agmpsmTTZtfSBr5fUlhftzG9BfqFa7msywOHvtHIBahbGAealvDyeAIlVcaoU8UeF3STWHkAQH+fZg/tcpyREcDWibDHwlFsEhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFQAPWG2; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso68953276.2;
        Wed, 30 Jul 2025 10:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753895053; x=1754499853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRbqamYfrWX/vU/16Q3x6GX8UsIbkDC1oPuEKEov6Lo=;
        b=gFQAPWG2Tk/XrwLNry8ej5VZXIfhacRU/wjLTmPexVm9Fmg6kKx0VOUh77v53ctSUx
         Bc9UMVPr/9tRjuns9+6WyTiFsdgb4KCJEmWQm7J1tqilQHcYrHFTEDX11SS9kwp8+EvF
         CF3w+GXdbYXGa4rY4qCQBfO3ALZQuSqpcm6Z4L5pCzyqodGm487g+DMq9ucd2J3lxhpV
         LJeRh6cJI3mz0mn0kwNWkkxys5X3bh+tbePkQJt2Zl4CgaU+IrynPtX9BTyhWBvkbMDP
         8266HZd6TkGxJ2Vkd0+2XVd1cIcNUDljGx0uwKD6vB50bMdL6+iHmlLqICVa5BqFfseU
         /ttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753895053; x=1754499853;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oRbqamYfrWX/vU/16Q3x6GX8UsIbkDC1oPuEKEov6Lo=;
        b=sFxOV7+ur+4FPt5uqBaDklDyPa2lxGbd/vzDcH2OfA0YdjT2sKnaJSBMVmxl3FN/gH
         W+lz6vEEvDxsI+wAktbfNFWTtTKXPOprRliD5G3iiqesmL2hklL20Q+4xTiPUncIp9kN
         ibhZRGbWDQSAtSqbddLVOM2i51wW7gIsHRhHMx7nEFcd/OZt0FdwhsFSfLGHCyOcEYcx
         NF77XKNwYKsHrqodpJdARJhU5GxY1CKW0VaJnDYGfe8zNqSElyanPESvQjytZ/m4ZmnM
         H86D9e0oQIdmcpRK7t3RgSD4A3AES7iIT3Ak53tiJpbGUST3CJsivo/Vb841VUf1x5r4
         YhPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgse4ruOGOSE/TBc1RCiGVkBRXLmEvBkn0Pv74HK23TyGKagQuGHJ7lqyno3tQgtrj0w8gKSgFLAxu@vger.kernel.org, AJvYcCVsOVNtDfePT564heAsadO1K/ZApPsBhpS62WLOtpZYzrOt/DYzPqyZ4oAModCFRai5giDcjrXa@vger.kernel.org
X-Gm-Message-State: AOJu0YzbpaMiOqwzQu2RHY1PGvrUJPv2LOAzTbl0IR0IanqWxyOTXtjB
	i7SFL5CSY+NQMdZLf/36QzNStd/mbsme3/cZVVRP4MoFbg+6u/NQfKgH
X-Gm-Gg: ASbGncswy3j4ncsG8FKzjBde0wARCEpfWYna1t2vqowg9ugLDn7kiJiTN4JmXjEhVcs
	kb38OS2QvCxxCYNiezk4LHL1vDH0sKB1iIDFaINp2+232vjQuRY457NqLiSiEflIrLQvbZoNtyB
	31FaKde1Leu30MzGlEWGZRRqzVowcS96dJedGlHZXtm7C1CBDpvtItcDyAW9q9Jum9BjHe29JPT
	lseydOEnIW1uP8vIGc+sweuRWNEIM5sixatkIdYp/0+dVOtxBgVmcVMP4jIqgsp810F7+SZaROj
	cCpOIv7unzWbBdjECy/kXevEwP2VKOYJafhKkOCyIPhpPhc2i+TOKbu94wLNgsWnzwbzFZkTR1I
	2h/C/+2d1IXdp/HE9m+lCs9Dm81yzritBm0391PcLJ4gKgP/zTiVJeFfr+TKt4n8bDCpupA==
X-Google-Smtp-Source: AGHT+IH4rSvXj2151H6m2wG/1wdSJO/aPei/aOeKkZbN3GpybejttOcrkcc3rPpvc4v5f27WCILN2Q==
X-Received: by 2002:a05:6902:2088:b0:e8d:868a:bae1 with SMTP id 3f1490d57ef6-e8e31486a64mr5446275276.13.1753895052483;
        Wed, 30 Jul 2025 10:04:12 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e8fd139dc24sm31134276.28.2025.07.30.10.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 10:04:11 -0700 (PDT)
Date: Wed, 30 Jul 2025 13:04:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Christoph Paasch <cpaasch@openai.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: Gal Pressman <gal@nvidia.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Bailey Forrest <bcf@google.com>, 
 Catherine Sullivan <csully@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Amir Vadai <amirv@mellanox.com>, 
 netdev@vger.kernel.org, 
 linux-rdma@vger.kernel.org, 
 hramamurthy@google.com
Message-ID: <688a508a5d70c_1d39272941d@willemb.c.googlers.com.notmuch>
In-Reply-To: <CADg4-L-7UWVfWOAFOBjVJ4PXbz06b1riDO3r5d4QpGj+aTVcfw@mail.gmail.com>
References: <20250729-mlx5_gso_segs-v1-1-b48c480c1c12@openai.com>
 <195d0388-57ca-4a1a-bc92-65da899443ab@nvidia.com>
 <CANn89iJo5Fxx4kqhE4S+z4N0BtLW2462Pc6uBB2OvPDpo7-pKw@mail.gmail.com>
 <CADg4-L-7UWVfWOAFOBjVJ4PXbz06b1riDO3r5d4QpGj+aTVcfw@mail.gmail.com>
Subject: Re: [PATCH net] net/mlx5: Correctly set gso_segs when LRO is used
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christoph Paasch wrote:
> On Wed, Jul 30, 2025 at 5:28=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> >
> > On Wed, Jul 30, 2025 at 4:06=E2=80=AFAM Gal Pressman <gal@nvidia.com>=
 wrote:
> > >
> > > On 29/07/2025 21:34, Christoph Paasch via B4 Relay wrote:
> > > > From: Christoph Paasch <cpaasch@openai.com>
> > > >
> > > > When gso_segs is left at 0, a number of assumptions will end up b=
eing
> > > > incorrect throughout the stack.
> > > >
> > > > For example, in the GRO-path, we set NAPI_GRO_CB()->count to gso_=
segs.
> > > > So, if a non-LRO'ed packet followed by an LRO'ed packet is being
> > > > processed in GRO, the first one will have NAPI_GRO_CB()->count se=
t to 1 and
> > > > the next one to 0 (in dev_gro_receive()).
> > > > Since commit 531d0d32de3e
> > > > ("net/mlx5: Correctly set gso_size when LRO is used")
> > > > these packets will get merged (as their gso_size now matches).
> > > > So, we end up in gro_complete() with NAPI_GRO_CB()->count =3D=3D =
1 and thus
> > > > don't call inet_gro_complete(). Meaning, checksum-validation in
> > > > tcp_checksum_complete() will fail with a "hw csum failure".
> > > >
> > > > Even before the above mentioned commit, incorrect gso_segs means =
that other
> > > > things like TCP's accounting of incoming packets (tp->segs_in,
> > > > data_segs_in, rcv_ooopack) will be incorrect. Which means that if=
 one
> > > > does bytes_received/data_segs_in, the result will be bigger than =
the
> > > > MTU.
> > > >
> > > > Fix this by initializing gso_segs correctly when LRO is used.
> > > >
> > > > Fixes: e586b3b0baee ("net/mlx5: Ethernet Datapath files")
> > >
> > > Maybe we should put an additional Fixes line for the gso_size patch=
?
> > > It doesn't directly fix it, but it will clearly emphasize the impor=
tance
> > > of picking up this patch together with the other one.
> > >
> > > > Reported-by: Gal Pressman <gal@nvidia.com>
> > > > Closes: https://lore.kernel.org/netdev/6583783f-f0fb-4fb1-a415-fe=
ec8155bc69@nvidia.com/
> > > > Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> > >
> > > Thanks Christoph,
> > > Reviewed-by: Gal Pressman <gal@nvidia.com>
> >
> > I do not think we need many Fixes: tag.
> >
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
> >
> > If we really want to be precise, the issue also came when GRO got
> > support for GRO packets ;)
> >
> > commit 5eddb24901ee    gro: add support of (hw)gro packets to gro sta=
ck
> >
> > This commit really implied that both gso_size and gso_segs had to be
> > set by drivers RX paths.
> >
> > It seems drivers/net/ethernet/google/gve/gve_rx_dqo.c has a similar i=
ssue.
> >
> > gve_rx_complete_rsc() sets gso_size but not gso_segs
> >
> > shinfo->gso_size =3D le16_to_cpu(desc->rsc_seg_len);
> =

> I see! I can send a fix, but won't have the ability to actually test
> it. So, maybe better if someone else takes this one.

Thanks. The GVE team will send a fix.

