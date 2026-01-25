Return-Path: <linux-rdma+bounces-15954-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3sEuEVmZdWmPGgEAu9opvQ
	(envelope-from <linux-rdma+bounces-15954-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 05:17:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3997FBFB
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 05:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E728930099A0
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 04:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857C91D8E10;
	Sun, 25 Jan 2026 04:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VtMnFyCb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D513D521
	for <linux-rdma@vger.kernel.org>; Sun, 25 Jan 2026 04:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769314643; cv=pass; b=KsE7rJMV1rfB/30h7dfmZraShRHzgwcaquObHkfLz1P3DibkzH64WkxYpeUXMscj9AIcXUek6CDKIILXE5h5m2ZzM1L9KwWQpVUI8wK4OuEltzL12SlPzXJzl8GaW2CmH4OnzAGJq5EaR71Psi/7jIaRUFL/q8gCbqZATgI0iU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769314643; c=relaxed/simple;
	bh=BQRRvG0QZOJbXK1+v9tWtL4ydL5oJQGU4QBqITXv2Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sg4OlIFB00Hz5yQTB1M3FDw+f3CqGDDcJwtpXRubO8P/pzG9Gn8giaS3YUNfF7iEigrc9q7wA95keYwPYf1rpIeIARC66+aApKKcUhYTz3pb3fj2hnR1l3buPshShPWZozFJOn1cSKN7PePAmgeBa+AjhkNE25x/NXK563kPh14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VtMnFyCb; arc=pass smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-81dab89f286so1719531b3a.2
        for <linux-rdma@vger.kernel.org>; Sat, 24 Jan 2026 20:17:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769314641; x=1769919441;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEHcPf8zixusA64VYVD3uGBzcmuimi+wNCHGpx1qB4U=;
        b=R5iNjI0wG1IPD7zW4+4KXWzHjINMT4xn9uZfYXvD2fXRplmQXRthANeJlbLNgVauJ0
         79ANKho6LqJSdBS/ybQQR45zEDsi+xkVf+Vb7DNadKT+ndA2QhF1EwcLmHiFaME8vKTi
         TLAi9gPIAeUuguc9ibTweMnAqPXrL/+r/TMy4N7RgbJmZqY5AJiqPFKEE34jx/9tW26E
         YhdKHaMlwZ9NuFF1CBiaYYjmRad3AFxM0gRSvo/sSWaQU6YQn7lnv7Xyb8JEJbZX0LZz
         DX+90SpwMYIcPn6WpQfJVO3oBtZ8yMk5L2m0RCYblpK1KjDObEkAxOhxn66iXsZWZMg4
         l5pA==
X-Gm-Message-State: AOJu0YzWOPPhSt3GGn6845GrkJBbvwtYSwZPvK5Oiv8L0ppKy1TTmA14
	6EhxZY9OdeHCjpghBTFIvAxfJZwG6TcBIDuJtgEMuvO6hSclStk4U7Tmiwt/uUwbYtRZ1lxqKqg
	snlypSzxRNF8cogIFijbQi0e+g+S3ZQrbWcZTVlfZn4lnR+BqYT84SVJ+OJCfKmKiA1SBIJX4Fi
	LOHRvaafQCSgSIYKKRn/3A2Aw4EL/yLVpzg9UfLjOEWqkym82paDcsulTdEti/DwaNAjPis5f4x
	dH/CfPNXMMj8tRue4zb1pn6OAZzVQ==
X-Gm-Gg: AZuq6aL4o7LYFgIA5qoqq4T+fB2/Cxg/c9vZma34vIKZX/kAOyL3zM71ekLd1a472uy
	IV19jrWpmho1xRCSxnnlaQuuwtHcmS8ExQJVkaC37cNza0RmHxkGZjd1uagCBfLZOOoOVtWY/Fc
	lMaxRJTi4hIx4ua6ElqBUXYgMiC62lk/mc3BQb/C3UbFhPt/0Dd6s1erACJxsnsLWEAuEgi4Nax
	6rGq8JFyoOGAlr/RtBpgi9HT5TCebqK5rKAIqZixJhxrxepjBmDD0EUFiIERicFitFJsj/Vzzae
	ZuOy6n+fNpGUSTQeKkV3qv/RwKHXByY5aJv52E/p17Bpg/ko3B0JsGWtj5klGr3Wv9qk9Azr1UB
	fWHpjQhCTcelBTQ9hvO4Oyj7vzh+NPUOV2E6mciEAN5bf45kXKAICqwtwSR+rFcAoyLm0FQHhKU
	6Z0I3GqrCG7WXQMel6S8G/jH/m0x7a5mXGFaJQY/O+Nede0YzHh71AlSSP8w==
X-Received: by 2002:a05:6a20:1604:b0:35d:d477:a7e0 with SMTP id adf61e73a8af0-38e9f0f3e6bmr509513637.15.1769314640651;
        Sat, 24 Jan 2026 20:17:20 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3536dc430besm827625a91.5.2026.01.24.20.17.20
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Jan 2026 20:17:20 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-352e214cce9so2450500a91.1
        for <linux-rdma@vger.kernel.org>; Sat, 24 Jan 2026 20:17:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769314639; cv=none;
        d=google.com; s=arc-20240605;
        b=h6Pg238ykyVqKRRTR3XpglbYtfuMcC3xOtKGQNpObpnnJrcni0EAkpZo8MPISCWJ3e
         d6yjc8D/pfKIXpNTeNT5XTXYW362U3QUwyVlc0NIFHk6A98+5/SsUpH+vN4Eb159aSHu
         ZkwydoyKTOH70+wyA2FA87uhNZk7nZjfQI0go4mLVn4ypGOEEgRjbCzGWsBlo3XH1ykj
         u0LJ9T9ju2HrZOrBi1IN5YaiF4/le9pHoW5nSEkDcs3CTjMggIMKzdFNKKFtak4gjL0t
         ETNYefKbDDOStkmETG9CvD4FHwxAHOTUjMNwPynO702eLH0ZFinZ9XDNoXrelxrEWvDX
         SqIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wEHcPf8zixusA64VYVD3uGBzcmuimi+wNCHGpx1qB4U=;
        fh=kDvYLeFL+lhH/XXVw9HnMZf+Rf28AQoAlh7XhmqrzAk=;
        b=GT7tt2qsuF3e8/vDvQFD5FS/TSMFYWbhebgVnk4AVEhPTGt0uN5Ba8Hfv+O1BbTt4M
         vjNJJICchWXjm7yLbttfSudfFLyvGozaIHTDgahmoyj1lTfCkzYtyjmLIdJoH/ETK8uw
         YNJAVkCryrD52ATqPYBPu+XBjJPE78dI1LeEX1Bbx+caj34BixvOdtTsHXhz2BTkl6qn
         cNWO1Rf2lvIveCpAUBcFtZghQx53PA/11PqGMaUtxKdKavXOKdhzJ9p/PBO21mPVQeGJ
         qHEmThsfaxgMjEEJnHv8a7FEL+SI4WSOVXp6KnoiFleNIP5OzjIyfvQqca9ewzJmBaXJ
         aP6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769314639; x=1769919439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wEHcPf8zixusA64VYVD3uGBzcmuimi+wNCHGpx1qB4U=;
        b=VtMnFyCbQ4wnu/wz9jP+2ipHlRAD6nifxqkL5r/17D/WWqDOpJo9xZFj1uiA5zX6pu
         a1m/6BT2SFbsfOb642ikJjHBOvCOFiXZPBNtmEm4ZUeeN14KsQ6z9hWR+EXJRmRInrgL
         JRJXQAmrCdMvwHYeUFfu0QVSDvXGnNMvA+eWQ=
X-Received: by 2002:a17:90b:3f4d:b0:34c:3501:d11c with SMTP id 98e67ed59e1d1-353c41ad3d4mr619862a91.37.1769314638716;
        Sat, 24 Jan 2026 20:17:18 -0800 (PST)
X-Received: by 2002:a17:90b:3f4d:b0:34c:3501:d11c with SMTP id
 98e67ed59e1d1-353c41ad3d4mr619857a91.37.1769314638337; Sat, 24 Jan 2026
 20:17:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116091808.2028633-1-kalesh-anakkur.purayil@broadcom.com>
In-Reply-To: <20260116091808.2028633-1-kalesh-anakkur.purayil@broadcom.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Sun, 25 Jan 2026 09:47:05 +0530
X-Gm-Features: AZwV_QgGcfsMTnhl4LiJa9oPVxUVuvJt2z_-fS6uRTPkvfHDmMbJuJna48HWwYc
Message-ID: <CAH-L+nNFR8broz0i6ddQPrGL38AO1ZVaSRdXe9AcEafT3Sqeaw@mail.gmail.com>
Subject: Re: [PATCH rdma-rext 0/4] RDMA/bnxt_re: Add QP rate limit support
To: leon@kernel.org, jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	selvin.xavier@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008f1bb106492eaa45"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15954-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kalesh-anakkur.purayil@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8A3997FBFB
X-Rspamd-Action: no action

--0000000000008f1bb106492eaa45
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leon, Jason,

A gentle reminder. Could you please review the patch series?

On Fri, Jan 16, 2026 at 2:43=E2=80=AFPM Kalesh AP
<kalesh-anakkur.purayil@broadcom.com> wrote:
>
> Hi,
>
> This patchset supports QP rate limit in the bnxt_re driver.
>
> Broadcom P7 devices supports setting the rate limit while changing
> RC QP state from INIT to RTR, RTR to RTS and RTS to RTS. Or, once
> the QP is transitioned to RTR or RTS state.
>
> First patch adds stack support for rate limit for RC QPs.
>
> Second patch adds support for QP rate limiting in the bnxt_re driver.
>
> Third patch adds support to report packet pacing capabilities in the
> query_device.
>
> Forth patch adds support to report QP rate limit in debugfs QP info.
>
> The pull request for rdma-core changes are at:
>
> https://github.com/linux-rdma/rdma-core/pull/1692
>
> Regards,
> Kalesh
>
> Kalesh AP (4):
>   IB/core: Extend rate limit support for RC QPs
>   RDMA/bnxt_re: Add support for QP rate limiting
>   RDMA/bnxt_re: Report packet pacing capabilities when querying device
>   RDMA/bnxt_re: Report QP rate limit in debugfs
>
>  drivers/infiniband/core/verbs.c           |  9 ++++--
>  drivers/infiniband/hw/bnxt_re/debugfs.c   | 14 ++++++--
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 39 +++++++++++++++++++++--
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 12 ++++++-
>  drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  3 ++
>  drivers/infiniband/hw/bnxt_re/qplib_res.h |  6 ++++
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c  |  5 +++
>  drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  2 ++
>  drivers/infiniband/hw/bnxt_re/roce_hsi.h  | 13 +++++---
>  include/uapi/rdma/bnxt_re-abi.h           | 16 ++++++++++
>  10 files changed, 107 insertions(+), 12 deletions(-)
>
> --
> 2.43.5
>


--=20
Regards,
Kalesh AP

--0000000000008f1bb106492eaa45
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
dDANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgZPTdMiUsC3x6j8z+7lYAI325bRnR
7NF1c+K5WjFR5SowGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
MTI1MDQxNzE5WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAd2TuSJ/VbZ9YzbDveaa92iEqkpiXCamR5ZGjhFeVAdcZDf2VgqfnYzh8urRaiejR
lZkpqyVw6mH7UejSIiR2kXj8qu40hDjNNwU1j5ER0cZ1EAEX0KjnsE1O6/Lc49C6ZTVPKQ6KEjnx
oDZnKkKKbun9tkU6euumyHKwcQkwGFEB5lrign1uuQRdw5wUeW93vlP+Qki/0EcOtxxQIVeRAeul
J0zwSK6nWOkib1h7+T0rqqL3//jVww60rbXVX0m+fOL9hpOzQvwjD27HKzDepONhI1EmnMsTNrOi
JygHoFc/rvrQgqvAHadt9gLFu78QdZostPm41zSfCtTWRD2sxg==
--0000000000008f1bb106492eaa45--

