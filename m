Return-Path: <linux-rdma+bounces-6834-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8302A022BC
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 11:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA7B8160EB4
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 10:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D92D1D63D7;
	Mon,  6 Jan 2025 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dUlwxFhv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B713B676
	for <linux-rdma@vger.kernel.org>; Mon,  6 Jan 2025 10:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736158444; cv=none; b=NwqWBmYYdnUfj8oB56hdAT6DixMFT1vmJgu+cx7Ww16liFXwuO11CKY1DKZADVMXdrTv36zLUaeva2tW3AO5e/CRuOIM/XIDEmUcc9T4X5f0ZWNWrXYanV0dzyCNX9osLYucQFboek2Q96IlOdk/6jFIxvenb/7HPJ8Rs73D0AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736158444; c=relaxed/simple;
	bh=hE2EOGbaRD9m25KCc0giXx+Rn91oo1seodOrKTpfIJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czkAhhQAh8p7lStno1AxirtjdRZIUym7jUNqm1D9XiAkGc9uKAMq/5tcajgBjYAYdOivuikcBF3xOtxR+dCzKXSeeNamIvX+J8fFlgWXzYg+11YHjeyzSfyEk6RLwEAhJf3LxlRDyFuLIbWkro7oUPxvggjtkzqCHfLtH/xz5wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dUlwxFhv; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fc01so744418a12.2
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jan 2025 02:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736158440; x=1736763240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LwVkJkoPeJJpCHiJKkf6UhWRBpykAJDCHuY0OmlTs1E=;
        b=dUlwxFhv+MvR7IGRA28dLGv2wu1qLvEBBFqLxilgWVP6oZKgQaSXPNOhz2N36/AE6q
         w5KLg3zBx+bN08z9P4+XECYYE1RczMTCHWboKjRre/CS4RVYYQ7PGbhu1Kx1RNokyjdm
         yXUEtqggQetToZBmbs7wZ6XiRo/7UqFrxs3GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736158440; x=1736763240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwVkJkoPeJJpCHiJKkf6UhWRBpykAJDCHuY0OmlTs1E=;
        b=fd3RI/ctXVBF6Hs6KnExUNN3/lvgP/QDvnOX4rRGCskHeFbNtlZbvaSdSzg4zjJ8Ah
         M7m1C9QhaD/FuOanejNqMkL8QYCY5R9kCIz+Qran/52W3kV5QZDXUXPOEyt8j+WV8rPx
         mMaHMI8Ulw+Cs7MdY+pzvg3aP4Frb7x22TVANsymmQPFuZ9XkqBjf6SQBSBdjHOhIOmn
         3JGaERM6mmCcxwCpiU458O5NOsH/ILpcB0RTg3GY8kFPh1x8qX1eqvMetnYEhaSAjfm1
         iWIRyjsCJh0S49xpC0319E8bk5o7gpskwQhD1IZNSf043F4m7ul4tKYFivBy6C/FydW6
         bUQA==
X-Gm-Message-State: AOJu0YyLk1BkSFBtO1xHOS8G3NnGiGuS1kJTsiavTAt936NypWvKoAJH
	iHZmpO/VU5rcNYRHcPrZsdNlkSEsg0DzIMk35ln9l85I/XijswIys2pTEvgPsp0B9Z05IFA3ROO
	FgqS6yR+iOBhjqi8REgGgMgpnVXjMWOuMWp1K
X-Gm-Gg: ASbGncsnQp2ZF33YtmqIqIljmOlCrp/DSmOhOqzvP09XqPSs/xBeA1ybxZ5YiBqsH8v
	VvzBxVPHxFt8kgNYRq6AlPSp2VzckDjw/eimuSf0=
X-Google-Smtp-Source: AGHT+IGBJpZdFEDM0bJ76/LwkJ1/xrNHYSUpXl3bwckcsX1Cnxef0MjfSnUia+grpqEjW6ayKihHTKFhz/zptFK84H4=
X-Received: by 2002:a05:6402:354b:b0:5d3:cfd0:8d3f with SMTP id
 4fb4d7f45d1cf-5d81ddfd82bmr51600584a12.24.1736158440452; Mon, 06 Jan 2025
 02:14:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106095349.2880446-1-kalesh-anakkur.purayil@broadcom.com>
In-Reply-To: <20250106095349.2880446-1-kalesh-anakkur.purayil@broadcom.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 6 Jan 2025 15:43:47 +0530
Message-ID: <CAH-L+nN=OoLpfOFjEFJx_ehyBRj+zYY3woQZhOdS0gxAfJzpsw@mail.gmail.com>
Subject: Re: [PATCH for-next v2 0/4] RDMA/bnxt_re: Support for FW async event handling
To: leon@kernel.org, jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	selvin.xavier@broadcom.com, michael.chan@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002457f3062b06e346"

--0000000000002457f3062b06e346
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leon,

I missed to copy netdev maintainers and ML. One of the patches in the
series is for Broadcom bnxt driver.

I will resend the series.

On Mon, Jan 6, 2025 at 3:31=E2=80=AFPM Kalesh AP
<kalesh-anakkur.purayil@broadcom.com> wrote:
>
> This patch series adds support for FW async event handling
> in the bnxt_re driver.
>
> V1->V2:
> 1. Rebased on top of the latest "for-next" tree.
> 2. Split Patch#1 into 2 - one for Ethernet driver changes and
>    another one for RDMA driver changes.
> 3. Addressed Leon's comments on Patch#1 and Patch #3.
> V1: https://lore.kernel.org/linux-rdma/1725363051-19268-1-git-send-email-=
selvin.xavier@broadcom.com/T/#t
>
> Patch #1:
> 1. Removed BNXT_EN_FLAG_ULP_STOPPED state check from bnxt_ulp_async_event=
s().
>    The ulp_ops are protected by RCU. This means that during bnxt_unregist=
er_dev(),
>    Ethernet driver set the ulp_ops pointer to NULL and do RCU sync before=
 return
>    to the RDMA driver.
>    So ulp_ops and the pointers in ulp_ops are always valid or NULL when t=
he
>    Ethernet driver references ulp_ops. ULP_STOPPED is a state and should =
be
>    unrelated to async events. It should not affect whether async events s=
hould
>    or should not be passed to the RDMA driver.
> 2. Changed Author of Ethernet driver changes to Michael Chan.
> 3. Removed unnecessary export of function bnxt_ulp_async_events.
>
> Patch #3:
> 1. Removed unnecessary flush_workqueue() before destroy_workqueue()
> 2. Removed unnecessary NULL assignment after free.
> 3. Changed to use "ibdev_xxx" and reduce level of couple of logs to debug=
.
>
> Please review and apply.
>
> Regards,
> Kalesh
>
> Kalesh AP (3):
>   RDMA/bnxt_re: Add Async event handling support
>   RDMA/bnxt_re: Query firmware defaults of CC params during probe
>   RDMA/bnxt_re: Add support to handle DCB_CONFIG_CHANGE event
>
> Michael Chan (1):
>   bnxt_en: Add ULP call to notify async events
>
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h       |   3 +
>  drivers/infiniband/hw/bnxt_re/main.c          | 156 ++++++++++++++++++
>  drivers/infiniband/hw/bnxt_re/qplib_fp.h      |   2 +
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c      | 113 +++++++++++++
>  drivers/infiniband/hw/bnxt_re/qplib_sp.h      |   3 +
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   1 +
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  28 ++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |   1 +
>  8 files changed, 307 insertions(+)
>
> --
> 2.43.5
>


--=20
Regards,
Kalesh AP

--0000000000002457f3062b06e346
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
AQkEMSIEIPe1o4KjrLbYNX1UPlkoK4BDWsfMX5QznmC7Zu1Ay19KMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDEwNjEwMTQwMFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCdEvtWkpF0
sWohC28Md15Qr+1+PC2NNF2N325CaPQn/7Zw8JYIPZNGk/w2KFapnuBuaMD7DYcbLTXV+wFyHlbY
SlVjLUk6nJkRBefc4p9Uv1nSRinRnT9ZALuCr4hW6bO9cMA4EvQrMoylpDaCnHarV/3luWMtVH+R
9SpWJ0xRPvCkNzUf8SaZD4zc10saLP1ON//YEs6NFBF+gu6J5MWMR0kUImWJ0fT3unjV2O2IgJxm
DoXjlh/9o2n5OL50VJr65fZgVL7fFLroZ0Ex7StPx3gi5AVn7Lel0fkeBViyWuh6xSKilsKRKuiR
1p3pcPuVBJbL5DM+UqSyQbtshcLe
--0000000000002457f3062b06e346--

