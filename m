Return-Path: <linux-rdma+bounces-15325-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E20CF88E4
	for <lists+linux-rdma@lfdr.de>; Tue, 06 Jan 2026 14:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5D493017EF5
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jan 2026 13:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768EE33AD8A;
	Tue,  6 Jan 2026 13:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NlCM3jkH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B347D33A9F4
	for <linux-rdma@vger.kernel.org>; Tue,  6 Jan 2026 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706540; cv=none; b=TFilBOKS0muzSy2YzI4Zzu1YjiK2Pdaen5XUWpKSm6CfCH9OxNsnspn3VoccldHOTtkEmZXV1gTkeO92lhn38ik+oKiTKNJZoScB2onkIVGwY5IlQ5u61tA5z4QrDq6rd6WSYKa9iiuDspVrIgnm46xXQwqX8HI3SPlSySyvdus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706540; c=relaxed/simple;
	bh=EIbDzEpvZUPUvwOYO9lsa0TqFC8WZ7aSs9obPdc3KsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxfEsxPVK0ZLnFBlpUMZYgDWS9F0PgTHnxzpoPA3IADV1HD62qf3RIr+lLQY6FdwqKMD3wJ5e2sdgY8xVu9hTsSdgLDxq9i7iwgSR2/Ts80KwQv4iiF8EOK1F/hU3bew4oKvA/gp14F9eZn2Z8BjbAonG/mMJUWfSlg1/ppUYlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NlCM3jkH; arc=none smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-55fe7eb1ad1so732764e0c.1
        for <linux-rdma@vger.kernel.org>; Tue, 06 Jan 2026 05:35:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767706537; x=1768311337;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqHAIDdPbpb7XofBcNsj257qaVNfu0iMJ0QcznvIkM8=;
        b=pJPGVvFHC2v3/8RXAlsr+mj1r0lEORubLZIn8zJ80HrwQssuVWPpqtSg0XmXdYgsTm
         dox/jqLJku6r6+Vb+Y8pOlJXMuRriPd2/8i6Kaui4gNVkMGdUCnQgaZ0TianwdYWoWA3
         7rtCQ6CfH7cFoCk/jncfr7bn7zCstc7CFJAo27ePG5G1T2G06xZeO0N5o2YW+dYtbsPf
         wOE9K7vpM34yPhGQ/W8A1OUqCApB5SquaNODXUy07FCfovjuRjN/gVi+8AdMWVC9tVoS
         s64PG41iZS1pmOz3F92rj/4lkES1uruQVyb4togc8fCLM1AQn+9ApoDN4ExixhK2Enp5
         M/Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXDE7IOtNB5XAM8962Rx+lj5XMWmOJXVHqa3oJ0rElmp/ZECfJpB4iEMeOP1A991w2AD/9cdCA8MWBS@vger.kernel.org
X-Gm-Message-State: AOJu0YxBVNekbM9IDSd1U4Rzkk89GWz4ET02zXSzFHRuOVNMZAx9YUUM
	o2e5gie4Wxz5auiQ7azFFCF8NRa8D+urJNIZrv5eb3K9pbV0RhcBO2Ow0hyatjU0NZGcCzAv9YX
	1WTGevaT+Mjy5mZ/xI8ZvcOrtC9ta+ptWiA09AH71vGGxvhqt0+t9/AUC6cEAOmAVcqTBYOo38R
	HOWse1FOq7s3IFaww9SJZb3sKuYdUR/XnvotNA4+4d6PV+oh9WKz+7Hn2axrUcoUJkn5d1pcAcL
	4arhCph0X9La8s=
X-Gm-Gg: AY/fxX4ptZ5otvdzHX11YZ88QGOSuHVNScn5+43Z6L0V2KlZ5P8UJ97ESJxuH702dzv
	oIhDYZev9ChFHxPn+CBWmmjx5J0X1BoAO6mBcI/zI4XYPfilgeMnC+ObPrFl5cCSqgmk3ITnP9K
	zWhkFfapw83eMk5nNr6vR+8IaAFA87RQhvqbFasferp5Wm/hMsZlWxAZxij5q+bfs9Tu5qFE7Vu
	AUL/+oURrvltTlAtMHAUFhbOBqSk+9WDYwXiPbgMcc8xS1onelO/T3PmVbiJMJAqGHgveCj6wVY
	YJ4dBBhbVYipU6pZ8edWZ2GskwGHOmOtr6NVQu5+8L2A6IQZR62KQSfLcZ99MrQuY3KN5OBiCBY
	Mt0ThCv+WThG/JRUrzuh+wT0U3L1gjhQjJuAdrHzPXjmsKxcKn321+gup2ZV4fo8uLNPABl3oP+
	Z04swIHGqvEfI9CMF42T/OlCEvcfSfda2UBz26GfQ4
X-Google-Smtp-Source: AGHT+IFkhNCNdBug/HLsPUabmBzWJRMV8l8DU5rfa1NvPgG4ljAsnQGQ2OSQP8Bn6oaJBQxL1Ixvg6ZM8dCJ
X-Received: by 2002:a05:6122:1350:b0:549:f04a:6eb3 with SMTP id 71dfb90a1353d-563394aee7cmr843030e0c.9.1767706537530;
        Tue, 06 Jan 2026 05:35:37 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5633a073d72sm267168e0c.0.2026.01.06.05.35.36
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jan 2026 05:35:37 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c387d3eb6so1011314a91.2
        for <linux-rdma@vger.kernel.org>; Tue, 06 Jan 2026 05:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767706536; x=1768311336; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqHAIDdPbpb7XofBcNsj257qaVNfu0iMJ0QcznvIkM8=;
        b=NlCM3jkHpUy9nxG2QGfw9Id7Wq0PL65u42N3j2XwWlkT2zZ2qDCjOb0KvrXesIQNx0
         OD5nop711qJweZJ8chfn50ysxb4KXDJsF9hAHAWOroqZA1bIYm8keJd8EZ4QZob1Rulr
         mm2+Vu7rIrDVZNG0lfTf7V/eFqMxfhuKe4LYI=
X-Forwarded-Encrypted: i=1; AJvYcCUYXZJmdUj3q+ZASYGiFc4sfkUtnVltqndRhJbZsuYrc9ceKdFtKGITj5DUAKTED/UYnQ2GKLgkFF5j@vger.kernel.org
X-Received: by 2002:a17:90b:2ccf:b0:343:684c:f8a0 with SMTP id 98e67ed59e1d1-34f5f30273emr2255201a91.23.1767706535913;
        Tue, 06 Jan 2026 05:35:35 -0800 (PST)
X-Received: by 2002:a17:90b:2ccf:b0:343:684c:f8a0 with SMTP id
 98e67ed59e1d1-34f5f30273emr2255182a91.23.1767706535527; Tue, 06 Jan 2026
 05:35:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106120343.54758-1-sunliming@linux.dev>
In-Reply-To: <20260106120343.54758-1-sunliming@linux.dev>
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Tue, 6 Jan 2026 19:05:21 +0530
X-Gm-Features: AQt7F2rrBInL-kdsdz8VCOr9egXOkpsmc_PmoR_PS3kav6feoRhoIiVvIQ_d7OM
Message-ID: <CAMet4B6o-BbUM9RjAHNJXQA32-rvQQ9oaynfZeoSGg+JZkvyaw@mail.gmail.com>
Subject: Re: [PATCH] RDMA/bng_re: fix variable dereferenced before check in bng_re_net_ring_free()
To: sunliming@linux.dev
Cc: gg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sunliming <sunliming@kylinos.cn>, 
	kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002a30d90647b840d7"

--0000000000002a30d90647b840d7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 5:34=E2=80=AFPM <sunliming@linux.dev> wrote:
>
> From: sunliming <sunliming@kylinos.cn>
>
> Fix below smatch warnings:
> drivers/infiniband/hw/bng_re/bng_dev.c:113 bng_re_net_ring_free() warn:
> variable dereferenced before check 'rdev'
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202601010413.sWadrQel-lkp@intel.com/
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  drivers/infiniband/hw/bng_re/bng_dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/=
hw/bng_re/bng_dev.c
> index d8f8d7f7075f..c32395d1593f 100644
> --- a/drivers/infiniband/hw/bng_re/bng_dev.c
> +++ b/drivers/infiniband/hw/bng_re/bng_dev.c
> @@ -118,7 +118,7 @@ static void bng_re_fill_fw_msg(struct bnge_fw_msg *fw=
_msg, void *msg,
>  static int bng_re_net_ring_free(struct bng_re_dev *rdev,
>                                 u16 fw_ring_id, int type)
>  {
> -       struct bnge_auxr_dev *aux_dev =3D rdev->aux_dev;
> +       struct bnge_auxr_dev *aux_dev;
>         struct hwrm_ring_free_input req =3D {};
>         struct hwrm_ring_free_output resp;
>         struct bnge_fw_msg fw_msg =3D {};
> @@ -127,6 +127,7 @@ static int bng_re_net_ring_free(struct bng_re_dev *rd=
ev,
>         if (!rdev)
>                 return rc;
>
> +       aux_dev =3D rdev->aux_dev;
rdev is valid from the caller.  NULL check for rdev can be removed. I
need to do few more changes for
addressing  other comments in
https://lore.kernel.org/all/202601010413.sWadrQel-lkp@intel.com/.
I will be pushing a patch soon along with removing if(!rdev). Thanks.

>         if (!aux_dev)
>                 return rc;
>
> --
> 2.25.1
>

--0000000000002a30d90647b840d7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
fyIFUZVWSBcxHWtNNVK4Oi0mqSJut0p/SwfLg6IMaVBU9VdXgVmw35CgcX/9B1ITmih041Oz+Qyo
wTULsXik3lHJuyhYevN9h4259CoDPt+tpaykVaqa4luUmGv8k3F6aC4+fZl83ywHGVun9fBVk/GE
2hmynyIEon1w6Me72fdjaPht4V1tbZBu/76zGxBiBFc13nAKU0dYrvIGPgKN9j0HDuOVC7UhhdTq
Gw+wN3sPJk9D2VtNAzNGw0sa/eJF1wQiBy4RVYG9r0MCAwEAAaOCAdwwggHYMA4GA1UdDwEB/wQE
AwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5Bggr
BgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUG
A1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUF
BwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDag
NKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIwYD
VR0RBBwwGoEYc2l2YS5rYWxsYW1AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBTNBMIvX7vsfxNYWor1Hxth
tmNmHzANBgkqhkiG9w0BAQsFAAOCAgEAJDoTbZO7LdV1ut7GZK90O0jIsqSEJT1CqxcFnoWsIoxV
i/YuVL61y6Pm+Twv6/qzkLprsYs7SNIf/JfosIRPSFz6S7Yuq9sGXNKpdPyCaALMbWtPQDwdNhT7
uJgZw5Rq9FQRZgAJNC9+HBtCdnzIW5GUmw040YclUNHFEKDfycJMKjSPez044QcDoN0T2mIzOM8O
Dt+sJTrC1YJ6+HI6F2H6igZUL79y9qYUz8FNshyITihg/1VBVCiMU9WRK3tNfUlLFzLBuTTr245d
xMh/e75vypL3qDSF4UG6Mpy++Plsnjfwab70KFFyCvNwB2hT1g/y8MLgslfxJl6fCyGdWqOmUB2J
QiuiqbSy8mlnucIPuGWQqqt8VBQjxKYIHdjXtkvw0uVvOHUC2QJWfGWDhMncxF5LFoaRPer4tlXJ
b5zmz9Mn+uQPQQLYUqYzs+EvX1REmGLGUuzlaNwAC20+8CVPY2EkU1mjU78+aW5Zbb2MyjQrLc6J
5IdkekEtk+xjpM992MC/aNMTpWIWhorGq8NmPXbuoUZf9MSi7WrVCaO69ro68FXPTErr/e13lJ/5
GAkwcxdTC+YVPVa/xpdHyAFW03/Oow/7fV8qjy6PAWfqEV97D2Tspc2aEFkbeuFS6UkPRy1OKjGc
/IUTSY4h9roe7Bh1ecqtofP9XL8E88sxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxoOshI0IGR+aGCCXkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIMkH
lpoGLsf72UFVnCwwE+cn1P3BB0yNFCfODxAAqWz9MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDEwNjEzMzUzNlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBALvNL/LRPAyNMvrFY2rbVRS1Lqfy5HyLp2mLrL7G
75+SA02qWpyPbkusXDc6YJns1XSnQ+ojB64trUhLASPHQvQgPhFyTnAMsZu8DUsowmc6PK55tofK
z7/iIACotCT/MIsJFjWUkfw02vjRwhTvT9/prm+BqqoEZa/r24fKqWA7okqIYLLKIpo9rBcHPW7U
bSDeZrGs8esadvjaGtawGW+vaO24WMVKkvZ2fnV5uH+hJbuwb+BHb4r7vCeYeUBXeYHLc4uueb2L
vLmpkjb+aFBKtkvJV/FG7UcsHq1XFe/trvFv90bG8Ro/kEx7AClQKdFJb7UIsgZ+/vjV+oU2eQQ=
--0000000000002a30d90647b840d7--

