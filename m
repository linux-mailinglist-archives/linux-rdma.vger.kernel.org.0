Return-Path: <linux-rdma+bounces-5573-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2347C9B2A2E
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 09:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D500C28186E
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 08:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D4E1917F6;
	Mon, 28 Oct 2024 08:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E0vBzIya"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C895B18A6BC
	for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2024 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730104056; cv=none; b=Rjnmp1hVS+lB1/Px94+eY6DGwEYjdY/58zGqTTAkSSFykVC1Io2IEHa2tw4sCnroMiWafh72ZZkAIanPqbqNa/3sGfgq7TdHSf+tnxaedl7v7Sjo6k0Opal96MrzWHq7xNODfMhgD9CZ+DS7Lr0bd6q24vrsthYuGJuZ/xidJOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730104056; c=relaxed/simple;
	bh=vxso8Pik2a0HIRDu5kA3CyddU9WwH4K1szXE7Jm4OrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTLahuc11n+RFeQM3xxTY8xeiB3YLuKaDqHZbVZ2iAguJcDHcqW6VSd6e9F0f33hrl0rycjF3HK35YG/Rl7k+l1/ERnurmhi94h7G0ofV9k6E1cn37FL5VJYjNcwyvMGS4PoS6IWkH5rg2sDxFTBpA1nIgGnrEV6jm6FZi0dZW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E0vBzIya; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so3470746e87.3
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2024 01:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730104052; x=1730708852; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9H0aKX84LkV2ZsaOEE3ozqWAsVReQ3B0yRYsmioSarw=;
        b=E0vBzIyavqt1JnmlxFD5H3IegV3eYpuT/TtSph37pFly+2mO8IhuroC+o6z4tqVJd6
         FZ3LHLR8hHqflKhy7DvOEIJwcwAHQVzkqp/vf/lzGJOwYC07AXLVXGYbvkBJr8Ef316L
         Phqdk9i5dxiMzx+uBrsm9zR1MuIoEW/6TswBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730104052; x=1730708852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9H0aKX84LkV2ZsaOEE3ozqWAsVReQ3B0yRYsmioSarw=;
        b=HqEOhmGErQOCaWhwAZeML35YEPIGpg+4lTJOSX/Y3s2beOzr/Al3xE9fTp6MF7eKUS
         MCKj1kKkQpujeRyE6J2i947bqs9+oLr6dvF5x6PPSxsVc+SD9I+pOskMAVlou6mpwq/r
         EwT9nv1bdtt9fhrlHRavpEIqIJ0A7q+dDw6jVrdf/y65UYzhtW6VqzxEkvkKEX7ITsSR
         b7d2zwXATzzGoHwRfmFxb2+iaGBuXjDew/WhdlXYSrfT9w8vJYfd3OTKR1pvjK3DctRZ
         dg2WPz16WyVncRW8u06DAuGQnSbjdf4LPqwaxTjy0wZa+o7MIMoG/SLYdcr035UYolK0
         Bg7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEVnVKXNRjo/QSLEgCZjGAHpkpyXjjryDBPsADiOhJXbL8OyzyhcpQSJ4BouvwahDFMjVyqGYFQxrq@vger.kernel.org
X-Gm-Message-State: AOJu0YzDhGn3oTqxg50StiGJbf7s2gpkx3Oel7s33XfUyvmIawgvwPOm
	KjKqIthS5FIXOmD6Nx4/22feWVNWMkBddGWmXYtFE1SeiDQr/nI19yeXWvblf82J0EhvAfouK5o
	6BaiZv1HazxRTMNxsZOpdjnqvyii/hCOV74bY
X-Google-Smtp-Source: AGHT+IEoGBnTq3szhbflITW+GzYfI90kWdzFHo4UvDbzcWOd/X3SSc6YeafkWyrmhQU2TgHEQUeVMF1/s6qQ+93X+1g=
X-Received: by 2002:a05:6512:3b8d:b0:539:ebe5:298e with SMTP id
 2adb3069b0e04-53b34c46556mr2605951e87.59.1730104051933; Mon, 28 Oct 2024
 01:27:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <580de136ad9b85b0d70709e912cfddd21b7e3f6f.1729930153.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <580de136ad9b85b0d70709e912cfddd21b7e3f6f.1729930153.git.christophe.jaillet@wanadoo.fr>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 28 Oct 2024 13:57:23 +0530
Message-ID: <CAH-L+nOZ98nyRzifRfrrxD4AVYrVrsz+tzeQcB3f_QD3sbQ=cQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] RDMA/bnxt_re: Fix some error handling paths in bnxt_re_probe()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000077900b0625853d1e"

--00000000000077900b0625853d1e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

Thank you for the patch. Please see my response below.

On Sat, Oct 26, 2024 at 1:39=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If bnxt_re_add_device() fails, 'en_info' still needs to be freed. This is
> done in bnxt_re_remove() with the needed locking.
>
> The commit in Fixes: in-correctly removed this call, certainly because it
> was expecting the .remove() function was called anyway. But if the probe
> fails, the remove function is not called.
>
> To fix this memory leak, partly revert this patch and restore the explici=
t
> call to the remove function in the error handling path of the probe.
>
> Fixes: a5e099e0c464 ("RDMA/bnxt_re: Fix an error path in bnxt_re_add_devi=
ce")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only
>
>
> Another solution, maybe more elegant, would be only call kfree() in the
> error handling path. In fact locking and the other stuff in the remove
> look useless in this specific case.
> ---
>  drivers/infiniband/hw/bnxt_re/main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw=
/bnxt_re/main.c
> index 6715c96a3eee..d183e293ec96 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -2025,7 +2025,15 @@ static int bnxt_re_probe(struct auxiliary_device *=
adev,
>         auxiliary_set_drvdata(adev, en_info);
>
>         rc =3D bnxt_re_add_device(adev, BNXT_RE_COMPLETE_INIT);
> +       if (rc)
[Kalesh] As you suggested, how about a small change to free en_info
here? You do not have to invoke bnxt_re_remove() in the error path
here.
> +               goto err;
>         mutex_unlock(&bnxt_re_mutex);
> +       return 0;
> +
> +err:
> +       mutex_unlock(&bnxt_re_mutex);
> +       bnxt_re_remove(adev);
> +
>         return rc;
>  }
>
> --
> 2.47.0
>


--=20
Regards,
Kalesh A P

--00000000000077900b0625853d1e
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
AQkEMSIEIOADCd8OITwcGR8YkfJDUgcdqUHQbz8fF7/LibOq945jMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAyODA4MjczMlowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDELWh3KeqF
hTK58jJKGloRiGS2F+XpsG2kT1DR6D0aGVpGLsia5CMcmV2O0Dw9b/U3hUlkNjA+NZ5k4VNbzxNG
dvwNUhAb2pYyQxlDVTElOn0jQUd5q1lZbUFcGmzX8MEQ7DNM5sM3+X9NE2Tj20B41kxTlL6enGFJ
x1RDh0ZeaRPBqjSJq8I1Y+6zEHQhxfRTt3JWVFqnLXMdbMxYzmeoGVH/NuWZFVYx3RQCzXbc/P0W
SbrDQ1k1fjMgqtD/ehV7PdoUjppESWNyRLaBzArMFmJn+vGdTf3De0vqLI9PEZ3yVf9n0yfVWgLB
DM1G6ZaPaKFO5nY2+LqrBxwNcXFG
--00000000000077900b0625853d1e--

