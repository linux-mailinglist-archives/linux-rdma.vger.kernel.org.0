Return-Path: <linux-rdma+bounces-20170-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PnHMD+r/GkNSgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20170-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 17:09:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5E74EAD47
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 17:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F8D53036EB8
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 15:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDDA43E9C6;
	Thu,  7 May 2026 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Abe3n7iz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A187443E4A1;
	Thu,  7 May 2026 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778166520; cv=none; b=nvmI46mv4g4/vmilR+ymJjZ7eNB4UyXffIxrj+SrFitOx6baVNUTYR01UScmJg+0QI3TPe0uddOB7KtoIqPWuuQcK57unxHHtMHAeQPDqlk+skkFjjxnS61vrEg7AW6rv8ldLupOzb/AS3bAfJXGaTlq6wM5R4b+F3AUdShY6pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778166520; c=relaxed/simple;
	bh=h3hcqBUbH6jetT+kZMUgXWTqXe6P9tvY9fQw/yBySvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnJdV5XV7G2W6fbHFb4PMVPxZrNLV5uJTrMzZKSMN+g458xx0B/SXxPNZc/5dcLeJ2z7R2MdnJYvEgNI+DMDw3GrvLAZbMW/Kx9g76SVFqP6qUOnBotLOsqammuYOoCf/IbHUyyf79rJPW0NrC9ARMi3nPXiwWGBABKIRkvJHRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Abe3n7iz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF67C2BCB8;
	Thu,  7 May 2026 15:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778166520;
	bh=h3hcqBUbH6jetT+kZMUgXWTqXe6P9tvY9fQw/yBySvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Abe3n7iztnI6wS00ew3Kag/pw9RsbzbEbmizqBsOmmYcDiF9cXaAfcsEK7DPlY9Uj
	 kjN40pfVibhX9lR2BlGq9w/XARA2loR5da8X4iXvqaGx9uoNvsAudhrzVoFu0o2yv2
	 b2p4Y5bas4ZyE78Gdr+0E3sY9hOKRjBbrgc+BoEToLL/hnJDVSEPKPVsmg5ksH1aaP
	 Vdlu04In2LNO9NdvvJhdZj7vU/sYmwlnast1IXDl5FOvEMrBZVMKU+67fk58V7gn9p
	 DvhBQPhKHIs+NzKFVtEKJ5oS6aZqqteFRPIXppCHM++upz+PRL7b9RfKj85wh/cOCE
	 E0Vf0dPSaEGRA==
From: David Ahern <dsahern@kernel.org>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	leonro@nvidia.com,
	linux-rdma@vger.kernel.org,
	David Ahern <dahern@nvidia.com>
Subject: [PATCH iproute2-next 4/4] rdma-dev: Update man page to reflect netns as a pid
Date: Thu,  7 May 2026 09:08:35 -0600
Message-ID: <20260507150836.28105-5-dsahern@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260507150836.28105-1-dsahern@kernel.org>
References: <20260507150836.28105-1-dsahern@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3A5E74EAD47
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20170-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: David Ahern <dahern@nvidia.com>

Signed-off-by: David Ahern <dahern@nvidia.com>
---
 man/man8/rdma-dev.8 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/man/man8/rdma-dev.8 b/man/man8/rdma-dev.8
index abc9f405..9ddad2dd 100644
--- a/man/man8/rdma-dev.8
+++ b/man/man8/rdma-dev.8
@@ -32,7 +32,7 @@ rdma-dev \- RDMA device configuration
 .B rdma dev set
 .RI "[ " DEV " ]"
 .BR netns
-.BR NSNAME
+.BR { NSNAME | PID }
 
 .ti -8
 .B rdma dev set
@@ -104,6 +104,7 @@ Renames the mlx5_3 device to rdma_0.
 .RE
 .PP
 rdma dev set mlx5_3 netns foo
+rdma dev set mlx5_3 netns 1234
 .RS 4
 Changes the network namespace of RDMA device to foo where foo was
 previously created using the iproute2 ip command.
-- 
2.50.1 (Apple Git-155)


