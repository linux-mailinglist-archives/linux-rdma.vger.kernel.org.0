Return-Path: <linux-rdma+bounces-13162-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256A7B49454
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 17:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1E0177BFA
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 15:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9A62ECEAC;
	Mon,  8 Sep 2025 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GVP+CnHy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A262D5929
	for <linux-rdma@vger.kernel.org>; Mon,  8 Sep 2025 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346896; cv=none; b=BuFNApJp2gWpuUwxBfcIdRLa0iT0tBaIytC/r++F2m2HLiAbjLTpZkYopKbA+hhz7RnIGOPQUgidemWH0IZwi+gmzE4IDfwCuwmTS17JoJAZX0lHVbZpxe++KMswICFiLmNmLjh1FqcIPNuZ0F25bKfsVSG+XZ4q1KLYIgQHj4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346896; c=relaxed/simple;
	bh=P0xNo7V0K3QllSmpWC+z53QHZII4S2LOWxq6niXkyVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mPvsM0akJseqZqy1NZ3zRXO4WHeJVhhTt2d4eW22dgpBj1kdWWZeC0diD0wGm5B7CcI4zGFSHl+61qrV2M2AQcbSdR79bAlNAQLleRMu6FXcOPJw4iGWEQl4QGDijRniPjQFyalej/Av0sLmYlBdAfOglCbcCel3SIeZl4OiZYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GVP+CnHy; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-32c54c31ed9so2219414a91.3
        for <linux-rdma@vger.kernel.org>; Mon, 08 Sep 2025 08:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757346894; x=1757951694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x0w4kPlJzTLuLXnhaHANjEreHJf11veb5lvJ07Ivc2s=;
        b=ga68LY2lgEvDSHHPQladWfEV0W2YgUtk2AC4pTIXMUc2SF9w0Cuf6X/7OiDYJETo+K
         RVL3Hle4jfFuPyu9BYBH0yLTwhsLdhVq+mhGE+KHYHJCPQGjorYjkdgPirO828ZhpjYC
         Ubg2Zf/Ew3cTEndHnxne1FHLsaP7bYCVVpNhSxIWpbMYnVjv8iRScr0Yp91QWhfIjTGq
         pkElXu6LXZFv8HntRMTC+/veswGfAHJwKCwRatwyQKczjZdR8izC4Jnjwqqc5hSGX5Ks
         N479FXPdawcmPU6YQL+se/fu0CYgsz20ySPRgolHh0QOpJOBCrsuUyiicCGOtosbQnLV
         7vgA==
X-Forwarded-Encrypted: i=1; AJvYcCVn6w03ev7Mjr4ldqIUjrMmOlau3NL/KtZvlRCFsVmlBVwA+DLdJBI2+f7xMLmquUeEh4NmFtU3u8Ut@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ9/s8LR7xR5akdFy5sFnZ2UO94XdWgj/gR0VTi47h4d9hK3kr
	qhvm6NgRVUh5yDTWiR7bzgJN0KiTMsce8rj02xMxJH1HBYCviYhguPfDXS7ucCxWOw/o7FHRY/x
	v6s/0iIYarf7RfOaaqXZnvncS+hUCal89jk2sjsT4HT4LYVvqqgeQgSo64jYTyxjgAA39uNSF5h
	QBjEWCgdV4Mgu1PEoTJwOiSBb2FNvNM2VTFzwuQXRdAuzPFhxT+iyIwPUa1V4GLQZf80hDRnE1l
	TCdEUy1Gr9UFF/xkrN9QNTsl/0pzg==
X-Gm-Gg: ASbGncstg/MqE0f6WvVsAkn4HporzOOgh7HJccKSHlzOQ2zdRXU3HmlCHckazcKGoez
	Q4Uhj1u/RTtYM+kN9U2SR/S/ttegN54SJxIB5jyKYmV161y7OU1cgZ3g652L2rdabcINDavoYJz
	khuWIIFf24Ywz/GvEQ/Lr5LE1BTMUGvG4Fvzr+GZN3uEuxIIZBxJhGRtONslj6deDXcqDjxrUUB
	5p2zJY+uO2W6QT/ltI9s+Yfy72JiEO2EZVr1kmlm7BA8mBMhHV9I+pLfdV+ZhY3FcvYLpFmKgTP
	Ee+6cZu8D0Q9breaKpt/1Rr+avu4sk83YZV1wxvDDagdYwPbfXuCa90dIrsZfnD17hhmVhqd/Wn
	4aOfEsQPTIVPlSKfD2hfiInduRyx5+4PaxyGif3xpHPzXKNtvjNe1iB7plimrcsLDAzIziNDhWF
	Zf1GpGft5wQrgebyY=
X-Google-Smtp-Source: AGHT+IFhCuyN/wZzln2WFgDBaSz46hwEb02DcD1zh16Rr1jXhBPtj4vrxO8f4UXHn9FsnffMM9fsLHVMk+Rf
X-Received: by 2002:a17:90a:d444:b0:32b:e3af:3c53 with SMTP id 98e67ed59e1d1-32d43f04faemr10217023a91.14.1757346893386;
        Mon, 08 Sep 2025 08:54:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-32b96dafc4bsm1077108a91.0.2025.09.08.08.54.53
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Sep 2025 08:54:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32bbe7c5b87so2942117a91.3
        for <linux-rdma@vger.kernel.org>; Mon, 08 Sep 2025 08:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757346891; x=1757951691; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x0w4kPlJzTLuLXnhaHANjEreHJf11veb5lvJ07Ivc2s=;
        b=GVP+CnHyuGLV+uzx6ZIfOUCQdik1XPSjouABCCEZVXD5APh8HDMQ7gus7T4YTJlHRV
         gXO4o68nsc9njueKPWAQMl7Zoqkz/6AQrwxOU7A+k+ppnOy30FUcKFkbV1NJFYh88b+I
         kdG9GSEEdihwGTei/rHYURC2B9MLw1DURQn7A=
X-Forwarded-Encrypted: i=1; AJvYcCWhbfALLBvFCWYu0l//62UZl7Sq5ZsrYYcd8jMIcELCKqDibynNSQIRNs7bx8E+L975OzBpwG54LHOj@vger.kernel.org
X-Received: by 2002:a17:90b:4ac9:b0:327:531b:b85c with SMTP id 98e67ed59e1d1-32d43f99cbamr11133167a91.35.1757346891405;
        Mon, 08 Sep 2025 08:54:51 -0700 (PDT)
X-Received: by 2002:a17:90b:4ac9:b0:327:531b:b85c with SMTP id
 98e67ed59e1d1-32d43f99cbamr11133142a91.35.1757346890783; Mon, 08 Sep 2025
 08:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com> <175734586236.468086.14323497345307202416.b4-ty@kernel.org>
In-Reply-To: <175734586236.468086.14323497345307202416.b4-ty@kernel.org>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 8 Sep 2025 21:24:39 +0530
X-Gm-Features: Ac12FXx3YEn7C6Xz12Tubv-IWQXGMfwafg6SZ5dYN4z6O413nX6iIKomcnRTTj8
Message-ID: <CAH-L+nPP+UU_0NQTh_WTNrrJ5t9GraES0x2r=FyvDMW_Wk2tEg@mail.gmail.com>
Subject: Re: [PATCH rdma-next 00/10] RDMA/bnxt_re: Add receive flow steering support
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	michael.chan@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003dff35063e4c35f5"

--0000000000003dff35063e4c35f5
Content-Type: multipart/alternative; boundary="0000000000002c41e5063e4c3516"

--0000000000002c41e5063e4c3516
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leon,

It looks like you have merged V1 of the series. I had already pushed a V2
of the series which fixes an issue in Patch#10.

I can push the changes made in Patch#10 as a follow up patch. Please let me
know.

On Mon, Sep 8, 2025 at 9:07=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:

>
> On Fri, 22 Aug 2025 09:37:51 +0530, Kalesh AP wrote:
> > The RDMA stack allows for applications to create IB_QPT_RAW_PACKET
> > QPs, which receive plain Ethernet packets. This patch adds
> ib_create_flow()
> > and ib_destroy_flow() support in the bnxt_re driver. For now, only the
> > sniffer rule is supported to receive all port traffic. This is to suppo=
rt
> > tcpdump over the RDMA devices to capture the packets.
> >
> > Patch#1 is Ethernet driver change to reserve more stats context to RDMA
> device.
> > Patch#2, #3 and #4 are code refactoring changes in preparation for
> subsequent patches.
> > Patch#5 adds support for unique GID.
> > Patch#6 adds support for mirror vnic.
> > Patch#7 adds support for flow create/destroy.
> > Patch#8 enables the feature by initializing FW with roce_mirror support=
.
> > Patch#9 is to improve the timeout value for the commands by using
> firmware provided message timeout value.
> > Patch#10 is another related cleanup patch to remove unnecessary checks.
> >
> > [...]
>
> Applied, thanks!
>
> [01/10] bnxt_en: Enhance stats context reservation logic
>         https://git.kernel.org/rdma/rdma/c/47bd8cafcbf007
> [02/10] RDMA/bnxt_re: Add data structures for RoCE mirror support
>         https://git.kernel.org/rdma/rdma/c/a99b2425cc6091
> [03/10] RDMA/bnxt_re: Refactor hw context memory allocation
>         https://git.kernel.org/rdma/rdma/c/877d90abaa9eae
> [04/10] RDMA/bnxt_re: Refactor stats context memory allocation
>         https://git.kernel.org/rdma/rdma/c/bebe1a1bb1cff3
> [05/10] RDMA/bnxt_re: Add support for unique GID
>         https://git.kernel.org/rdma/rdma/c/b8f4e7f1a275ba
> [06/10] RDMA/bnxt_re: Add support for mirror vnic
>         https://git.kernel.org/rdma/rdma/c/c23c893e3a02a5
> [07/10] RDMA/bnxt_re: Add support for flow create/destroy
>         https://git.kernel.org/rdma/rdma/c/525b4368864c7e
> [08/10] RDMA/bnxt_re: Initialize fw with roce_mirror support
>         https://git.kernel.org/rdma/rdma/c/d1dde88622b99c
> [09/10] RDMA/bnxt_re: Use firmware provided message timeout value
>         https://git.kernel.org/rdma/rdma/c/d7fc2e1a321cf7
> [10/10] RDMA/bnxt_re: Remove unnecessary condition checks
>         https://git.kernel.org/rdma/rdma/c/dfc78ee86d8f50
>
> Best regards,
> --
> Leon Romanovsky <leon@kernel.org>
>
>
>

--=20
Regards,
Kalesh AP

--0000000000002c41e5063e4c3516
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Leon,<div><br></div><div>It looks like you have merged =
V1 of the series. I had already pushed a V2 of the series which fixes an is=
sue in Patch#10.</div><div><br></div><div>I can push the changes made in Pa=
tch#10 as a follow=C2=A0up patch. Please let me know.</div></div><br><div c=
lass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_=
attr">On Mon, Sep 8, 2025 at 9:07=E2=80=AFPM Leon Romanovsky &lt;<a href=3D=
"mailto:leon@kernel.org">leon@kernel.org</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex"><br>
On Fri, 22 Aug 2025 09:37:51 +0530, Kalesh AP wrote:<br>
&gt; The RDMA stack allows for applications to create IB_QPT_RAW_PACKET<br>
&gt; QPs, which receive plain Ethernet packets. This patch adds ib_create_f=
low()<br>
&gt; and ib_destroy_flow() support in the bnxt_re driver. For now, only the=
<br>
&gt; sniffer rule is supported to receive all port traffic. This is to supp=
ort<br>
&gt; tcpdump over the RDMA devices to capture the packets.<br>
&gt; <br>
&gt; Patch#1 is Ethernet driver change to reserve more stats context to RDM=
A device.<br>
&gt; Patch#2, #3 and #4 are code refactoring changes in preparation for sub=
sequent patches.<br>
&gt; Patch#5 adds support for unique GID.<br>
&gt; Patch#6 adds support for mirror vnic.<br>
&gt; Patch#7 adds support for flow create/destroy.<br>
&gt; Patch#8 enables the feature by initializing FW with roce_mirror suppor=
t.<br>
&gt; Patch#9 is to improve the timeout value for the commands by using firm=
ware provided message timeout value.<br>
&gt; Patch#10 is another related cleanup patch to remove unnecessary checks=
.<br>
&gt; <br>
&gt; [...]<br>
<br>
Applied, thanks!<br>
<br>
[01/10] bnxt_en: Enhance stats context reservation logic<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.kernel.org/rdma/rdma/c/4=
7bd8cafcbf007" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/=
rdma/rdma/c/47bd8cafcbf007</a><br>
[02/10] RDMA/bnxt_re: Add data structures for RoCE mirror support<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.kernel.org/rdma/rdma/c/a=
99b2425cc6091" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/=
rdma/rdma/c/a99b2425cc6091</a><br>
[03/10] RDMA/bnxt_re: Refactor hw context memory allocation<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.kernel.org/rdma/rdma/c/8=
77d90abaa9eae" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/=
rdma/rdma/c/877d90abaa9eae</a><br>
[04/10] RDMA/bnxt_re: Refactor stats context memory allocation<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.kernel.org/rdma/rdma/c/b=
ebe1a1bb1cff3" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/=
rdma/rdma/c/bebe1a1bb1cff3</a><br>
[05/10] RDMA/bnxt_re: Add support for unique GID<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.kernel.org/rdma/rdma/c/b=
8f4e7f1a275ba" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/=
rdma/rdma/c/b8f4e7f1a275ba</a><br>
[06/10] RDMA/bnxt_re: Add support for mirror vnic<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.kernel.org/rdma/rdma/c/c=
23c893e3a02a5" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/=
rdma/rdma/c/c23c893e3a02a5</a><br>
[07/10] RDMA/bnxt_re: Add support for flow create/destroy<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.kernel.org/rdma/rdma/c/5=
25b4368864c7e" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/=
rdma/rdma/c/525b4368864c7e</a><br>
[08/10] RDMA/bnxt_re: Initialize fw with roce_mirror support<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.kernel.org/rdma/rdma/c/d=
1dde88622b99c" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/=
rdma/rdma/c/d1dde88622b99c</a><br>
[09/10] RDMA/bnxt_re: Use firmware provided message timeout value<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.kernel.org/rdma/rdma/c/d=
7fc2e1a321cf7" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/=
rdma/rdma/c/d7fc2e1a321cf7</a><br>
[10/10] RDMA/bnxt_re: Remove unnecessary condition checks<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.kernel.org/rdma/rdma/c/d=
fc78ee86d8f50" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/=
rdma/rdma/c/dfc78ee86d8f50</a><br>
<br>
Best regards,<br>
-- <br>
Leon Romanovsky &lt;<a href=3D"mailto:leon@kernel.org" target=3D"_blank">le=
on@kernel.org</a>&gt;<br>
<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr">Regards,<div>Kalesh AP</div></div></div>

--0000000000002c41e5063e4c3516--

--0000000000003dff35063e4c35f5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJgMIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcN
AQkEMSIEIG5YSA5ikMyrxNMlyXU+QeRe9ZOVKrNF37rgX2Z/x2/gMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDkwODE1NTQ1MVowXAYJKoZIhvcNAQkPMU8wTTAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAKN/HyOGTl074z5/R5OysO151gob
UBEjsX5G2asR//tRFxjsej8MVab21s3DCPRtcwQ+wTc6z0yWS7cHXzzTQuwbHqWTtA5XzaAX3ABD
UrR03HPCLYC1+VeNrmXN6HU+bfPTWPzD0giUXVm+I9aWSEk0FW7IYKk2APhICDLkvmDXY/7MClru
QWF/4Cc+CiCJAsZxvkQtWnA60W+d8Q73e8VF8dSlkFAR/vbM/srTqtulbwPCeMT6v515B17wb6a+
f9pWIuFdRj13ZE6H2L/KBcK6w3W2x1r+CBWZMYzWqgbu8S0ncHSvc+5412DXv1SHzgsUQkYgEOnt
8IcMm4v/KQI=
--0000000000003dff35063e4c35f5--

