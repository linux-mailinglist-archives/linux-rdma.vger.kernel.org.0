Return-Path: <linux-rdma+bounces-20738-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIDuKONdBmrijAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20738-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 01:42:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E826547CEA
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 01:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35A683026A8B
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 23:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B5239DBFA;
	Thu, 14 May 2026 23:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAA1Q/E5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5989538C2B0;
	Thu, 14 May 2026 23:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778802141; cv=none; b=YXQeCZhGeelAj2F6LHJsoqJW6SGBbPYIZfuFp9dSs8BWHMDBUHHgBwKV2qyBAANKnpYHPtSd83w6TSpsXm2MMLPVz3ffBOkgSPTFpZUoNhh4H/ZHHgJlQB40aY3zpyBZ8jXHl900ZXFMWrQuof8pTraiT+tTfnGmn7voRqcyWwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778802141; c=relaxed/simple;
	bh=J5z8BrvW7MUwwukRDBhUX4+6YCNoc6zcOCSYKYGEIYw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwqW+84sE48MaIOHDBAaXTRpt/O26WyO8TskzxqNVkVo9XRO30jqsL21f5LhLuXlliyVuVNMx7PTk2nEr1YKk0SUV6VBMBZmFW5C/Np/UeXVnYdD5v2uWrdQa+XCX7taNzl9PrCsHDCtoLhqxTlGym3rD8uEd7Z7HHbs+G/1kc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAA1Q/E5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8F8C2BCB3;
	Thu, 14 May 2026 23:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778802140;
	bh=J5z8BrvW7MUwwukRDBhUX4+6YCNoc6zcOCSYKYGEIYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HAA1Q/E52X2rgxX6DTmYBcaD8jsZoAh+jfTuzk7uM7uwV/w0yUTaf/nJkjQ0xfFlh
	 J9LZ7WCwOXlxfSSmFvA4xyA1v/DxfU05C4S6JxzrLzNT2B9G9AUhH0eBjoAqwsFGP9
	 0oOO68sronKX5tcsH91jo6NCiz44EPmamAJ3rLWGbchoXoTBW5I1npNHYPHagQsWfA
	 PnCLLmHyqd03Vo80pJIU1IRkRVcrOZFYNLFx1fVqcPkjUd86JYWQr0p0t+KyGDJM/E
	 ysZLzCSbV8aoR5aJpmSbJ2OR45lm1/17p3ClpkEi/h0OZnBQpl1eMK7YI+P9yL/Aor
	 hcog5tkjnJxfA==
Date: Thu, 14 May 2026 16:42:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>, <netdev@vger.kernel.org>, Cosmin
 Ratiu <cratiu@nvidia.com>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] IB/IPoIB: ndo_set_rx_mode_async conversion
Message-ID: <20260514164219.0cb832ff@kernel.org>
In-Reply-To: <20260513124519.3357165-1-dtatulea@nvidia.com>
References: <20260513124519.3357165-1-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2E826547CEA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20738-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,intel.com,gmail.com,redhat.com,fomichev.me,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, 13 May 2026 15:45:18 +0300 Dragos Tatulea wrote:
>  drivers/infiniband/ulp/ipoib/ipoib_main.c | 8 +++++---

Since it was tagged for "net" - can we get a stamp from RDMA?

