Return-Path: <linux-rdma+bounces-18126-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO5+B0EBs2mQRQAAu9opvQ
	(envelope-from <linux-rdma+bounces-18126-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 19:09:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC4527706C
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 19:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 345643018060
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 18:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B683FEB29;
	Thu, 12 Mar 2026 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="amCrJEYr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B0F3CCFDF;
	Thu, 12 Mar 2026 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773338938; cv=none; b=cY2SnUskQP0ObDfR5djDqUt7xISh9+01S+XU6qOACqE55/zzc3echFdhPPuCRkkQ97Lbsa7E3a6JAzZG0F1U4O3VHgjkTfml+3KRL2TouQc9Sj5oIMmQtklmotSbXmFqhTg3NqfAXRWVSzEjcJC+VacQCcxRoHWze6Y1MuEZ4Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773338938; c=relaxed/simple;
	bh=zKubwnE6WBFqFhMA7VdJVmmNgM5iok6L4iNXlYsPiJk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G66JpYxOnNjt53smc8vuy4uUY0Su8/PcOxZAnvnEYeJ1GJ1DShaTf+LvL9gVbVaUwogaBfI8fwBk8G5gj8kSXBDtGi/Unb5WaIGjHPcscybz7Y1fDi54hjb4Lobj6ykQwINGIGDqPl2RYFYo33JBOZ69jQoWyC4P8JkI+T/KyZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=amCrJEYr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id BBB5F20B710C; Thu, 12 Mar 2026 11:08:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BBB5F20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773338935;
	bh=YJqUVJBTcGYoYBP952Xegm6UMbj6eDAXix4l/bYt0+s=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=amCrJEYrHoBXsY8281kNYyzTHswa4TWOaiY0DklnOCpFzyJ5PjmDxeUT0rKBRdTFR
	 8kSIUquvlWuPNXcNilcfNWCc3wKcax50rqaLnEdvcLCmu9Dws3nx85dgDwUC4HPoO2
	 wfVlbsh7xpEsDpxRP02TU5aC5JU6RspY4F9dFZ48=
Date: Thu, 12 Mar 2026 11:08:55 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: longli@microsoft.com, kotaranov@microsoft.com,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mana: hardening: Clamp adapter capability
 values from MANA_IB_GET_ADAPTER_CAP
Message-ID: <abMBN3I4A0OrYtoD@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260312112538.966157-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312112538.966157-1-ernis@linux.microsoft.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18126-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 1AC4527706C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 04:25:37AM -0700, Erni Sri Satya Vennela wrote:
> As part of MANA hardening for CVM, clamp hardware-reported adapter
> capability values from the MANA_IB_GET_ADAPTER_CAP response before
> they are used by the IB subsystem.
> 
> The response fields (max_qp_count, max_cq_count, max_mr_count,
> max_pd_count, max_inbound_read_limit, max_outbound_read_limit,
> max_qp_wr, max_send_sge_count, max_recv_sge_count) are u32 but are
> assigned to signed int members in struct ib_device_attr. If hardware
> returns a value exceeding INT_MAX, the implicit u32-to-int conversion
> produces a negative value, which can cause incorrect behavior in the
> IB core and userspace applications.
> 
> Clamp these fields to INT_MAX in mana_ib_gd_query_adapter_caps() so
> all downstream consumers receive safe values.
> 
> Additionally, fix an integer overflow in mana_ib_query_device() where
> max_res_rd_atom is computed as max_qp_rd_atom * max_qp. Both operands
> are int and the multiplication can overflow. Widen to s64 before
> multiplying and clamp the result to INT_MAX.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

I will be sending v2 for this patch since it requires change in the
title.

Thanks,
Vennela

