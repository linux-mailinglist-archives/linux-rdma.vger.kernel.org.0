Return-Path: <linux-rdma+bounces-16903-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EA71BTuWkmnuuwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16903-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 04:59:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 727B5140CD8
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 04:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E633300EAB2
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 03:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8A228D8FD;
	Mon, 16 Feb 2026 03:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XiavALD7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com [74.125.224.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C0A273D6D
	for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 03:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771214388; cv=pass; b=n1dqdQtC3M1xKeJuD1ds++RYAz16VWsecQc8mNYkVwKttyWtKdDy576zW2Ti9UKVckh4tUGYSXveriUtKIwsKJl8npg5PVYsrKo0c0OA6pYQUs5YNlRcL8lij/A+l62EVwTjhI+9ORo20AX1mMkO/rPOdi2TpzHLl0poUyAP6s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771214388; c=relaxed/simple;
	bh=7h+aqsny1gVAlGPvxjtXiPN1y6pYrmEJT09LCRFj+hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3lDFBv8kjCB2H8vC8RWIeu7uM1pixjGQ8yMlbwEvx3AWj8oLgn9umwl68vCVcgQERiw8B+Poi/9UY5+PWgQjyGPOwB3jtH0HMocXS60pRU6bxwGt+fKe8oCPu8zJVjVPmj3iCHJ23LBoPvOh6+zq1QImECg/xpUDoDDjTn+I10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XiavALD7; arc=pass smtp.client-ip=74.125.224.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f98.google.com with SMTP id 956f58d0204a3-64ad46a44easo2453681d50.0
        for <linux-rdma@vger.kernel.org>; Sun, 15 Feb 2026 19:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771214386; x=1771819186;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5JdF5Fcf8ODEG+jsJxhALXWgbWidK5mhHlvXXGoZf4=;
        b=MjhslE7M6oVu0XoQwsaKNMMbvw580XPNnPDydC3fUOidKzIKrbBJHSM0lnv0Xeu9Su
         bsmAaxqVmHhl3IEaC2pt++3mSkabMR/OmX8jOL/2vazuTCCc7z0xRRxkPDU5vA892Qfq
         sSqptFC4RQfWYiIVuXrbbuL3TD5v6gKma66l6pIByOwa6N/u4U+JfRFPqVWtGxd+9YM+
         I1vyXf2zCf+8Vr99S+b2RT8ndjKN3wDOTFNRf5pMBIio4JCqVyo9+zhfRn7tDNr08yT3
         IkvGq8lfX9yzXe6MrLMvNvFhDM5HDIidwoWQQZYplD8wZsXmMfOBNxDoMESgjEcPsEL3
         VW/Q==
X-Forwarded-Encrypted: i=2; AJvYcCWVwmhDaxCKml64wFAZtYP+vIeTJYqiKkRT0xkg5P9LrmU4TDhKuMvePqwiQW2aI1N5JgsCqOxHeVsp@vger.kernel.org
X-Gm-Message-State: AOJu0YxdkOog2Vmw+MfXdP6/WhZCAIAtE1YcnN4nNg+6Fb9Tjz7GPR2W
	K6Y3O21MO8UIDJqen7oytgW0znGVeG7OPtit5C4LfNDB3jwNP0KeS7KNmflIn78UZDuQao2Gxn4
	cNUHpCOFedZWL5y3lR392Ro3i80pfSVeE6qu690SByvoMoM6+zWO/HZEVT4dbdlpIK9Er2WkGRE
	QKzaGzLU3KOkGkCTiX8utxyHyV2nJ8i3OquDPlyPgg8nYy0PRfAwAAwzT17jEjCq8PRd57yGBJL
	vWqVl/UoUXYTq6Qsw==
X-Gm-Gg: AZuq6aKYBIsliycLMkYk4ZtjTdh4RHaXFfX5YYhPWSausyAH0BRpazv7Mt6lshuCVRc
	qZfQS7w9cBpd7H2UWPAzSARMl/0SZ/ZKA69LNel7itSRfCIwnESwi6RLAsmqlFRM0TWXZI6Gm3d
	Sqf745eWrxviDwz/3LP5SYtqLiSV+Q0NC0058NRCrgUGgzxcUkSM5fAs08R7jAcr47/6GwCA/Ro
	p4UyEi3IzzL+kBYAmM5KYljlSWKi6xjcvsE0ccipRmO/QKxya7+PvndXXcSKs+zTJB1m8izFs2i
	YDH7QpC7seWg/RQWytsHFzE0PAfZR+406x+jbnCF9pIOOh6NXLT6vdWnV7/nzaz8cz71anJIHyI
	/fIl4/FzcWs+KpyjFwytlfAy6NFFdFeTYHGH2GmYgrtYXqWhgkhQjGVsum+F8K5jgZS7OznSrZc
	oPO3xiLywvFpb1QlMopqC19cqbFUs3kzT/itDdVoEVsIajLXarEU6bA9CYHLEN
X-Received: by 2002:a05:690e:689:b0:649:c7dd:d2fb with SMTP id 956f58d0204a3-64c14d99826mr5889115d50.75.1771214386289;
        Sun, 15 Feb 2026 19:59:46 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-64c22ddc5f5sm619034d50.2.2026.02.15.19.59.45
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Feb 2026 19:59:46 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b8f5bce308dso255234766b.1
        for <linux-rdma@vger.kernel.org>; Sun, 15 Feb 2026 19:59:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771214384; cv=none;
        d=google.com; s=arc-20240605;
        b=Cp+8/ru1l7s37qJwhWhPErwyzLy6OirLtpyW4kr6tSRT9CshB88Me1G5tBBZv/UcFw
         M6qymBscgA5xZEB+9M0tXOQYo3mT40wdA/1j4JhPjhjXvD1L927s4bHDo0VrrLmvSBbH
         2XZYIoQl1fVrsU759BtP468D+dc5WWua7dB4zmcSPhgzay3s/wWF9jruK+cItZ/BQg0d
         2KkCuNegg0usNJUfqzUkpTGNanUbOLQmI3rb+6Vdz1OdRYjgQC2Y8t+nNotOPrTNaIp/
         ObN49BfcrfVBwR+HQ6GaJ7qrErupX5gafeVZdMbMuRMXpAbn3RCdAKJ0Kf1PEV+koW3N
         O+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=J5JdF5Fcf8ODEG+jsJxhALXWgbWidK5mhHlvXXGoZf4=;
        fh=reiPl43C85iHfoh4/zvH7TYJ1sDkgeqb9DMXVtqS12E=;
        b=VkgAEPjsrRXzMtJNQdTIN31Qrk18gDi/WIwISilNjz4dL4DrBaJ7EhZ1eeGKby+YPx
         rp8TXtlXImBN432Jsxi+rqu16eHksMLPDnWJdB6PNEZmzsgfwkE7c39EWn7oAlNMRg0w
         cL4rnLW2rV7qvvC7LkXFNrFfe6/l2iW22KCFhEka/vOdKAjg4W44W1zi8s7D66uTCH7y
         Ub59YyZI1lk+vG1WyrlXwyviBF5DsoD2f0FOLiThCuTI3DyccQOqAR2RP4SWCtzYeIkX
         zaOEGVI4TJ6XdYb4UI3BZArh+IdFAfOqnzqCSTu1hBx/g2NuAAeWljPx5oSz38y/PKK/
         Fx5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771214384; x=1771819184; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J5JdF5Fcf8ODEG+jsJxhALXWgbWidK5mhHlvXXGoZf4=;
        b=XiavALD7Gg8fwvHyjOCxxmzpMcG1G06FjJ3Y9r+HVxILdCBRrpkopWZ+DTfj11bvnC
         Iobxezl4OnmE8JQXprPKKCvh2Zo1zKv3tXXdDb5oIhO2ZznzJDgh+S9zZrcQ4VTK4KnH
         CVYE8SiVpuBDHPwQPZQ2RhcdO1bgboLaLgiK4=
X-Forwarded-Encrypted: i=1; AJvYcCXSgNPTVyhAEmDMFHfuXevuPczhQhYKrrPvgfrv3w0DBBQqvMW7RbFCTmRVIUjbUmNhA73Q9SVY2A+s@vger.kernel.org
X-Received: by 2002:a17:907:9282:b0:b87:6953:9d5e with SMTP id a640c23a62f3a-b8fb44870a8mr448290766b.33.1771214383880;
        Sun, 15 Feb 2026 19:59:43 -0800 (PST)
X-Received: by 2002:a17:907:9282:b0:b87:6953:9d5e with SMTP id
 a640c23a62f3a-b8fb44870a8mr448290166b.33.1771214383394; Sun, 15 Feb 2026
 19:59:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com> <20260213-refactor-umem-v1-42-f3be85847922@nvidia.com>
In-Reply-To: <20260213-refactor-umem-v1-42-f3be85847922@nvidia.com>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Mon, 16 Feb 2026 09:29:29 +0530
X-Gm-Features: AaiRm53YuvEdahP9BFdxxykEgks-2-so2BYe0D9GQQvG1LfKUwG4ZM7F5DjtN-0
Message-ID: <CA+sbYW0Gh2bLoPZKzH9u-EcWDTz6mbF3RB=6Q3q=m7YpUpNU6Q@mail.gmail.com>
Subject: Re: [PATCH rdma-next 42/50] RDMA/bnxt_re: Complete CQ resize in a
 single step
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
	Potnuri Bharat Teja <bharat@chelsio.com>, Michael Margolin <mrgolin@amazon.com>, 
	Gal Pressman <gal.pressman@linux.dev>, Yossi Leybovich <sleybo@amazon.com>, 
	Cheng Xu <chengyou@linux.alibaba.com>, Kai Shen <kaishen@linux.alibaba.com>, 
	Chengchang Tang <tangchengchang@huawei.com>, Junxian Huang <huangjunxian6@hisilicon.com>, 
	Abhijit Gangurde <abhijit.gangurde@amd.com>, Allen Hubbe <allen.hubbe@amd.com>, 
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>, 
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>, Long Li <longli@microsoft.com>, 
	Konstantin Taranov <kotaranov@microsoft.com>, Yishai Hadas <yishaih@nvidia.com>, 
	Michal Kalderon <mkalderon@marvell.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Christian Benvenuti <benve@cisco.com>, Nelson Escobar <neescoba@cisco.com>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
	Bernard Metzler <bernard.metzler@linux.dev>, Zhu Yanjun <zyjzyj2000@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-hyperv@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000327d91064ae8fc71"
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
	TAGGED_FROM(0.00)[bounces-16903-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[ziepe.ca,broadcom.com,chelsio.com,amazon.com,linux.dev,linux.alibaba.com,huawei.com,hisilicon.com,amd.com,intel.com,microsoft.com,nvidia.com,marvell.com,cisco.com,cornelisnetworks.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 727B5140CD8
X-Rspamd-Action: no action

--000000000000327d91064ae8fc71
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 4:31=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> There is no need to defer the CQ resize operation, as it is intended to
> be completed in one pass. The current bnxt_re_resize_cq() implementation
> does not handle concurrent CQ resize requests, and this will be addressed
> in the following patches.
bnxt HW requires that the previous CQ memory be available with the HW until
HW generates a cut off cqe on the CQ that is being destroyed. This is
the reason for
polling the completions in the user library after returning the
resize_cq call. Once the polling
thread sees the expected CQE, it will invoke the driver to free CQ
memory.  So ib_umem_release
should wait. This patch doesn't guarantee that.  Do you think if there
is a better way to handle this requirement?

>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 33 +++++++++-----------------=
------
>  1 file changed, 9 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniban=
d/hw/bnxt_re/ib_verbs.c
> index d652018c19b3..2aecfbbb7eaf 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -3309,20 +3309,6 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const st=
ruct ib_cq_init_attr *attr,
>         return rc;
>  }
>
> -static void bnxt_re_resize_cq_complete(struct bnxt_re_cq *cq)
> -{
> -       struct bnxt_re_dev *rdev =3D cq->rdev;
> -
> -       bnxt_qplib_resize_cq_complete(&rdev->qplib_res, &cq->qplib_cq);
> -
> -       cq->qplib_cq.max_wqe =3D cq->resize_cqe;
> -       if (cq->resize_umem) {
> -               ib_umem_release(cq->ib_cq.umem);
> -               cq->ib_cq.umem =3D cq->resize_umem;
> -               cq->resize_umem =3D NULL;
> -               cq->resize_cqe =3D 0;
> -       }
> -}
>
>  int bnxt_re_resize_cq(struct ib_cq *ibcq, unsigned int cqe,
>                       struct ib_udata *udata)
> @@ -3387,7 +3373,15 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, unsigned=
 int cqe,
>                 goto fail;
>         }
>
> -       cq->ib_cq.cqe =3D cq->resize_cqe;
> +       bnxt_qplib_resize_cq_complete(&rdev->qplib_res, &cq->qplib_cq);
> +
> +       cq->qplib_cq.max_wqe =3D cq->resize_cqe;
> +       ib_umem_release(cq->ib_cq.umem);
> +       cq->ib_cq.umem =3D cq->resize_umem;
> +       cq->resize_umem =3D NULL;
> +       cq->resize_cqe =3D 0;
> +
> +       cq->ib_cq.cqe =3D entries;
>         atomic_inc(&rdev->stats.res.resize_count);
>
>         return 0;
> @@ -3907,15 +3901,6 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_e=
ntries, struct ib_wc *wc)
>         struct bnxt_re_sqp_entries *sqp_entry =3D NULL;
>         unsigned long flags;
>
> -       /* User CQ; the only processing we do is to
> -        * complete any pending CQ resize operation.
> -        */
> -       if (cq->ib_cq.umem) {
> -               if (cq->resize_umem)
> -                       bnxt_re_resize_cq_complete(cq);
> -               return 0;
> -       }
> -
>         spin_lock_irqsave(&cq->cq_lock, flags);
>         budget =3D min_t(u32, num_entries, cq->max_cql);
>         num_entries =3D budget;
>
> --
> 2.52.0
>

--000000000000327d91064ae8fc71
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
zJH6Ivyz2skA36zh/px/UmF2ORX4Y0CY6GtU8/vxuN2j4rd2medlyifwALUm+KI3SsD782IwKLCf
8bNhYGiw4YxsbyX7dV7O4SNQc5U9ktrSKH3D4SuTnK/xdjca5PiNI2NTcBVmP7+u2bvVLdRqISop
9dpRkJ6xxhGJjxakljIxHdcZLXltxX4YM0Onf3agcjY3boIqnVlDjBwSZX674ZU+YVrcIlcRcqs/
W83e6PmIRFwpkKOhuLNKSpW5mZoEQdpnxGwE9U7qLGECAwEAAaOCAd4wggHaMA4GA1UdDwEB/wQE
AwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5Bggr
BgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUG
A1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUF
BwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDag
NKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJQYD
VR0RBB4wHIEac2VsdmluLnhhdmllckBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQw
HwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt26AjhRiwoJIwHQYDVR0OBBYEFJA9fV7cOoiN64ws5XPC
J5qtayo5MA0GCSqGSIb3DQEBCwUAA4ICAQBFCIF4AxAiXVz6gX5YfFEbIYtbGFifcfe+QGc5cfac
CSzIrQWUPXAYAef3G5WouD2AKwa2tPGJgK2L7n1r2W4NIvr93588EDVnGgfMfWaFsB8VlLsPlH8Y
fLfaTdN3OQPnFFp54yK9wv8AtTIiTQcailMw7QX5x5GE6HVZElxf0V0Ljc2NrUQLoYzHzAU+sysl
6JQzomxjIfuXiIiUfmnWQdhO95kQchRdOUAaguLTV+RRfPZ1p54dRmgGEpJtzjGLdsrLkZ2rCN5j
cOTTXyxJmvlgm9jfT0Uy5SOPHdq1jtZbQyXrNT4fQ07Odmq3xQCUTi+a59IiC+6V7nFJ8zyCSk+p
n/iGouvun/owYzTmFxB6sVLWZcaWz2Ufcm7b6nOYV+pwUS/n6+6oFRKmGLrl0CRCF0AOph5p81aV
kgKuS5oXBoDefJfjKHuu5lJVelBx3n++iMGMW9FWFmXErCHy2d+L42Raai5X2PL8jAmh+lpPRDX4
CT9jL6xWM5QkCBtxyVKuxGxxUY2wczmVcQ1nGh9mGghI04Scs4OtE8Qh9LMOe2PXzxcV6lpF+yay
B3fwJWxl7miwNFjWuu9M6Z+rcjm3JF5srcAu2fp/VzQD4AE5Kq7ywukMvlU4Y3X2t+D2eU1DH8pk
c8mM1CtQWfWUboaoLABVmYmYfihDvTURkzGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAX
BgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1F
IENBIDIwMjMCDDy76dRYp65lyF2c4zANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg
EHewyNNlkY4qI/Y/4FDemH598qhce+Q8ReKG/2VVATAwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYwMjE2MDM1OTQ0WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAL80bUWzOlO7ylY9A/f9ng2JrEOROa8iAgyi5
bjpaaSGGjai0d/LCunA/I1GdQWxanYhsPhhzpmlMhdiL+BfwtcJGjFqrKqNJllcHEIO2acGgGZeN
uXhIqXTwjSjfy4RKDGnbS3XdGJyFH06LaVURp1dR0ED0akkIjmTeDGLrNhc4Q+MOym58cGeL6HVk
rAmYNaiUVNgVwkQIr6OGhTaT3HgflS8ug/Zf84jqTFYS4GusKWnYUw5bgVGMgydAnjo8qt9xu13j
IxKc1UryuP70KCAaY6fbe2q9rNtobkA1OFJWzF+1ECKMsibWluA+aoS10nuCWhYEkXt4RPrVYapm
LQ==
--000000000000327d91064ae8fc71--

