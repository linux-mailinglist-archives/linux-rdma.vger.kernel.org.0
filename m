Return-Path: <linux-rdma+bounces-5607-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 788039B5DE0
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 09:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AFBA281F16
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 08:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BEE1DFE3F;
	Wed, 30 Oct 2024 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="el/VLtEK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4611991CF
	for <linux-rdma@vger.kernel.org>; Wed, 30 Oct 2024 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730276963; cv=none; b=BwjklXP9k2UyHiCN4tGROdm6Fm9l3POKvnLo5FntU6cSxCCWvYINEM2NbjzAZ3f4JgMYy4TyU6Iix5LJh71r6NkqcyS1AobipKFU1UQunFCej85uyYFEpSYD8/vW4Slbek23wMO4GkAVzsaucnB4Kb6DBcq9beXlgrIzTz2Uo/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730276963; c=relaxed/simple;
	bh=G+pZDGtPjv7iB2gQQRR6axXt8dSS8s9clfcmIdaYmyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIVLhsbQxmApdSU0nh5F0yVZySiJYeKCZGq0mU0rXrkXaI7WiIpACCNpZozhEgNLFJC+w0ZhtRpQFke3YCRwjawZQPnAZv6FrsJr2lmxEQLOOsYl/tbThOiDrqnQNiKm2jJj65y95W8o0BSbY8yUX7GvMppgyOgAyZYJfDcPQdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=el/VLtEK; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e2e444e355fso548192276.1
        for <linux-rdma@vger.kernel.org>; Wed, 30 Oct 2024 01:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730276960; x=1730881760; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KHcxfWijOrTr7IuaqqUfGWz/WaNu5DRljr7kIOAHYf4=;
        b=el/VLtEKsY8YYJu0uOLowaP4H4JSvw4h1AcC/SbIIq/Hr4/NIs3KQr8Z2Mj11vE12l
         Q3I/aj2Lug3IH1L3HapzgM2CTff/8et7Qu5MAvmfEX7NZxgV+3byAMzbCLdpHdtc5tpF
         Fe9y6Uzyx/EHDwzHyGftj/nvaflbbI9Wsp4WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730276960; x=1730881760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHcxfWijOrTr7IuaqqUfGWz/WaNu5DRljr7kIOAHYf4=;
        b=UrUqNWyVcExh8ySyhmZgJSRPBlDY2KtoGPBIx761360BotA3h+aOGEhGt6SDH40h91
         /34ZFKA6r2wjURED5Nivk0VVAMmRflBIe+4KtndvpLplwb9HFU2wiDCU87o2DSNB2LQw
         p7ku2doh2HzjM2qtkvDzGOSygrwZjKN2bUbbDV0JEvZcUmX7zBeQDBQPySgbUPY65ude
         +xMYBgqp3zzm6bffmWIdZvDa4GOLFM8Q5u+jq96Bi2vX+Ex5uE6Ed6C21OyekSQGuHju
         WtKRZzQb+LTC6EPQgsnzT35TGPFxQQhlgaDP0hVWfdACe8ckCl3era02zxj0c3mbZgTO
         NkTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRaKRWjKCn9z7YBvrW5e0rAkwARA1mbM/V9NXACCe6VuvqLTA2Xo8P48T/wYI6CbxFtcUrd6S5e963@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9fR1FvzFxM26Q6ROZp9LgM5VGhwCnkvw94UNpjHdwr0w9IOp/
	q4wQHTmKNoZCu/QkwhvVUqBTZ5MGr07lnLfMHJJYTh6vSYI7yZCsMtbPC3jwUQ43NS3Tjb95yLR
	bfRe1J0DWeiB9MnE2yjaGlaGjx90uUzrF42Tj
X-Google-Smtp-Source: AGHT+IEsSPU+uGKIp7Jov+F0QhAS233vV4uUHjkDMySdYp6zfSH2o/fjxJzC03kgmWYDqy0EI/SgzXGxOHZpAD1J+vw=
X-Received: by 2002:a05:6902:1747:b0:e2e:447b:7048 with SMTP id
 3f1490d57ef6-e30c17ef10cmr4261143276.12.1730276959693; Wed, 30 Oct 2024
 01:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1729591916-29134-1-git-send-email-selvin.xavier@broadcom.com>
 <1729591916-29134-2-git-send-email-selvin.xavier@broadcom.com> <20241029140319.GN1615717@unreal>
In-Reply-To: <20241029140319.GN1615717@unreal>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Wed, 30 Oct 2024 13:59:06 +0530
Message-ID: <CA+sbYW1_DSX3g1-Q7YyOYGj2R7nNJVSCeY_GezBnHEQCRvn-Vg@mail.gmail.com>
Subject: Re: [PATCH for-next 1/4] RDMA/bnxt_re: Support driver specific data
 collection using rdma tool
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, kashyap.desai@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000090ca170625ad7f0e"

--00000000000090ca170625ad7f0e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 7:33=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Tue, Oct 22, 2024 at 03:11:53AM -0700, Selvin Xavier wrote:
> > From: Kashyap Desai <kashyap.desai@broadcom.com>
> >
> > Allow users to dump driver specific resource details when
> > queried through rdma tool. This supports the driver data
> > for QP, CQ, MR and SRQ.
> >
> > Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/main.c | 148 +++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 148 insertions(+)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/=
hw/bnxt_re/main.c
> > index 6715c96..5bed9af 100644
> > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > @@ -882,6 +882,146 @@ static const struct attribute_group bnxt_re_dev_a=
ttr_group =3D {
> >       .attrs =3D bnxt_re_attributes,
> >  };
> >
> > +static int bnxt_re_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr=
 *ib_mr)
> > +{
> > +     struct bnxt_qplib_hwq *mr_hwq;
> > +     struct nlattr *table_attr;
> > +     struct bnxt_re_mr *mr;
> > +
> > +     table_attr =3D nla_nest_start(msg, RDMA_NLDEV_ATTR_DRIVER);
> > +     if (!table_attr)
> > +             return -EMSGSIZE;
> > +
> > +     mr =3D container_of(ib_mr, struct bnxt_re_mr, ib_mr);
> > +     mr_hwq =3D &mr->qplib_mr.hwq;
> > +
> > +     if (rdma_nl_put_driver_string(msg, "owner",
> > +                                   mr_hwq->is_user ?  "user" : "kernel=
"))
>
> Two comments:
> 1. There is already a helper function to decide if owner is user or kerne=
l - rdma_is_kernel_res().
> 2. This print duplicates existing information. The difference between
> user and kernel can be easily seen by looking on the PID output.
Got it. I will remove this in the follow up patch.
>
> > +             goto err;
> > +     if (rdma_nl_put_driver_u32(msg, "page_size",
> > +                                mr_hwq->qe_ppg * mr_hwq->element_size)=
)
> > +             goto err;
> > +     if (rdma_nl_put_driver_u32(msg, "max_elements", mr_hwq->max_eleme=
nts))
> > +             goto err;
> > +     if (rdma_nl_put_driver_u32(msg, "element_size", mr_hwq->element_s=
ize))
> > +             goto err;
> > +     if (rdma_nl_put_driver_u64_hex(msg, "hwq", (unsigned long)mr_hwq)=
)
> > +             goto err;
> > +     if (rdma_nl_put_driver_u64_hex(msg, "va", mr->qplib_mr.va))
> > +             goto err;
>
> <...>
>
> > +static int bnxt_re_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp=
 *ib_qp)
> > +{
> > +     struct bnxt_qplib_qp *qplib_qp;
> > +     struct nlattr *table_attr;
> > +     struct bnxt_re_qp *qp;
> > +
> > +     table_attr =3D nla_nest_start(msg, RDMA_NLDEV_ATTR_DRIVER);
> > +     if (!table_attr)
> > +             return -EMSGSIZE;
> > +
> > +     qp =3D container_of(ib_qp, struct bnxt_re_qp, ib_qp);
> > +     qplib_qp =3D &qp->qplib_qp;
> > +
> > +     if (rdma_nl_put_driver_string(msg, "owner",
> > +                                   ib_qp->uobject ?  "user" : "kernel"=
))
> > +             goto err;
> > +
> > +     if (rdma_nl_put_driver_u32(msg, "sq_max_wqe", qplib_qp->sq.max_wq=
e))
> > +             goto err;
> > +     if (rdma_nl_put_driver_u32(msg, "sq_max_sge", qplib_qp->sq.max_sg=
e))
>
> Doesn't this information already exist in other places? devinfo?
device level max_sge that can be retrieved from devinfo.
This is a per QP value we are displaying here . It is important for
the latest GenP7 adapters as we support variable size
 Work Queue entries (and variable size SGEs) now.
This information is available in the query_qp response. But it can be
handy to dump this while debugging.

>
> Thanks

--00000000000090ca170625ad7f0e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
FYMZp2DojLAq9f4Oi2OBetbnWxo0WGycXpmq/jC4PUx2u9mazQ79i80VLagGRshWniESXuf+SYG8
+zBimjld9ZZnwm7itHAZdtme4YYFxx+EHa4PUxPV8t+hPHhsiIjirPa1pVXPbQIDAQABo4IB2zCC
AdcwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU3TaH
dsgUhTW3LwObmZ20fj+8Xj8wDQYJKoZIhvcNAQELBQADggEBAAbt6Sptp6ZlTnhM2FDhkVXks68/
iqvfL/e8wSPVdBxOuiP+8EXGLV3E72KfTTJXMbkcmFpK2K11poBDQJhz0xyOGTESjXNnN6Eqq+iX
hQtF8xG2lzPq8MijKI4qXk5Vy5DYfwsVfcF0qJw5AhC32nU9uuIPJq8/mQbZfqmoanV/yadootGr
j1Ze9ndr+YDXPpCymOsynmmw0ErHZGGW1OmMpAEt0A+613glWCURLDlP8HONi1wnINV6aDiEf0ad
9NMGxDsp+YWiRXD3txfo2OMQbpIxM90QfhKKacX8t1J1oAAWxDrLVTJBXBNvz5tr+D1sYwuye93r
hImmkM1unboxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFcSRsLpqG7n
bGSM/tLii2Rcc2Eu4nZiN3ig1iNbgVppMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MTAzMDA4MjkyMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB/+REndwNW+H46esVuTVHB45JLm+qN
QiVp3QPZ73LcOt77NCcqUT2L9W4L2+jqop+DzbBb3BAfNSMV9K/S7Guo25H5YQ+FgSHoMPxUnK1s
g0T/MnPft0Zf3O7bX3U65ud7kugCsIpiP7hK7muRalo5QEMgRjgIKCm2a5orz/7cokNS/qHqprWM
avhwVM9FL/JQan/9wNzhmLUOwbbZ409QnKAQlVCU/T96Da4fe4qZoEuW42nXaOT5yFk5z/379wWJ
xWx+fUmvxlLyqSr89wAwnkZHPD5Qa0hUluDa7ooilZQ5OOXRTHqnO5GooXxBHyT1lTOmwi3rbBnF
KRC2n5om
--00000000000090ca170625ad7f0e--

