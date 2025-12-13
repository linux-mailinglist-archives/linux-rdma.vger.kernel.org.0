Return-Path: <linux-rdma+bounces-14984-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B03CBA2DB
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Dec 2025 03:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98A1C3000B32
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Dec 2025 02:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CA723EA97;
	Sat, 13 Dec 2025 02:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNVwcUYr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28BE23E358
	for <linux-rdma@vger.kernel.org>; Sat, 13 Dec 2025 02:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765592085; cv=none; b=ITbBC5SQzzvAPK6+kD03eqbJhB4ib0hys8CpIBrVaA/BpbV736eC3erxow5f1/UCHcCoQSyrHj29wiEh0Ft7mbF1OZbwL2XPzGts+/ht9TpU8dhwnRIt29b/q1BTAINjWERG3/9DvzMQpmRx+SGo+0Hh9yNAuv9d0VVcXzY9ygc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765592085; c=relaxed/simple;
	bh=BeWXYtO9Vh7C2i5AQfViuXzLL1asoIxB/QTiROfg4/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bL7x9/euY0VJH2f2GCUUuppNQtpZcGI4xX3IJt+I6SwIRPw/mfI3+FbmmgmlhGB9dUlp/4XU/MUTk+2ROk5veng7CxQa8WNdZ1SlpysRhO9lchRmNqVmI+ZZTzMtQgv/oj47NEcXgQU5m3mWFv3luV09NGyHdXZ5lmNFWq4hX8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNVwcUYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC39C16AAE
	for <linux-rdma@vger.kernel.org>; Sat, 13 Dec 2025 02:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765592084;
	bh=BeWXYtO9Vh7C2i5AQfViuXzLL1asoIxB/QTiROfg4/8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gNVwcUYryDQuHoXfLjDFxKmlgjmtACo4a+6gYLx+ishzpwvwW5MsmvX5AtF39LJ3k
	 MeYVz7Tj042xVa4s+cjc/1tut1QshqoyZ+kPCpOuewb45NDWNwpBDQs94oBK+5chmW
	 qdD93i4wiyHcuTePytbkEbIDZK8t6Jd2xqat2rw5TKHh3c0x5lggCQLuJK24yVQ5kZ
	 kU25NWKyo02BwOYdd/Y1c00aST+gmAKWu6q3uKiC/804bwHH3YeVuQjaTbJBv7gClK
	 dJTyZQKvX9o7iOElzSMteAAs4IZgtIiY7y3cLB9otb9N9AJcSaS+9h/uc1DpCLSaYr
	 NDpSnOFuTUitw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7370698a8eso235626566b.0
        for <linux-rdma@vger.kernel.org>; Fri, 12 Dec 2025 18:14:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4X5kkVeK1odwrX/9NRctgXXp3MdIBEY5mPCSJYU585eB0jwwsasQ/XCs/78HxlzfZjquph0XPDvfS@vger.kernel.org
X-Gm-Message-State: AOJu0YwLkl1w2nvbKGQWj6AEn7PLGpaFsDhyt9u0EKV0WceifhdQ2jMP
	eNc/eru+ls78uaTp/Yr6HaxPNvqR4MCIgJmfn6B0vhqUCwVtsfvhTZgmGCanDmmnMSJ0qyfPYHG
	5/tpEc0NEpEa0ekRViQo1NXSeeSClKwY=
X-Google-Smtp-Source: AGHT+IG8f8o/pePvXmIPPZj1zf10P5xokIHgvDQ+GhvZjTy1X0sF3rPD4/ifjWXMC/VRDCDyFSpDq7uHQeAjTOydca0=
X-Received: by 2002:a17:907:9617:b0:b76:8163:f1f8 with SMTP id
 a640c23a62f3a-b7d23a7d742mr379528866b.53.1765592083150; Fri, 12 Dec 2025
 18:14:43 -0800 (PST)
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
In-Reply-To: <721eb7b1-dea9-4510-8531-05b2c95cb240@samba.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 13 Dec 2025 11:14:31 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-WTsVEyONDmOMbKseyAp29q71KiUPwGDp2L_a53oL0vg@mail.gmail.com>
X-Gm-Features: AQt7F2rBArEeWijTVbJ6igYRF5Af7eyfIBmsXD2glrmdx56g46JcoSlDAuAmS78
Message-ID: <CAKYAXd-WTsVEyONDmOMbKseyAp29q71KiUPwGDp2L_a53oL0vg@mail.gmail.com>
Subject: Re: Problem with smbdirect rw credits and initiator_depth
To: Stefan Metzmacher <metze@samba.org>
Cc: Tom Talpey <tom@talpey.com>, 
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> I've put these changes a long with rw credit fixes into my
> for-6.18/ksmbd-smbdirect-regression-v4 branch, are you able to
> test this?
Problems still occur. See:

[ 5734.595709] ksmbd: running
[ 5872.277551] ksmbd: smb_direct: dev[rocep1s0f0]: iwarp=0 ib=0 roce=1
v1=1 v2=1 device_cap_flags=0x1425321c36 kernel_cap_flags=0x2e
page_size_cap=0xfffffffffffff000
[ 5872.277575] ksmbd: smb_direct: dev[rocep1s0f0]: max_qp_rd_atom=16
max_qp_init_rd_atom=16 max_fast_reg_page_list_len=65536 max_sgl_rd=3
max_sge_rd=30 max_cqe=4194303 max_qp_wr=8192 max_send_sge=30
max_recv_sge=32
[ 5872.277606] ksmbd: smb_direct: initiator_depth:16 peer_initiator_depth:16
[ 5872.277612] ksmbd: smb_direct: max_send_sges=4
max_read_write_size=8388608 maxpages=2048
[ 5872.277619] ksmbd: smb_direct: sc->rw_io.credits.num_pages=256
sc->rw_io.credits.max:9
[ 5872.278221] ksmbd: smb_direct: max_rdma_ctxs=9 rdma_send_wr=27
[ 5872.294920] ksmbd: smb_direct: dev[rocep1s0f0]: iwarp=0 ib=0 roce=1
v1=1 v2=1 device_cap_flags=0x1425321c36 kernel_cap_flags=0x2e
page_size_cap=0xfffffffffffff000
[ 5872.294929] ksmbd: smb_direct: dev[rocep1s0f0]: max_qp_rd_atom=16
max_qp_init_rd_atom=16 max_fast_reg_page_list_len=65536 max_sgl_rd=3
max_sge_rd=30 max_cqe=4194303 max_qp_wr=8192 max_send_sge=30
max_recv_sge=32
[ 5872.294941] ksmbd: smb_direct: initiator_depth:16 peer_initiator_depth:16
[ 5872.294942] ksmbd: smb_direct: max_send_sges=4
max_read_write_size=8388608 maxpages=2048
[ 5872.294956] ksmbd: smb_direct: sc->rw_io.credits.num_pages=256
sc->rw_io.credits.max:9
[ 5872.295110] ksmbd: smb_direct: dev[rocep1s0f1]: iwarp=0 ib=0 roce=1
v1=1 v2=1 device_cap_flags=0x1425321c36 kernel_cap_flags=0x2e
page_size_cap=0xfffffffffffff000
[ 5872.295116] ksmbd: smb_direct: dev[rocep1s0f1]: max_qp_rd_atom=16
max_qp_init_rd_atom=16 max_fast_reg_page_list_len=65536 max_sgl_rd=3
max_sge_rd=30 max_cqe=4194303 max_qp_wr=8192 max_send_sge=30
max_recv_sge=32
[ 5872.295125] ksmbd: smb_direct: initiator_depth:16 peer_initiator_depth:16
[ 5872.295126] ksmbd: smb_direct: max_send_sges=4
max_read_write_size=8388608 maxpages=2048
[ 5872.295128] ksmbd: smb_direct: sc->rw_io.credits.num_pages=256
sc->rw_io.credits.max:9
[ 5872.295144] ksmbd: smb_direct: max_rdma_ctxs=9 rdma_send_wr=27
[ 5872.295276] ksmbd: smb_direct: max_rdma_ctxs=9 rdma_send_wr=27
[ 5872.301380] ksmbd: smb_direct: dev[rocep1s0f1]: iwarp=0 ib=0 roce=1
v1=1 v2=1 device_cap_flags=0x1425321c36 kernel_cap_flags=0x2e
page_size_cap=0xfffffffffffff000
[ 5872.301386] ksmbd: smb_direct: dev[rocep1s0f1]: max_qp_rd_atom=16
max_qp_init_rd_atom=16 max_fast_reg_page_list_len=65536 max_sgl_rd=3
max_sge_rd=30 max_cqe=4194303 max_qp_wr=8192 max_send_sge=30
max_recv_sge=32
[ 5872.301395] ksmbd: smb_direct: initiator_depth:16 peer_initiator_depth:16
[ 5872.301396] ksmbd: smb_direct: max_send_sges=4
max_read_write_size=8388608 maxpages=2048
[ 5872.301398] ksmbd: smb_direct: sc->rw_io.credits.num_pages=256
sc->rw_io.credits.max:9
[ 5872.301536] ksmbd: smb_direct: max_rdma_ctxs=9 rdma_send_wr=27
[ 5887.761125] ksmbd: smb_direct: disconnected
[ 5887.762410] ksmbd: Failed to send message: -107
[ 5887.762586] ksmbd: Failed to send message: -107
[ 5887.762775] ksmbd: smb_direct: Send error. status='WR flushed (5)', opcode=0
[ 5887.762794] ksmbd: smb_direct: Send error. status='WR flushed (5)', opcode=0
[ 5887.762830] ksmbd: Failed to send message: -107
[ 5887.762860] ksmbd: Failed to send message: -107
[ 5887.762888] ksmbd: Failed to send message: -107
[ 5887.762913] ksmbd: Failed to send message: -107
[ 5887.762967] ksmbd: Failed to send message: -107
[ 5887.763042] ksmbd: Failed to send message: -107
[ 5887.765363] ksmbd: smb_direct: dev[rocep1s0f1]: iwarp=0 ib=0 roce=1
v1=1 v2=1 device_cap_flags=0x1425321c36 kernel_cap_flags=0x2e
page_size_cap=0xfffffffffffff000
[ 5887.765385] ksmbd: smb_direct: dev[rocep1s0f1]: max_qp_rd_atom=16
max_qp_init_rd_atom=16 max_fast_reg_page_list_len=65536 max_sgl_rd=3
max_sge_rd=30 max_cqe=4194303 max_qp_wr=8192 max_send_sge=30
max_recv_sge=32
[ 5887.765416] ksmbd: smb_direct: initiator_depth:16 peer_initiator_depth:16
[ 5887.765422] ksmbd: smb_direct: max_send_sges=4
max_read_write_size=8388608 maxpages=2048
[ 5887.765428] ksmbd: smb_direct: sc->rw_io.credits.num_pages=256
sc->rw_io.credits.max:9
[ 5887.765919] ksmbd: smb_direct: max_rdma_ctxs=9 rdma_send_wr=27

>
> If that works I'll prepare real patches...
>
> Note there's also a for-6.18/ksmbd-smbdirect-regression-v4+ branch,
> but that's only for my own usage with my debug kernel that has some
> backports required for the IPPROTO_SMBDIRECT patches...
>
> metze

