Return-Path: <linux-rdma+bounces-15039-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68647CC58A3
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 01:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FB4A3010CCC
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 00:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2482A18CC13;
	Wed, 17 Dec 2025 00:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/ilRq/m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C742B9B7
	for <linux-rdma@vger.kernel.org>; Wed, 17 Dec 2025 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765929607; cv=none; b=ESzENLi/eVKPn+4TgF/bqja1bkP4bL/oc/xHxP1HygFFEN1bJ2+mNGo/6Z6FyLmq4u+ZuR7A+bLsvhw7E9DmtBnmsAYnUyr4JcATXM1ovfBWmrtRyCG12ZQs+MzNRUWg+22Ywmwh8vlmf0Ls5Ge4Qr6rSbrPDbeuzzVlAA0oabw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765929607; c=relaxed/simple;
	bh=8mDs+Y7B0dFJfUSgklRCSaX7ME0npJK8zLZZWIFf0B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNTjbN6xSmo89YHxDgHrsimnui/+nBjzSWZLPCGK3jhTiWFpKIAc8bsmYwgUd+DaCQESV9FJGTkN8vtqi5z4xdTtZ/LnFsOtgnZK/083fKf9ht6YsfVbOhnLaR3Ehp17yxWj7kGSnZyGrJq4YHdJNaiao9DWgpaHvECymLQitE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/ilRq/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5779FC19422
	for <linux-rdma@vger.kernel.org>; Wed, 17 Dec 2025 00:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765929607;
	bh=8mDs+Y7B0dFJfUSgklRCSaX7ME0npJK8zLZZWIFf0B8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b/ilRq/mJ/hNRCJe3xtj0ir9L0KzMw39NU+hxbRbSjuaAdh5cTAbbVFSfphSOy84O
	 yLbVej1tloqabbqbJTgwqJs6yRW4Z4GhfHL48RHg/C1MY15pa46yM9R7Dn73UEIe+2
	 +/WZiI+ZMcxpL/ne5od7920lOodQEY1u7gCSYrOIf/bZmrZzhEAsPGfr9oyigL3jyk
	 KJzXd0bdBxfYAcROBxVhT7HNURmkKOKKxgnNX6Km6LamT7R+qB+UN4OA6utkklzi5X
	 RDB9hFLhEHWJMHXW/azobOOM+vUrR2oENcnF52K2EvI+vN4uSrTNJTp7ziCg2wUy0M
	 HA4LPOKR/6E5w==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7636c96b9aso868666366b.2
        for <linux-rdma@vger.kernel.org>; Tue, 16 Dec 2025 16:00:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVhngZnaerqKp5+S78ZbTzWmqRsrfxOA0FTHEEmpU6d8u1lP6vxTy75LYzfLLaeG5Hr0G8KVlHX2whE@vger.kernel.org
X-Gm-Message-State: AOJu0YxM7g23QbgdN8dm5qPXAmMRKkaAgaVawo/UlQCD1DMXuMPyHRVV
	/nUTGhqswvGi9El5FvhD/fwERglpOkicT8nbFhMkqJHLW7CpCZjnV//rqCfRxyjUsDrB/SBhKCq
	1S9k/JL+tKDKORiJvTUX7f+q5Oyo0dUk=
X-Google-Smtp-Source: AGHT+IFp5470iJjp0AKXZtbffSUsVEbXotuciEq7ukUcIQn6rd8W76YieMsVehi0GMfnVV5CCj9JKDa6kODCRdm/YQg=
X-Received: by 2002:a17:907:2715:b0:b7f:fa9c:2462 with SMTP id
 a640c23a62f3a-b7ffa9c3805mr278668366b.3.1765929605793; Tue, 16 Dec 2025
 16:00:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <35eec2e6-bf37-43d6-a2d8-7a939a68021b@samba.org>
 <CAKYAXd9p=7BzmSSKi5n41OKkkw4qrr4cWpWet7rUfC+VT-6h1g@mail.gmail.com>
 <f59e0dc7-e91c-4a13-8d49-fe183c10b6f4@samba.org> <CAKYAXd-MF1j+CkbWakFJK2ov_SfRUXaRuT6jE0uHZoLxTu130Q@mail.gmail.com>
 <CAKYAXd__T=L9aWwOuY7Z8fJgMf404=KQ2dTpNRd3mq9dnYCxRw@mail.gmail.com>
 <86b3c222-d765-4a6c-bb79-915609fa3d27@samba.org> <a3760b26-7458-40a0-ae79-bb94dd0e1d01@samba.org>
 <3c0c9728-6601-41f1-892f-469e83dd7f19@samba.org> <721eb7b1-dea9-4510-8531-05b2c95cb240@samba.org>
 <CAKYAXd-WTsVEyONDmOMbKseyAp29q71KiUPwGDp2L_a53oL0vg@mail.gmail.com>
 <183d92a0-6478-41bb-acb3-ccefd664d62f@samba.org> <ee6873d7-6e47-4d42-9822-cb55b2bfb79e@samba.org>
In-Reply-To: <ee6873d7-6e47-4d42-9822-cb55b2bfb79e@samba.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 17 Dec 2025 08:59:53 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-=e-w+6XzL+yLPKFZAYp468T1Ar7F7dmDDJnS61oniBQ@mail.gmail.com>
X-Gm-Features: AQt7F2pWr5VE-JhicEWXc_JIrgKqCROwYvxm1Pd3tAlnaRqIqkkEJwrbrbYu3xo
Message-ID: <CAKYAXd-=e-w+6XzL+yLPKFZAYp468T1Ar7F7dmDDJnS61oniBQ@mail.gmail.com>
Subject: Re: Problem with smbdirect rw credits and initiator_depth
To: Stefan Metzmacher <metze@samba.org>
Cc: Tom Talpey <tom@talpey.com>, 
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 5:17=E2=80=AFAM Stefan Metzmacher <metze@samba.org>=
 wrote:
>
> Am 14.12.25 um 23:56 schrieb Stefan Metzmacher:
> > Am 13.12.25 um 03:14 schrieb Namjae Jeon:
> >>> I've put these changes a long with rw credit fixes into my
> >>> for-6.18/ksmbd-smbdirect-regression-v4 branch, are you able to
> >>> test this?
> >> Problems still occur. See:
> >
> > :-( Would you be able to use rxe and cake a network capture?
> >
> > Using test files with all zeros, e.g.
> > dd if=3D/dev/zero of=3D/tmp/4096MBzeros-sparse.dat seek=3D4096MB bs=3D1=
 count=3D1
> > would allow gzip --best on the capture file to compress well...
>
> I think I found something that explains it and
> I was able to reproduce and what I have in mind.
>
> We increment recv_io.posted.count after ib_post_recv()
>
> And manage_credits_prior_sending() uses
>
> new_credits =3D recv_io.posted.count - recv_io.credits.count
>
> But there is a race between the hardware receiving a message
> and recv_done being called in order to decrement recv_io.posted.count
> again. During that race manage_credits_prior_sending() might grant
> too much credits.
>
> Please test my for-6.18/ksmbd-smbdirect-regression-v5 branch,
> I haven't tested this branch yet, I'm running out of time
> for the day.
[ 3395.803163] ksmbd: running
[ 3480.416969] perf: interrupt took too long (2547 > 2500), lowering
kernel.perf_event_max_sample_rate to 78500
[ 3576.875490] ksmbd: smb_direct: dev[rocep1s0f0]: iwarp=3D0 ib=3D0 roce=3D=
1
v1=3D1 v2=3D1 device_cap_flags=3D0x1425321c36 kernel_cap_flags=3D0x2e
page_size_cap=3D0xfffffffffffff000
[ 3576.875564] ksmbd: smb_direct: dev[rocep1s0f0]: max_qp_rd_atom=3D16
max_qp_init_rd_atom=3D16 max_fast_reg_page_list_len=3D65536 max_sgl_rd=3D3
max_sge_rd=3D30 max_cqe=3D4194303 max_qp_wr=3D8192 max_send_sge=3D30
max_recv_sge=3D32
[ 3576.875599] ksmbd: smb_direct: initiator_depth:16 peer_initiator_depth:1=
6
[ 3576.875605] ksmbd: smb_direct: max_send_sges=3D4
max_read_write_size=3D8388608 maxpages=3D2048
[ 3576.875612] ksmbd: smb_direct: sc->rw_io.credits.num_pages=3D256
sc->rw_io.credits.max:9
[ 3576.876219] ksmbd: smb_direct: max_rdma_ctxs=3D9 rdma_send_wr=3D27
[ 3576.894371] ksmbd: smb_direct: dev[rocep1s0f1]: iwarp=3D0 ib=3D0 roce=3D=
1
v1=3D1 v2=3D1 device_cap_flags=3D0x1425321c36 kernel_cap_flags=3D0x2e
page_size_cap=3D0xfffffffffffff000
[ 3576.894398] ksmbd: smb_direct: dev[rocep1s0f1]: max_qp_rd_atom=3D16
max_qp_init_rd_atom=3D16 max_fast_reg_page_list_len=3D65536 max_sgl_rd=3D3
max_sge_rd=3D30 max_cqe=3D4194303 max_qp_wr=3D8192 max_send_sge=3D30
max_recv_sge=3D32
[ 3576.894429] ksmbd: smb_direct: initiator_depth:16 peer_initiator_depth:1=
6
[ 3576.894435] ksmbd: smb_direct: max_send_sges=3D4
max_read_write_size=3D8388608 maxpages=3D2048
[ 3576.894442] ksmbd: smb_direct: sc->rw_io.credits.num_pages=3D256
sc->rw_io.credits.max:9
[ 3576.894968] ksmbd: smb_direct: max_rdma_ctxs=3D9 rdma_send_wr=3D27
[ 3576.908669] ksmbd: smb_direct: dev[rocep1s0f0]: iwarp=3D0 ib=3D0 roce=3D=
1
v1=3D1 v2=3D1 device_cap_flags=3D0x1425321c36 kernel_cap_flags=3D0x2e
page_size_cap=3D0xfffffffffffff000
[ 3576.908694] ksmbd: smb_direct: dev[rocep1s0f0]: max_qp_rd_atom=3D16
max_qp_init_rd_atom=3D16 max_fast_reg_page_list_len=3D65536 max_sgl_rd=3D3
max_sge_rd=3D30 max_cqe=3D4194303 max_qp_wr=3D8192 max_send_sge=3D30
max_recv_sge=3D32
[ 3576.908727] ksmbd: smb_direct: initiator_depth:16 peer_initiator_depth:1=
6
[ 3576.908733] ksmbd: smb_direct: max_send_sges=3D4
max_read_write_size=3D8388608 maxpages=3D2048
[ 3576.908740] ksmbd: smb_direct: sc->rw_io.credits.num_pages=3D256
sc->rw_io.credits.max:9
[ 3576.909251] ksmbd: smb_direct: max_rdma_ctxs=3D9 rdma_send_wr=3D27
[ 3576.920882] ksmbd: smb_direct: dev[rocep1s0f1]: iwarp=3D0 ib=3D0 roce=3D=
1
v1=3D1 v2=3D1 device_cap_flags=3D0x1425321c36 kernel_cap_flags=3D0x2e
page_size_cap=3D0xfffffffffffff000
[ 3576.920912] ksmbd: smb_direct: dev[rocep1s0f1]: max_qp_rd_atom=3D16
max_qp_init_rd_atom=3D16 max_fast_reg_page_list_len=3D65536 max_sgl_rd=3D3
max_sge_rd=3D30 max_cqe=3D4194303 max_qp_wr=3D8192 max_send_sge=3D30
max_recv_sge=3D32
[ 3576.920961] ksmbd: smb_direct: initiator_depth:16 peer_initiator_depth:1=
6
[ 3576.920968] ksmbd: smb_direct: max_send_sges=3D4
max_read_write_size=3D8388608 maxpages=3D2048
[ 3576.920974] ksmbd: smb_direct: sc->rw_io.credits.num_pages=3D256
sc->rw_io.credits.max:9
[ 3576.921687] ksmbd: smb_direct: max_rdma_ctxs=3D9 rdma_send_wr=3D27
[ 3594.013976] ksmbd: smb_direct: disconnected
[ 3594.013986] ksmbd: Failed to send message: -107
[ 3594.013992] ksmbd: sock_read failed: -107
[ 3594.014578] ksmbd: Failed to send message: -107
[ 3594.014616] ksmbd: Failed to send message: -107
[ 3594.014632] ksmbd: Failed to send message: -107
[ 3594.014803] ksmbd: Failed to send message: -107
[ 3594.014820] ksmbd: Failed to send message: -107
[ 3594.014833] ksmbd: Failed to send message: -107
[ 3594.014844] ksmbd: Failed to send message: -107
[ 3594.014855] ksmbd: Failed to send message: -107
[ 3594.014866] ksmbd: Failed to send message: -107
[ 3594.014877] ksmbd: Failed to send message: -107
[ 3594.016795] ksmbd: smb_direct: Send error. status=3D'WR flushed (5)', op=
code=3D0
[ 3594.019203] ksmbd: smb_direct: dev[rocep1s0f1]: iwarp=3D0 ib=3D0 roce=3D=
1
v1=3D1 v2=3D1 device_cap_flags=3D0x1425321c36 kernel_cap_flags=3D0x2e
page_size_cap=3D0xfffffffffffff000
[ 3594.019235] ksmbd: smb_direct: dev[rocep1s0f1]: max_qp_rd_atom=3D16
max_qp_init_rd_atom=3D16 max_fast_reg_page_list_len=3D65536 max_sgl_rd=3D3
max_sge_rd=3D30 max_cqe=3D4194303 max_qp_wr=3D8192 max_send_sge=3D30
max_recv_sge=3D32
[ 3594.019279] ksmbd: smb_direct: initiator_depth:16 peer_initiator_depth:1=
6
[ 3594.019287] ksmbd: smb_direct: max_send_sges=3D4
max_read_write_size=3D8388608 maxpages=3D2048
[ 3594.019293] ksmbd: smb_direct: sc->rw_io.credits.num_pages=3D256
sc->rw_io.credits.max:9
[ 3594.020638] ksmbd: smb_direct: max_rdma_ctxs=3D9 rdma_send_wr=3D27
[ 3619.448809] ksmbd: Failed to send message: -107
[ 3619.448825] ksmbd: Failed to send message: -107
[ 3619.448833] ksmbd: Failed to send message: -107
[ 3619.448840] ksmbd: Failed to send message: -107
[ 3619.448846] ksmbd: Failed to send message: -107
[ 3619.449697] ksmbd: smb_direct: Send error. status=3D'WR flushed (5)', op=
code=3D0
[ 3619.449762] ksmbd: Failed to send message: -107
[ 3619.449773] ksmbd: smb_direct: disconnected
[ 3619.453543] ksmbd: smb_direct: dev[rocep1s0f1]: iwarp=3D0 ib=3D0 roce=3D=
1
v1=3D1 v2=3D1 device_cap_flags=3D0x1425321c36 kernel_cap_flags=3D0x2e
page_size_cap=3D0xfffffffffffff000
[ 3619.453552] ksmbd: smb_direct: dev[rocep1s0f1]: max_qp_rd_atom=3D16
max_qp_init_rd_atom=3D16 max_fast_reg_page_list_len=3D65536 max_sgl_rd=3D3
max_sge_rd=3D30 max_cqe=3D4194303 max_qp_wr=3D8192 max_send_sge=3D30
max_recv_sge=3D32
[ 3619.453566] ksmbd: smb_direct: initiator_depth:16 peer_initiator_depth:1=
6
[ 3619.453568] ksmbd: smb_direct: max_send_sges=3D4
max_read_write_size=3D8388608 maxpages=3D2048
[ 3619.453571] ksmbd: smb_direct: sc->rw_io.credits.num_pages=3D256
sc->rw_io.credits.max:9
[ 3619.453770] ksmbd: smb_direct: max_rdma_ctxs=3D9 rdma_send_wr=3D27
[ 3626.073742] ksmbd: smb_direct: dev[rocep1s0f0]: iwarp=3D0 ib=3D0 roce=3D=
1
v1=3D1 v2=3D1 device_cap_flags=3D0x1425321c36 kernel_cap_flags=3D0x2e
page_size_cap=3D0xfffffffffffff000
[ 3626.073753] ksmbd: smb_direct: dev[rocep1s0f0]: max_qp_rd_atom=3D16
max_qp_init_rd_atom=3D16 max_fast_reg_page_list_len=3D65536 max_sgl_rd=3D3
max_sge_rd=3D30 max_cqe=3D4194303 max_qp_wr=3D8192 max_send_sge=3D30
max_recv_sge=3D32
[ 3626.073769] ksmbd: smb_direct: initiator_depth:16 peer_initiator_depth:1=
6
[ 3626.073772] ksmbd: smb_direct: max_send_sges=3D4
max_read_write_size=3D8388608 maxpages=3D2048
[ 3626.073775] ksmbd: smb_direct: sc->rw_io.credits.num_pages=3D256
sc->rw_io.credits.max:9
[ 3626.073995] ksmbd: smb_direct: max_rdma_ctxs=3D9 rdma_send_wr=3D27
[ 3626.087056] ksmbd: Failed to send message: -107
[ 3626.087072] ksmbd: Failed to send message: -107
[ 3626.087097] ksmbd: smb_direct: disconnected
[ 3626.087098] ksmbd: Failed to send message: -107
[ 3626.087104] ksmbd: sock_read failed: -107
[ 3626.087118] ksmbd: Failed to send message: -107
[ 3626.087439] ksmbd: smb_direct: Send error. status=3D'WR flushed (5)', op=
code=3D0
[ 3626.087475] ksmbd: smb_direct: Send error. status=3D'WR flushed (5)', op=
code=3D0
[ 3626.087485] ksmbd: smb_direct: Send error. status=3D'WR flushed (5)', op=
code=3D0
[ 3626.089052] ksmbd: Failed to send message: -107
[ 3626.090507] ksmbd: Failed to send message: -107
[ 3626.090552] ksmbd: Failed to send message: -107
[ 3626.090580] ksmbd: Failed to send message: -107
[ 3626.092896] ksmbd: Failed to send message: -107
[ 3626.092931] ksmbd: Failed to send message: -107
[ 3626.095299] ksmbd: Failed to send message: -107

>
> But I tested it with smbclient and having a similar
> logic in fs/smb/common/smbdirect/smbdirect_connection.c
>
> metze

