Return-Path: <linux-rdma+bounces-17170-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG5CC/L+nmlAYgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17170-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:53:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96946198660
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E616D304A573
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 13:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F09E3D1CDB;
	Wed, 25 Feb 2026 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsESe6Pz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACD23D1CAA;
	Wed, 25 Feb 2026 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772027347; cv=none; b=P9Cjr4tsNsuGGlLlHFD4PXhqYRfBuxxHPZeJVxC8LtfJ+jeDvPIkxEJTwGcjTQNMR0g14eXIhBz2C4Q85kFw3Sw7KggaEDZrUkmdL5pcu7mNT27lBYbPTQAyJ5xpjuHBIjtbyeNd5gS1BS7B9929FsOZ4uRA5aqabOSmxasYDp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772027347; c=relaxed/simple;
	bh=L+FXSfFVZTWw/7cJ1b6EmaymixfTwFa7Sq/2AoPzxuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ieVlqO29yyXjQ7TbcceqGfHAhIyPNPVXOc72iyLuRBogH3FR8WeDUuy4S8YOlF5DFof2tOoWSZK5ob12UWdGIzYZoIsG+34vw9SjTQYqI7Q8/06fzUAM05oBYhNSx3tgXEfvUqu+0lTwr+jh1rZud1VEuDJQXakg9QaoXZL2ir8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsESe6Pz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4518CC116D0;
	Wed, 25 Feb 2026 13:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772027346;
	bh=L+FXSfFVZTWw/7cJ1b6EmaymixfTwFa7Sq/2AoPzxuU=;
	h=From:To:Cc:Subject:Date:From;
	b=TsESe6PzhNEfVeu3a7vQ0RepTaIFoo4H5lQS2CVqzHApBGO+59XbSAs2uxnf2fHME
	 PUhARIusFn4T9f92JcehJoTCJyGAwJRt3+qf9PipXaWif4M3Rn3WwU156rY7xaaDtm
	 32ufrKw42UV8Mi62HJC1z7WtmAv62qLoWOVXhjttyGEH7Oa0r+AravnfsUnTEGtzmt
	 s0EL12VKeW3wHXAHV+/Q/KWGbvnsSd4NLPfeaWuVuk2zRxmSgVpFrhYukUBB8cTFoN
	 aR2LIQNZcZVfNjPXaW/MpTykXs+Gz6sysmJod8N0ul+blIO4ZZA80484emZqHFdana
	 yUQPOhPnIEoPg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Edward Srouji <edwards@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-rc] RDMA/uverbs: Import DMA-BUF module in uverbs_std_types_dmabuf file
Date: Wed, 25 Feb 2026 15:48:59 +0200
Message-ID: <20260225-fix-uverbs-compilation-v1-1-acf7b3d0f9fa@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260225-fix-uverbs-compilation-d6668390275b
X-Mailer: b4 0.15-dev-47773
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17170-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 96946198660
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>=0D
=0D
Fix the following compilation error:=0D
=0D
ERROR: modpost: module ib_uverbs uses symbol dma_buf_move_notify=0D
	from namespace DMA_BUF, but does not import it.=0D
=0D
Fixes: 0ac6f4056c4a ("RDMA/uverbs: Add DMABUF object type and operations")=
=0D
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>=0D
---=0D
 drivers/infiniband/core/uverbs_std_types_dmabuf.c | 2 ++=0D
 1 file changed, 2 insertions(+)=0D
=0D
diff --git a/drivers/infiniband/core/uverbs_std_types_dmabuf.c b/drivers/in=
finiband/core/uverbs_std_types_dmabuf.c=0D
index dfdfcd1d1a44..4a7f8b6f9dc8 100644=0D
--- a/drivers/infiniband/core/uverbs_std_types_dmabuf.c=0D
+++ b/drivers/infiniband/core/uverbs_std_types_dmabuf.c=0D
@@ -10,6 +10,8 @@=0D
 #include "rdma_core.h"=0D
 #include "uverbs.h"=0D
 =0D
+MODULE_IMPORT_NS("DMA_BUF");=0D
+=0D
 static int uverbs_dmabuf_attach(struct dma_buf *dmabuf,=0D
 				struct dma_buf_attachment *attachment)=0D
 {=0D
=0D
---=0D
base-commit: 104016eb671e19709721c1b0048dd912dc2e96be=0D
change-id: 20260225-fix-uverbs-compilation-d6668390275b=0D
=0D
Best regards,=0D
--  =0D
Leon Romanovsky <leonro@nvidia.com>=0D
=0D

