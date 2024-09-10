Return-Path: <linux-rdma+bounces-4844-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E41E29727C2
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 06:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49821F24BDE
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 04:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF92B13A878;
	Tue, 10 Sep 2024 04:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bERABGMC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFF54430
	for <linux-rdma@vger.kernel.org>; Tue, 10 Sep 2024 04:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725940855; cv=none; b=a+dEwjEKmgSiL4wRbNliiR/OnZRySizRdqGArnlVzhVujq8+XahE01sguefz3TijaSyN+nyd34E0SWLa80KoEPSXVFIoB4Zlk6Ms+Tue3NwsxqT3ov2WeXfl/TW5Tf+YHBh7iGhwcNoNXXcIJ489R0qNOcRIS9YqowaaN88MTxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725940855; c=relaxed/simple;
	bh=drTcMW75ESLUDn5l2MOkq3k8YeszJ3mqG2Aw+uhS8t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJvf+aLiP3rILWPPhDhTtxGPgIc/67kdszoDiwyno6nsx2ikpkWKsZTQC7hUTfwUNxt7D3GES2+fbWdOBcXbYqhVmDYojfKBcycin1vO7d76uMhvYP10309vOKpI80aOysE6RgquTxFU27KXYGdfGL7NoMI7oFDIE+DlALiLrX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bERABGMC; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f74e468baeso60882711fa.2
        for <linux-rdma@vger.kernel.org>; Mon, 09 Sep 2024 21:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725940852; x=1726545652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aTMVXi4dSfXdC5dz/kRcRTNYT/nVAVmvghafWw/+OXw=;
        b=bERABGMCrSJzwMx0BL5Oqqy/9u+kQUoHMDu86WzX/dXiz/iHNUGY3oTodkjtjoBQXM
         o+QLuQXcPS6ZqBgq+ePvEJNyxzJCUwShUi9kHGqFLe2Rn51lLerbtdeHqbTgOPrX76NY
         HiMHMsnuzxtD7peVLqUo+j4TupCE1SJGhPWOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725940852; x=1726545652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aTMVXi4dSfXdC5dz/kRcRTNYT/nVAVmvghafWw/+OXw=;
        b=wWfCOQF4+eS4h8plGrGvBu8LUMwVY9COnBrtY+Mj/DdJJ8pj5GgsxmtOmbbAAAb+dg
         j2FcErm8Fjv4oAvQ6yc7BJhmsr5FSkW6jRvJTRjdNGVikw45umiUXb9aN00YVTnJtOeN
         Ww45ia2OXTW1CEDoWF5GzusZ2EEVa5NMuzgqtisg9ff33WkIuJUVPwhF1vScvQXrnKha
         qhmYTp3j2JL4Y+9mc3v0JGXwa6MBNZFoG1Jd75JPi5kwWaHS/Dkp9CF4et50p+ApL4C9
         mljCBkW8/LUqxAtB5W/v4tO3kuZ9FXXe8Uh40agkN5iEeyWj4g7kVmvENJsWD+CKqZJJ
         dHTw==
X-Forwarded-Encrypted: i=1; AJvYcCUFoP2YF9IfnPXft2WkHUEqTDtX5HBmfftNwGx4xNppyL6XhNQ3u+R3Bl+pnxbgRl699fm5pVgZcxbK@vger.kernel.org
X-Gm-Message-State: AOJu0Ywehg5zlhHwAAlyJ9PF1hjzkvkqxudxY+OPPUJ0A0bL5FepRZ/L
	IdNp/d0L0EjuMh5Kco1N2sBBXD/GUkSSYLHSvIPwhDvepvcq3uSB0DM8jLv48eSlmBA5mlBJ9aX
	00S/uQHCwJ5IUL0q/HgYT94Lg9rNARrhOLRT9
X-Google-Smtp-Source: AGHT+IEVktBJTNG7mm+JqrdQGyKNkNbBp3sI9uawZdTwGhr0CXGxGczmUkZD8AG5ngkhti3gjVm556LQ1syUELN2FFw=
X-Received: by 2002:a05:6512:ea4:b0:536:54fd:275b with SMTP id
 2adb3069b0e04-5365880fd8amr7907812e87.54.1725940851635; Mon, 09 Sep 2024
 21:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909173025.30422-1-michaelgur@nvidia.com> <20240909173025.30422-5-michaelgur@nvidia.com>
In-Reply-To: <20240909173025.30422-5-michaelgur@nvidia.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 10 Sep 2024 09:30:39 +0530
Message-ID: <CAH-L+nMhivuCfziOg0anCb5q6CNU_N9febb_qB1AFyDioW5f2A@mail.gmail.com>
Subject: Re: [PATCH v3 rdma-next 4/7] RDMA/device: Remove optimization in ib_device_get_netdev()
To: Michael Guralnik <michaelgur@nvidia.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, leonro@nvidia.com, 
	mbloch@nvidia.com, cmeiohas@nvidia.com, msanalla@nvidia.com, 
	dsahern@gmail.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000691fef0621bbebaf"

--000000000000691fef0621bbebaf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 11:10=E2=80=AFPM Michael Guralnik <michaelgur@nvidia=
.com> wrote:
>
> From: Chiara Meiohas <cmeiohas@nvidia.com>
>
> The caller of ib_device_get_netdev() relies on its result to accurately
> match a given netdev with the ib device associated netdev.
>
> ib_device_get_netdev returns NULL when the IB device associated
> netdev is unregistering, preventing the caller of matching netdevs proper=
ly.
>
> Thus, remove this optimization and return the netdev even if
> it is undergoing unregistration, allowing matching by the caller.
>
> This change ensures proper netdev matching and reference count handling
> by the caller of ib_device_get_netdev/ib_device_set_netdev API.
>
> Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
> Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
> Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Looks good to me
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> ---
>  drivers/infiniband/core/device.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/d=
evice.c
> index 0290aca18d26..b1377503cb9d 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2252,15 +2252,6 @@ struct net_device *ib_device_get_netdev(struct ib_=
device *ib_dev,
>                 spin_unlock(&pdata->netdev_lock);
>         }
>
> -       /*
> -        * If we are starting to unregister expedite things by preventing
> -        * propagation of an unregistering netdev.
> -        */
> -       if (res && res->reg_state !=3D NETREG_REGISTERED) {
> -               dev_put(res);
> -               return NULL;
> -       }
> -
>         return res;
>  }
>
> --
> 2.17.2
>
>


--=20
Regards,
Kalesh A P

--000000000000691fef0621bbebaf
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
AQkEMSIEILIQPp5vmr+juEFaLpO7NLSKVZsLzODUIcLIYAHd561XMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDkxMDA0MDA1MlowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA2nVQ0T07H
MYs3CzffQ9xllCQNMdpEBXt64DRidfsZr5vemaZRk7UQ+rblae60RZC4aO2fzgwsRMHQvjz7juQA
S/25Fju/sG9ErcrTSi80BoIBmrpVjylMNB1op0so7BczDSMokZC2ptwpcT7kNu4PBk90Q0nEQX88
xzifMA5fmcxvSGZtVO+a1nIlLDtbYGb34EkpXXG5VhZbOKcTmwo95goUkXsODvFw9nIfdAnHM1Nx
oYBLaF7+S1SAQfD3XUwnmgdejmTXwHYfW76ZmOzsVO0fltIarvaYjsP9ALHIRDEnHpZjCnlQbgIC
aw1f08DoruOnqCLn+687ELS95vtN
--000000000000691fef0621bbebaf--

