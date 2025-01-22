Return-Path: <linux-rdma+bounces-7175-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77937A18D63
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 09:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDC93A1904
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 08:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EE11C3BE5;
	Wed, 22 Jan 2025 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Qil166BW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211891714B2
	for <linux-rdma@vger.kernel.org>; Wed, 22 Jan 2025 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737533371; cv=none; b=D3Pzg27FGhhhI+KGBdY2zweEnGKEid8QRurHCHf1Fh0bdHzkc4VVXNz/zAm+WCrF7ZGLlbkTAgIbRVr/uA+Bw2WBU2KoJAHpElvdApSfcYQVsHki1MqgHy1xAcO0oNyoz/xmxIp6F8x/JCOaGPzmYzrKOvzYChAxoG625wl6dlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737533371; c=relaxed/simple;
	bh=ZXQzN0nPklDgC0mbPZz38Ll4XTsS004fIw+ylNkSCA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gc7XTbf7vlLK/B9GtR3ypDXb9igWcd061zy5h7HCBk3tdQnnd6zxfJZY3QyJXzJ3MvGzTlz/WkgszmxlgH+gwzMM/YqU19hnDMXDm2EDsgZQefLFM4Q9r5LfT8BoM9bDdixnsWImKP2aDrDyELe4FbVs5xOwv3gP/ROMCdzjV5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Qil166BW; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-29ff039dab2so3583645fac.3
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jan 2025 00:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737533368; x=1738138168; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kacwvi+O+P5sOQPyFed5ov/Hh3EmzVD1VQPCWfHyGug=;
        b=Qil166BWyqg2CLqc3KoQWFQ25evJ0+2Y3xbLDp41DkUagVLqhDX7q0pGo2fgbYyQeW
         V6Gfvu3yDWx/K4PUEa3fSji5JyyuQ1+/m+Zsd0bwrKlO0ae6Hi5DU7urYdW9VXXLzozx
         /KsSAbZ85teet2EqY32ZUw6dQ+oARavcTVlos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737533368; x=1738138168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kacwvi+O+P5sOQPyFed5ov/Hh3EmzVD1VQPCWfHyGug=;
        b=LDWcrsK0H0xi0fHcEJkfgG8gtUaJ65hKlnB7xRgWY1CehkrzcSO5QsAC3Vu34tVbHT
         pBll91zTHD3+nsUYnbpkevC5J1p7kTXfETQ0H0IH/GHWfnkBKe3P/sZREJKRszBtTORx
         wbVVqKwXAzJZDvxZjFF07wZ1jHFqqkmZ92dttctS/IeyloVRU5nD81gWQXoeldI9or90
         ZNGQbaBA8kHFBDMWTLj2VyaHvt84WeE+QiSrbVQJl3MFJ1ZLhJwUojvcmsZT8tFxmGdX
         dJZ25F65/ECEMH12KsSkLLZtvCp5tplXsLxIPUrfTOyb9NSDgO4NnnbgrnCGHfJPQEe5
         h+9A==
X-Forwarded-Encrypted: i=1; AJvYcCVdFDwCqO+xSHBi88FmsU5fGZijG0/geRXV4yv2WxXlFIMVDFKgL/t1IIcR4GixbRHcxmaIcSeHUbNA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl6Zw//MOI7CZObQ5HlEiyeqDCOJj9wJeyY9PcJIRx26d9eE87
	ksMUM46doBXK/YVkaXYN0P7hSpZOhEwUY4pAOQuQ2A0FHRWzaY2Je1B1fxyC2mhuVTwiA0TDdIA
	ZJJDKe4giAYG92twdnygC+eu3sW3Y0txy1bxi
X-Gm-Gg: ASbGncudI1C65VyLTBwUFrvD92VvE6qD/7M1ihMk6RSl04X8Jyr/OzxJuA2N6m6FYOF
	x8M6bHUcNLTOZxJMvjjVT9asY5bBx17Sj/m/8dcwFyDbK38nBKYc8
X-Google-Smtp-Source: AGHT+IGFBI3qQw8slgzl23oz4/5qOMySsaSYxIh9NV7snfw5aUx85BiO/FCIHz3i90Kpeh2Df/Ws+uzfIXvCKDH3LS8=
X-Received: by 2002:a05:6870:171d:b0:297:285e:f9f4 with SMTP id
 586e51a60fabf-2b1c0cced79mr12565217fac.34.1737533368562; Wed, 22 Jan 2025
 00:09:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1737301535-6599-1-git-send-email-selvin.xavier@broadcom.com>
 <20250120164000.GO674319@ziepe.ca> <CA+sbYW2oDbrodgYdzOgUiSv6v+8aBcACLbfrXM+0NZGmHquUFw@mail.gmail.com>
 <20250121153127.GQ674319@ziepe.ca>
In-Reply-To: <20250121153127.GQ674319@ziepe.ca>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Wed, 22 Jan 2025 13:39:16 +0530
X-Gm-Features: AbW1kvaDe1rEuzZ5H6Rz14lyZJdN1H4InY7E_Qvirqgbz012N17Y35l0CdA87Cw
Message-ID: <CA+sbYW21WJsFECZ9tWDBqZy_p1C+H2Z2chOJcv93JnJ6TdzJFA@mail.gmail.com>
Subject: Re: [PATCH for-next v2] RDMA/bnxt_re: Congestion control settings
 using debugfs hook
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: andrew.gospodarek@broadcom.com, leon@kernel.org, 
	linux-rdma@vger.kernel.org, kalesh-anakkur.purayil@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003c35a7062c4703d8"

--0000000000003c35a7062c4703d8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 9:01=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Jan 21, 2025 at 04:10:33PM +0530, Selvin Xavier wrote:
> > On Mon, Jan 20, 2025 at 10:10=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca>=
 wrote:
> > >
> > > On Sun, Jan 19, 2025 at 07:45:35AM -0800, Selvin Xavier wrote:
> > > > Implements routines to set and get different settings  of
> > > > the congestion control. This will enable the users to modify
> > > > the settings according to their network.
> > >
> > > Should something like this be in debugfs though?
> > Since these are Broadcom specific parameters, i thought its better to
> > be under debugfs. Also I took the reference of a similar
> > implementation in mlx5.
>
> debugfs is disabled in a lot of deployments, it is a big part of why
> we are doing fwctl. If you know it works for you cases, debugfs is
> pretty open ended..
The main use case for this debugfs support is for evaluation customers and
the tuning for their network. So debugfs should be okay.
>
> > > bnxt_qplib_modify_cc() is just sending a firmware command, seems like
> > > this should belong to fwctl?
> > Agree. We can move to this model once fwctl is accepted. For now, it
> > is important for us to support our customers with an immediate
> > solution. Customers are asking for this support.
>
> Well, fwctl can be accepted when you guys come through with an
> implementation :)
>
> > > Additionally there may be interest in some common way to control CC
> > > for RDMA..
> >
> > Do you think there are common parameters for multiple vendors here? I
> > think enable/disable is an option.
>
> I haven't seen much commonality here, every site seems to have their
> own totally different stuff right now.
>
> Jason

--0000000000003c35a7062c4703d8
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEII/JHHIlIiEV
6uXcLKEEQfh8XDDMsH/BaekSM1K+5NfrMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI1MDEyMjA4MDkyOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDj0qV0+70SkjtgCwf9WCT8G/V80mBS
aE++KOknhBBd/hFNxIRtnfV7O6+Ldhne4NMiTfR9h717YDA0MsP5tWxb0vVNTwNQ6LDIQHDgsrg4
Fkao4XYOkoQtLUmxa/g5uuv2HIbYJbmXPd+zx4u7+XrkjsSbgPoX0hN0ce5Z/F0G2nyZaC/q7DC4
9IS1nBXTfNwdbP40RSuDPMf6VYE8JGwRHWDalrpHDxI+MmkJ5cKuh1sytpNX+ZQL3HkQi8GBRfDj
3pNXlNj1T35+zE1Drstu51W+wlOFZfkBDtRpdQszari7RwAkvMf3SONBmMKa+/nffU+Nb1aXdo/1
76lGhdFb
--0000000000003c35a7062c4703d8--

