Return-Path: <linux-rdma+bounces-11915-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3485BAFA9B2
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 04:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F55A7A42A9
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 02:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DAA199EBB;
	Mon,  7 Jul 2025 02:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JaoyWv8E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE0A17D7
	for <linux-rdma@vger.kernel.org>; Mon,  7 Jul 2025 02:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751855709; cv=none; b=dw8B6DCuWgSDuw5wErD9eO5X7/l03Z88gMnitXOrY1SEiLo7MLXNgNNrtIirZNY7qfL48l20WwFV2sMatIDNa/E/a6lsAn+tPhouwME0XLwkUN3LlCCoBuMVEfSqDD7K7n1cm2VkcdRKzmvFEkc+40T1cy0tD/8zg6SLCBBZ5f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751855709; c=relaxed/simple;
	bh=M6d/2vL3kpzmrovCG5MrvmOM6/QIG7AO9N/T0dJCf9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYRYbW9212OfcR+s3TQmp6IZoZXdvuxQEeM5/6yh3cplFye9I3CsNwQElbbpI+TDsm4hm7Qcd9zQyLJqG9MItaM1mLxCxFBevRlCUA5U1hh5el729f5U/oP7x3QAYH+jx7vmq++jG4i/hSD/mXYR1i/F2h+Atya5FOiNZ0GZY7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JaoyWv8E; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74924255af4so2398088b3a.1
        for <linux-rdma@vger.kernel.org>; Sun, 06 Jul 2025 19:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751855707; x=1752460507; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M6d/2vL3kpzmrovCG5MrvmOM6/QIG7AO9N/T0dJCf9M=;
        b=JaoyWv8E1WxP3Qku80NcmHjQ8BUDI9qqhWH0TTYTeXIyiTd8Wr7NRihYwjnUL6nfnq
         D9JNtnh3H5iQ6u+CNgL8DyaUmcWTtRz0Tl2kHBb2rJr3vv1PjcwKi6vYtDtjaqoelAJu
         VEJ5B5xn+CYzTAn25DYUb2MfKjt1NzlexfKeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751855707; x=1752460507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M6d/2vL3kpzmrovCG5MrvmOM6/QIG7AO9N/T0dJCf9M=;
        b=C2D5p8Ho37MmP+SjY5nEdcb03Yg7el+f4acQc99+kVzVtgIyBGlL+MDHj7GjbU5lJg
         /OppCOUNt7YEGcEoNOmBYezBcSZLHBf3BwKOD0HRyJYBdI9d/EvbxOKplv8nLAuqWEuo
         nD6RfTdqQBRq98I2OmOXjQrHQyN8hwLeeNCFFPo05Epiai1hfuasnTXZq9c2rLy8IkSA
         8TngEluVV7kJyzmEXkc3FZyIYYR1641G/nRa1C/JRvRM9XW3yLIBe7J8bp8laJJEaqGr
         o/pfUqubBAsaUoecPl8a8qFkPxS4VjNRKXImlTQ2JBesVYZA3HONcX7G5PdL8C4vrkPF
         Gb+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVE2apWxThfzAu6riwRJN/W2UyZ7Eu9JHJmoRBGUQOfcdltbVf//QQYR08LoRYxZaJvrndAGxr/a3Hr@vger.kernel.org
X-Gm-Message-State: AOJu0Yynv1chxsqfT4Z2r0P2NlloY2UvSwzsSP3fwLLVFlJZfpvRsSRT
	zzXlAAaKETz2Uee1HuPKn4iMOH8ItPs2pGpLVe7GN9bnQSgvbRJDnWtv4Wx49bVI0owRm9FMF19
	YEvcf1Gb6GOzbPrVWmsfqslvGRg3XCAyAzaHgFBOl
X-Gm-Gg: ASbGncvhHUlGW+TIqbplfxLUrUIE8stInoKTwZ9ik6emKt+P8gTGjywjCR+GEmlhdrO
	zQdLZb70bN/wlHSrcQCfP6PnoIArybJD/PT0orri9Pw/vdodJYQ7klSgE4jxvnwIP2Cn8cd7nKn
	90tXJPLkLiYAAt67Qqr3fdVJM8kpwywjc8asDPDsCNuPJX/EPrf0oQ17Y=
X-Google-Smtp-Source: AGHT+IHcW9EQERBS0/Vaznhcnx72bI5szEiRAWz6b/MnGJjmOYvxBmOO2jyXKLljXe3iVD0iZI18c8a90CSr8DVClZA=
X-Received: by 2002:a05:6a00:1307:b0:748:f750:14c6 with SMTP id
 d2e1a72fcca58-74ce8ab16e8mr13572654b3a.14.1751855706933; Sun, 06 Jul 2025
 19:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704043857.19158-1-kalesh-anakkur.purayil@broadcom.com>
 <20250704043857.19158-3-kalesh-anakkur.purayil@broadcom.com> <20250706073729.GR6278@unreal>
In-Reply-To: <20250706073729.GR6278@unreal>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 7 Jul 2025 08:04:54 +0530
X-Gm-Features: Ac12FXyK4ZZilp-9xjEJOF2HnHjxK2lSCF-S3E7lzXcSzzoRNMVz8ayZkQDjhXc
Message-ID: <CAH-L+nP2=6fRcxXWtS5OAE=5xDTZ1O3YqbK5G1x66kqYygK2AQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next 2/3] RDMA/bnxt_re: Support 2G message size
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	selvin.xavier@broadcom.com, Shravya KN <shravya.k-n@broadcom.com>, 
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002155f206394db1f8"

--0000000000002155f206394db1f8
Content-Type: multipart/alternative; boundary="0000000000001c46d906394db1e5"

--0000000000001c46d906394db1e5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 6, 2025 at 1:07=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:

> On Fri, Jul 04, 2025 at 10:08:56AM +0530, Kalesh AP wrote:
> > From: Selvin Xavier <selvin.xavier@broadcom.com>
> >
> > bnxt_qplib_put_sges is calculating the length in
> > a signed int. So handling the 2G message size
> > is not working since it is considered as negative.
> >
> > Use a unsigned number to calculate the total message
> > length. As per the spec, IB message size shall be
> > between zero and 2^31 bytes (inclusive). So adding
> > a check for 2G message size.
>
> You can easily use opto 80 chars per-line in commit messages, there is
> no need to limit yourself to 50 chars.
> Sure, thank you Leon. I usually format upto 80 characters per line, not
> sure how I missed it.
> Thanks
>


--=20
Regards,
Kalesh AP

--0000000000001c46d906394db1e5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jul 6, =
2025 at 1:07=E2=80=AFPM Leon Romanovsky &lt;<a href=3D"mailto:leon@kernel.o=
rg">leon@kernel.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On Fri, Jul 04, 2025 at 10:08:56AM +0530, Kalesh AP wrot=
e:<br>
&gt; From: Selvin Xavier &lt;<a href=3D"mailto:selvin.xavier@broadcom.com" =
target=3D"_blank">selvin.xavier@broadcom.com</a>&gt;<br>
&gt; <br>
&gt; bnxt_qplib_put_sges is calculating the length in<br>
&gt; a signed int. So handling the 2G message size<br>
&gt; is not working since it is considered as negative.<br>
&gt; <br>
&gt; Use a unsigned number to calculate the total message<br>
&gt; length. As per the spec, IB message size shall be<br>
&gt; between zero and 2^31 bytes (inclusive). So adding<br>
&gt; a check for 2G message size.<br>
<br>
You can easily use opto 80 chars per-line in commit messages, there is<br>
no need to limit yourself to 50 chars.<br>
Sure, thank you Leon. I usually format upto 80 characters per line, not sur=
e how I missed it.<br>
Thanks<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr">Regards,<div>Kalesh AP</div></div></div></div>

--0000000000001c46d906394db1e5--

--0000000000002155f206394db1f8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQfgYJKoZIhvcNAQcCoIIQbzCCEGsCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3iMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
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
AQkEMSIEINIhv9IVXeGaeNsajlT4o2sApYqBE5rJK/cTmdALXgHQMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDcwNzAyMzUwN1owXAYJKoZIhvcNAQkPMU8wTTAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAKFCxHBa9zGxey2FVg3QFJkJYu7Z
i9HJlvROx7uLkotYk3aw/1RG1DhT7zmEH67xijqeTxEcWGP9v0UNwpVH86RYA17MH/sBmbMaPKfv
M3Ej40MADLbWa6N20fDIUiuE55dDrEuzfKumNEnqBhu1RwTV2jY4ZEgrd9f1sPGGqRZMPLWJfL1N
fM15bu4pGk9IyuG/eh6dpd0sKst5GCFIiJY0+zoss31aRN8fQjtsqgB6KX6mndqhf9J3uISaD6Zl
7T5WDP1OvX0wYdtduvkflqmnzGusnRBp61J7v0riQY6LZPYmtYPlOTdiauX89abFmBUpRkrEtEjf
WKlWzfw0acM=
--0000000000002155f206394db1f8--

