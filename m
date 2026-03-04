Return-Path: <linux-rdma+bounces-17457-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Pz4ObfSp2l7kAAAu9opvQ
	(envelope-from <linux-rdma+bounces-17457-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 07:35:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6731FB332
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 07:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D22C2301BA45
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 06:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03C637FF46;
	Wed,  4 Mar 2026 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ENbdnEla"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B0637F8B9
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 06:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772606128; cv=pass; b=EReBgE2Di9tXjWz1cu7lpWG6tHQ+ONmMzwxJ4RMn9TkAwUFFxEh3ar1WGMic3oijWhYP7GJ55GJVPgc4ijP5tqWL+yKRYjQe/LRVHbKlF4J11JN4mWUsFv0EvMGrABV1lIWUknoia/ohkoP3X2FXwAh8GP+oCiJOWextrVBOsd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772606128; c=relaxed/simple;
	bh=khV1UhrjWjUmTThjWqd1BG8zAe2pZfVlrzGRD+P//G4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHx5PTs1ZBJho2pBSqh8XIY7WphzMnZMCTxhhbv9ka4pFBOrmB6tX6UWnbG8RDJkZ32m0L6uVzDfK/BY5/m9F8I9owtKKx1bPgHLIRw8UpIImO42c/oC0R6/c0Fi2daNlGJNZPCmmqP/x1clLnmyi3VcGNNpttc0JHdXDo56+hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ENbdnEla; arc=pass smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-64acd19e1dfso5641378d50.0
        for <linux-rdma@vger.kernel.org>; Tue, 03 Mar 2026 22:35:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772606125; x=1773210925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OnquJ484ottD76W9CAZqMmq9gKqVC3QUwKJslquvfLk=;
        b=nPV7z4n3pN6X9Py+X+sWBXDNKX4GwI1C91o4vAuKYTlV18FsSGyGQGvcNwqotQTSKy
         fiet0TRyjBI0IqRCVbRznwBm5cixz5ZA1CZhoda8s1Ku4OeG7drJJuGjy1IJeZOAy1ut
         v9xJaa0KarDOwWARuRPRFUlr8cBFzfq0pT/j9sNTo0VJgxFOpUVq91oxjnUdTusHL6po
         Je5M9S3k7tev2kbIp3i+9uRulGCUMTcxMUdVz/upyJbyjAgz5BP6TZS1YpHN4OYGqq+Z
         LZRCa0QjHG3399xNkRcZmOrg0oM0nx6GvNEnqR/e9pwzk3s/KWreE2xjsPpoOIM80ZnG
         ehSg==
X-Forwarded-Encrypted: i=2; AJvYcCWazFXLP27+QGd1VY5+OKw3wpbfKul6al7w6o62fw6sgP7AxcajNTRRHhVN2fCsI1K7zGAjsjOd2KaV@vger.kernel.org
X-Gm-Message-State: AOJu0YwUadPYAE7v3POMZ9QFJyOXEKwo44V9wfd+Qt7HILCsv0jDxyRe
	pUiBwKwKM2LGopgEEXuywXQnbjF0xe5/d4DybdB+RbGKXeMBIzw6Rhk7xzmozHidVkzjgpDHcsZ
	wVLlR65ow33g4l140m7u6WBBqK51cVSDQ39Y+PdxMYia69xwQezNMwGkPY/u/BcUlIjF9twjTPX
	uoXYXOfLEA6+1joG0zgiK+sZZGdsivuEq21GugqUbaDThlk4tsva52O96yWfKMHAIgcmbD3jIhZ
	6VRvj0MJ2/0+Z5yxgTy6wFj7QuD
X-Gm-Gg: ATEYQzzEgdDGWVyQKnlNwPzYqOK0MVC72g+flHsFQypccPcG6GdfGUYEh7hvSP0uM2o
	ONr1lYWOx3yKvx54IP0yjm5ohWe2CgrvjCkbuQXbTp83lmLvg5UKpmY68noxhgvABVLKFtI/uU4
	B8s9G8hNiTuF6sLHs2Cx9X8X7cTBMMAe6nQ437+k5Mux1THsOYf/sGCpP+X4yRRoH9CgLb6kKaF
	Un+SMOx50r2jnsUubb65RDKZAf8onUP+mNTGHF7kQhhcHPLnbI5GqyHMMaf/T96fdTiMhikf4Ti
	J7z4ycjzFCMzBD8l9/yBqwpk70YmrTw4UPRB+tCGPsYxSzfi97JdjyyZcYkGoSmsS1DJybFskr2
	ihu4D1f85pU0d89pzpvc72n0qNyKKpN4ZbBKaP/dtAWCz23nWXCQSKOFpkpDAemEWHEGuOy7+B1
	j7+EIViaK+0XUgjHpkKqtQkvmiYzS3/YZEKVGaWrV6sa0TvqDBzfAp7qA/w3TJsDqaxBa6EwM=
X-Received: by 2002:a05:690e:151b:b0:649:45c2:6d62 with SMTP id 956f58d0204a3-64cf9b34b01mr770522d50.5.1772606125021;
        Tue, 03 Mar 2026 22:35:25 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-64cb75fb6b0sm1778409d50.7.2026.03.03.22.35.24
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2026 22:35:25 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439c54e0f6aso556696f8f.0
        for <linux-rdma@vger.kernel.org>; Tue, 03 Mar 2026 22:35:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772606123; cv=none;
        d=google.com; s=arc-20240605;
        b=d40M3iOqWwGAOJ7jCxNDjNHkLB7ZbSLjXogutpboYGAF7oPzfwKbW4ECVkmnSrg2UC
         vqdIAMnDXbpOttBlDo+jOwlrD+FsD/bWXMv5FE1nAEDCoqNdm2qy0crhyc4NKWGp5fiU
         yKrEPcDDQORZjeOsb87o9fdN1cAkBC17OvpBUp3XvftUfK5JruA06tHU/9wjJnNY6fzJ
         b1SeJzsNsf9YUdtV0qTi/PzcWJEMFvMBQXBJ13JL0iT1Ez85wUkSQFsCHQOr+7rqh+5m
         g3vYjxhWLbb/8CUvd2+ReV5/rNUgN+SfhzTdNyMs7ToTO/msQt8DNBdvnlBXWchbWmUS
         J/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OnquJ484ottD76W9CAZqMmq9gKqVC3QUwKJslquvfLk=;
        fh=EkjyPgxiXTfXUli6VYTqysR8b2Iq5HdK08wP1Gy07RY=;
        b=Rlpl+D5NORxr9bhtLpNH/LJyUs7Zu4sqSKdWk+cQzy+pNU+lQuHU2lun8anA3QDT10
         gzfSQMvNZBO/KxYNAf/YQnTZvUSMRboVrBogV6Dk8xZ1rrCrdQwc2kRXwk+el6QOnDrl
         h4p3S1rb80JMljOXZGpbMPUW4EmZeG/K+wpp5QQqYZ94EjsBups1qeh0gkXDCxOL7JHG
         liWi6Cq+Bovc9eE1D64UB6SbAPhzj1sIUxWWQBj7iVvLtYyTq8MrtxE8cl3UteL2O8YC
         8bH1hi6GOpO1ZISmApfQpzdNvGSZj/+IQXgbmd2uQBUOsrWP+7b+RN3v8SNh8YXB6wJs
         ymBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772606123; x=1773210923; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OnquJ484ottD76W9CAZqMmq9gKqVC3QUwKJslquvfLk=;
        b=ENbdnEla5AWhcY8Cv5f/L7ZziXqjAXcTESvD53bgVzRl8ySiQw7MTGCBM22Y9rVpiB
         kzEXWEMWwQXLLTZJ5pNYNqoo/PgS7fLN/PfkIhEZueEt477Ary9tYmVnZ0GGB2GBFffP
         pnWYn+tSE9VZtBw5aL8sUzfQVXCJCDtXJ5ZIA=
X-Forwarded-Encrypted: i=1; AJvYcCVzCCUGi6BESWtU19tl3jEu6+u8gjw7TVuCfkHh/sYuq/swekBIzzGw2Y4u+byRQmqh5/T+1aqSy+6B@vger.kernel.org
X-Received: by 2002:adf:e3c4:0:b0:439:c560:bb78 with SMTP id ffacd0b85a97d-439c560bc6bmr3260357f8f.22.1772606123365;
        Tue, 03 Mar 2026 22:35:23 -0800 (PST)
X-Received: by 2002:adf:e3c4:0:b0:439:c560:bb78 with SMTP id
 ffacd0b85a97d-439c560bc6bmr3260333f8f.22.1772606122879; Tue, 03 Mar 2026
 22:35:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com> <13-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <13-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Wed, 4 Mar 2026 12:05:11 +0530
X-Gm-Features: AaiRm50aGUttJJht24MG4C2N0HMHRInd4YCzsOnkCMyDHR-q5HEnDIQcVprrLug
Message-ID: <CAHHeUGW5aOHbhETW624fM_MSkXAqUgw=T+6skPaA=R3py+9EQQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] RDMA: Add IB_UVERBS_CORE_SUPPORT_ROBUST_UDATA
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, Leon Romanovsky <leon@kernel.org>, 
	linux-rdma@vger.kernel.org, Selvin Xavier <selvin.xavier@broadcom.com>, 
	patches@lists.linux.dev, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000056170b064c2d0616"
X-Rspamd-Queue-Id: EF6731FB332
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
	TAGGED_FROM(0.00)[bounces-17457-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,broadcom.com:dkim]
X-Rspamd-Action: no action

--00000000000056170b064c2d0616
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 1:20=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> This flag can be set by drivers once they have finished auditing and
> implementing the full udata support on every udata operation.
>
> My intention going forward is that driver authors proposing new udata uAP=
I
> for their drivers must first do the work and set this flag.
>
> If this flag is not set the userspace should not try to use udata based
> uAPI newer than this commit, though on a case by case basis it may be OK
> based on what checks historical kernels performed on the specific call.
>
> Since bnxt_re is audited now, it is the first driver to set the flag.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/device.c                  | 1 +
>  drivers/infiniband/core/uverbs_std_types_device.c | 8 ++++++++
>  drivers/infiniband/hw/bnxt_re/main.c              | 1 +
>  include/rdma/ib_verbs.h                           | 6 ++++++
>  include/uapi/rdma/ib_user_ioctl_verbs.h           | 1 +
>  5 files changed, 17 insertions(+)
>
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/d=
evice.c
> index 558b73940d6681..5b4fb47cbaeee6 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2706,6 +2706,7 @@ void ib_set_device_ops(struct ib_device *dev, const=
 struct ib_device_ops *ops)
>
>         dev_ops->uverbs_no_driver_id_binding |=3D
>                 ops->uverbs_no_driver_id_binding;
> +       dev_ops->uverbs_robust_udata |=3D dev_ops->uverbs_robust_udata;
this should be: dev_ops->uverbs_robust_udata |=3D ops->uverbs_robust_udata;

Thanks,
-Harsha
>
>         SET_DEVICE_OP(dev_ops, add_gid);
>         SET_DEVICE_OP(dev_ops, add_sub_dev);
> diff --git a/drivers/infiniband/core/uverbs_std_types_device.c b/drivers/=
infiniband/core/uverbs_std_types_device.c
> index a28f9f21bed89d..12ca15739cd2cd 100644
> --- a/drivers/infiniband/core/uverbs_std_types_device.c
> +++ b/drivers/infiniband/core/uverbs_std_types_device.c
> @@ -247,13 +247,21 @@ static int UVERBS_HANDLER(UVERBS_METHOD_GET_CONTEXT=
)(
>  {
>         u32 num_comp =3D attrs->ufile->device->num_comp_vectors;
>         u64 core_support =3D IB_UVERBS_CORE_SUPPORT_OPTIONAL_MR_ACCESS;
> +       struct ib_device *ib_dev;
>         int ret;
>
> +       ib_dev =3D srcu_dereference(attrs->ufile->device->ib_dev,
> +                                 &attrs->ufile->device->disassociate_src=
u);
> +       if (!ib_dev)
> +               return -EIO;
> +
>         ret =3D uverbs_copy_to(attrs, UVERBS_ATTR_GET_CONTEXT_NUM_COMP_VE=
CTORS,
>                              &num_comp, sizeof(num_comp));
>         if (IS_UVERBS_COPY_ERR(ret))
>                 return ret;
>
> +       if (ib_dev->ops.uverbs_robust_udata)
> +               core_support |=3D IB_UVERBS_CORE_SUPPORT_ROBUST_UDATA;
>         ret =3D uverbs_copy_to(attrs, UVERBS_ATTR_GET_CONTEXT_CORE_SUPPOR=
T,
>                              &core_support, sizeof(core_support));
>         if (IS_UVERBS_COPY_ERR(ret))
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw=
/bnxt_re/main.c
> index b576f05e3b26b2..7af514524632e2 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -1326,6 +1326,7 @@ static const struct ib_device_ops bnxt_re_dev_ops =
=3D {
>         .owner =3D THIS_MODULE,
>         .driver_id =3D RDMA_DRIVER_BNXT_RE,
>         .uverbs_abi_ver =3D BNXT_RE_ABI_VERSION,
> +       .uverbs_robust_udata =3D true,
>
>         .add_gid =3D bnxt_re_add_gid,
>         .alloc_hw_port_stats =3D bnxt_re_ib_alloc_hw_port_stats,
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index e1ba20c3974f08..58af61eae52de7 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -2474,6 +2474,12 @@ struct ib_device_ops {
>         enum rdma_driver_id driver_id;
>         u32 uverbs_abi_ver;
>         unsigned int uverbs_no_driver_id_binding:1;
> +       /*
> +        * Indicates the driver checks every op accepting a udata for the
> +        * correct size on input and always handles the output using the =
udata
> +        * helpers.
> +        */
> +       unsigned int uverbs_robust_udata:1;
>
>         /*
>          * NOTE: New drivers should not make use of device_group; instead=
 new
> diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/=
ib_user_ioctl_verbs.h
> index 89e6a3f13191b9..90c5cd8e7753c7 100644
> --- a/include/uapi/rdma/ib_user_ioctl_verbs.h
> +++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
> @@ -46,6 +46,7 @@
>
>  enum ib_uverbs_core_support {
>         IB_UVERBS_CORE_SUPPORT_OPTIONAL_MR_ACCESS =3D 1 << 0,
> +       IB_UVERBS_CORE_SUPPORT_ROBUST_UDATA =3D 1 << 1,
>  };
>
>  enum ib_uverbs_access_flags {
> --
> 2.43.0
>

--00000000000056170b064c2d0616
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCA5VYv4Yc6vem24fi9Y8pZity250EuxJPZH
q5pA/5qJrTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAzMDQw
NjM1MjNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBrxVNeXOoK3/DZFkMMr3jFhZGtQXxNo0V6A7Der5sc8uL67gz3hphD2t5Ay8N00+cGU0BC
fqoabuv/9YHnwvhD0f9SxXq5JjkT8tPuWXmD5ytKJEzMk/zpbUSPGBuOlIG8skOIfHWpCbOHdFHx
nluK0ZdIFU5plPIBxdehkzzmynt1sQxk2S46GYfnW8C6QrPGQB0hPnpzRHmO1D+8nfPQKMk1IL64
lBlknOFLAgTej/I5wQFDHTargk/vmiZdNGvdBMd6QiRZV1aTXAVP5rB6t2pBusbIb4Femk5ZtHD7
feO/I/4jNxJCj1xZrl7XdYBi+jtdo2hD/ck7vlX3iv3c
--00000000000056170b064c2d0616--

