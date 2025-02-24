Return-Path: <linux-rdma+bounces-8029-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C61A4178F
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2025 09:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A22516DE64
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2025 08:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA33C198E77;
	Mon, 24 Feb 2025 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QezKL5NZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF73817548
	for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2025 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386313; cv=none; b=PmCz8/9ll67jErPs7IIrqOn0BBn1ebPj3hI1M3MGn62sCFFyz55I1+gZfyh5Mug0ELHjxmw++h3Fy9zjDLfNLozmGGLQjEdG9Mxp41+CDA5IBhBX0Aw1DZcTF3jCblDK6uaR44+seS88anRjUnkZ+R53236EWoDKRgC+QRecsjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386313; c=relaxed/simple;
	bh=h5u+9GMXsC+Jlpu17EWLQEzN6AkT72KOoCpwhaAbOzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDlBfag8T4ALyNuUhk/8rM7alFckDRbf4LmeDznH6rnt06p37h6RcNvAvPdR7bAwnGd5ogeR59cQ+MOvXp+em1zCCRHZ68yWIwlrZybWCWMSKWXGk9qgvXEEqCvtVaCKmXOMBkewxRmk6P2tBcI+UD0RMxpuYXMa3eIhAeHUfZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QezKL5NZ; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5209ea469e9so3534858e0c.0
        for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2025 00:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740386310; x=1740991110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8g7/1d9YTVRvwct1bPC+3VIZjKFh6tO6+Cm9QzniYv0=;
        b=QezKL5NZMUJ1cJkCa2Uo8/wqkh6cTEKykj4v0ebSpCjhARvSgItVPwuK16PDUnvw7N
         7M3Y/I+slKqYl2Dsc5kQPk6Zr50yeLNBdNZJUpLaDJDch09ZNU/6GG0erXaR/Zlh0BCp
         tQPhuSK2iHk+6URFqso7WzH8VwsxDLHm29gTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740386310; x=1740991110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8g7/1d9YTVRvwct1bPC+3VIZjKFh6tO6+Cm9QzniYv0=;
        b=g4eCk3BX7TBtUAFmbnZYWKs6t2ErnQfZnUGIsUqNDP03cmm0HsljSqTA2S/uMmsiU5
         rNeS8x/uGs4iL7yJChBpih06wHRnB+C073XqL5YgzV1HEgdJnZqC/9qloGL/WNl87mEp
         MxCKMb5JQbUh85J6ynJJ2N0FfaBKtyV7AZuY4pGqqUUWysCF293VaCRLOyCnYhtdx5it
         7wQ2hRFuUde6CPUC6h4BVM8WHhelaVX+cRzPt2ANeLs3TswKEp5SxyI4tfKRGvd79jKY
         R4pFm4+Uoe1aPc41Huf7AvR5vpbiWioB1lQAoH/P3B0cMZONyyCK/zAAxR/1ahjZ0SEn
         Xtxw==
X-Forwarded-Encrypted: i=1; AJvYcCVxBTZUcvfm0WeWD1hd3/6VmDBKp9DFpU6L3ligHHPMMt+TL6BfHnSPcSROTIwKlAfXRnYlViftslSt@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzm00XJOlrZlOC2g954denG560wGcGk0ZfDa5EAFDo/tUAKNCF
	Ii7R4JWP0f5OoMtwxnmyyELwf/IKf3h2xG5cjnbpQQyvswfPV3cVqfhX/FLg7W2ZRIjFiTGYLpt
	p/wMgsfJZsCb7PTAsR3K8K0gsETIV/C6t5nsV
X-Gm-Gg: ASbGncuga6brOEI6mv/6VCERUfrq1J9r4gIK3ZEqYNeWpfv52Cmh9Vu3qPMgXtBkzJ4
	rUAzMvqsZllI4ZQ3SnriAojF2X27kiXRos3vpwv0JYVvNJTvAd6CVMEn95T5y2/WaNqX1crTaYw
	ZS82gu9tMA
X-Google-Smtp-Source: AGHT+IG8wc96LdQ2iGLYFkaq7Qc7cPLhIEebSo3FJE7z0o0a2d52WrMgQ+LJwTSz/xt4C+SDnIMJ1I+55oI41/Yq7B0=
X-Received: by 2002:a05:6102:304b:b0:4bd:860f:ff2 with SMTP id
 ada2fe7eead31-4be99122626mr6787530137.4.1740386309754; Mon, 24 Feb 2025
 00:38:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221085350.198024-3-thorsten.blum@linux.dev> <9ec62114-f92a-4db4-a929-9d3d53e144e4@gmail.com>
In-Reply-To: <9ec62114-f92a-4db4-a929-9d3d53e144e4@gmail.com>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Mon, 24 Feb 2025 14:08:17 +0530
X-Gm-Features: AWEUYZkiQUpUN4CkEqX_XL7yV0pHysShh8gxDvTLq62oEPVP2ejxMGEdVIBAIfk
Message-ID: <CAOBf=mvRK=CK_sExdSo5i-VxXUQMPqEf_w++vDJwWE62vGec6A@mail.gmail.com>
Subject: Re: [RESEND PATCH net-next] net/mlx5: Use secs_to_jiffies() instead
 of msecs_to_jiffies()
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Yevgeny Kliteynik <kliteyn@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Itamar Gozlan <igozlan@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	Saeed Mahameed <saeed@kernel.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c7f07c062edf4330"

--000000000000c7f07c062edf4330
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 4:05=E2=80=AFPM Tariq Toukan <ttoukan.linux@gmail.c=
om> wrote:
>
>
>
> On 21/02/2025 10:53, Thorsten Blum wrote:
> > Use secs_to_jiffies() and simplify the code.
> >
> > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > Reviewed-by: Saeed Mahameed <saeed@kernel.org>
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> > Resend with "net-next" in the title as suggested by Jacob and Saeed.
> > ---
> >   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c=
 b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
> > index 3dbd4efa21a2..19dce1ba512d 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
> > @@ -220,7 +220,7 @@ static int hws_bwc_queue_poll(struct mlx5hws_contex=
t *ctx,
> >                             bool drain)
> >   {
> >       unsigned long timeout =3D jiffies +
> > -                             msecs_to_jiffies(MLX5HWS_BWC_POLLING_TIME=
OUT * MSEC_PER_SEC);
> > +                             secs_to_jiffies(MLX5HWS_BWC_POLLING_TIMEO=
UT);
>
> secs_to_jiffies() is expanded to a significantly simpler code than
> msecs_to_jiffies().
>
> LGTM.
>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
>
> >       struct mlx5hws_flow_op_result comp[MLX5HWS_BWC_MATCHER_REHASH_BUR=
ST_TH];
> >       u16 burst_th =3D hws_bwc_get_burst_th(ctx, queue_id);
> >       bool got_comp =3D *pending_rules >=3D burst_th;
>
>

--000000000000c7f07c062edf4330
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
nSGLsSobByQoGh1GyLfFTXI7QOGn/6qvrJ7x9Oem5V7miUTD0wGAIozD7MCVoluf5Psa4Q2a5AFV
gROLty059Ex4oK55Op/0e3Aa/a8hZD/tPBT3WE70owdiCwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpzb21uYXRoLmtvdHVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUabMpSsFcjDNUWMvGf76o
yB7jBJUwDQYJKoZIhvcNAQELBQADggEBAJBDQpQ1TqY57vpQbwtXYP0N01q8J3tfNA/K2vOiNOpv
IufqZ5WKdKEtmT21nujCeuaCQ6SmpWqCUJVkLd+u/sHR62vCo8j2fb1pTkA7jeuCAuT9YMPRE86M
sUphsGDq2ylriQ7y5kvl728hZ0Oakm3xUCnZ9DYS/32sFGSZyrCGZipTBnjK4n5uLQ0yekSLACiD
R0zi4nzkbhwXqDbDaB+Duk52ec/Vj4xuc2uWu9rTmJNVjdk0qu9vh48xcd/BzrlmwY0crGTijAC/
r4x2/y9OfG0FyVmakU0qwDnZX982aa66tXnKNgae2k20WCDVMM5FPTrbMsQyz6Hrv3bg6qgxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgx6wAr6NdQY0sTG
G7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICW6MpCoNrYx52pvEaqZRaye6Q3I
mj/3YXAo90JZsnt1MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1
MDIyNDA4MzgzMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBJUEvQ+yEKYGqu1rIWZchlDx/PNJYMOW4sqg2uLzPi4fW2
cGwp3BOzECr5vuEO5jAqd0UOS6foZkH6RiLD6YqASFJXleuYpg9M7TZoSi+VrVut57Ad9r5MaH5U
gSUDzHtDgPWDmFbi3PM3Lwnp4CyeXnr4RIWZmltR8Y6yF94q3/HkWEzsNIXT7LVU+d2OOpRtbkqv
D2IirxwplLVnjn2E2RBCLrsDvjEVQrvVA7Pu9nRiHTOzswd1ApBIQDqA5zpF5PG2joEJicvAR5ws
3nKfrlHOpf0+929TOfiAIDqr4frG0fJ6BJBxx82SQNBzOyWtUylCXuw3SN9J61YEzDbc
--000000000000c7f07c062edf4330--

