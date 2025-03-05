Return-Path: <linux-rdma+bounces-8354-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A865CA4FD04
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 11:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F251316BC0F
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 10:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D59A21D3C8;
	Wed,  5 Mar 2025 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DJ0NhOzr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C83214A95
	for <linux-rdma@vger.kernel.org>; Wed,  5 Mar 2025 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172361; cv=none; b=ExAE+QC9vGiFvetS/G7ZBaGam6gucmyQFHK1wVfGRE3/PceB5EWTM4TlMt1Y1jnNjVHoz7JMKEoBJlv8dV3CsUOx5lt1xKbVc5iAHpoA4rrdGvmgnzT9QI51vwd7gDhxBeUm4/KkU1Nz4jRnPPsCWhr/3TaU9RaQTG064sPSk9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172361; c=relaxed/simple;
	bh=8XD0fONGWIzRbalkgMuvl4q79+Ksya8HUcied26vHuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLcJyL+w7RY1ndQ0XDlYJP8oYWM2DVwypckjcUoHfyvPIRahoBQakSLS3fJDvUXziTB42sVeLjb2fUGRIEMElWpkIl02qnRdgp35RaPqcQqq0TCrJ+RiVPd0bNwKbQ9gSZxMQeM8lq8E8AirHlH6XquXySzQXR762lhO6LvCgPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DJ0NhOzr; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abf615d5f31so715754366b.2
        for <linux-rdma@vger.kernel.org>; Wed, 05 Mar 2025 02:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741172358; x=1741777158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8XD0fONGWIzRbalkgMuvl4q79+Ksya8HUcied26vHuA=;
        b=DJ0NhOzrMeNEEshlmkS5PN3jvOOZUe5PmedYKFymoMgDIBou2UeARgYY+o6cz0RGHm
         LW8sTYzkCdF8ccAvPc0CeJ+2BtcjqGro6ldokZyRdhl41L8dmIrKTnr7n3a2D3k5xGpF
         SOYDWtueoeTP5W6Q9wmF3A3IszIRq/i3nxBR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741172358; x=1741777158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XD0fONGWIzRbalkgMuvl4q79+Ksya8HUcied26vHuA=;
        b=rGxlZmJ2zGss1x8at6sP0YjXY5KZyZDaJLRC5sIC8eVSmdrXSLFrCxhvuLNLdZoPJJ
         BOQUi16S80m/TGBgT1DwQ2jS4GoOFnxRl9+M97o+Mt6lXQdudYn6YpVC/bVixf+4AoWQ
         BriUk5jz/t16IaGA5F6L8ay4wVCEbrlnf3Cfm2Bv3yae/nZeO1Y9BnGJk8vl8tYstnDL
         SkFiJ0K+X0vlJnF9SgKpIUp7lbvBQ3QUyeBmGUuwX33mnfIoieJVvfPQ56Nt9nTROGui
         x1H87M9CmZMXi6Lsfrtcp14/asfbo4J1vXWnmLCbFYQHblcPcyRHTMjhiFxl4U0bBXJV
         ylRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwZJ+3TpFFN2bwAHkOae/EfVu/LkqP67mG3hysitu1TYXe5ckhh8Uz3poYjdJP2YPu49YBeXR+CxyI@vger.kernel.org
X-Gm-Message-State: AOJu0YwQtqxthaKSd5RZbi0P/GHOX0GGMDpAmBej4N0aQ+p4OtWOSSOu
	fIZuE9YfeiXML2fjpyVRtjs4uNCjZKwp4i2cPE1s9BzqxLuET3zBEuF2vyCd/5jjkTbDIHCnq3a
	Rb+yU0sjgeqWRsvpMVkFMbbKUAYhL4uf9D9KbJbdae/m/UV1v5Q==
X-Gm-Gg: ASbGncuihMKB6ah4beJop+mxwrNFXKYN+1fgrz4o1OHTbPdgLkkgxj+A2D8G/EEOmtl
	pv8o2inH5rnaKs/jO1wlQKQ5ThZpXM26dAgPu/UKBRjiii1gpaCUWZ+91SIA3xuLhHchZo9gs79
	gGxlL7+pSupKmHnHse0ghrNEQtNrHD
X-Google-Smtp-Source: AGHT+IHq/4z9aO8x3vTI4sYleR0vUhG984PS1EiPk29BlyIkoU28xtfEOUasqzdHEoYJfje0qt4vEzYz788o/+2ANpg=
X-Received: by 2002:a17:907:c48c:b0:ac1:f6ba:3b18 with SMTP id
 a640c23a62f3a-ac20dadcb0cmr247972066b.44.1741172357685; Wed, 05 Mar 2025
 02:59:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125072215.GF160612@unreal> <20250304233233.799662-1-sherry.yang@oracle.com>
In-Reply-To: <20250304233233.799662-1-sherry.yang@oracle.com>
From: Kashyap Desai <kashyap.desai@broadcom.com>
Date: Wed, 5 Mar 2025 16:29:05 +0530
X-Gm-Features: AQ5f1JoLWau-T_d62RkDxDYoslR5V5hT-w79uHxeHxFQ7NyQo-64R9FXvEIszak
Message-ID: <CAHsXFKHMPLceijak_uWeRv-8Xs7cyqMfqLr=DnSWxChAzN2TSA@mail.gmail.com>
Subject: Re: [PATCH] Fix bnxt_re crash in bnxt_qplib_process_qp_event
To: Sherry Yang <sherry.yang@oracle.com>
Cc: leon@kernel.org, mheib@redhat.com, selvin.xavier@broadcom.com, 
	linux-rdma@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e6810e062f964781"

--000000000000e6810e062f964781
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 5:02=E2=80=AFAM Sherry Yang <sherry.yang@oracle.com>=
 wrote:
>
> Hi All,
>
> I encountered a similar issue with the bnxt_re driver from Linux 6.12 to =
6.14
> where a KVM host kernel crash occurs in bnxt_qplib_process_qp_event due t=
o a
> write access to an invalid memory address (ffff9f058cedbb10) after perfor=
ming
> few SRIOV operations on the guest. It doesn=E2=80=99t happen on Linux 6.1=
1. It can=E2=80=99t be
> reproduced consistently, happens 2 out of 5 times.
>

Below controller supports experiment level RDMA functionality.
We recommend using the next generation controller for RDAM
functionality but not the below one.
Broadcom BCM57417 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller

We have seen panic like you mentioned in our testing. Some of them are
Firmware issues.
Not a straightforward driver fix. If you do not have any use case of
RDMA on this controller, disable the RDMA feature on it.

Kashyap

> System details:
> - NIC: Broadcom BCM57417 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
>

--000000000000e6810e062f964781
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
//gyd5clTejfGxz7u6TjAKPT7G/PY9BaxKSEf8zLsYtlHAJMVeCFF20jzwQHb5/L+5h2CkPOrrSB
JSieWyW6UjDpmJdXnnM3sqAtuQHYoZ76TqNQWkummLSqMwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRprYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUuFb0TqXOZcrcNo5g7TmU
kbW0uVQwDQYJKoZIhvcNAQELBQADggEBAEpkK1pEFLXwM8dPS+Y+gSbbTOhzvfHfnB1tKMepSjVT
Sh0CvvfRgpBkaqZJv2+/9W5dfZejA+3xFc/G/lurpofq2yVp2Zik+RbO/FjpFfg24MHjkSr2foJm
RImddZVt810u7w3qtY2pQQ/QHCS9fHkLtz5dKfmePAebpPuX2BJ+FmPfFZyHLpLHr4CJwUU9ETgH
GRRQamqDhA+VgD34fZSymk33umJA6SDgqaX9pDs276nwbY0g8TSOZwohc/6eTzU0Gsl1jSuJezXm
/bctt3Fx6+DwYeO9905PrJUE+iBLLHPm5cHBNF9yWCy/FrP9ZMFvsUvcPiWyEWFPYhsVxAMxggJg
MIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwQyr9ygXXwrg7q
ph4wDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIEuJitZdKmyCvB123MThH01nssHi
2t/+9XMEWAI/IFMSMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1
MDMwNTEwNTkxOFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3
DQEBAQUABIIBAEfkc7+fVrVMKkprCVQZ9ac40PHXYJvJVYWEHCoHXIjuNMxjljjKNsRyp2a0/KwM
ZtJZpkyVEKWnuI1xnTfsFImfTADDBiDWx5T2WHf7FEN/yLIYWPF0kgvIwC5p6dArvV/uMkaDc8j1
sfrPgQjlP2FaGcQPhNhmCOxn5ea/rX5HCuU6vEundp2jP5emVnZ5FcZKW74WX33wR5pDdNxIs25M
rTS7353rZ7dkeanoZhr3VfAP5p7evlomwfAkOALI5o7gpDZuO/wtS1Ki+NPwpgbSfiS76gLi36DK
U45ktOfTPIEdvWlqnrglxTMuL6OJA3zAUnHZBE8lGfQbS5lHDDE=
--000000000000e6810e062f964781--

