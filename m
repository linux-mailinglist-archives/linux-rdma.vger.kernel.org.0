Return-Path: <linux-rdma+bounces-22931-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eIxKHzhkT2pdfwIAu9opvQ
	(envelope-from <linux-rdma+bounces-22931-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 11:04:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0A072EA97
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 11:04:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=QHsBujKL;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22931-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22931-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E2AB318502F
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074374028FE;
	Thu,  9 Jul 2026 08:55:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6925E3EF0CD
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2026 08:55:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783587347; cv=none; b=oH76pr4rZ3Iznr7JLBEhagwVvsFWxVBsBr7rq8rE06t3JGx0F+1ogMjF2p2EpMeXiqYJ8hlNOZoM4XGtU9Ks9L7BsCti7pVCmJhQSRWU6ifYxXY+dWkQ4kFG40MZLJOfjF058eyz5jJazet8HBJ4XgBrHGopbkarn1kRriW7lDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783587347; c=relaxed/simple;
	bh=gG5esoFveftpL2Ei16b4Q7xCuUBAkeaWjoF8W29taSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdMqciqgNVS2oSkrQrZmHqUPP677S/lm/tYReiqqxlLAI26xi7fl5VnlCjZaa37FuzWI/tfyupdKHVU5uSCW4ePN+Efhjwteublpp1P63fXyuLUnXQvnz8+5MCufXBtGEl2YME0UyC/aLdLmhVfOnfzcqjl6uERW6L6P9jganSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QHsBujKL; arc=none smtp.client-ip=74.125.224.97
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-6649ffb1d01so2293336d50.1
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jul 2026 01:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783587345; x=1784192145;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gG5esoFveftpL2Ei16b4Q7xCuUBAkeaWjoF8W29taSc=;
        b=PE4HXmnlY5NqLMvImldNgrTvcXJBJdyvHxeOzNtrDBb7T2FjJFeCbTegc+VKC1tl3g
         XesbOIx9crcKwDa3//wHKYrW1QtT8gWp08hGmAXIWQv42wb3GqYUUuoB5qjoJoGY8LqN
         +r0sXHF3dAUnzNnCiAwFLi7E/GIyTbt795BFSSjA14mMQx/N4SxmmkEXu0SNlA/mIiu1
         RWbQ3BWWWp9CMa5OD9xivjfGvYYY25uFPJh4NMvvnXep9Kwo2M+/zBlnMZbwXwegBKtc
         vmpVomfN/mYwpBCBtdY/A58D5q7Wl1DlCGonHzwJWyTkABAcuVyNoSiJPx0f93qwYZyR
         x0YQ==
X-Forwarded-Encrypted: i=1; AHgh+RoGLRHfQt032J1R552GpzhG2lAY9UbOIVLVySRxp5LKl+4ENkzl87Gj1zk60V1XVKycBwKPkgyAhztL@vger.kernel.org
X-Gm-Message-State: AOJu0YzGU4snzZVbzfyOWvT7Aq4XeFeS1hBz/nmRtC5tcoXaF76IX5ir
	sm4EeZgtAk78SGbaPaA+ViNWnmsQ468GbLR1Cve6eTP5AkS9Vfa0n0hAW91bDLTQ/lZwrmoiEKH
	CgrD+eo/hP6/Ryk35+uzca1XwbR6KQVMVaTAfY9VQrcdQ4/yiDrIdYs8694hAnujEZVC+S4CjtV
	6agQUGWumf0l6iBlrWocSdjKhk7UYqHKtGMSDi7Zvj5IWKh02V+/Vrir22GYqZXRG2pFs4EX81d
	n00eGVUEstPl7kOlAg9hPS3BKuY8g==
X-Gm-Gg: AfdE7cldV2H286NI4SvRw7TEhKSMS4cmrEoZ1jcuEgm4Vr0R5GoIvlgx6ls7dlyKGT/
	ScYaJwp+9pQiUdoNicDpLetF1cTJWITtu+xODCMowAiUcy+QUrZittg6kwp9s/N3ayqzqWDm/NF
	i1tq3AsI4HsJ+xkKzjM4y+H3nRUKHrkRIy3hP6dkBviaVia+y8t+/NcT/aFFHGAE/e++Gw7Js9p
	HAdxWAXoHlVTzKV1Nj7lcO2yTTcf+Jg00/cd3bHfAX5gvFwVJkjnVuVOzkV82cEam031jg6XRkm
	awtfDfxSIpNWwJEJJMZpsr+htUIUKstlaTL2MvA2J7J6+e94EEHTtVbZmpueu3gZq6RMKVEFaVU
	PzUDmc45V3O0eL/nycnlhgJaX/F5mnsGCjCqABKHSNbubR+FH6zw/fpuXnVBIp0umzaPGov5Mny
	st87PnP1JtaCMCVExbD7dQ0pJ+iby/gcWlCvCdl4m8zLOM7LtTjoB9R1a3M6s=
X-Received: by 2002:a05:690e:190d:b0:667:9f48:d6e7 with SMTP id 956f58d0204a3-6679f48e5b6mr3957773d50.93.1783587345354;
        Thu, 09 Jul 2026 01:55:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-667879bff1esm376709d50.18.2026.07.09.01.55.44
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:55:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8482fd61e83so2874476b3a.1
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jul 2026 01:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783587344; x=1784192144; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gG5esoFveftpL2Ei16b4Q7xCuUBAkeaWjoF8W29taSc=;
        b=QHsBujKLUdbx3CRNVMTlX6nKdN95h+k8FcuPpBk/GCk+kMkbvlXEGbXWRQHEnsGVJU
         ZYxtH8vmT1OKrBDIWp9a9X5U7RyqU265s3mAAoVRFJuXfjWIN9gqIOn8kmhJVR+tvweH
         BR7cMQhXjZB1mPIO1L1Iz6Z42KLI6rzy2TTWo=
X-Forwarded-Encrypted: i=1; AHgh+RosPry8dLBgW9KpoX0JBRvQcgmQaWhNwV/2MEI833JGh8sWpPhxdPhbmqbJGbCH592aAD1vJqzEsIw4@vger.kernel.org
X-Received: by 2002:a05:6a00:8f0b:b0:842:708f:39be with SMTP id d2e1a72fcca58-84842fdf097mr6328551b3a.5.1783587343867;
        Thu, 09 Jul 2026 01:55:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:8f0b:b0:842:708f:39be with SMTP id
 d2e1a72fcca58-84842fdf097mr6328534b3a.5.1783587343472; Thu, 09 Jul 2026
 01:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708-clean-init-one-hfi1-v1-0-b9e9641268a5@nvidia.com> <20260708-clean-init-one-hfi1-v1-1-b9e9641268a5@nvidia.com>
In-Reply-To: <20260708-clean-init-one-hfi1-v1-1-b9e9641268a5@nvidia.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Thu, 9 Jul 2026 14:25:30 +0530
X-Gm-Features: AVVi8Cdm3SDfpMuK1vS4XvsGjWm-jGQnW6OeicGkTSCRj3LKFiqsfpLsCZle4T0
Message-ID: <CAH-L+nOUaW5rG1JF3Yfk1RC-=U7Yz1qVJGd8qB+=oQtYomoJLA@mail.gmail.com>
Subject: Re: [PATCH rdma-next 01/13] RDMA/rvt: Return NULL after port
 allocation failure
To: Leon Romanovsky <leon@kernel.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Ira Weiny <iweiny@kernel.org>, Doug Ledford <dledford@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>, 
	Mike Marciniszyn <mike.marciniszyn@intel.com>, Sadanand Warrier <sadanand.warrier@intel.com>, 
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>, Dean Luick <dean.luick@intel.com>, 
	Sebastian Sanchez <sebastian.sanchez@intel.com>, Jubin John <jubin.john@intel.com>, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dennis Dalessandro <dennis.dalessandro@intel.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000145360065629cad5"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-11.26 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:iweiny@kernel.org,m:dledford@redhat.com,m:willy@infradead.org,m:grzegorz.andrejczuk@intel.com,m:mike.marciniszyn@intel.com,m:sadanand.warrier@intel.com,m:michael.j.ruhl@intel.com,m:dean.luick@intel.com,m:sebastian.sanchez@intel.com,m:jubin.john@intel.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dennis.dalessandro@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kalesh-anakkur.purayil@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22931-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kalesh-anakkur.purayil@broadcom.com,linux-rdma@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E0A072EA97

--000000000000145360065629cad5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 4:21=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> rvt_alloc_device() deallocates the IB device when its port array cannot
> be allocated but then returns the pointer to the released allocation.
> Callers treat any non-NULL value as valid and dereference it, resulting
> in a use-after-free.
>
> Return NULL immediately after deallocation so callers can propagate the
> allocation failure.
>
> Fixes: ff6acd69518e ("IB/rdmavt: Add device structure allocation")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>


--=20
Regards,
Kalesh AP

--000000000000145360065629cad5
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
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGtzCCBJ+g
AwIBAgIMEvVs5DNhf00RSyR0MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNDI1N1oXDTI3MDYyMTEzNDI1N1owgfUxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEYMBYGA1UEBBMPQW5ha2t1ciBQdXJheWlsMQ8wDQYDVQQqEwZLYWxlc2gxFjAUBgNVBAoT
DUJST0FEQ09NIElOQy4xLDAqBgNVBAMMI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20u
Y29tMTIwMAYJKoZIhvcNAQkBFiNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29tLmNvbTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOG5Nf+oQkB79NOTXl/T/Ixz4F6jXeF0+Qnn
3JsEcyfkKD4bFwFz3ruqhN2XmFFaK0T8gjJ3ZX5J7miihNKl0Jxo5asbWsM4wCQLdq3/+QwN/xAm
+ZAt/5BgDoPqdN61YPyPs8KNAQ8zHt8iZA0InZgmNkDcHhnOJ38cszc1S0eSlOqFa4W9TiQXDRYT
NFREznPoL3aCNNbDPWAkAc+0/X1XdV1kt4D9jrei4RoDevg15euOaij9X7stUsj+IMgzCt2Fyp7+
CeElPmNQ0YOba2ws52no4x/sT5R2k3DTPisRieErWuQNhePfW2fZFFXYv7N2LMgfMi9hiLi2Q3eO
1jMCAwEAAaOCAecwggHjMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcB
AQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQv
Z3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2ln
bi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAy
ASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNv
bS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29t
L2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwLgYDVR0RBCcwJYEja2FsZXNoLWFuYWtrdXIucHVyYXlp
bEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAUACk2nlx6ug+v
LVAt26AjhRiwoJIwHQYDVR0OBBYEFJ/R8BNY0JEVQpirvzzFQFgflqtJMA0GCSqGSIb3DQEBCwUA
A4ICAQCLsxTSA9ERT90FGuX/UM2ZQboBpTPs7DwZPq12XIrkD58GkHWgWAYS2xL1yyvD7pEtN28N
8d4+o6IcPz7yPrfWUCCpAitaeSbu0QiZzIAZlFWNUaOXCgZmHam8Oc+Lp/+XJFrRLhNkzczcw3zT
cyViuRF/upsrQ3KY/kqimiQjR9BduvKiX/w/tMWDib1UhbVhXxuhuWMr8j8sja2/QR9fk670ViD9
amx7b5x595AulQfiDhcN0qxG4fr7L22Y/RYX8fCoBAGo0SF7IpxSukVsp6z5uZp5ggdNr2Cq88qk
if7GG/Oy1beosYD9I5S5dIRcP25oNbcJkbCb/GuvWegzGfxCCBuirb09mTSZRxaBmb1P6dANmPvh
PdqGqxfFrXagvwbO15DN46GarD9KiHa8QHyTtWghL3q+G6ZHlZUWnyS4YMacrx8Ngy0x7HR4dNdT
pqAqOOsOwDmQFBNRYomMdAaOXm6x6MFDnp51sIWVNGWK2u4le2VI6RJMzEqLzMZKL0vTW+HPqMaT
hWv2s5x6cJdLio1vP63rDxJS7vH++zMaY0Jcptrx6eAhzfcq+y/TkHJaZ4dWrtbof1yw3z5EpCvT
YDxV0XFQiCRLNKuZhkVvQ8dtmVhcpiT/mENrWKWOt0DwNEeC/3Fr1ruoyriggbnRmBQt1bC5uxfv
+CEHcDGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1FIENBIDIwMjMCDBL1bOQzYX9NEUsk
dDANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgOfBfO/VscBKyAvvEvwRLmk88bzIR
QZCGFEyIBS1m+UwwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
NzA5MDg1NTQ0WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAWzcTGaUJNKUxPV9FIJsY1It+MYVpLQrvWlxute0xOyBqk1A2bHnbaQ0aL6bGUWIM
OF/t1AvpSWPul+WBapWys4xBqB2SLP7WSISnnD5dF+zyoHCDg0KHRy6mWagY62h3zHCsnbHHQCZj
LQb7+DXgp14NbuITUFJDfUi1ea0rJczxR9xCodJRdU9CXpMsR4Ebr/5XRRIRVxGOJNh8jKowb93F
ijKw3kE7O2fha12u+Zlf53OfgTV2Xdim6gXC+9nuEHrD1+kTvwrnIHTxx6E7gJdRE74a5slbWeoV
nERt8ET6l+LYvtfcHvZG0Ic/MLzmUKntNu21pBQ2jNVCyRI60A==
--000000000000145360065629cad5--

