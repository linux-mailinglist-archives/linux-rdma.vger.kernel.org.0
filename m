Return-Path: <linux-rdma+bounces-15520-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C765D1A8A3
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 18:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D9F030090AB
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 17:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04F131691C;
	Tue, 13 Jan 2026 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aEVmkUVX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B92FDC5E
	for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768324441; cv=none; b=puj/7aaelvt05apJWTtbHjUCx59FYGfOWod/3ufQUWuDAGvDVwXZhjX3REdzgsbz7FDKozaloBkFLBwBqdqNC4pZ7yjfRHhUD0eWfKw+kxW/PQy2RFHtVxWaevHLlJJp71JpYvc9O6u8JPqSOigzdiln3y13KDx+XGEkIkAbTEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768324441; c=relaxed/simple;
	bh=j2KSMJrF17Hs98dStNSPYwdFziQ4SZ9JiF06XIC30a0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xl5sQ+0mMgQa0z6nf23xHhjaSoFweY40eoPkhWCm2ipIICRUHLK9V9BXF/0MJavuC8+AFUsuaq2/xvxEqTq2c/6Oc50cycrv715bVrR5OAb7i1B3UosD6xvydNuq+jk0e5clN4awaPaQzqssMos1S2GfeGV75fe2N2yyIeIOQtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aEVmkUVX; arc=none smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7c6d3676455so4063090a34.2
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 09:13:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768324439; x=1768929239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlQLvd+yX4VWN+RZaCsh4KHjYDXlizfAqJNwYmpEJSo=;
        b=e6a/2fhM7CQi/81YynBdCvJ8I7saPTKdce1IjvYxPN8kso7P6XS/n90G8xq+5JYezR
         Dd5b7ZCoi2iAgQrJ7imOHCzrAGZ+2eAwZsZj8vkiQEjpmCFDm0WjqJsrI7XIO0uWwklS
         nN6ZJ1v4Zrjrg/Gl0mtybj3GJgVMwJK+J96rsZt86+nPTRj56zd1GDVWQ+lUXxVlCQx2
         hoaMKN7/8J6Vc1xqtAcwXfVfGr8MZmNKmdre4DeZAF9GgiOW4MoAOQf0f//XzdZ96HWu
         g4OoKT5pBOgM5WRfoBRrrbttyo8w+aFkW/zgSyX/rCD4tIGTb/VIabm3WaOXh1flYzC3
         IXJw==
X-Forwarded-Encrypted: i=1; AJvYcCVztcp/bhzOCZHC0KpgWnzOk9I2Hbz0xFgXQ76ySSv2RI48mD6lDVKwvQRKUIot3dIh127NxpduQHUu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Z2WHTnFk0OzTAel5AAJv9mQ/evmmIuFPe6Oo06cwuZ3VErk9
	bHMp/HV458BO825zzxihdg4XCMZB2k355VRplL7Ljfy0UgK/RkYps4v12Vj9HIvNgdnLs8gFix/
	Bjos8PS8fdhu6oysJNPIOES1JBLIzcjbP5oyCxFEgmx3gt0YdSAx1yRNlK6nnUdZyd46YZO9n5k
	JQ3pvPfS6zckd39Gp693RzMKH1ser2hgIerPWNiJJzP/6zeuUCIHAdTltWa3q6B8wTfvx1OxFbr
	DW8YiqKtaHeVM+2XLYWP2dD6Gfq
X-Gm-Gg: AY/fxX7+1JIMFeRxWwxW25qp9OalZAeQN9ZobjuEGpfTU/hMgNYhrTXoZKd/o+G6e64
	DfrvW+CSB2qopY53URjLRnKndkzfxxY7C6zrbmmkJoSJzJXdGZFyWqnY9YYtPd2jFzrn6QoD3eo
	6BUTPNlDxKXHNz3nI9p4k7fZGRBfvJG6zlo4NKJDIh/YFChSqrby/DAuMe8QsmSIgFK9A3qTseF
	FQM0QO4KByPg7fBr0Iq3PIQRLOItiNOUsKRApKvChbkONY95AOHQvDpEPbEtTmCGbx50FbA9Ka/
	iy67mbuaJmIJviZIe9+6XRq+G3hZmY2/LBrgg57EkUPYGhzE4PI9oQlJlHH19s5Wwxfa2sXp/jQ
	CQ0IL12mok05tzlsWetx5iLXonoi98XSGfXbS99BZU5ytp5hDs/sQxDvVNqTEWDj3QEMnmaidMY
	du7KDi
X-Google-Smtp-Source: AGHT+IFSs/7FQAgt+5hHBf9eXMzvqa913wfxz0e+FU1kmRUNq3k7LIWxPbr0DYmPImdZujxM4CeOq+m78Uqo
X-Received: by 2002:a05:6820:2401:b0:659:9a49:8df2 with SMTP id 006d021491bc7-65f54f5fb3bmr8386690eaf.52.1768324438816;
        Tue, 13 Jan 2026 09:13:58 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-65f48d7a2c7sm492528eaf.10.2026.01.13.09.13.57
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jan 2026 09:13:58 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47d1622509eso50490535e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 09:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768324436; x=1768929236; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HlQLvd+yX4VWN+RZaCsh4KHjYDXlizfAqJNwYmpEJSo=;
        b=aEVmkUVXHGsR1aSoIEjLKSyyBBAtatEUxhR6KMtiRXBSDKQl7MiYGfR653WqRxrCLN
         DVoYC03SFHV0gEvsfvIAjmCAg78TsUJtWE+xiLip1fwcYKCw1suvPXPSnmdZJb9um3EA
         oUxFbRRVkTfyHJwDYiUuh45Ljpt9zAzETDrfw=
X-Forwarded-Encrypted: i=1; AJvYcCV8OXQzXvc/e3W/A+ass+r06enfjO8453ASTErqQAvRX9p2pHnK2fd+HooRvHBNvyG1XkIYGXDakQ0h@vger.kernel.org
X-Received: by 2002:a05:600c:4752:b0:477:df7:b020 with SMTP id 5b1f17b1804b1-47d84b54c47mr227364385e9.18.1768324436335;
        Tue, 13 Jan 2026 09:13:56 -0800 (PST)
X-Received: by 2002:a05:600c:4752:b0:477:df7:b020 with SMTP id
 5b1f17b1804b1-47d84b54c47mr227364215e9.18.1768324435920; Tue, 13 Jan 2026
 09:13:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224042602.56255-1-sriharsha.basavapatna@broadcom.com>
 <20251224042602.56255-4-sriharsha.basavapatna@broadcom.com> <20260109185542.GM545276@ziepe.ca>
In-Reply-To: <20260109185542.GM545276@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Tue, 13 Jan 2026 22:43:42 +0530
X-Gm-Features: AZwV_QhDKzhfPApjIkJN7BEXhv3LbgCWH0wV9oy2TYvjl3qliF0J1mfevJKSMss
Message-ID: <CAHHeUGW9WuG27d-9PeocxNfB+KhxfBcHo2NwFMQOipRg9HnTMg@mail.gmail.com>
Subject: Re: [PATCH rdma-next v6 3/4] RDMA/bnxt_re: Direct Verbs: Support DBR verbs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e56e300648481daa"

--000000000000e56e300648481daa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 12:25=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Wed, Dec 24, 2025 at 09:56:01AM +0530, Sriharsha Basavapatna wrote:
> > +static int UVERBS_HANDLER(BNXT_RE_METHOD_DBR_ALLOC)(struct uverbs_attr=
_bundle *attrs)
> > +{
> > +     struct bnxt_re_dv_db_region dbr =3D {};
> > +     struct bnxt_re_alloc_dbr_obj *obj;
> > +     struct bnxt_re_ucontext *uctx;
> > +     struct ib_ucontext *ib_uctx;
> > +     struct bnxt_qplib_dpi *dpi;
> > +     struct bnxt_re_dev *rdev;
> > +     struct ib_uobject *uobj;
> > +     u64 mmap_offset;
> > +     int ret;
> > +
> > +     ib_uctx =3D ib_uverbs_get_ucontext(attrs);
> > +     if (IS_ERR(ib_uctx))
> > +             return PTR_ERR(ib_uctx);
> > +
> > +     uctx =3D container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
> > +     rdev =3D uctx->rdev;
> > +     uobj =3D uverbs_attr_get_uobject(attrs, BNXT_RE_DV_ALLOC_DBR_HAND=
LE);
> > +
> > +     obj =3D kzalloc(sizeof(*obj), GFP_KERNEL);
> > +     if (!obj)
> > +             return -ENOMEM;
> > +
> > +     dpi =3D &obj->dpi;
> > +     ret =3D bnxt_qplib_alloc_uc_dpi(&rdev->qplib_res, dpi);
> > +     if (ret)
> > +             goto free_mem;
> > +
> > +     obj->entry =3D bnxt_re_mmap_entry_insert(uctx, 0, BNXT_RE_MMAP_UC=
_DB,
> > +                                            &mmap_offset);
> > +     if (!obj->entry) {
> > +             ret =3D -ENOMEM;
> > +             goto free_dpi;
> > +     }
> > +
> > +     obj->rdev =3D rdev;
> > +     dbr.umdbr =3D dpi->umdbr;
> > +     dbr.dpi =3D dpi->dpi;
> > +
> > +     ret =3D uverbs_copy_to_struct_or_zero(attrs, BNXT_RE_DV_ALLOC_DBR=
_ATTR,
> > +                                         &dbr, sizeof(dbr));
> > +     if (ret)
> > +             goto free_entry;
> > +
> > +     ret =3D uverbs_copy_to(attrs, BNXT_RE_DV_ALLOC_DBR_OFFSET,
> > +                          &mmap_offset, sizeof(mmap_offset));
> > +     if (ret)
> > +             goto free_entry;
> > +
> > +     uobj->object =3D obj;
> > +     uverbs_finalize_uobj_create(attrs, BNXT_RE_DV_ALLOC_DBR_HANDLE);
> > +     hash_add(rdev->dpi_hash, &obj->hash_entry, dpi->dpi);
>
> This is out of order, hash_del is done inside bnxt_re_dv_dbr_cleanup()
> so it should be before finalize, but it isn't a bug.
>
> It should probably be written like this:
>
>         uobj->object =3D obj;
>         hash_add(rdev->dpi_hash, &obj->hash_entry, dpi->dpi);
>         uverbs_finalize_uobj_create(attrs, BNXT_RE_DV_ALLOC_DBR_HANDLE);
>
>         ret =3D uverbs_copy_to_struct_or_zero(attrs, BNXT_RE_DV_ALLOC_DBR=
_ATTR,
>                                             &dbr, sizeof(dbr));
>         if (ret)
>                 return ret;
>
>         ret =3D uverbs_copy_to(attrs, BNXT_RE_DV_ALLOC_DBR_OFFSET,
>                              &mmap_offset, sizeof(mmap_offset));
>         if (ret)
>                 return ret;
>         return 0;
Ack, reordered as above.
Thanks,
-Harsha
>
> Jason
>

--000000000000e56e300648481daa
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGszCCBJug
AwIBAgIMPiCpKhlPGjqoQ++SMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTQwNVoXDTI3MDYyMTEzNTQwNVowgfIxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEUMBIGA1UEBBMLQmFzYXZhcGF0bmExEjAQBgNVBCoTCVNyaWhhcnNoYTEWMBQGA1UEChMN
QlJPQURDT00gSU5DLjErMCkGA1UEAwwic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNv
bTExMC8GCSqGSIb3DQEJARYic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNvbTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKS3kXt4zVFK0i5F3y88WV5rV0rr2S3nOVTaCGMB
o6Se8pIb2HJcdpQ4rMiJuIRSyG2XDWv6OB+66eM/6cD2oklFcdzpC4/eYOQFWJ/XM8+ms6HT7P5e
uE7sY6CeUzLzHNjcRwVgZRWlELghY7DIW9fbMzRNDFsbxuIN/7eSofavP1q7PF3+DqhHZpmrVkDu
vcEBTRZSn8NWZ0Xhy4a+Y3KN2W55hh6pWQWO0lt2TtpyaqYp95egJGqDUPtqydci+qrBzXbL05Q0
gcK0NfqGJwLsEVqxHwzz/jRrzKBYKQEK4Bpau91oxVGLmxy1nQDiyI1121xyvsJBDctKH245XZkC
AwEAAaOCAeYwggHiMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSB
hjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3Nn
Y2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5j
b20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgw
QgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9y
ZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjZzbWltZWNhMjAyMy5jcmwwLQYDVR0RBCYwJIEic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJy
b2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3b
oCOFGLCgkjAdBgNVHQ4EFgQU9Dwqof/Zp1ZdK6zi7XdRGdBWQt0wDQYJKoZIhvcNAQELBQADggIB
AKzx/6ognUMhNv+rh7iQOeHdGA7WMDixk+zrD7TZL6O5DPqXfFqaTLpswyruTymA3AVxZkMJyF6D
zOAsRfU23BjVlgC95zl1glr7DorZW7B/CQDwbLHlkFy92Oa3E+gBzwdiDMjnq6tOW5p83zoVqiV4
qm4OwC9JILEkslV4uZVXHPm5cZoOQURTECE2BN34Qhg5qD3EKYqOTeMVRed1qQiIPqQv1b4xjPVS
qBwNPl7/4TJGiZGnRB7FsNnNUQRJONnEFifM3KGqjbqA4F8BhLXCYjqtBxxCGA5506StNfsjT8UU
28E6lcuJXC4hQXau+xXQ5GWqS4ecWwm22FAVy/i8FJVfXPTJnZeixmqaadbIU3fOJs5+XfyNkU2T
mlCafSr7KgV570M6tITSyminW/7rc8hdznGYypCNa+45JYJTaK4x1+Ejptaxc7TCS12B1zQNCxa7
AHX5PZra3SpDb7g1p1i1Ax0JVJTkThiCSNDbiauVn7xIJpf+H8HC6O2ddGmtKUxe6NseFnSGJsi6
7lO/cU+TpduV7w3weUy+nHhp+GsbClfvAGhFAs/GkyONExCwwIEVlFp9Mj5JLAgB+ceMbojBIoaO
d5rOzdIII5FDwKAAqyjHuniYLrP0xIH4L5kWOAy+LudP4PSze7uAxTiCiSJg5AaNBTa5NuwTnSX6
MYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEo
MCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMPiCpKhlPGjqoQ++SMA0G
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAxOeoJtaJXcrgbqtQ9IKeZAY+e4J416c8T
MYJyEzvspjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMTMx
NzEzNTZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQCfVH+W60FYmubhR/NPLypzbGZSz/19JIazMx5v+EQIp2vx89bWmlolcXs86gGhqqyvmgc2
9Ddkl5tw4PbGpP4DSnzZCZOoo78ePGxaKh86quLuh7bQIC5VTlrZqzgwtcBC+XctwWvOxaLErI0G
YQpL5YFqiUl7qh7AbC2uBnft8KBny3b1SskEMhpWUd1ml3fsvy0D9RP7nB3yFGJmRjdSuTQCsN2A
u0SF3s4UaXO5+K93QAyScVTfB+IWkVnBKqO3GMJzVI9KqMCMreyxtQ1v0Htmz4GokvlMTSZ/rkLL
PclsXFLKP+i7CadQnPvbyGkWfd7Hma/BEMhGfJvHxlvq
--000000000000e56e300648481daa--

