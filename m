Return-Path: <linux-rdma+bounces-20129-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFYmLO9n/GnPPgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20129-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 12:22:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B9A4E6B5A
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 12:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FDF43006B79
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 10:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4833D9DA4;
	Thu,  7 May 2026 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TMDOCy+U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f225.google.com (mail-oi1-f225.google.com [209.85.167.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E843C9ED9
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778149355; cv=none; b=JGeliY0yhefEBi2zwGCJbyQftk/znC5ahcLiH+8K8+8Gy2axHGCa8rnZkhTVEcYsSK3bF7cUtw9fHYmy17wAp1P2zAIDMJoV2yakrlZ17LjFDAzDSivPMhub6mEbEMyn4vsMezeJsyRXiki4eSGKUSskJeljYY9Cv6U8vAGk2aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778149355; c=relaxed/simple;
	bh=j0rxQnEWQq5YsP4EY2lv0GYSxH2l1nI2vjUHk/ACXbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n673nZouTJi3+KOke8gVPJboilJB8THicPvLsdj1azpJt1BqLlbMeVURXkFbQHEsmHB5YnB8GSKOL+MnGb2LcvDe3yjAsUJYW1RSOF9YINd9N08LdNy/guOb7IB9ViD0vWqpLr/sBWxZ2VJfUDBfj4vx8ywniNStGAOH1ANw7PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TMDOCy+U; arc=none smtp.client-ip=209.85.167.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f225.google.com with SMTP id 5614622812f47-464bc03efd8so316516b6e.2
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 03:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778149353; x=1778754153;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvfg51YkOVTwYAmFN0ts3oNrnlV7HJWucMCr22Xer48=;
        b=lrDtGnhqRH2/iEacmSMJ9yeZIiKu4I+YI1piaX1T/lLILveBo+kzvdts+d95XNnrDj
         0D/NPQdQLtksu2rOwkL4umCXcWNsh5fd5ASuFUGc6S++mcQU0NGATaHydpvKTjVYD2w1
         dkGijVRbpEmEAI/S3JfcUvxViS5K0KYYAKqZdsB5ieah+ezgkJONpob3aQ4/dwdz9Uah
         b53QQosIVKIVEz2rr45ozJC3iaHhxdiDLqh5IZ6frNLBRUTvV9eS9ZfXmWUjSssOELx/
         KH9bnpRXMmeFVx73gx3Og3WAHxSzTbZwn2U1CMQrlWmiKkE5+my87J/ZBOOWbZNZUUAU
         X++w==
X-Forwarded-Encrypted: i=1; AFNElJ/VuP3LSZuh4c8NppA/PcIow1wnRrsSQQjwbSs3v3H7d2exzjx9XraZGQo6x32iTEavnN1TOYrqZoEo@vger.kernel.org
X-Gm-Message-State: AOJu0YwmpWLRkjfqE/hhETpL1SqaQ7xvmNIhqoAI7PRMT/ktcEMKSjgo
	KcwnfDqqG3PRKc+xPhYKyO0RqHbtIvOgDIFAcNVpvOyn10KXzQtnX23PHSXjJ3XnFtX8JLYpU5S
	nLADlebGiOhBFEvGtf7oLzG/RRtBPC+HNCpuJDiDq6pN9Q3g8gfUvmRRlG8qcTIqYn5ePgZWczH
	amYisTuCWt+U1/A9Goi2XsqUa7nRz3Rjxof8xgbhZ9hDssLWfa1SdYS/9iphFwieJfa0foBr8XD
	wIa97ndlTJI+CI=
X-Gm-Gg: AeBDietl9Z1BQLtT76Q/v6JSbBFAAAoHd4+839LZwuRszOAOjkkSgmFnciLaZagUWVz
	xMCh+VgbfqVcop7XBcRN7OudnfhP4UAHx80hEccq/qOX7NC+pyd3/GUgnONUhBos/e90b2RzGgn
	bFwCOnokvbID63xLO1iEbsH7ZEQY0kFb7902hBQttX9q4y7G89VO3mvVRb18wzW7esshceXxPo2
	oT3WoJ6aiGca2h+KEKubJ1yZPQzoqRWp11QPO1X12sq8spHxJAoQOuXirvrIFrGJ2EiUL2trlj2
	jMWC8+h1guRcx+v42Bdietv/aZxOAICWbp6qbv0GKFcY1BJs4fad9TmmX48e07CxdAK7qmNwOV+
	8n9k+T8n2R5yIe1x1/RSdlRA4tjnxCHYKkEvicjtpGpgYoTylW2uQwXvZVAAi1Jcu4gwbfdoexA
	YHaZlDJoQuIAmAHlGp4/e/lnsS
X-Received: by 2002:a05:6870:d109:b0:41c:25b1:930f with SMTP id 586e51a60fabf-434f65f3d0amr4978858fac.19.1778149353075;
        Thu, 07 May 2026 03:22:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-43454d1f0easm1678304fac.11.2026.05.07.03.22.32
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2026 03:22:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5147078691fso15576841cf.3
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 03:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778149352; x=1778754152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nvfg51YkOVTwYAmFN0ts3oNrnlV7HJWucMCr22Xer48=;
        b=TMDOCy+UjA+KBxWLXzZ8PAm8xHz37Dj6f8yRB2D6RnYPf2pSnscM/5EGtwVbuD3T9u
         NoOdi23jAHyeN5lOsbK2t3/45bIHJEWJSQCu3ZRiXw/kEkmCp0yCBAqRVMkZWJDCWlf9
         nzOJQHMQvyI2DO6/uJ3SduXu+0ENOrW6Uq4LM=
X-Forwarded-Encrypted: i=1; AFNElJ9sw98y+N+mUxeHQRwTGEEtBct5MCdC5e9aDFKYfr1/HdoDf2RSMXMxsuQWkvlphIQUgHuq6zcqplrP@vger.kernel.org
X-Received: by 2002:a05:622a:1181:b0:4f0:131f:66fe with SMTP id d75a77b69052e-514621f49f3mr99414601cf.59.1778149351928;
        Thu, 07 May 2026 03:22:31 -0700 (PDT)
X-Received: by 2002:a05:622a:1181:b0:4f0:131f:66fe with SMTP id
 d75a77b69052e-514621f49f3mr99414271cf.59.1778149351483; Thu, 07 May 2026
 03:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505085709.1755534-1-roheetchavan@gmail.com>
In-Reply-To: <20260505085709.1755534-1-roheetchavan@gmail.com>
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Thu, 7 May 2026 15:52:16 +0530
X-Gm-Features: AVHnY4LnXkRDp2XHQqVyWShLXJsOgDEJTJVyZjGEVQzQtR_84cKsX0O4xLhCH0o
Message-ID: <CAMet4B5nyrCLcV4s2PoL_LmvYsK7jaTxD=m_0wFMOFxt9B0hxw@mail.gmail.com>
Subject: Re: [PATCH] RDMA/bng_re: Remove unused variable rc
To: Rohit Chavan <roheetchavan@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000803b1b065137a8f9"
X-Rspamd-Queue-Id: 12B9A4E6B5A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20129-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[siva.kallam@broadcom.com,linux-rdma@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

--000000000000803b1b065137a8f9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 2:27=E2=80=AFPM Rohit Chavan <roheetchavan@gmail.com=
> wrote:
>
> The variable 'rc' is initialized to 0 and returned at the end of
> bng_re_process_qp_event(), but it is never modified in between.
>
> Simplify the function by removing the redundant variable and returning 0
> directly. This cleans up the code and avoids potential compiler warnings
> about unused variables.
>
> Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
Reviewed-by: Siva Reddy Kallam <siva.kallam@broadcom.com>

> ---
>  drivers/infiniband/hw/bng_re/bng_fw.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/hw/bng_re/bng_fw.c b/drivers/infiniband/h=
w/bng_re/bng_fw.c
> index 17d7cc3aa11d..50156c300b33 100644
> --- a/drivers/infiniband/hw/bng_re/bng_fw.c
> +++ b/drivers/infiniband/hw/bng_re/bng_fw.c
> @@ -123,7 +123,6 @@ static int bng_re_process_qp_event(struct bng_re_rcfw=
 *rcfw,
>         bool is_waiter_alive;
>         struct pci_dev *pdev;
>         u32 wait_cmds =3D 0;
> -       int rc =3D 0;
>
>         pdev =3D rcfw->pdev;
>         switch (qp_event->event) {
> @@ -152,7 +151,7 @@ static int bng_re_process_qp_event(struct bng_re_rcfw=
 *rcfw,
>                                  "rcfw timedout: cookie =3D %#x, free_slo=
ts =3D %d",
>                                  cookie, crsqe->free_slots);
>                         spin_unlock(&hwq->lock);
> -                       return rc;
> +                       return 0;
>                 }
>
>                 if (crsqe->is_waiter_alive) {
> @@ -182,7 +181,7 @@ static int bng_re_process_qp_event(struct bng_re_rcfw=
 *rcfw,
>                 spin_unlock(&hwq->lock);
>         }
>         *num_wait +=3D wait_cmds;
> -       return rc;
> +       return 0;
>  }
>
>  /* function events */
> --
> 2.34.1
>

--000000000000803b1b065137a8f9
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
QSAyMDIzAgxoOshI0IGR+aGCCXkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIGlG
5o23njvhckJYu8N60sTs2/ZeuMoBs7zy+Ewwe13TMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDUwNzEwMjIzMlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAEX1onElBaWeOt1B9w30qyS4i0EHCKWDc0dollgI
Qxl/K/DfqqMMiqDT3ZciXpn649sgLvqWSVZC+J76N+UjncEKYqpFv7NhbeoX5GnB+RMcC4La0TQH
n+YLVYWEa9j3cHYdZGnnHnT3Oj0N8RwdWt3Ur2iwuonsOLKXLvxzseT9FqhPqN1iv0mFlz/XkFAH
zQb1l4csejua8rFQHFYFHBbAv3vV/InXfmyFbIyvB1U400DQYYj7DE2KIMGF+8zOElZODZUCGh95
3IEWxtdF/wilFy+7xxL/rgc4ndZV54qOaQk9QMxF2TIaJjvJLTBIF7rvbrs0vABrYOp7D9xdC8o=
--000000000000803b1b065137a8f9--

