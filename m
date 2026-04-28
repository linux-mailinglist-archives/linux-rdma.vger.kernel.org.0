Return-Path: <linux-rdma+bounces-19644-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLmJHDxz8GldTgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19644-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 10:43:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD19D480625
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 10:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D186D306246F
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 08:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FCD235358;
	Tue, 28 Apr 2026 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C3QK6nKa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834BC2D0614
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365124; cv=none; b=YQvM/8ZJA+KpQnMqS1mBLBN6tNWfASZovwMV05J4FCW59+Ismiy4flFxK0cqGBdpleq+w4y2Bi46mOH+nf+b1ROh+LxWhFoHNn1KJugZr3ENa/dKd7FBTADgT9cQgrJktDIv66xFmMVJ9xUjrsrcIqZsFwS7CxQhg7vi2eJo7Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365124; c=relaxed/simple;
	bh=idki5IDSpjSeLZ6iToxkgpIB3UbA5hXsN7pvbvmjt54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4AsPUmmMn0TIpzm6z34oPHbFAkjiHadlBjbwJNE8jG8a6jTlAR+rNzPgnRFzJasTlt84I74AhVAtBmRfr045nYETdosilLe3FEwScx3a6V5TCGaWllnxVt7YUyzoe7uOFYviR0B2GHBjAsHgeOJPJE+L2RIlfdMDpAdiM6B5A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C3QK6nKa; arc=none smtp.client-ip=209.85.160.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-506a7bbe9d0so91167361cf.0
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 01:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777365121; x=1777969921;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uk6dzkfOhM+kckQqlNbepEbhRv5aj4v/XKWlb5L72S0=;
        b=KCAugaoDuX/0U0B/1MjPnrNkPHnQ4UV+ElwdkI9Y2UgntmeFLhuXYvZgwPXaGoUOn0
         xBDLcdwhA9YO5n+Z2YSila038wU6eG8/SjGli4PZV7b7Um+FKMipTIrsqk9gx79nS9le
         GAosthC1G6kyWXrynltOSW8AQsrN1RJW1V2mEXJQZD7JEM2p1Pa80ZCg+LbEVobknPSu
         SHq2vJVkKAbPexwznwAvJLWfZRnHNJXY757++xl7j+dBU+d8P0tmUnPLmlCxKvr9UAP2
         w4BiL/f0dodAysWVh22Yt0LuhcFXTylv34kTYa7UI22Wh2dTDVH5sNv5J7/NGDlsOzZI
         pj4g==
X-Gm-Message-State: AOJu0YyBGY1hvqGKbgpDFUE9fNEfsqBvYcJFiSsi5Y+T1lUOWkhCk/vP
	XFxRgVtAAK1njP3wIbGWlP4JtWI9U1dA0xu4AuFJcN5vuBZMrJXB7qMXHeNrca8eh88INpBSjCL
	XKkOC+d/Dw90wNYYh4yEZD4x+QA3/d9bpLN+E8qLpDnmp+DvWeM8MMg8mtlkXQrHfY+G/53hjhy
	33wSThusFSeB9GuE/5Zig4mUsVorQI47OhrJCtPXIQpLrw5KB8aYPikpScblJOy28wq5KTIW1tW
	lCPXlMS+vTDppiDjE2rDvTJtswI
X-Gm-Gg: AeBDieu8F4XSbooW1A5xCCtPW/Z6wM7+1VeXOBxp6F4eADpDcUqJnalmjcC9reX7mBR
	U0TxAavAD7Xeg/Hm2bSSEbZJNkXiN/k2Eg/unUx7808BjQrCnls84c2TzngydNPjmxDB4UNQMSi
	lRlTxDCjEdMJqjdlduZmQiuvbTyFrPIjIWdsBfVSKKK8iBYIZ07KRYsEVWMV16bu5vzxn/LNWFT
	giYB+VlAQOCr5GB8VHalQKm8CleNdgsrHmQMjFk1UYKubZP8qUr03ObTN1SvcgdYht9TWJwmaVC
	c7pKx1kHtAFk58Chm9oe357KE54Ngeh+GGwbjuUe/k93TRumv6l23gXr3z1i6JhBY87EhcWYE61
	E0jGu8FFZKUZ8/oUp1hmrfQNumlASejLvhzrM/y1BkPeBB9HbyqDY7MZESx16lTlbBR9z7jFDZL
	ORgsVHcCn1xZACULO5BEG89INp4Lo=
X-Received: by 2002:ac8:6f05:0:b0:509:348f:bc1a with SMTP id d75a77b69052e-5100e1465f3mr26679571cf.26.1777365121178;
        Tue, 28 Apr 2026 01:32:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-51013779459sm180881cf.22.2026.04.28.01.32.00
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2026 01:32:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d1fec59c9so7329427f8f.0
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 01:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777365118; x=1777969918; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uk6dzkfOhM+kckQqlNbepEbhRv5aj4v/XKWlb5L72S0=;
        b=C3QK6nKabn+99v3lBN+1oolhpEhRtzaNUAMDf5SQ49Ct90Kyp1GSjd1FvoatqgDtbF
         YJTvLcT9nFylAKNXThUdmVEGaliAeTI/twE5xBEJoNmvQbv4rwJiwDLA4Pkl8o9EqgR3
         yyEzP94bqmVWtPeepC/BzoaTkv/orsrVeJTWY=
X-Received: by 2002:a5d:644b:0:b0:43d:210:2b2d with SMTP id ffacd0b85a97d-44652b863a5mr2394341f8f.31.1777365118486;
        Tue, 28 Apr 2026 01:31:58 -0700 (PDT)
X-Received: by 2002:a5d:644b:0:b0:43d:210:2b2d with SMTP id
 ffacd0b85a97d-44652b863a5mr2394295f8f.31.1777365117914; Tue, 28 Apr 2026
 01:31:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415054957.36745-1-sriharsha.basavapatna@broadcom.com>
In-Reply-To: <20260415054957.36745-1-sriharsha.basavapatna@broadcom.com>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Tue, 28 Apr 2026 14:01:44 +0530
X-Gm-Features: AVHnY4L1-gbtpN_kNPBKlXndfqiuV7EE5gmBMqMaVTwVxtA5d3Ap0YGS6cQoq1Q
Message-ID: <CAHHeUGUVx9q=SVAgmDSyZmSVK4VpKLy9Wbaxoy1oUeOddOXwgg@mail.gmail.com>
Subject: Re: [PATCH rdma-next v3 0/7] RDMA/bnxt_re: Support QP uapi extensions
To: leon@kernel.org, jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008d16d00650811046"
X-Rspamd-Queue-Id: DD19D480625
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19644-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:dkim,broadcom.com:email]

--0000000000008d16d00650811046
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 11:28=E2=80=AFAM Sriharsha Basavapatna
<sriharsha.basavapatna@broadcom.com> wrote:
>
> Hi,
>
> This patchset adds QP uapi extensions to the bnxt_re driver.
> This is required by applications that need to manage some of the
> RDMA HW resources directly and to implement the datapath in the
> application.
>
> This series supports application allocated memory for QPs.
> The application takes into account SQ/RQ ring sizing constraints
> (extra entries, rounding up etc) while allocating this memory.
> The driver should avoid duplicating this logic while creating
> these QPs.
>
> uAPI changes in this series:
> - Patch#4: new uapi parameter 'sq_npsn' in bnxt_re_qp_req.
> - Patch#6: new driver specific attribute 'DBR_HANDLE' for doorbell region=
.
> - Patch#7: new comp_mask 'APP_ALLOCATED_QP_ENABLE' in bnxt_re_qp_req.
>
> Patch#1 Refactor bnxt_re_init_user_qp()
> Patch#2 Update rq depth for app allocated QPs
> Patch#3 Update sq depth for app allocated QPs
> Patch#4 Update msn table size for app allocated QPs
> Patch#5 Update hwq depth for app allocated QPs
> Patch#6 Support doorbells for app allocated QPs
> Patch#7 Enable app allocated QPs
>
> Thanks,
> -Harsha
>
> ******
>
> Changes:
>
> v3:
> - Removed umem patch from the series, that is dependent on uverbs support=
.
> - Patch#7: Process DBR_HANDLE attr regardless of app_qp comp_mask.
>
> v2:
> - Rebased to umem_list uverbs patch series:
>   https://patchwork.kernel.org/project/linux-rdma/cover/20260325150048.16=
8341-1-jiri@resnulli.us/
> - Deleted Patch#9; create_qp_umem devop is not supported.
>
> v2: https://lore.kernel.org/linux-rdma/20260327091755.47754-1-sriharsha.b=
asavapatna@broadcom.com/
> v1: https://lore.kernel.org/linux-rdma/20260320135437.48716-1-sriharsha.b=
asavapatna@broadcom.com/
>
> ******
>
> Sriharsha Basavapatna (7):
>   RDMA/bnxt_re: Refactor bnxt_re_init_user_qp()
>   RDMA/bnxt_re: Update rq depth for app allocated QPs
>   RDMA/bnxt_re: Update sq depth for app allocated QPs
>   RDMA/bnxt_re: Update msn table size for app allocated QPs
>   RDMA/bnxt_re: Update hwq depth for app allocated QPs
>   RDMA/bnxt_re: Support doorbells for app allocated QPs
>   RDMA/bnxt_re: Enable app allocated QPs
>
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 270 +++++++++++++++--------
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h |   1 +
>  drivers/infiniband/hw/bnxt_re/uapi.c     |  18 ++
>  include/uapi/rdma/bnxt_re-abi.h          |   6 +
>  4 files changed, 206 insertions(+), 89 deletions(-)
>
> --
> 2.51.2.636.ga99f379adf
>
Rebased on latest rdma tree (Linux 7.1-rc1, commit: 254f49634ee1). The
series applied cleanly without any code changes. Please let me know if
I should send a new version.
Thanks,
-Harsha

--0000000000008d16d00650811046
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBMi0hi4j4VKToKYlKg67XVPM0yIC2BeuLJ
owb66kX9tjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA0Mjgw
ODMxNThaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQCe5tyOiZPR3oMu7AjgQQ7qaC3mb2a5tdUU6VWmZjU/Cx6fc+L3bbmqNzL/nAbfesGOJWPz
OuactAbgAzpaIVIy9KpllAdg/FRFfjzlUdnCQwOg/7641xYT6Jo3TvjMR0Wt/3bsESXldiYfcx4g
7DG4+W4TfE1MgqJGMpZRpbA8drLAV0kurvA94QK0gd0twVmF/FVqJ0Bj14CM0XiWdJ+RzXXAc4q5
tv14z+fXE9HCKBvarC3FgHUcgN4AYkZ+3q58/PSQnDMtDX/y6a26lHtobU29S39VY/hbDVdGSqrm
VyR7c0osb5f1QfZnRG0AQ4kSfsiZHzzEv4vmxPBjem2X
--0000000000008d16d00650811046--

