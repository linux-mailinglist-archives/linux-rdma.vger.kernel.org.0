Return-Path: <linux-rdma+bounces-5427-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4929A04FE
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 11:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3C61C23020
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 09:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3D82038A5;
	Wed, 16 Oct 2024 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z7O+c2Uw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12591CC8A6
	for <linux-rdma@vger.kernel.org>; Wed, 16 Oct 2024 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069453; cv=none; b=W//jI6sxlHVevynfSKEl4Ab59imHMaZlnMRorvesMsBlve0bml0oTagb4+GBXVdl9hskAbCi2+L5zjdDVQYsFOHU9yXzhtSpi2o46vFCs+PbHebCcyQK8eXSmYzuoz0w6sR2W4JKkV1VirSnaUPBU1InjiMPQdSHY+AVAAPZAGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069453; c=relaxed/simple;
	bh=51aaAle4tC0DDZO7qwRHz1lN+2Io9wJUCn+wBRZZC6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YogyEEheXSElFbH7Rt7KDHSkl25WzsDf1yZgtvQ0mUVsKllV+b6IiwT71dIiABGQQ8GsBKFcDxM1Pw5vM4EIYHcjmqBpBeuTXnkcOK8tU4nwoybJogsNEbNL7zhrryifyWPNqai0H3v0tEtynN7qFLWGCJ6hSzddnCGBuHvh90w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Z7O+c2Uw; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e34339d41bso44361107b3.0
        for <linux-rdma@vger.kernel.org>; Wed, 16 Oct 2024 02:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729069450; x=1729674250; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q/Z1A+jOwymtBHcOIKzmHrsVfq+AnOx8ByBvqMM4mW8=;
        b=Z7O+c2UwSLyXJGzvj1LH776y9IqjqjsrjudfKks7dQ0iMSnIATZW+tHwpgyfznngt4
         QWwZwvVf53KouFpOZ+zYDPR4Dz9sBonrZbqYX2chKOz5qn0xN6fpgf67cPUSAoxgClpB
         +3FEI0S24PP+1rZZEXFF9cdSNvJILvWomRFsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729069450; x=1729674250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/Z1A+jOwymtBHcOIKzmHrsVfq+AnOx8ByBvqMM4mW8=;
        b=FmKvkDMIsak8dHhL7BC/7u4o04xlpxy+IrljpoOORE/KBMPFuSb6q5zuCFqdJXGHi4
         Bmo6oUalExjK7CQiBbIkVNsKINZBv3RjlMBaOOvi8ssMOl4t0uRVoukGbOew0f4cA6x5
         kjy7SB1nzWQjAkm2Ma8SU222CpT4SzpbcZ2/S+ZACZcT84sMuT7wtpqV2FXuh1xqMP9B
         Oyds0GGWUMHsbxe9I44m1mdNEfOY8za6BFWGa59ASjZJHaycPyL8BgMMOc1tiwk0ExKn
         ydnAJBeP6UNqXFxbL4yyACRIKUtb6JY5h22mrCg7HYk4lrnPYg40gM1UVeIOi5U7lol8
         lfvQ==
X-Gm-Message-State: AOJu0YwIo7/EFavcMwEWbp7hqI+09hOevWD4CdUUXdTJ8nFg9R/SOKNW
	nwOyod9C3F+kl55oBDVYRn64hMhz3pc8DOBrIF+YUvhzpCMFxEhEp5GtF1l4Vz60EsFAEQKPFD+
	kJEbH0MFEuIgbOo3eOwy/b4WRZ50MDDd6i0vk
X-Google-Smtp-Source: AGHT+IGFI+J8XubaLvPFk9Hl2ePaSziMynDNLmfA32c+ys4Qs9MVjVviRq9ndT7Tnk7DgqOxAFCIsRy0KXAhgZrm63U=
X-Received: by 2002:a05:690c:dcf:b0:6de:1e2:d66a with SMTP id
 00721157ae682-6e3d407f362mr34434667b3.2.1729069450528; Wed, 16 Oct 2024
 02:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1729065346-1364-1-git-send-email-selvin.xavier@broadcom.com> <1729065346-1364-3-git-send-email-selvin.xavier@broadcom.com>
In-Reply-To: <1729065346-1364-3-git-send-email-selvin.xavier@broadcom.com>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Wed, 16 Oct 2024 14:33:57 +0530
Message-ID: <CA+sbYW2xq70mVQASjo+3nt2PSfhuav7veBJDAmbsRP+rCWZ02g@mail.gmail.com>
Subject: Re: [PATCH] RDMA/bnxt_re: Fix access flags for MR and QP modify
To: leon@kernel.org, jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Hongguang Gao <hongguang.gao@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006a59550624945adc"

--0000000000006a59550624945adc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leon/Jason,

Ignore this patch. This patch is sent by mistake. It is available as
4/4 patch in the previous series. Sorry for the confusion.

Thanks,
Selvin

On Wed, Oct 16, 2024 at 1:46=E2=80=AFPM Selvin Xavier
<selvin.xavier@broadcom.com> wrote:
>
> From: Hongguang Gao <hongguang.gao@broadcom.com>
>
> Access flag definition in MR and QP is different
> in FW. Currently both reg/bind MR and modify/query QP uses
> the same flags. Add a different function to map
> the QP access flags for newer adapters.
>
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Hongguang Gao <hongguang.gao@broadcom.com>
> Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 59 ++++++++++++++++++++++++++=
+-----
>  1 file changed, 50 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniban=
d/hw/bnxt_re/ib_verbs.c
> index 2a21a90..e610807 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -94,9 +94,9 @@ static int __from_ib_access_flags(int iflags)
>         return qflags;
>  };
>
> -static enum ib_access_flags __to_ib_access_flags(int qflags)
> +static int __to_ib_access_flags(int qflags)
>  {
> -       enum ib_access_flags iflags =3D 0;
> +       int iflags =3D 0;
>
>         if (qflags & BNXT_QPLIB_ACCESS_LOCAL_WRITE)
>                 iflags |=3D IB_ACCESS_LOCAL_WRITE;
> @@ -113,7 +113,49 @@ static enum ib_access_flags __to_ib_access_flags(int=
 qflags)
>         if (qflags & BNXT_QPLIB_ACCESS_ON_DEMAND)
>                 iflags |=3D IB_ACCESS_ON_DEMAND;
>         return iflags;
> -};
> +}
> +
> +static u8 __qp_access_flags_from_ib(struct bnxt_qplib_chip_ctx *cctx, in=
t iflags)
> +{
> +       u8 qflags =3D 0;
> +
> +       if (!bnxt_qplib_is_chip_gen_p5_p7(cctx))
> +               /* For Wh+ */
> +               return (u8)__from_ib_access_flags(iflags);
> +
> +       /* For P5, P7 and later chips */
> +       if (iflags & IB_ACCESS_LOCAL_WRITE)
> +               qflags |=3D CMDQ_MODIFY_QP_ACCESS_LOCAL_WRITE;
> +       if (iflags & IB_ACCESS_REMOTE_WRITE)
> +               qflags |=3D CMDQ_MODIFY_QP_ACCESS_REMOTE_WRITE;
> +       if (iflags & IB_ACCESS_REMOTE_READ)
> +               qflags |=3D CMDQ_MODIFY_QP_ACCESS_REMOTE_READ;
> +       if (iflags & IB_ACCESS_REMOTE_ATOMIC)
> +               qflags |=3D CMDQ_MODIFY_QP_ACCESS_REMOTE_ATOMIC;
> +
> +       return qflags;
> +}
> +
> +static int __qp_access_flags_to_ib(struct bnxt_qplib_chip_ctx *cctx, u8 =
qflags)
> +{
> +       int iflags =3D 0;
> +
> +       if (!bnxt_qplib_is_chip_gen_p5_p7(cctx))
> +               /* For Wh+ */
> +               return __to_ib_access_flags(qflags);
> +
> +       /* For P5, P7 and later chips */
> +       if (qflags & CMDQ_MODIFY_QP_ACCESS_LOCAL_WRITE)
> +               iflags |=3D IB_ACCESS_LOCAL_WRITE;
> +       if (qflags & CMDQ_MODIFY_QP_ACCESS_REMOTE_WRITE)
> +               iflags |=3D IB_ACCESS_REMOTE_WRITE;
> +       if (qflags & CMDQ_MODIFY_QP_ACCESS_REMOTE_READ)
> +               iflags |=3D IB_ACCESS_REMOTE_READ;
> +       if (qflags & CMDQ_MODIFY_QP_ACCESS_REMOTE_ATOMIC)
> +               iflags |=3D IB_ACCESS_REMOTE_ATOMIC;
> +
> +       return iflags;
> +}
>
>  static void bnxt_re_check_and_set_relaxed_ordering(struct bnxt_re_dev *r=
dev,
>                                                    struct bnxt_qplib_mrw =
*qplib_mr)
> @@ -2053,12 +2095,10 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct=
 ib_qp_attr *qp_attr,
>         if (qp_attr_mask & IB_QP_ACCESS_FLAGS) {
>                 qp->qplib_qp.modify_flags |=3D CMDQ_MODIFY_QP_MODIFY_MASK=
_ACCESS;
>                 qp->qplib_qp.access =3D
> -                       __from_ib_access_flags(qp_attr->qp_access_flags);
> +                       __qp_access_flags_from_ib(qp->qplib_qp.cctx,
> +                                                 qp_attr->qp_access_flag=
s);
>                 /* LOCAL_WRITE access must be set to allow RC receive */
> -               qp->qplib_qp.access |=3D BNXT_QPLIB_ACCESS_LOCAL_WRITE;
> -               /* Temp: Set all params on QP as of now */
> -               qp->qplib_qp.access |=3D CMDQ_MODIFY_QP_ACCESS_REMOTE_WRI=
TE;
> -               qp->qplib_qp.access |=3D CMDQ_MODIFY_QP_ACCESS_REMOTE_REA=
D;
> +               qp->qplib_qp.access |=3D CMDQ_MODIFY_QP_ACCESS_LOCAL_WRIT=
E;
>         }
>         if (qp_attr_mask & IB_QP_PKEY_INDEX) {
>                 qp->qplib_qp.modify_flags |=3D CMDQ_MODIFY_QP_MODIFY_MASK=
_PKEY;
> @@ -2263,7 +2303,8 @@ int bnxt_re_query_qp(struct ib_qp *ib_qp, struct ib=
_qp_attr *qp_attr,
>         qp_attr->qp_state =3D __to_ib_qp_state(qplib_qp->state);
>         qp_attr->cur_qp_state =3D __to_ib_qp_state(qplib_qp->cur_qp_state=
);
>         qp_attr->en_sqd_async_notify =3D qplib_qp->en_sqd_async_notify ? =
1 : 0;
> -       qp_attr->qp_access_flags =3D __to_ib_access_flags(qplib_qp->acces=
s);
> +       qp_attr->qp_access_flags =3D __qp_access_flags_to_ib(qp->qplib_qp=
.cctx,
> +                                                          qplib_qp->acce=
ss);
>         qp_attr->pkey_index =3D qplib_qp->pkey_index;
>         qp_attr->qkey =3D qplib_qp->qkey;
>         qp_attr->ah_attr.type =3D RDMA_AH_ATTR_TYPE_ROCE;
> --
> 2.5.5
>

--0000000000006a59550624945adc
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAIAfsD/UCHT
YSfn3ZyNWHfZRmOIaD3M+mOJykJqMsQZMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MTAxNjA5MDQxMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAou2ENBKuSsYfWqOw9ox9m+H8OtAbp
4K/byur4yqhY8/DW5WZOamBIz1/wxT+gwJtZeXVZNLwTDNuWXGzEU2PpvRKrVq8mpSIO3egszYrX
Xb4Sjd/dQrp5mherIYyqjrmTMTRpO4Gs/8mm7JL5ZiqWhXgxMXrYtM24uK08tJWzgPDqqY83/L5I
iBs6dHXIvWNpBW9W7CcWdr4LdaiR3E29na1c3TIXtDHc1HVfMdRypbrSpr08JC7gxY79TYobuHSY
3jfap0w2/OeYdPlyqZCFi4G3rT5IPXT3RChVpf2Aa8bpjYUeCy0EfCHLwUZLKMzfXAHgvTCv7duF
Zqdd93RL
--0000000000006a59550624945adc--

