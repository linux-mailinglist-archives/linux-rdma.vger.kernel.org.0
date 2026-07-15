Return-Path: <linux-rdma+bounces-23275-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u6HeDkdpV2qJMwEAu9opvQ
	(envelope-from <linux-rdma+bounces-23275-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 13:04:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFEF75D45E
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 13:04:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=A1v6T3yT;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23275-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23275-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB52F30432D1
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 11:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560B842CB14;
	Wed, 15 Jul 2026 11:03:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22450334692;
	Wed, 15 Jul 2026 11:03:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113409; cv=none; b=J4CvIBVsXs3MmvARXGUojpTDJ9xSMVYQvCgW64jIz0ANbnqbl8y70yy/y/F+boYI8Jj93h9S3EpPUIJ2TtMRgWhBT106FgQtkxvfC+IszPHW7NSWScDJOthxSwZShGtUEK8AzR9BkSkLOGzidYEcCpBcKZUhM2omln6XzE14Nno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113409; c=relaxed/simple;
	bh=3OvHQeH8X15G68xAWsxjZwDBnqtvwt+xsNLQl29eLgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P44CO+pffDhAkrrgI1sbCrLd9qhXLeP8Vdod+hM2enb2KprNyu021JQq9484k1JqiLRgAOIzvAPH1n11g3qEaudKn+pCNYAcvPSJ5F8eVVdNeQ+JZGniu8sCRgMVSpcRZBxGEVpu5yB9OFtmjOtJw68pGIL90+4eP32SpX2K0uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1v6T3yT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81771F000E9;
	Wed, 15 Jul 2026 11:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784113407;
	bh=+6L2mR1Z7PucopuI1/SHxIqdO9XYAj/qxei07U+TFyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A1v6T3yTmihfZid2P83olrspUF/t38FQq4dqOFdECNnR7UxWbc4Eq4dZzqYik9Y7a
	 th5OugAo+4bTeOaZ3+IpYUwx3dKjWxI7J1ku82vJTv+qX+S8dbFcaZfoc0DzDsPh2V
	 jyCmT4wqGQNJ+Y7k90RYtZLMVwdqRxd/WKkXYokYBin55D7/jjcJ1R/dB8HEhBar5a
	 68jS1RKjjVsTr+7hXi8/m1QoUwj2CvDt9XxPRy2adSqUqjgulYVoD1SK9zgRVr8Mhk
	 w9j0TXkiJK0h6rTjClK7wvwXKRCGmnm2xZIWkQBDaK70bQRsLng/p/34U1vtm/2lTQ
	 Ay2KpuB1Ywayw==
From: Leon Romanovsky <leon@kernel.org>
To: Potnuri Bharat Teja <bharat@chelsio.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yishai Hadas <yishaih@nvidia.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH rdma-next 1/4] RDMA/cxgb4: use kmalloc() for the PBL address array
Date: Wed, 15 Jul 2026 14:03:09 +0300
Message-ID: <20260715-get_pages-to-kmalloc-v1-1-b0b7fce288be@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715-get_pages-to-kmalloc-v1-0-b0b7fce288be@nvidia.com>
References: <20260715-get_pages-to-kmalloc-v1-0-b0b7fce288be@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bharat@chelsio.com,m:jgg@ziepe.ca,m:yishaih@nvidia.com,m:neescoba@cisco.com,m:satishkh@cisco.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rppt@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-23275-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7DFEF75D45E

From: Leon Romanovsky <leonro@nvidia.com>

c4iw_reg_user_mr() allocates a page-sized temporary array of DMA
addresses while programming a PBL. The array has no page-specific
requirements, so allocate it with kmalloc() and release it with kfree().

This avoids the casts required by the page allocator and lets the free
operation derive the allocation size from the object.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/cxgb4/mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
index cd1b01014198..49498c75f38f 100644
--- a/drivers/infiniband/hw/cxgb4/mem.c
+++ b/drivers/infiniband/hw/cxgb4/mem.c
@@ -541,7 +541,7 @@ struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (err)
 		goto err_umem_release;
 
-	pages = (__be64 *) __get_free_page(GFP_KERNEL);
+	pages = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!pages) {
 		err = -ENOMEM;
 		goto err_pbl_free;
@@ -568,7 +568,7 @@ struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 				mhp->wr_waitp);
 
 pbl_done:
-	free_page((unsigned long) pages);
+	kfree(pages);
 	if (err)
 		goto err_pbl_free;
 

-- 
2.55.0


