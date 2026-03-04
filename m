Return-Path: <linux-rdma+bounces-17460-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHT2NTP1p2mtmwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17460-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 10:02:43 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BB11FD103
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 10:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B68B53007AF2
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 09:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D2134F48F;
	Wed,  4 Mar 2026 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="a1OkD44n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52AB1A58D
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772614958; cv=pass; b=MVGDqjwvIBLy5/aB5t2iDlKXvZPFa7fsawtI0E8Dy0p8BK2kkpo4ikpYcos+3MlDUdOPqpRtoAfHakh45zhr33fkcowymuD+2NqAI8wUS1V6G01/4ugxqfIXTKepzBLYkqwtQgAJVmwFDFSt/o0gzJMPYWCFomHanyDlfzoffoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772614958; c=relaxed/simple;
	bh=ZieFyj8ViavD5FBWMyU8oqRZyEiUBBu5Xk+dXrYFOf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ckViRFh9MtJGz+2k5VvPGm9BYJZ5UE2L/W7iTX07GvBJpDTNaLcR1fJKK8Qh+GuyV7z+3jtbWvGA2D9mBeW2VyJ/uy0fEf3vNJ7F+4vdVyLRQcZsBbhhW5uLA8GHWNNCbH7FeyfpBXQ30l67HcJLWeZtkRPXkFPTo+7ZrbHmVGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=a1OkD44n; arc=pass smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7d4cb7e10efso7683132a34.0
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2026 01:02:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772614956; x=1773219756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/C7nlGgesjmwxGZaFWkxNfEwoAChYqvcN0WiXXk6aQU=;
        b=JGbMQqFd6ENxOIH83r+QVqD225nD3DoU1gu/NiQP7v9gk0TWmEBn/gev1+O/4oR6YM
         ndxye9CgUCWM5JSm3070IC557hI7eVmh5sZh6xYH70kTRhHKqyegIVkrQcadxI+Q5X25
         aPZXxrOU6JZsftfi1kL2wdg8nAxUwbKVGgqGp5wwrgOEQYm5pF1kyBZTqyzMLp5HlFXZ
         gHuuedz8vTYYcw19pE/UKSTIK1FtixPdNxYb8ewXS8d+HZCREEyfgSzUGrM/abv4UFJj
         CsmDJ/IJVerCE4wM3b5rGP4Lf2fByZVcl7g2ircyNDdoZ4fSJYHMNcxZeD0Z0CfcJ4hM
         H/SQ==
X-Gm-Message-State: AOJu0YyZt6eb7iMPqxJlH0jhl4GaLVXVs7sEyr0b0RgO9CgWwFrhvgtY
	PYMW3pKsEeddIC/ikHeW4wb5ZuqplNJabFax0nYB5V89FnwbI5aBdUiQKoAP6aGJCd1IXJus5a3
	9RX3Hnpo1ka+Ywn6xjafZIFJ1LGcOKWPCiQcZpjl6PRgnSup4zVd0UDWgcfW3knb8imwQqV5HIP
	8EQGYFqEvTFQxJbSbk9dGg+CZ4RvHYqtZf4VK39ndJRdsSpieH5k8L74f9MARzVNzxzyH8G+rB7
	F3MRj721OOnvUw=
X-Gm-Gg: ATEYQzxc2mrHXo1ZMwNd4l+31zsH0X1+aEZxNpVMlNn4u+o9P5LNEXy7JvoNZ4jzOQI
	uhZOQjZTv2w/OK3rZcAn2NNfZLcxbCo/zVCYoVBhgm8D2ue64tcvIFg7v91+UoueTVzT2nSy3pQ
	IXrQyu1qY0jdQ5kHSx7/CjlcrOhc79LI8xCKTGsB6uZLbzjWpZJIJpynGIf3KNg0uWGCYrumm8w
	J9cOtfqRb2NUdIO2+7QCFmiWDQ63nbk7P+KiLa7PlAVbNAXz6/KiKDiVI+yJer0nGr8C3i/Sg6Z
	V+TfDxwoLEN6v7NEx9JOzyDbmKLNN+EIT98T0yH9MjzpBCjVXV82mz2PXRjqeVhPVTFAp9Ci41K
	56UcEJb19DNILLzGMyAAearGSA8Z0IfU9J2cCCIKLMnM5B7SqbfZS+V+1p04GK4mNSvyfFp8IJq
	a6wusxQ98LfsstE/Pcl9R5jWzUNVYPAJYuniqH1u/05DQy6uV8PEIy+kc=
X-Received: by 2002:a05:6830:7191:b0:7cf:dd63:3d37 with SMTP id 46e09a7af769-7d6d13b1e9emr824094a34.25.1772614955630;
        Wed, 04 Mar 2026 01:02:35 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7d58661c821sm2249888a34.6.2026.03.04.01.02.35
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2026 01:02:35 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ae4af66f40so39971615ad.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2026 01:02:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772614954; cv=none;
        d=google.com; s=arc-20240605;
        b=H1E7/2Jdbb9J47PEiTUOIZIV8xgWDzzIXa/4Zi5fyAuMnXyeDQQzlBCe4taICPjsjC
         NcJ3gp2pAQr05T/rhhV3dQOETLSvegW94bayMS+Wi4z+AfXbK6JgiSaNZBvIn4dicapi
         DmbOcLShfJWlyOWCZOzOzOzNKfl4vC5cvurUPuyLCSDjepwKFp0bX2DaLMFUeXyKh9kl
         6aPKlVPFaW5XT1yhV0TgDoWgpagj758Lxbu8wAbzociYZuSl/UMBh8SBiMiBP+DVGSy5
         VdprHMXO6VgxK0pzi5/krlJ4FDtVaje0xhwoGaAyOH7gU6gizP20HW1e3RpCqmlgT31q
         Z2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/C7nlGgesjmwxGZaFWkxNfEwoAChYqvcN0WiXXk6aQU=;
        fh=w0mXopiuvrEbtyibuHGjr8e7My6f8zLWL4cctQqRa48=;
        b=iPFye9Jrz12hcb02Oazx7VEdLEiJysQ30fyMvcc5Rv9c+xAK7PkB7lf1iiBOZDHttb
         u9mKDjrBN6L0LORDsecjxk66KDj8AALwG+hBZUkhEc8t9+OpTgL+W+hPJ8k/CgClsa/u
         NgnbK0FihQHN8jHBiis0ImO9m3HdlS47yVZlOUqYbyQY2XOxsrtTx0LtP+QLYQP/hvHv
         MkLLJAbqRjiXSuiBUg2V/thq9yik+ormiS0FyJatv5go8LbxpjJm7RbX8hMysyyTPPC2
         YVmBPvXARHYEaeSqu0Yeb840nnJ2piOb3DC5LSVB3xA0oaaJ4qUeP4wmnH57GlSG0TEn
         45yQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772614954; x=1773219754; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/C7nlGgesjmwxGZaFWkxNfEwoAChYqvcN0WiXXk6aQU=;
        b=a1OkD44njNRhnMohEkOW19RsQEeXeR6Nd1ndIKGwApBdVVrQ1Lm6R99pRgLEz4I2IB
         Z9nh+ILXv5uAdqOmfl1et+RamFSPgclkOSNdTOqyka5Ir6XurywAwKO0M6DNoewpYPJd
         CWfRchEZArANWFJCiSAiFBWYwMKFZ2LkrH+vY=
X-Received: by 2002:a17:90b:2691:b0:354:a2a0:259f with SMTP id 98e67ed59e1d1-359a69c2a5cmr1176396a91.12.1772614954224;
        Wed, 04 Mar 2026 01:02:34 -0800 (PST)
X-Received: by 2002:a17:90b:2691:b0:354:a2a0:259f with SMTP id
 98e67ed59e1d1-359a69c2a5cmr1176380a91.12.1772614953721; Wed, 04 Mar 2026
 01:02:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303043645.425724-1-kheib@redhat.com>
In-Reply-To: <20260303043645.425724-1-kheib@redhat.com>
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Wed, 4 Mar 2026 14:32:21 +0530
X-Gm-Features: AaiRm50ir1p1BcBwrHp1iAu7ABi9zjtkWjQjJHookaOnntBFSMJeuwvGfjLYzOQ
Message-ID: <CAMet4B6G3AQ-KPQ=8U5r+kKBqvEMAfZ5ZFKqnMmRN1nJgZvyag@mail.gmail.com>
Subject: Re: [PATCH for-rc] RDMA/bng_re: Fix silent failure in HWRM version query
To: Kamal Heib <kheib@redhat.com>
Cc: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b0720f064c2f1416"
X-Rspamd-Queue-Id: A1BB11FD103
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17460-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[siva.kallam@broadcom.com,linux-rdma@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

--000000000000b0720f064c2f1416
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 10:06=E2=80=AFAM Kamal Heib <kheib@redhat.com> wrote=
:
>
> If the firmware version query fails, the driver currently ignores the
> error and continues initializing. This leaves the device in a bad state.
>
> Fix this by making bng_re_query_hwrm_version() return the error code and
> update the driver to check for this error and stop the setup process
> safely if it happens.
>
> Fixes: 745065770c2d ("RDMA/bng_re: Register and get the resources from bn=
ge driver")
> Signed-off-by: Kamal Heib <kheib@redhat.com>
Reviewed-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
> ---
>  drivers/infiniband/hw/bng_re/bng_dev.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/=
hw/bng_re/bng_dev.c
> index d34b5f88cd40..17147175a9b0 100644
> --- a/drivers/infiniband/hw/bng_re/bng_dev.c
> +++ b/drivers/infiniband/hw/bng_re/bng_dev.c
> @@ -210,7 +210,7 @@ static int bng_re_stats_ctx_alloc(struct bng_re_dev *=
rdev)
>         return rc;
>  }
>
> -static void bng_re_query_hwrm_version(struct bng_re_dev *rdev)
> +static int bng_re_query_hwrm_version(struct bng_re_dev *rdev)
>  {
>         struct bnge_auxr_dev *aux_dev =3D rdev->aux_dev;
>         struct hwrm_ver_get_output ver_get_resp =3D {};
> @@ -230,7 +230,7 @@ static void bng_re_query_hwrm_version(struct bng_re_d=
ev *rdev)
>         if (rc) {
>                 ibdev_err(&rdev->ibdev, "Failed to query HW version, rc =
=3D 0x%x",
>                           rc);
> -               return;
> +               return rc;
>         }
>
>         cctx =3D rdev->chip_ctx;
> @@ -244,6 +244,8 @@ static void bng_re_query_hwrm_version(struct bng_re_d=
ev *rdev)
>
>         if (!cctx->hwrm_cmd_max_timeout)
>                 cctx->hwrm_cmd_max_timeout =3D BNG_ROCE_FW_MAX_TIMEOUT;
> +
> +       return 0;
>  }
>
>  static void bng_re_dev_uninit(struct bng_re_dev *rdev)
> @@ -306,7 +308,9 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
>                 goto msix_ctx_fail;
>         }
>
> -       bng_re_query_hwrm_version(rdev);
> +       rc =3D bng_re_query_hwrm_version(rdev);
> +       if (rc)
> +               goto query_hwrm_ver_fail;
>
>         rc =3D bng_re_alloc_fw_channel(&rdev->bng_res, &rdev->rcfw);
>         if (rc) {
> @@ -392,6 +396,7 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
>  nq_alloc_fail:
>         bng_re_free_rcfw_channel(&rdev->rcfw);
>  alloc_fw_chl_fail:
> +query_hwrm_ver_fail:
>         bng_re_destroy_chip_ctx(rdev);
>  msix_ctx_fail:
>         bnge_unregister_dev(rdev->aux_dev);
> --
> 2.52.0
>

--000000000000b0720f064c2f1416
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
QSAyMDIzAgxoOshI0IGR+aGCCXkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEILKN
C4NfFhG9YFj1dNsMIdWhzni9FGLIFu+cPqPO2i0SMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDMwNDA5MDIzNFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAEFcOcTw15BkptR46d+/F6E6GfEs6D8HqP6bmo0Q
aq4tkpQWjyXDllzw3ZgGVvsMv0ZO2I+pxUxxuXroxMJUfSpxYLHEaqrjhzaAbVSMey4RvodGxs8W
63XZdZW7COIW6GsT76bgMRpb1mDfp9RBnCuiVxri8WteWDLcdtK+zWdzmlLBuDUIj0vYapCZ5HKw
AZN3YYOCatk5G2A+b+dTQkygyGzZtOtAM3cItO5MN5g8Ur35gU1MA3kkkqcJs8fDZo/yp288CQL2
OJB6jQEyA84ywL8gZ2srembdPyVqAB9wSSKxtZToaKbcjvLEhAcxCs/rjdVMrGoqiueQbSkGQXs=
--000000000000b0720f064c2f1416--

