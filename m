Return-Path: <linux-rdma+bounces-15202-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FAECDB580
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Dec 2025 05:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 217883009F7C
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Dec 2025 04:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BCB2C21F9;
	Wed, 24 Dec 2025 04:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eOTv4YOq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F44B2BDC13
	for <linux-rdma@vger.kernel.org>; Wed, 24 Dec 2025 04:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766551127; cv=none; b=EDXerYXrowK56PpEIDJX9HKXx0tFGVdOyowX7C8ofr6qE6ve/peRXeCvANxdXI07gn91HqvTzsDnaGWogyBJQiex/i0tS6XQqznFfSQYwggCxJaHj1wbpUJjDlNzxhbMbI36xmX9OGfKNiI/HL1DXbUG8cVrgYqrlMUsgWi0W/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766551127; c=relaxed/simple;
	bh=uUrg/gLohEQa1yzEP++tidCWTnu6ZygmXsjU+xnCLbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5vFwFm37Q3Jsjg5zKcCUK3/6QY988ypVC4gnXBmgRF4hZiNhG2jQdydZAsHKqrMc82XhH+lg7anq6GFYBbiitWJYMPSeLDA0/rKhE8+kRh1+qLGnwqfx9EepkTr3z/YcwU2TdfPH+z9FB3E2bD/eLUMZnxR8wQJBDiPxaRC0cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eOTv4YOq; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-4ed9c19248bso48373931cf.1
        for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 20:38:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766551125; x=1767155925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nR9ddnw74OXQyt7NQlZ/CCBmkp2AFcNlJ3yQEwCu130=;
        b=ftMwbQwBLQlwqRWy1wNL5jfZ4Ep6U541yOCKgqQ3gNkw7DrFO6VbAxet853svGxj/x
         dFfxeZlRbXWiNvP2DA6nx3Q0WKMCyWCes8K2n+348IlKu8WteM2/Mnby1BjXgKHKgJN4
         Tph1HWi4aQqvCDIe49gfTFH7rhI0qoejMGxKC9E6ld6q8Y7WWe4OmHfZzfsvANduxLvT
         m9tKtSJTkr0W46qyrMmgawrNyuCFnzX6iKNKvIr5LZFR1W0ILePRoEtkCReGlAw3+m/R
         5ZsN7UTSuPU5gmm3kIoJXLrn7r3OT1b5PCmQPh6mCLdbxXW0zJp3T4l8ha1gS6AlOvkp
         2cgA==
X-Forwarded-Encrypted: i=1; AJvYcCWcgIBLPMZ/BDf735/VV2EHqks22eX5TazI55nJN8/YFtK8fZwJshKyUOC6IOb/UgReEgfUDTkckzml@vger.kernel.org
X-Gm-Message-State: AOJu0YxqVHOB0T2QIYLDJo+rjmB7L8ofoVtz+oXbqLs+6Myjmx7YNZQo
	Ud7pz2vqL8t9gvOsTWD7vc7z5421VRBxHPQb3w2hZVs9HCi0IPEouyhFXDWx0FwZeyU41ugmlzc
	QHrbo4z8C1r/7rUog40YFXnE7owUsk2VEeFXdakqW8GHouylpVDXFOJsfi0gpACg3hA5xC0ykb8
	7CJ7Fi1D3KwRNVm9pyF+YI8sIgIAkFOq0ISg4bn1wVLogGluTr+LdWFcnt+n3AEojmI5BzwbNEU
	sC8ApkbrR+U/joa09ignnWfosa1
X-Gm-Gg: AY/fxX6NXeHTIrCjPwo+jUkfmK078ekSyBsaqIGudJnm6o0A5GZOK329AHvl6u1BN74
	hLpDp/lLbNvb0+wXCM67s1frlyxzJbbylVQMgzo2hQFoUiqa0mnasQCLhSNVG4xIo5iqL6dLJpd
	XryVsziL6pxoj5sYMS3gZYimk2H96dbN6ZIbMc4FMYWUEvzcscoffpeLcrwOgavSM3eyusu6ZmT
	4YAfBjGY8FvgMvAigpZUsa48uUmBP4HtBGNYuZ6kEpPjVITVTWF7w6XdtRg/kCpmOY9htHv49pd
	a7D4/DVSEzbOBZLy978837rzwHQDazJOE7o/2ZtOQ74zxVTBQosNdzKuIjbsgCXj/QkmZKeVtN/
	AUmqkb+zIZIVG4p7xOUo01/1sBCQTqlZOTipr/pA/tsXJn4MyiL/I6ZL37XCcmrwCsMHVcSg4hR
	d+XV//4+wxwvO+t3bL9zvgqucBl7pohdkAoVZg1veR9M5dt3QxrQSDMboc
X-Google-Smtp-Source: AGHT+IGOuwNEtyU8VJczRsZPza3cOq1hEPTrHhB5ki56XCz7qqLdiRm04S4excq3uRfodNolfgskHUhn69w4
X-Received: by 2002:a05:622a:4243:b0:4ed:e337:2e52 with SMTP id d75a77b69052e-4f4abd1daccmr217369641cf.30.1766551125093;
        Tue, 23 Dec 2025 20:38:45 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88d98431837sm21678656d6.32.2025.12.23.20.38.44
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Dec 2025 20:38:45 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430f57cd2caso5324525f8f.0
        for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 20:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1766551123; x=1767155923; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nR9ddnw74OXQyt7NQlZ/CCBmkp2AFcNlJ3yQEwCu130=;
        b=eOTv4YOqVqS9bbg07CutmB0qGy6bGQDTiyqaqPP3ajQ4b1qp05Emua8fn/r2a3Wc06
         2YGzlbS0Sld+S3QvN80KVjFVit7wEjj5YOsC1/AchTNV9OqtcBzN7ARa1bYna2/CPN4/
         e1Hodq2hltVsSTNC9eRUEDXjKxXG9jPkPbciY=
X-Forwarded-Encrypted: i=1; AJvYcCWQz9XqXLrtwdllw/+xFUhadhBnfoNusCVQf+VxNthTPiVzENiUJkeAtggWloFAcHYuvaKc2Xyrm0Ec@vger.kernel.org
X-Received: by 2002:a05:6000:240e:b0:42f:b707:56ef with SMTP id ffacd0b85a97d-4324e4fdcb4mr18933108f8f.39.1766551123169;
        Tue, 23 Dec 2025 20:38:43 -0800 (PST)
X-Received: by 2002:a05:6000:240e:b0:42f:b707:56ef with SMTP id
 ffacd0b85a97d-4324e4fdcb4mr18933096f8f.39.1766551122790; Tue, 23 Dec 2025
 20:38:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251129165441.75274-1-sriharsha.basavapatna@broadcom.com>
 <20251129165441.75274-4-sriharsha.basavapatna@broadcom.com> <20251217195828.GB243690@nvidia.com>
In-Reply-To: <20251217195828.GB243690@nvidia.com>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Wed, 24 Dec 2025 10:08:31 +0530
X-Gm-Features: AQt7F2rfrrc5eRMUhmfu23lYeyrUKYjQ7gl5rlUoROxbvTTlSGTsHVB0lxcZKgY
Message-ID: <CAHHeUGU4n3NC7ExtwcK_67=61c52Hkh09zenXs6RTPR+eqLjhQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next v5 3/4] RDMA/bnxt_re: Direct Verbs: Support DBR verbs
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000315c960646ab3cc9"

--000000000000315c960646ab3cc9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 1:28=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Sat, Nov 29, 2025 at 10:24:40PM +0530, Sriharsha Basavapatna wrote:
> > +DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_DBR_QUERY,
> > +                         UVERBS_ATTR_PTR_OUT(BNXT_RE_DV_QUERY_DBR_ATTR=
,
> > +                                             UVERBS_ATTR_STRUCT(struct=
 bnxt_re_dv_db_region,
> > +                                                                dbr),
> > +                                             UA_MANDATORY));
> > +
> > +DECLARE_UVERBS_NAMED_METHOD_DESTROY(BNXT_RE_METHOD_DBR_FREE,
> > +                                 UVERBS_ATTR_IDR(BNXT_RE_DV_FREE_DBR_H=
ANDLE,
> > +                                                 BNXT_RE_OBJECT_DBR,
> > +                                                 UVERBS_ACCESS_DESTROY=
,
> > +                                                 UA_MANDATORY));
> > +
> > +DECLARE_UVERBS_NAMED_OBJECT(BNXT_RE_OBJECT_DBR,
> > +                         UVERBS_TYPE_ALLOC_IDR(bnxt_re_dv_dbr_cleanup)=
,
> > +                         &UVERBS_METHOD(BNXT_RE_METHOD_DBR_ALLOC),
> > +                         &UVERBS_METHOD(BNXT_RE_METHOD_DBR_FREE),
> > +                         &UVERBS_METHOD(BNXT_RE_METHOD_DBR_QUERY));
>
> This is not a "method" on an object because it doesn't accept any
> object ID as an argument. This is just a global function, so it should
> be using DECLARE_UVERBS_GLOBAL_METHODS().
>
> It should probably also have a clearer name that it is about returning
> the ucontext's DBR.
Ack, changed it to a global method and renamed DBR_QUERY -> GET_DEFAULT_DBR=
.
>
> >  /* DPIs */
> > +int bnxt_qplib_alloc_uc_dpi(struct bnxt_qplib_res *res, struct bnxt_qp=
lib_dpi *dpi)
> > +{
> > +     struct bnxt_qplib_dpi_tbl *dpit =3D &res->dpi_tbl;
> > +     struct bnxt_qplib_reg_desc *reg;
> > +     u32 bit_num;
> > +     int rc =3D 0;
> > +
> > +     reg =3D &dpit->wcreg;
> > +     mutex_lock(&res->dpi_tbl_lock);
> > +     bit_num =3D find_first_bit(dpit->tbl, dpit->max);
> > +     if (bit_num >=3D dpit->max) {
> > +             rc =3D -ENOMEM;
> > +             goto unlock;
> > +     }
> > +     /* Found unused DPI */
> > +     clear_bit(bit_num, dpit->tbl);
>
> Stuff like this should be implemented as an ida..
This code (dpi_tbl and related bitmap) already exists, we are just
reusing that in a new function. We will look at changing this to an
ida based implementation as a separate patch series.

Thanks,
-Harsha
>
> Jason

--000000000000315c960646ab3cc9
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDRX9e9L1aWKDiMiijMWybY9T8dcVoyw6gH
nReganAU4zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTEyMjQw
NDM4NDNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBKIxCTq1HTHDu5G067DyUNwo05XIzmYgb842g9MDJ70G9HX8lpfCiMxYC0x5tVWiyKGO+G
AKV7uZFVSwKv+ISIgiysnO/Zl4SxczLKlnaaINjTrNKuTXq0jpBh6bAFgvwXivDNhJHwaNauaA2x
B2oaxIv/km/hup2zwQ4XumpMKTGWcdGE3Xm7keenjr41a9ovj6YBcVl+kRZRoNBD+11wCGdt6O9F
ULMptl3DtnniPQZ5xO6XseQ8dKxBl3AaepXsCTD4HCj7M8ABhuEONsjgbN6nbfDKdv2XoDIbmEwg
C2DoU7gx6zUThTIj+jtVkVqp6x8iNR7tWjrZVv211HbK
--000000000000315c960646ab3cc9--

