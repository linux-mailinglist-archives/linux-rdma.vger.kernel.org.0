Return-Path: <linux-rdma+bounces-18510-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLs5J73hwGnAOAQAu9opvQ
	(envelope-from <linux-rdma+bounces-18510-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 07:46:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFF42ED270
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 07:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9139F3012EAE
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 06:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F40D35BDC7;
	Mon, 23 Mar 2026 06:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dEaXkNh2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f225.google.com (mail-dy1-f225.google.com [74.125.82.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23E435B63E
	for <linux-rdma@vger.kernel.org>; Mon, 23 Mar 2026 06:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774248375; cv=pass; b=mM+44V0/1J9g7V78/NlM/eSxmfzcf470h4p93oNcQ4jQ+9Io5ifCCMMII9OC+lTpzwTvrJ6gJt4sWKuNPktOat/OXhJXJh04gdlihCyTMeS/mXF4i8WMyWQ+QkSjqoaYoH9mivpC69IfJ1hMQVnRU5ztlbyEvAamoSv4Jjlwg2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774248375; c=relaxed/simple;
	bh=Hx7CkDowlYEr1uO8YZsfboi9X33Y9/x6VlqesMkuVY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkUDvIYwHcAlUzyuXnehmJFVFefa3z5mAGsJrg7/M+rEsbTsilv29TTzSMmPHV8PYs5CIYMQFck03xOzojQXcLm5Mr85EIDB/7MaH8JEvQPU6gsxNwT1avtFy7XCL0yLE6dsVUny4gb7aQ72TxrDtWZk4HHirdAiGHLPcFynxtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dEaXkNh2; arc=pass smtp.client-ip=74.125.82.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f225.google.com with SMTP id 5a478bee46e88-2c10a2e2cd1so1778736eec.0
        for <linux-rdma@vger.kernel.org>; Sun, 22 Mar 2026 23:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774248373; x=1774853173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mJZb8EihqVQOT49DDLjQ0dZ6//dj5L8fPtsWq/Ikag=;
        b=GBHcLQliokNe/qKAY9A+eXVWucJmcENCgF9fj+rOEMNC5kDlYrGNRoNFlOd3JxtFyI
         p7fF7i2HuFbOkBa7f3Rz7ZbMfUiVEHfV8F06zfJIgsmsDACVt60YeQTNhhpdTWadShbY
         ojOEhLoiGXZS+dz70WJqfNYO/e1EtKkRyeWpG6ZlHtIag2TQRLNFWWGKCnoa87b6cggo
         Urp8833DL/ZzjOPIHeVh4W4oTg4lXQjNJnVhhrI/qf3Op/WVxa68Ak2bDoNuFFBkzyZv
         XjHIN4k0KSVe0bJPrtQGreiEUYuuqVypWaXNRIcMrXjUuBl5lJNQ/22JDjjnAEeMMKU6
         3lIQ==
X-Forwarded-Encrypted: i=2; AJvYcCX0kSECqTK4311ofZk4kMAHzuohyIuP0OiS+EnW763D/jCY7o0Ro50S5x6qM8ZicLUtA5T28lpNs+GY@vger.kernel.org
X-Gm-Message-State: AOJu0YzDh1XF4em4IqNnB/oFu3wPZetdq6jQCjN9QC3N6PwM91ah9LYw
	LUU/ktydVy5GINOtJM8HnuaNy4pmO7mcOdXt+23O6XlJkgNM5pBM/FdSAe+r0/6JNLXQ6zb8/XF
	+2mT1g9GqHyZ42f5cumN3kBTaKTBxAFytDBBl3X/ZMfcm+2EgKyRrYjeXEkROnLEjOPBTm89+K+
	+D5GNt1y7V4K4DzlpqnMrWngimb2SYqlDVVTd+uIiN4AMalRs4ka9hZKz2EnH4xDUMMY91jwYoM
	pM4ND/PcbTUynitVw==
X-Gm-Gg: ATEYQzy9QH0VUroA4+30yvY8AGM0i1xP5pCiEjos7pNtnzkA+bvC6N0amqdGPNTqxk+
	fOFnGqqXfIxFQZARaa7ICBfZNhkjmO/jzLaM50H4txGwpVGkZ16sKqIVGaF0MxuP3sXmCDCX5Nf
	IKbGKPDNjmMX8WWfM7KiCxeD54gOG6mpjzJPEbzXEH0vkvITsvjSEIV+N+MQvbk0m+ofpn9idHZ
	9OuWhARCJ6owdBdarKY6AIEOEQpamWZiYSCqIWvsO5IqsqFtgCytiYqh6ylT4ySZGjspTo7SsGJ
	qLVcCkVm+oR5UHlWi6vKtwGvSGaCSGcdhYH+2NhupKprNhfkIUIGwq5zFaDI2gP8i38QZo4pY3o
	Z8L0Tu2zD+D3PG0NyLaDd+ZHN2EOzYKgiSQp5/27tbt3r+pxpOwdsWg9nT5gP6y1HTCTZ2kUnV1
	2U2EhE3wdEOHOLHJsmJf6xhefjzdGFWz4HN0aOSVrQEQZckBM1patBVWeW8iWq
X-Received: by 2002:a05:7300:5b95:b0:2be:b00c:d083 with SMTP id 5a478bee46e88-2c1097ecb5bmr5690229eec.35.1774248372547;
        Sun, 22 Mar 2026 23:46:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2c10b293092sm772321eec.7.2026.03.22.23.46.12
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2026 23:46:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-463ee33f9b2so14664650b6e.3
        for <linux-rdma@vger.kernel.org>; Sun, 22 Mar 2026 23:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774248371; cv=none;
        d=google.com; s=arc-20240605;
        b=NuEYvVII2mdUTpcfPvTc+CAxbx6hb1g8REmf1ovij4MfYs5q3mphBWrUbrZ3isZ9OQ
         RlpsqAGM2kIK60ZCVebOq+IeEibDVxKn9adRIz3ZChCUcIi2SmZqkKJiPSYSddglw7Zy
         On5LIChw2YhUpmScwA9arfgA+ZvzAb5sm2Qbaj4HFK6jZtFMGfmNrVUpBVyI17S/sgbC
         LqHKJMBwPqW9cQ+8LapCVQu76duEImGTx48gP+QNaEyBX4N15K4XVn1JcARwi4XkqU+I
         hn4yqfal4DKe/LbNeP/FY/hoaj71Y7wP1gZ+NX0JlPftss86vPdxJyyKVInuPGhxyo5e
         zzZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4mJZb8EihqVQOT49DDLjQ0dZ6//dj5L8fPtsWq/Ikag=;
        fh=Hv/jvgcaKG9nLWu4Xwycnof2dpgeXtTvfz2A6sEe0Vo=;
        b=jm2ReL2IB5EZZ8edgHIGjOtlRR28flxLiFODTUwQS0zaWKX6a3ZjirVPOpJbZMu9nh
         euJObyocZo354Nu/K82jrSbsfnNTzB6zie4yTp09tpUvV3rQ70/23buU+/obp9eP+rZ/
         6lQ9gRgrS3foDgxdRRLvNInEuhg5J2usszf1aHHhmL95+RGvQn2aVlAbwTUKh0bI5wED
         k+O8ystg3lSxLRF4h0kiLclyvQoMnivAJB5t/3PXBMK3dHHA/+WV7J2Wq0DSEA+1KMi5
         0SYzCAzRr0bg4KD9rULPnMK7de4TjowpK+UuSNyasesqX7IMU1k2SpLrjU0LpQ3TDsjy
         5GtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774248371; x=1774853171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4mJZb8EihqVQOT49DDLjQ0dZ6//dj5L8fPtsWq/Ikag=;
        b=dEaXkNh27Y9EjgZ4uOiQg4SCIn+4d5ePnmWsVqTXshjQV64l1SgtgMIECmCdWYop2I
         LXYk3AMKHqatGoDcBCFna66Oev3wB5DLwdYHdm/YZKytFt7/bPdYkbUvy2pFyz/1N4f1
         VYAFTDwI0+i7VCDqxV9A8G2HU/iLyy2fj4BH8=
X-Forwarded-Encrypted: i=1; AJvYcCXKcK/ySBtbwdg3p87884fKbaN67kuIC2HiDpCyJUzzh1xj3Um6Zyn2QvSET9WTwbHITWzQqZQw3aL4@vger.kernel.org
X-Received: by 2002:a05:6808:2221:b0:466:fd51:6a65 with SMTP id 5614622812f47-467e5dd1240mr6376720b6e.23.1774248371116;
        Sun, 22 Mar 2026 23:46:11 -0700 (PDT)
X-Received: by 2002:a05:6808:2221:b0:466:fd51:6a65 with SMTP id
 5614622812f47-467e5dd1240mr6376712b6e.23.1774248370611; Sun, 22 Mar 2026
 23:46:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318-bnxt_re-cq-v1-0-381cb1b5e625@nvidia.com> <20260318-bnxt_re-cq-v1-3-381cb1b5e625@nvidia.com>
In-Reply-To: <20260318-bnxt_re-cq-v1-3-381cb1b5e625@nvidia.com>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Mon, 23 Mar 2026 12:15:58 +0530
X-Gm-Features: AQROBzD1pFnLHVE-bT2D-Eb_tT69nwpBSl26-IV5fgeUL0n8pYGrAHP_qdQPWZ4
Message-ID: <CA+sbYW1-jqFS6XwMNAa3wuS65PL2G0_yiXuirdvG04NQUue08Q@mail.gmail.com>
Subject: Re: [PATCH rdma-next 3/4] RDMA/bnxt_re: Replace kcalloc() with kzalloc_objs()
To: Leon Romanovsky <leon@kernel.org>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000eba64e064dab630f"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18510-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: 2EFF42ED270
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000eba64e064dab630f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 3:39=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> New code should use kzalloc_objs() instead of kcalloc(). Update the drive=
r
> accordingly.
>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniban=
d/hw/bnxt_re/ib_verbs.c
> index cb53dfdf69bab..1aee4fec137eb 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -3486,8 +3486,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const str=
uct ib_cq_init_attr *attr,
>         cq->qplib_cq.cq_handle =3D (u64)(unsigned long)(&cq->qplib_cq);
>
>         cq->max_cql =3D attr->cqe + 1;
> -       cq->cql =3D kcalloc(cq->max_cql, sizeof(struct bnxt_qplib_cqe),
> -                         GFP_KERNEL);
> +       cq->cql =3D kzalloc_objs(struct bnxt_qplib_cqe, cq->max_cql);
>         if (!cq->cql)
>                 return -ENOMEM;
>
> @@ -4413,7 +4412,7 @@ struct ib_mr *bnxt_re_alloc_mr(struct ib_pd *ib_pd,=
 enum ib_mr_type type,
>         mr->ib_mr.lkey =3D mr->qplib_mr.lkey;
>         mr->ib_mr.rkey =3D mr->ib_mr.lkey;
>
> -       mr->pages =3D kcalloc(max_num_sg, sizeof(u64), GFP_KERNEL);
> +       mr->pages =3D kzalloc_objs(u64, max_num_sg);
>         if (!mr->pages) {
>                 rc =3D -ENOMEM;
>                 goto fail;
>
> --
> 2.53.0
>

--000000000000eba64e064dab630f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVXQYJKoZIhvcNAQcCoIIVTjCCFUoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLKMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
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
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGkzCCBHug
AwIBAgIMPLvp1FinrmXIXZzjMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTI0NFoXDTI3MDYyMTEzNTI0NFowgdoxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEPMA0GA1UEBBMGWGF2aWVyMQ8wDQYDVQQqEwZTZWx2aW4xFjAUBgNVBAoTDUJST0FEQ09N
IElOQy4xIzAhBgNVBAMMGnNlbHZpbi54YXZpZXJAYnJvYWRjb20uY29tMSkwJwYJKoZIhvcNAQkB
FhpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBALyww4rAbY/uRJ/p/H3RRc0ipz0vxZgIXUdvhNOrG9uErj7X64vntdJTkcN1BOWQC1xpmt5e
zJH6Ivyz2skA36zh/px/UmF2ORX4Y0CY6GtU8/vxuN2j4rd2medlyifwALUm+KI3SsD782IwKLCf
8bNhYGiw4YxsbyX7dV7O4SNQc5U9ktrSKH3D4SuTnK/xdjca5PiNI2NTcBVmP7+u2bvVLdRqISop
9dpRkJ6xxhGJjxakljIxHdcZLXltxX4YM0Onf3agcjY3boIqnVlDjBwSZX674ZU+YVrcIlcRcqs/
W83e6PmIRFwpkKOhuLNKSpW5mZoEQdpnxGwE9U7qLGECAwEAAaOCAd4wggHaMA4GA1UdDwEB/wQE
AwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5Bggr
BgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUG
A1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUF
BwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDag
NKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJQYD
VR0RBB4wHIEac2VsdmluLnhhdmllckBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQw
HwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt26AjhRiwoJIwHQYDVR0OBBYEFJA9fV7cOoiN64ws5XPC
J5qtayo5MA0GCSqGSIb3DQEBCwUAA4ICAQBFCIF4AxAiXVz6gX5YfFEbIYtbGFifcfe+QGc5cfac
CSzIrQWUPXAYAef3G5WouD2AKwa2tPGJgK2L7n1r2W4NIvr93588EDVnGgfMfWaFsB8VlLsPlH8Y
fLfaTdN3OQPnFFp54yK9wv8AtTIiTQcailMw7QX5x5GE6HVZElxf0V0Ljc2NrUQLoYzHzAU+sysl
6JQzomxjIfuXiIiUfmnWQdhO95kQchRdOUAaguLTV+RRfPZ1p54dRmgGEpJtzjGLdsrLkZ2rCN5j
cOTTXyxJmvlgm9jfT0Uy5SOPHdq1jtZbQyXrNT4fQ07Odmq3xQCUTi+a59IiC+6V7nFJ8zyCSk+p
n/iGouvun/owYzTmFxB6sVLWZcaWz2Ufcm7b6nOYV+pwUS/n6+6oFRKmGLrl0CRCF0AOph5p81aV
kgKuS5oXBoDefJfjKHuu5lJVelBx3n++iMGMW9FWFmXErCHy2d+L42Raai5X2PL8jAmh+lpPRDX4
CT9jL6xWM5QkCBtxyVKuxGxxUY2wczmVcQ1nGh9mGghI04Scs4OtE8Qh9LMOe2PXzxcV6lpF+yay
B3fwJWxl7miwNFjWuu9M6Z+rcjm3JF5srcAu2fp/VzQD4AE5Kq7ywukMvlU4Y3X2t+D2eU1DH8pk
c8mM1CtQWfWUboaoLABVmYmYfihDvTURkzGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAX
BgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1F
IENBIDIwMjMCDDy76dRYp65lyF2c4zANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg
OZ7cGcWEi51zE0RaVsXxKmIFwKiK4T9b0eHbzMXnQUUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYwMzIzMDY0NjExWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAbgdaLu6/LqkyDBSfyrFh14wz7SGTpR75WO+S
RSKsr31ETJBuJsMaZfwLSSgnE8PfJbabB7BvtuLDmRZW6iWcKAn9V/U3QkUujNnsRWHPxs+0AI/H
m9eunr9ftwUAieP2R4ZpmfyhRyj3SwapBX2+ZRxEB2tzvr4nBZRSaLC5JnAtkVCV8f7ZwfTew74+
B5PgTpZxKh7zmGpz7GTafOMZnq0U/VBL7C+BV+uG99fj0qJD7k4+sy3ACM6meIxqC9e9xXTF7x8e
XmE3OachKrJ3ZDrTf4rIPVg3zcltqn5RAWnMwuVP2m27jvbFGXHgHfWuX/I1nvhBIIj1qq3Mugyv
uw==
--000000000000eba64e064dab630f--

