Return-Path: <linux-rdma+bounces-2537-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D808C93B3
	for <lists+linux-rdma@lfdr.de>; Sun, 19 May 2024 09:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6A42816BE
	for <lists+linux-rdma@lfdr.de>; Sun, 19 May 2024 07:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A47517C6B;
	Sun, 19 May 2024 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="laMt+PtV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-70.smtpout.orange.fr [80.12.242.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BE115AC4;
	Sun, 19 May 2024 07:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716104205; cv=none; b=S5n34EAQKauEE+SZzw4Uz8nkvRm+1SZbl3EYD0pJ1EfdpNZHkm++rqht0rehL3U1oSb5wgPqo8iQM4Ftq2lM+4ZdAocqpUT5NsIGr6rixwaQJBCezmDKTIKfaHpwKkL9zN5V204abDBXGwxPIh+Kf0lrFw29q71t+Mdi7EWAxf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716104205; c=relaxed/simple;
	bh=EvmQQWNeJGwNqewjsCWVicRfAYaNcgdeLiLjrEetQbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AVMpLh2CoHaHPITJbPvaiPGAXKa+no//qK2VzxnEc6azHCAEKVbjRhA+keS4j5fpg/U5fYjG5bkuRU9lk4pLSRz84uyrM1OlY8Nl6fP5GtPLswXF9uE5aKulaqipPJCqep9/NoyhWkNEuEnh4PpXeYuGtxZ9ArSVCzHLPO8KVS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=laMt+PtV; arc=none smtp.client-ip=80.12.242.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 8aYusLlTw69OH8aYusyjjq; Sun, 19 May 2024 09:02:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1716102150;
	bh=DpV324OF1N6KWvT4lJQi/tT98cIN5IcDh30eoiZYvd0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=laMt+PtVCBzsbS0whtoPwaW+J+XwtrmW2Nl3RA2gKV94y/I0bEpUVtDm2QEr1x6X4
	 3bNbLg8hPALHUdhBB+piZyiuMXEGjPbTIaS9/SryDTbieWwtwfwpbDrwvnItMnwwgI
	 i403EWtgKbooMY70cFtTvgzzYh7GcQmSYX4jBx8KXcZMPMI/432UEj9TMWjKB/l0d0
	 CHr0DwCpGvIgOiVmWsopRcLDYeKIfVmlbbbiLLW8+xOJvghTLOkn9k3k1z1RuzbRbG
	 NcCsZO0vZ9MZH21WeAiY3pLlQTWrvoKj//5A2BPfQe7EmLWp+OHEamjbGcsY2/730G
	 csRzU7MOETESg==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 19 May 2024 09:02:30 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Mustafa Ismail <mustafa.ismail@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-rdma@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] RDMA/irdma: Annotate  flexible array with __counted_by() in struct irdma_qvlist_info
Date: Sun, 19 May 2024 09:02:15 +0200
Message-ID: <2ca8b14adf79c4795d7aa95bbfc79253a6bfed82.1716102112.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'num_vectors' is used to count the number of elements in the 'qv_info'
flexible array in "struct irdma_qvlist_info".

So annotate it with __counted_by() to make it explicit and enable some
additional checks.

This allocation is done in irdma_save_msix_info().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/hw/irdma/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index b65bc2ea542f..9f0ed6e84471 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -239,7 +239,7 @@ struct irdma_qv_info {
 
 struct irdma_qvlist_info {
 	u32 num_vectors;
-	struct irdma_qv_info qv_info[];
+	struct irdma_qv_info qv_info[] __counted_by(num_vectors);
 };
 
 struct irdma_gen_ops {
-- 
2.45.1


