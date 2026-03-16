Return-Path: <linux-rdma+bounces-18215-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKIlMdNeuGnxcwEAu9opvQ
	(envelope-from <linux-rdma+bounces-18215-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 20:49:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B6F29FE83
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 20:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEC943023A49
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DDF3CFF62;
	Mon, 16 Mar 2026 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSmzNamu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610D321B185;
	Mon, 16 Mar 2026 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690575; cv=none; b=UboXScrFlk6QZvTGM/XwSbF5gVRVvJFOc8JpoY8DkGMw6iqHRv93mW2iwWrON0Wh+ia4Xic2LZD4f8KTeMBZAhWwUrA5nW91OxS+IEBRY+xWNLtr+M3pOWkxMI4Lfbk4eojchJKF3kPBsio6ECUv+VhncPFTZHpacGQvXqg8O0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690575; c=relaxed/simple;
	bh=kuJI5O48hK5qNBedYpwMqQB1NSo9oS2I+AC3o8HPCRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbSbb8QZ1+En8JK0royu6EDf3BVA4+Q48lugm0hT/ajPS1BcuvsVEeDfqEdRDP3zoBBDeyim+WCi+/0XdQkMqiqHXwwIHtyB/ap/rHwgcaaN2MVSs+h6Z44JTyb2EJjWDxt8dFvvThsLpXnk5cMWWVePa/IdIpRBXMd6C+D1TjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSmzNamu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A05C19421;
	Mon, 16 Mar 2026 19:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773690575;
	bh=kuJI5O48hK5qNBedYpwMqQB1NSo9oS2I+AC3o8HPCRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BSmzNamuxhhJ/apmqz80e6cWCvo+K2Cxw/txvH3RW/Llg5Scg2XXIjXuAFQog8BmU
	 FRZURlKQYxWG5omteGhs3oXP59oStr6xSo0U8FKzbpcz85ouNANj2+3H3yyCQLYEPO
	 i+vx9l3rdlTQMyLv/1Tjl3JToZzmqOcIzdLLxTPcrORlcESwalDJ0bfmy3xGr93XTh
	 P3LsXGG8u6eIPXj2AoyJTXsMZgoOQCoh4vsMSW7Z65SZZRFiCAYGEOVDmC+1YoMUad
	 SevL+HvuQSHJAu2B5jWtNbVzRaqoHD5wV955DXKALDRCMG32WwjV4tJRC+xZS0FxdM
	 2EUW5vSYtpHIg==
Date: Mon, 16 Mar 2026 21:49:29 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: longli@microsoft.com, kotaranov@microsoft.com,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v2] RDMA/mana_ib: hardening: Clamp adapter
 capability values from MANA_IB_GET_ADAPTER_CAP
Message-ID: <20260316194929.GI61385@unreal>
References: <20260312181642.989735-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260312181642.989735-1-ernis@linux.microsoft.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18215-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 36B6F29FE83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 11:16:41AM -0700, Erni Sri Satya Vennela wrote:
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

This sentence does not make sense in the context of the Linux kernel.  
The fundamental assumption is that the underlying hardware behaves  
correctly, and driver code should not attempt to guard against purely  
hypothetical failures. The kernel only implements such self‑protection  
when there is a documented hardware issue accompanied by official  
errata.

Thanks

