Return-Path: <linux-rdma+bounces-15580-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BF7D24163
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 12:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 12A823007F38
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 11:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE19376BCC;
	Thu, 15 Jan 2026 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Kv/nFs+R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F93E376BE0
	for <linux-rdma@vger.kernel.org>; Thu, 15 Jan 2026 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475464; cv=none; b=cWT3o2pnLyqa+ZKx6spim46zOOirIJaHkQ+hzMGow7XPtI21mUr4XaOSrvkSsZwuxM+1TS9D89EoCBCsQjjdEVv+OrT6oIO3p9NXn0iSgS93ZTFLhzb4Gq8gLX3CgKD7qJ+vjXUn/kZDRXPT2/Cazn7aFnuRQHVGJ6ONhsna2Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475464; c=relaxed/simple;
	bh=5vyX++AME9ilU9LJjaHNAvpJyrT68J4sO6YOB6r2P/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUk8iawp/PmMjFHR3WrDbieCnpyqP/GqoE2FQZBp0vME9ZyucF6WIEjMZbXhHm3b2QU/olmm5kyKFe7lWXeTSAidS63nlImfwYF9szmSjalI07S901v3BHkSMAvoktLft2fc6mUWEDoYffCkWklu3pKwIAmnF+JjOdomRjJWF04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Kv/nFs+R; arc=none smtp.client-ip=209.85.217.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-5efa33b2639so233858137.2
        for <linux-rdma@vger.kernel.org>; Thu, 15 Jan 2026 03:11:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768475459; x=1769080259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNxLxfNLP2cNdqTGIiSH94bCYbiCvIALnHF7TFZKjeY=;
        b=K9qFvyOj3r3VxXO4NyEE5Gp0AKTJVqMHcwyfu/yIJYA10V0MJbYtXQ62aZ1MMwtRbm
         HojaIgg/Q8slFPBdF5c1t1HjJlu96B5Kv6Vum+vXj45kCDdx4zsU4DSAHIpC0XxRzEfJ
         vjJKzniWp/tUYj4Z5jlmdhdgcBfRcVZJTskX+HdzqnSj9e57GbMMMLP/LVK19XNmwvlv
         LaolQmwrPcr0IR9ZeBwrtbnm3KjBMCkDquTWt9Uli3pGGeVFDczgJInKO1MMVR10nAk6
         540hFNu95m0Nf6B1dtpNZb3ne69Y+ZKmUWUbOzzr1cDunPQsQYJR9gYtMaLN7yN0Z4Mp
         s3bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbxP4uzeuI5SoxoHzUKfNAT9qcvLRJaDx3QabQCpMp+eo0ANKZVMyODk1yDi/ZHk/JCjshjNgpEYFl@vger.kernel.org
X-Gm-Message-State: AOJu0YxEFLRytHtxxx2OEZ7NAzF5TZ/R7VNfQGig0G+3c8pKw4X4Bk0K
	GGWD+FyL2xl5/XIhuys9Db9gT5hlJ09TwtdfbVGmwESjHefL4v9ekhxuCpPtnXcTXezDlFSeKKH
	lOmgm+cJ1Tah2V5hro1N0lkk0FNnilZAzrHl+NDKdegfSvXuRLwml9rt/k1nAoVCSFQriaWj84+
	upxKxeSBUIFcWEiV3PRMxE3dyqVlwAAIxLqJ6to+LqbhPKtj7w3EANLoyLuHLdIe02nS/ef4K28
	rjrhdBrTx4ezQPIS0VJHgXCPZ4b
X-Gm-Gg: AY/fxX77IDewfQhjxem/7Fe0tPmnNE4FTfVxk4x3OuDA2ub7vjyvGci6HnrsTNcOETv
	Sa+FApmb4kcnw5k86em6b/VMCO2OqVBXcvtIVnkj5DIZY590mEI0RkL6RReVhszUsQQ/Ig3B+wf
	RwYV2SXDSnTd3sWfUGmsfePGVICQAdgB5x2cLEi7jqef/7cBUgzC/4AC156YTepuC4ux/uOGjt1
	KdTTrKR/7WxqKNYK6P+3bfV+GjdFzkDF5775SaO6U8wiEUemD7ZRADLyl4KzjhuRPXnvrhayXt2
	g2jyGWE4GYfJn+E/duKdnoYDvDk8R4Th2gnuPBNzkv9BwtW3BBnjsg3XmLkGk1XWPEBBnK2Zf/M
	SeO4yhPyQIVMX8sDHr9+9FY1q3saxAkiLjpU9PyR2UkJQ6mvgU4btzYh7wvxfYO61sTZC9DOZin
	Gmk56Qo19OTaFiJPlOqSpe47EXl7YQAUF+vbpD238nb+vYu5V9LiknCg==
X-Received: by 2002:a05:6102:3e27:b0:5e1:82e5:201e with SMTP id ada2fe7eead31-5f17f3f9ef8mr2063731137.8.1768475458675;
        Thu, 15 Jan 2026 03:10:58 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5efad7fe064sm2843009137.5.2026.01.15.03.10.58
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jan 2026 03:10:58 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779edba8f3so9072415e9.3
        for <linux-rdma@vger.kernel.org>; Thu, 15 Jan 2026 03:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768475457; x=1769080257; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HNxLxfNLP2cNdqTGIiSH94bCYbiCvIALnHF7TFZKjeY=;
        b=Kv/nFs+RfGVhMvyLm56i8CX3mKjEJHo/7jobXaPyzgSbUdQBPCqwtBSu1IpNgkqQaI
         jjZVqrLOo/5AxJt0FVt+aOicY+21fOESuy+HI3pE+4GF4FStOBf8oj0jD5d6zjGzkTDM
         La/aD8sQ0kZetM+dnI/tWZu/tNAlw/qJ/5nCE=
X-Forwarded-Encrypted: i=1; AJvYcCXENT0axjv846HIHs60nsja+tUgtSRiwYz2KKz1o3ElwbZ9U/lFrM20aHb22EUy7Lp0D3IcfldarNh/@vger.kernel.org
X-Received: by 2002:a05:600c:4e54:b0:47a:935f:618e with SMTP id 5b1f17b1804b1-47ee47ca723mr65209195e9.15.1768475457219;
        Thu, 15 Jan 2026 03:10:57 -0800 (PST)
X-Received: by 2002:a05:600c:4e54:b0:47a:935f:618e with SMTP id
 5b1f17b1804b1-47ee47ca723mr65208935e9.15.1768475456852; Thu, 15 Jan 2026
 03:10:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113170956.103779-1-sriharsha.basavapatna@broadcom.com>
 <20260113170956.103779-5-sriharsha.basavapatna@broadcom.com>
 <20260113173247.GT745888@ziepe.ca> <CAHHeUGWErNHmhFX13VHw3V6feswyV6JVzULegGoBNg+2x6O12w@mail.gmail.com>
 <20260113185957.GU745888@ziepe.ca> <CAHHeUGUgacV=t6pUJDX_orvxwzv4LEH_cnzyN61mCA-MMY7acA@mail.gmail.com>
 <20260114165909.GA961572@ziepe.ca> <CAHHeUGUuN+WBX5xKHH2MeS0XoRdDbZHDduDD_8aK=Tv8d12Zeg@mail.gmail.com>
 <20260114174931.GB961572@ziepe.ca> <CAHHeUGVdfmJtZDnHUduX8OJNPDVnOou+9X-irruN6N3dpxWH0w@mail.gmail.com>
In-Reply-To: <CAHHeUGVdfmJtZDnHUduX8OJNPDVnOou+9X-irruN6N3dpxWH0w@mail.gmail.com>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Thu, 15 Jan 2026 16:40:42 +0530
X-Gm-Features: AZwV_Qg6Uo8V_ZUiOCFUR-fU8RWZn2BBgWyHpWS_T8lzf9GdB0Nqlb2bA_iVSvI
Message-ID: <CAHHeUGWTwGjHDN3p5f-_pCiLH+MEDGpjAiJNF6-SkXZW8wGXTA@mail.gmail.com>
Subject: Re: [PATCH rdma-next v7 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000070a87606486b470a"

--00000000000070a87606486b470a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 11:33=E2=80=AFPM Sriharsha Basavapatna
<sriharsha.basavapatna@broadcom.com> wrote:
>
> On Wed, Jan 14, 2026 at 11:19=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> w=
rote:
> >
> > On Wed, Jan 14, 2026 at 11:14:30PM +0530, Sriharsha Basavapatna wrote:
> >
> > > > Please don't pass object handles in structs, the attributes must be
> > > > used to pass these things. The driver can obtain the pointer with a
> > > > simple
> > > >
> > > >                         send_cq =3D uverbs_attr_get_obj(attrs,
> > > >                                         UVERBS_ATTR_CREATE_QP_SEND_=
CQ_HANDLE);
> > > But there's no cmd buffer to fill this in as an attribute from the
> > > bnxt_re library, since it is using ibv_cmd_create_qp_ex().
> >
> > ??
> >
> > DECLARE_UVERBS_NAMED_METHOD(
> >         UVERBS_METHOD_QP_CREATE,
> >         UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_HANDLE,
> >                         UVERBS_OBJECT_QP,
> >                         UVERBS_ACCESS_NEW,
> >                         UA_MANDATORY),
> >         UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_XRCD_HANDLE,
> >                         UVERBS_OBJECT_XRCD,
> >                         UVERBS_ACCESS_READ,
> >                         UA_OPTIONAL),
> >         UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_PD_HANDLE,
> >                         UVERBS_OBJECT_PD,
> >                         UVERBS_ACCESS_READ,
> >                         UA_OPTIONAL),
> >         UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_SRQ_HANDLE,
> >                         UVERBS_OBJECT_SRQ,
> >                         UVERBS_ACCESS_READ,
> >                         UA_OPTIONAL),
> >         UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_SEND_CQ_HANDLE,
> >                         UVERBS_OBJECT_CQ,
> >                         UVERBS_ACCESS_READ,
> >                         UA_OPTIONAL),
> >         UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_RECV_CQ_HANDL
> > [..]
> >
> > DECLARE_UVERBS_NAMED_METHOD(
> >         UVERBS_METHOD_CQ_CREATE,
> >         UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_CQ_HANDLE,
> >                         UVERBS_OBJECT_CQ,
> >                         UVERBS_ACCESS_NEW,
> >                         UA_MANDATORY),
> >         UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_CQ_CQE,
> >                            UVERBS_ATTR_TYPE(u32),
> >                            UA_MANDATORY),
> >         UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_CQ_USER_HANDLE,
> >                            UVERBS_ATTR_TYPE(u64),
> >                            UA_MANDATORY),
> > [..]
> >
> > You can add a driver specific attribute using the mechanism:
> >
> > ADD_UVERBS_ATTRIBUTES_SIMPLE(
> >         mlx5_ib_cq_create,
> >         UVERBS_OBJECT_CQ,
> >         UVERBS_METHOD_CQ_CREATE,
> >         UVERBS_ATTR_PTR_IN(
> >                 MLX5_IB_ATTR_CREATE_CQ_UAR_INDEX,
> >                 UVERBS_ATTR_TYPE(u32),
> >                 UA_OPTIONAL));
> >
> > const struct uapi_definition mlx5_ib_create_cq_defs[] =3D {
> >         UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_CQ, &mlx5_ib_cq_create),
> >         {},
> >
> > Shouldn't be a problem?
> Thanks for this example on driver specific attributes, let me look into t=
his.
> -Harsha
Posted a related comment on the library (rdma-core github).
Thanks,
-Harsha
> >
> > Jason

--00000000000070a87606486b470a
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCA4jU1m4rwayZy0Av0upLU1S2b4Nrvorbo3
6DKf8iymlDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMTUx
MTEwNTdaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQB7vH0RYuJ1kxnwVC/Tnh0t6qWjY1z74b37l12LSI3x4ssqo/m2SJTuFl0Fp9nMrCqfo8si
mqSEeh8Yv0i5ctsbI4CrOSUZQSGvLvzgsfaK8CLFeQpe7LkXmJxuSCgAEQtv8JYw/qunAhd60oTB
bxW4dk7IaHYrSpUkP9BAwuEnDXvf7NXE8qJjZYEYPbGRKcu8mHoeyj0lLkTtldDBvHIo+qMjrx7e
kVAv7cN47pCZEblS2v+7aAgZWKtc389+ND5mQTqgO/W7D+QEEer9rOP1uznIBbFoqZIazfm0GegU
+ksBDibuM22IzUVpe/F+YFhN6i2XwD9bw866OIvRVJWK
--00000000000070a87606486b470a--

