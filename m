Return-Path: <linux-rdma+bounces-15201-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6A0CDB57D
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Dec 2025 05:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 218BE301A728
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Dec 2025 04:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB9A2C2356;
	Wed, 24 Dec 2025 04:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JNG2KnQ+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7826A1D63EF
	for <linux-rdma@vger.kernel.org>; Wed, 24 Dec 2025 04:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766551077; cv=none; b=qaEz05CGi335okJ9EIJUE0Hu4k1olwx1AqzlylE1FPhalv5t7ARzlQKrGrtVBb6QIjvU+LiNQfE7/vhUHqUmUHyWxLwWqW86yZiCXpC1N9AyLKuOfZaJbZ2AYFLddHSgyldLw41xRmGY8R7MMu7Mbx7WXTLCe6pQqx/dcqoLRwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766551077; c=relaxed/simple;
	bh=jsUemn/QJrORxFTVubOsyMlBDPwpOKPwd4q1yLMDP5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esD0QkMMS8/1pC2tDoQrQQoJZ3egb1KhRqz8Zg0ekBUEZYg8K1eLY/0MdH4cmTcHp1QdmaRxImjI82iVYhJd+CBBk3Rpg6v28//NbuQGcHM+dJc4IjZuBwpgh/d7V8LRYU5TtG0psqMzZtOWhjsotNDRYRrFgPZL1738cY98kDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JNG2KnQ+; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso3681849a12.3
        for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 20:37:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766551076; x=1767155876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Q8acEpGWfMc8b9NqAAabYSoyxdhKc4Wexjpi1gAOtk=;
        b=FppaHVhp3hYOBvgYcaPfOW8WlmOlhxdEzDgwkusv3rHK0GZfr8oolKuyDVmoM/nuhw
         TSIv2SRCjD03dGwuqcG3SPjSHoJHP5bt2CYvyIRMPrXxXYz+/464J5Ii1xWrQoutSUU3
         zmnJm5+WIYs2QW1InTccBvbYB3njIMH8KOCNu441QHtUfsz7gHY04VYilRgMGRwhF0BI
         /Ye+BxtWP3x53KW325oYKCA6j1VspVu0Y/kHWIaftexxkxnsMnzOCVfJMEomR4PbjAhf
         pLN0+cqfcRFrmm/xwo9tgkX8mahegLpII9xmfeFmAfU1uVlVwtkb11Ak0XieHxLBSavb
         nGAg==
X-Forwarded-Encrypted: i=1; AJvYcCVT8H6XzBmvYXwf/kewzZ5ahdHuiXTsg90upc//AlI7uqR4nx/mxDaw3SiKaOuL6Pa9q8EIZ+d+7bJC@vger.kernel.org
X-Gm-Message-State: AOJu0YxCzszau/MCpAupqfPb8xtd2aWct0BdD04qbhfMnrhFAkueOCav
	7Wk1WIAckjGejTBz0R8Qe0sFnAqxzyBloaFiH0Ap/nHqcRQAilrCm/fzLCGOT40LWS8W14wQ6lZ
	Xlhn2WUqdjiszI+2QqM7LerN0W46mrfU0OnlJCll0ZKMgFGC9HhfpuDiqKP/tye6DRRhlk8w9/8
	x1Zj/YO0Q0zQS5GjaIWcKQvsM5S8qOxfGuiovf+erIjgifXj0s7Yq05IUAlKryMlS4TLiMLnUyA
	cst5s41OPwtIip1JkadLbJWoelD
X-Gm-Gg: AY/fxX7+IM0VtB7HfSiYD8gpFU4wEGXkrrJKX58UT/fs63nAN4exNJXW/+khqs9O8qd
	aQIWjI6M2pGfjp0GIrxXcoPKlbdaG27FKBkzxeM64v/xiWPOnPRdxD7nW0JhpwluntYTH+1pjgc
	0CpLX2r8qFecWKvtSXgWs8eg13XM+QaSfNRFMXr+D36TrGHq90eamfyhse9xlyQTfj4CknE2Xxz
	9ViXeViGstTQ4klxZ7HmW4DKPn8GdaupgZbYqlSfqdBQX3ieFtiCjAHKRXqyEX8cPOElQA9xcUk
	+tKIwJqqkL9t2AhKpOlww7gZUvmNxxxd6VqEz76hC5w3mTpfCkzTTzvklfAGsptt1JaUjSqCWEl
	S4n/xcJDik7w2rKPh37bVq6lmpzrkCQgXLVjuAZ9SEjYZpo5pNCU3KX3PmZKDl5zQUArOTIfxs1
	wbACZ+5eWBLG6AdHYoFSmfwbqD4ryEQKMjGjImmguANVem58RQNOKWVKWF
X-Google-Smtp-Source: AGHT+IHNGuxULrIDlLz7HeMV/7q+Sii76nmmDBLS9E+0ZlGYnCJ5aEuo5lxRjVsjTvCrNaa1EExnDdjhBAJw
X-Received: by 2002:a05:701b:2705:b0:11b:ceee:a49f with SMTP id a92af1059eb24-121721ab860mr12153730c88.8.1766551075378;
        Tue, 23 Dec 2025 20:37:55 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1217253e933sm3205272c88.8.2025.12.23.20.37.54
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Dec 2025 20:37:55 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-431054c09e3so3105775f8f.0
        for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 20:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1766551073; x=1767155873; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Q8acEpGWfMc8b9NqAAabYSoyxdhKc4Wexjpi1gAOtk=;
        b=JNG2KnQ+r3Sz7ugo7jq6qQiuYN1rG/miFL/NJeWVOrLCDKEWEXtklKyvtKr+8RDEmy
         tl7DwoVzj2dONa5LKH6/keGovpg92rzMfTEXaHbjv/wNLfsxm5+ni+ikwq5505FtRBEP
         Rz65kv2TztX2byBYRHDGtZV3u9O35rNLeR4Q8=
X-Forwarded-Encrypted: i=1; AJvYcCVG4FO7lA6bI+XevCqL1IgG3dhjkwwBRH1Y8XnUWpHED5pSSKfFf6m3ZHV366HmzgWoJIFzkVGH+ZlB@vger.kernel.org
X-Received: by 2002:a05:6000:22c8:b0:430:ff0c:360f with SMTP id ffacd0b85a97d-4324e4f6addmr21301892f8f.33.1766551073386;
        Tue, 23 Dec 2025 20:37:53 -0800 (PST)
X-Received: by 2002:a05:6000:22c8:b0:430:ff0c:360f with SMTP id
 ffacd0b85a97d-4324e4f6addmr21301875f8f.33.1766551073044; Tue, 23 Dec 2025
 20:37:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251129165441.75274-1-sriharsha.basavapatna@broadcom.com>
 <20251129165441.75274-4-sriharsha.basavapatna@broadcom.com> <20251217193106.GA243690@nvidia.com>
In-Reply-To: <20251217193106.GA243690@nvidia.com>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Wed, 24 Dec 2025 10:07:40 +0530
X-Gm-Features: AQt7F2pEp_2Y-0I8-41_h0DuAtNgXAbJbTB_bnAWRrHxVX2IjpOuENc8vJVzliE
Message-ID: <CAHHeUGX6tWzHPXgPWibZWESWvjL6wcGuu20DynjONP0d--eJdA@mail.gmail.com>
Subject: Re: [PATCH rdma-next v5 3/4] RDMA/bnxt_re: Direct Verbs: Support DBR verbs
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000039a7e90646ab3984"

--00000000000039a7e90646ab3984
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 1:01=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Sat, Nov 29, 2025 at 10:24:40PM +0530, Sriharsha Basavapatna wrote:
>
> > +struct bnxt_re_dv_db_region {
> > +     __u32 dbr_handle;
> > +     __u32 dpi;
> > +     __u64 umdbr;
>
> __aligned_u64
>
> > +     void *dbr;
>
> void * cannot appear in the uapi headers, this has to be __aligned_u64
>
> > +     __aligned_u64 comp_mask;
>
> We generally don't have comp_mask in these sorts of structs and it is
> never used, remove it.
>
> It looks like it only sets umdbr and dpi, so what the other things
> even for? Remove them if they are not used.
Ack, removed unused variables; only two used now - dpi and umdbr.
Thanks,
-Harsha
>
> Jason

--00000000000039a7e90646ab3984
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCecWAAXKwEXK3pDq2BwWdlgNIelXGhFeBS
++MGcm0pcTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTEyMjQw
NDM3NTNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBJG207OHNsFggwZ/WRErzmdSIvtKlaSxNZbv2hkan/ZX8ATIMYMg6G66npeVklXdZoEQAJ
j6yePcMVhbV5dc0a2RaBRGf/4kxkBhfecX9dVEG68YHocOG1cEXVWjWhW4Zc1nC4bEhY7q5M949m
R1V5HB8AR/UMewrkzZk1KG3RqQI13F/PEFYQbNDnDYai0AyWEO3uI6btCZHgrRnvZx5DCdTYpDdl
8xG78Owd9hoLqObsawh+Qqz2QrM4EFrCQPQL2TOCWV7Am1pEUPQYz43CuQAWTYC8jQc8t3I+j4y/
AaMQQ60ZrICwPGTzg1INQzf/Dhnv5400/lgvojQ/y9u1
--00000000000039a7e90646ab3984--

