Return-Path: <linux-rdma+bounces-14898-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7724BCA5E9B
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Dec 2025 03:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06E623019F4E
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Dec 2025 02:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75EC23EAA0;
	Fri,  5 Dec 2025 02:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUp8E0B/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861241D90DD
	for <linux-rdma@vger.kernel.org>; Fri,  5 Dec 2025 02:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764902032; cv=none; b=UFhXbCJj1NfxhUbbSG1Qj80Iuy9hdzi0Z2lBRGKbzWZQQr6dHMpWoVxTi4mMMFFZ6riTd6hGM1qgLG93sJHLb1yFnSnRHKsl40F/A9pGvQzDYHQHsZc398F1Z+aTIY9cWGuuZf0T+GtERXo48yp6pXu3WzDe3gPxlJ9bje4ph6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764902032; c=relaxed/simple;
	bh=COs/o+uEqpSuC/pEq0dwmDK9YdspLnIbywLQQKKHSqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdFZbR3TyMG1hx2I4yjcKgnb4fOYY1/GyO31knjdcrJ/tUbqXex0Sb2KI61ivX/Bv/n3bR2YNIPOlzGOYbbMhtndmfJtvJqzN0HmEb3BcoVU62tzzmzeG2/4ptrE0vs03ZJdvdXTnz5FbvpOmJYT2E26QVfIGISP4ksqN/eC5SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUp8E0B/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB76C4CEFB
	for <linux-rdma@vger.kernel.org>; Fri,  5 Dec 2025 02:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764902032;
	bh=COs/o+uEqpSuC/pEq0dwmDK9YdspLnIbywLQQKKHSqQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EUp8E0B/QS2hF+rnWBQ2zr3J2GKxZw8lK6G72UajSved1HUjn9GrK7NhS0/+1OGEn
	 SZj92X1Za8Z9Ihcw5Q3CR9nBrmSST1vyCYDKyeCd2W5VyMBa1nJtBdfthhBeQfRdDk
	 duAHlaTHFtd0aJWaod/qENWZ/6z+5C5MZYFpexyxg4RP+YAPi4xd28KC0q09DYQ7ft
	 hklC4gffV47YQbkSKgHI4EDuO7INQHxnCZxoD6k+mq/VSRpeoAB9WElIiKjk9IuZCZ
	 RHLqmvI5KM66C1CDsHyt5TDNFe6fh5CfEYJTaxkxRTtgo/yb7KSuxfbWnbWCPaTYq6
	 aveRbtLs07lBw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b735487129fso241119066b.0
        for <linux-rdma@vger.kernel.org>; Thu, 04 Dec 2025 18:33:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjRBBhU/+y4K2kNSwojQT1FUJGpUlP0u+D+N8M+oSFomx4Tkm2EmxwuXCcRrJV6Ox4PWIS0jdMxxpH@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbfy2Yu4p0b9UiApkGhjV11PRpWq/dXsDk0sEtaTSab0XzEPbx
	rnxmJfrHcXpmpE5YyrOmnamarQxeF4hZ0BQ/GdeubavdtBJ3sfFd7WIDu9y2X9u8G6nCSv/dk2U
	iqwAdxrXvEvZvN1qzV30bMvXOHqtb6ZY=
X-Google-Smtp-Source: AGHT+IGtk6bOp92M8I3N7Kd/gLPHcCu4ffXNAntumxTR9V2XawG3acZAiyrFtvmW1UkUTIvl4TNNjftWahhEdFOYm2U=
X-Received: by 2002:a17:907:72cc:b0:b72:d8da:7aac with SMTP id
 a640c23a62f3a-b79dc7aea5amr837634666b.56.1764902030643; Thu, 04 Dec 2025
 18:33:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <35eec2e6-bf37-43d6-a2d8-7a939a68021b@samba.org>
 <CAKYAXd9p=7BzmSSKi5n41OKkkw4qrr4cWpWet7rUfC+VT-6h1g@mail.gmail.com> <f59e0dc7-e91c-4a13-8d49-fe183c10b6f4@samba.org>
In-Reply-To: <f59e0dc7-e91c-4a13-8d49-fe183c10b6f4@samba.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 5 Dec 2025 11:33:37 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-MF1j+CkbWakFJK2ov_SfRUXaRuT6jE0uHZoLxTu130Q@mail.gmail.com>
X-Gm-Features: AQt7F2pGW9XnFLql4QubyyaL3uL3-Xk_HGTop7LuR4AfSmkJw-l438u1BRHNDkM
Message-ID: <CAKYAXd-MF1j+CkbWakFJK2ov_SfRUXaRuT6jE0uHZoLxTu130Q@mail.gmail.com>
Subject: Re: Problem with smbdirect rw credits and initiator_depth
To: Stefan Metzmacher <metze@samba.org>
Cc: Tom Talpey <tom@talpey.com>, 
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 6:40=E2=80=AFPM Stefan Metzmacher <metze@samba.org> =
wrote:
>
> Hi Namjae,
Hi Metze,
>
> > Okay, It seems like the issue has been improved in your v3 branch. If
> > you send the official patches, I will test it more.
>
> It's good to have verified that for-6.18/ksmbd-smbdirect-regression-v3
> on a 6.18 kernel behaves the same as with 6.17.9, as transport_rdma.c
> is the same, but it doesn't really allow forward process on
> the Mellanox problem.
>
> Can you at least post the dmesg output generated by this:
> https://git.samba.org/?p=3Dmetze/linux/wip.git;a=3Dcommitdiff;h=3D7e724eb=
c58e986f4e101a55f4ab5e96912239918
> Assuming that this wasn't triggered:
> if (WARN_ONCE(needed > max_possible, "needed:%u > max:%u\n", needed, max_=
possible))
I didn't know you wanted it. I will share it after office.
>
> Did you run the bpftrace command? Did it print a lot of
> 'smb_direct_rdma_xmit' message over the whole time of the file copy?
No, I didn't check it. but I will try this.
>
> Did you actually copied a file to or from the server?
nod.
>
> Have you actually tested for-6.18/ksmbd-smbdirect-regression-v2,
> as requested? As I was in hope that it would work in the
> same way as for-6.18/ksmbd-smbdirect-regression-v3,
> but with only a single patch reverted.
I tested the v2 patch and the same issues still occurred, but they are
gone in v3.
>
> I'll continue to fix the general problem that this works
> for non Mellanox setups, as it seems it never worked at all :-(
Smbdirect should work well on Mellanox NICs. As I said before, most
people use this. I've rarely seen ksmbd users use smbdirect with
non-Mellanox NICs. If you want to have a stable, long-term smbdirect
feature on Samba, you'll need to have this device.
>
> Where you testing with RoCEv2 or Infiniband?
RoCEv2
>
> I think moving forward for Mellanox setups requires these steps:
> - Test v1 vs. v2 and see that smb_direct_rdma_xmit is actually
>    called at all. And see the dmesg output.
> - Testing with Mellanox RoCEv2 on the client and rxe on
>    the server, so that we can create a network capture with tcpdump.
Okay.
Thanks.
>
> Thanks!
> metze
>
> > Thanks.
> >
> > On Thu, Dec 4, 2025 at 3:18=E2=80=AFAM Stefan Metzmacher <metze@samba.o=
rg> wrote:
> >>
> >> Hi Namjae,
> >>
> >> I found the problem why the 6.17.9 code of transport_rdma.c deadlocks
> >> with a Windows client, when using irdma in roce mode, while the 6.18
> >> code works fine.
> >>
> >> irdma/roce in 6.17.9 code =3D> deadlock in wait_for_rw_credits()
> >> [   T8653] ksmbd: smb_direct: initiator_depth:8 peer_initiator_depth:1=
6
> >> [   T8653] ksmbd: smb_direct: max_rw_credits:9
> >> [   T7013] ------------[ cut here ]------------
> >> [   T7013] needed:31 > max:9
> >> [   T7013] WARNING: CPU: 1 PID: 7013 at transport_rdma.c:975 wait_for_=
credits+0x3b8/0x430 [ksmbd]
> >>
> >> When the client starts to send an array with larger number of smb2_buf=
fer_desc_v1
> >> elements in a single SMB2 write request (most likely 31 in the above e=
xample)
> >> wait_for_rw_credits() will simply deadlock, as there are only 9 credit=
s possible
> >> and 31 are requested.
> >>
> >> In the 6.18 code we have commit 0bd73ae09ba1b73137d0830b21820d24700e09=
b1
> >> smb: server: allocate enough space for RW WRs and ib_drain_qp()
> >>
> >> It makes sure we allocate qp_attr.cap.max_rdma_ctxs and qp_attr.cap.ma=
x_send_wr
> >> correct. qp_attr.cap.max_rdma_ctxs was filled by sc->rw_io.credits.max=
 before,
> >> so I changed sc->rw_io.credits.max, but that might need to be split fr=
om
> >> each other.
> >>
> >> But after that change we no longer deadlock when the client starts sen=
ding
> >> larger SMB2 writes, with a larger number of smb2_buffer_desc_v1 elemen=
ts
> >> it no longer deadlocks, 159 more than enough.
> >>
> >> irdma/roce:
> >> [   T6505] ksmbd: smb_direct: initiator_depth:8 peer_initiator_depth:1=
6
> >> ...
> >> [   T6505] ksmbd: smb_direct: sc->rw_io.credits.num_pages=3D13 sc->rw_=
io.credits.max:159
> >>
> >> My current theory about the Mellanox problem is, that the number of pe=
nding
> >> RDMA Read operations should be limited by the negotiated initiator_dep=
th, which is at max
> >> SMB_DIRECT_CM_INITIATOR_DEPTH (8). And we're overflowing the hardware =
limits by
> >> posting too much RDMA Read sqes.
> >>
> >> The change in 0bd73ae09ba1b73137d0830b21820d24700e09b1 didn't change t=
he
> >> resulting values of sc->rw_io.credits.max for iwarp devices, it only a=
djusted
> >> the number for qp_attr.cap.max_send_wr.
> >>
> >> So for iwarp we deadlock in both versions of transport_rdma.c, when
> >> the client starts to send an array of 17 of smb2_buffer_desc_v1 elemen=
ts
> >> (I was able to see that using siw on the server, so that tcpdump was
> >> able to capture it, see:
> >> https://www.samba.org/~metze/caps/smb2/rdma/linux-6.18-regression/2025=
-12-03/rdma1-siw-r6.18-ace-fixed-hang-01-stream13.pcap.gz
> >> With roce it's directly using 17:
> >> https://www.samba.org/~metze/caps/smb2/rdma/linux-6.18-regression/2025=
-12-03/rdma1-rxe-r6.18-race-fixed-rw-credits-reverted-hang-01.pcap.gz
> >>
> >> The first few SMB2 writes use 2 smb2_buffer_desc_v1 elements and at th=
e end
> >> the Windows client switches to 17 smb2_buffer_desc_v1 elements.
> >>
> >> irdma/iwarp:
> >> [Wed Dec  3 13:45:22 2025] [   T7621] ksmbd: smb_direct: initiator_dep=
th:8 peer_initiator_depth:127
> >> ..
> >> [Wed Dec  3 13:45:22 2025] [   T7621] ksmbd: smb_direct: sc->rw_io.cre=
dits.num_pages=3D256 sc->rw_io.credits.max:9
> >> ...
> >> [Wed Dec  3 13:45:22 2025] [   T8638] ------------[ cut here ]--------=
----
> >> [Wed Dec  3 13:45:22 2025] [   T8638] needed:17 > max:9
> >>
> >>
> >> siw/iwarp:
> >> [Wed Dec  3 13:49:30 2025] [   T7621] ksmbd: smb_direct: initiator_dep=
th:8 peer_initiator_depth:16
> >> ...
> >> [Wed Dec  3 13:49:30 2025] [   T7621] ksmbd: smb_direct: sc->rw_io.cre=
dits.num_pages=3D256 sc->rw_io.credits.max:9
> >> ...
> >> [Wed Dec  3 13:49:30 2025] [   T9353] ------------[ cut here ]--------=
----
> >> [Wed Dec  3 13:49:30 2025] [   T9353] needed:17 > max:9
> >>
> >> I've prepared 3 branches for testing:
> >>
> >> for-6.18/ksmbd-smbdirect-regression-v1
> >> https://git.samba.org/?p=3Dmetze/linux/wip.git;a=3Dshortlog;h=3Drefs/h=
eads/for-6.18/ksmbd-smbdirect-regression-v1
> >>
> >> This has some pr_notice() messages and a WARN_ONCE() when the wait_for=
_rw_credits() happens.
> >>
> >> for-6.18/ksmbd-smbdirect-regression-v2
> >> https://git.samba.org/?p=3Dmetze/linux/wip.git;a=3Dshortlog;h=3Drefs/h=
eads/for-6.18/ksmbd-smbdirect-regression-v2
> >>
> >> This is based on for-6.18/ksmbd-smbdirect-regression-v1 but reverts
> >> commit 0bd73ae09ba1b73137d0830b21820d24700e09b1, this might fix your s=
etup.
> >>
> >> for-6.18/ksmbd-smbdirect-regression-v3
> >> https://git.samba.org/?p=3Dmetze/linux/wip.git;a=3Dshortlog;h=3Drefs/h=
eads/for-6.18/ksmbd-smbdirect-regression-v3
> >>
> >> This reverts everything to the state of v6.17.9 +
> >> This has some pr_notice() messages and a WARN_ONCE() when the wait_for=
_rw_credits() happens.
> >>
> >> Can you please test them with the priority of testing
> >> for-6.18/ksmbd-smbdirect-regression-v2 first and the others if you hav=
e
> >> more time.
> >>
> >> I typically use this running on a 6.18 kernel:
> >> modprobe ksmbd
> >> ksmbd.control -s
> >> rmmod ksmbd
> >> cd fs/smb/server
> >> make -j$(getconf _NPROCESSORS_ONLN) -C /lib/modules/$(uname -r)/build =
M=3D$(pwd) KBUILD_MODPOST_WARN=3D1 modules
> >> insmod ksmbd.ko
> >> ksmbd.mountd
> >>
> >> The in one window:
> >> bpftrace -e 'kprobe:smb_direct_rdma_xmit { printf("%s: %s pid=3D%d %s\=
n", strftime("%F %H:%M:%S", nsecs(sw_tai)), comm, pid, func); }'
> >> And in another window:
> >> dmesg -T -w
> >>
> >>
> >> I assume the solution is to change smb_direct_rdma_xmit, so that
> >> it doesn't try to get credits for all RDMA read/write requests at once=
.
> >> Instead after collecting all ib_send_wr structures from all rdma_rw_ct=
x_wrs()
> >> we chunk the list to stay in the negotiated initiator depth,
> >> before passing to ib_post_send().
> >>
> >> At least we need to limit this for RDMA read requests, for RDMA write =
requests
> >> we may not need to chunk and post them all together, but still chunkin=
g might
> >> be good in order to avoid blocking concurrent RDMA sends.
> >>
> >> Tom is this assumption correct?
> >>
> >> Thanks!
> >> metze
> >>
>

