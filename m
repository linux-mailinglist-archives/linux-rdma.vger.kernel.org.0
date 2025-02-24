Return-Path: <linux-rdma+bounces-8030-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A8AA417FE
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2025 10:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E85188FC50
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2025 09:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8788D242916;
	Mon, 24 Feb 2025 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b14+ROxi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCECE61FFE
	for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2025 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387619; cv=none; b=fMY8CqNn4iBM7/LbsQo+ZC4N06dPe0u2Oqol5bXE0zLUgowbE1/e404yvJOLe4LFckv9l94YCbv8W0zjulNiF7+AdIxl5S5OOJgbl/72BOYXPTZK+L1flI0Ezj5mbV9TUGqlZlv4KakIP9Za9q81LvP1YWTz4hKf/k8s+Y/gmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387619; c=relaxed/simple;
	bh=wbiPPv2verbSHbWZKxESPU7DIKQXQwXpJIonVmG4BA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A5AIMdnHCoi3GOAJxsRdTSKj29XB5IlkyhbZJrJjCp9ygev4QynQYvjxvcEEcAqzHR8MBI3v9kEckG8TiiNWThjYp+Mno/nW3qg6mvHHcBf3/OUsB+rA01NF28Vhy8O+cjY23NkU7/a9J2M38d+4wtd2Spo8H8p2sux+ARsC3oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b14+ROxi; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5fce5eee2beso2608166eaf.0
        for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2025 01:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740387617; x=1740992417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wbiPPv2verbSHbWZKxESPU7DIKQXQwXpJIonVmG4BA4=;
        b=b14+ROxi1/hMlQorSxiIsVgNFhJZzErq4h8yRd+9FNCbF+WGbVAf/mZp9lUjm9TT32
         3GIEDkHuVMuHGbt0rUOqOSTaxZYdLJyU2t8Thgldf+KIezuXs13JRFUr0CrVTqqsHjMJ
         kM1c4WRJ3Pyu7/U86XSWms6JpqoaWh1Zwhfks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740387617; x=1740992417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbiPPv2verbSHbWZKxESPU7DIKQXQwXpJIonVmG4BA4=;
        b=hcoQ2IRBtou1FtMbM67QX39ocapyXDZavz5BpZr4mwTblosDUqB0tSr9+XvUaJHmlc
         GcWa6k9hJpksikAvAkom+XDP54N4Y3M3HAuPdsUUhMXt2qZx2y02gAJunL6BBu12z31s
         /MVsl9vr2qfsgPE/mGvZwOcnDgCkbqBYTDpBJp+qy/+TYnR/HSdAOCV5bgANEZs6c86H
         pKNbp3gEhsGxCv3lyCz974zvuXWCs/Y3K/iY/a0MrAj7Wz27WFPfLSQ5AnKOhRrHrplf
         cHY1xlzmUhJr7DivP4yQ7OmGFMPbN6Rk8OuTOCiTRPfpkZ2OauIu8viOtGh1iK9BwYnM
         v38A==
X-Forwarded-Encrypted: i=1; AJvYcCVhQfeydqr0ReOKn9NWAomRgXw9DoX5tS0RRSFKYfYHp5bRqXLQ3erf5s7/thqNiQE3U/bJU3Q4gV+k@vger.kernel.org
X-Gm-Message-State: AOJu0YwnHVATR0HmrSi/H6sufeN7TeAlr5Eltqe4Q7zFyCxW4UN3bZMK
	ZxqzYUOAatynyQufB8ScBcTaYECXe9O3h3hhK8KuKRNOBPnxUiWYDKbx5XUZNJLTwHfeTAZdqqS
	xpBTwuhFmHKP6cnrqWeXa14ezHIebtLy1Z7qI
X-Gm-Gg: ASbGncuFkivK8Fmi0QsgAERECgNiVvqEX8kiGMTmy1l8/nHvQbhiY6n8WC3IODxpI+l
	mdpZhfXCQbBkX96xw1DEhJeJ/M5pzLnL2rNGgTXIVUZGgTeNZnusVIxjvWNjjhpCQ3cibEGDBYP
	o9GCZIu2hW
X-Google-Smtp-Source: AGHT+IF+E4//s2y4VgMubTDSl5iSy1aAs3L+0lHZFTZgV1cC3NriWLyMlC+IWWQGCmst2T9kOdY8tUBjOECNMM0OXiE=
X-Received: by 2002:a05:6820:4901:b0:5fc:f2b7:9853 with SMTP id
 006d021491bc7-5fd0ad6257emr11420798eaf.0.1740387616784; Mon, 24 Feb 2025
 01:00:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com> <20250223133456.GA53094@unreal>
In-Reply-To: <20250223133456.GA53094@unreal>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Mon, 24 Feb 2025 14:30:04 +0530
X-Gm-Features: AWEUYZnVIziCUIInlPq1jE68iiIIVs8MBnThc1DKUedrT8PjVStL1hXI_uoFip4
Message-ID: <CA+sbYW3VdewdCrU+PtvAksXXyi=zgGm6Yk=BHNNfbp1DDjRKcQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next 0/9] RDMA/bnxt_re: Driver Debug Enhancements
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, abeni@redhat.com, 
	horms@kernel.org, michael.chan@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b106eb062edf9196"

--000000000000b106eb062edf9196
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 7:05=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Thu, Feb 20, 2025 at 10:34:47AM -0800, Selvin Xavier wrote:
> > For debugging issues in the field, we need to track some of
> > the resources destroyed in the past. This is primarily required
> > for tracking certain QPs that encountered errors, leading to
> > application exits. A framework has been implemented to
> > save this information and retrieve it during coredump collection.
> >
> > The Broadcom bnxt L2 driver supports collecting driver dumps
> > using the ethtool -w option. This feature now also supports
> > collecting coredump information from the bnxt_re auxiliary driver.
> > Two new callbacks have been implemented to exchange dump
> > information supported by the auxbus bnxt_re driver.
> >
> > The bnxt_re driver caches certain hardware information before
> > resources are destroyed in the HW.
>
> Unfortunately, no. The idea that you will cache kernel objects and they
> live beyond their HW counterpart doesn't fit RDMA object model.
Since the scale of the resources are in thousands usually, we can not dump
the debug information to the system logs. So we are not having much context=
 of
the failure and this is the reason for having this new mechanism.
>
> I'm aware that you are not keeping objects itself, but their shadow
> copy. So if you want, your FW can store these failed objects and you
> will retrieve them through existing netdev side (ethtool -w ...).
FW doesn't have enough memory to backup this info. It needs to
be backed up in the host memory and FW has to write it to host memory
when an error happens. This is possible in some newer FW versions.
But itt is not just the HW context that we are caching here. We need to bac=
kup
some host side driver/lib info also to correlate with the HW context.
We have been debugging issues like this using our Out of box driver
and we find it useful to get the context
of failure. Some of the internal tools can decode this information and
we want to
have the same behavior between inbox and Out of Box driver.

>
> Thanks

--000000000000b106eb062edf9196
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGjmyldl/iRU
Euy5akIF3qOStDIAWAeCJciWrcl+SglYMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI1MDIyNDA5MDAxN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCa49m4gB6O3M0DwS8j08HSZyErcU2I
hq+SUctFvpegpCUo8dudSl1HGjoDEr21sE/AaumE+3YaS8r95+8ZHEgYzCnGYON5OX3yGr3NeKul
GMW/Q2+/31v8lTO38pUh051dcR++BNShJfmUJs3DdBZhxbgYp+Y7eisf4nP6gTOGrmapSukvuBKH
wGN5cldUIJwQuZiNS0FrL8rzNvMYj2nVx8652/eutGnWZHmz48rSyQruXlLDLmYtMmrN5SgIQhTP
KWaAvn/XPkPttshw/MAa3VvBD5CNlYyeH10AM2MAiNCsdjjZ1AHhhPU4M33UCRBiE60Fcfr24GsR
FZpU+T7d
--000000000000b106eb062edf9196--

