Return-Path: <linux-rdma+bounces-17008-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0C05LeLDlmnjmAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17008-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 09:03:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6002D15CE77
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 09:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39FDA3024979
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 08:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150F81C84AB;
	Thu, 19 Feb 2026 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WnOI0f1K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com [209.85.210.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C9E3EBF28
	for <linux-rdma@vger.kernel.org>; Thu, 19 Feb 2026 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771488220; cv=pass; b=jCJ+8OIzHLlrySn6HLcnKSdvAgXUJsYdIOGHcLN1CRJ/xh/ENiBhmLz00SfsIbKPaoGawrtRyybVem3UjQvMsH74Qvm9tr/aCxmgR+2n4pSnn4v3eiA2qOWBLccvuVUZ7yG17Ai0X3IpPgV6m5mPlO5vHeWqkV6dThproAu/FWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771488220; c=relaxed/simple;
	bh=GOSFpAws0ggIlsu5yJb1zR7cx4sxriiXpwk2KHzF750=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GydnyOaKYABYmTFfULfI3jdZYESGcKbkl6ipamZ3petwDSfRVukdi53rv4XYJ2CYNUKQ/0K82v19SVGYXQS0EMr3VXi0TJ5EXvLR4uG3boTF/jaGvxCRJeQn0pXaWZ/iM9bX4zHOxqtLkZsUgDO3VrR8SAZsYfe/jYjuMIXs4n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WnOI0f1K; arc=pass smtp.client-ip=209.85.210.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f99.google.com with SMTP id 46e09a7af769-7d4c383f2fcso589787a34.0
        for <linux-rdma@vger.kernel.org>; Thu, 19 Feb 2026 00:03:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771488218; x=1772093018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hH3yfIVwD9DVYw8MeDhJmA5SvOU+PL60xyVjhmA+Hzs=;
        b=uJWZPT1dRkYktg95MVK1w0OZScup/k0J4DLWxSAkSee7gu0B6iNuxh6QFizBguWE7N
         KGFVPUqEvB9oXKte6Kuy4BXYfUgBzjMNQqAn1mxJzyuvT9Ld2/uhIAganjgLYTlGgG54
         Y5dyd3uviBARMsXca5BidNF0ad/XS/S8+yAZsqo5pS3pjnL8PstpNzqiJ0vGVkJC019z
         uDTAFy8wjZmFKnt0FKmS3biJ9umWW2jt6sorstjBGi2555nsyMc1c9NLF3o9uF0qNg8B
         KXE2uOSEHdzvmxN1uFWBwvkPdsHaK4P3TOapuaMNLDURC/R9XynqlQDvKKkVu7yuY6rP
         oy+g==
X-Forwarded-Encrypted: i=2; AJvYcCVHASBdqFG10xz+efBA1Hk4A8hAWSvV5oXr3jYa7QbXlbRA+1qG8Iu6IOMpkArsiYFXE4s5KQSEBT9u@vger.kernel.org
X-Gm-Message-State: AOJu0YythD2uZoQUm2tRhCjYBgT1O6AcpIsVsTGfjS2PtBUOr7MnNXkF
	o0sDDiMWZIbX8tn/VQB91zzZP9WvxWDhq45gvYxDtBsgi3jDo/J3KmY3k7MiNY7lu8l9yTz+sNE
	i81IYPrFhEcHavKV92SBZMsQJx7ibGcMHKUaFq2FNzIYUfNwq7MaKXZ23ojZUo1IU5xYL+eCegs
	i24+c4AC4Nb23A7+pEXQiQ9PlQ0YHqDLwexlWM/i1Byy5+4LuULMiOg3C5ABSGTGt+m47E+ZXzp
	BqD5rDYdpzWmyWLCA==
X-Gm-Gg: AZuq6aKXmmGvZmpQDugzPCMEuFsCEeRlCOSubuwWnm2fTCzhaHHewIl1bw4Mpdbtoo9
	LHAyZ3qWOdWPOOgsfsRUFy20mkKitgmz5eUXDiwuGLy8iBQHN1CDaMXV5DoDBA1VZRW0gW/7VJk
	WJ/uKZGLcbVjUVmRdlJNAWh0fJTyOcbjVWpS/OJyoO+v+a4y2ulKjxlOyeTgXBQRlg+GWYN5aTE
	LEqRA5G9+8EHggEL8vhv/jOGwlDltyv4yXr/ObCgdAMLZ6irObNfjZBNFm7uwJkkr+lWf3RwAeM
	z+EAu5ErmxbqF/aQlf5/8Qbaao5Yp3Xutg/25GBv8rqvSnymgdnxadQXl35NyoQeaAaJIpPhoYF
	sqrIZPdOKaO+qgLxSe3FX9JQ8B5JCTKiTwvMnd8lrbQAQTRuieRpCpB6Hv40IgjoZQYd8+clx0l
	RipLdpoUQWRG/d1opmJnRTzV9XdmrKnUwHkvTddcr5dlsHeMnf4UrZTcDgcg==
X-Received: by 2002:a05:6830:6586:b0:7d4:4d3c:c601 with SMTP id 46e09a7af769-7d5127b793fmr1340877a34.5.1771488218159;
        Thu, 19 Feb 2026 00:03:38 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7d4a75cf928sm3545289a34.5.2026.02.19.00.03.37
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Feb 2026 00:03:38 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-658b82db375so583664a12.1
        for <linux-rdma@vger.kernel.org>; Thu, 19 Feb 2026 00:03:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771488216; cv=none;
        d=google.com; s=arc-20240605;
        b=QWzW5b+WB/nR3vcqvsC4dG/6sJauGu/yBTCz6lE7JBiWHpfDjBbmQ0I1oEcZPfBzdb
         wajpQ1Oi+eM2yHyHJYCNaUyvk1u2dr8t8YyFiOOtoQo+at+Ug46UJQ/eaOExizmFcHTG
         zh7uqSipuiMYHp4IW2dc4bwNl0458+d9qVTi34V9nlCN9i1xxhh/j4fmaaFmhZWMs5ie
         ak3lnLDt/jeIorE12J3y54EGydTmR07+4OpyUrACEqXM9B3nhuFPjgFPg1PAXqpe5Woh
         xCPjpDEzTVoEZGAR3szBB+VsiGiImg786U3m3wyvJPqj1BbF+OK45apqO3ZdDbGSpeYK
         Rmbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hH3yfIVwD9DVYw8MeDhJmA5SvOU+PL60xyVjhmA+Hzs=;
        fh=3IAQ6NR6N1xfWxaaOmLv2spIZhIhaO5GQ+5iGj5691w=;
        b=DFZkWiBUUrBWep0sFHm77AvZqFRcV4V9TcEUw9illvwsGxtC5otMBtR6GWyfHiwu7t
         4T5xVlZKbdBSsiKQvgJ4mYKj9O29dSGkuzLoKrm1Fi/Jqhn8quDESVYWKyGim/cE1rKJ
         +ODpvpBnPZzj0AGFjHE6Tx0aSKuQjpmXPJ7/MJh12ZEEHMxOPY+WZgItRdEVcBYjZ0Yv
         q+wXPJxbuBQEkfZzFoeQO2yf1b8zE8USXhwP4IIZFBvBtts6dgXu1Jl3WMpKv5s61sx2
         B3jN05wrDUZnpIGFEUjqtlD6XdCKUvBTf89rFuOcWbdxBz9npVdVaU84ole75o2osP74
         8RpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771488216; x=1772093016; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hH3yfIVwD9DVYw8MeDhJmA5SvOU+PL60xyVjhmA+Hzs=;
        b=WnOI0f1KOCVNMyh5rp34tKG/HJuSeuzxyIb1HQBTKjbLxQ2s8mcGXLmxW1oZVEL8v/
         tMIEq6f0DAcb3v08toeUi0mfKQ1VZ5YjpRTemBsQh5E9a8mFHxZiiJ0JFe3coXee+ai6
         0/OViW9YGDJBAnjSjQ6VvlObYcxEhWcjYiWMM=
X-Forwarded-Encrypted: i=1; AJvYcCXM5ocyFXLd3n0LVmHZjpM2sJXIhH23U7mkkic2V61ArHNHySkT0BnI1yal4nFJBsAjxfSsRYALlFNo@vger.kernel.org
X-Received: by 2002:a17:907:3fa0:b0:b87:fad:442f with SMTP id a640c23a62f3a-b903dc8feb6mr250165366b.42.1771488216024;
        Thu, 19 Feb 2026 00:03:36 -0800 (PST)
X-Received: by 2002:a17:907:3fa0:b0:b87:fad:442f with SMTP id
 a640c23a62f3a-b903dc8feb6mr250162366b.42.1771488215341; Thu, 19 Feb 2026
 00:03:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
 <20260213-refactor-umem-v1-42-f3be85847922@nvidia.com> <CA+sbYW0Gh2bLoPZKzH9u-EcWDTz6mbF3RB=6Q3q=m7YpUpNU6Q@mail.gmail.com>
 <20260216080746.GD12989@unreal> <CA+sbYW0Ba==5Z5fyqjBS1AH8HE37ese2qMiR4+hoY-i8pajzQg@mail.gmail.com>
 <20260217075654.GI12989@unreal> <CA+sbYW2Bzis0E-pLKZ_j3T748YeB8Bt_zM_t2pzh09_TGoUnHA@mail.gmail.com>
In-Reply-To: <CA+sbYW2Bzis0E-pLKZ_j3T748YeB8Bt_zM_t2pzh09_TGoUnHA@mail.gmail.com>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Thu, 19 Feb 2026 13:32:57 +0530
X-Gm-Features: AaiRm50bo7RjFoSNINnjTI9C_jjn-QbeLwsR42tq87l8Ti_pJrpmJEr5FwpDKnw
Message-ID: <CA+sbYW05DLXCAPq55G+3UuiaB=MmpJao69+SbESZPqTD8D21xA@mail.gmail.com>
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
	boundary="000000000000dd8358064b28bd23"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17008-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[ziepe.ca,broadcom.com,chelsio.com,amazon.com,linux.dev,linux.alibaba.com,huawei.com,hisilicon.com,amd.com,intel.com,microsoft.com,nvidia.com,marvell.com,cisco.com,cornelisnetworks.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6002D15CE77
X-Rspamd-Action: no action

--000000000000dd8358064b28bd23
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 4:22=E2=80=AFPM Selvin Xavier
<selvin.xavier@broadcom.com> wrote:
>
> On Tue, Feb 17, 2026 at 1:27=E2=80=AFPM Leon Romanovsky <leon@kernel.org>=
 wrote:
> >
> > On Tue, Feb 17, 2026 at 10:32:25AM +0530, Selvin Xavier wrote:
> > > On Mon, Feb 16, 2026 at 1:37=E2=80=AFPM Leon Romanovsky <leon@kernel.=
org> wrote:
> > > >
> > > > On Mon, Feb 16, 2026 at 09:29:29AM +0530, Selvin Xavier wrote:
> > > > > On Fri, Feb 13, 2026 at 4:31=E2=80=AFPM Leon Romanovsky <leon@ker=
nel.org> wrote:
> > > > > >
> > > > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > > >
> > > > > > There is no need to defer the CQ resize operation, as it is int=
ended to
> > > > > > be completed in one pass. The current bnxt_re_resize_cq() imple=
mentation
> > > > > > does not handle concurrent CQ resize requests, and this will be=
 addressed
> > > > > > in the following patches.
> > > > > bnxt HW requires that the previous CQ memory be available with th=
e HW until
> > > > > HW generates a cut off cqe on the CQ that is being destroyed. Thi=
s is
> > > > > the reason for
> > > > > polling the completions in the user library after returning the
> > > > > resize_cq call. Once the polling
> > > > > thread sees the expected CQE, it will invoke the driver to free C=
Q
> > > > > memory.
> > > >
> > > > This flow is problematic. It requires the kernel to trust a user=E2=
=80=91space
> > > > application, which is not acceptable. There is no guarantee that th=
e
> > > > rdma-core implementation is correct or will invoke the interface pr=
operly.
> > > > Users can bypass rdma-core entirely and issue ioctls directly (syzk=
aller,
> > > > custom rdma-core variants, etc.), leading to umem leaks, races that=
 overwrite
> > > > kernel memory, and access to fields that are now being modified. Al=
l of this
> > > > can occur silently and without any protections.
> > > >
> > > > > So ib_umem_release should wait. This patch doesn't guarantee that=
.
> > > >
> > > > The issue is that it was never guaranteed in the first place. It on=
ly appeared
> > > > to work under very controlled conditions.
> > > >
> > > > > Do you think if there is a better way to handle this requirement?
> > > >
> > > > You should wait for BNXT_RE_WC_TYPE_COFF in the kernel before retur=
ning
> > > > from resize_cq.
> > > The difficulty is that libbnxt_re  in rdma-core has the  queue  the
> > > consumer index used for completion lookup. The driver therefore has t=
o
> > > use copy_from_user to read the queue memory and then check for
> > > BNXT_RE_WC_TYPE_COFF, along with the queue consumer index and the
> > > relevant validity flags. I=E2=80=99ll explore if we have a way to han=
dle this
> > > and get back.
> >
> > The thing is that you need to ensure that after libbnxt_re issued resiz=
e_cq command,
> > kernel won't require anything from user-space.
> >
> > Can you cause to your HW to stop generate CQEs before resize_cq?
> we dont have this control (especially on the Receive CQ side).  For
> the Tx side, maybe we can prevent
> posting to the Tx queue.
After discussing with other teams internally, we feel that the
sequence given by you
 should work fine.  As per the sequence, BNXT_RE_WC_TYPE_COFF should
be available when resize request is returned from FW.
We will test your series and confirm above behavior.
> >
> > Thanks

--000000000000dd8358064b28bd23
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
NZpokDZQlI8OT9860T5yioYoHs4V946nzNxxlimAEBswGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYwMjE5MDgwMzM2WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEARtEz/v/BPo8qIzCNkffdg141yDKn7fU0MKsT
PdquwdEYE2jVRahpFGrhWcsggJUUYPIZXUAPSLFdNByxrumy+WcZVDoDlUjYLHf0pWmPlj0Gtic4
vmidwLdzz2GQxTZAFbSK8I5wQ+oxX2T6+b3bfOHMOix3tBNmPPOeTJj6oGeZcxDxjXLexSFmZxTE
0EY+q1SH1NDoelILCjeABLtWfzb77OadXCKw2FpcS81cUycb3sS1W9WNFdPJ0txoDJnG5MF5DTxg
eF91OaWCGBl86g9XBWavOsZ6y31gIy7Up8GC4tFwAfrVRjbWt/1nSGYb86lSyi/YDo5/Ida5T4J+
wA==
--000000000000dd8358064b28bd23--

