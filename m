Return-Path: <linux-rdma+bounces-19317-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHsUAzPb3WnukAkAu9opvQ
	(envelope-from <linux-rdma+bounces-19317-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 08:14:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E30B3F5E08
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 08:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0823300DCC2
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 06:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9C130BF6F;
	Tue, 14 Apr 2026 06:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z0ZKHvIB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D01223323
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 06:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776147248; cv=pass; b=f1MGXFGjyTg18wNGK6+DKbZeRUyRdij/6U5gnuntIkMgwGDedeSaYxttS4CHYUzqNPGfOSfWUoIO2AcpPBqbOdsiVn/ve0vWhRRThfQ2pXPay1EPmPj4tmSOMDll6RpXJn2QPf3BFAMT3Sj80yuzN4bs3sImd8QDYeHm+wJcE3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776147248; c=relaxed/simple;
	bh=U3PccDEYwUkFRrd9zERsyqdy45nCkpD3lVhWdnqEcs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmFAO9efW4qzprkc6wJBooP9S3ffpO0see1zfDO1gMm57F9kBPjdhU6/9HGwKu+B48a1vqZmMiLCT3fFg1sttePAL1J/Uy92l7g8zFd4tkiENvYCH4Cf9FhifB6y6VcRUXh4RFrtlkVwB4vxHpT2K7SuvW2nI+KIrUgjvxbjWIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Z0ZKHvIB; arc=pass smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2b2ea1b3962so13097495ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 23:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776147246; x=1776752046;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTeIbq7yXVmVDlgN0G+N44dPQ0xMtrIHiJKutfMi6bE=;
        b=GeMjYdoqD/B4n0u8svQm7u4pAcQSVAzYPSVpJOIkjAzf5iWH3JScdF70s2q6exOo8j
         fsHhqbPsEhXSWNbhTdiM8pKEPVq1HGgl8i/SRP2Aj9ejtORUoA+umii29R1uXuFJZm/y
         N3a14v3b1ZdPNg+sZ8ZjHKokLTNS3ij+vwN8xxlDW/M7+IGa9Q0PhXplYIIiDzfbSew4
         pA+nLc19/ZvCE9XQEozbJYsFa/V8C5w9aiWuBIVjdHhJD1ONVjfp59OTibpnxGg5Qzmn
         hgFjLZ9tw3CfJFczsX7DA+a3TR/iGt41kxENBBYFLlXDteI7pQYmPTzV3LQWymHKvCuF
         1gig==
X-Forwarded-Encrypted: i=2; AFNElJ+GKcpgniadOQYa1QSyA0kVTVGkDzM0607lJYSIQQALhDM/odOfSP48vVF9zSH2oli/hyIUFioImZDp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ecbAjsm1/T5QpFqda7epWIx/bq9eSdTWaUDBnWog2o6F7Opi
	+TZ/cjXydqS3G5J3v5cHS1PH5aFhXLMqJ3Zc3//xRx9lHdug5hFr7zAJXBZQAHSs50LQ3lUOiLJ
	2dLks7l0bZLv5HuD5ZYpIn71RyhOhmz+K63ofbLO0/MB7gU1ObZE+Cwluo/EGG88VkqcoP/H7+b
	nH+4BivuL5ptmD/WEDFl7BLUgEiwVORgUYGNwDtaqpa/oXPbYvnqNIAMlaVDNz2iKGt6jDycCpD
	oSn6cFdOzPVepxrh82BvvUAO7UI
X-Gm-Gg: AeBDiev2scWOiXuZrYbqXi0u9oOkRFnxpUYDo8prxFX4k48/VoN79LUKgxvTTY/mxRE
	0wBnPYIUksDgstJSEYKckaVhAPzsis9DZXO5VjtRPpH45FsHXIPwina+3qlBCGXE3Y6ko9ZbOnF
	D1gWKltBWcJVTKsd1XHdmN34YUqDThY8r/003TOWDucqQ9nhqS9O7OsmNLkKkfE55c538hhNP5G
	Tp+j8ga/v+xeZdzSMdzOruhjyOaVWH9B7BkqpJ3LJQYll2E2ns2Ohlp5JNf/vOr408pnXaR5JuY
	x7o/r4CL6Zma5hnoNk96tEyg5S4ujL7/JSDA68Xe1Ly0FlXHlC1yk8vpJDIzQ3ASL4i4WG8SK+5
	XY/G9qhP/8YBodv/s+1mzXWAGu0FFfYyvNGaT1WnJn7kWDy5bYuA0RDSBLrKWMXmcb35ci5fdZj
	VqorW09iBeaYhCKGVsmbivGlxGy5rTshyg232O1GTt82QCU55MEN5/fSN47AQOpfisPJML
X-Received: by 2002:a17:903:3dc9:b0:2b2:54e5:b3af with SMTP id d9443c01a7336-2b2d5aac9b5mr122149635ad.45.1776147246268;
        Mon, 13 Apr 2026 23:14:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b4637cdfa3sm3176565ad.28.2026.04.13.23.14.05
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2026 23:14:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35d9f68d00fso10270908a91.2
        for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 23:14:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776147244; cv=none;
        d=google.com; s=arc-20240605;
        b=KSDSFDJT6/X1iaBqneRnE3tUd0judqHLWx9pxY5TxLdgAeZP9T6D6MeWkqh7cfSxsc
         yDxcH2Kkyy8fu7VnPvW1aVMuewwb2PaJ56dEDcNWlvHO/y6wsaIULjUclN8HYkWUTuGy
         /yAmShATJZ/PmnBCNWB62au81nqHBtdFOD3hJs93gsjZ2pEseyA+itTU508BRlxrA9md
         /3SSmwxJQwlaqFu3mVpqb+ZK8DTv7DsnjC0+wc22uIDad1FgaasdJN76g8xVJF/drTGc
         wizeXRwV3Ffo+jdXD3oJbDBnbYkHHw3zOd71dKjGJkQwrs+AKgc+7qNSoHPcvanWhAJH
         KORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gTeIbq7yXVmVDlgN0G+N44dPQ0xMtrIHiJKutfMi6bE=;
        fh=DRjSbTEZvoanMNTjV3z9sUc9hYXEtaNZhtczvUcXHT4=;
        b=lk380nna4DHpACLlUq9Anc/KQM6lS4HLXikQFKBqXb2oaiQ8FEy3h860aN2YGJb7ey
         NS+Bt7jA8Dq826YMEGd5Mp+8gaMABhsDbRmXHAehUjY8D+gxlb8CHHR+CGxG58JsD4cr
         l37ILrC6J+M+wT1JZLj7dK6YD4VJShWSl53+bBS5vXmeqGvOGlv8KKSM9PT0nltyxqoH
         67yeaNIwQ9xsf1BGE8LAvk685xVoUjIVA7xtO6+I2J1E3m8M6QmzEbL0cpGTOLntzZ9J
         hOPnukEqRCCwx/16eO72u5oOEFBwigqfGyVwAHdlKSthdlA8yjXVXk3n2ji8Os0QZKWr
         VYBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776147244; x=1776752044; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gTeIbq7yXVmVDlgN0G+N44dPQ0xMtrIHiJKutfMi6bE=;
        b=Z0ZKHvIB+CYDRg0dyOou88JoQ1Vw1/7CpR+FkyY//a7w1nat9SHr99klgl1kUZSeLk
         HWe+25I0Sk5NyGdhg9eGur//NGZEDH4lkUELxPRxVz0ymIm4faorveIWbb/spq25t+Wy
         Yee7apWFCc47G2MNCRi5q5HZTevfAIKmBNBn4=
X-Forwarded-Encrypted: i=1; AFNElJ//SSyxv7zwKZ1bbv67oqGHc0atGPBQxBf30BQ/tWkW0pcHpFoNWIkJnAA3H+Tpt4YEF4DSLc8oeqe+@vger.kernel.org
X-Received: by 2002:a05:6a20:7292:b0:39b:d9f1:6d00 with SMTP id adf61e73a8af0-39fe3ff1405mr17742162637.43.1776147244572;
        Mon, 13 Apr 2026 23:14:04 -0700 (PDT)
X-Received: by 2002:a05:6a20:7292:b0:39b:d9f1:6d00 with SMTP id
 adf61e73a8af0-39fe3ff1405mr17742146637.43.1776147244221; Mon, 13 Apr 2026
 23:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327091755.47754-1-sriharsha.basavapatna@broadcom.com> <20260410152509.GX2551565@ziepe.ca>
In-Reply-To: <20260410152509.GX2551565@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Tue, 14 Apr 2026 11:43:41 +0530
X-Gm-Features: AQROBzAfEOJLM2ednWI_QA7UcfWqL6hACQHQ_N-apeM7JMHoqsMJ8Sv6PHUppu4
Message-ID: <CAHHeUGUQgO_XGkwtYXZnWYxMZkSpZ74ipdHQ9M_9n29HFrRkAA@mail.gmail.com>
Subject: Re: [PATCH rdma-next v2 0/8] RDMA/bnxt_re: Support QP uapi extensions
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000991a25064f658104"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19317-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,ziepe.ca:email]
X-Rspamd-Queue-Id: 9E30B3F5E08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000991a25064f658104
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 8:55=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, Mar 27, 2026 at 02:47:47PM +0530, Sriharsha Basavapatna wrote:
> > Sriharsha Basavapatna (8):
> >   RDMA/bnxt_re: Refactor bnxt_re_init_user_qp()
> >   RDMA/bnxt_re: Update rq depth for app allocated QPs
> >   RDMA/bnxt_re: Update sq depth for app allocated QPs
> >   RDMA/bnxt_re: Update umem for app allocated QPs
> >   RDMA/bnxt_re: Update msn table size for app allocated QPs
> >   RDMA/bnxt_re: Update hwq depth for app allocated QPs
> >   RDMA/bnxt_re: Support doorbells for app allocated QPs
> >   RDMA/bnxt_re: Enable app allocated QPs
>
> Can you split this into two halfs, one just QP stuff and the other
> allowing QPs to use different umems? I think we can merge the first
> part more quickly
>
> Jason
I have split this into a series with just QP changes (dropped the
'Update umem' patch above) and I can post the umem patch when the
kernel uverbs changes are ready.
Thanks,
-Harsha

--000000000000991a25064f658104
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDGWHLtPbJ9QPYKlu652AjBPRV3WlQ8HQTZ
mWCk8dMJYTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA0MTQw
NjE0MDRaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBUDJktKOSCy7Pc8YYwmgkHgtBCNUTaojQScLKyFO74rMfwfM2REXydwed6Scsatjv9oLJJ
rUcpyTQEpNEFQDY0fpxN3AcklXQorNO0dZbG251CLGPXSpr/I0q9VbjFLkJh6DQpL51vmvOHJsaf
XJbAovHqJRovUjJYfDTIX7dl7+Kf61RNQ0ob5xyuKNbzbKvCW3WyunpcTWPXSTr08vd0zLIkZnEy
O5jYFAZOerWopk5Ha3OEcJDt4oNFsGhX2kiPBBaF4QbokrRvvUj+pQVNlJ6GMx5El+nJ/1CmrgOY
mWGoY6a6QA9v9Goy0lvefXc5Cd+hrerbPmWX58a+v9J/
--000000000000991a25064f658104--

