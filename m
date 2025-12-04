Return-Path: <linux-rdma+bounces-14875-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E49CCA2059
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Dec 2025 01:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFCDB300DA48
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Dec 2025 00:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DB01F92E;
	Thu,  4 Dec 2025 00:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vlbg1PdT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822E1A59
	for <linux-rdma@vger.kernel.org>; Thu,  4 Dec 2025 00:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764806842; cv=none; b=hD/L8JI62i9DCuDUFq94DKPLefZFs2W4VUz6CK7RCOzJldXrNYfuQJ3NkXe8zHHuIEO6r13kZ0ncGJ2rkv8iBVYrUgnxP0axCN/wgz3OYrhQzBy+0K7mJKDEhkZElY1Xd2AH+fmoCcG8zQc+iekm88xsAZ33XSet6joc8f53GVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764806842; c=relaxed/simple;
	bh=5k031bdZ9Mu+dXIF+y2+BeP4p1iu+Nx/TI05NoGIOek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9uYKMkiegO430StajCzKya48y+38l9ElQaH18EHqMu+zHjR0+WMMohlR++m+mLB2MDs2sEYi6DIxeSkHy+P4Zdsk4AcsLiwaTl2yk5Uc3q0lrhcGloWhUlRPPe1iYT19RwW2/Ecq3CZVFrRe2XtblhFpMtVIcqzsvhk688ZHoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vlbg1PdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A777C19421
	for <linux-rdma@vger.kernel.org>; Thu,  4 Dec 2025 00:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764806842;
	bh=5k031bdZ9Mu+dXIF+y2+BeP4p1iu+Nx/TI05NoGIOek=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Vlbg1PdT0uHXJttEJzEHrRFfmeJpezAjGKGElwiYRZWJ2HSZw0Evv9xbIANhAeWHn
	 RNT/yf5rxn6irWOKEp1X4/2u+ABMqJj/3FFFAqffdFwnuCX8IvzIpL3Yd+nMFD7i6T
	 CEEcROJllldvLHh5dLnAKUrzTwGOPnVs0vzModk6RlIjUjHe4cHy2+6ElSeSRVHsJh
	 t79pxUZOC3Tos+uzsfgNdlcvs1pWLM2hRGocthkEQezCBlWVjNTR+8G4fASaQXbvcZ
	 xGO8SNOOjRHq5kzr62itQbiILnfIjL6EHjF1HD4NUSh9g54nnBzDn80q8Q6GxjecOu
	 wu8F/TFBV/+gA==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so510223a12.0
        for <linux-rdma@vger.kernel.org>; Wed, 03 Dec 2025 16:07:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+Z2ygt/NCwvcAjtd8s2PCWlApmkdhDLyNUGXLX7B0mPSKqeXkHifTNmjRLivpkr4BoG0qacRNIaz7@vger.kernel.org
X-Gm-Message-State: AOJu0YwherDzytvxnXgiUrcdrnaONdnVGCQHLaAeXxdER8sfhKePBrvW
	B4D2ccU91hHMLC1sGSWUfQIs1SCArChs38jprH1nYxJL8ZXSr6vwi/8oCsayeTVGHH1rm5E8PPt
	FmRPbY19MAuXOlUnjf8Wyud0tPkwFAM4=
X-Google-Smtp-Source: AGHT+IHK1NSacj8N0iEpKDdCKuvfwaLmnLH5MToBcFmg/YN85veNJ4tO5vG89PJ0OzdLjzlB0ET/r3RP2EhXm40djVs=
X-Received: by 2002:a17:907:6e89:b0:b3f:cc6d:e0a8 with SMTP id
 a640c23a62f3a-b79ec41fd53mr119310766b.17.1764806840632; Wed, 03 Dec 2025
 16:07:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <35eec2e6-bf37-43d6-a2d8-7a939a68021b@samba.org>
In-Reply-To: <35eec2e6-bf37-43d6-a2d8-7a939a68021b@samba.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 4 Dec 2025 09:07:08 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9p=7BzmSSKi5n41OKkkw4qrr4cWpWet7rUfC+VT-6h1g@mail.gmail.com>
X-Gm-Features: AWmQ_bnT_oPj60e-XBDCKSHcOu1lIZOU6fDnVagcXe5URfuMJg6Z3wqhpyWAxYg
Message-ID: <CAKYAXd9p=7BzmSSKi5n41OKkkw4qrr4cWpWet7rUfC+VT-6h1g@mail.gmail.com>
Subject: Re: Problem with smbdirect rw credits and initiator_depth
To: Stefan Metzmacher <metze@samba.org>
Cc: Tom Talpey <tom@talpey.com>, 
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Metze,

Okay, It seems like the issue has been improved in your v3 branch. If
you send the official patches, I will test it more.

Thanks.

On Thu, Dec 4, 2025 at 3:18=E2=80=AFAM Stefan Metzmacher <metze@samba.org> =
wrote:
>
> Hi Namjae,
>
> I found the problem why the 6.17.9 code of transport_rdma.c deadlocks
> with a Windows client, when using irdma in roce mode, while the 6.18
> code works fine.
>
> irdma/roce in 6.17.9 code =3D> deadlock in wait_for_rw_credits()
> [   T8653] ksmbd: smb_direct: initiator_depth:8 peer_initiator_depth:16
> [   T8653] ksmbd: smb_direct: max_rw_credits:9
> [   T7013] ------------[ cut here ]------------
> [   T7013] needed:31 > max:9
> [   T7013] WARNING: CPU: 1 PID: 7013 at transport_rdma.c:975 wait_for_cre=
dits+0x3b8/0x430 [ksmbd]
>
> When the client starts to send an array with larger number of smb2_buffer=
_desc_v1
> elements in a single SMB2 write request (most likely 31 in the above exam=
ple)
> wait_for_rw_credits() will simply deadlock, as there are only 9 credits p=
ossible
> and 31 are requested.
>
> In the 6.18 code we have commit 0bd73ae09ba1b73137d0830b21820d24700e09b1
> smb: server: allocate enough space for RW WRs and ib_drain_qp()
>
> It makes sure we allocate qp_attr.cap.max_rdma_ctxs and qp_attr.cap.max_s=
end_wr
> correct. qp_attr.cap.max_rdma_ctxs was filled by sc->rw_io.credits.max be=
fore,
> so I changed sc->rw_io.credits.max, but that might need to be split from
> each other.
>
> But after that change we no longer deadlock when the client starts sendin=
g
> larger SMB2 writes, with a larger number of smb2_buffer_desc_v1 elements
> it no longer deadlocks, 159 more than enough.
>
> irdma/roce:
> [   T6505] ksmbd: smb_direct: initiator_depth:8 peer_initiator_depth:16
> ...
> [   T6505] ksmbd: smb_direct: sc->rw_io.credits.num_pages=3D13 sc->rw_io.=
credits.max:159
>
> My current theory about the Mellanox problem is, that the number of pendi=
ng
> RDMA Read operations should be limited by the negotiated initiator_depth,=
 which is at max
> SMB_DIRECT_CM_INITIATOR_DEPTH (8). And we're overflowing the hardware lim=
its by
> posting too much RDMA Read sqes.
>
> The change in 0bd73ae09ba1b73137d0830b21820d24700e09b1 didn't change the
> resulting values of sc->rw_io.credits.max for iwarp devices, it only adju=
sted
> the number for qp_attr.cap.max_send_wr.
>
> So for iwarp we deadlock in both versions of transport_rdma.c, when
> the client starts to send an array of 17 of smb2_buffer_desc_v1 elements
> (I was able to see that using siw on the server, so that tcpdump was
> able to capture it, see:
> https://www.samba.org/~metze/caps/smb2/rdma/linux-6.18-regression/2025-12=
-03/rdma1-siw-r6.18-ace-fixed-hang-01-stream13.pcap.gz
> With roce it's directly using 17:
> https://www.samba.org/~metze/caps/smb2/rdma/linux-6.18-regression/2025-12=
-03/rdma1-rxe-r6.18-race-fixed-rw-credits-reverted-hang-01.pcap.gz
>
> The first few SMB2 writes use 2 smb2_buffer_desc_v1 elements and at the e=
nd
> the Windows client switches to 17 smb2_buffer_desc_v1 elements.
>
> irdma/iwarp:
> [Wed Dec  3 13:45:22 2025] [   T7621] ksmbd: smb_direct: initiator_depth:=
8 peer_initiator_depth:127
> ..
> [Wed Dec  3 13:45:22 2025] [   T7621] ksmbd: smb_direct: sc->rw_io.credit=
s.num_pages=3D256 sc->rw_io.credits.max:9
> ...
> [Wed Dec  3 13:45:22 2025] [   T8638] ------------[ cut here ]-----------=
-
> [Wed Dec  3 13:45:22 2025] [   T8638] needed:17 > max:9
>
>
> siw/iwarp:
> [Wed Dec  3 13:49:30 2025] [   T7621] ksmbd: smb_direct: initiator_depth:=
8 peer_initiator_depth:16
> ...
> [Wed Dec  3 13:49:30 2025] [   T7621] ksmbd: smb_direct: sc->rw_io.credit=
s.num_pages=3D256 sc->rw_io.credits.max:9
> ...
> [Wed Dec  3 13:49:30 2025] [   T9353] ------------[ cut here ]-----------=
-
> [Wed Dec  3 13:49:30 2025] [   T9353] needed:17 > max:9
>
> I've prepared 3 branches for testing:
>
> for-6.18/ksmbd-smbdirect-regression-v1
> https://git.samba.org/?p=3Dmetze/linux/wip.git;a=3Dshortlog;h=3Drefs/head=
s/for-6.18/ksmbd-smbdirect-regression-v1
>
> This has some pr_notice() messages and a WARN_ONCE() when the wait_for_rw=
_credits() happens.
>
> for-6.18/ksmbd-smbdirect-regression-v2
> https://git.samba.org/?p=3Dmetze/linux/wip.git;a=3Dshortlog;h=3Drefs/head=
s/for-6.18/ksmbd-smbdirect-regression-v2
>
> This is based on for-6.18/ksmbd-smbdirect-regression-v1 but reverts
> commit 0bd73ae09ba1b73137d0830b21820d24700e09b1, this might fix your setu=
p.
>
> for-6.18/ksmbd-smbdirect-regression-v3
> https://git.samba.org/?p=3Dmetze/linux/wip.git;a=3Dshortlog;h=3Drefs/head=
s/for-6.18/ksmbd-smbdirect-regression-v3
>
> This reverts everything to the state of v6.17.9 +
> This has some pr_notice() messages and a WARN_ONCE() when the wait_for_rw=
_credits() happens.
>
> Can you please test them with the priority of testing
> for-6.18/ksmbd-smbdirect-regression-v2 first and the others if you have
> more time.
>
> I typically use this running on a 6.18 kernel:
> modprobe ksmbd
> ksmbd.control -s
> rmmod ksmbd
> cd fs/smb/server
> make -j$(getconf _NPROCESSORS_ONLN) -C /lib/modules/$(uname -r)/build M=
=3D$(pwd) KBUILD_MODPOST_WARN=3D1 modules
> insmod ksmbd.ko
> ksmbd.mountd
>
> The in one window:
> bpftrace -e 'kprobe:smb_direct_rdma_xmit { printf("%s: %s pid=3D%d %s\n",=
 strftime("%F %H:%M:%S", nsecs(sw_tai)), comm, pid, func); }'
> And in another window:
> dmesg -T -w
>
>
> I assume the solution is to change smb_direct_rdma_xmit, so that
> it doesn't try to get credits for all RDMA read/write requests at once.
> Instead after collecting all ib_send_wr structures from all rdma_rw_ctx_w=
rs()
> we chunk the list to stay in the negotiated initiator depth,
> before passing to ib_post_send().
>
> At least we need to limit this for RDMA read requests, for RDMA write req=
uests
> we may not need to chunk and post them all together, but still chunking m=
ight
> be good in order to avoid blocking concurrent RDMA sends.
>
> Tom is this assumption correct?
>
> Thanks!
> metze
>

