Return-Path: <linux-rdma+bounces-20989-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KI4HeeVDGq/jQUAu9opvQ
	(envelope-from <linux-rdma+bounces-20989-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 18:55:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6325582B01
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 18:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 895CE3019838
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 16:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063E4367B7A;
	Tue, 19 May 2026 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TyKGqzhS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f103.google.com (mail-yx1-f103.google.com [74.125.224.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9A1367B60
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209692; cv=none; b=YLI0MQCb9uBXALaschyS2KcBgCPvZThZufo/zEvaYtrWBMLb4lR3QYU5fOix4dhyunniOnj5DCX0n61syzzV59d6O9dA6phNslVapYEi4LgYRFgq2Vb8Y7bpXDq90zs6cGwPHaAgo+Naz/YFr6C5ZvKbfpK80tgJKy5mM3Sta9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209692; c=relaxed/simple;
	bh=sdK7wAgwdAeacR76rSgu5hnakscrC6p/dsmspW5a5CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1ymHldb6OL4c44zgnHjMSbNrskq6WsSIf42Rfdo8v7/Kd641598w7oyK5Jlvdzr/mOHrE1cuY4JdueiYqT/MmbiujWyuNdLCFXzDWzkD3WR29LMxSa6rZVHsemHm0CzMLMGjfCDMu+F0G9klWolaV9oovYTcUz/yxsGycHKCFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TyKGqzhS; arc=none smtp.client-ip=74.125.224.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f103.google.com with SMTP id 956f58d0204a3-651d6347a69so5276006d50.0
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 09:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779209690; x=1779814490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKrNB1uujdPHIe3xG74TIQkvjle2/XZm0csTPwhSGcI=;
        b=ZGJOBHUrspOtHwSeHvkOfEqoez4f/hexIgTvBwHro8xzmIPjP746P23pUBgyRGpJgz
         Uz5/T50goNreiC7cHJZ2Vc3pqdNyIhryumMjKgNdWXt3WsP9ty2HR1Nh76qcmtC7TfCO
         nUncOSVZdMTLYd6yuTrdHBzZ3NAC7auewN2V80jAkegl9tH70PBIme0axa60tVpRfPuu
         e7gtqpZmOfcEnlwoSEt9tIf43mkLobPLQjQOLDcMeDW2W1eKtO7kysk8XoDNq2o5lmK7
         g8kndMrgKcLQSH6Cs+pnx2gkebYf4QsrnAWBcegGoHzWMG/R7TyAsCRiZhyyKuUzaEHW
         HQOg==
X-Gm-Message-State: AOJu0YygJ0KxmoWSbbs2m0BaliS4z3y8ir2QY3YE0IkQJC/AagiFTU7R
	qNQeggL/eeZhj8Yz3r8U3RXaIcT104aBookXinNLI3BHGNfUBL40yDzqobx6pVtpOfDNrAe4qTR
	XVvDF9dP8dY/YP1c0QWVj/21lve9LGlNbEALRylhmxKaLazLfdwWhDdvOm4ef6FKEwmiP9Okviw
	Fw+VUzRqX6lZoJdRK6f0vl6mzIbeIL31j5QDNuFw/CrUyLoQ5+/w2htscdC/1Reu3a7478UmYre
	xxVuRU2mgATbmGPLwu4/rwG2F22ZLU=
X-Gm-Gg: Acq92OGm32+m0lc/na/gr5qWE9O9HhQz82tt4xkpj6cBghG6Jb+StbQou0CHWrpaCSz
	9FH+md6WqhUZoyfqe1XlsU8VCqHJjtRlRFd0yKlCH/O8cyBg2D4ZaxBkNHXLIZh9Uzcg5Ib0iAB
	4i/DXmL2p4Rd/xkfPRnPewi80hCalVqbktMUW/Nc/PS9Gnl3bSVFw7HRaFDehykqJiScqpV7hqo
	0QOzy8O5IskqIO4e8q7foeG3MEO1g/+tbve2bJYStgWfXk1wpd/kNXW95o4cobhfV9NkrXE92Q9
	lo/GuN/MipgzO0y5W1A4IAgpSAN99C9xVMRfcVZikmgDcdzZAp/w67Gf0QagKLTXyCEjsnJkI2I
	VT0tBKDyS8T3PLNLK29MB2oBwmRqjGQ6/tqDp2Kl94+znjqXbJpfvEVC920aVQCk/zjc9KBKDDO
	p5PjYjrn5SVYJCwAhp8V4p1NYckn1CjUPz/+GM7aojfSd21Md1APYjfcU956rCtAXkJMzu
X-Received: by 2002:a05:690e:140d:b0:650:1c35:6f3d with SMTP id 956f58d0204a3-65e0b05745bmr19572383d50.13.1779209690138;
        Tue, 19 May 2026 09:54:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-65e0d892489sm1323068d50.8.2026.05.19.09.54.49
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2026 09:54:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4900f69197fso11529015e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 09:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779209688; x=1779814488; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NKrNB1uujdPHIe3xG74TIQkvjle2/XZm0csTPwhSGcI=;
        b=TyKGqzhSNrXS0W6Go7VqAGsf7WnIc3MxIVgHm+Ave1Hoo9iqlBvsAFTCey9YDHSq14
         V75bQDq4FHYNVRAN8ZZOq33RnXdQ7SIbZFlB64jaQ14TTUGCyXI85cn8J/654BkwMJVa
         dJBYEFgVkr9B+lgpSdeyfyLWhPOdaP57nMtwc=
X-Received: by 2002:a05:600c:5ca:b0:48f:e6de:1cb9 with SMTP id 5b1f17b1804b1-48fe6de1dd2mr197204345e9.19.1779209688534;
        Tue, 19 May 2026 09:54:48 -0700 (PDT)
X-Received: by 2002:a05:600c:5ca:b0:48f:e6de:1cb9 with SMTP id
 5b1f17b1804b1-48fe6de1dd2mr197204105e9.19.1779209688105; Tue, 19 May 2026
 09:54:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519150041.7251-1-sriharsha.basavapatna@broadcom.com>
In-Reply-To: <20260519150041.7251-1-sriharsha.basavapatna@broadcom.com>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Tue, 19 May 2026 22:24:36 +0530
X-Gm-Features: AVHnY4I4arA5o7p7iw8RcnenHU6_8GIUpyCqohxrVrdmhh-TPnPyNF7eepxeQLc
Message-ID: <CAHHeUGW4q6bVxHqk+YcTfLc7AEw1k4=m99m-7F1adMoeqgW7sQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next v7 0/9] RDMA/bnxt_re: Support QP uapi extensions
To: leon@kernel.org, jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007c84eb06522e8923"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20989-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sashiko.dev:url,broadcom.com:email,broadcom.com:dkim]
X-Rspamd-Queue-Id: E6325582B01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000007c84eb06522e8923
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 8:39=E2=80=AFPM Sriharsha Basavapatna
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
> - Patch#8: new driver specific attribute 'DBR_HANDLE' for doorbell region=
.
> - Patch#9: new comp_mask 'FIXED_QUE_ATTR' in bnxt_re_qp_req.
>
> Patch#1 Refactor bnxt_re_init_user_qp()
> Patch#2 Update rq depth for app allocated QPs
> Patch#3 Update sq depth for app allocated QPs
> Patch#4 Update msn table size for app allocated QPs
> Patch#5 Update hwq depth for app allocated QPs
> Patch#6 Enhance dbr usecnt logic in doorbell uapis
> Patch#7 Enhance dpi lifecycle logic in doorbell uapis
> Patch#8 Support doorbells for app allocated QPs
> Patch#9 Enable app allocated QPs
>
> Thanks,
> -Harsha
>
> ******
>
> Changes:
>
> v7:
> - Fixed an issue reported by Sashiko.
>   - Patch#7:
>     Restrict changes to DPI allocated by DBR_ALLOC(),
>     by using a boolean dpi_valid.
>
> v6:
> - Fixed issues reported by Sashiko AI.
> - Added two new patches: #6 and #7.
> - Patch#6: Support kref for DBR object (from v5).
> - Patch#7: DPI lifecycle changes.
> - Patch#8 (QP-DBR) requires these two patches.
> - Patch#9:
>   - Commit msg updated: removed unused comp_mask.
>   - ureq->sq_npsn validation (from v5).
> - Remaining issues are about lack of ureq->sq_slots validation.
>   - Existing code; will be fixed in a subsequent patch series.
>
> v5:
> - Fixed issues reported by Sashiko AI.
> - Patch#1:
>   - No changes.
>   - Issues are about lack of ureq->sq_slots validation.
>   - Existing code; will be fixed in a subsequent patch series.
> - Patch#2:
>   - Removed unused ureq param in bnxt_re_init_rq_attr().
> - Patch#4:
>   - Issues are about lack of ureq->sq_npsn validation.
>   - Validation added in Patch#7 fixes these issues.
> - Patch#5:
>   - Updated to utilize existing code for RQ hwq depth.
> - Patch#6:
>   - Moved usecnt relase logic to after QP is destroyed in HW.
>   - Avoids race with concurrent dbr destroy.
>   - Updated usecnt from simple atomic to kref based counter.
>   - This handles implicit teardown of dbr.
>   - Added kfree() of dbr.
> - Patch#7:
>   - Added validation of ureq->sq_npsn.
>   - Removed unused ureq comp_mask: BNXT_RE_QP_REQ_MASK_VAR_WQE_SQ_SLOTS.
>
> v4:
> - Rebased to latest for-next tree (Linux 7.1-rc1, commit: 254f49634ee1).
> - Renamed QP req comp_mask: APP_ALLOCATED_QP_ENABLE -> FIXED_QUE_ATTR.
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
> v6: https://lore.kernel.org/linux-rdma/20260518153721.183749-1-sriharsha.=
basavapatna@broadcom.com/
> v5: https://lore.kernel.org/linux-rdma/20260514162336.72644-1-sriharsha.b=
asavapatna@broadcom.com/
> v4: https://lore.kernel.org/linux-rdma/20260508085858.21060-1-sriharsha.b=
asavapatna@broadcom.com/
> v3: https://lore.kernel.org/linux-rdma/20260415054957.36745-1-sriharsha.b=
asavapatna@broadcom.com/
> v2: https://lore.kernel.org/linux-rdma/20260327091755.47754-1-sriharsha.b=
asavapatna@broadcom.com/
> v1: https://lore.kernel.org/linux-rdma/20260320135437.48716-1-sriharsha.b=
asavapatna@broadcom.com/
>
> ******
>
> Sriharsha Basavapatna (9):
>   RDMA/bnxt_re: Refactor bnxt_re_init_user_qp()
>   RDMA/bnxt_re: Update rq depth for app allocated QPs
>   RDMA/bnxt_re: Update sq depth for app allocated QPs
>   RDMA/bnxt_re: Update msn table size for app allocated QPs
>   RDMA/bnxt_re: Update hwq depth for app allocated QPs
>   RDMA/bnxt_re: Enhance dbr usecnt logic in doorbell uapis
>   RDMA/bnxt_re: Enhance dpi lifecycle logic in doorbell uapis
>   RDMA/bnxt_re: Support doorbells for app allocated QPs
>   RDMA/bnxt_re: Enable app allocated QPs
>
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 273 +++++++++++++++--------
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h |   6 +-
>  drivers/infiniband/hw/bnxt_re/uapi.c     |  49 +++-
>  include/uapi/rdma/bnxt_re-abi.h          |   7 +-
>  4 files changed, 242 insertions(+), 93 deletions(-)
>
> --
> 2.51.2.636.ga99f379adf
>
Sashiko is reporting 'Failed', I'm not sure why.
https://sashiko.dev/#/patchset/20260519150041.7251-1-sriharsha.basavapatna%=
40broadcom.com
Thanks,
-Harsha

--0000000000007c84eb06522e8923
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCLfdn2z0KrYc75nw8ENKYbUgPwT1lB543a
vdtJzR8KUzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA1MTkx
NjU0NDhaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQB0H52kw/RH5mYsf3ArDzc561QqSL2A4dNuNA5il9xpds7nl/VcAVmuMGExBhh3QbmVo5+m
4CNf+lWxXySui7IS7OLi2h0b17K5gDPP7CbHDvGWKK4brkAoUND7rKlZIL0owQx0eckcH8yvo3gT
t9xtP1wI+TeQ/NmZ73zmhNV/e4DNkw2FbrO0Bshd78qOK3x94bPMZzecGYNWmcTlc+SUk+nPlxK4
0hdCxrp30aaeo8zVCl8QAVeLGmZrPh8w3PfLv7VX86SjhfSUacexQEjiMEb3m6iCaX0ruSdVrgc8
jYbx3NCZ7G2nFqiFPMBZLGYyir44akzrvkotIyb5ZpBr
--0000000000007c84eb06522e8923--

