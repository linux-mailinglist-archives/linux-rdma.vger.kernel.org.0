Return-Path: <linux-rdma+bounces-3116-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C169067AE
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 10:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BE1DB29D7D
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 08:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D3F142E7A;
	Thu, 13 Jun 2024 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ELIvyx4j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB931142E6F
	for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2024 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268555; cv=none; b=hDjmnAToHVHYRn9qnO68KLtzsxM6FwYWDznv5EXr/RgMfbI4odnd1ocI0luOc3EUonQt8kmjGuq5f5YDUbjUHm0BS2WeSpGc+ndXC0c+q06UqJZa5YRk6VxC8M2aqV30AdFcA9CDksxhBITERDaxvYbYV+XsGU05VQvXaTqhUVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268555; c=relaxed/simple;
	bh=FwvamT4r98U3jkfDnvv+lFX5M6eNGQ0Dbu8sL8/1ubc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8JjT2ejQZ6iTZxD0kLDlk66e4VuNjKDDT3l29FbHhxGRinBM+XNh899rVGWVuH39QHncL7BwVmkPEv48QYlzTzeDWk434EVuMLdQNKK89lWTzRdnGZLf9AaxCUWbR7REVrxWnRqv0819sLoFwSx4hJkOYITkKXphF+SETpecSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ELIvyx4j; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dff0c685292so123583276.3
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2024 01:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718268553; x=1718873353; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OgaSDFx5g/efpek5UIsMWS56g/HKQ0WbWG+OaS73xX8=;
        b=ELIvyx4jWKl6Rh+tUbcyc2Vn+e0tIS4KUaS9xHAG7rxKFeU0Y3uDHEggvcF5UUqkrQ
         PKXjKePRLPmEiYChOHsU8VANHHR/v8BI0ZkJIKwnmsrKDU/cYiTh0IFyWLycao2QjdFJ
         L64QkRobGvSZ14k75Fg77wHR4Ddu08CXetXX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718268553; x=1718873353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OgaSDFx5g/efpek5UIsMWS56g/HKQ0WbWG+OaS73xX8=;
        b=GjBSD0rq/6XJreTHWfBuhPUPIypl41XvCWuYOojpmxQDCAQ/yDnp5vNdCSklK+lqAb
         uhf1ZQd45tqQFw00qmSmpnzkrTfS0yfSpFLhb2SRz8AinIAh1K2s/E6HWwb7VOfn2d2m
         n0u2a0VBk1sGU4XIsljtK9hVDOtYcefLvrgtdVjRe7ZnNXfAyl+p7JZXEgzN/m783jyi
         Mx4zNOirG0531gvoPGxHOwuST8zHnVg7uG4OclfgagCtIKqurfq1gB9lAuVZwmNR0pIF
         40KsdBAGpfcXxX4f1afjBgzm+h1MRl35kixKNnNaswSbnmuEFN4okgI5F0fA40jtC8S6
         HJew==
X-Gm-Message-State: AOJu0YzbpWIxV0FlAdmOi9U+KaUXYKX50l+EUtM45mgljA58vXW8G/AN
	UqCwc48jGdhuKaA88XHO9ebaP44XdAZQmU0ROktSWSV/Yyyf90c2vVNeGMT6z9cKlOmqVNb1UeR
	3o56tleod4Yy+ZZ5BavW9DPPR5z4pikDiGiis4IenYuolcrWurg==
X-Google-Smtp-Source: AGHT+IGFnuT+PX2SiCUMbWsYwc1ziJMyx0rshfhu8RkVQcC2Q0YLyHBXcA1QtFK1JOuW5t7MefvE4ry7zQ7cqBcxw7g=
X-Received: by 2002:a25:ae24:0:b0:dfa:72cc:f88b with SMTP id
 3f1490d57ef6-dfe68c0ab1cmr4408964276.52.1718268552785; Thu, 13 Jun 2024
 01:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87jziucdlj.fsf@daath.pimeys.fr> <87frticdf8.fsf@daath.pimeys.fr>
 <CA+sbYW1bONzFsrKAD+NLbBEuSDvqdZ+mPT1srwXrp67go6GRaQ@mail.gmail.com> <a4281961-3b17-4cbd-9a6f-1d0ddcd26be8@debian.org>
In-Reply-To: <a4281961-3b17-4cbd-9a6f-1d0ddcd26be8@debian.org>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Thu, 13 Jun 2024 14:19:00 +0530
Message-ID: <CA+sbYW3YQW0jMBRv4hrQQ48JkLNEHuA_dhgTTqfd+zqGxx20kg@mail.gmail.com>
Subject: Re: What's the current status with bnxt_re-abi.h
To: =?UTF-8?Q?Pierre=2DElliott_B=C3=A9cue?= <peb@debian.org>
Cc: linux-rdma@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000bcec29061ac19230"

--000000000000bcec29061ac19230
Content-Type: multipart/alternative; boundary="000000000000b7db44061ac19212"

--000000000000b7db44061ac19212
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 11:59=E2=80=AFPM Pierre-Elliott B=C3=A9cue <peb@deb=
ian.org>
wrote:

> De : Selvin Xavier <selvin.xavier@broadcom.com>
> =C3=80 : Pierre-Elliott B=C3=A9cue <peb@debian.org>
> Cc : linux-rdma@vger.kernel.org
> Date : 12 juin 2024 19:18:34
> Objet : Re: What's the current status with bnxt_re-abi.h
>
> > Hi,
> > bnxt_re-abi.h in linux kernel and rdma-core uses abi version 1. We
> > dont bump up the version in upstream and backward compatibility is
> > maintained using the comp_mask field of the interface structures.
> >
> > If you are using the latest drivers maintained in the Broadcom site
> > (which uses ABI version 6), you need to use the libbnxt_re hosted in
> > the Broacom site itself. We maintain compatibility between the Out of
> > tree driver and Out of tree library.
> >
> > Thanks,
> > Selvin
> >
> > On Wed, Jun 12, 2024 at 10:21=E2=80=AFPM Pierre-Elliott B=C3=A9cue <peb=
@debian.org>
> wrote:
> >>
> >> Pierre-Elliott B=C3=A9cue <peb@debian.org> wrote on 12/06/2024 at
> 18:47:36+0200:
> >>
> >>> Hello,
> >>>
> >>> In bnxt_re-abi.h, the abi version mentioned is 1. It's used as it's i=
n
> >>> all libibverbs to determine the min AND max supported ABI.
> >>>
> >>> bnxt_re isn't currently mainlined in the kernel,
> >>
> >> Sorry, a word is missing: "Recent bnxt_re isn't currently mainlined"
> >>
> >>> and those eager to use
> >>> the driver need to rely on the one provided by broadcom on their
> >>> website.
> >>>
> >>> The thing is, they bumped their ABI version multiple times (current i=
s
> >>> 6). In the current context, one can't use the manually compiled bnxt_=
re
> >>> driver with libibverbs as any call will error due to the bnxt_re abi
> >>> version being outside of min/max supported abi version.
> >>>
> >>> What's the current situation regarding bnxt_re, should we consider
> >>> libibverb support of bnxt_re as deprecated?
> >>>
> >>> Of course I could have missed something, sorry for that if that's the
> >>> case.
> >>>
> >>> Bests,
> Hey Selvin,
>
> Thanks a lot for clarifying this.
>
> I built libbnxt_re, but the thing is, I can't use the usual infiniband
> tooling (ib_write_bw) et al without using libibverbs which is still the
> linux-rdma one.
>
> Do you have an alternative to suggest that I should consider?
>
It should work fine with the libibverbs installed by linux-rdma-core. The
Broadcom support team can help you with the necessary instructions. I will
forward your mail to them and they will  help.

>
> Also, would a RDMA+SRIOV-capable broadcom card with the latest firmware
> (229 something) work fine with the drivers shipped in rdma-core.
>
> If so maybe I should use what's provided by the kernel and rdma-core.
>
The drivers shipped with rdma-core and kernel should work for most of your
use cases. I suggest you try this.

>
> Bests,
>
> --
> Pierre-Elliott B=C3=A9cue
>

--000000000000b7db44061ac19212
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 12, 2024 at 11:59=E2=80=
=AFPM Pierre-Elliott B=C3=A9cue &lt;<a href=3D"mailto:peb@debian.org">peb@d=
ebian.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">De : Selvin Xavier &lt;<a href=3D"mailto:selvin.xavier@broadcom.=
com" target=3D"_blank">selvin.xavier@broadcom.com</a>&gt;<br>
=C3=80 : Pierre-Elliott B=C3=A9cue &lt;<a href=3D"mailto:peb@debian.org" ta=
rget=3D"_blank">peb@debian.org</a>&gt;<br>
Cc : <a href=3D"mailto:linux-rdma@vger.kernel.org" target=3D"_blank">linux-=
rdma@vger.kernel.org</a><br>
Date : 12 juin 2024 19:18:34<br>
Objet : Re: What&#39;s the current status with bnxt_re-abi.h<br>
<br>
&gt; Hi,<br>
&gt; bnxt_re-abi.h in linux kernel and rdma-core uses abi version 1. We<br>
&gt; dont bump up the version in upstream and backward compatibility is<br>
&gt; maintained using the comp_mask field of the interface structures.<br>
&gt; <br>
&gt; If you are using the latest drivers maintained in the Broadcom site<br=
>
&gt; (which uses ABI version 6), you need to use the libbnxt_re hosted in<b=
r>
&gt; the Broacom site itself. We maintain compatibility between the Out of<=
br>
&gt; tree driver and Out of tree library.<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Selvin<br>
&gt; <br>
&gt; On Wed, Jun 12, 2024 at 10:21=E2=80=AFPM Pierre-Elliott B=C3=A9cue &lt=
;<a href=3D"mailto:peb@debian.org" target=3D"_blank">peb@debian.org</a>&gt;=
 wrote:<br>
&gt;&gt; <br>
&gt;&gt; Pierre-Elliott B=C3=A9cue &lt;<a href=3D"mailto:peb@debian.org" ta=
rget=3D"_blank">peb@debian.org</a>&gt; wrote on 12/06/2024 at 18:47:36+0200=
:<br>
&gt;&gt; <br>
&gt;&gt;&gt; Hello,<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; In bnxt_re-abi.h, the abi version mentioned is 1. It&#39;s use=
d as it&#39;s in<br>
&gt;&gt;&gt; all libibverbs to determine the min AND max supported ABI.<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; bnxt_re isn&#39;t currently mainlined in the kernel,<br>
&gt;&gt; <br>
&gt;&gt; Sorry, a word is missing: &quot;Recent bnxt_re isn&#39;t currently=
 mainlined&quot;<br>
&gt;&gt; <br>
&gt;&gt;&gt; and those eager to use<br>
&gt;&gt;&gt; the driver need to rely on the one provided by broadcom on the=
ir<br>
&gt;&gt;&gt; website.<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; The thing is, they bumped their ABI version multiple times (cu=
rrent is<br>
&gt;&gt;&gt; 6). In the current context, one can&#39;t use the manually com=
piled bnxt_re<br>
&gt;&gt;&gt; driver with libibverbs as any call will error due to the bnxt_=
re abi<br>
&gt;&gt;&gt; version being outside of min/max supported abi version.<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; What&#39;s the current situation regarding bnxt_re, should we =
consider<br>
&gt;&gt;&gt; libibverb support of bnxt_re as deprecated?<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; Of course I could have missed something, sorry for that if tha=
t&#39;s the<br>
&gt;&gt;&gt; case.<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; Bests,<br>
Hey Selvin,<br>
<br>
Thanks a lot for clarifying this.<br>
<br>
I built libbnxt_re, but the thing is, I can&#39;t use the usual infiniband =
tooling (ib_write_bw) et al without using libibverbs which is still the lin=
ux-rdma one.<br>
<br>
Do you have an alternative to suggest that I should consider?<br></blockquo=
te><div>It should work fine with the libibverbs installed by linux-rdma-cor=
e. The Broadcom support team can help you with the necessary instructions. =
I will forward your mail to them and they will=C2=A0 help.</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
Also, would a RDMA+SRIOV-capable broadcom card with the latest firmware (22=
9 something) work fine with the drivers shipped in rdma-core.<br>
<br>
If so maybe I should use what&#39;s provided by the kernel and rdma-core.<b=
r></blockquote><div>The drivers shipped with rdma-core and kernel should wo=
rk for most of your use cases. I suggest you try this.=C2=A0=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Bests,<br>
<br>
-- <br>
Pierre-Elliott B=C3=A9cue<br>
</blockquote></div></div>

--000000000000b7db44061ac19212--

--000000000000bcec29061ac19230
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
FYMZp2DojLAq9f4Oi2OBetbnWxo0WGycXpmq/jC4PUx2u9mazQ79i80VLagGRshWniESXuf+SYG8
+zBimjld9ZZnwm7itHAZdtme4YYFxx+EHa4PUxPV8t+hPHhsiIjirPa1pVXPbQIDAQABo4IB2zCC
AdcwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU3TaH
dsgUhTW3LwObmZ20fj+8Xj8wDQYJKoZIhvcNAQELBQADggEBAAbt6Sptp6ZlTnhM2FDhkVXks68/
iqvfL/e8wSPVdBxOuiP+8EXGLV3E72KfTTJXMbkcmFpK2K11poBDQJhz0xyOGTESjXNnN6Eqq+iX
hQtF8xG2lzPq8MijKI4qXk5Vy5DYfwsVfcF0qJw5AhC32nU9uuIPJq8/mQbZfqmoanV/yadootGr
j1Ze9ndr+YDXPpCymOsynmmw0ErHZGGW1OmMpAEt0A+613glWCURLDlP8HONi1wnINV6aDiEf0ad
9NMGxDsp+YWiRXD3txfo2OMQbpIxM90QfhKKacX8t1J1oAAWxDrLVTJBXBNvz5tr+D1sYwuye93r
hImmkM1unboxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIK8h2/PHH5O
IuXZ8xQOZM0CPe77EMVzXMgUmOcgQhueMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MDYxMzA4NDkxM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDO4SRrDIDL2Oc3KNr3l3zlTcd//Fjg
BW4j9Ox+mQWPNboHXzYv7x8+buZkv+n3DjovnQs9tnoOfkcrnNm9/WGviu85kJdeOzw2F/TOVkp+
vkigiKBQM2OnqpMIaP3/qp62G6PTmBuBXIIjYOndQk0TrFIh0A8H7uDq00roCx79SGWl+ppG8yWL
/32nOEF5+o2ZUy+jcnoVNPk9sq1uG3LWzQ5KVf8c2NheZEMx3RrfHfVeReuS0XI8HgMW2XpLWCDn
lX3P1b5EiucHPfI2JN2PLPu9QSlhpjnPZIJkaZvFj2KE0/rbnWGaX01DB6lgWVMtlVsTkZVkIjlZ
d6dTjc4s
--000000000000bcec29061ac19230--

