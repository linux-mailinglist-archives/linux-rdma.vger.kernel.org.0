Return-Path: <linux-rdma+bounces-4842-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C17109727BB
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 05:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22EA41F23E62
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 03:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBBD14037D;
	Tue, 10 Sep 2024 03:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H6zcHGhI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D5512E48
	for <linux-rdma@vger.kernel.org>; Tue, 10 Sep 2024 03:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725940714; cv=none; b=LuBjhJ4dkwQtlCvQTGmSXpa+Heej4NqODZlwnIIWCW5aGmoNK7Ugv7rgfgBciXc4FOlJLGS8K0NJ7w26bc7VVkmgiSYwAu3ZdAJ+nsy0/luDalnWW7Eu2Ahx8dM5suFn5212K331uBj6pmbuZ8hFtsFhD90BGnVq2A6XwQMIwco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725940714; c=relaxed/simple;
	bh=IMOUEIIhvIxtySxmyovggt0L83/y0A/ziX0gxvd7Ir8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aci5rljYzL3MoNpTLI6Jc7Z5fZVlyoNSaOEjMvBfYyGP8hgqA0h81rXb8i78fPu+8Db3USyuxKrpagH/0iaKt3ewrqsQ1baz3Up92EKQ1u6CpwRFSAkTzrlRUFpOfXl8DL/NYfbj/vv0b+SYXih0HqYYTr6mb0tL87Lj7D/4DDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H6zcHGhI; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53567b4c3f4so197081e87.2
        for <linux-rdma@vger.kernel.org>; Mon, 09 Sep 2024 20:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725940710; x=1726545510; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L3/T45OoIftlxuHheS/Mg0SoEVgQH5fgedy6ji0IgYc=;
        b=H6zcHGhIm1Nx3/RYBPaQx8KYuQ9pVQOZaUMzZJt3OTeYOp2SrSn/e5gfSEfaT4GHk6
         GkgC0tPLsOOneKbUQqdZrMn//bfGBy/bB7yt0savCzl2q97Qu7YOGVNsnH3UVb2s+5Ch
         vIsjtnIAoEXuZFdQSR9tM/plXzuyDaL5c9JtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725940710; x=1726545510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3/T45OoIftlxuHheS/Mg0SoEVgQH5fgedy6ji0IgYc=;
        b=qaYafHqFqaak7Mpu0o0XaW7EvmC20a7I3iVeu1rSsMaLLWUcBEB4XOpAo+4e3cWGBf
         Iw6AuKwm+jm0ZU6MvJGsGzW0rUGVx0ih6AiBs9L9awsQMDtB3+T7vC1E5rt4Fp8381yT
         OhCWjh3GiYmQVYfFA0Zdj2DJkO++5peQjzLDi/nIbimtJUaYKkE/mCbUNmhWPp8lqh6h
         h2JTvAQmdqgCmq00MbwTJ4XrpHNVh0dxKpW7xHdC8V/MrFECNRJjOSVjSjaQtdgBOl/B
         CJIJKBuajtqRKh7AmN2+LkuHRk3ZbOAKdCGFkyuMbWwnmpdu8h614Nn5P0E2emdPX7bW
         cs1g==
X-Forwarded-Encrypted: i=1; AJvYcCVfUUCZ06XhCwfFGxDvz0yVOjWHCDpEV96j7HA7lAKxvWchmHP0s7dlcEPiutYUtsjXrUQlQVdthcXu@vger.kernel.org
X-Gm-Message-State: AOJu0YwLA7OYGEgOnqMVNd65oOo/B0UG1BasWsMSzn1RVzT+B1QVf33V
	9RvS7MW65gdYITC52ojbSKR/2QPH6WRvLa66qoNGN5qSO85w/ACvGnZYJd22yhfWBndxpZOL7bG
	7oj+dHx3edhexO/r5fyWVwoazAfb048LwTgVt
X-Google-Smtp-Source: AGHT+IEtY7rV4Upi1WlXggFCbJbDMLFdnQh7iR1MPzuNZJBjJTC2rm6wi0Pt40ttJ+MU0/aJw0cZ/hqgixLYmrPjsFE=
X-Received: by 2002:a05:6512:15a7:b0:535:d4e9:28cf with SMTP id
 2adb3069b0e04-536588138fcmr8520915e87.59.1725940708984; Mon, 09 Sep 2024
 20:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909173025.30422-1-michaelgur@nvidia.com> <20240909173025.30422-2-michaelgur@nvidia.com>
In-Reply-To: <20240909173025.30422-2-michaelgur@nvidia.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 10 Sep 2024 09:28:16 +0530
Message-ID: <CAH-L+nMVqug0+4UYFs+nRyTXiYgeRgkQc2ELXOSC-uFR0xaCeA@mail.gmail.com>
Subject: Re: [PATCH v3 rdma-next 1/7] RDMA/mlx5: Check RoCE LAG status before
 getting netdev
To: Michael Guralnik <michaelgur@nvidia.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, leonro@nvidia.com, 
	mbloch@nvidia.com, cmeiohas@nvidia.com, msanalla@nvidia.com, 
	dsahern@gmail.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f30fd60621bbe215"

--000000000000f30fd60621bbe215
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 11:10=E2=80=AFPM Michael Guralnik <michaelgur@nvidia=
.com> wrote:
>
> From: Mark Bloch <mbloch@nvidia.com>
>
> Check if RoCE LAG is active before calling the LAG layer for netdev.
> This clarifies if LAG is active. No behavior changes with this patch.
>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Looks good to me
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/ml=
x5/main.c
> index b85ad3c0bfa1..cdf1ce0f6b34 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -198,12 +198,18 @@ static int mlx5_netdev_event(struct notifier_block =
*this,
>         case NETDEV_CHANGE:
>         case NETDEV_UP:
>         case NETDEV_DOWN: {
> -               struct net_device *lag_ndev =3D mlx5_lag_get_roce_netdev(=
mdev);
>                 struct net_device *upper =3D NULL;
>
> -               if (lag_ndev) {
> -                       upper =3D netdev_master_upper_dev_get(lag_ndev);
> -                       dev_put(lag_ndev);
> +               if (mlx5_lag_is_roce(mdev)) {
> +                       struct net_device *lag_ndev;
> +
> +                       lag_ndev =3D mlx5_lag_get_roce_netdev(mdev);
> +                       if (lag_ndev) {
> +                               upper =3D netdev_master_upper_dev_get(lag=
_ndev);
> +                               dev_put(lag_ndev);
> +                       } else {
> +                               goto done;
> +                       }
>                 }
>
>                 if (ibdev->is_rep)
> @@ -257,9 +263,10 @@ static struct net_device *mlx5_ib_get_netdev(struct =
ib_device *device,
>         if (!mdev)
>                 return NULL;
>
> -       ndev =3D mlx5_lag_get_roce_netdev(mdev);
> -       if (ndev)
> +       if (mlx5_lag_is_roce(mdev)) {
> +               ndev =3D mlx5_lag_get_roce_netdev(mdev);
>                 goto out;
> +       }
>
>         /* Ensure ndev does not disappear before we invoke dev_hold()
>          */
> --
> 2.17.2
>
>


--=20
Regards,
Kalesh A P

--000000000000f30fd60621bbe215
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
AQkEMSIEICNSMJXdrFl0GC9x5WWP8CWMhFrN3zZDQlyCHla8rK15MBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDkxMDAzNTgzMFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBlPubgpDa8
EuFHAlGnnjH5OM+eemID9kFm2UK5PJf1qVIuafW47ABLeyEOrzlC/pNKbAB8E3AcuGDuSlfRqxtm
Uzlv2C1Pjazl3KBjay+0iBkfS0qINq7em/7CulBsGTD4eL3c5TthtHZsT16nySw4pAbaOJSPKDbs
a1HDcz8+XfgO6hvALY8LeiDKADLRn5CTh/YE7qIAzho8rmtEmc16tU6LTUqNZKpwUXGSLwHF5uTV
a89wUnZ+/vEEdWWwa8Hwuv5YrvrJTFLrfN4avxCa34ydgJ8oWeSYp9zHvuO16AJYefuqy0PtQfzs
X+ZvVJeYm8naruMeBf1Sx1adW05g
--000000000000f30fd60621bbe215--

