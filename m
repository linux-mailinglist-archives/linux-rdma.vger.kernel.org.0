Return-Path: <linux-rdma+bounces-16649-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOIfMIrchWn4HQQAu9opvQ
	(envelope-from <linux-rdma+bounces-16649-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 13:20:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E071FD8D5
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 13:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF70B3021E63
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 12:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4492EB67A;
	Fri,  6 Feb 2026 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hQtzVZf7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAB830BBB8
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 12:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770380424; cv=pass; b=mjDAameprdLxNP4bON5H2ny/THCeLi5Zzl6im2fblF6F3vBuF8uavM++A5cv4soJY39huF1C5+tt6XsenHgcev2G785cOTaROraGMOVDDBDW6Z5GHVAiM/R+IICG6jhrF2QJvprXxbMXLnHS7vixpVyt3WFCrCJUdGJkGbEsH8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770380424; c=relaxed/simple;
	bh=LQU8HZouoilr0XeqRxLbYC9ja5Drx1Ni10YOpHd04Nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5C1PA63LV2Td2/9cXOx2Yy3Jk8GCfMELHUaU3uXnMeew8+A5EnswUvz9Qk5cqBLpDvqq3rgejKwt8vMN6ad4PNLvR5ilRet1uSp0P1JuoIaesW7GUpd+TxUrhwDmU0qUuXz9ekckV4LJjWD/157ZrAlunu56sC1B9wmt9BuAA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hQtzVZf7; arc=pass smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so109208a12.0
        for <linux-rdma@vger.kernel.org>; Fri, 06 Feb 2026 04:20:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770380423; x=1770985223;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIB6ubAoabB4y/RkoI4lamfjd+DfqTQFSzkCWuy5VXI=;
        b=OF6eY6sge4acdZVqS/CYmxthNvRVHsLMmvCH5T1yje0jIVMgwpCAPjDefNF9qK/fJR
         dTTLHKz/bTMDowpGJ51hGBEJBgZLMDUrfn6pkkr7dkbJyS79Dw1VqB9hZR1TTlfUPiLV
         wFbbgIR/3BWO2YJmhmZgCZ0U0GLYYaRFqKsyN6LzECtltreWa9Jt0x/bN4yT5LOBY5BM
         Ihuxyl5csoD3bNzetgRvPnW4G6WZBZF/0wT/YRDoZLn+xKB9CkIXoVIViU3eYade5em0
         HhCVH1M8Bio70ZUmeOrhgZTHP2EbcbhMhmWM9riNmnrfbANviZ5WpYYug9kF9hhqp9Mk
         sgXw==
X-Forwarded-Encrypted: i=2; AJvYcCVhaIB89i9Vssaa4V5FxBtKjR9v3EuSfDfMU0rt3doTDkAaq1qA40Nb8d+OxCl1zYCPKKYr8IaF4zPX@vger.kernel.org
X-Gm-Message-State: AOJu0YyHWPEpA/y2lB6KczabdMmVPkzIx2E/LfGFhxerjJaRUC8ZH3Hz
	gl4m2/ZsVB1frN6948OSt9S6CdxQk099pxkDcxhRvyPhHLPtvpBkAVXP8eu0qntRXb0UUR/7JxK
	YVRgDBSTgWpOPl8JitUj11xHTC7vM/+FIRzc0ObU1u+X03Xc6ueYJW0p+9lnt+i22wf2P2548QD
	/whIqN/CC8w6B5h2ypZ4P0OI90sTZT/fIyIzB9ZhSiqCCqGm3+A3CYOs1tkNNxQW+nblfb07ikO
	qBcMsk00dKuWZKgliHM6gRXkuKy
X-Gm-Gg: AZuq6aKPKl0CiqBIzkH+obJdloHUbtL46Y2hxSQTA/k28rq645Bkd9ZHbApKwS12Uut
	gouK7iD7HU7b01wWMTRz7Do1YWnEwFY1QH6dCEdvRTpjL757eVrWmshoEehTSiUmigu3HN9Jozs
	CHw4SzLaXVIJCRx0lQmgeZ6ZyeSTDBRzfwKMRDWhZxKeqTCvqHe3d1MJh8U3Qr+5jiP63W8nTiL
	a/XRIpotASoBWiWALPzRfeCOKdwlzu+GVIXuRbIuVBVr8Yg0lAibTN7cgHLn/ylLfD2xYoKkRRT
	H3+07elAQ4nZVM6xnmVPtEGQOpsncilgU1YkIBsf0CenNwPgnjVB3oxO2MdOgGkj3F3Q6aroqh5
	OlGt8VyDKMqXafVkre/B7APyeFi+JfcIEA22UN7qOw2/Mc65hTtOQO+b5vrS6pAYhxXREAPTX7q
	VqrhfvbcAn2xP1LOCUFCM3D18AiPVc+KveEIKR3mZxFOVA8VEwAQwU0A==
X-Received: by 2002:a17:902:cece:b0:2a9:48ce:fbb9 with SMTP id d9443c01a7336-2a9518161dfmr25958535ad.41.1770380422832;
        Fri, 06 Feb 2026 04:20:22 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a951c6cbb9sm3397265ad.14.2026.02.06.04.20.22
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Feb 2026 04:20:22 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4803e8b6007so21855195e9.0
        for <linux-rdma@vger.kernel.org>; Fri, 06 Feb 2026 04:20:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770380421; cv=none;
        d=google.com; s=arc-20240605;
        b=S3UJjCmUkxfesYfZ6FNrg6C3WhiMRz8ZBARiVO2khzAE4wOhOxeijpS8CxzbE13FG9
         Bk2uekN6zrZYvVTwxGuLE7so85+Ut1Eo9kWzBG3Ka14eM94g14JrNEHZD2VxLH2h5gfp
         RQrzKQFKjioSKJCrvhlQIqNC2McbaW9faDJO46PWCHI4D9vL4LZPu1XYbJ/qdA9yV4b4
         G1ycZvEdxK00A6MwhCnxVH2ZkUULD2VJ8fwfpZ8cQ7yXNHXsaSjbxlaixupuQkGbuZvk
         63/CZpnxkRMC+fWTBaET6BI28Rsy5/2xRDqxpEEeHYmEbjLybD90Iem0oV+8lrPOp6Gx
         89lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tIB6ubAoabB4y/RkoI4lamfjd+DfqTQFSzkCWuy5VXI=;
        fh=Yl7hYCEgACjFB9Rf2M8/DhkstVqxIMb+uey6rB8elfY=;
        b=FvudmMxsyrmaRLUkSMxfqr0UX2+LGyUoR66vNEhpd1qGYJPZI5h5GvSY72u7J8MQxq
         LRLp9+jdbLWr30B7a2IvPj6oPhwx+QGTvOLL6cS6JJyG7LyLS3ZYVI7TCKYM8nddGe2p
         lk4ointLhBPdzMtMb/IAG+gBRNRw2+jfexYcGhrVD5pQpaMG5gk20kGRmJBQpaMEZwP/
         Ni6EzyYiTzPXMrqzaHHaIropGQJJtvhXIUQS9Lm3LmV7/CSEEbO+yAWdGpUskjyrGPyl
         cau9KEMSIE9Sq1qEI+CxO0HCy8N3lbjDoVakDq8T1QPo16u79fDd2W9fNHSQ164P4P8L
         1U9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770380421; x=1770985221; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tIB6ubAoabB4y/RkoI4lamfjd+DfqTQFSzkCWuy5VXI=;
        b=hQtzVZf7HCpF9TGzO/XcG+I8bwvuH+8YvzWWPkhpf9PVt+NXP3/L7wNWZwtunjyjp3
         ilbjZk9J2GeHU5iowmP/blf9J7SS6MYqD81OvP5QVsYu1WA3z+HnCJqpJP9jOUCBL+p3
         KSxq4QHLahlxcnHJXFvu5gjfHNs9poBTXvBg8=
X-Forwarded-Encrypted: i=1; AJvYcCWWg7V2gw+biqC/gL6VbiXZzKs6G78fGjmjKup0x/hntbs/wWNBjZyN2h7opegIwnlPbwajzhf8vQhb@vger.kernel.org
X-Received: by 2002:a05:600c:1387:b0:47b:deb9:15fb with SMTP id 5b1f17b1804b1-48320229ce6mr41483075e9.33.1770380420567;
        Fri, 06 Feb 2026 04:20:20 -0800 (PST)
X-Received: by 2002:a05:600c:1387:b0:47b:deb9:15fb with SMTP id
 5b1f17b1804b1-48320229ce6mr41482665e9.33.1770380420110; Fri, 06 Feb 2026
 04:20:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Fri, 6 Feb 2026 17:50:07 +0530
X-Gm-Features: AZwV_QiOstocTtD1A7zQmEpj2xAVTA0JLrJ2Pjm6bSBFQ0ReYlaFPkCh-BRSpps
Message-ID: <CAHHeUGWw221yuH7Ac8hbsVc+dMBC2GDnPZMmAjKMdu36wkY0Zg@mail.gmail.com>
Subject: Re: [PATCH 00/10] Provide udata helpers and use them in bnxt_re
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, Leon Romanovsky <leon@kernel.org>, 
	linux-rdma@vger.kernel.org, Selvin Xavier <selvin.xavier@broadcom.com>, 
	patches@lists.linux.dev, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001d183a064a26d0f7"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16649-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 1E071FD8D5
X-Rspamd-Action: no action

--0000000000001d183a064a26d0f7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 7:15=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> Add new helpers that entirely execute the expected common patterns for
> driver data uAPI forward and backwards compatibility so that drivers don'=
t
> have to open code these.
>
> The helpers were developed by looking at the entire tree and moving every
> driver to use them, but this series only converts bnxt_re as it has a
> pending series to extend the driver data uAPI and the lack of correct
> compatibility handling will be problematic.
>
> This handles both the request and response side of the udata using the
> following general rules:
>
> 1) The userspace can provide a longer request so long as the trailing
>    part the kernel doesn't understand is all zeros.
>
>    This provides a degree of safety if the userspace wrongly tries to use
>    a new feature the kernel does not understand with some non-zero value.
>
>    It allows a simpler rdma-core implementation because the library can
>    simply always use the latest structs for the request, even if they are
>    bigger. It simply has to avoid using the new members if they are not
>    supported/required.
>
> 2) The userspace can provide a shorter request, the kernel will 0 pad it
>    out to fill the storage. The newer kernel should understand that older
>    userspace will provide 0 to new fields. The kernel has three options
>    to enable new request fields:
>      - Input comp_mask that says the field is supported
>      - Look for non-zero values
>      - Check if the udata->inlen size covers the field
>
>    This also corrects any bugs related to not filling in request
>    structures as the new helper always fully writes to the struct.
>
>  3) The userspace can provide a shorter or longer response struct.
>     If shorter the kernel reply is truncated. The kernel should be
>     designed to not write to new reply field unless the userspace has
>     affirmatively requested them.
>
>     If the user buffer is longer then the kernel will zero fill it.
>
>     Userspace has three options to enable new response fields:
>       - Output comp_mask that says the field is supported
>       - Look for non-zero values
>       - Infer the output must be valid because the request contents deman=
d
>         it and old kernels will fail the request
>
> Since bnxt_re has never implemented these rules correctly and now does,
> provide a UCTX flag to tell userspace about it. If
> BNXT_RE_UCNTX_CMASK_UAPI_COMPAT_SUPPORTED is not set then userspace must
> not use any request or response fields beyond the current kernel uAPI.
>
> Using any new fields is only possible on kernels with the flag.
>
> A series converting all drivers to these new helpers is on github, I will
> send it later:
>
> https://github.com/jgunthorpe/linux/commits/rdma_uapi/
>
> Jason Gunthorpe (10):
>   RDMA: Add ib_copy_validate_udata_in()
>   RDMA: Add ib_copy_validate_udata_in_cm()
>   RDMA: Add ib_respond_udata()
>   RDMA: Add ib_is_udata_in_empty()
>   RDMA: Provide documentation about the uABI compatibility rules
>   RDMA/bnxt_re: Add compatibility checks to the uapi path
>   RDMA/bnxt_re: Add compatibility checks to the uapi path for no data
>   RDMA/bnxt_re: Add missing comp_mask validation
>   RDMA/bnxt_re: Use ib_respond_udata()
>   RDMA/bnxt_re: Add BNXT_RE_UCNTX_CMASK_UAPI_COMPAT_SUPPORTED
>
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c |  84 +++++++---
>  include/rdma/ib_verbs.h                  | 185 +++++++++++++++++++++++
>  include/uapi/rdma/bnxt_re-abi.h          |   1 +
>  3 files changed, 251 insertions(+), 19 deletions(-)
>
>
> base-commit: aace79adb7196a02ff45a334839a4d31a0e262fb
> --
> 2.43.0
>

Thanks for this patch series. Patches 6, 7, 8 and 10 failed to apply
cleanly, due to conflicts with the recently merged QP rate limit
patchset in bnxt_re.  So please rebase it.
I applied this series, + QP-dmabuf devop patch, + bnxt_re DV series
and tested it.  It worked fine.

For the series:
Acked-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Tested-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>

Thanks,
-Harsha

--0000000000001d183a064a26d0f7
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCC/bSBRkxztnbzlWU5j61igsX1cm8DH4Lri
0VNq1MoHSjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAyMDYx
MjIwMjFaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQB4UGzRw5H/KbXk9rOkGQw3xUtHgLpbtvWTSz7bgPfkPH/UtDr+5XDmaiwetb+PsWur5Ii5
T8/GcRmivrQnqYqYeVcWVmek9VDCeVtJNbjRNnulMBPZ7JthMFIZ90dMYvV+pniw9MMb575uGZCz
V48q60Xkj+LhSAD95S7a3FErNuWyZBdw11GeUUun2nhHjdLvCeftEr8NueJ2OU9GF1gqU3vk9Ajc
WBsXEh3wfs1ZYXO5RRphJ/DwEhihiSCKE70uK4w+N24I7wMbtv3YRz0cQo9Gmn0+oiKtNll8sNo2
+Po733iHoHtDFe/kVaKyQydOxA5xnGyvjzbOzpQL/rEU
--0000000000001d183a064a26d0f7--

