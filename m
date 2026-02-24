Return-Path: <linux-rdma+bounces-17085-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIuVFVTxnGkaMQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17085-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 01:31:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A76E41803C7
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 01:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 264EE30A3B25
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 00:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7551F09B3;
	Tue, 24 Feb 2026 00:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SwVsWgrb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A39187FE4
	for <linux-rdma@vger.kernel.org>; Tue, 24 Feb 2026 00:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771893073; cv=none; b=dS8t0HxNvHAAArhIUVLSp80iBOezTtSs+aVsAKizV1gx+Ob3hhiTlIxjUx4ZBk5IOrY6D6CQPgsiHpNrRfEaFkS9Mopkg/1wdwUhVQIEfy8o/8XZ1jqqxfKL4hIh3dSu16Pdgrd7kf/lMSrLzroE81diXgzVZNLus2QFcTQvfmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771893073; c=relaxed/simple;
	bh=BNVmyTeSSfZEQvQc/EsrC/aeU6D9dEQaT2+TiLaMb60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iCBpst+YOkckExeELgdoVTihAynvC5kBbYFS6F08cjk/v8ofKs+Ws7KT2wMdQVrhT+j+9Ax3Zk0GWsTPAQwIUkGCrQINZMewSc+PPDt1BKaahJkQG5uGBURHz6pPvswOi1G8AN6qXbDLrw7IBBZMNvsjdNPBScFvULXVyPAabYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SwVsWgrb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=MkD4IyDUxGG+tECnoyI9ypiieJJqgugQJ5YbfBbWL+A=; b=SwVsWgrbjttJHRRERuJQq5Am1y
	VnrSk+Kx4LY9RUPlJ/hQUCnAgb0q4SxelNmZ+iMsZLveg+GBZ6vgaNHJgSoYeaDqj4MrkF3ZmtN4O
	944K7gj1Q1vUOjJJWsvAKfKnj7LZERJKdamRKyA9KRuE4MAvpn7s9TaGgGSer5NlBo6SJMB9Am73y
	1T4Qw/nxjgXdjtOs2d9PEzw3b9x/GyaSTOtKziakMysU1HmXn8AtFPnUyjX4+oEgHh/XfwRlf4sPL
	8wfWE4liq9QF0Rtfl9NMmQwZr4E5h9vRkx7LaNOgDw6S+aOt8JDAt0zdx5SLxfmxY17cm3Ji2jI9Z
	WRXpvo+g==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vugKS-00000001F6v-1EPb;
	Tue, 24 Feb 2026 00:31:08 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-rdma@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH] IB/cache: avoid kernel-doc warnings
Date: Mon, 23 Feb 2026 16:31:06 -0800
Message-ID: <20260224003106.3172916-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17085-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim,infradead.org:email]
X-Rspamd-Queue-Id: A76E41803C7
X-Rspamd-Action: no action

Use the correct function parameters names to eliminate kernel-doc
warnings:

Warning: include/rdma/ib_cache.h:47 function parameter 'device_handle'
 not described in 'ib_get_cached_pkey'
Warning: include/rdma/ib_cache.h:89 function parameter 'port_active'
 not described in 'ib_get_cached_port_state'

(not adding missing function return value descriptions)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>

 include/rdma/ib_cache.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20260205.orig/include/rdma/ib_cache.h
+++ linux-next-20260205/include/rdma/ib_cache.h
@@ -34,7 +34,7 @@ struct net_device *rdma_read_gid_attr_nd
 
 /**
  * ib_get_cached_pkey - Returns a cached PKey table entry
- * @device: The device to query.
+ * @device_handle: The device to query.
  * @port_num: The port number of the device to query.
  * @index: The index into the cached PKey table to query.
  * @pkey: The PKey value found at the specified index.
@@ -80,7 +80,7 @@ int ib_get_cached_lmc(struct ib_device *
  * ib_get_cached_port_state - Returns a cached port state table entry
  * @device: The device to query.
  * @port_num: The port number of the device to query.
- * @port_state: port_state for the specified port for that device.
+ * @port_active: port_state for the specified port for that device.
  *
  * ib_get_cached_port_state() fetches the specified port_state table entry stored in
  * the local software cache.

