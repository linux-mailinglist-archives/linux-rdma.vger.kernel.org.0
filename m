Return-Path: <linux-rdma+bounces-6670-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DCD9F8C07
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 06:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A70DA7A13DE
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 05:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E47413D8A4;
	Fri, 20 Dec 2024 05:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PA5CpWDh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9129925949A
	for <linux-rdma@vger.kernel.org>; Fri, 20 Dec 2024 05:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734674043; cv=none; b=barXUfrG3qNVRiR4J0mpGTuBl7RSXf4xYoN6PzxgZ2FK0hdmN6gSZop/+vw6096LpHGTmmdrMGohyzQdFbZxC99rPDB1sMro32/rPzhMGGRqmcrsbwCRT4WOY8nCyWfFHc90vwqocBUqw0UYFBL5fa8VYAttPbGc04rh9DQcHNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734674043; c=relaxed/simple;
	bh=u/lhPAsQBXYKDn0TG3vY+t1SwZDJ6WXk0u6z9+2US/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V42cCPSJwevsWiNNmvfE8uz6kdA4Wb4W5+jmhWWXsgbIFSqK7pn+QyTZTFNoFYdK5R6H9WsNd+V+epyHd5V3yfuH/tryF2aKvWxWLVAAZ4LUXpbCvIz2VNyBS+QwdfRPp4LTs8sRaJyXStuWifeGyojxbkA5xv14nFXP6w8ZAm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PA5CpWDh; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso2321945a12.0
        for <linux-rdma@vger.kernel.org>; Thu, 19 Dec 2024 21:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734674040; x=1735278840; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u/lhPAsQBXYKDn0TG3vY+t1SwZDJ6WXk0u6z9+2US/E=;
        b=PA5CpWDhr6MIderxGndQ11Ho+DnoNmWvBe34y4ARy0DhnbNntucAdl5FSGROHbstmj
         1PhNEtAFbOSEgJi2upEgaiK+ZWe4f5UIoJK2tn90sJLLDimhIi975w3QVKPAXYkWEdAz
         eUI/+W7Kl/jlNAEdfN6PfY02Yf648WmANsUIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734674040; x=1735278840;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/lhPAsQBXYKDn0TG3vY+t1SwZDJ6WXk0u6z9+2US/E=;
        b=Z18j9yiq+ItClWO6DRvO2uqqlT1NdgxQ/ik2BMcllMNvM5oUAtoSJjAdLYa0x/hdwe
         3E06GEkCERsCsOdEKnLqGHPeQVHTL/y0cvtPqRhdUTFkDIB7zze+yvuHxYxypURz45gj
         oe3cphzHJG1TfuT//h4iRQwGsRl+SiXGbQcaAP9N+/nFwkLLGikuPM5JZ89+AhW8K180
         8XrzSBepH/wLJurqp3LNwDffuXRhBCLMZ+h872OETqbhmGhrngbp9RV9dqFUhl1u29Lr
         R9OlKmFhnaiLOOaFacdXK9/hTeFVhTxMY8S+8S2jxFKwoQ/w4ityCZ9bNtpQ5NV9G+RV
         FkaA==
X-Forwarded-Encrypted: i=1; AJvYcCVwP4Gg2bB5f3cT+TQu3aRZJojcCC40Gu+0QAsDDPaEl4z62pXZRT0cWDTfWOPoRW8U+nUtXzET4gao@vger.kernel.org
X-Gm-Message-State: AOJu0Yxay9MagpZqfRccUxMa2ZhlGG8c6R3Gtzk0ZK+0IdWCDC3RcXND
	cAdTa30kzJTU6puUNT7QREfjbGThrLOAHNYl/I0skzVIsh5oJlOIq5kTU5pNJw9hUJgqKNokq3N
	DFezcQahiEsYE8sFdqPFot8+pSRypq8UWzkoY
X-Gm-Gg: ASbGncuQ4A5pVU0cx+Wvi5uj14zlfbQzOaS296DRJGZ4DUu/w6Lg12/ZFSZtqWSJGSY
	pXWMLjupRYf8++mLMb4KmSqP2MnaYtvNytu8bgQM=
X-Google-Smtp-Source: AGHT+IGkbiUHfeMV86E8zvw/XXCg7XFgBx+eXFg8ccoGUK8CwZq5NKt9q7WYuiu36/KJBB2i0pHcgEqaxTW1OiZ+mAM=
X-Received: by 2002:a05:6402:388a:b0:5d0:e3fa:17e2 with SMTP id
 4fb4d7f45d1cf-5d81dda9517mr1369953a12.11.1734674039904; Thu, 19 Dec 2024
 21:53:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204075416.478431-5-kalesh-anakkur.purayil@broadcom.com>
 <20241205090716.GU1245331@unreal> <CAH-L+nN0C=0ZoJmAgBTbjCUcwoQO00WoUc3d3BKn_tGPdk5UbA@mail.gmail.com>
 <20241205113841.GY1245331@unreal> <CA+sbYW21nc0JPs-N0rmR-DgUvX0pydCY_bZXUC57aA0rXUst1A@mail.gmail.com>
 <20241210114841.GE1245331@unreal> <CA+sbYW0n5CPupxByysd7Dc9=QLQm33ivC1YH5T2UbvG6MBVymg@mail.gmail.com>
 <20241211155610.GL1888283@ziepe.ca> <CA+sbYW2kuQjbUKtKrWkcSTTM3NZL9miBjf=OCRP+LCxFEZsH4Q@mail.gmail.com>
 <CAH-L+nPCCyCiDQLMoBmvMrjRqMFvkBYeWCObqAFfVFOBi9-rjg@mail.gmail.com> <20241219114621.GC82731@unreal>
In-Reply-To: <20241219114621.GC82731@unreal>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Fri, 20 Dec 2024 11:23:46 +0530
Message-ID: <CAH-L+nPiEbzd+fDf1uz-dN6jvbuX_dAd_2a4+OKTYrBpgXNq_Q@mail.gmail.com>
Subject: Re: [PATCH for-rc 4/5] RDMA/bnxt_re: Fix error recovery sequence
To: Leon Romanovsky <leon@kernel.org>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, Kashyap Desai <kashyap.desai@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f7e14e0629ad45ee"

--000000000000f7e14e0629ad45ee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 5:16=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Tue, Dec 17, 2024 at 10:53:08AM +0530, Kalesh Anakkur Purayil wrote:
> > Hi Leon/Jason,
> >
> > Are we good here? Or, do you still have any more concerns on this
> > patch? Please let me know whether I need to push a V2.
>
> Yes, if you make sure that your newly added check is not racy.
>
> Thanks
Thank you Leon.
Yes, there is no race with this newly added check.
Let me post the same patch as V2 since the other patches in the series
have been accepted already.



--=20
Regards,
Kalesh AP

--000000000000f7e14e0629ad45ee
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
AQkEMSIEIAj7/e52NuzTsAIwV2hxL5iEYk+RW/S20OYNcjfLBR9yMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTIyMDA1NTQwMFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAE6H43njEp
KslQDZnJcw910alP0dM5KmEfmasRg58vnicWkRDdVTQTXwaaA2Sa4HpxHq6nDHoUyfzI8aG6fJR1
mic9zIJEgGxJAKDc7V1+k7Vy+VRyt3Kp1Mb+WwBmSMpPgwViQM5Oa9yGBxLPJmTFLa/ZfjxVZJnl
pP5dvBu4HnfKAePmfXDATI7kRKjiz020AX9kS9tCvBqCvMzM5ycTPkFIzF3+4OvbR7D4Y4n66/yQ
SZNkNhEfTXCKZ/Oi4ORCOp8tzMrb4ZKhwU0ZEsTwH+d/+ruo0ijkTnA6GpRG/ENMpqGkS6zpHg6n
Q6YmYxoMxtkQWYQCKojA6Irl8Pr9
--000000000000f7e14e0629ad45ee--

