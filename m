Return-Path: <linux-rdma+bounces-22508-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EdDtIu2ZP2rDUwkAu9opvQ
	(envelope-from <linux-rdma+bounces-22508-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 11:37:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF976D1A7E
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 11:37:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Bk5igmAy;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Z6wfE98u;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22508-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22508-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=mailbox.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3BBEE3013C78
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 09:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523653939B9;
	Sat, 27 Jun 2026 09:32:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12A62AF1D;
	Sat, 27 Jun 2026 09:32:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782552732; cv=none; b=tHedewc3e+4ZcxbmLoBffqG4vnAWUC/H+zTbOVeDGTelCyoFGlgicQ9Ne4U83+wntJ6o41LsAUWVNeyq6T0aHxkpXHv4aWpgL48O7W8Zn/YZYGt+rktgjUAqySqY35qIwnAvjK50Y7i3LKjptU4pTvngp0Pu73+omfwX+QxDnHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782552732; c=relaxed/simple;
	bh=icje0IA2Khdt0azjH6bQRFThDwSjwmBc1Xzidmakxm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jihlde3jXtYlykPJMyzDf0R9OWmI+cwvF1GDluPlgQr+EwTKXLkkjdL0kEKTpksWqUxSXQq5pPP5/9xrg2m13abluF0Z7KKP+i1pfXBV4We83eoEqpYfeYcccgUTRmoJaIIpmbkwKI568SAY8bCrBas2rBLbegtRtECmQ9GL0MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Bk5igmAy; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Z6wfE98u; arc=none smtp.client-ip=80.241.56.152
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gnS433ssgz9v4J;
	Sat, 27 Jun 2026 11:32:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782552723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tMQprRWKHQflARV3hUtuLOapLDf0iAdpGrwiU+30f0c=;
	b=Bk5igmAy8Gc2M5OJ3gkYTdMoBwFWISWHyK4eQhGrVESOplpW2TvGeF3Lr7/Ni8+3J4vMxg
	VI+tX9zf9uThQ1vtGlbbpT2QFfH0KCv5FXePdiMS4GKWacBmgW+Ib5WXzF6c80I/5y5L/5
	38hLIDW0iyKjBAblDHBhuv91tSJAhsN91G63AN+MvZFXSuojGmtY9diNPZbxzG2pCH9sM9
	Nu56y/g8uSswla1yNlxoInBSyj2qjHEbWwTvmgTPkPmQ6fl02PhIxJMY+wWL7FhX4OfH6n
	MaL6PQA7hZlYmAi7Fx26q5QmJK2eFKYZbrj6TuWhFyGCQsvi5AMqwi53UhzoMg==
From: Manuel Ebner <manuelebner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782552721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tMQprRWKHQflARV3hUtuLOapLDf0iAdpGrwiU+30f0c=;
	b=Z6wfE98u+n3qv8+4+VupjwPmUFi3kg1D5CGAsrCEkT8IoPGNMf1iQm4rP1N2gEWl/cDEAB
	BNsRxzguEIJWwc/uXk9TTSBp15lR0T3/7NMw4CACL+OsDPhd21CApFiqRnfOLq5f/eJIGz
	DgoAPk8pOHvImJ7UvMjld1IHeOrI1jrFD534s751vz1TgOH4Bn3UbBf563Tz8cvAeMHEAZ
	BJ8hIEW8SlG/sFst/pKgVqSGf/fxvrdwtIIe44heBtk6nbTYaZ1jeYSIjXZbOZCEiKfyop
	MQIrCoggNS/pYJ9nTrXheSsnpGatxblLvjVQBNjxcBs440gMzY0qrfAIUYo7ag==
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-rdma@vger.kernel.org (open list:INFINIBAND SUBSYSTEM),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Cc: Manuel Ebner <manuelebner@mailbox.org>
Subject: [PATCH] docs: infiniband: fix bracket
Date: Sat, 27 Jun 2026 11:31:08 +0200
Message-ID: <20260627093107.31068-2-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c6d96639ed23a95f5e2
X-MBO-RS-META: pe1m37dkiqbzw3tnuoo8gyc55ixyysnh
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22508-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[manuelebner@mailbox.org,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:manuelebner@mailbox.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manuelebner@mailbox.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,mailbox.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8BF976D1A7E

Remove needless ')'.

Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
---
 Documentation/infiniband/user_mad.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/infiniband/user_mad.rst b/Documentation/infiniband/user_mad.rst
index d88abfc0e370..cd66e7623d66 100644
--- a/Documentation/infiniband/user_mad.rst
+++ b/Documentation/infiniband/user_mad.rst
@@ -62,7 +62,7 @@ Receiving MADs
 	struct ib_user_mad *mad;
 	mad = malloc(sizeof *mad + 256);
 	ret = read(fd, mad, sizeof *mad + 256);
-	if (ret == -ENOSPC)) {
+	if (ret == -ENOSPC) {
 		length = mad.length;
 		free(mad);
 		mad = malloc(sizeof *mad + length);
-- 
2.54.0


