Return-Path: <linux-rdma+bounces-16120-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCS4M0W1eWk0ygEAu9opvQ
	(envelope-from <linux-rdma+bounces-16120-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 08:05:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 322E99D947
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 08:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 417AA3021EB1
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 07:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EA62E8B6B;
	Wed, 28 Jan 2026 07:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FOoqjp3m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047A329A30E
	for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 07:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769583854; cv=pass; b=Vcgxnz60IccfgJS5A/gfiCBM5wFDxAYTNJkweyaeUzSgWPJj9MQ/NO7JCZJIYW+m+BXB9gSufAkzUwqF7wxIpVIqo9amE8pTfNUKXvfjQoDCxkY39xUfeTjZnbusLY041PfQV+ycCJp6TLSzrFO1KOqbLHKzgjby5WgXIeOcA6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769583854; c=relaxed/simple;
	bh=KlMrf8PVe5BDNDac9yLQ29sDTXUjzugqK7nFIJ5EmKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1OvNMEtj0QPEwsPh1R+P9G/hVk1NAIGko5fWZAiVFsmLNBkqYJFIGKeE/4JUobjjViK265UL5g4LRiWNLkgJWxll1/omX157SFfapRFbyJjCDV3Bpvtsk/QcuXdQJGx2Au1usr9US+RrBbK8lwklyQKn5lNz8jwYK1J4n0B0uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FOoqjp3m; arc=pass smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-894638da330so73507396d6.1
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 23:04:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769583852; x=1770188652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkGDnMOngowFAW8t+9+qJjq8Cg7avmhI7XOVG93iJ7M=;
        b=CX6ANSxXNq3TDstAxCVVG12mdLZTYGVbNdaEKXc6CXFPMvo13FkpsjfhPWZx76duhR
         1Tw+FlWadneeiJdqCpLhGjqSQKzVlix5Q7qbTF+P72Cz6F5o/vBalKOzrWp5OEYqgRKA
         HtHcpVnitRnwYDXpuLpZr5NtlhLRsdg8LSQ8uEfhZWlxKmEE9bxMSGbHfLC1XYqPPUVX
         fZFCLo0WsJ/Q/TwN6rv5Rf6I02Cjp4/wDWmlOOvF/5+QvFwxxIQW7n4xE/hQy7Nhp5Of
         MAuYQHPJ8uR5ZeDkb1pa+pGKBlNuGJqxUBNXL4nzmV0xcK7BpPW2w7/wkzMGgrRwHGaM
         ZHbQ==
X-Forwarded-Encrypted: i=2; AJvYcCWG48WWYV/ReeNzqm6g9cnDQLWC7Nk/k7NtUii39uqSWICr2JtmFD+5zNVWVtwvM4MjQk9n2pGroq1E@vger.kernel.org
X-Gm-Message-State: AOJu0YxDz3pui4f825u8I6FSmWUoq4uDwUGcWtKUMX0arGpuP4nzYyDV
	xDH9vt4XgzIIfXwikne1FBGjI+81WJaNySRqT8YcrxjzpG+G3JYWqJ35LtWooUMr2s/AjrixNpI
	lzLZlAPrEYH3VNDAhNb2BeyVboH2M9S36Ci/cBO/ATq8JGJo0+8KHMjMwIIOf4tTXeaxU1sriy1
	y2lBv3DqK2CNd79Xd1ovL7YcvO09OdGPLbJwOjTRhkPyKyGcC5QDnjLrZHdY6+QGI1SEx0qlyd1
	4ZcmNOAVQSz7nBuMQ==
X-Gm-Gg: AZuq6aJM9Juul8l/sCVaNRgl+3q3KvhBPOd42ltr+nUGX7h2NjxWhPU2Z4fNX3/NX/b
	D9wLpWUaDmzBQTEMTqsXrDNFnBMBl1FvkRX2vW9eNBirdNtSv/nHY/gW5T4PUCH7IdjMK87SJeP
	Wma2dRMGcS8MVnK3gf2mbUGHbgWFcONHL3DKBcQp5i53461ymeILDqgSwrTRu99jrr3aUwBWp66
	rLNoUtobT01THbvG+qJ0XGJcYA8MT3czjbFrHlk/ubQTDi4aOosfTAULgFChmmXujhRaB+OKP6W
	L19Grf3tS50+1AMmq+qKu8zgCDSGCb6B3k98OQZkYiFjCqKZvl8RY5/TA7k/MVeZ8TeyfinryfL
	aHhiSAteB3m1OaQCG1W0AS0c7LwsCFvz7rKt8V/08+m6kR/CUjEXqjDNGXalkWBisb1F3MG+K/J
	DymW1MXRtEfYTN9iwlUxgRVinYBCD54O8ZrvJyoewyGe8=
X-Received: by 2002:a05:6214:234c:b0:894:7c8b:1213 with SMTP id 6a1803df08f44-894cc8a74ebmr55673956d6.37.1769583851855;
        Tue, 27 Jan 2026 23:04:11 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-894d36c1262sm2383596d6.8.2026.01.27.23.04.11
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jan 2026 23:04:11 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c7166a4643so39732885a.0
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 23:04:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769583851; cv=none;
        d=google.com; s=arc-20240605;
        b=CtLQdIAg/NxA8dtSIvqovlbEoJQILVBvpTkcqY30qnL/jUS5rkBr/Rm7tgefSRuAZF
         OgvpkPOqtHPQ+dWF/jzDdiUFzyxiBpCtdiLHnrc9cc0PaeQiIi4jWkatLxpKuJ/0IU1f
         dMW2ky4kZhFkLMQSn2YiXv3j0VxYTOVvPQWfpEKJ3l4L2kKXAlXlrsU98Hhfm4aQUuBq
         47DRjgRsTeXInZpy5pZ3JpWoKFeBqrrN7Ubttz1utaeegawMYm/Y/DVCqtHS+nmfOek+
         XHJV+PGXLcirBZs++r7Zykgap1kdLzb4OVMVgI4WyGDxyDVXSRqkL0wXnbVOGhWGGFR/
         tNTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tkGDnMOngowFAW8t+9+qJjq8Cg7avmhI7XOVG93iJ7M=;
        fh=IrcLYZ4l7IcINTGnSf//AsPJPXX8CnVv+1Xwn+mgkgQ=;
        b=DxVukGNcYaJOecZQuLWzGQEMv/DoWPleqiKxR07p0VbOme59PCwF3UI0zmB3XVlSl5
         N42DXupAIo+EOdJQzE+3ADZ7uA0SaeSYuV8H676PxFtLN3NlDZbhLxgIysSGzQjewK35
         CQw65FyBPZKurti7wYLjwJjvILPhCXoQTkVVka82wy9FEFQTsbc76B+bP45pPVIslKGI
         pI3gbgRRQUusX+19mKCdsZXmlTTWzW4ANzw2xEQYsVyxBFP7RS08zH16LzFysynvaN9x
         cNMw91buPM2IkTgx+JIV8PFMXbe1K3zpbNDW+7l+nDkQMqlDErsoDMQRQFlUqdr3Ssbg
         fAaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769583851; x=1770188651; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tkGDnMOngowFAW8t+9+qJjq8Cg7avmhI7XOVG93iJ7M=;
        b=FOoqjp3miIgu/FDpbF+d8b7l/A5IKJgSTGkvxPapYM4a+2KEDInaIoKB6tzK6ZZ5j7
         8HUnQujTjfLKKJGDU22d9HqwsBNV9MgdvhiSIVhmHYczG3nVeqlnaTvEj7zWacsZTe/R
         +GzvPbIbi845qyogwMAxfb0uizkrQom8ls9ZM=
X-Forwarded-Encrypted: i=1; AJvYcCW2tJrdkijgPzwGxlFpwJSmChp/ioZ9nMBGP0HqdGkOKDetB4am6gFpDE/M94CC/02Y/zcIniYyH0uA@vger.kernel.org
X-Received: by 2002:a05:620a:2904:b0:8b2:e990:5114 with SMTP id af79cd13be357-8c70b8eef80mr494540585a.42.1769583851125;
        Tue, 27 Jan 2026 23:04:11 -0800 (PST)
X-Received: by 2002:a05:620a:2904:b0:8b2:e990:5114 with SMTP id
 af79cd13be357-8c70b8eef80mr494538685a.42.1769583850650; Tue, 27 Jan 2026
 23:04:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116091808.2028633-1-kalesh-anakkur.purayil@broadcom.com>
 <CAH-L+nNFR8broz0i6ddQPrGL38AO1ZVaSRdXe9AcEafT3Sqeaw@mail.gmail.com> <20260126201857.GP13967@unreal>
In-Reply-To: <20260126201857.GP13967@unreal>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Wed, 28 Jan 2026 12:33:57 +0530
X-Gm-Features: AZwV_QgJRhRRXqkL2_PqlpELFXcQzRHqI06nVI9GB7AxkanTuTebGRHop8qfQwI
Message-ID: <CA+sbYW3dLsVqXcaG9xYdh-YRpdf6-ZjrMKRCBnapMY+gFzoA2w@mail.gmail.com>
Subject: Re: [PATCH rdma-rext 0/4] RDMA/bnxt_re: Add QP rate limit support
To: Leon Romanovsky <leon@kernel.org>
Cc: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>, jgg@ziepe.ca, 
	linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000df855806496d58ca"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16120-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim]
X-Rspamd-Queue-Id: 322E99D947
X-Rspamd-Action: no action

--000000000000df855806496d58ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 1:49=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Sun, Jan 25, 2026 at 09:47:05AM +0530, Kalesh Anakkur Purayil wrote:
> > Hi Leon, Jason,
> >
> > A gentle reminder. Could you please review the patch series?
>
> Sorry for the delayed response. The idea and implementation look fine to =
me.
Thanks you for your response.
> What is missing is a clear and well-documented definition of the semantic=
s
> of QP rate limiting for RC QPs.

man page of ibv_modify_qp doesn't have much information about rate limit

 struct ibv_qp_attr {
...
          uint32_t                rate_limit;             /* Rate
limit in kbps for packet pacing */
       };


attr_mask:IBV_QP_RATE_LIMIT  Set rate_limit

This man page contains only the required field for each transition and
doesn't mention about the optional flags. Do you want us to add a
section for the QP rate limit in the notes?

>
> How should RDMA_READ or small RDMA_REQ packets be treated? Are response
> packets included in the rate limit as well? It must be documented in
> man pages.

All transmitted packets (including rdma_read request and other request
packets) will be part of rate limiting setting for the QP. In our
implementation, the ack packets are not part of the rate limiting of
the normal transmit path. READ data response will be rate limited at
the peer side, if the rate limit is configured on the peer side.

We have another question. Existing implementation of IB_QP_RATE_LIMIT
is applicable only for raw ethernet QP. With this change, we will
start supporting for RC QPs also. So mlx driver can also get this
request for RC QPs, but it will silently ignored as the QP type is not
Raw ethernet QP. Should we fail the request instead?

Thanks,
Selvin Xavier
>
> Thanks
>
> >
> > On Fri, Jan 16, 2026 at 2:43=E2=80=AFPM Kalesh AP
> > <kalesh-anakkur.purayil@broadcom.com> wrote:
> > >
> > > Hi,
> > >
> > > This patchset supports QP rate limit in the bnxt_re driver.
> > >
> > > Broadcom P7 devices supports setting the rate limit while changing
> > > RC QP state from INIT to RTR, RTR to RTS and RTS to RTS. Or, once
> > > the QP is transitioned to RTR or RTS state.
> > >
> > > First patch adds stack support for rate limit for RC QPs.
> > >
> > > Second patch adds support for QP rate limiting in the bnxt_re driver.
> > >
> > > Third patch adds support to report packet pacing capabilities in the
> > > query_device.
> > >
> > > Forth patch adds support to report QP rate limit in debugfs QP info.
> > >
> > > The pull request for rdma-core changes are at:
> > >
> > > https://github.com/linux-rdma/rdma-core/pull/1692
> > >
> > > Regards,
> > > Kalesh
> > >
> > > Kalesh AP (4):
> > >   IB/core: Extend rate limit support for RC QPs
> > >   RDMA/bnxt_re: Add support for QP rate limiting
> > >   RDMA/bnxt_re: Report packet pacing capabilities when querying devic=
e
> > >   RDMA/bnxt_re: Report QP rate limit in debugfs
> > >
> > >  drivers/infiniband/core/verbs.c           |  9 ++++--
> > >  drivers/infiniband/hw/bnxt_re/debugfs.c   | 14 ++++++--
> > >  drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 39 +++++++++++++++++++++=
--
> > >  drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 12 ++++++-
> > >  drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  3 ++
> > >  drivers/infiniband/hw/bnxt_re/qplib_res.h |  6 ++++
> > >  drivers/infiniband/hw/bnxt_re/qplib_sp.c  |  5 +++
> > >  drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  2 ++
> > >  drivers/infiniband/hw/bnxt_re/roce_hsi.h  | 13 +++++---
> > >  include/uapi/rdma/bnxt_re-abi.h           | 16 ++++++++++
> > >  10 files changed, 107 insertions(+), 12 deletions(-)
> > >
> > > --
> > > 2.43.5
> > >
> >
> >
> > --
> > Regards,
> > Kalesh AP
>
>
>

--000000000000df855806496d58ca
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
zJH6Ivyz2skA36zh/px/UmF2ORX4Y0CY6GtU8/vxuN2j4rd2medlyifwALUm+KI3SsD782IwKLCf
8bNhYGiw4YxsbyX7dV7O4SNQc5U9ktrSKH3D4SuTnK/xdjca5PiNI2NTcBVmP7+u2bvVLdRqISop
9dpRkJ6xxhGJjxakljIxHdcZLXltxX4YM0Onf3agcjY3boIqnVlDjBwSZX674ZU+YVrcIlcRcqs/
W83e6PmIRFwpkKOhuLNKSpW5mZoEQdpnxGwE9U7qLGECAwEAAaOCAd4wggHaMA4GA1UdDwEB/wQE
AwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5Bggr
BgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUG
A1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUF
BwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDag
NKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJQYD
VR0RBB4wHIEac2VsdmluLnhhdmllckBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQw
HwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt26AjhRiwoJIwHQYDVR0OBBYEFJA9fV7cOoiN64ws5XPC
J5qtayo5MA0GCSqGSIb3DQEBCwUAA4ICAQBFCIF4AxAiXVz6gX5YfFEbIYtbGFifcfe+QGc5cfac
CSzIrQWUPXAYAef3G5WouD2AKwa2tPGJgK2L7n1r2W4NIvr93588EDVnGgfMfWaFsB8VlLsPlH8Y
fLfaTdN3OQPnFFp54yK9wv8AtTIiTQcailMw7QX5x5GE6HVZElxf0V0Ljc2NrUQLoYzHzAU+sysl
6JQzomxjIfuXiIiUfmnWQdhO95kQchRdOUAaguLTV+RRfPZ1p54dRmgGEpJtzjGLdsrLkZ2rCN5j
cOTTXyxJmvlgm9jfT0Uy5SOPHdq1jtZbQyXrNT4fQ07Odmq3xQCUTi+a59IiC+6V7nFJ8zyCSk+p
n/iGouvun/owYzTmFxB6sVLWZcaWz2Ufcm7b6nOYV+pwUS/n6+6oFRKmGLrl0CRCF0AOph5p81aV
kgKuS5oXBoDefJfjKHuu5lJVelBx3n++iMGMW9FWFmXErCHy2d+L42Raai5X2PL8jAmh+lpPRDX4
CT9jL6xWM5QkCBtxyVKuxGxxUY2wczmVcQ1nGh9mGghI04Scs4OtE8Qh9LMOe2PXzxcV6lpF+yay
B3fwJWxl7miwNFjWuu9M6Z+rcjm3JF5srcAu2fp/VzQD4AE5Kq7ywukMvlU4Y3X2t+D2eU1DH8pk
c8mM1CtQWfWUboaoLABVmYmYfihDvTURkzGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAX
BgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1F
IENBIDIwMjMCDDy76dRYp65lyF2c4zANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg
kdwqWGd+Pu0QPIQx4Fzad9i9B4Kho7M2XSHTIvWa2LYwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYwMTI4MDcwNDExWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAOvRdRkTb5zJ3z7/donlsC2ds+EhVmHIUUAhz
l78VdVFntPicjI3aQVXScbtnp2ejqzs1upkvTQurbFeV4hbXg8fpYjadmeFWr3Gqntc4yNTewti5
qm51KSgtvYWCadyH0r0o8gB2oUfIawybccR81WkI5M8tuLXQ6bVkmiLfca8J/nrmcXTfzQs/0BLm
W3FuWqwkNV06/qgdkEilCIOiWmjoZYStLlq3CdiwhPS+8pwvAr6o+gmxhdT0ZctybMJv6JHZyAau
qzu4xnFP4FQCkqyra0w7td53ZiUFHNHx/0KvAE3IIxg0WGzkZj3OvhzdYQPMJm/C7gtEe5uP2WjA
wQ==
--000000000000df855806496d58ca--

