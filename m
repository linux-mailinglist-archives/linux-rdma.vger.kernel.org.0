Return-Path: <linux-rdma+bounces-7581-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 149FEA2D630
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 14:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B165C1662B9
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 13:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ADA24635D;
	Sat,  8 Feb 2025 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aVKZye/j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5591A3157
	for <linux-rdma@vger.kernel.org>; Sat,  8 Feb 2025 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739020480; cv=none; b=bXn5VitJPoZA3o3m5ETDSZthVONlpOI+YLIvgZTQsk63Rx9XybO3lqOnFuqLYRzmApNonM62NUf+yq70cQaLFUkqBo6l9EeKWdGrwPC0wS9tB1OfJ8e8EbgR5PVftI3eAiG4hjzN+KidAFE7pXbZ/kqqwA7AGTcJiN/KERt7Gk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739020480; c=relaxed/simple;
	bh=uDjfG29yrLrOBth96YkvqCba3Kt53EYMfU58RQ9e8Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRrLA05aP8gQjBITGtoq26oCWyBMSVFdG8wJjnXI4cUtF5YEtRWrcEQUmxBsZeuTtf/xAvH6D1iDJroytFNT1GxB0z20TkoNNLsZoTUZbsqG8Ugrf8UoUbreizSkUZtaLrGcOJbJnzF1zYv1ebAyRcxkkM+rc1U9VqqAGfqr5sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aVKZye/j; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71deb3745easo850020a34.3
        for <linux-rdma@vger.kernel.org>; Sat, 08 Feb 2025 05:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739020477; x=1739625277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fFjnA1RKziN9HdPoCPh0+fPmpnWjnewYfiq2p+XYTH0=;
        b=aVKZye/jD3EmdOnX7BUDJLYBZOZCot6ZRCbfhWsNOFARwICbRrRe+UM0PtRtstzZTv
         Tc2UzjAflP02qipOtWzUaDj4ufsJdq00ZVuaPXlKZ0NQZ3Ggb2Ek/m59G6z3V/NgqDgr
         uBkRoVyw+JMfqH7lm/mkRyPaFJmBSOABigxlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739020477; x=1739625277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFjnA1RKziN9HdPoCPh0+fPmpnWjnewYfiq2p+XYTH0=;
        b=NR3MCE6yKWWCsKrGEs+aZ7xy8IRT5K/oeWrTMmGdMh1ec0vXaFy6eAuV7BchnxXi7Z
         2SInUWZz2olTBdR3ujlDqoW+M/mtZYVkKYMwVooKqDcM0eYO+7jLbS6r7i+UPATYWrAJ
         CdFGPF8OSr0DfPDP4NHtuSiRQfXl/jm1Gf9Ub1jEGJNtS343CXEsdTFpyNbEyQOzWsy4
         nsJBqjd9SQBj7l3U8y5zg2RQyvCgB5oz9JGZjDA9v0CORIip+aJjCRxhmyqzVWICiQo4
         UFTbSCn3qaW39znQbrLGFhsXgy6lvBJ4vcspPs3HKXrGJmguY9MTP3ny+lCM8VUDkh4D
         RkzA==
X-Forwarded-Encrypted: i=1; AJvYcCUROBi4Se0L9h5K+xPLsAO/XYjizHcInzO7muQXWsWhLe4WOHh9DIjnO0pK5bVI9/4U08r0zCsmgoia@vger.kernel.org
X-Gm-Message-State: AOJu0Yw197Qr+pr6THRUoW89QfIgSkKfqXapE9ZSt1nlyVEVWSDGChf+
	8nwUKzzqDkVv11LWBu44t8xh/tkj/+QXj5oSuJSCprs637HYPrsLdDXy3waalZviitFj3WdfoVj
	FblL5NX4YNSPeCFqkogsLkHfu/vURHhBfoBbL
X-Gm-Gg: ASbGncsu/zQfwYn8pVY3GbrV2O5QL5rCUtxJ49ZMUV4mON5zLK2bEYBInGL3iX8sCc8
	Me03brwS2qY5KkJc1xmTmEjkmkOdXcQzGtt+VNeQacqY/pstsLg7GmkK8MfK8/RyJIIS/kIMv
X-Google-Smtp-Source: AGHT+IGeCJ7wAxXz4nFY4wslIxlFX1NZaJXnFE/JCHWvybo8IspkQUgWdQV/ChBYB0pBBqPs07bbBsnKJJXf0cborlw=
X-Received: by 2002:a05:6830:698f:b0:718:18d6:a447 with SMTP id
 46e09a7af769-726b88a9e63mr4697337a34.24.1739020477141; Sat, 08 Feb 2025
 05:14:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1737301535-6599-1-git-send-email-selvin.xavier@broadcom.com> <4fa11b0e-e838-bfc1-a9e1-80c4aefc728f@huawei.com>
In-Reply-To: <4fa11b0e-e838-bfc1-a9e1-80c4aefc728f@huawei.com>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Sat, 8 Feb 2025 18:44:23 +0530
X-Gm-Features: AWEUYZliDnJR9Yo-tvdC1anGC984NA3J6DRU52GMF0zfsZNrV_MuknmIcleh9To
Message-ID: <CA+sbYW0Lt1pyK7Z3BYUTrAs7x0rQfxmfj4VQG23Q7EGAnY-aig@mail.gmail.com>
Subject: Re: [PATCH for-next v2] RDMA/bnxt_re: Congestion control settings
 using debugfs hook
To: Chengchang Tang <tangchengchang@huawei.com>
Cc: leon@kernel.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d1422b062da14144"

--000000000000d1422b062da14144
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 2:49=E2=80=AFPM Chengchang Tang
<tangchengchang@huawei.com> wrote:
>
>
>
> On 2025/1/19 23:45, Selvin Xavier wrote:
> > Implements routines to set and get different settings  of
> > the congestion control. This will enable the users to modify
> > the settings according to their network.
> >
> > Currently supporting only GEN 0 version of the parameters.
> > Reading these files queries the firmware and report the values
> > currently programmed. Writing to the files sends commands that
> > update the congestion control settings
> >
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> > v1 -> v2:
> >   Addressed Leon's comments
> >      - rename debugfs file "g" to "run_avg_weight_g"
> >      - Fix the indentation errors
> >      - Remove the unnecessary error message during the read entry point
> >      - Fix the return value
> >
> >  drivers/infiniband/hw/bnxt_re/bnxt_re.h |   2 +
> >  drivers/infiniband/hw/bnxt_re/debugfs.c | 212 ++++++++++++++++++++++++=
+++++++-
> >  drivers/infiniband/hw/bnxt_re/debugfs.h |  15 +++
> >  3 files changed, 228 insertions(+), 1 deletion(-)
> >
>
> ...
> > +static const struct file_operations bnxt_re_cc_config_ops =3D {
> > +     .owner =3D THIS_MODULE,
> > +     .open =3D simple_open,
> > +     .read =3D bnxt_re_cc_config_get,
> > +     .write =3D bnxt_re_cc_config_set,
> > +};
> > +
> >  void bnxt_re_debugfs_add_pdev(struct bnxt_re_dev *rdev)
> >  {
> >       struct pci_dev *pdev =3D rdev->en_dev->pdev;
> > +     struct bnxt_re_dbg_cc_config_params *cc_params;
> > +     int i;
> >
> >       rdev->dbg_root =3D debugfs_create_dir(dev_name(&pdev->dev), bnxt_=
re_debugfs_root);
> >
> >       rdev->qp_debugfs =3D debugfs_create_dir("QPs", rdev->dbg_root);
> > +     rdev->cc_config =3D debugfs_create_dir("cc_config", rdev->dbg_roo=
t);
> > +
> > +     rdev->cc_config_params =3D kzalloc(sizeof(*cc_params), GFP_KERNEL=
);
> > +
> > +     for (i =3D 0; i < BNXT_RE_CC_PARAM_GEN0; i++) {
> > +             struct bnxt_re_cc_param *tmp_params =3D &rdev->cc_config_=
params->gen0_parms[i];
> > +
> > +             tmp_params->rdev =3D rdev;
> > +             tmp_params->offset =3D i;
> > +             tmp_params->cc_gen =3D CC_CONFIG_GEN0_EXT0;
> > +             tmp_params->dentry =3D debugfs_create_file(bnxt_re_cc_gen=
0_name[i], 0400,
>
> Write operation doesn't seem to work?
right. I made a mistake in some code cleanup done just before posting
this patch.
 I have a bug fix patch for this, will post it. Thanks.

> > +                                                      rdev->cc_config,=
 tmp_params,
> > +                                                      &bnxt_re_cc_conf=
ig_ops);
> > +     }
> >  }
> >
>
>

--000000000000d1422b062da14144
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPCzzxB7C6VW
saarlVDmOHF6eSrfNzHDZ8zteMef46s4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI1MDIwODEzMTQzN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBaGsuxfR9ys/6HycpScZKA3prIL60k
TsSoI7wSoVyy5fIv4+7biqhuE91FHdHsiFHDo49Fwl74seMvsOB4nm57yUWCM8Lbt7aoib1T9HpT
dtYOA5+TxH/XogZbbkUQ6KWPijwUlK9Sm+Nm5KmYDnAnhG3jYB+G4HuNHcoF2Xztdk6SByxu1PDD
JHm3vC8+hlPZTd0KqVKMkhTgx42bOPuM6x68BDJe5E0NDJ+B30U4sm3pwpEblucoOwx8vbpRdezc
PT3cuuQeyPEnLgTv9RLNCTmBZatorrITab+WUxnIro77hUklfFAyWoCX3s34++vfPulLqeKtMvog
xBQOLIth
--000000000000d1422b062da14144--

