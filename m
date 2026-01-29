Return-Path: <linux-rdma+bounces-16178-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNvJALLwemkiAAIAu9opvQ
	(envelope-from <linux-rdma+bounces-16178-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 06:31:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 802CAABF07
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 06:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE4E6301A161
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 05:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A332D77FA;
	Thu, 29 Jan 2026 05:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PckVail+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3899925332E
	for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 05:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769664680; cv=pass; b=TY8rL/PFaG3vi9iMYksawrbipk6jiUEakOYoE2xlUDWusDPvs0FHVclaQ7dPTfTs4JRBOkHrEyuBvlgihv+utdhcIaM1/2bazHN/bgEiXZFkCIJq937/I/eMasveAZc51krWM5rMz5eMpN67TXpYDatpnzVO5pYD1chgxly0qhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769664680; c=relaxed/simple;
	bh=rCfJe3nJMbW6hGo1pL7MWanS1Gv6O2GGk//61Ek+mLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngxhO/WLG1/qztIr/w/gemx7Wlh6PYGHtdctOw/LvbQEyTG3RDpnn/GUiru2swtr1fgDtm/Ckxx1E6siVsb31hFL5ZHGdUkj7JnQFo7OH5t8usx17VS48/c2q806l5OGc02XvnOrzq+XoGe3gR39/6tSLwcsqsW8ZtF2sCI3sc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PckVail+; arc=pass smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-644715aad1aso774445d50.0
        for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 21:31:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769664678; x=1770269478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SN94bhaHNJUHtLZnEt3io0vWm1n4xIpErNO5/PTudyc=;
        b=KBXTdbCjzQ6CswR92UD6D4ja3hI9dXrUhSKMLaC5mSAfVTmTAyeVnowwxPxGLbysbY
         9zD+alKMo/ejBea1WFoqjSCXtNKiKJfTAcTzZbNeiRGuSd/90Kbtd+qSSLXqpNCXri0q
         vPwOfFn2WvgboU0xGKhBoCrCyHjc1acIiqAKVCiX6juw795BeWtJT8tfZUG706GVX0FH
         D4ErIIBQbtgtpyvYulp+R6k72S9L7y8/CEOGlHwekTwqWR+/O8JS304rSgsmyOI/j3kO
         cdEbtWbRjq6t694RNq8k/cAEjpGO2UOE3SOkUJ5UexgTw9LYJLMqZ4H1At5AUUBeuY6R
         yWLw==
X-Forwarded-Encrypted: i=2; AJvYcCWwo4oieA0ZXROXaK+cpKGElIU1gn/GeGgS8E/iDpQ3cqZ2SmneI1v9jQat0bZyKASUoRblOFmn5aaN@vger.kernel.org
X-Gm-Message-State: AOJu0YzUqNlxwfdl5L6ZpLuKHoPPkBGMty/7c3fWdhPBORH2qmudmi1N
	YL9IehGz20J9jliKW+V/h9XaJ5eq8Tru86o4Eg/0kINs3vdXQXP3N04LWtp/AESpRVJS1lVo5Ob
	wKOljl4KLZ22AUtEqlBda+3AaAVkVgLRRA9bs/5U3A7L1HcX2h6NxOu2Vrmf4wr5ndxhxFnp0XW
	EqeYqwH2H2lVtrZ4YqM7ZSHY5vsmMimK0n8uayYc8CU++RdGQEkpqltgKliPC1ZFlSja12YqTp1
	PtWZVZD4bV9vovAgw==
X-Gm-Gg: AZuq6aL4NN/8mFVMPnUQQWqzcQJ7W3NCK1m8/ZB48lr/0Ul7hcJA8Jq3/BtVcgvsC2b
	F5beFOJPAL/e5rdXFbdy7GNhppFSr7uERAIf476Foz6kVqaEh1PIDtX3XulcfIwjRTwc7mrDqpi
	1839w3tqw9uDHgc2cDzWbM8dgXKhV92iajygsXEbT4jCIsmizQ7Qj3r2Hmt9QXH602Igzhhfa/E
	xqpVXC1e7CMA05ItDr4EKmN08q3adlleaxt8sEO5NnhnsPP/G54H89HidTNQmKxDadKOGcIBCOY
	TQ03APjgeFsgf3b+yPr5VC5lWSHvlnsPduwdzT8KpbkquZ9SJnfHoqns46DGHOe3aZBYMQkXK3h
	Q69Jnl0nEzq1B60KpRz2JKPhWTp+nHIJuMjqs494rCv5vcxBMQYwJdgTryeTQj7Yovg5IqOiGZs
	VEN70F4QSs8xYxuxE5yTqwyhRz7AZusx2uwNIcwM69t5Y=
X-Received: by 2002:a05:690e:12c1:b0:646:5385:7125 with SMTP id 956f58d0204a3-6499f08466amr1442139d50.46.1769664678042;
        Wed, 28 Jan 2026 21:31:18 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6499610162asm381874d50.12.2026.01.28.21.31.17
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jan 2026 21:31:18 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-4097bb790e5so3026187fac.1
        for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 21:31:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769664677; cv=none;
        d=google.com; s=arc-20240605;
        b=cltpsE/n0VsisNjdCwp6nIsUCNompgYSrVYoUOlUtrnabPK7wKBdQ4299u/D9XDPyY
         G9bdPVd5NoaC9RG+E3EMSfJKwe2iIKpG0MUspA1W6VtyFzoQEgh22R+7IiOcUGTXE53W
         uO1Tba51E5J1uacXQtzPuAV7w290qsbyCDl05MsbFSAJkD+cEyPsKP4Rgk3zVX5rU32w
         /tUJYEqVxIrmE8lMn2ozF9uHjFUMMTgATJv+MQ+kLQzks+JNI3fKw+rUbPpK4nRWhnC4
         GQJ4sHe45DVIURcENaE6O4su556zytcIWLR5UdWo+WGFhWcwkMv0MmB4f3CSFXQZsba9
         rDGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SN94bhaHNJUHtLZnEt3io0vWm1n4xIpErNO5/PTudyc=;
        fh=zvIzEgb3vyp6wTgEZkXaG2gGqQchPvUlk3PlQ+b0KkM=;
        b=h5SYcWOmt+MZpkJS8TEfriTfurnDBeBiElyHwxRNQ70uDSv8noBfupGvPs5TDUDZDy
         3cbptBiVD/vH54hQ7N/sSB2McDDz05xARR7beNEJFA3HXl8uYoeg4fNVhJUGDkxgZejP
         jNpQs25lyfkY701ui4gL0RO/HTSRyilMMA9l4WxkPuQcnDlmcypYikxkOAfrj7zjKU1x
         tRfy1lJTy7lglVDFrTOfrNrsp/qBfmJB2ppNk+Kf9Ko8RCc9qVWUfdUoazPdtAdVfLkE
         e+ubing2/XIv9owRQiFIloagifDZwJcTcknyujg/nxJmr1TsYYfB6P6TqQXH+DdfAOvY
         mlbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769664677; x=1770269477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SN94bhaHNJUHtLZnEt3io0vWm1n4xIpErNO5/PTudyc=;
        b=PckVail+GhCMZeTBXyrIAY6lL4wVUMulL7seZOU24KC81iMq4NfVHtsQaARU3V7+jj
         2jPNyU89mW7B3gx//vXnHnzywqu9CbXhbUxpJhlp3/q1jJs4Zj3TvkT4Mb+fZN7VFkkq
         Zx5K3/czA4PrPvmVUxAOWSYJCkloxQRdYM4iY=
X-Forwarded-Encrypted: i=1; AJvYcCWPSbYuVshaeqil42CWXsec1l/SPKzvbIQd+CwpNoSqQE/VJ390PDKsLnA9Tn3ve3xUqo6AYyWwynUk@vger.kernel.org
X-Received: by 2002:a05:6820:4510:b0:662:b59b:ae37 with SMTP id 006d021491bc7-6630616b309mr915193eaf.21.1769664676897;
        Wed, 28 Jan 2026 21:31:16 -0800 (PST)
X-Received: by 2002:a05:6820:4510:b0:662:b59b:ae37 with SMTP id
 006d021491bc7-6630616b309mr915182eaf.21.1769664676491; Wed, 28 Jan 2026
 21:31:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116091808.2028633-1-kalesh-anakkur.purayil@broadcom.com>
 <CAH-L+nNFR8broz0i6ddQPrGL38AO1ZVaSRdXe9AcEafT3Sqeaw@mail.gmail.com>
 <20260126201857.GP13967@unreal> <CA+sbYW3dLsVqXcaG9xYdh-YRpdf6-ZjrMKRCBnapMY+gFzoA2w@mail.gmail.com>
 <20260128121733.GA40916@unreal>
In-Reply-To: <20260128121733.GA40916@unreal>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Thu, 29 Jan 2026 11:01:04 +0530
X-Gm-Features: AZwV_Qiqu6VCJI5yHvExLDGLP9LSL4IZJb2wuC4CH2ps91_uPT0hlhuLxHo2lOw
Message-ID: <CA+sbYW35DNNFg=2NBOXDwJX3U=oh4JptjuQ8qLY9zxGdTOof9w@mail.gmail.com>
Subject: Re: [PATCH rdma-rext 0/4] RDMA/bnxt_re: Add QP rate limit support
To: Leon Romanovsky <leon@kernel.org>
Cc: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>, jgg@ziepe.ca, 
	linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007465c30649802a17"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16178-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 802CAABF07
X-Rspamd-Action: no action

--0000000000007465c30649802a17
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 5:47=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Wed, Jan 28, 2026 at 12:33:57PM +0530, Selvin Xavier wrote:
> > On Tue, Jan 27, 2026 at 1:49=E2=80=AFAM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > On Sun, Jan 25, 2026 at 09:47:05AM +0530, Kalesh Anakkur Purayil wrot=
e:
> > > > Hi Leon, Jason,
> > > >
> > > > A gentle reminder. Could you please review the patch series?
> > >
> > > Sorry for the delayed response. The idea and implementation look fine=
 to me.
> > Thanks you for your response.
> > > What is missing is a clear and well-documented definition of the sema=
ntics
> > > of QP rate limiting for RC QPs.
> >
> > man page of ibv_modify_qp doesn't have much information about rate limi=
t
> >
> >  struct ibv_qp_attr {
> > ...
> >           uint32_t                rate_limit;             /* Rate
> > limit in kbps for packet pacing */
> >        };
> >
> >
> > attr_mask:IBV_QP_RATE_LIMIT  Set rate_limit
> >
> > This man page contains only the required field for each transition and
> > doesn't mention about the optional flags. Do you want us to add a
> > section for the QP rate limit in the notes?
>
> I would expect the changes to be in https://github.com/linux-rdma/rdma-co=
re/blob/master/libibverbs/man/ibv_modify_qp_rate_limit.3
will update this with the QP types supported.
> and your driver implements .modify_qp_rate_limit() callback in rdma-core.
This is already done in this pull request -
https://github.com/linux-rdma/rdma-core/pull/1692

Thanks
>
> >
> > >
> > > How should RDMA_READ or small RDMA_REQ packets be treated? Are respon=
se
> > > packets included in the rate limit as well? It must be documented in
> > > man pages.
> >
> > All transmitted packets (including rdma_read request and other request
> > packets) will be part of rate limiting setting for the QP. In our
> > implementation, the ack packets are not part of the rate limiting of
> > the normal transmit path. READ data response will be rate limited at
> > the peer side, if the rate limit is configured on the peer side.
> >
> > We have another question. Existing implementation of IB_QP_RATE_LIMIT
> > is applicable only for raw ethernet QP. With this change, we will
> > start supporting for RC QPs also. So mlx driver can also get this
> > request for RC QPs, but it will silently ignored as the QP type is not
> > Raw ethernet QP. Should we fail the request instead?
>
> We should return something to users, since it would be surprising if a
> policy-related feature simply failed without notice.
>
> The tricky part is deciding how to expose this so users can anticipate it
> up front, especially since we're dealing with a generic verb.
>
> Thanks
>
> >
> > Thanks,
> > Selvin Xavier
> > >
> > > Thanks
> > >
> > > >
> > > > On Fri, Jan 16, 2026 at 2:43=E2=80=AFPM Kalesh AP
> > > > <kalesh-anakkur.purayil@broadcom.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > This patchset supports QP rate limit in the bnxt_re driver.
> > > > >
> > > > > Broadcom P7 devices supports setting the rate limit while changin=
g
> > > > > RC QP state from INIT to RTR, RTR to RTS and RTS to RTS. Or, once
> > > > > the QP is transitioned to RTR or RTS state.
> > > > >
> > > > > First patch adds stack support for rate limit for RC QPs.
> > > > >
> > > > > Second patch adds support for QP rate limiting in the bnxt_re dri=
ver.
> > > > >
> > > > > Third patch adds support to report packet pacing capabilities in =
the
> > > > > query_device.
> > > > >
> > > > > Forth patch adds support to report QP rate limit in debugfs QP in=
fo.
> > > > >
> > > > > The pull request for rdma-core changes are at:
> > > > >
> > > > > https://github.com/linux-rdma/rdma-core/pull/1692
> > > > >
> > > > > Regards,
> > > > > Kalesh
> > > > >
> > > > > Kalesh AP (4):
> > > > >   IB/core: Extend rate limit support for RC QPs
> > > > >   RDMA/bnxt_re: Add support for QP rate limiting
> > > > >   RDMA/bnxt_re: Report packet pacing capabilities when querying d=
evice
> > > > >   RDMA/bnxt_re: Report QP rate limit in debugfs
> > > > >
> > > > >  drivers/infiniband/core/verbs.c           |  9 ++++--
> > > > >  drivers/infiniband/hw/bnxt_re/debugfs.c   | 14 ++++++--
> > > > >  drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 39 +++++++++++++++++=
++++--
> > > > >  drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 12 ++++++-
> > > > >  drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  3 ++
> > > > >  drivers/infiniband/hw/bnxt_re/qplib_res.h |  6 ++++
> > > > >  drivers/infiniband/hw/bnxt_re/qplib_sp.c  |  5 +++
> > > > >  drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  2 ++
> > > > >  drivers/infiniband/hw/bnxt_re/roce_hsi.h  | 13 +++++---
> > > > >  include/uapi/rdma/bnxt_re-abi.h           | 16 ++++++++++
> > > > >  10 files changed, 107 insertions(+), 12 deletions(-)
> > > > >
> > > > > --
> > > > > 2.43.5
> > > > >
> > > >
> > > >
> > > > --
> > > > Regards,
> > > > Kalesh AP
> > >
> > >
> > >
>
>

--0000000000007465c30649802a17
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
02yTcEz9whxZLCy80GnmxjVovkQjdF5XJRerT/pANfUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYwMTI5MDUzMTE3WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAtpayb1krMZWyLnclgyiSq8hS/UgjwO58R4sW
v5xG3HmW2JRLnAgU1z/DOcwLsXtfmYivMaNsG+hvWW3cni8vEJ2GW+mdbTTY9jNn7lE9sgGM9WHo
/52hdCA9Rpf/B6boIHRIRL8pQ5IgojVwTk/PjZpf1iAjpywOmWj/K+JqnEgw+V1Wewl92HW/t52o
8IVOivn5RGOqzU4kSaBYtvMrTRgxG/DO1VBFAqOrKe2RVQqu6bTAYJ6n2mJhbgDIOi5TeHNg2DW2
2VVL9+EiS/3E2GDZDGsUegccaIbQRy/Cngz0mD8jcWkUlCslVhUZQhM+RUiih1Pr+b6DDV7Z6YwN
wg==
--0000000000007465c30649802a17--

