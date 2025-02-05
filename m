Return-Path: <linux-rdma+bounces-7454-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0225A29610
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 17:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE80E7A32AD
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 16:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0F219FA93;
	Wed,  5 Feb 2025 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DzvK2G2X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DC2149C7B
	for <linux-rdma@vger.kernel.org>; Wed,  5 Feb 2025 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772447; cv=none; b=Qp1uuhmD/D1JcxkxYkwx4Asbi1uPM/vUlTaYPuZTzFRAofcZFtpVGk7JJTm2Sso5291DWmFbwxjo8BhMQ+DKo9X7OKrfbeen1gvouKsAO94W+qtrkgf/CC8tttYEt7lLoqh5n1XNqgXJ6PzPVgtsKrGxJrt0IUVW4sTUx/JPkmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772447; c=relaxed/simple;
	bh=ptS5pmYSoqa1sLa/8PDNNLMurnAZCFSSHhfCsR1fk8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VObH9mxjyqpTN53lM5A1m2kra6sfzNbni2MfAeWv4dpvQSUmQFcyEDaYiDtMyU01jxJ6BJot0Tx1grvRnoNT1UOy7mWYLXSAJSjtrDW3NA2iG3+77EQVx5HkfzHUFGRd8owEROey8jQyoEjMGYJgaAaItNqIayyTOuytDmjk0z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DzvK2G2X; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f05693a27so27620675ad.2
        for <linux-rdma@vger.kernel.org>; Wed, 05 Feb 2025 08:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738772445; x=1739377245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ptS5pmYSoqa1sLa/8PDNNLMurnAZCFSSHhfCsR1fk8Q=;
        b=DzvK2G2Xtuvv9P5CRwTwIXC55QBn83SDX/GmdUcMsHbudjcfsOo/jG2y2RMERfAfcQ
         1IF3mQ4yeRmPnW59au4kvDI8CKZRYRQ04CQA8vgIPQQdTkh8FYgADRkcOXMIR47bz7sM
         bPSN2BAnm7+Eeg2oLBgycXZEQrhCALu8ry/hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738772445; x=1739377245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptS5pmYSoqa1sLa/8PDNNLMurnAZCFSSHhfCsR1fk8Q=;
        b=kr4BFVa3cz4skG9JvRPcAhcnVH/3gp3DaWE64hF2XX2WeaDUIFkHj63bCK3NlaNtx+
         XvqdoeyrOC4bTfihXkL4foS4P0Pj5NiODlgQ3jxFR0T/cb6SZmShMLS8YDKCIVjW+hSS
         eJLubel3Ey83d8xuirf/pErrpjWGG+FKfpP38rq+rZvuSgP0J0hrSpS9zKDYUveicMX4
         zQgkMu7hJqqiJ4nKQVWob2rkZ+UFHOPpiCmNJmgY0Uw7cbumdJB+GZv3KEwNhqlV3JLZ
         jpSDT35cy2E8PE7oFF7gDRiPsiSWMG0rUA/wyCdwA4B6Qj6b4ROI6BRBxxQ1AvOMeTuR
         Wllg==
X-Forwarded-Encrypted: i=1; AJvYcCWgC/cC7WNaYj4qRoaIoE6ZfSKN3ivpjU/foK//zOJ5pTSvZvJ1XyQPYJKmJ42TZmJfbuORQaNEq55L@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0b09O1H4v41bC2ghmxTx6lxNfZRetaabV35UTSv2TAYyi6/xu
	xgq93nzpOJj1r0KudLlIY9D+dUEuheV3zAcyf+YLdcAanlmz+NYGK147Qb/PznT3FtOgp5+ahXQ
	8aC3xzo2Nn2EaHXQPPC7n5Mh1g3II4cPWykHT
X-Gm-Gg: ASbGncspzeDiuR1bH9mYqkZ1U9LkpuvmduRINh+xIgvxWC5LIWFbLOZmrR0EaA49+SR
	X1GIui6YGTIEUU11jX7AAQFa/8zH9Omg5HGlECGD3X5UHVHNXjD+D0i20Cc+zGHSFbSoFhIe8Mg
	==
X-Google-Smtp-Source: AGHT+IEGmHYYwvDmnbxHBHD5qtzZsBqG+JLugSI/oZiQq3bmgNhBu3f+Tc1o9zNn7ba+P4Tnj4cFnPnKZDtCD9wwjHI=
X-Received: by 2002:a05:6a00:851:b0:725:96f2:9e63 with SMTP id
 d2e1a72fcca58-73035224858mr6949661b3a.24.1738772445492; Wed, 05 Feb 2025
 08:20:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1738657285-23968-1-git-send-email-selvin.xavier@broadcom.com>
 <1738657285-23968-3-git-send-email-selvin.xavier@broadcom.com>
 <20250204114400.GK74886@unreal> <CAH-L+nPzuSdKN=WQccTP2crfMp8hSLqq-uTXqw_Ck=sHtWbyEQ@mail.gmail.com>
 <20250205071747.GM74886@unreal> <CAH-L+nM6+-v6dvgzA6UDhgbhjysr55BJ859N5aWWXNEm4k+EDw@mail.gmail.com>
 <20250205144724.GN2296753@ziepe.ca>
In-Reply-To: <20250205144724.GN2296753@ziepe.ca>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 5 Feb 2025 21:50:33 +0530
X-Gm-Features: AWEUYZl3WxpqmkvKtpd_dz8PyUZQOWJOiqqpKCMNfaxiPCYKXaxaoV7M1tVEwwc
Message-ID: <CAH-L+nOrzmv5OU96pDnxUHD0+btMBf-_0_KOmZx0fFPowE2xYQ@mail.gmail.com>
Subject: Re: [PATCH rdma-rc 2/4] RDMA/bnxt_re: Add sanity checks on rdev validity
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, Selvin Xavier <selvin.xavier@broadcom.com>, 
	linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000fa82a8062d6781cb"

--000000000000fa82a8062d6781cb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 8:17=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Wed, Feb 05, 2025 at 01:54:14PM +0530, Kalesh Anakkur Purayil wrote:
> > > Shouldn't devlink reload completely release all auxiliary drivers?
> > > Why are you keeping BNXT RDMA driver during reload?
> >
> > That is the current design. BNXT core Ethernet driver will not destroy
> > the auxiliary device for RDMA, but just calls the suspend callback. As
> > a result, RDMA driver will remains loaded and remains registered with
> > the Ethernet driver instance.
>
> What is the difference between your suspend and reloading the driver??
>
> Do you keep the ib device registered during suspend and all uverbs
> contexts open? How does that work???

We unregister the IB device in both cases.
The only difference is in the suspend path, the communication channel
with the Ethernet driver is still active. As a result, the ethernet
driver may invoke ULP callbacks even though the IB device is removed.

As I mentioned in my last response to Leon, we are working on to
improve this design to remove the auxiliary device completely instead
of invoking auxdrv->suspend.
>
> Jason



--=20
Regards,
Kalesh AP

--000000000000fa82a8062d6781cb
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
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIKz79QpuKOeLzaRQwilBEaZELXDZOKsHqHVBkP1xtGaUMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIwNTE2MjA0NVowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBC+qRjFiRP
PdAQJRJEmun+rtk56QVICoz2zSMov+px9J1vtgZtYiB3cO2jEXugzRVklfo11FEUTHfFfR0DY8SC
RPmSCdUMDML5ZQjqGB1senzMFlQ8RJYGo0rMS7dn7ZLuFLSPZ987HT2vInZfHe5MfQUZxUoy2cyv
og7nbmt9u6dNlp+Muk9f6bl0dNZDn/vqKEeGA1zzQxP8EZvwJCzEanWo4t+6LRPaGxprl5H6Sb1o
XkKZk2HMc6z7YxbBKhDkFeeZBTWi7vb13ra7eGufuAknC1D8FT8X23O+QQ4AEV6u+P6z/8TSYa6g
RabC8+y01aDnP8moIduRpqcR7P5J
--000000000000fa82a8062d6781cb--

