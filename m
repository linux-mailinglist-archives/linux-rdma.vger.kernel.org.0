Return-Path: <linux-rdma+bounces-21350-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKRQJQvoFmruvgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21350-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 14:48:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 190A35E463F
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 14:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C51073019518
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 12:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BF03DFC7C;
	Wed, 27 May 2026 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Rq96XAjY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3416A346766
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779885863; cv=pass; b=LJWzvdi5d5PwrPFA6PHxsOeC/hgYgaRacel0cTx5n+gV1K5SFFmVQGB6m6NxxEIjRJht/4HE8djO1yHalkEJIgnOCg+EqUS08E1BwFb3j3fi6RSxXhVuIpKvJT51Bgv4DDtaUQ9AftLHvIgxJ0pNxRzrS7WLkUkDzr7AvgavQmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779885863; c=relaxed/simple;
	bh=rKGbXXnRzWeaQEyHC0cf0kemgdpBvit5j2YSNFR8sD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ebya5Fo8eW4seQPFWK3ZdsO/1mihz+uYmiHjLQcSwZ8Mlyl9cErjXT5yBYkMD93/yrzK9MzhPakLLdYEEL6IRQrkD19X0X1DKv6cAazkX9dP6ppoXXv0kS+cD8A2iB7SrBKcC9t2hOEbBQakAtIHT2rt511yHk01jS0sPIWVC5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Rq96XAjY; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38ea6a5a0b3so93830421fa.3
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 05:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779885859; cv=none;
        d=google.com; s=arc-20240605;
        b=Nzkn3eFdZyQG59II6Bdizr09TPN5e0WDLSG8DgWlVR8FBBT208QMk5KEf+XP9HNRcR
         RSNSoLTL+OUER64BN80ej97ZzY52yMSba9GOU9hffKgnyYTLYILnbNF1/GORYfu83mM9
         0JhnrqHkABcqybr2tMk01khWRTZPAlWggVzFYVYEV/XhSCoqUtAZr22p72rKCUDS49Dp
         xSgPHosFtLw4xxIkFiyiHsQ3LKKA3iVjzFEHuduPKyB1/sYDxCfcVq1+w4gWcCsKpZ0P
         yT7XDYQHEFR4XffvYLGrDs332seS0rbX/iE8MXBZbfHswGPghZ8A9O7H433StUaXy+nc
         nilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qYq2RP7F78uUAT5YOZEmhrXVmYdKWobwZFZG/FoawmM=;
        fh=jdsbh/ZZgo9UkZ2q2omkg/T6+WHuctsyrhoDmogjoEM=;
        b=WS0u5LC9Tdhw5GL5+u0nY/VTKbosuqo9vW0iULCYHFgNMmKsS0P+wLsseGj/+zbjkf
         fDpuptB9ozd0rjMxIdzmI7A4eq2DqNrMUnu4c1x5LHMERBZOUBMLis/4KL6hWs4g6w61
         StofdLoeDP768nYbw33CKjPUtCU5Iga1RjjiL1rkMLUCcAWlF64AbZgWoSFnCeqn5EP0
         IPsLxfFwKHhNUdsxciizZIr8MlDAJFkH8BQN+KibhPATIs8MKcOvPKcYWG+fGXRLhAKL
         dlxogB3BzXcBIeoan4qwAgaUZ2Bcao7qZNy/yNranF7dzxnlkeoVDdU5dneQD5AYpPWJ
         QqMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1779885859; x=1780490659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYq2RP7F78uUAT5YOZEmhrXVmYdKWobwZFZG/FoawmM=;
        b=Rq96XAjYJ0bCmfwqWVKdMxj8UkueOC8qrqieEVn2pQIDXzhAf/6B3fzbc1AEegOkec
         eaPiO3DDX9n/c2rWRwdt9R8ge2/sfBYaIXSmLGHs9ncjEhnAEdniuSbzADTDk/0U7FBG
         z+oKYrzdi7EAdYdKKq3JFw5/vykWSRkFvbhusqi52uertqJXqR56CiIfE5A3Aa4OPxdh
         +ZDto/1W0cdBwES+bNcq1pmyh3Yz3/oKkPV5GfaGQwjaCaHU8VjXPz5OQUHq8wnEYpg6
         20HqOSJPReM3fpSOxMrbdPs33YnScokzQPKDXeThnFnXRuxqJ3WuikgkqYdASmM3OFbe
         i+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779885859; x=1780490659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qYq2RP7F78uUAT5YOZEmhrXVmYdKWobwZFZG/FoawmM=;
        b=EKZCjwXwewhKzcDYT48gmMSRPuuZcWfDXAJFJFTPCE95rYaO9Rit19mKnIqDYz8Qg6
         qKz+NS0r0WiXyob4FC0n0rq07nRtmdeiOnAZrJEUsA9MNpzXZwAEUHpqt7syB8naZVo5
         F/CmxCYF72UChoHiJDw9cbfgjVihDaeidaBZidEp9i13shtvRFqrFtX16eAKWmWgy4D6
         0DsTh3ZEQMeZxG0XNYBRAtR3uqX0Z/W9CWlmEn55KwNWMxanaEa1uBf/npP5r1oRgw0f
         tBUrcr+dgXJ5fxT2teo15J4NNpAwFVBSyXQYXghCI2vUZ7gsofQ6/XOgG6dfkD0jAYml
         eXqg==
X-Forwarded-Encrypted: i=1; AFNElJ+vMEspcT/JPeULHIEXN4amFYC991nIIFlfJzXe2C86mgNvV0ZMNnkqCMPLngY78ZkfxIriKvvkLaIF@vger.kernel.org
X-Gm-Message-State: AOJu0YyfiPokTkQxK29kYE5fX50qugLwgWhCPxtC7Dbekthjlm8PbZOc
	bJQEG9YTD6tGle97k9tejGrT9ZOBzcg9VOYEDc8En6XqehuFV/i4WZBlfck5sGQIiBSIH7AFtd6
	ZiCmk/NX8EhXRwrGqxpbh8cRb1r09sFEd4jaNvnpxIA==
X-Gm-Gg: Acq92OEyc7A9vrLPfwL7A8psiWcOVI9bxICcd3L872AE+LpklYmRopsY3LZsg3EM9mT
	HkTBsGNSTiaQxwyzh/Rj4Tg+85GdxNUWERkEeT5Nq08fjMiPPnAiUcuA+bvY8h0IAsR5yPg0hVQ
	Wk0eAIQJrKPM2srBQimTHWqYrczR5uDaFKi7EfFXL/IKfNoFfMFhYkQUk3PVsz1u26vU3/IxFjJ
	PSDEmNX2XUuI4rCQzY+ughRsAiIZ9H08Blv3EH1AtGdww7MFgs2eSkFbdBXWv4yHQn8fEcy6EW2
	o53RJ+K92Me9E0Hyp2tBHgE+V7mdbKcYHZ5vvGmLreWkh6Q2P1+M+pZq6Q+zPntIKaPbsn02tif
	6CIMlSedlO7iMAGwF4KWr+V2S5FQxDfyIfQ==
X-Received: by 2002:a05:651c:32d4:b0:38e:97c5:fe20 with SMTP id
 38308e7fff4ca-395d8d8d349mr56711231fa.23.1779885859193; Wed, 27 May 2026
 05:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505074644.195453-1-haris.iqbal@ionos.com> <20260512103424.GR15586@unreal>
In-Reply-To: <20260512103424.GR15586@unreal>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Wed, 27 May 2026 14:44:08 +0200
X-Gm-Features: AVHnY4JbIzKW-7wrGTUabsud434YAg-68Z5-lM-9PCK-aByORojgnGaXhVpogZs
Message-ID: <CAJpMwyg-6Qxskq2ktuhvf46yD5848J9BYLMPPfBLjg2Uzs=xnw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF RFC PATCH 00/13]
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-block@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, axboe@kernel.dk, bvanassche@acm.org, hch@lst.de, 
	jgg@ziepe.ca, jinpu.wang@ionos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUBJ_ALL_CAPS(2.10)[28];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21350-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ionos.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haris.iqbal@ionos.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ionos.com:dkim]
X-Rspamd-Queue-Id: 190A35E463F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 12, 2026 at 12:34=E2=80=AFPM Leon Romanovsky <leon@kernel.org> =
wrote:
>
> On Tue, May 05, 2026 at 09:46:12AM +0200, Md Haris Iqbal wrote:
> > Following a conversation with Bart yesterday, I am sending the RMR+BRMR
> > code through patch for easier review.
> >
> > The patches apply over the for-next branch of the block tree over commi=
t
> > 07dfa981ca3
> >
> > For context,
> > RMR (Reliable Multicast over RTRS) is a kernel module that provides
> > active-active block-level replication over RDMA. It guarantees delivery
> > of IO to a group of storage nodes and handles resynchronization of data
> > directly between storage nodes without involving the compute client.
> >
> > BRMR (Block device over RMR) sits on top of RMR and exposes a standard
> > Linux block device (/dev/brmrX) backed by an RMR pool. Together, RMR an=
d
> > BRMR provide a single-hop replication and resynchronization solution fo=
r
> > RDMA-connected storage clusters.
> >
> > My session is on Wednesday, at 12 in the storage room (Istanbul).
>
> To summarize the discussion:
>
> 1. Move as much logic as possible into the block layer; RDMA should serve
>    strictly as a transport.
> 2. Identify another in=E2=80=91kernel user of this functionality, and add=
 support for
>    it if required. At least accommodate potential users elsewhere in the
>    kernel.

Thanks for the summary Leon.

The main logic which handles multicast/replication legs, missed I/O
tracking, re-synchronization, etc are the core parts of RMR.
If we move those to a separate module, there won't be much left in
RMR. RMR already uses RTRS from the RDMA subsystem as transport.

Having said that, I am not against moving RMR out of the RDMA layer.
It can serve as a reliable replication service/library for any other
user in the kernel to use.
Which subsystem (block or something else) would be a better fit then,
can be discussed.

PS: Would this be a good candidate for a session/discussion in the upcoming=
 LPC?

>
> Thanks

