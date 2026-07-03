Return-Path: <linux-rdma+bounces-22741-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CZfRBWZ9R2qcZQAAu9opvQ
	(envelope-from <linux-rdma+bounces-22741-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Jul 2026 11:14:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B19700833
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Jul 2026 11:14:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b="h/+XZDOG";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22741-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22741-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BA67307D23D
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jul 2026 09:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D2739E17E;
	Fri,  3 Jul 2026 09:05:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4053838D3F8
	for <linux-rdma@vger.kernel.org>; Fri,  3 Jul 2026 09:05:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783069537; cv=none; b=O97hoNTc/Qj67Mq28cZf3kvcJNTGQK+aSZRMaf+z/MhcUE1VL74UmN048ypZWe6PzVKCdEY/A0MYX/E04iYbJVeq6Dugr+Vc//1N/+aA5XmopggH2CKXnfUJ9JefVtO+O0v2h1glI8Yod5S82e3vI62XhuSsCsC27PyvfPu2hl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783069537; c=relaxed/simple;
	bh=0c0JQiq1YC9cGJ81uPjTliL3jTs8f2arOhuUn0v44dE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQ7Im7wbWDYq9fwSpTm2Xw+QTOJm3lnzLvxpTL+50Jg+F0vqzuVvPUql0fIc1qegnS9CPUQasQGNIBZdrFiqvQ8Rl/4dsxZeavjir8wgPtR2JbbmFblP++ZC53Q/Gl98iPO7JkCKZRqQEOBLI2b1wH8g34mi6mq4y9M+aQDGIAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=h/+XZDOG; arc=none smtp.client-ip=74.125.224.97
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-664d4478a64so436352d50.3
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jul 2026 02:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783069535; x=1783674335;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAPKx7dt9mnb5EuVAgrhg7j8udB8qd2k085Bap0Hq9o=;
        b=Qi3hNB821IPcEogykIeYt+bW6VhlEJN9m2oMKcBqzV9RyBOX0xPCp0mr8PPv9vIOBW
         k+nfT9DagI7/nEHyqNyOylNrwCD9PI9EUjgC2c68Modn5eMtwwG7kH9D5dBYLyGEGhyV
         ZvC+f+uBT9Vs2mP89AGlcx2D7+KhYHBM6VrmN2tPIsmmbSl/YRcJvFO6pmu2aotGFEjx
         8p5G9kMTWjweyo9NnNiuetczD5A2UfMwQVUtRfh/YMnr+yLjs1KojwT8AR2yjfDucZxS
         ht8/Mn2lnaUsL8VZfodUlcngEg/qQVc2sPwpGEHqP5umY/uwtJkbGAYEHk25QSwy9uwK
         Q04w==
X-Forwarded-Encrypted: i=1; AHgh+RrlxAAPyxeLggskTQfofM8Bg3JMuecC3W+/hNf7VMKYsBZWg5vUbW8sbdXbxFtKkINoRpNzFHTjb34H@vger.kernel.org
X-Gm-Message-State: AOJu0YwRIQZPwl3csIw9vR3C8AYdTO2drci577GjgnGRNU/GzK7xhoPs
	CICea55Zq61+SYBRyMtLCih+WkDhCoOwJzETAJ87+XKSqnpAmL9loMvxtgzcGTnaqC+uApxy1B2
	30NQSIsI1MpNGBCzEnueynPT/zXawOwFcwxYVYXCQidAGqAqalXxeZYB4hkqJR9XXZ5WXcWfKkD
	AtQ8Mgt59uDHogo4Mr0i8YEyl1awZTqBj735nPrs9O1cQYj9yvZ9hN+TV5OpjVA8slMw+uqXpEz
	Lm820gKXeKj5Ng=
X-Gm-Gg: AfdE7clvA7DKnEpCki/UsnujTBtYtG0Q+jpo2C/3YqQHkHJy23qrkkJE/rbNOpvi50U
	X+GbG7gWoSTvga8NMergnQ06yZVzTNIUe30n5BUbZ9VHNwiIGDx2WQ4R+P5QBn4lAyOVfie7y1I
	01aGDoyurz/vuGWQe9LP2bLCKKgVXgRay7DP7MKdNzpOheRZcsBipLjir3FezfQW/7709/SV33C
	bxBMArAiFMVhFWADsvaJQCtgHMIXU3YN61KCO4dUVUL0qGzXWuZ8SlY13ugI3mB1jYosUnpRNKm
	NBjGm3paGElwnFy7IJybEBB4vzYx4gGgdGGmRotMHDC2WVbAD+UGaXfbmfdNTdG9c4S36yhvIi7
	CuawcPnE7A73EwvuQsSH2xwCMbM8hhZwx0IANQgRVI68xP2iElH0yFd7sOSl/c+sdx12tlRPPG2
	0i3s4kzfqZgoC3EOpBtrXbBewO5ccVbtrgW+uLoNcP/Iwh
X-Received: by 2002:a05:690e:b88:b0:664:d71f:4e90 with SMTP id 956f58d0204a3-66521670d1emr9023480d50.0.1783069534961;
        Fri, 03 Jul 2026 02:05:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-666401820aesm23179d50.6.2026.07.03.02.05.34
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jul 2026 02:05:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c8620ee0971so576116a12.0
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jul 2026 02:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783069533; x=1783674333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HAPKx7dt9mnb5EuVAgrhg7j8udB8qd2k085Bap0Hq9o=;
        b=h/+XZDOG9h9FSpL1HNHtZscZUNa20dJ+0LbNgKjKAZclBICE4UHaxTiOClL4sT7+t3
         OJwPe+dyWa0y1WAa1URQgx8z/x224/ffQIGyWXDbueGEuGdX5mGP7GXhLbw4XAjurT/d
         BK4WlLX9yQ0N7ed08jpDKm5xSC4XbFuBYtbl8=
X-Forwarded-Encrypted: i=1; AFNElJ9SG/89xEBSbp5GKFiPEo93Vl5E/vCZkUXH1tG99jNGHCd5cH2xkQ5G6zwu/UyBzEKRGHT3EF/mlg47@vger.kernel.org
X-Received: by 2002:a05:6a21:2291:b0:398:bbd6:80b9 with SMTP id adf61e73a8af0-3bfed23041dmr10887440637.23.1783069533602;
        Fri, 03 Jul 2026 02:05:33 -0700 (PDT)
X-Received: by 2002:a05:6a21:2291:b0:398:bbd6:80b9 with SMTP id
 adf61e73a8af0-3bfed23041dmr10887404637.23.1783069533121; Fri, 03 Jul 2026
 02:05:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625003614.27515-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260625003614.27515-1-pengpeng@iscas.ac.cn>
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Fri, 3 Jul 2026 14:35:19 +0530
X-Gm-Features: AVVi8CdckNZm0szI_DOMuvVU1V47i3PbeAM5bHyx0Daiy4VEXRRjJTnLdy4Zh1w
Message-ID: <CAMet4B4f9S6HZgqU3JnaMip15004xrSOtXh7NmYidjmXKkskKQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA/bng_re: return a timeout when firmware responses stall
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002e2ad90655b13ad2"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-11.26 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22741-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[siva.kallam@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[siva.kallam@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:from_mime,broadcom.com:email,broadcom.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73B19700833

--0000000000002e2ad90655b13ad2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 6:06=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn>=
 wrote:
>
> __wait_for_resp() documents that it returns a non-zero error when a
> firmware command does not complete, and bng_re_rcfw_send_message() alread=
y
> marks the firmware as stalled when the helper returns -ENODEV.
>
> However, the helper ignores wait_event_timeout() expiry.  If the response
> slot remains in use after the timeout and after the polled CREQ service
> attempt, the loop starts another full timeout period and can repeat
> forever.
>
> Return -ENODEV after a timed out wait that still has no response.  The
> existing caller then marks FIRMWARE_STALL_DETECTED and returns
> -ETIMEDOUT to the command issuer.
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Reviewed-by: Siva Reddy Kallam <siva.kallam@broadcom.com>

> ---
>  drivers/infiniband/hw/bng_re/bng_fw.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/hw/bng_re/bng_fw.c b/drivers/infiniband/h=
w/bng_re/bng_fw.c
> index 50156c300..ab6a2d2e9 100644
> --- a/drivers/infiniband/hw/bng_re/bng_fw.c
> +++ b/drivers/infiniband/hw/bng_re/bng_fw.c
> @@ -401,14 +401,15 @@ static int __wait_for_resp(struct bng_re_rcfw *rcfw=
, u16 cookie)
>  {
>         struct bng_re_cmdq_ctx *cmdq;
>         struct bng_re_crsqe *crsqe;
> +       unsigned long time_left;
>
>         cmdq =3D &rcfw->cmdq;
>         crsqe =3D &rcfw->crsqe_tbl[cookie];
>
>         do {
> -               wait_event_timeout(cmdq->waitq,
> -                                  !crsqe->is_in_used,
> -                                  secs_to_jiffies(rcfw->max_timeout));
> +               time_left =3D wait_event_timeout(cmdq->waitq,
> +                                              !crsqe->is_in_used,
> +                                              secs_to_jiffies(rcfw->max_=
timeout));
>
>                 if (!crsqe->is_in_used)
>                         return 0;
> @@ -417,6 +418,9 @@ static int __wait_for_resp(struct bng_re_rcfw *rcfw, =
u16 cookie)
>
>                 if (!crsqe->is_in_used)
>                         return 0;
> +
> +               if (!time_left)
> +                       return -ENODEV;
>         } while (true);
>  };
>
> --
> 2.50.1 (Apple Git-155)
>

--0000000000002e2ad90655b13ad2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVWwYJKoZIhvcNAQcCoIIVTDCCFUgCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLIMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGkTCCBHmg
AwIBAgIMaDrISNCBkfmhggl5MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNDQ1NFoXDTI3MDYyMTEzNDQ1NFowgdoxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEPMA0GA1UEBBMGS2FsbGFtMRMwEQYDVQQqEwpTaXZhIFJlZGR5MRYwFAYDVQQKEw1CUk9B
RENPTSBJTkMuMSEwHwYDVQQDDBhzaXZhLmthbGxhbUBicm9hZGNvbS5jb20xJzAlBgkqhkiG9w0B
CQEWGHNpdmEua2FsbGFtQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBANW6xYdzQHMOlXaC3uNwVMTzlpl+DKeCRXUyBs7g1OpCUSj02n1WEwCoNJXQrmoVYTD6lTHL
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
QSAyMDIzAgxoOshI0IGR+aGCCXkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIP1z
lEclRO2n848fQWPR38yM8P9nF6CXrmbRY50nYkrCMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDcwMzA5MDUzM1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBADhnQs0FfeZ0Zy7V8/1PmCrs8BQYF7DFEwE5qvvH
NkbyGa6vZQ+xzqJcVsqKRxLsc47yMb4wwL9w1xWeDtNIJQvbwZNOqsZuOxqU7i04+q6/AEUIx+QW
ZPkh9uirCGCfXcH+BFAHKK+TNK05HXhdBbg/jmOBht/2TwMDhqIYu9l3Os/E2qqiGffkMkkyR71i
YF3JvbyBMq0H5dsZSk9zqu3JO8R2dU4/VhFbO9aEspNU7RxZYggXlQd5FcBNlHNr43+zadZE1wjC
7JM+xgvuuSwp9kFng6Rind9BmQZacrUk0k2kGFEjyK4kJVgJCdy03H0WQFkRi/0V8B4l/CvW8Pc=
--0000000000002e2ad90655b13ad2--

