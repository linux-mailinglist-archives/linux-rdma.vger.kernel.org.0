Return-Path: <linux-rdma+bounces-475-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC95581D097
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Dec 2023 00:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC571C20E7F
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Dec 2023 23:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5F235EE9;
	Fri, 22 Dec 2023 23:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0DFfXuvC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE8335EE3;
	Fri, 22 Dec 2023 23:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=xlxgje3UaSBCWUqU3cE6lT9GNviJolLmY2/JzIgy6DQ=; b=0DFfXuvCq2dMImvornjiY+xKKR
	yupnFemjTEabgltjBZdEhBBw7M7D7WyAsEzznuEXYjqNyoQiZXenAGRYYuemniHkDqDpCJOKEOzoc
	SPvtl8HgPscsxj4ccI2w7bdn2NSYPEv2+2ANwjLz3nAxtLwx6Ewlx1hziXzg3mSyUkipO6BlJ4B4d
	uvZBBGIjvTKrd490ACJsHR1K+ITWo8ye2WDjZNeoZuLjie7hRLjBUj7D0xo2+xmpa0eu7giqG40Al
	jolrx0TZgZsy7gEo8A3gSws051//wQG4/rmv3RlVd9v2eYWw1TO+Ikz3pPMog/SFCjBTZgXl0Xuw+
	nA9ySEJQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGpDk-0072Dw-01;
	Fri, 22 Dec 2023 23:46:24 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH] IB/iser: iscsi_iser.h: fix kernel-doc warning and spellos
Date: Fri, 22 Dec 2023 15:46:23 -0800
Message-ID: <20231222234623.25231-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop one kernel-doc comment to prevent a warning:

iscsi_iser.h:313: warning: Excess struct member 'mr' description in 'iser_device'

and spell 2 words correctly (buffer and deferred).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/ulp/iser/iscsi_iser.h |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff -- a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
--- a/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -182,7 +182,7 @@ enum iser_data_dir {
  *
  * @sg:           pointer to the sg list
  * @size:         num entries of this sg
- * @data_len:     total beffer byte len
+ * @data_len:     total buffer byte len
  * @dma_nents:    returned by dma_map_sg
  */
 struct iser_data_buf {
@@ -299,7 +299,6 @@ struct ib_conn;
  *
  * @ib_device:     RDMA device
  * @pd:            Protection Domain for this device
- * @mr:            Global DMA memory region
  * @event_handler: IB events handle routine
  * @ig_list:	   entry in devices list
  * @refcount:      Reference counter, dominated by open iser connections
@@ -389,7 +388,7 @@ struct ib_conn {
  *                    to max number of post recvs
  * @max_cmds:         maximum cmds allowed for this connection
  * @name:             connection peer portal
- * @release_work:     deffered work for release job
+ * @release_work:     deferred work for release job
  * @state_mutex:      protects iser onnection state
  * @stop_completion:  conn_stop completion
  * @ib_completion:    RDMA cleanup completion

