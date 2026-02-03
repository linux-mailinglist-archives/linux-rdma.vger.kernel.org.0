Return-Path: <linux-rdma+bounces-16491-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FtqA759gmnAVQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16491-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 23:59:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF46DF794
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 23:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 888E6309C972
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 22:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5880536CDF7;
	Tue,  3 Feb 2026 22:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqwgUlF/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEB6310763
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770159547; cv=none; b=SPn8RKwTGZc52je8WcfsEiwAF/E56f0U7ogBFUGOXRt/QdCzl/9TyIt91lg1TIxBkMbbfbkNrJw5WhDbTu3Jsq9KMdQj8OuolFNeXBsXunxaWVVwEjr+rD8B2pmRU6nFYFl1cur8WVuZuK3FUvmdcrdoRxsfoUA0dWoYIx+Zulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770159547; c=relaxed/simple;
	bh=tJNadpiFM50O70Wa/xME6qyZkIQ571lLqhqsljcE//s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5/YW3J7oUUE9aqP/2yji1JYx3WcjTI4qBabxLoVGau14wTeY1gDaFJIxkq372ZpmJ4kvcICiOBHDWeCXssN+Nk3F2vWUwnYuir9/ttCJFxR1eTwGZQ90c5TYF/iZI7GgQMeDbbXl3spLasU9LqAu245CgxUWTSh2cZ+sakhTzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqwgUlF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AB9C116D0
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 22:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770159546;
	bh=tJNadpiFM50O70Wa/xME6qyZkIQ571lLqhqsljcE//s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AqwgUlF/wVShQbmJtrZJ3WLq/OV3bTA7D2dkMjFZe7PJewiemClCJ9fBY4uLa5lvx
	 Nlud1I9Nx0cID63r3SMYDWwMGhRhD2HohuzyWBISEjlIeQiyum/V2wV29+nEfvOAwy
	 X7iImRKP1gmYl1iZhazJoi33jrcnWZWOROdSCt/nttMYWI+dJlZ75uY/ze2BUAgDgm
	 HcGtqbamfOjVmkZpNrBEV75hb6XI6HaYJcae/nA2wQ5VqAg/cLv1rTI1WLuzhrLyhT
	 vxrpRvzFb1oiSsNwCeIm4S/pX2TmATAYbC53355OWVtHuW5Y5l8kc1iCCOTZWHWdqs
	 OQZ6SBi3+gYlg==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so515633a12.0
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 14:59:06 -0800 (PST)
X-Gm-Message-State: AOJu0Yw37+ck0y2GQuAKGj/08Pfv0r0CviGXXypN1SyPV6V0YJZKrqKR
	pVDk2OtlFi0dZIDW+Cm4XutAZbFOzDm2qccnv4nWiyHplznC6O5VMguAjj/atctMK081QtVg0oK
	yeW95lgxcfV3GiTbsJ8CaE1NitQ+YQHE=
X-Received: by 2002:a17:907:971b:b0:b87:85f:4598 with SMTP id
 a640c23a62f3a-b8e837d96bbmr290314266b.14.1770159545347; Tue, 03 Feb 2026
 14:59:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769025321.git.metze@samba.org>
In-Reply-To: <cover.1769025321.git.metze@samba.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 4 Feb 2026 07:58:52 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-eyYhh9E2zkiraJX0ihct=yEpx-tgQvpAJ0fK+q1oUQQ@mail.gmail.com>
X-Gm-Features: AZwV_QiaxFV2_vq5ig4lbGmwCExyMJg3gUgo8OLH5hhxOtefqrfin2SeP-FVFIQ
Message-ID: <CAKYAXd-eyYhh9E2zkiraJX0ihct=yEpx-tgQvpAJ0fK+q1oUQQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] RDMA/smbdirect: introduce and use rdma_restrict_node_type()
To: Stefan Metzmacher <metze@samba.org>
Cc: linux-rdma@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Steve French <smfrench@gmail.com>, Tom Talpey <tom@talpey.com>, 
	Long Li <longli@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.samba.org,ziepe.ca,kernel.org,gmail.com,talpey.com,microsoft.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16491-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8FF46DF794
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 5:07=E2=80=AFAM Stefan Metzmacher <metze@samba.org>=
 wrote:
>
> Hi,
>
> for smbdirect it required to use different ports depending
> on the RDMA protocol. E.g. for iWarp 5445 is needed
> (as tcp port 445 already used by the raw tcp transport for SMB),
> while InfiniBand, RoCEv1 and RoCEv2 use port 445, as they
> use an independent port range (even for RoCEv2, which uses udp
> port 4791 itself).
>
> Currently ksmbd is not able to function correctly at
> all if the system has iWarp (RDMA_NODE_RNIC) interface(s)
> and any InfiniBand, RoCEv1 and/or RoCEv2 interface(s)
> at the same time.
>
> And cifs.ko uses 5445 with a fallback to 445, which
> means depending on the available interfaces, it tries
> 5445 in the RoCE range or may tries iWarp with 445
> as a fallback. This leads to strange error messages
> and strange network captures.
>
> To avoid these problems they will be able to
> use rdma_restrict_node_type(RDMA_NODE_RNIC) before
> trying port 5445 and rdma_restrict_node_type(RDMA_NODE_IB_CA)
> before trying port 445. It means we'll get early
> -ENODEV early from rdma_resolve_addr() without any
> network traffic and timeouts.
>
> This is marked as RFC as I want to get feedback
> if the rdma_restrict_node_type() function is acceptable
> for the RDMA layer. And because the current form of
> the smb patches are not tested, I only tested the
> rdma part with my branch the prepares IPPROTO_SMBDIRECT
> sockets.
>
> I'm not sure if this would be acceptable for 6.19
> in order to avoid the smb layer problems, if the
> RDMA layer change is only acceptable for 7.0 that's
> also fine.
>
> This is based on the following fix applied:
> smb: server: reset smb_direct_port =3D SMB_DIRECT_PORT_INFINIBAND on init
> https://lore.kernel.org/linux-cifs/20251208154919.934760-1-metze@samba.or=
g/
> It's not yet in Linus' tree, so if this gets ready
> before it's merged we can squash it.
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
>
> Stefan Metzmacher (3):
>   RDMA/core: introduce rdma_restrict_node_type()
>   smb: client: make use of rdma_restrict_node_type()
>   smb: server: make use of rdma_restrict_node_type()
>
>  drivers/infiniband/core/cma.c      |  30 ++++++++
>  drivers/infiniband/core/cma_priv.h |   1 +
>  fs/smb/client/smbdirect.c          |  26 +++++++
>  fs/smb/server/transport_rdma.c     | 108 +++++++++++++++++++++--------
>  include/rdma/rdma_cm.h             |  17 +++++
>  5 files changed, 154 insertions(+), 28 deletions(-)
>
> --
> 2.43.0
>

