Return-Path: <linux-rdma+bounces-14252-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA87C342E9
	for <lists+linux-rdma@lfdr.de>; Wed, 05 Nov 2025 08:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BEC118C41D7
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Nov 2025 07:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BF62D0C79;
	Wed,  5 Nov 2025 07:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="e7sy115+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819B725291B;
	Wed,  5 Nov 2025 07:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762326777; cv=none; b=M37VdjoS9N87KH7HqfpX1DnLXRX5/SGGsJN84RzqbsmvrXK+HCuSWsTfxSh3U2xH/vTrv+BOQ16UTlgwXwoKnRJZvPAK2NHFbYXcFYkc8xR7dweef4ZmlPJQV8xLpA0mKc+2gfujI8wVBMLADOdOhCdOYqktsRga+FgaYGENnJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762326777; c=relaxed/simple;
	bh=e6xxS2KcAuUEtj6xiPqplUbCE/tjj/nNZKvuVlT6zUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Awd7ibX4QeBRxz+H+Py4NECrqrkqtV8AS9iKVM25oBrvndpU30/xZlhexw1If/dDM9AMTOsafmEPfjdgTmphQBwkgbYwpKOKGqgDbZKza4gjocNfWevX1LQGz/oYUXMbB0LCuantNDOrbxu4ir1h4GSTD1HMCCTT0Ni8xarQ30Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=e7sy115+; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762326765; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=tDwgROlxpHCEod2UJ8fw5P9DnURew1R9BGzDCvNPSec=;
	b=e7sy115+Rsmmn5ij9nWNwlu0CPcJ6MGVV/CDf42SajNf0346+3W9RtCU8USO3EgWEfZSLE8bI8qhb6FjbBum3TrGEsF+5+7Vnt9tIamY4Q9IZOKh5MNiljd/mZc9WOQSz4ojt98ikgXfOfwTbPlLhJ3RJKO8W4b17WLMusvfdSw=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WrkOLwv_1762326764 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 05 Nov 2025 15:12:44 +0800
Date: Wed, 5 Nov 2025 15:12:44 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, mjambigi@linux.ibm.com,
	wenjia@linux.ibm.com, dust.li@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, kuba@kernel.org,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com, sidraya@linux.ibm.com,
	jaka@linux.ibm.com
Subject: Re: [PATCH net] net/smc: fix mismatch between CLC header and
 proposal extensions
Message-ID: <20251105071244.GA87813@j66a10360.sqa.eu95>
References: <20251031031828.111364-1-alibuda@linux.alibaba.com>
 <95bd9c85-8241-4040-bbd0-bcac3ffc78f7@linux.ibm.com>
 <20251104070828.GA36449@j66a10360.sqa.eu95>
 <5f415b7e-3557-4fa0-a0f9-f5643c1c7528@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f415b7e-3557-4fa0-a0f9-f5643c1c7528@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Nov 04, 2025 at 09:51:09AM +0100, Alexandra Winter wrote:
> 
> 
> On 04.11.25 08:08, D. Wythe wrote:
> > On Mon, Nov 03, 2025 at 09:28:22AM +0100, Alexandra Winter wrote:
> >>
> >>
> >> On 31.10.25 04:18, D. Wythe wrote:
> >>> The current CLC proposal message construction uses a mix of
> >>> `ini->smc_type_v1/v2` and `pclc_base->hdr.typev1/v2` to decide whether
> >>> to include optional extensions (IPv6 prefix extension for v1, and v2
> >>> extension). This leads to a critical inconsistency: when
> >>> `smc_clc_prfx_set()` fails - for example, in IPv6-only environments with
> >>> only link-local addresses, or when the local IP address and the outgoing
> >>> interface’s network address are not in the same subnet.
> >>>
> >>> As a result, the proposal message is assembled using the stale
> >>> `ini->smc_type_v1` value—causing the IPv6 prefix extension to be
> >>> included even though the header indicates v1 is not supported.
> >>> The peer then receives a malformed CLC proposal where the header type
> >>> does not match the payload, and immediately resets the connection.
> >>>
> >>> Fix this by consistently using `pclc_base->hdr.typev1` and
> >>> `pclc_base->hdr.typev2`—the authoritative fields that reflect the
> >>> actual capabilities advertised in the CLC header—when deciding whether
> >>> to include optional extensions, as required by the SMC-R v2
> >>> specification ("V1 IP Subnet Extension and V2 Extension only present if
> >>> applicable").
> >>
> >>
> >> Just thinking out loud:
> >> It seems to me that the 'ini' structure exists once per socket and is used
> >> to pass information between many functions involved with the handshake.
> >> Did you consider updating ini->smc_type_v1/v2 when `smc_clc_prfx_set()` fails,
> >> and using ini as the authoritative source?
> >> With your patch, it seems to me `ini->smc_type_v1` still contains a stale value,
> >> which may lead to issues in other places or future code.
> > 
> > Based on my understanding, ini->smc_type_v1/v2 represents the local
> > device's inherent hardware capabilities. This value is a static property
> > and, from my perspective, should remain immutable, independent of
> > transient network conditions such as invalid IPv6 prefixes or GID
> > mismatches. Therefore, I believe modifying this field within
> > smc_clc_send_proposal() might not be the most appropriate approach.
> 
> 
> 'ini' is allocated in __smc_connect() and in smc_listen_work().
> So it seems to me the purpose of 'ini' is to store information about the
> current connection, not device's inherent hardware capabilities.
> 
> Fields like ini->smc_type_v1/v2 and ini->smcd/r_version are adjusted in
> multiple places during the handshake.
> I must say that the usage of these fields is confusing and looks somehow
> redundant to me.
> But looking at pclc_base->hdr.typev1/v2, as yet another source of
> information doesn't make things cleaner IMO.
>

That’s definitely a reasonable way to look at it as well. If the community
prefers this interpretation as more natural, I’m fully open to it.

I’d like to do some testing first, as I have concerns about
possible side effects from directly modifying ini and if nothing
problematic shows up, I’ll send the updated version with this change.

Best wishes,
D. Wythe

