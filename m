Return-Path: <linux-rdma+bounces-13927-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B32B0BEB273
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 20:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93C324F456B
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 18:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0567B32F77F;
	Fri, 17 Oct 2025 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zNwSmndC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B93308F26
	for <linux-rdma@vger.kernel.org>; Fri, 17 Oct 2025 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760724398; cv=none; b=CvTaP0HBsevpRm3foLTwkf8+pxZ/qtT3cWUkpv2QbhbOHgmHYK9PfNi0XXNXREas1UVH9QgDdlfk6uwNkACH+0kMC7qfP3KrrZuXgWLFU4eZrPm03jnNBtNYAmNI+lEE+hsY4CjF6tsPAJuYymTIxlxlHkxFxsTg4dHNQNSVTYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760724398; c=relaxed/simple;
	bh=RswICkAVP/gJfU84z7sG0RSQkn8OBmkgeH5K1mNTLgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkWiD3TuPHmUkhEfuoAtVPiffeTsVKaCFuGczauzWKSKhlc+jS0x+ChecJv9ekZxNKSIzbKBoY8skV3YB58v8dC0ynvLhw3L+NeYNDf6xuwLdoQrx7eUQyUv7+NF1hQc/YNRoaTQ+jAxx5rNJ7wxK9g1Z2m3ZipDYm9HgljNNW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zNwSmndC; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-87c1f61ba98so27113226d6.0
        for <linux-rdma@vger.kernel.org>; Fri, 17 Oct 2025 11:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760724394; x=1761329194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rif0oa9DkHAZwRALv2degzNg53F1yw0lZ1fMrEk6s1E=;
        b=zNwSmndC1G8BjGCizsb8qzsXiGoY84YbF6A1GNeK0ZVSd9rxTqiFebDxfWSwIp7Go2
         pDqDTpbI1LWJ38YzR14fYjGoxsC3vmHZpb9ulCMC2EpFrd7q1+qZ1nnTQpI+rC55Y6se
         b8XyHmQSrk8QPtGyg4NtBoSqpi06Di5AkANIRU9OSeS90U6kmfKKs6Xg4/3mKQmjWHSj
         FkhmFHbmrzsE3axqYkkahNTr97fL8qovIaJNRcb3QJJq5xhkoY6sOj0ukPP6/eqYk6hu
         zxd9tZ8mts0+jHH6JEJvrrfso/mJ4NzfGske1/o9fNadOKtYWhcpEEyKEOgYGOO7bm6b
         DS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760724394; x=1761329194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rif0oa9DkHAZwRALv2degzNg53F1yw0lZ1fMrEk6s1E=;
        b=mwqIePy2bVXsZh5gIs8yLCakOpmNNZiUgnaVDNqBFQs/iRaTMqF73wGDTpOvSEz5O7
         kb347Hw6F4B6ymACpnVRfj7bfQHy6/Q1DjokMmxBBVS0ch4l/qA3un2ASMEdytPgic+H
         1U2LPp1j3C03/X77t9YNTf5aoeODXaRIyOqlRmKpPfPQx8USOANVDkThIfHbjLNFLewy
         JItahTorrgruLqc7YC1LYJBpnBGrdj4J6wCsbEoDIJiWqqVAaL6y2/bRh4fOltuYFccP
         mQTpg9+bx4U9ITJoBOi+SyckYaPyTVo52ai7c2GF+OLoWS6Z0IhiGhpCxb9qc/3j1WnV
         c5nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVayzR59uym2AmW0NwBDq8rl6SQnUgWwzNWxMNlIX5IUzfn7hcVi2N8LLac7iYrzRrsdwSrO+UsYiz@vger.kernel.org
X-Gm-Message-State: AOJu0YyoAjRKzWaEzq+JqgCBBMU2k0LLPWySgeb9UlAiDNbu4pgpGzex
	wtJVOAlCUbfX8YCGGJEJBmJEzy/HnGVh7BjucpYH+JoB0tSN6OIlygJtSQVMjTpKtaaUh6vHBBM
	FavnSl2NrtBE6R0F0QWxcbdQRHFSWnhO8maE8l6kn
X-Gm-Gg: ASbGncsSqotVC5G/Uny5oYFakGSsTANo2XHrODywtNqgrLfSe/bbYH3rktU2gVEVkoR
	PBgeMIfeV7qQRJiZTVRDf1F4PAIySDkxEMGR8TLVbVxgfRANh/6z5Dc+/3z+TMsb4qneFef/C9z
	RB2qDnIDPsT3xzfO+LcqI2CwSwIY2eVCTWN0QKB1hf0byT1wbywaM3iPClFjNP7QPXrCJGWkHQe
	aonNEtw/3TYVFX6Wa9XAtxc9rq4ZFUGd5pWv/nIBHKAdVQSYCC091JGEWh/BkgdQfKJyX9BEbz+
	PMkU4bU=
X-Google-Smtp-Source: AGHT+IGs9M6rMBKgqyMBA77+Os13P8a0Trwqj3NIUOuVflQK6sbRWDZHMmwlxaaugj3dXHN2eVpH1oOwE0XiM6XeBZg=
X-Received: by 2002:ac8:5d0c:0:b0:4b7:8d26:5068 with SMTP id
 d75a77b69052e-4e89d1d931amr68197211cf.17.1760724393834; Fri, 17 Oct 2025
 11:06:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003154724.GA15670@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CANn89iJwkbxC5HvSKmk807K-3HY+YR1kt-LhcYwnoFLAaeVVow@mail.gmail.com>
 <9d886861-2e1f-4ea8-9f2c-604243bd751b@linux.microsoft.com>
 <CANn89iKwHWdUaeAsdSuZUXG-W8XwyM2oppQL9spKkex0p9-Azw@mail.gmail.com>
 <7bc327ba-0050-4d9e-86b6-1b7427a96f53@linux.microsoft.com> <1d3ac973-7bc7-4abe-9fe2-6b17dbba223b@linux.microsoft.com>
In-Reply-To: <1d3ac973-7bc7-4abe-9fe2-6b17dbba223b@linux.microsoft.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Oct 2025 11:06:22 -0700
X-Gm-Features: AS18NWD9oOYYHDWUxXoRuwJar8qOGE2ISFfEALKFndeOAt7P5v6X0t3YuKTfx3M
Message-ID: <CANn89iKFsuUnwMb-upqwswrCYaTL-MXVwsQdxFhduZeZRAJZ2A@mail.gmail.com>
Subject: Re: [PATCH net-next] net: mana: Linearize SKB if TX SGEs exceeds
 hardware limit
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com, 
	kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com, 
	ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com, 
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, gargaditya@microsoft.com, 
	ssengar@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 10:41=E2=80=AFAM Aditya Garg
<gargaditya@linux.microsoft.com> wrote:
>
> On 08-10-2025 20:58, Aditya Garg wrote:
> > On 08-10-2025 20:51, Eric Dumazet wrote:
> >> On Wed, Oct 8, 2025 at 8:16=E2=80=AFAM Aditya Garg
> >> <gargaditya@linux.microsoft.com> wrote:
> >>>
> >>> On 03-10-2025 21:45, Eric Dumazet wrote:
> >>>> On Fri, Oct 3, 2025 at 8:47=E2=80=AFAM Aditya Garg
> >>>> <gargaditya@linux.microsoft.com> wrote:
> >>>>>
> >>>>> The MANA hardware supports a maximum of 30 scatter-gather entries
> >>>>> (SGEs)
> >>>>> per TX WQE. In rare configurations where MAX_SKB_FRAGS + 2 exceeds
> >>>>> this
> >>>>> limit, the driver drops the skb. Add a check in mana_start_xmit() t=
o
> >>>>> detect such cases and linearize the SKB before transmission.
> >>>>>
> >>>>> Return NETDEV_TX_BUSY only for -ENOSPC from
> >>>>> mana_gd_post_work_request(),
> >>>>> send other errors to free_sgl_ptr to free resources and record the =
tx
> >>>>> drop.
> >>>>>
> >>>>> Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
> >>>>> Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> >>>>> ---
> >>>>>    drivers/net/ethernet/microsoft/mana/mana_en.c | 26 +++++++++++++
> >>>>> ++----
> >>>>>    include/net/mana/gdma.h                       |  8 +++++-
> >>>>>    include/net/mana/mana.h                       |  1 +
> >>>>>    3 files changed, 29 insertions(+), 6 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/
> >>>>> drivers/net/ethernet/microsoft/mana/mana_en.c
> >>>>> index f4fc86f20213..22605753ca84 100644
> >>>>> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> >>>>> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> >>>>> @@ -20,6 +20,7 @@
> >>>>>
> >>>>>    #include <net/mana/mana.h>
> >>>>>    #include <net/mana/mana_auxiliary.h>
> >>>>> +#include <linux/skbuff.h>
> >>>>>
> >>>>>    static DEFINE_IDA(mana_adev_ida);
> >>>>>
> >>>>> @@ -289,6 +290,19 @@ netdev_tx_t mana_start_xmit(struct sk_buff
> >>>>> *skb, struct net_device *ndev)
> >>>>>           cq =3D &apc->tx_qp[txq_idx].tx_cq;
> >>>>>           tx_stats =3D &txq->stats;
> >>>>>
> >>>>> +       BUILD_BUG_ON(MAX_TX_WQE_SGL_ENTRIES !=3D
> >>>>> MANA_MAX_TX_WQE_SGL_ENTRIES);
> >>>>> +       #if (MAX_SKB_FRAGS + 2 > MANA_MAX_TX_WQE_SGL_ENTRIES)
> >>>>> +               if (skb_shinfo(skb)->nr_frags + 2 >
> >>>>> MANA_MAX_TX_WQE_SGL_ENTRIES) {
> >>>>> +                       netdev_info_once(ndev,
> >>>>> +                                        "nr_frags %d exceeds max
> >>>>> supported sge limit. Attempting skb_linearize\n",
> >>>>> +                                        skb_shinfo(skb)->nr_frags)=
;
> >>>>> +                       if (skb_linearize(skb)) {
> >>>>
> >>>> This will fail in many cases.
> >>>>
> >>>> This sort of check is better done in ndo_features_check()
> >>>>
> >>>> Most probably this would occur for GSO packets, so can ask a softwar=
e
> >>>> segmentation
> >>>> to avoid this big and risky kmalloc() by all means.
> >>>>
> >>>> Look at idpf_features_check()  which has something similar.
> >>>
> >>> Hi Eric,
> >>> Thank you for your review. I understand your concerns regarding the u=
se
> >>> of skb_linearize() in the xmit path, as it can fail under memory
> >>> pressure and introduces additional overhead in the transmit path. Bas=
ed
> >>> on your input, I will work on a v2 that will move the SGE limit check=
 to
> >>> the ndo_features_check() path and for GSO skbs exceding the hw limit
> >>> will disable the NETIF_F_GSO_MASK to enforce software segmentation in
> >>> kernel before the call to xmit.
> >>> Also for non GSO skb exceeding the SGE hw limit should we go for usin=
g
> >>> skb_linearize only then or would you suggest some other approach here=
?
> >>
> >> I think that for non GSO, the linearization attempt is fine.
> >>
> >> Note that this is extremely unlikely for non malicious users,
> >> and MTU being usually small (9K or less),
> >> the allocation will be much smaller than a GSO packet.
> >
> > Okay. Will send a v2
> Hi Eric,
> I tested the code by disabling GSO in ndo_features_check when the number
> of SGEs exceeds the hardware limit, using iperf for a single TCP
> connection with zerocopy enabled. I noticed a significant difference in
> throughput compared to when we linearize the skbs.
> For reference, the throughput is 35.6 Gbits/sec when using
> skb_linearize, but drops to 6.75 Gbits/sec when disabling GSO per skb.

You must be doing something very wrong.

Difference between TSO and non TSO should not be that high.

ethtool -K eth0 tso on
netperf -H tjbp27
MIGRATED TCP STREAM TEST from ::0 (::) port 0 AF_INET6 to
tjbp27.prod.google.com () port 0 AF_INET6
Recv   Send    Send
Socket Socket  Message  Elapsed
Size   Size    Size     Time     Throughput
bytes  bytes   bytes    secs.    10^6bits/sec

540000 262144 262144    10.00    92766.69


ethtool -K eth0 tso off
netperf -H tjbp27
MIGRATED TCP STREAM TEST from ::0 (::) port 0 AF_INET6 to
tjbp27.prod.google.com () port 0 AF_INET6
Recv   Send    Send
Socket Socket  Message  Elapsed
Size   Size    Size     Time     Throughput
bytes  bytes   bytes    secs.    10^6bits/sec

540000 262144 262144    10.00    52218.97

Now if I force linearization, you can definitely see the very high
cost of the copies !

ethtool -K eth1 sg off
tjbp26:/home/edumazet# ./netperf -H tjbp27
MIGRATED TCP STREAM TEST from ::0 (::) port 0 AF_INET6 to
tjbp27.prod.google.com () port 0 AF_INET6
Recv   Send    Send
Socket Socket  Message  Elapsed
Size   Size    Size     Time     Throughput
bytes  bytes   bytes    secs.    10^6bits/sec

540000 262144 262144    10.00    16951.32

>
> Hence, We propose to  linearizing skbs until the first failure occurs.

Hmm... basically hiding a bug then ?

> After that, we switch to a fail-safe mode by disabling GSO for SKBs with
>   sge > hw limit using the ndo_feature_check implementation, while
> continuing to apply  skb_linearize() for non-GSO packets that exceed the
> hardware limit. This ensures we remain on the optimal performance path
> initially, and only transition to the fail-safe path after encountering
> a failure.

Please post your patch (adding the check in ndo_features_check()),
perhaps one of us is able to help.

