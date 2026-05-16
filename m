Return-Path: <linux-rdma+bounces-20798-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AnlHBEo2CGoHegMAu9opvQ
	(envelope-from <linux-rdma+bounces-20798-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 11:18:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F0455ADD3
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 11:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C036B3010C2B
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 09:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8FA37E2FC;
	Sat, 16 May 2026 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UCU9R5/k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-77.smtpout.orange.fr [80.12.242.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D8C2C375A;
	Sat, 16 May 2026 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778923073; cv=none; b=jSJRL80CbcKL8FwctIw3z6OkfkR0e6+Mlk3WuiXm8Ye+FMhjAUdxB9qLoOSALtC8dE9RJzuFIsKE8ujoYZ2uNZjnYffS1vvgJIPNTr4zGyEwZ39XOStiS1PHAEFjX7fmAwJZ+tapvR/GN7G3TpT7jXf/ppLgYPXe+oiBpdw38Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778923073; c=relaxed/simple;
	bh=HgmvDRO34wayBy8VZ6meLJgKT9YIyUv7cxsiRyILNOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n+JPeEHlmp6+58z0oqLOE0oMnKzZUAbqS4taOqqQlOEi4ZCXjy/syYoTGh4Rwh+7ASzkcNlEOuCrbsoSZHl9htoQYeA25t9gfVXxcSwmsv+qkFVY0lrslPTq3DMPffOqwX5hrqL16nOWmfkcuOoj67VDnA/jSQssJ3i32kRi75w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=UCU9R5/k; arc=none smtp.client-ip=80.12.242.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPSA
	id OB9ZwnyF1DTmsOB9aw7qCa; Sat, 16 May 2026 11:17:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1778923070;
	bh=62qKDa5dGrj20kJkQH0/jgHOYW8OejzKlqfIFQW9qmA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UCU9R5/kgQt+Ua0eG5FuXkApi+fflPpvAfHfXA+mhEq6sJO4QLTBxQ2VX/jFPtQh5
	 XeAZGpXg0KsEQeV06WkCzWS7qsPxoUXymhVNXxapsQ4QSxcA4xIsfwjP7cLRUZ4HRe
	 cs0JCjTvcmXCjlu9M5a/OCVszn6s3VTkERwkNZFZAOEdpASJqxz7AKA/6hLKHWIAXp
	 1n0gS7TwmRCDSQrMDuK+hFc50C6BelSk3cTtb5tWNQ7o5dQruerjTIQijObIzsGAet
	 Kp2vw4heCJtKQbmAeE9Mdfnz2ElL5BVKSGK6mF9sqZkcZUADuDkgtOlwDYZwSxSmgh
	 rbJTHoDP8TfAg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 16 May 2026 11:17:50 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/cma: Constify struct configfs_item_operations and configfs_group_operations
Date: Sat, 16 May 2026 11:17:47 +0200
Message-ID: <6acd9c8a79b868b5e541a7e080a6b4b145e4fd4f.1778923041.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 57F0455ADD3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wanadoo.fr,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[wanadoo.fr:s=t20230301];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20798-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,wanadoo.fr];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[wanadoo.fr];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christophe.jaillet@wanadoo.fr,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wanadoo.fr:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

'struct configfs_item_operations' and 'configfs_group_operations' are not
modified in this driver.

Constifying these structures moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   6677	   2776	     64	   9517	   252d	drivers/infiniband/core/cma_configfs.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   6901	   2552	     64	   9517	   252d	drivers/infiniband/core/cma_configfs.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/core/cma_configfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
index 819927ce4f0e..891e52afb8f4 100644
--- a/drivers/infiniband/core/cma_configfs.c
+++ b/drivers/infiniband/core/cma_configfs.c
@@ -255,7 +255,7 @@ static void release_cma_ports_group(struct config_item  *item)
 	cma_dev_group->ports = NULL;
 };
 
-static struct configfs_item_operations cma_ports_item_ops = {
+static const struct configfs_item_operations cma_ports_item_ops = {
 	.release = release_cma_ports_group
 };
 
@@ -264,7 +264,7 @@ static const struct config_item_type cma_ports_group_type = {
 	.ct_owner	= THIS_MODULE
 };
 
-static struct configfs_item_operations cma_device_item_ops = {
+static const struct configfs_item_operations cma_device_item_ops = {
 	.release = release_cma_dev
 };
 
@@ -327,7 +327,7 @@ static void drop_cma_dev(struct config_group *cgroup, struct config_item *item)
 	config_item_put(item);
 }
 
-static struct configfs_group_operations cma_subsys_group_ops = {
+static const struct configfs_group_operations cma_subsys_group_ops = {
 	.make_group	= make_cma_dev,
 	.drop_item	= drop_cma_dev,
 };
-- 
2.54.0


