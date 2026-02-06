Return-Path: <linux-rdma+bounces-16656-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULxnMXAVhmk1JgQAu9opvQ
	(envelope-from <linux-rdma+bounces-16656-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 17:23:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7680100329
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 17:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4629030028C4
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 16:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E912F2C21D9;
	Fri,  6 Feb 2026 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fzUdVa5E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725E8212D7C
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770394984; cv=pass; b=qMIobmYPoTZFZqxVzXvITmg2xIwcU3ElzUf3QLrZfMUOJsb4ru/xdQLY3IaUkK1BGfuNeMTHTBfRtlBTQV6zYIuXoNMoMvKlE2ywD5n3/8QTMGpG51D8YqxOHbWY3HV5Qvia5reerLKiptiZzLWaLh9/xP5u++rz/XNF8FK2LAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770394984; c=relaxed/simple;
	bh=CPKQfJqw7q3geMRpDycmZOk2l79ttM32QC/mUml737Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0P01WDq7q09QNE3HpEr/8lh51uSrv+P/M2NuLyrmvwOg3FJnKLpLJkKFC33ExCf6DLVQJ4xW/7FGRlAdoU13nxfc6k4O8kyVl+WztIuCOYDrJ/s42uVEwl7OlNeNtNTC7WiH/6uTIDmRPqxRxEqKvUkuDj1A55Smy9BFmqIiKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fzUdVa5E; arc=pass smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8c52c67f64cso188219185a.0
        for <linux-rdma@vger.kernel.org>; Fri, 06 Feb 2026 08:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770394983; x=1770999783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPKQfJqw7q3geMRpDycmZOk2l79ttM32QC/mUml737Y=;
        b=vauckwfsvG6cq3UmahBhIQ0w5N9Ry478NPm5AXkg5Pg1FcC0lEtQ1PNSQDtCWsvCWE
         sE8clgoA8iwwuATgZ4t3aMdJYONrb96r35siBno7robY3is8oyT67YE5YlAbIL0RvXJo
         F1jljSFORN0+SDGGgB4MhQwFprYQr57qC/dtcVvdv7vBUQKqxvZugjwL+Z6XbnJWgxgk
         DZQNW0XS5Uv+HxjzRI6yK2f42K0r2ExOvH0W25yz3RaXQSYBgF/cOAjgBgAnMTijSORN
         J+MpnYpzKcWtfaBuAWY0gzleKISIXz6LEkvo/P0OuG7d5uKw6NvJFDSxO5BWew5QAvRH
         0HZQ==
X-Forwarded-Encrypted: i=2; AJvYcCUh9HngiuZKpb3G4HImB/0Rd+n72ioWjKJX6RIZtcBdUMwiSEsghSxAR/YpP0Xiy9BNwHGmeJLzA53b@vger.kernel.org
X-Gm-Message-State: AOJu0YyrTsKBejjiqlY91DoFvAL9AUcCS/ThTiS+Cl9qaNuFJTC/v5oy
	jelqPAQp/UqqsJscnNZhihGUdBOxpA2apE3+dBBLMD7bAmzSQl9QWOOd8VgBJkplS6r3YJMNzCl
	ZnYFUWaBcyRsDPg2inwba0ilqcng+I/b0DTxIRQ8LN/MTYCWXgcN09v81QWz/cnlqfkKVOUTjS7
	avn8RTBg7FJUxnOR63lAUdb3HMqtkTPEIAWkiuoeKsL7ThgE56TdjyhlpbbDpaTKpeL17/sX17+
	Wqfs8k44sITntXGnZ+NceirDm/V
X-Gm-Gg: AZuq6aLwHEdIDgJSvvvymWpXD5tx4llwC1sTj7bhtrdJnz5LiebFBioPQptRz/wuLoq
	lNGKYaC8WTIU9Fc85QGvMSGVokirT8QvG14NRBhOR5DGI4CDv4yT0Sqjqyxri8hSqHuFpIySy0y
	xQp/SFLHF42+q2DVvnBnwHKe3dWPyhsz/+VqT/bCp/V3UqG2d1820LkHP2l3Jzsr55gM6RtyNhF
	Ws1+MvhqOOcr8J66zjlh8aUaKBsctZP9ddBpSTJjJQQyu0C1+plAG+y6LpUwSCQxkRMh6apuEpt
	G/mEiY+1gqFucOmpE+cMCT7km30b8TJ9KarqbGakEDxXwmG6r8C1JfV8MFY651tv+lxUfP/06Sw
	SjsRMkYJBFLmf3vZag3amNL4AdMa7OCPsG0an+zIao/ypTzvbf0aR59NusEtoLp3UbnO5AGzlQK
	Z6IfYFjjcr/jXDlN+49Ccj1ts4UEjeF5dPciSKHMDxkdnEk4rx8WA82NUO87Mxaa/4XVJndS0=
X-Received: by 2002:a05:620a:25c7:b0:8ca:2e36:18b0 with SMTP id af79cd13be357-8caeed3b00bmr428065385a.39.1770394983226;
        Fri, 06 Feb 2026 08:23:03 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8caf47b1f33sm31883085a.0.2026.02.06.08.23.02
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Feb 2026 08:23:03 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-431054c09e3so2063481f8f.0
        for <linux-rdma@vger.kernel.org>; Fri, 06 Feb 2026 08:23:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770394981; cv=none;
        d=google.com; s=arc-20240605;
        b=f3varfVlJr+r9200w46pa+KfLH21VGebO7VmldOt9K1Ow4WMWi4fXYeTNuMLslcpG0
         bAjH9YCP1mvqcmBKgBYzCTxsaVbTBmwqFlto247pDwsxUlWh+VCF7APauS8t6Q8KQ4pK
         m7kP7AWxOmAX2IlmiWwymDK2xkn3n/egl4g3iRuTilPcvfM0dvXpBE6QIt1zkVNvvZJi
         o2/6OmlPqCKATmus0jURl/iIlHxFiRU9W2jSsLclpwOkSpLyyDUGDbu4pn4Dy79jMhAc
         h58/7Y8efHySuAh3iiEQU8FGrOoXlNjhTSa4R/cURHIXuE0GIRWGWxBb/qUawM6phgUP
         FpAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CPKQfJqw7q3geMRpDycmZOk2l79ttM32QC/mUml737Y=;
        fh=H3UB91Wz4N0tvEaKrNY+J3RNx9YyNMWmKG0giTwmvHE=;
        b=hr1Pp0SULZCG8a5Kd48goepQHaFMZDu4R2Uub2kEYLH11TidrmSnGYCN6J98LYO76N
         AGIAtD7w9H0RQRLtCbzBLiSF9UliKxUMwlpkQUC7AGihLt5dsjtb6CHm75S1a0T0Nsir
         v2h0A9LgjTH87Nt5dyF8/KafcQTNjW4rSGgT/12kKeSZzxqAiNgZFRzYsZV+WBSXbvTl
         DkVapnXx6M13z92nyXkxo//GaYc80PKINlQ+8yxcAHB8X+3B7y8Rz3/rgXSq7ul2OoAo
         vtRT6H6ePhhm0u61jU0OXMhCeT20txkIGsovsX0vs5Ib9AhXO8e7dGvu4gqk22fn2/Hh
         wGqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770394981; x=1770999781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKQfJqw7q3geMRpDycmZOk2l79ttM32QC/mUml737Y=;
        b=fzUdVa5E4NqciejdOekgSfbOCqQHCpYZUl8QT5C+HBonbGQN6TNC4Q+37HGwJ8AAh8
         1XI5rucqTQK2KJIgcgoaopuiaetkD4eDBeXvcTEQVg+6M2Q7WYJG638yBpAUUKVeTGXT
         +X2YDUhLiz29yW7TrPR6Gks9wR92YWVIoG+Y4=
X-Forwarded-Encrypted: i=1; AJvYcCXCcP9aFgYadom2iCAPwWvRdn7gnPQg3N+9EnHMwFA1FnfZrxLmM183VdOHUD2vDmc0gSNC9CSSRjZC@vger.kernel.org
X-Received: by 2002:a5d:5d87:0:b0:435:9f41:d54 with SMTP id ffacd0b85a97d-436293b29c8mr4681010f8f.60.1770394980932;
        Fri, 06 Feb 2026 08:23:00 -0800 (PST)
X-Received: by 2002:a5d:5d87:0:b0:435:9f41:d54 with SMTP id
 ffacd0b85a97d-436293b29c8mr4680978f8f.60.1770394980542; Fri, 06 Feb 2026
 08:23:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203050049.171026-1-sriharsha.basavapatna@broadcom.com>
 <20260203050049.171026-7-sriharsha.basavapatna@broadcom.com> <20260206142651.GG943673@ziepe.ca>
In-Reply-To: <20260206142651.GG943673@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Fri, 6 Feb 2026 21:52:48 +0530
X-Gm-Features: AZwV_QiNl8kgf7GTkHgmSq0pYIUmUhIhM7xRIPal_GybLbJ0B9FyTWvW1ijr7C8
Message-ID: <CAHHeUGUChdv+pvCoLSZdTMkP89Xn4Zy1SPHdwkekDs_3n0B7Rw@mail.gmail.com>
Subject: Re: [PATCH rdma-next v10 6/6] RDMA/bnxt_re: Direct Verbs: Support QP verbs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f9ea03064a2a33ce"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16656-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:dkim]
X-Rspamd-Queue-Id: C7680100329
X-Rspamd-Action: no action

--000000000000f9ea03064a2a33ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 7:56=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Tue, Feb 03, 2026 at 10:30:49AM +0530, Sriharsha Basavapatna wrote:
> > The following Direct Verbs have been implemented, by enhancing the
> > driver specific udata in existing verbs.
>
> Same general remarks here as for CQ. Don't introduce a "DV" idea,
> split out adding umem from the other stuff, make it fully general so
> that umem works on all QP types, and integrate the new parameters
> directly into the normal flow.
>
> Clearly explain what the new uapi parameters are for and why they are
> needed. I didn't try to guess if they overlap attrs but they look
> questionable like CQ's were.
>
> Every one of these version I've looked at seems to have unjustified
> junk in the uAPI - this is something your team needs to take
> seriously, a clean uAPI design is essential to having a maintainable
> driver.
>
> Jason

Let me discuss with our team and get back to you.
Thanks,
-Harsha

--000000000000f9ea03064a2a33ce
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCB/39QDdKiebSPINgvYA7YVwSh5S9vQ67mQ
vlS2pSZS3TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAyMDYx
NjIzMDFaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQCapS3jJ0+u13+8ZyY6rnDe28LxuXALr6u39u2m5we/Q/wchsAJsSTn2G80X6UqgazYk1V2
OEmftgR1m+KnKl+QH0skODiaGz3qmpM1JDcq0BR2239iPYykj4LY+2Pg8Rhc2LmZX+69D+V1hD9O
TvgP0Jp5FrDnEYNXLbDGPG1OwB9l3tLicsXTaicLLLCndIgu/elLjX4vmrNsSIUX1YfXFWSmFR6o
Dx1jkdGdN16eDDF7NYaJ7Dey269cX6rAzIewJcXkzUPs2XFMpFQ+Buan7/RqK7s3/iN95G/GEwMa
rJ6aCHKupo1vkTDe0sLbAYI6EAMjp6HI17I/2Ss/hd/I
--000000000000f9ea03064a2a33ce--

