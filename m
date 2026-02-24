Return-Path: <linux-rdma+bounces-17088-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJRbK3/xnGkaMQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17088-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 01:31:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F301803DE
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 01:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77E2230B849D
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 00:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6578225397;
	Tue, 24 Feb 2026 00:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Alnv3OTM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB301E3DF2
	for <linux-rdma@vger.kernel.org>; Tue, 24 Feb 2026 00:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771893113; cv=none; b=U7pL/fjx5AEYU5aM/LSddudu1brHv5p/QeDf7qbgfKlEzQN07jaj8nB7eDZuoUR4B13PMG9j3MyC4GDof64aw5JrsEbE0k279wBEvl5c3hSklNHq1DtqmVCAzydIz8HUMAUKdFeamqQubl8seiScnvDWcaIh7bhIaDbHvt1wjEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771893113; c=relaxed/simple;
	bh=PKL0b3OzlwCJ1VnWm0jpFuNsJryCjxkZgNqKq+FgWZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VzcP91aJkLGe72+H8GfKoUvzVFuLxKQH0QCAvzXWMEL3b3oY/GsIwurK5l4jZX1x/7KuZQrICekIcynxJcoa31+q+lx2JSRCBREXlF7aewFfOamuzZPN5GiF2uPNAQdlCHrRsz0v0WdKD7/JqxbxG+hT1Q0vFA8oXGbSn64FHSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Alnv3OTM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=NQ9JdS+RMd6T8h0W5IwvmQftHgBQQJ95LItXdPi0/os=; b=Alnv3OTMwM5olJ92brcDLNecop
	JGSTxfzxS1jdzcKtUjZCx+qPMQxR61i0CsnFRGsnVgzvF9edhVSwhNjeYuhBfbiaTtPtNstOyGT2D
	D5MTV1k4bV+6K2mnM6ZyaCjoaukjEB9g683NbDyWc0x/wY765tQKlfY+nBCIePcLV73F3rgGeGIEQ
	16TTGoHnljuQTyTZex9Te8+Mv5dpbd7Llk578cx9LBQMkDf3GQVyocsLgxG3TUWqIBaG4tU3PRtLl
	uxB5VT3DBpCcKvGJ37a099CPICI3UwPbwj1z94Y4fTj1U22nnwuiKd5XYZevMXUqjDpUSHvI+PLSq
	HOazgnnw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vugL8-00000001F8n-3Kl5;
	Tue, 24 Feb 2026 00:31:50 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-rdma@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH] RDMA/restrack: fix kernel-doc indicator
Date: Mon, 23 Feb 2026 16:31:49 -0800
Message-ID: <20260224003149.3175815-1-rdunlap@infradead.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17088-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim,infradead.org:email]
X-Rspamd-Queue-Id: 45F301803DE
X-Rspamd-Action: no action

Use "/**" to begin kernel-doc comments. This eliminates these
kernel-doc warnings:

Warning: include/rdma/restrack.h:123 struct member 'kref' not described in
 'rdma_restrack_entry'
Warning: include/rdma/restrack.h:123 struct member 'comp' not described in
 'rdma_restrack_entry'

(not adding missing return value kernel-doc descriptions)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>

 include/rdma/restrack.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20260205.orig/include/rdma/restrack.h
+++ linux-next-20260205/include/rdma/restrack.h
@@ -87,11 +87,11 @@ struct rdma_restrack_entry {
 	 * query stage.
 	 */
 	u8			no_track : 1;
-	/*
+	/**
 	 * @kref: Protect destroy of the resource
 	 */
 	struct kref		kref;
-	/*
+	/**
 	 * @comp: Signal that all consumers of resource are completed their work
 	 */
 	struct completion	comp;

