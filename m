Return-Path: <linux-rdma+bounces-15895-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLv+BKR9cmmklQAAu9opvQ
	(envelope-from <linux-rdma+bounces-15895-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 20:42:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 107086D278
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 20:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D1B43005740
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 19:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184243994B3;
	Thu, 22 Jan 2026 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GtdEzPKB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3F83939CA
	for <linux-rdma@vger.kernel.org>; Thu, 22 Jan 2026 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110657; cv=pass; b=UdbZUn90tAmHDwe96qV5c70p7M+T/C76kLysBaAgxs/nM6fKDZ0oHCSzGVKym3YQL9TVaXe46u3VPRo6q5Z+ZZQnUmZi60ZWWk+vFkz2LZcsdUQzJ/WcqDjod+WDEuQWSnvXxOoKajk0TWQKwv1HS72WiDjfs7Gp7qDFzQo1HnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110657; c=relaxed/simple;
	bh=lrUywm4qp3okgxTxDP29oBdqECLHsQDRhGVjmHVt9Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvIgru0SytiTePwYvKqwKVV2AuHu0M8OxCsG0WrF6VXygZBLv0ExBw830WYMgt3VrnWpNufbFmyD56q8wNZi8dsG3XomuA1tRqZuMAFwmjs5lLAUJRGbsE7NnZDq3qdbb96Em7FyYKmZ1DlPTt3zUETIN4cC2xJ3EZmh9gMKNaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GtdEzPKB; arc=pass smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a78e381fc1so6313975ad.3
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jan 2026 11:37:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769110635; x=1769715435;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVaq0Zp8evbg64Cr1CmsOmwCrxwe+tn3WaioMs2/A2M=;
        b=j6a4A+FwU8Ywu25eQee7pQVNrAcPkZ5/m4F952QSvKm6pNPQWoRdCXg2bcNpn5HB/S
         IUkNSEzXmHeD/3SxwX96/U4J0VTq5SgrSQq44hPDmaSh2yWWnDXywYozCxeF6sdcYv3w
         JCNyOt7ntF0vLf27PDGM+IpnQJ4q6eCnqzW4qFlxkZglPlf4y9e1rdtoQ8TK1dfvCyD4
         HfMzxqLduh2cxZbt8FBpMw6B3MQbzIR/tWXeA0tv0gtJ6wT0fZ27ais2gcc9xF3a+4lY
         GtuwW64x6NzHp05zzPfrbNFr1sOaEjhE82DJE2RU54g0bOiluLh9la5yVu+pR4BWx5D5
         lOmw==
X-Forwarded-Encrypted: i=2; AJvYcCVfXLzD963+7IOSgh7RDdSHl5FuVIjbRPeZh8YviIg5nCeocVBun+lGtRjvjnjgBZLtXXrt1ie6g6jG@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl8J3pSf8UhHcVgkTISjxscLXee+kuD7mHKoGoYHWU5xUCFNuv
	xSdtfccca/TF6t5HkxyHqVUaF9vZyOa5XFnaoLJ1ydSsOkM1GcXuinKN4i3y1mBYIvmPn0lIoX6
	bpStI3FMYHShWsuOj5tZAexBSKTTUvm7Haks+if/dQmylo4BbirAwqVhnXB6GGjImT2Sf4KeYzp
	JOBSqhJFqkjXJCMruHp9BI6w4M3JNC2LAHXaq2h8k2my9qE/6jpQcp0HjIwlNDRV4MJtWxQti+q
	3zigkJQXzIIwEYO7555IeY=
X-Gm-Gg: AZuq6aKhzb/FDlgtRNwzg21cfGsASwD/SvZtrOap9+dRJJ8bsMr3+UiUMdrFH19omoi
	Os6PWHMeKInibsMOxvNF3KilZVBXdpYcse7pxt6orGAI2r5T/NsZUeYduTNpBXKS8RAbf7jkfXA
	ias9e6Bee6Psx0g0G3fRtdTKsqtseMY0LbBkSRsaO2prtB6IxwJkOID7ad7hUg/oAjAqK62IbRN
	g06w8tVAlOuvVFrzdnrlE8/pkW0v8w0Uc9DUShrwsUV9osQAYNXlQacIFHfi71ml9772MjPYi4F
	ELZlrNzgOU8kbuMu1+0kpk4/fOfQCQeZh6ILO7rFVtwf6sVw1mxpii1ojj4kZ5LolJeYnJf0FV2
	yELFeK6QpqVV/Vz71B8w1Ll5XbKh9ewNX3aa4lO6FilaveazIo6gU9x1DOMkHAk3ZP05XLUVTxv
	PdTqIhv6qKdg0IjB/IXVA80ZTbVOJDZ1eE7BwHtNCQ09PcXK2KxRRpBw==
X-Received: by 2002:a17:903:2c07:b0:295:9b3a:16b7 with SMTP id d9443c01a7336-2a7fe45d6dfmr4571755ad.4.1769110634411;
        Thu, 22 Jan 2026 11:37:14 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a802fa9451sm46305ad.53.2026.01.22.11.37.13
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jan 2026 11:37:14 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4802bb29400so19653685e9.0
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jan 2026 11:37:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769110632; cv=none;
        d=google.com; s=arc-20240605;
        b=cNjpTq+AHPeJ6nPjXt29xakJrCZeC9ZF/DZcS5jndoTpp9b6crHkk/WEfv0BWfj5PZ
         VqtERTmVFNXVgxfRheduavYNgAHS8iYGY0FV268yfposPUNO/pYVAmkuRjN+ROBiZYvX
         /j4ueuPoVFSfP0xbWGDyn9jkH1q27S9t9Fn3C+rRRwoYv1tLG1Hs15x2JkS6at7Jsjm3
         +MVvlamK/MQIBuTTadxhfQ82FYnV4l1SBEhPv8FxulDC5SqqXbpdmHULkiw/19X6UoPG
         2VXcXHdPMy5hr+fL431A89ZFB8f182fvJe5GI1iybgvYbfXxLPIdNjv6RL/uNUXfr19L
         3SEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gVaq0Zp8evbg64Cr1CmsOmwCrxwe+tn3WaioMs2/A2M=;
        fh=/1FO7/tvJaefpFNKcoNaJK1eWzF8RU2QZSZ2M3DdBKQ=;
        b=deP7wj2uAZPI4gz++1R61PfMAfNLrz7IHDLiCZSFZ0+AtyztbQ8KoA8rjaa6DXfZat
         X8lctqay7cuSdmz4tvCY9lVCHQyH1vTfDUC1GjiD6PRbopBJbuCkIOKa2nJDP0wuDYed
         02Q1XOT2qLfB3pCWotLnbGqlUfMP5SwkoLCU2UsQWIbYcDGR6pWrwhgkSLXzF5ui3aYi
         xX/HFQazPSfImTIokvjfv85zCMCxE2wr98neKSHeZKeTn/iZauECEJK870O8RBtNfo0G
         hpLFSWz9A1zgcR4nkJ0tMfymzBsH/EoS5TDeB0/wUNOcIfFf5IzzqrXc2hiHOFrWPZep
         oMKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769110632; x=1769715432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gVaq0Zp8evbg64Cr1CmsOmwCrxwe+tn3WaioMs2/A2M=;
        b=GtdEzPKBYHgXGd/O/A7bRPdSepHlyUkD46f9M5AZgO0ijp2Fm2aL8paTtMy/Qdj479
         GaJdf9wUCvxlzrAh5ApfzRZAERU9Suq8e6VXWy3q8u5znuQv0Yt+LdIUdf801xsHXpJl
         oKjOzuJKgVe7LobOFrZu45JBvwKmymvNLIA9c=
X-Forwarded-Encrypted: i=1; AJvYcCWatdieRcvT3Hnba0KN2NRiO0YQqBnrCdocMWcirUoyNptlrOZ4asVaewvrsVOJpydb/NnlleQG30rR@vger.kernel.org
X-Received: by 2002:a05:600c:8b84:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-4804c95cac1mr12707895e9.12.1769110632322;
        Thu, 22 Jan 2026 11:37:12 -0800 (PST)
X-Received: by 2002:a05:600c:8b84:b0:480:1d0b:2d32 with SMTP id
 5b1f17b1804b1-4804c95cac1mr12707545e9.12.1769110631864; Thu, 22 Jan 2026
 11:37:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113170956.103779-1-sriharsha.basavapatna@broadcom.com>
 <20260113170956.103779-5-sriharsha.basavapatna@broadcom.com>
 <k3mj4pl3ifyrva44z4bscpzwgmvctr2stgorixsj2xwtvi6sws@7miulfpsl2zw> <20260122140742.GI961572@ziepe.ca>
In-Reply-To: <20260122140742.GI961572@ziepe.ca>
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Date: Thu, 22 Jan 2026 14:36:59 -0500
X-Gm-Features: AZwV_Qj3nTLWnYaQaXYED4vnthK0A897O_zwZ8GOKxcCqcp296kdeOL6arrh4sg
Message-ID: <CACDg6nWkZTGj=rnHorFBXgTVDoKcb1rPRSgVBnbj9xjh_Uj3Mw@mail.gmail.com>
Subject: Re: [PATCH rdma-next v7 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jiri Pirko <jiri@resnulli.us>, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, Leon Romanovsky <leon@kernel.org>, 
	linux-rdma@vger.kernel.org, Selvin Xavier <selvin.xavier@broadcom.com>, 
	Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d3d1030648ff2a5a"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,multipart/alternative,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15895-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew.gospodarek@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,mail.gmail.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 107086D278
X-Rspamd-Action: no action

--000000000000d3d1030648ff2a5a
Content-Type: multipart/alternative; boundary="000000000000c7fd0f0648ff2aaf"

--000000000000c7fd0f0648ff2aaf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 9:07=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Thu, Jan 22, 2026 at 11:35:34AM +0100, Jiri Pirko wrote:
> > Tue, Jan 13, 2026 at 06:09:56PM +0100,
sriharsha.basavapatna@broadcom.com wrote:
> > >The following Direct Verbs have been implemented, by enhancing the
> > >driver specific udata in existing verbs.
> > >
> > >CQ Direct Verbs:
> > >----------------
> > >- CREATE_CQ:
> > >  Create a CQ using the specified udata (struct bnxt_re_cq_req).
> > >  The driver maps/pins the CQ user memory and registers it with the
> > >  hardware.
> > >
> > >- DESTROY_CQ:
> > >  Unmap the user memory and destroy the CQ.
> >
> > Perhaps I'm missing something, but why can't you use existing create cq
> > with umem extension introduces by following commit:
> >
> > commit 1a40c362ae265ca4004f7373b34c22af6810f6cb
> > Author: Michael Margolin <mrgolin@amazon.com>
> > Date:   Tue Jul 8 20:23:06 2025 +0000
> >
> >     RDMA/uverbs: Add a common way to create CQ with umem
> >
> >     Add ioctl command attributes and a common handling for the option t=
o
> >     create CQs with memory buffers passed from userspace. When required
> >     attributes are supplied, create umem and provide it for driver's
use.
> >     The extension enables creation of CQs on top of preallocated CPU
> >     virtual or device memory buffers, by supplying VA or dmabuf fd, in =
a
> >     common way.
> >     Drivers can support this flow by initializing a new create_cq_umem
fp
> >     field in their ops struct, with a function that can handle the new
> >     parameter.
> >
> >     Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> >     Link:
https://patch.msgid.link/20250708202308.24783-2-mrgolin@amazon.com
> >     Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> >     Signed-off-by: Leon Romanovsky <leon@kernel.org>
>
> Oh! I completely forgot about that, yes, that definately needs to be
> used here too instead of reinventing it inside the driver!
>
> And Jiri is correct we should do the same work for QP side as well,
> the patch looks reasonable.
>

It sounds like Jiri's proposed core changes are the right long-term
approach. We would be happy to collaborate with him to accommodate this in
the next kernel release.

However, based on your comments in the other v8 thread/message, the v8
series will still be accepted and added to for-next, correct?

--000000000000c7fd0f0648ff2aaf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Thu, Jan 22, 2026 at 9:07=E2=80=AFAM Jason Gunthorpe &l=
t;<a href=3D"mailto:jgg@ziepe.ca">jgg@ziepe.ca</a>&gt; wrote:<br>&gt;<br>&g=
t; On Thu, Jan 22, 2026 at 11:35:34AM +0100, Jiri Pirko wrote:<br>&gt; &gt;=
 Tue, Jan 13, 2026 at 06:09:56PM +0100, <a href=3D"mailto:sriharsha.basavap=
atna@broadcom.com">sriharsha.basavapatna@broadcom.com</a> wrote:<br>&gt; &g=
t; &gt;The following Direct Verbs have been implemented, by enhancing the<b=
r>&gt; &gt; &gt;driver specific udata in existing verbs.<br>&gt; &gt; &gt;<=
br>&gt; &gt; &gt;CQ Direct Verbs:<br>&gt; &gt; &gt;----------------<br>&gt;=
 &gt; &gt;- CREATE_CQ:<br>&gt; &gt; &gt; =C2=A0Create a CQ using the specif=
ied udata (struct bnxt_re_cq_req).<br>&gt; &gt; &gt; =C2=A0The driver maps/=
pins the CQ user memory and registers it with the<br>&gt; &gt; &gt; =C2=A0h=
ardware.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt;- DESTROY_CQ:<br>&gt; &gt; &gt;=
 =C2=A0Unmap the user memory and destroy the CQ.<br>&gt; &gt;<br>&gt; &gt; =
Perhaps I&#39;m missing something, but why can&#39;t you use existing creat=
e cq<br>&gt; &gt; with umem extension introduces by following commit:<br>&g=
t; &gt;<br>&gt; &gt; commit 1a40c362ae265ca4004f7373b34c22af6810f6cb<br>&gt=
; &gt; Author: Michael Margolin &lt;<a href=3D"mailto:mrgolin@amazon.com">m=
rgolin@amazon.com</a>&gt;<br>&gt; &gt; Date: =C2=A0 Tue Jul 8 20:23:06 2025=
 +0000<br>&gt; &gt;<br>&gt; &gt; =C2=A0 =C2=A0 RDMA/uverbs: Add a common wa=
y to create CQ with umem<br>&gt; &gt;<br>&gt; &gt; =C2=A0 =C2=A0 Add ioctl =
command attributes and a common handling for the option to<br>&gt; &gt; =C2=
=A0 =C2=A0 create CQs with memory buffers passed from userspace. When requi=
red<br>&gt; &gt; =C2=A0 =C2=A0 attributes are supplied, create umem and pro=
vide it for driver&#39;s use.<br>&gt; &gt; =C2=A0 =C2=A0 The extension enab=
les creation of CQs on top of preallocated CPU<br>&gt; &gt; =C2=A0 =C2=A0 v=
irtual or device memory buffers, by supplying VA or dmabuf fd, in a<br>&gt;=
 &gt; =C2=A0 =C2=A0 common way.<br>&gt; &gt; =C2=A0 =C2=A0 Drivers can supp=
ort this flow by initializing a new create_cq_umem fp<br>&gt; &gt; =C2=A0 =
=C2=A0 field in their ops struct, with a function that can handle the new<b=
r>&gt; &gt; =C2=A0 =C2=A0 parameter.<br>&gt; &gt;<br>&gt; &gt; =C2=A0 =C2=
=A0 Signed-off-by: Michael Margolin &lt;<a href=3D"mailto:mrgolin@amazon.co=
m">mrgolin@amazon.com</a>&gt;<br>&gt; &gt; =C2=A0 =C2=A0 Link: <a href=3D"h=
ttps://patch.msgid.link/20250708202308.24783-2-mrgolin@amazon.com">https://=
patch.msgid.link/20250708202308.24783-2-mrgolin@amazon.com</a><br>&gt; &gt;=
 =C2=A0 =C2=A0 Reviewed-by: Jason Gunthorpe &lt;<a href=3D"mailto:jgg@nvidi=
a.com">jgg@nvidia.com</a>&gt;<br>&gt; &gt; =C2=A0 =C2=A0 Signed-off-by: Leo=
n Romanovsky &lt;<a href=3D"mailto:leon@kernel.org">leon@kernel.org</a>&gt;=
<br>&gt;<br>&gt; Oh! I completely forgot about that, yes, that definately n=
eeds to be<br>&gt; used here too instead of reinventing it inside the drive=
r!<br>&gt;<br>&gt; And Jiri is correct we should do the same work for QP si=
de as well,<br>&gt; the patch looks reasonable.<br>&gt;<br><br>It sounds li=
ke Jiri&#39;s proposed core changes are the right long-term approach. We wo=
uld be happy to collaborate with him to accommodate this in the next kernel=
 release.<br><br>However, based on your comments in the other v8 thread/mes=
sage, the v8 series will still be accepted and added to for-next, correct?<=
div><br><div><br></div></div></div>

--000000000000c7fd0f0648ff2aaf--

--000000000000d3d1030648ff2a5a
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
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGozCCBIug
AwIBAgIMLAiVyur+1MRjdDgxMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNDMwNVoXDTI3MDYyMTEzNDMwNVowgeYxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzETMBEGA1UEBBMKR29zcG9kYXJlazEPMA0GA1UEKhMGQW5kcmV3MRYwFAYDVQQKEw1CUk9B
RENPTSBJTkMuMScwJQYDVQQDDB5hbmRyZXcuZ29zcG9kYXJla0Bicm9hZGNvbS5jb20xLTArBgkq
hkiG9w0BCQEWHmFuZHJldy5nb3Nwb2RhcmVrQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAOP/A/G3pTTF6D8/BCAHpxJpQjOueWirQLqbjFWJTHsh6ADFdvKs+izD
0snfZopX+ZSMfR+NKl12zoJaZy/HTGiXvyeLACXBAP5i8J+smf3H0UZo+ztl9s/CLIxDfjquoQYV
UHAKWXC5euJvZ4N4/n2E35/OV6VV3JeKQHAiSOXhljrejDS6Wk96WYaQKawDm0jYH6OoXDnR/CMn
3bcNBRgaGW5VtJUP5jpTLrsQFC25kFf6fA5/HWLsVdOwkBWic80s6HCG0ROnFWnbLPL49NGItRmc
Cndhx/wUdeIk/qDpB3NiaC0IsvVNnZLIIbEl5kBojwkZV0jD/VicntRDJ78CAwEAAaOCAeIwggHe
MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEF
BQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2Ey
MDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNt
aW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoD
AjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBB
BgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNh
MjAyMy5jcmwwKQYDVR0RBCIwIIEeYW5kcmV3Lmdvc3BvZGFyZWtAYnJvYWRjb20uY29tMBMGA1Ud
JQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQW
BBTQMVctYYJaUBLeJgZz6cT67l9WmjANBgkqhkiG9w0BAQsFAAOCAgEARE5k774M2TzT1K6LUDrm
HBHxHxe8rQpJrB59lyOANT2BjSITyUXPC/Up9ExGhYbioibOJALdaBhATnMgqw03EJLpr7Sy/mY9
g/LlaPMSHU0vcuhuU15DAwQfJ9Liw4K9AmTo0MnPKgiSDLWT8yuphPFiXATg1x8+K1b/KEt8t3Cx
3pY6cGPUH4iJXz801q7ka38emkBlMKS4i7eWgwCSHR/9c7JvlrVYT5+wqYCbmPasbv3jNS0MfEdY
qNLhtJABTy1ePhWmAzFMlbexVyN3FeWCOtxrnnD6tFhYt9dMX2kSvti9voE1cPJfyHj7IhvHVlUc
aBR5GY5F9netDgPvbqg1YpqYZwxblN6i91QhywTGSydHpbgJAmVEEp9rKvGJirwRjORPt0wXb3b6
6BzJD4dFfmqoXVKRl6WHOOICEKWVcD0OnPRdCJEXiSW6y1xobGpElvWmB7lGIE+W9V/Efv17PdJa
/u6hPkFWZBhzmFzEWDSaWvsfJpk3Jb+8oHhOk0IERLc4VLhPNhyMOQq+aL30GjEej1lqr79p5a70
/+WaRxxlypFBMj2V0384P2ACDsYAayPdKSx5aoEJWmW2cc/xR0LxENIsNWeqUBvEjcA6Qud56l66
dGBNtVCEGdHfKttDlWel93rPRa77UmnqEt+6YNFCXnuhaSUJGOA0yxQxggJXMIICUwIBATBiMFIx
CzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxT
aWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgwsCJXK6v7UxGN0ODEwDQYJYIZIAWUDBAIBBQCggccw
LwYJKoZIhvcNAQkEMSIEIAfUkT+pw3cxxPP+m7nwTJ2+R0igG78jT2Xlm+T4XdyXMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDEyMjE5MzcxMlowXAYJKoZIhvcN
AQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0D
BzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAEFDrMfyZbEEGGHy
CT4/u9WuLzBizct10NANvCdDDWngQPfkR/LTBsCOma+oqhlutL6jaq3DWLh2HlpQj+hFoUQcXlJ7
0Mgz/Y1ojynukWJUMmItOfUVNfitegXpWrKE5vffrinrteBj2GccOVfDg902JWhtMpX50BJVq0lw
9ll5FBYtTmZ2q9sWKnNLs4xn+7sAdhQ3koL7YrAFW+kGrdpNsNjQd7CifPrsC8N2EX+GCphnhOXO
rN357ecGr7fNb0KTmoTHjACtCFyLct4y/TDAvepBNdGDqpp9AMCg/rOp9OREhmY5zcpOzFXra3iV
eNNY8xXGI3FIOogArlp1bko=
--000000000000d3d1030648ff2a5a--

