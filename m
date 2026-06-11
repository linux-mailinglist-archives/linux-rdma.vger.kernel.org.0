Return-Path: <linux-rdma+bounces-22097-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jbFZGXtQKmp2nAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22097-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 08:06:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8625766EE43
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 08:06:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=ldFLJqzI;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22097-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22097-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D20B300B517
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 06:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AE731F9A2;
	Thu, 11 Jun 2026 06:06:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215371F4C8E
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 06:06:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781157995; cv=none; b=A1pwCbcBXQjrXufqjg9Rb1VW0W3U9bV7MUSBDNUr3Sdy9xLxgVV0ULKHK0v9qoonPxDGnDcidY98TJTZr4mEIN8hSn8CJwxbQxLkWfehF1h6GRGQCzqqpXhFVVHik6iSCg+j6hXWLjjjTDGTX5LPEjKYhl/L76X9/cK6pO/Fin8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781157995; c=relaxed/simple;
	bh=KzFBtbZCsFIB1C0x8hhlcVuxnERR7LA7E4Ddc1WdmLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KfW737Fl2cUXE5d4wvuxtyf1+g967VUNmL3va+ERJM7W1fZpa7zNwnGd7+PkbTkQwHHN8JF/7ZJZu12OhC4r+gfRUv5hoSiABQjxHv1/easE22EaawYs3TSCLcSiatzfJrrvvVTBCmKQgOedNZE6oEm2zezc4qMFH9J2UDdTOjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ldFLJqzI; arc=none smtp.client-ip=95.215.58.172
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781157990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KzFBtbZCsFIB1C0x8hhlcVuxnERR7LA7E4Ddc1WdmLU=;
	b=ldFLJqzIcmnVhtrkuzj24N8ayQkAjfXil6/utIeI5rCajukudFBDL0jyltS/Br9yoOVIg6
	cIEDLY2t2DSnr8clJdGGZgOwkYBWJqnpVraplDMcAumZ3wjX/1Wq6QDyXzaDBXnDyGGT3J
	4niTI2/0emmAXBld5AECTLSheKv42iE=
From: Tao Cui <cui.tao@linux.dev>
To: michaelgur@nvidia.com
Cc: edwards@nvidia.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	phaddad@nvidia.com,
	yishaih@nvidia.com,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH rdma-next 5/9] RDMA/core: Fix FRMR set pinned push error path
Date: Thu, 11 Jun 2026 14:06:05 +0800
Message-ID: <20260611060606.44899-1-cui.tao@linux.dev>
In-Reply-To: <20260610000145.820592-6-michaelgur@nvidia.com>
References: <20260610000145.820592-6-michaelgur@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22097-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:michaelgur@nvidia.com,m:edwards@nvidia.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:phaddad@nvidia.com,m:yishaih@nvidia.com,m:cuitao@kylinos.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8625766EE43

From: Tao Cui <cuitao@kylinos.cn>

> Add destruction of FRMR handles in case the push to the pool fails.
> This prevents resources leak in case pool page allocation fails.
>
> Fixes: 020d189d16a6 ("RDMA/core: Add pinned handles to FRMR pools")
> Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>

Reviewed-by: Tao Cui <cuitao@kylinos.cn>

Thanks
--
Tao

