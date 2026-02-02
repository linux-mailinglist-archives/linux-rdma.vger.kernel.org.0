Return-Path: <linux-rdma+bounces-16329-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I/RCmeegGl2/wIAu9opvQ
	(envelope-from <linux-rdma+bounces-16329-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 13:53:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82674CC83C
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 13:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0326D300EAA0
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 12:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CFA19E7F7;
	Mon,  2 Feb 2026 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PLuKkApo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976D419C540
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770036681; cv=pass; b=p2lo6oOWJTvayefrC99uk2VwVxTtOuidRNS2rHWEcUxVIH3S40V7Pelisf7Gd6aQZvQF3gkKUz8TrWpmJ4WCIT6MrwU8wmIE/53cks807wne6j0GqCW87ptbt5jac/E9qHQt9M7cMgATUF8T58vbkbN+JwZZvBAHBZJFaS5lOxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770036681; c=relaxed/simple;
	bh=xvBXgbv3m84M3sADphvk49/gWqugVTdlc4HP6qbUDiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/QZrR49tHLuywMkH/OvFc/kDuQNxfa5C50rCexZRQ43cP/uMMPAYoel6i48Q3X5vrByiy7TTcna4SlE5OCOBsfwoBpgLj+7ElF/nictw/UJ0CodJdIioi23p3H55N+TFP6eTXwo0y/l+Ft339nkUqDchmosMVOHO6mqTlra8iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PLuKkApo; arc=pass smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-8220bd582ddso2531208b3a.2
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 04:51:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770036679; x=1770641479;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbfFnZ019XWHDlvK8BsbGAxGIGouKGCsc/z5lTf5Puw=;
        b=G696nWsLEdmuFa8AkN9qrMs0wSWkPFbis3AZ58+A2LwN++x5TeMuFVstA1yeP9GEwB
         ESBa0ebBYWdXFItDKTihc6TB6RsapGrUu1ZRuS8UQ6fwb4AkEtSaBnWOATjwGq3XoAYS
         cdhNanMhuHVUxIKgiVUAOdgzd5zWexWbkPx1E+Xr+mGPUskLftFINWhUYd2dMKyM9+ml
         KQwwA17BapHoeE2//wgAFYtug/j84/nfocjR1S8jmpEdRyBbpmMQjKRFzWDQYAiRg0m2
         u13GHKtrJ0AIG4SztGRDqz9JtGiz13y0fmvl+7qQ3NYQ6mItPJbMXmDK9XMFFQElFQr6
         q0JA==
X-Forwarded-Encrypted: i=2; AJvYcCXEpP7Y6axDisQZtSv6EP/bIet1us1GO+3VgNqPHKhN3KLv9FvXR/sOwe9FMrJt+nH3BaJX0QPGr2tV@vger.kernel.org
X-Gm-Message-State: AOJu0Yyalo+8THZBHg5wx0egO41PiVE/0RmsV3FVxWf75cFC69/KeasJ
	NzPG08mVLQcpF+txmjPvmaj9N0o043gJltXV7/R6dx6V4DecKH5JGn368gD14okV52Li3t8zhHC
	VMPcwGRudtyGaA/pA6DsuTFSMooM0ENDbWg7gRbjp97EJlqMeVATE9Q/PHPQN3ff8iwVQoYVcfS
	ehxz5EF6nb1ym+HHjKGHNC6xwCxKfDhi5RfPz+2Bn1b5LpFZ+U2BFYflZiwk4eIvxJV5fWDls7Y
	aHTcMBH86jzxgY+FcMMF4ctwzLIbQ==
X-Gm-Gg: AZuq6aInR2GsK06Ts5ag7uz4+tSNDYJ49Je3VXtsAiz2EY8R/H3PYrQoRffe91G/v6k
	H9cIGOOtFo6F3BjyUKHNflbVyoBukpiKnS93sVxXf3Odd7bqlXibJD6ikeU3dqLUIpmuqr6p+ub
	DGtVJ14hkqqxRmLtOc0171X2GGxKW4U4SlUsB0WbQiKziJajcZevR4dk+pyQXu1p+o5g6EY2ysw
	l8PV+U03oEYnI6GjtqB+urpzWqIbShjUl0esDOPlEaA4CN3+HNM5LpF6iaBBeENlti/alrB4XYH
	ffjqU6MPM7bB5wVdA9yaEfJ5+Yon3aWMb68N0M7IoBvuAvcK2Ur5bzPXDAnsRwBCMTieS2k9DBN
	1M5KZqQygXuku/kU5eXSvKf0NaCd/jslbm3uaTXoL8Mf26uWd9D08F2BttcoGg8K+/7qRQBwZ4J
	KL046Ezb0C7s5Qp+eohqVXHQ5omSkz2TMzm8HfPsTNao1+BFqrkalZh/MD270I
X-Received: by 2002:a05:6a20:9c8e:b0:38b:e750:bc27 with SMTP id adf61e73a8af0-392e014ba5emr10564707637.58.1770036678774;
        Mon, 02 Feb 2026 04:51:18 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-82379b187a3sm1926526b3a.1.2026.02.02.04.51.18
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Feb 2026 04:51:18 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a76f2d7744so42946675ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 04:51:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770036676; cv=none;
        d=google.com; s=arc-20240605;
        b=NwHRNx/2e0ZrEJEHbM4CXWumayBWSi2qm8d4IOUMFe3pj0SnaBMlUmwmRMbKguQ3Ja
         G4weE5ICD3lRkjuc2eDSl8ERVqqe59kdvKQBj6sKX/iESfObzwaTzuuwuUcrsYr3WQAB
         lCwoKMOkRwdFSfOFnpyihJUzrSoIb7E8I9UPDW2KNwh6Fe0zwhsqoSHgedoFoS8Nsceg
         hWtSehjjg9xP51fBGwM/qRlgbJh5SytukEwmt7d8pPv80v6ZYyZ7aDG56eyRTRbhwhAG
         UEdTCykbUXDdAxwRXj2uI3Thj/H1tdtLbH4vRDHP/cuK69jfrUrqUOVbb+26fvKmOvLr
         fCKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IbfFnZ019XWHDlvK8BsbGAxGIGouKGCsc/z5lTf5Puw=;
        fh=m5hmxUCMXL1lAynVwRQ9ea0wLc+fN6dcHJK/W8svs1g=;
        b=lAev9/k6PK6NTzlWwl4DbJ1rR8uP/ffZX7/VED+U7KKioVB0YoGHK5qCPvHYsoJ1Ue
         LhQrEqFYHhbDylXbvA3lLRwDFnXZeNcslK9aw5f5j0y8b2SSBfGX88OeIvhgXp27YMcz
         Prt/gE7t/hHjEvn4hknm+HzpHJH6Uq6vkCJ01LrujrfH5TfS3j0y6ytBDIgLX2oY+e8J
         wBzje9q68GRXst9fx/PrpnscT3cnnTUxaGnOE5h1+9mbynBQWViiZNl2RcW/xgLRYrMC
         1M9zFkJ5+bDzvxv7nTRP4VF1FhHKMnFvc5ybLbrcMEMpgsweEvppslZ21ZYh3kWNlcTm
         sUeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770036676; x=1770641476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IbfFnZ019XWHDlvK8BsbGAxGIGouKGCsc/z5lTf5Puw=;
        b=PLuKkApocImRDRRCoUN6NNPqt7E5qe2+Y8oqcuhTLnlAKkw0X4IJdRMAU3SBT8IkMI
         LVVnzMvdJo8mlJOxM8cBj57b9kdYWy99M/bcFndX0B9Nnh0ydhkHQqukoUZS4KKQHobM
         So/RIODQk5JuDJy4LhFHwRB1iZSU6IHaIga5A=
X-Forwarded-Encrypted: i=1; AJvYcCVNUMAmDthA8iMc2MB3nBmrU5350aE1tCftmwFZxJwklvnBonj73HWEAcpEvg121RuEVlKp+8zKtfHV@vger.kernel.org
X-Received: by 2002:a17:903:40d1:b0:295:738f:73fe with SMTP id d9443c01a7336-2a8d8150797mr126363965ad.30.1770036676462;
        Mon, 02 Feb 2026 04:51:16 -0800 (PST)
X-Received: by 2002:a17:903:40d1:b0:295:738f:73fe with SMTP id
 d9443c01a7336-2a8d8150797mr126363695ad.30.1770036676061; Mon, 02 Feb 2026
 04:51:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202045120.3139712-1-kalesh-anakkur.purayil@broadcom.com>
 <20260202045120.3139712-2-kalesh-anakkur.purayil@broadcom.com> <20260202121707.GI34749@unreal>
In-Reply-To: <20260202121707.GI34749@unreal>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 2 Feb 2026 18:21:05 +0530
X-Gm-Features: AZwV_Qh_5neIYCNwkpvm5yzRD608qYKIjlG7lTPsaot7krvm_GATsR68VRVqHpk
Message-ID: <CAH-L+nOqtRTEfYp8fpNRGK-_wgdduE6mGbmx_wXRsNeQJisDhw@mail.gmail.com>
Subject: Re: [PATCH rdma-rext V3 1/5] RDMA/bnxt_re: Add support for QP rate limiting
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	selvin.xavier@broadcom.com, 
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>, 
	Hongguang Gao <hongguang.gao@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005e397a0649d6c734"
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
	TAGGED_FROM(0.00)[bounces-16329-lists,linux-rdma=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[kalesh-anakkur.purayil@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82674CC83C
X-Rspamd-Action: no action

--0000000000005e397a0649d6c734
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 5:47=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Mon, Feb 02, 2026 at 10:21:16AM +0530, Kalesh AP wrote:
> > Broadcom P7 chips supports applying rate limit to RC QPs.
> > It allows adjust shaper rate values during the INIT -> RTR,
> > RTR -> RTS, RTS -> RTS state changes or after QP transitions
> > to RTR or RTS.
> >
> > Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
> > Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
> > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 11 ++++++++++-
> >  drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 12 +++++++++++-
> >  drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  3 +++
> >  drivers/infiniband/hw/bnxt_re/qplib_res.h |  6 ++++++
> >  drivers/infiniband/hw/bnxt_re/qplib_sp.c  |  5 +++++
> >  drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  2 ++
> >  drivers/infiniband/hw/bnxt_re/roce_hsi.h  | 13 +++++++++----
> >  7 files changed, 46 insertions(+), 6 deletions(-)
>
> AI generates the following:
>
> Scenario:
> 1. User creates an RC QP (ext_modify_flags =3D 0, zero-initialized)
> 2. User calls `ib_modify_qp()` with `IB_QP_RATE_LIMIT` =E2=86=92 `ext_mod=
ify_flags` becomes `0x8`
> 3. User calls `ib_modify_qp()` **without** `IB_QP_RATE_LIMIT` (e.g., just=
 state change)
> 4. `modify_flags` is reset to 0, but `ext_modify_flags` still has `0x8`
> 5. In `bnxt_qplib_modify_qp()`:
>    - `req.ext_modify_mask =3D cpu_to_le32(qp->ext_modify_flags);` =E2=86=
=92 sends 0x8 to firmware
>    - `if (bmask_ext & CMDQ_MODIFY_QP_EXT_MODIFY_MASK_RATE_LIMIT_VALID)` =
=E2=86=92 TRUE
>    - `req.rate_limit =3D cpu_to_le32(qp->rate_limit);` =E2=86=92 sends st=
ale rate_limit value
> 6. Firmware receives unintended rate limit modification
>
> **Severity**: This is a functional bug that can cause:
> - Unintended rate limiting on subsequent QP modifications
> - The stale `rate_limit` value being sent to firmware on every modify_qp =
call
> - Unexpected QP behavior
>
> -------------------------------------------------------------------------=
-------
> Is it expected behavior?
Thanks, it was a miss. I will push a new version.
>
> Thanks
>
>
>
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infinib=
and/hw/bnxt_re/ib_verbs.c
> > index f19b55c13d58..2930461be20d 100644
> > --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > @@ -2089,7 +2089,7 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct=
 ib_qp_attr *qp_attr,
> >       unsigned int flags;
> >       u8 nw_type;
> >
> > -     if (qp_attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
> > +     if (qp_attr_mask & ~(IB_QP_ATTR_STANDARD_BITS | IB_QP_RATE_LIMIT)=
)
> >               return -EOPNOTSUPP;
> >
> >       qp->qplib_qp.modify_flags =3D 0;
> > @@ -2129,6 +2129,15 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struc=
t ib_qp_attr *qp_attr,
> >                       bnxt_re_unlock_cqs(qp, flags);
> >               }
> >       }
> > +
> > +     if (qp_attr_mask & IB_QP_RATE_LIMIT) {
> > +             if (qp->qplib_qp.type !=3D IB_QPT_RC ||
> > +                 !_is_modify_qp_rate_limit_supported(dev_attr->dev_cap=
_flags2))
> > +                     return -EOPNOTSUPP;
> > +             qp->qplib_qp.ext_modify_flags |=3D
> > +                     CMDQ_MODIFY_QP_EXT_MODIFY_MASK_RATE_LIMIT_VALID;
> > +             qp->qplib_qp.rate_limit =3D qp_attr->rate_limit;
> > +     }
> >       if (qp_attr_mask & IB_QP_EN_SQD_ASYNC_NOTIFY) {
> >               qp->qplib_qp.modify_flags |=3D
> >                               CMDQ_MODIFY_QP_MODIFY_MASK_EN_SQD_ASYNC_N=
OTIFY;
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infinib=
and/hw/bnxt_re/qplib_fp.c
> > index c88f049136fc..3e44311bf939 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> > @@ -1313,8 +1313,8 @@ int bnxt_qplib_modify_qp(struct bnxt_qplib_res *r=
es, struct bnxt_qplib_qp *qp)
> >       struct bnxt_qplib_cmdqmsg msg =3D {};
> >       struct cmdq_modify_qp req =3D {};
> >       u16 vlan_pcp_vlan_dei_vlan_id;
> > +     u32 bmask, bmask_ext;
> >       u32 temp32[4];
> > -     u32 bmask;
> >       int rc;
> >
> >       bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
> > @@ -1329,9 +1329,16 @@ int bnxt_qplib_modify_qp(struct bnxt_qplib_res *=
res, struct bnxt_qplib_qp *qp)
> >                   is_optimized_state_transition(qp))
> >                       bnxt_set_mandatory_attributes(res, qp, &req);
> >       }
> > +
> >       bmask =3D qp->modify_flags;
> >       req.modify_mask =3D cpu_to_le32(qp->modify_flags);
> > +     bmask_ext =3D qp->ext_modify_flags;
> > +     req.ext_modify_mask =3D cpu_to_le32(qp->ext_modify_flags);
> >       req.qp_cid =3D cpu_to_le32(qp->id);
> > +
> > +     if (bmask_ext & CMDQ_MODIFY_QP_EXT_MODIFY_MASK_RATE_LIMIT_VALID)
> > +             req.rate_limit =3D cpu_to_le32(qp->rate_limit);
> > +
> >       if (bmask & CMDQ_MODIFY_QP_MODIFY_MASK_STATE) {
> >               req.network_type_en_sqd_async_notify_new_state =3D
> >                               (qp->state & CMDQ_MODIFY_QP_NEW_STATE_MAS=
K) |
> > @@ -1429,6 +1436,9 @@ int bnxt_qplib_modify_qp(struct bnxt_qplib_res *r=
es, struct bnxt_qplib_qp *qp)
> >       rc =3D bnxt_qplib_rcfw_send_message(rcfw, &msg);
> >       if (rc)
> >               return rc;
> > +
> > +     if (bmask_ext & CMDQ_MODIFY_QP_EXT_MODIFY_MASK_RATE_LIMIT_VALID)
> > +             qp->shaper_allocation_status =3D resp.shaper_allocation_s=
tatus;
> >       qp->cur_qp_state =3D qp->state;
> >       return 0;
> >  }
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infinib=
and/hw/bnxt_re/qplib_fp.h
> > index 1b414a73b46d..30c3f99be07b 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> > @@ -280,6 +280,7 @@ struct bnxt_qplib_qp {
> >       u8                              state;
> >       u8                              cur_qp_state;
> >       u64                             modify_flags;
> > +     u32                             ext_modify_flags;
> >       u32                             max_inline_data;
> >       u32                             mtu;
> >       u8                              path_mtu;
> > @@ -346,6 +347,8 @@ struct bnxt_qplib_qp {
> >       bool                            is_host_msn_tbl;
> >       u8                              tos_dscp;
> >       u32                             ugid_index;
> > +     u32                             rate_limit;
> > +     u8                              shaper_allocation_status;
> >  };
> >
> >  #define BNXT_RE_MAX_MSG_SIZE 0x80000000
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infini=
band/hw/bnxt_re/qplib_res.h
> > index 2ea3b7f232a3..9a5dcf97b6f4 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
> > @@ -623,4 +623,10 @@ static inline bool _is_max_srq_ext_supported(u16 d=
ev_cap_ext_flags_2)
> >       return !!(dev_cap_ext_flags_2 & CREQ_QUERY_FUNC_RESP_SB_MAX_SRQ_E=
XTENDED);
> >  }
> >
> > +static inline bool _is_modify_qp_rate_limit_supported(u16 dev_cap_ext_=
flags2)
> > +{
> > +     return dev_cap_ext_flags2 &
> > +             CREQ_QUERY_FUNC_RESP_SB_MODIFY_QP_RATE_LIMIT_SUPPORTED;
> > +}
> > +
> >  #endif /* __BNXT_QPLIB_RES_H__ */
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infinib=
and/hw/bnxt_re/qplib_sp.c
> > index 408a34df2667..ec9eb52a8ebf 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> > @@ -193,6 +193,11 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw=
 *rcfw)
> >               attr->max_dpi =3D le32_to_cpu(sb->max_dpi);
> >
> >       attr->is_atomic =3D bnxt_qplib_is_atomic_cap(rcfw);
> > +
> > +     if (_is_modify_qp_rate_limit_supported(attr->dev_cap_flags2)) {
> > +             attr->rate_limit_min =3D le16_to_cpu(sb->rate_limit_min);
> > +             attr->rate_limit_max =3D le32_to_cpu(sb->rate_limit_max);
> > +     }
> >  bail:
> >       dma_free_coherent(&rcfw->pdev->dev, sbuf.size,
> >                         sbuf.sb, sbuf.dma_addr);
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infinib=
and/hw/bnxt_re/qplib_sp.h
> > index 5a45c55c6464..9fadd637cb5b 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> > @@ -76,6 +76,8 @@ struct bnxt_qplib_dev_attr {
> >       u16                             dev_cap_flags;
> >       u16                             dev_cap_flags2;
> >       u32                             max_dpi;
> > +     u16                             rate_limit_min;
> > +     u32                             rate_limit_max;
> >  };
> >
> >  struct bnxt_qplib_pd {
> > diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infinib=
and/hw/bnxt_re/roce_hsi.h
> > index 99ecd72e72e2..aac338f2afd8 100644
> > --- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
> > +++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
> > @@ -690,10 +690,11 @@ struct cmdq_modify_qp {
> >       __le32  ext_modify_mask;
> >       #define CMDQ_MODIFY_QP_EXT_MODIFY_MASK_EXT_STATS_CTX     0x1UL
> >       #define CMDQ_MODIFY_QP_EXT_MODIFY_MASK_SCHQ_ID_VALID     0x2UL
> > +     #define CMDQ_MODIFY_QP_EXT_MODIFY_MASK_RATE_LIMIT_VALID  0x8UL
> >       __le32  ext_stats_ctx_id;
> >       __le16  schq_id;
> >       __le16  unused_0;
> > -     __le32  reserved32;
> > +     __le32  rate_limit;
> >  };
> >
> >  /* creq_modify_qp_resp (size:128b/16B) */
> > @@ -716,7 +717,8 @@ struct creq_modify_qp_resp {
> >       #define CREQ_MODIFY_QP_RESP_PINGPONG_PUSH_INDEX_MASK  0xeUL
> >       #define CREQ_MODIFY_QP_RESP_PINGPONG_PUSH_INDEX_SFT   1
> >       #define CREQ_MODIFY_QP_RESP_PINGPONG_PUSH_STATE       0x10UL
> > -     u8      reserved8;
> > +     u8      shaper_allocation_status;
> > +     #define CREQ_MODIFY_QP_RESP_SHAPER_ALLOCATED          0x1UL
> >       __le32  lag_src_mac;
> >  };
> >
> > @@ -2179,7 +2181,7 @@ struct creq_query_func_resp {
> >       u8      reserved48[6];
> >  };
> >
> > -/* creq_query_func_resp_sb (size:1088b/136B) */
> > +/* creq_query_func_resp_sb (size:1280b/160B) */
> >  struct creq_query_func_resp_sb {
> >       u8      opcode;
> >       #define CREQ_QUERY_FUNC_RESP_SB_OPCODE_QUERY_FUNC 0x83UL
> > @@ -2256,12 +2258,15 @@ struct creq_query_func_resp_sb {
> >       #define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_LAST \
> >                       CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPOR=
T_IQM_MSN_TABLE
> >       #define CREQ_QUERY_FUNC_RESP_SB_MAX_SRQ_EXTENDED                 =
        0x40UL
> > +     #define CREQ_QUERY_FUNC_RESP_SB_MODIFY_QP_RATE_LIMIT_SUPPORTED   =
        0x400UL
> >       #define CREQ_QUERY_FUNC_RESP_SB_MIN_RNR_RTR_RTS_OPT_SUPPORTED    =
        0x1000UL
> >       __le16  max_xp_qp_size;
> >       __le16  create_qp_batch_size;
> >       __le16  destroy_qp_batch_size;
> >       __le16  max_srq_ext;
> > -     __le64  reserved64;
> > +     __le16  reserved16;
> > +     __le16  rate_limit_min;
> > +     __le32  rate_limit_max;
> >  };
> >
> >  /* cmdq_set_func_resources (size:448b/56B) */
> > --
> > 2.43.5
> >



--=20
Regards,
Kalesh AP

--0000000000005e397a0649d6c734
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
dDANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgBKcVmxxPSLqjIm3lMCznb5FAc7HM
SDI9FpACrHf2/UQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
MjAyMTI1MTE2WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAOS2I/CCC8KOj/kuvAghTQepJcyRfD/OaIrgmy/GfCSjA6y4Bb17CJkT8hQQ4ZC1a
q03c/Hruv+inPEhAXpn2OzPA4qgPAF/CATVxqOBURZbnBsNkV7iojndH2zT7XnJx76IkTkpbt/AA
atCC/MstfYOhzNLtARa/A+fK5gAkXhUq2nT+yIE2masOdk5nTytdu3Do2YMK5ShB9wULUhA+vPjw
dYqw4toadiUb6BPMAD9CY0jvrK/hRDIQS44+0MYb1FDpzrYLvr4O3hDO3qtagW0hY8U35nO+BKbQ
HbzavAYnryHsrvlUxiFAFoKjyxed+/Jmb/UPdD9CV4k/x1Qa7Q==
--0000000000005e397a0649d6c734--

