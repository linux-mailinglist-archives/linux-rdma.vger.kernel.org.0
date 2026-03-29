Return-Path: <linux-rdma+bounces-18772-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHSOGM6NyWm1zAUAu9opvQ
	(envelope-from <linux-rdma+bounces-18772-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 22:38:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DF6354032
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 22:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76CF03044832
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 20:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5B535F60F;
	Sun, 29 Mar 2026 20:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMU2ngsG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE0F33EC;
	Sun, 29 Mar 2026 20:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774816506; cv=none; b=usKa5ocfsGqO/R9jATMfJbWHoNExoFNRU6BvueqvE1vqE3lad8jSJkmW05o1WaCl5tueSV39krtc7juvCotDAOXzHOdo3/OvpGR5FDPwT65zz+z5Nc/2dJVfgjfTPjxlpW5CTAewS88E8d+gZv6krGasENDtWRtNNzzs9wkUmzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774816506; c=relaxed/simple;
	bh=A/GCYI6CeXv32fG4P744q+BBGeiRVdpybqEscFaYyrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QP9EQC1rf1my3xcR9EGVrfbpEVUJUA4UPu1t0eeidbEPx3bjfib+yyt045I1sLNfTz0glhHU2B08LpwxOnaWhjCxf4SaSCXnzHd9OTXLRPTgq1xNqgsf3tS4y4JV9iQr/d8KAT9lA5i2wrkq9Bj/QheYSRWbZMyQ94Q++3kAS3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMU2ngsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F797C116C6;
	Sun, 29 Mar 2026 20:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774816506;
	bh=A/GCYI6CeXv32fG4P744q+BBGeiRVdpybqEscFaYyrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hMU2ngsGmbbcDhbjrrcgq05KEXuZxoDOfZgHec7OcJHA5PpbfHIog8619Sr8hXUaC
	 vd5z3Ms3Ugh/y+asvY1YLKFsmj6E2IjturUdE06qtarFnLTpRsID4P0wNVpuBHbPZx
	 1AEmYE9fhpDO9hNlEVaumifGlFc01uSayFvsbWiTMnfJi10Mgy4y0F620S7j1D3n/Q
	 /K/R05I3iHrt3oB5N5DuFAE8QDPY6TUDCkzoBf0x8MhHikgsyrv97AM4usDlvSD9UX
	 oVrWVkrfqkUgi2QAJ8ggrrrLFOVDw29tOTk8qD80GL4X8WlM8aYl2inSohGILSGz/r
	 c0CDVfaHR8iWA==
From: Jakub Kicinski <kuba@kernel.org>
To: lixiasong1@huawei.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yuehaibing@huawei.com,
	zhangchangzhong@huawei.com,
	weiyongjun1@huawei.com
Subject: Re: [PATCH net 1/2] net/smc: fix potential UAF in smc_pnet_add_ib for ib device
Date: Sun, 29 Mar 2026 13:35:03 -0700
Message-ID: <20260329203504.2816795-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325110352.3833570-2-lixiasong1@huawei.com>
References: <20260325110352.3833570-2-lixiasong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18772-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3DF6354032
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
No issues found.
-- 
pw-bot: cr

