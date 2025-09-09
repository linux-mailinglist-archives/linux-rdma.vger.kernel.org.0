Return-Path: <linux-rdma+bounces-13185-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B61B4A5F9
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 10:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0123E1755A9
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 08:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FFC3FFD;
	Tue,  9 Sep 2025 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CpaQQxPq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9682749F2
	for <linux-rdma@vger.kernel.org>; Tue,  9 Sep 2025 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407910; cv=none; b=UTtJaBSw9ZIrUtz4scm9Eu8nCP0BzHT/jOoixMzL5V/G9G11VvYN+gOw2tgjtpWOcJvJMt2M1hrtlXi62Whh+8l0VrqXYRbiwY8Ihx5iM8dkMNZZlUyusQ0EkkVVVOSYnVkFASe+b2vnHxMULmJtljIROArDeNmhlnYpr/r4Db4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407910; c=relaxed/simple;
	bh=RaRm7RQ1mWCpEWOJqY2875NzOBWz/SXp5cogkxm0o1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYjPraZqcdiEFfbYIdAph2lYJYeAJ+r9G+urBeeanTWyL4fULqrkVrl9jniUSkbwANV3e2ePkrD5emK/ubLBWinrQQySbr+DsoSVoX/ELhOgRPFmBL0CVfzfoKenPZjY/0d/YEcKX1Gnk7Xz3YGTN0O2xoBDXpYAlYeRf4Q55tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CpaQQxPq; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-71d71bcab6fso49016147b3.0
        for <linux-rdma@vger.kernel.org>; Tue, 09 Sep 2025 01:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757407907; x=1758012707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I49CfRy/OqyXG2Ni3xGM7jObrNhSTeyYNNgjuYA8N0A=;
        b=cicbqKVCONye6oRzSSoiL2vouAQFCDRU00Iungq9RWsbPXxVts9yGgk8kleALPprPA
         xC0s/yiVwEg307hv6Oa40IcD9fJgJh/+DsNKEy5zjolaR4GLCiQEUrGRmW5NYVULT578
         0fM8dlvP4y/2wgVDD6AgoxNXgh2mZudJ79hC7ZwUl4yYNlSt32KD9lPA+BbG9PgztI8q
         nel0/X/UCfsAwPW+X7WyC9SSfTHT/XpMfApCtkfGD1TQ1FWhWHWguKSxdO6jvpLNId+b
         Xr7apT7bapo4deJLDF88vcKM8U8lJBByu2TIFErKcoRnk5eCP/qWXi9e3dk8SIs/rkk4
         hiLw==
X-Forwarded-Encrypted: i=1; AJvYcCXDronwMI/Ijj+7mhRarB1mHc1ze3PYMwy1tK37gjzUC90yECEz4ovyEXVtIgo49JVFiU76oDw6Jbnd@vger.kernel.org
X-Gm-Message-State: AOJu0YzJx0K15rEMmEbUpGrahejZoQGxVSVz8kRStklWMB/up4j6T4rN
	PsdCKgn0MyTzOpCfRWpA7tzx5iiO6OrbGhlT+FDxB05OPe6M4eRuH42JbTcMgMrf2tTEjS+C+/v
	AA9iTzxUKBbEZfZ4LggSU9lhKMjLgWJn+wipjdBfkQmtBfm/5tyoQX1pdVgGJvffRzPVmisD1rL
	Us5gxc/hbMV6UeOALk1b6s4G2dryv7M2ZXGCPDPRiNQQgkJFz83ZogD3+1vaa85Ds8HVyWn3GiB
	InNVt+HShEAT+qH1x20OkWqCLe56A==
X-Gm-Gg: ASbGncvyopntaVHBNfJtInLR7mzPIv3VCALydaGXESPEZGmiX7oroagQbv3/wLmWMSZ
	2qcJSeg5EhO6NIPDkbVr4ksxfui+3o7uUxK/6r3rKPy0YnHeF+kUC74fl5U59FeMZr4j8K6B/Z3
	ytVB0NQgUzE1pVGTnmH0VtL+4QQnV5Sq0dScdD0EfVkOJZwcAkC8HP8UkYArvAvJOnf24YaHaVK
	Fgo8IJRgq+6nLYleh3i8wrYsKXTwWLTbsC5EzvwPVCLeo+NCxTx5LYZO1NwyUkqAuBRP9ELR9TG
	tLoWR2ZDlgv/H4QEfNA+AAzkAYQ6kWZy6E2Ry51xXByiMybuZc326msr0eJ+uGvqrpSgtA0xDwN
	gLN+/pYf03f5VzWC9bqwZ0Bk/9d/U+fOEaxhnx0CIPn04Aco3B4Jdqiz/gZreb8oREZx0apG9P8
	AF2mb7vJHSCmfm
X-Google-Smtp-Source: AGHT+IGm0RgDkHFyajAkBx09gWBr51lO2Jatm8vsPhPB07y6MZvN5peCFQBH5umBSJ5Pkq+wLlzPltzua0qY
X-Received: by 2002:a05:690c:7002:b0:725:9818:1eb0 with SMTP id 00721157ae682-727f563ce65mr109166397b3.35.1757407906853;
        Tue, 09 Sep 2025 01:51:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-724c2f3e990sm11610737b3.26.2025.09.09.01.51.46
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Sep 2025 01:51:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-329e55e686dso8123121a91.3
        for <linux-rdma@vger.kernel.org>; Tue, 09 Sep 2025 01:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757407905; x=1758012705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I49CfRy/OqyXG2Ni3xGM7jObrNhSTeyYNNgjuYA8N0A=;
        b=CpaQQxPq0lCtV0vnc49Oy3OPGebF/c9lzVu7Buut+WsJcXMUWyfWYJWMshekPzfoz5
         ZoNaZ082kCTggh2KZoawYYLgHgNw7/K81THxU+J+Ai7D1ToCPLGMDsL1+k9NoldiKf1p
         qfVKG1U6J8Vls8fTt6n2l/Ih78mHF280E+7ts=
X-Forwarded-Encrypted: i=1; AJvYcCXQYmVDWRF/bbszBgOCwF4J9qI/2gvh8t1Nrpkb6oyg78n7li98VKLpKyUQ/T3MRtnT7CkE/H/H8e+R@vger.kernel.org
X-Received: by 2002:a17:90b:5783:b0:32b:c610:6ef6 with SMTP id 98e67ed59e1d1-32d43fb706amr14182041a91.21.1757407905653;
        Tue, 09 Sep 2025 01:51:45 -0700 (PDT)
X-Received: by 2002:a17:90b:5783:b0:32b:c610:6ef6 with SMTP id
 98e67ed59e1d1-32d43fb706amr14182010a91.21.1757407905182; Tue, 09 Sep 2025
 01:51:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com>
 <175734586236.468086.14323497345307202416.b4-ty@kernel.org>
 <CAH-L+nPP+UU_0NQTh_WTNrrJ5t9GraES0x2r=FyvDMW_Wk2tEg@mail.gmail.com> <20250909081709.GB341237@unreal>
In-Reply-To: <20250909081709.GB341237@unreal>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 9 Sep 2025 14:21:32 +0530
X-Gm-Features: Ac12FXyEHapK-NQ_OIZKekmMaT42Uj_r8sElaod3zCbOkuxOQE2l5OQwx4HCYxM
Message-ID: <CAH-L+nNut2mMh5vG=dBtJGDud4mD1W-VJCsQ87oa_74QhrW7fA@mail.gmail.com>
Subject: Re: [PATCH rdma-next 00/10] RDMA/bnxt_re: Add receive flow steering support
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	michael.chan@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f5e3cb063e5a691a"

--000000000000f5e3cb063e5a691a
Content-Type: multipart/alternative; boundary="000000000000ea129f063e5a69d2"

--000000000000ea129f063e5a69d2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 1:47=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:

> On Mon, Sep 08, 2025 at 09:24:39PM +0530, Kalesh Anakkur Purayil wrote:
> > Hi Leon,
> >
> > It looks like you have merged V1 of the series. I had already pushed a =
V2
> > of the series which fixes an issue in Patch#10.
> >
> > I can push the changes made in Patch#10 as a follow up patch. Please le=
t
> me
> > know.
>
> No need, I fixed it locally.
>

Thank you Leon.

>
> Thanks
>
> >
> > On Mon, Sep 8, 2025 at 9:07=E2=80=AFPM Leon Romanovsky <leon@kernel.org=
> wrote:
> >
> > >
> > > On Fri, 22 Aug 2025 09:37:51 +0530, Kalesh AP wrote:
> > > > The RDMA stack allows for applications to create IB_QPT_RAW_PACKET
> > > > QPs, which receive plain Ethernet packets. This patch adds
> > > ib_create_flow()
> > > > and ib_destroy_flow() support in the bnxt_re driver. For now, only
> the
> > > > sniffer rule is supported to receive all port traffic. This is to
> support
> > > > tcpdump over the RDMA devices to capture the packets.
> > > >
> > > > Patch#1 is Ethernet driver change to reserve more stats context to
> RDMA
> > > device.
> > > > Patch#2, #3 and #4 are code refactoring changes in preparation for
> > > subsequent patches.
> > > > Patch#5 adds support for unique GID.
> > > > Patch#6 adds support for mirror vnic.
> > > > Patch#7 adds support for flow create/destroy.
> > > > Patch#8 enables the feature by initializing FW with roce_mirror
> support.
> > > > Patch#9 is to improve the timeout value for the commands by using
> > > firmware provided message timeout value.
> > > > Patch#10 is another related cleanup patch to remove unnecessary
> checks.
> > > >
> > > > [...]
> > >
> > > Applied, thanks!
> > >
> > > [01/10] bnxt_en: Enhance stats context reservation logic
> > >         https://git.kernel.org/rdma/rdma/c/47bd8cafcbf007
> > > [02/10] RDMA/bnxt_re: Add data structures for RoCE mirror support
> > >         https://git.kernel.org/rdma/rdma/c/a99b2425cc6091
> > > [03/10] RDMA/bnxt_re: Refactor hw context memory allocation
> > >         https://git.kernel.org/rdma/rdma/c/877d90abaa9eae
> > > [04/10] RDMA/bnxt_re: Refactor stats context memory allocation
> > >         https://git.kernel.org/rdma/rdma/c/bebe1a1bb1cff3
> > > [05/10] RDMA/bnxt_re: Add support for unique GID
> > >         https://git.kernel.org/rdma/rdma/c/b8f4e7f1a275ba
> > > [06/10] RDMA/bnxt_re: Add support for mirror vnic
> > >         https://git.kernel.org/rdma/rdma/c/c23c893e3a02a5
> > > [07/10] RDMA/bnxt_re: Add support for flow create/destroy
> > >         https://git.kernel.org/rdma/rdma/c/525b4368864c7e
> > > [08/10] RDMA/bnxt_re: Initialize fw with roce_mirror support
> > >         https://git.kernel.org/rdma/rdma/c/d1dde88622b99c
> > > [09/10] RDMA/bnxt_re: Use firmware provided message timeout value
> > >         https://git.kernel.org/rdma/rdma/c/d7fc2e1a321cf7
> > > [10/10] RDMA/bnxt_re: Remove unnecessary condition checks
> > >         https://git.kernel.org/rdma/rdma/c/dfc78ee86d8f50
> > >
> > > Best regards,
> > > --
> > > Leon Romanovsky <leon@kernel.org>
> > >
> > >
> > >
> >
> > --
> > Regards,
> > Kalesh AP
>
>
>

--=20
Regards,
Kalesh AP

--000000000000ea129f063e5a69d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 9, =
2025 at 1:47=E2=80=AFPM Leon Romanovsky &lt;<a href=3D"mailto:leon@kernel.o=
rg">leon@kernel.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On Mon, Sep 08, 2025 at 09:24:39PM +0530, Kalesh Anakkur=
 Purayil wrote:<br>
&gt; Hi Leon,<br>
&gt; <br>
&gt; It looks like you have merged V1 of the series. I had already pushed a=
 V2<br>
&gt; of the series which fixes an issue in Patch#10.<br>
&gt; <br>
&gt; I can push the changes made in Patch#10 as a follow up patch. Please l=
et me<br>
&gt; know.<br>
<br>
No need, I fixed it locally.<br></blockquote><div><br></div><div>Thank you =
Leon.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Thanks<br>
<br>
&gt; <br>
&gt; On Mon, Sep 8, 2025 at 9:07=E2=80=AFPM Leon Romanovsky &lt;<a href=3D"=
mailto:leon@kernel.org" target=3D"_blank">leon@kernel.org</a>&gt; wrote:<br=
>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; On Fri, 22 Aug 2025 09:37:51 +0530, Kalesh AP wrote:<br>
&gt; &gt; &gt; The RDMA stack allows for applications to create IB_QPT_RAW_=
PACKET<br>
&gt; &gt; &gt; QPs, which receive plain Ethernet packets. This patch adds<b=
r>
&gt; &gt; ib_create_flow()<br>
&gt; &gt; &gt; and ib_destroy_flow() support in the bnxt_re driver. For now=
, only the<br>
&gt; &gt; &gt; sniffer rule is supported to receive all port traffic. This =
is to support<br>
&gt; &gt; &gt; tcpdump over the RDMA devices to capture the packets.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Patch#1 is Ethernet driver change to reserve more stats cont=
ext to RDMA<br>
&gt; &gt; device.<br>
&gt; &gt; &gt; Patch#2, #3 and #4 are code refactoring changes in preparati=
on for<br>
&gt; &gt; subsequent patches.<br>
&gt; &gt; &gt; Patch#5 adds support for unique GID.<br>
&gt; &gt; &gt; Patch#6 adds support for mirror vnic.<br>
&gt; &gt; &gt; Patch#7 adds support for flow create/destroy.<br>
&gt; &gt; &gt; Patch#8 enables the feature by initializing FW with roce_mir=
ror support.<br>
&gt; &gt; &gt; Patch#9 is to improve the timeout value for the commands by =
using<br>
&gt; &gt; firmware provided message timeout value.<br>
&gt; &gt; &gt; Patch#10 is another related cleanup patch to remove unnecess=
ary checks.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [...]<br>
&gt; &gt;<br>
&gt; &gt; Applied, thanks!<br>
&gt; &gt;<br>
&gt; &gt; [01/10] bnxt_en: Enhance stats context reservation logic<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://git.kernel.or=
g/rdma/rdma/c/47bd8cafcbf007" rel=3D"noreferrer" target=3D"_blank">https://=
git.kernel.org/rdma/rdma/c/47bd8cafcbf007</a><br>
&gt; &gt; [02/10] RDMA/bnxt_re: Add data structures for RoCE mirror support=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://git.kernel.or=
g/rdma/rdma/c/a99b2425cc6091" rel=3D"noreferrer" target=3D"_blank">https://=
git.kernel.org/rdma/rdma/c/a99b2425cc6091</a><br>
&gt; &gt; [03/10] RDMA/bnxt_re: Refactor hw context memory allocation<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://git.kernel.or=
g/rdma/rdma/c/877d90abaa9eae" rel=3D"noreferrer" target=3D"_blank">https://=
git.kernel.org/rdma/rdma/c/877d90abaa9eae</a><br>
&gt; &gt; [04/10] RDMA/bnxt_re: Refactor stats context memory allocation<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://git.kernel.or=
g/rdma/rdma/c/bebe1a1bb1cff3" rel=3D"noreferrer" target=3D"_blank">https://=
git.kernel.org/rdma/rdma/c/bebe1a1bb1cff3</a><br>
&gt; &gt; [05/10] RDMA/bnxt_re: Add support for unique GID<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://git.kernel.or=
g/rdma/rdma/c/b8f4e7f1a275ba" rel=3D"noreferrer" target=3D"_blank">https://=
git.kernel.org/rdma/rdma/c/b8f4e7f1a275ba</a><br>
&gt; &gt; [06/10] RDMA/bnxt_re: Add support for mirror vnic<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://git.kernel.or=
g/rdma/rdma/c/c23c893e3a02a5" rel=3D"noreferrer" target=3D"_blank">https://=
git.kernel.org/rdma/rdma/c/c23c893e3a02a5</a><br>
&gt; &gt; [07/10] RDMA/bnxt_re: Add support for flow create/destroy<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://git.kernel.or=
g/rdma/rdma/c/525b4368864c7e" rel=3D"noreferrer" target=3D"_blank">https://=
git.kernel.org/rdma/rdma/c/525b4368864c7e</a><br>
&gt; &gt; [08/10] RDMA/bnxt_re: Initialize fw with roce_mirror support<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://git.kernel.or=
g/rdma/rdma/c/d1dde88622b99c" rel=3D"noreferrer" target=3D"_blank">https://=
git.kernel.org/rdma/rdma/c/d1dde88622b99c</a><br>
&gt; &gt; [09/10] RDMA/bnxt_re: Use firmware provided message timeout value=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://git.kernel.or=
g/rdma/rdma/c/d7fc2e1a321cf7" rel=3D"noreferrer" target=3D"_blank">https://=
git.kernel.org/rdma/rdma/c/d7fc2e1a321cf7</a><br>
&gt; &gt; [10/10] RDMA/bnxt_re: Remove unnecessary condition checks<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://git.kernel.or=
g/rdma/rdma/c/dfc78ee86d8f50" rel=3D"noreferrer" target=3D"_blank">https://=
git.kernel.org/rdma/rdma/c/dfc78ee86d8f50</a><br>
&gt; &gt;<br>
&gt; &gt; Best regards,<br>
&gt; &gt; --<br>
&gt; &gt; Leon Romanovsky &lt;<a href=3D"mailto:leon@kernel.org" target=3D"=
_blank">leon@kernel.org</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; <br>
&gt; -- <br>
&gt; Regards,<br>
&gt; Kalesh AP<br>
<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr">Regards,<div>Kalesh AP</div></div></div></div>

--000000000000ea129f063e5a69d2--

--000000000000f5e3cb063e5a691a
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
AQkEMSIEIJ0vzxenbEiWPU0krWqdYZNCm0WceULp4zaWfK7GEUVGMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDkwOTA4NTE0NVowXAYJKoZIhvcNAQkPMU8wTTAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAA3EtfyF+OW1uhavApWq8aK0FUas
fyemq/aNPdqNZriBd61PK6/r1CMafyD3BzqQuyqDrOysyNhQLo/HX09qu70n1wmHxRz7M4zFyKnP
03XzD9pG3DHvpww4tAyLOjSdHQJA0vkUW5V9f9P7aKcrrXlwkuQEFgYVZtxjWszGZJLLToLTb1+E
YIb7IgK5ckQt2wWfS8lNGkkFnLRN3C+DjWUQs0hKuRHGZWKD2DOtkMLoHzxOQUTD2TFyD6wqgRPe
I5uRkrYdzr3LeyFoMFyeyv2ofqOQTlgyHFZr/WcowNgsWzm3s0qXxlHq3ARcr1qACPXoob1h2XOK
c9KSwQl7tJ8=
--000000000000f5e3cb063e5a691a--

