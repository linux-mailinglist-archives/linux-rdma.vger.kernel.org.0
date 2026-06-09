Return-Path: <linux-rdma+bounces-22037-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U9XmIi2kKGolHAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22037-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 01:39:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8BC664D29
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 01:39:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=GcJ+PaQl;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22037-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22037-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C97A303D74B
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 23:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50DF3F5BDB;
	Tue,  9 Jun 2026 23:39:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3DD3E4C87
	for <linux-rdma@vger.kernel.org>; Tue,  9 Jun 2026 23:39:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781048356; cv=fail; b=kQeKangHPWbbdYK29V2zhGI68Ri3BlT44JalW8xJz/ARPstrteRNStwCXXiWh+1vO4poeJ38nenJv3neXuQH8GHVXuYKwpOyA8XQSLuIxO6JN74DbFCW2p9KQVoQ0erYx10kG1adr66pyjkVusOtia7NzpOhqUekwVqH7RRij64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781048356; c=relaxed/simple;
	bh=GJd2gJZmlAgFMCFkHrHwJ2yIaE6MPUQzzzENfnpUb+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfCVhnkyGvrZ/xCWA51QWlmvnFrBnIVFp6n927099DjAAPoEvKFJHBBm6lLGmX4fYusPgh2Sb4m//RHkBWAAr2ucgHWf+EkwOwRzeIFm79/6rT6skieJHPTdsJJ8uGPXTshQOpeFYztX6BV8WJw4YMuSRjfYHzvzb/R07YakHA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GcJ+PaQl; arc=fail smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 659GTJW11835845
	for <linux-rdma@vger.kernel.org>; Tue, 9 Jun 2026 16:39:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=GJd2gJZmlAgFMCFkHrHwJ2yIaE6MPUQzzzENfnpUb+A=; b=GcJ+PaQlVJQW
	/QiaOOTC0nYPA6Pp1uWg5Nw0lxfOPK46wy3QRjqt6HHI/s8hYflLqOpkQeAGxxLh
	hoyKhwGK2JX4YooWC50qu5EDWSMax2nyL/oD/rrE9huRAKUD3dcFOCQPD6EbqIBe
	/w0OyjcqD5OfnfePJGKHwyaQUFmf3+Tzo3fYXQ5XrBU7OcozGO9AnrRjAwvSdxcY
	Crl7znQ4/d1k0Z7Rho184bTWuJJxHxuMZzLmmMtWby4mzLYkfL9hkRHA6cnRmNak
	77cxz9A7UldkmH6wLB52VlDZREdWuq79DRuezb/llSLMmzA0JKqEm6HamQd79ptg
	ldQYgc2yiw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by m0001303.ppops.net (PPS) with ESMTPS id 4eppd52tud-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 16:39:12 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6f905ea78so11215810a34.1
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 16:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781048352; cv=none;
        d=google.com; s=arc-20240605;
        b=ISlbY/Ub4p4/V9I91ugKdc0FnEZSUADuo3t4wUCZDaMS7oz9hVsxtT2bVWUvhDlxZE
         vZ0JTZfjZ6B4Wjv4JiljY1FFdzr9vBfwZghYe9+d26Px0QWps0sZkf1oR/hbmTjC5SWV
         oSNXM8N3syVN8i1gGyU/mIY9WhJH2eQwBFULFu2g9pHUn0zhmgT3uEeJ6aYKpICrBIWy
         RYVqZUfYn0MFaG7wClduqZmUv3XzviNjbMzj+6SuMHO4CgPPnj/wvZhljtxmIlNA6yse
         C2zBwP3J6pQm4Z+rB9ysFFZ+jEmcBZH/8pMSgQvaNiy1S/ZjwMBJdRkRAlUFRpg3Eau4
         ObMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=VHRS+sWMPwoxZ0n+tLXpfsQUcezlTBJw4Sj0yHIKfGE=;
        fh=k7m6V/KCbMwJPCO8R9YXs79GyxAy5j4bF1OI87g9EXY=;
        b=LroQRY7SeO2s9Os+EqVU/YHKfkvXrq4C6lFvAHVJMU8aF5SXvK5o/nresBYfuXMVJl
         PvbtG3hpMQeOJbjQcNacoQO4H9QeUePYolRdW0OgXS89Xo8O6g3az52+YyvBqEM5FctK
         UgAot/eyV2lblCLH7xUFDL2Txzbgdp8xGKU0dnMtelCdKHsCZWXrb0E91+J+sO65cBi4
         UPmqNZlq+HPuIlAkRyGReCQRYO4IcywKdt54GH7wneLIM4yjPdA8XDJKILIcRyzfrQQ2
         O1flVHgxN/ty9h/SznrjohJGvLXtOTtQSf09GUQW7u858roQBi2bRG2qOLVP3ODCG7Vy
         dj+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781048352; x=1781653152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VHRS+sWMPwoxZ0n+tLXpfsQUcezlTBJw4Sj0yHIKfGE=;
        b=rRpBao+psn/qpQCBkbKJyXF8H6XL3DaFOwCeNcc+3Ml2h5B/cxHYU6Kl2kGB8FhRrl
         tjLyijWv01CDeEw5XcFFGH7rrj01iwgol9xjXtRXS1u5b7YelrO+54cmQ6tpGfZ1S3kg
         K8uBvcPRe7sYAvbEjVde7TomWG1gSPTNjaTh6FAWauiD3A2/2fM0jL58CSHg6MIDrCST
         g/BeVVL1eEErAGnVBYUCiLt9zAm+q31k+gmBpKvHAcDkNObTqtDoVyXe4dJNECRIZ8DX
         f7U5fE9NBxa4kpMtsvI0tj5mekLuBax7lFPEVnnOamky1GoDsMLTqshkSC4z4C+u7Dsz
         h9Wg==
X-Forwarded-Encrypted: i=1; AFNElJ+H5RYAVsJwN0eA8doKJjUi8RK718hh9gzmnmAg/cqCo3DMwqVWF7tI8l0LUHD9jCP+NA/EKrHNeppA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6t3Y5QFZyKUtQJtaFMO96D2W8aRehqOMMoys1WcxzsYVdYObx
	q2XaSJ/rAzOFzaXyORvkYXYLZW24mLKoBbh1EsTFUifbqiSiv81AhwZ9x/w2dCE7IK4zvzE/Ij7
	yLLgI7Q/Wfq01xLcmyeMpaROh1sNsLAclP0oQEBOGp4vzRW3grmRIE8cZFC90eK6dKNbLzza+Il
	EiYH9jQTyxnPCIfu/EwGbkYNLAr854WZy2tztc
X-Gm-Gg: Acq92OGfqamGAhRK8RDql2HTLv6eHlvEc/W0HbxztkTlz5wFt/0KspwPqSyz+oHgifu
	cFTq46hsR94PT0c6zmvJGpEJTROss4bO0CBba0vpUsbAkpZhmSUjWVHK6+J/DFlwJuXWcPeUBQZ
	lid0vjbJUhaBRleAe3uNeMjC9WNKhuackxBGJoXQyl9DyjARV2ozJf7tIc+o56BYvDN/a+HmSWD
	xYWWtBh/7Jx0aQAGRP5BNgUmCNMEQ==
X-Received: by 2002:a05:6830:6108:b0:7e5:68d0:462d with SMTP id 46e09a7af769-7e751abe2fdmr3883334a34.19.1781048352050;
        Tue, 09 Jun 2026 16:39:12 -0700 (PDT)
X-Received: by 2002:a05:6830:6108:b0:7e5:68d0:462d with SMTP id
 46e09a7af769-7e751abe2fdmr3883310a34.19.1781048351521; Tue, 09 Jun 2026
 16:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608185646.4085127-3-zhipingz@meta.com> <20260609195612.GA85322@bhelgaas>
In-Reply-To: <20260609195612.GA85322@bhelgaas>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 9 Jun 2026 16:38:59 -0700
X-Gm-Features: AVVi8CfvpQJ6ajVUxnazmY-1cK1d-x3MxGzuw2_lfYAMYCTtvbg2jMZaGu0O5NM
Message-ID: <CAH3zFs0u7qJ9JsfweOw_r0FqNUpixLvawZKp9pUTcWWQN6nZjw@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] PCI/TPH: expose enabled requester type and
 capability helpers
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: oyNUfX_F5rW_2ZaDWKl4FBv_RxR0wEfQ
X-Authority-Analysis: v=2.4 cv=FNYrAeos c=1 sm=1 tr=0 ts=6a28a420 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=1XWaLZrsAAAA:8 a=earV_t7fcAfV2sAEFq0A:9
 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: oyNUfX_F5rW_2ZaDWKl4FBv_RxR0wEfQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIyMyBTYWx0ZWRfX+F6IeohhbeNc
 gR3OjrJHKsPXU4lI7h5OtTK1WIHV7VMnkIPsXpIleu6KSeBSiDFz/THwCIsUKuhpbU0t+9bb7PC
 JsuxcJrCilhncQCdYQ8u0cYJXsE/Nk2lKzYye1VAavKOrRQzNvM5rxwVRY5MshfFbjCmUdtXdtF
 I73gdhbCEGmH/TviN4p+oVCR9hExIuVRyvoW3BSgmUJjD4QkyHDk3tScq9CJOm1b4KbrbBwBSLe
 TyvGu0zEQxHy7K9ZWsUw79UWJRkfX370GldSyvrXXvx5GrXVQ1f6N56cfLyO/rJ9g8T5ABaw9lL
 RPPsxVEw/6DLFtJJEGTEj4X41X+u8OTr35wptvq4uYAYEQuDzd4N9wo8Gnez9+uKy/VHXjXG/tv
 ia7nffeV4ByFJahjlY84hsQEKJXB8Yye7iaITcAF7RviQWPteEts9vzG49PAJfi+iDOqNy434YQ
 znAtFP3vKFnaHiswmUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-22037-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:helgaas@kernel.org,m:alex@shazbot.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:netdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:kbusch@kernel.org,m:yochai@nvidia.com,m:yishaih@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[meta.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B8BC664D29

On Tue, Jun 9, 2026 at 12:56=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> >
> On Mon, Jun 08, 2026 at 11:56:39AM -0700, Zhiping Zhang wrote:
> > Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> > requester mode without reaching into pci_dev internals, and
> > pcie_tph_supported() so they can test whether the device exposes the
> > PCIe TPH Extended Capability without doing the same.
>
> s/exposes/advertises/
>

ack, will fix in v7.

> > This keeps pci_dev::tph_req_type and pci_dev::tph_cap inside the
> > PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for callers.
>
> Update subject line to match capitalization of history
> (use "git log --oneline drivers/pci/tph.c")
>
> s/expose/Add/ in subject.
>
> ("Expose" suggests that the interfaces already exist and we're just
> exporting them, but these interfaces didn't exist at all before.)
>

ack, thanks for pointing this out!

> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>
> With the above,
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>

Thanks,
Zhiping

