Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4786539DFF8
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 17:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhFGPJB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 11:09:01 -0400
Received: from smtprelay0150.hostedemail.com ([216.40.44.150]:39004 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230220AbhFGPJB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Jun 2021 11:09:01 -0400
Received: from omf09.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 3C637100E7B42;
        Mon,  7 Jun 2021 15:07:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 11E8F1E04D5;
        Mon,  7 Jun 2021 15:07:07 +0000 (UTC)
Message-ID: <e3242b18d12db4bff77127d82d5e788b7712035a.camel@perches.com>
Subject: Re: irdma: utils.c typos in irdma_cqp_gather_stats_gen1 ?
From:   Joe Perches <joe@perches.com>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 07 Jun 2021 08:07:06 -0700
In-Reply-To: <d41c5503b5b74996af3f3c1853a67935@intel.com>
References: <9e07e80d8aa464447323670fd810f455d53f76f3.camel@perches.com>
         <d41c5503b5b74996af3f3c1853a67935@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.90
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 11E8F1E04D5
X-Stat-Signature: dm4hd4kw9p6qehpwofxh6awabsad9odp
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/zj8KEbA0EEpDZmDrCIUh8Jf8ytrS3JMo=
X-HE-Tag: 1623078427-529422
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 2021-06-07 at 14:54 +0000, Saleem, Shiraz wrote:
> > Subject: irdma: utils.c typos in irdma_cqp_gather_stats_gen1 ?
> > 
> > There are some odd mismatches in field and access index.
> > These may be simple cut/paste typos.
> > 
> > Are these intentional?
> 
> No. Accidental. Likely cut/copy mistake. I will send a fix. Thanks
> Joe!

Reason is I was refactoring what I thought was rather templated and
overly verbose code.

Here's a possible patch (with probable corrections to these index typos):
---
 drivers/infiniband/hw/irdma/type.h  | 104 ++++++++++---------
 drivers/infiniband/hw/irdma/utils.c | 196 +++++++++---------------------------
 drivers/infiniband/hw/irdma/verbs.c | 125 +++++++++--------------
 3 files changed, 147 insertions(+), 278 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index 7387b83e826d2..4050e5b19c6e1 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -101,60 +101,64 @@ enum irdma_qp_event_type {
 	IRDMA_QP_EVENT_ACCESS_ERR,
 };
 
+#define IRDMA_STAT(index)    IRDMA_HW_STAT_INDEX_ ## index
+#define IRDMA_STAT_32(index) (IRDMA_HW_STAT_INDEX_ ## index)
+#define IRDMA_STAT_64(index) (IRDMA_HW_STAT_INDEX_MAX_32 + IRDMA_STAT_32(index))
+
 enum irdma_hw_stats_index_32b {
-	IRDMA_HW_STAT_INDEX_IP4RXDISCARD	= 0,
-	IRDMA_HW_STAT_INDEX_IP4RXTRUNC		= 1,
-	IRDMA_HW_STAT_INDEX_IP4TXNOROUTE	= 2,
-	IRDMA_HW_STAT_INDEX_IP6RXDISCARD	= 3,
-	IRDMA_HW_STAT_INDEX_IP6RXTRUNC		= 4,
-	IRDMA_HW_STAT_INDEX_IP6TXNOROUTE	= 5,
-	IRDMA_HW_STAT_INDEX_TCPRTXSEG		= 6,
-	IRDMA_HW_STAT_INDEX_TCPRXOPTERR		= 7,
-	IRDMA_HW_STAT_INDEX_TCPRXPROTOERR	= 8,
-	IRDMA_HW_STAT_INDEX_MAX_32_GEN_1	= 9, /* Must be same value as next entry */
-	IRDMA_HW_STAT_INDEX_RXVLANERR		= 9,
-	IRDMA_HW_STAT_INDEX_RXRPCNPHANDLED	= 10,
-	IRDMA_HW_STAT_INDEX_RXRPCNPIGNORED	= 11,
-	IRDMA_HW_STAT_INDEX_TXNPCNPSENT		= 12,
-	IRDMA_HW_STAT_INDEX_MAX_32, /* Must be last entry */
+	IRDMA_STAT(IP4RXDISCARD)	= 0,
+	IRDMA_STAT(IP4RXTRUNC)		= 1,
+	IRDMA_STAT(IP4TXNOROUTE)	= 2,
+	IRDMA_STAT(IP6RXDISCARD)	= 3,
+	IRDMA_STAT(IP6RXTRUNC)		= 4,
+	IRDMA_STAT(IP6TXNOROUTE)	= 5,
+	IRDMA_STAT(TCPRTXSEG)		= 6,
+	IRDMA_STAT(TCPRXOPTERR)		= 7,
+	IRDMA_STAT(TCPRXPROTOERR)	= 8,
+	IRDMA_STAT(MAX_32_GEN_1)	= 9, /* Must be same value as next entry */
+	IRDMA_STAT(RXVLANERR)		= 9,
+	IRDMA_STAT(RXRPCNPHANDLED)	= 10,
+	IRDMA_STAT(RXRPCNPIGNORED)	= 11,
+	IRDMA_STAT(TXNPCNPSENT)		= 12,
+	IRDMA_STAT(MAX_32), /* Must be last entry */
 };
 
 enum irdma_hw_stats_index_64b {
-	IRDMA_HW_STAT_INDEX_IP4RXOCTS	= 0,
-	IRDMA_HW_STAT_INDEX_IP4RXPKTS	= 1,
-	IRDMA_HW_STAT_INDEX_IP4RXFRAGS	= 2,
-	IRDMA_HW_STAT_INDEX_IP4RXMCPKTS	= 3,
-	IRDMA_HW_STAT_INDEX_IP4TXOCTS	= 4,
-	IRDMA_HW_STAT_INDEX_IP4TXPKTS	= 5,
-	IRDMA_HW_STAT_INDEX_IP4TXFRAGS	= 6,
-	IRDMA_HW_STAT_INDEX_IP4TXMCPKTS	= 7,
-	IRDMA_HW_STAT_INDEX_IP6RXOCTS	= 8,
-	IRDMA_HW_STAT_INDEX_IP6RXPKTS	= 9,
-	IRDMA_HW_STAT_INDEX_IP6RXFRAGS	= 10,
-	IRDMA_HW_STAT_INDEX_IP6RXMCPKTS	= 11,
-	IRDMA_HW_STAT_INDEX_IP6TXOCTS	= 12,
-	IRDMA_HW_STAT_INDEX_IP6TXPKTS	= 13,
-	IRDMA_HW_STAT_INDEX_IP6TXFRAGS	= 14,
-	IRDMA_HW_STAT_INDEX_IP6TXMCPKTS	= 15,
-	IRDMA_HW_STAT_INDEX_TCPRXSEGS	= 16,
-	IRDMA_HW_STAT_INDEX_TCPTXSEG	= 17,
-	IRDMA_HW_STAT_INDEX_RDMARXRDS	= 18,
-	IRDMA_HW_STAT_INDEX_RDMARXSNDS	= 19,
-	IRDMA_HW_STAT_INDEX_RDMARXWRS	= 20,
-	IRDMA_HW_STAT_INDEX_RDMATXRDS	= 21,
-	IRDMA_HW_STAT_INDEX_RDMATXSNDS	= 22,
-	IRDMA_HW_STAT_INDEX_RDMATXWRS	= 23,
-	IRDMA_HW_STAT_INDEX_RDMAVBND	= 24,
-	IRDMA_HW_STAT_INDEX_RDMAVINV	= 25,
-	IRDMA_HW_STAT_INDEX_MAX_64_GEN_1 = 26, /* Must be same value as next entry */
-	IRDMA_HW_STAT_INDEX_IP4RXMCOCTS	= 26,
-	IRDMA_HW_STAT_INDEX_IP4TXMCOCTS	= 27,
-	IRDMA_HW_STAT_INDEX_IP6RXMCOCTS	= 28,
-	IRDMA_HW_STAT_INDEX_IP6TXMCOCTS	= 29,
-	IRDMA_HW_STAT_INDEX_UDPRXPKTS	= 30,
-	IRDMA_HW_STAT_INDEX_UDPTXPKTS	= 31,
-	IRDMA_HW_STAT_INDEX_RXNPECNMARKEDPKTS = 32,
-	IRDMA_HW_STAT_INDEX_MAX_64, /* Must be last entry */
+	IRDMA_STAT(IP4RXOCTS)	= 0,
+	IRDMA_STAT(IP4RXPKTS)	= 1,
+	IRDMA_STAT(IP4RXFRAGS)	= 2,
+	IRDMA_STAT(IP4RXMCPKTS)	= 3,
+	IRDMA_STAT(IP4TXOCTS)	= 4,
+	IRDMA_STAT(IP4TXPKTS)	= 5,
+	IRDMA_STAT(IP4TXFRAGS)	= 6,
+	IRDMA_STAT(IP4TXMCPKTS)	= 7,
+	IRDMA_STAT(IP6RXOCTS)	= 8,
+	IRDMA_STAT(IP6RXPKTS)	= 9,
+	IRDMA_STAT(IP6RXFRAGS)	= 10,
+	IRDMA_STAT(IP6RXMCPKTS)	= 11,
+	IRDMA_STAT(IP6TXOCTS)	= 12,
+	IRDMA_STAT(IP6TXPKTS)	= 13,
+	IRDMA_STAT(IP6TXFRAGS)	= 14,
+	IRDMA_STAT(IP6TXMCPKTS)	= 15,
+	IRDMA_STAT(TCPRXSEGS)	= 16,
+	IRDMA_STAT(TCPTXSEG)	= 17,
+	IRDMA_STAT(RDMARXRDS)	= 18,
+	IRDMA_STAT(RDMARXSNDS)	= 19,
+	IRDMA_STAT(RDMARXWRS)	= 20,
+	IRDMA_STAT(RDMATXRDS)	= 21,
+	IRDMA_STAT(RDMATXSNDS)	= 22,
+	IRDMA_STAT(RDMATXWRS)	= 23,
+	IRDMA_STAT(RDMAVBND)	= 24,
+	IRDMA_STAT(RDMAVINV)	= 25,
+	IRDMA_STAT(MAX_64_GEN_1) = 26, /* Must be same value as next entry */
+	IRDMA_STAT(IP4RXMCOCTS)	= 26,
+	IRDMA_STAT(IP4TXMCOCTS)	= 27,
+	IRDMA_STAT(IP6RXMCOCTS)	= 28,
+	IRDMA_STAT(IP6TXMCOCTS)	= 29,
+	IRDMA_STAT(UDPRXPKTS)	= 30,
+	IRDMA_STAT(UDPTXPKTS)	= 31,
+	IRDMA_STAT(RXNPECNMARKEDPKTS) = 32,
+	IRDMA_STAT(MAX_64), /* Must be last entry */
 };
 
 enum irdma_feature_type {
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 2f078155d6fd0..32c1200810eb8 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -1705,155 +1705,53 @@ void irdma_cqp_gather_stats_gen1(struct irdma_sc_dev *dev,
 	stats_inst_offset_32 *= 4;
 	stats_inst_offset_64 = stats_inst_offset_32 * 2;
 
-	gather_stats->rxvlanerr =
-		rd32(dev->hw,
-		     dev->hw_stats_regs_32[IRDMA_HW_STAT_INDEX_RXVLANERR]
-		     + stats_inst_offset_32);
-	gather_stats->ip4rxdiscard =
-		rd32(dev->hw,
-		     dev->hw_stats_regs_32[IRDMA_HW_STAT_INDEX_IP4RXDISCARD]
-		     + stats_inst_offset_32);
-	gather_stats->ip4rxtrunc =
-		rd32(dev->hw,
-		     dev->hw_stats_regs_32[IRDMA_HW_STAT_INDEX_IP4RXTRUNC]
-		     + stats_inst_offset_32);
-	gather_stats->ip4txnoroute =
-		rd32(dev->hw,
-		     dev->hw_stats_regs_32[IRDMA_HW_STAT_INDEX_IP4TXNOROUTE]
-		     + stats_inst_offset_32);
-	gather_stats->ip6rxdiscard =
-		rd32(dev->hw,
-		     dev->hw_stats_regs_32[IRDMA_HW_STAT_INDEX_IP6RXDISCARD]
-		     + stats_inst_offset_32);
-	gather_stats->ip6rxtrunc =
-		rd32(dev->hw,
-		     dev->hw_stats_regs_32[IRDMA_HW_STAT_INDEX_IP6RXTRUNC]
-		     + stats_inst_offset_32);
-	gather_stats->ip6txnoroute =
-		rd32(dev->hw,
-		     dev->hw_stats_regs_32[IRDMA_HW_STAT_INDEX_IP6TXNOROUTE]
-		     + stats_inst_offset_32);
-	gather_stats->tcprtxseg =
-		rd32(dev->hw,
-		     dev->hw_stats_regs_32[IRDMA_HW_STAT_INDEX_TCPRTXSEG]
-		     + stats_inst_offset_32);
-	gather_stats->tcprxopterr =
-		rd32(dev->hw,
-		     dev->hw_stats_regs_32[IRDMA_HW_STAT_INDEX_TCPRXOPTERR]
-		     + stats_inst_offset_32);
-
-	gather_stats->ip4rxocts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP4RXOCTS]
-		     + stats_inst_offset_64);
-	gather_stats->ip4rxpkts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP4RXPKTS]
-		     + stats_inst_offset_64);
-	gather_stats->ip4txfrag =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP4RXFRAGS]
-		     + stats_inst_offset_64);
-	gather_stats->ip4rxmcpkts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP4RXMCPKTS]
-		     + stats_inst_offset_64);
-	gather_stats->ip4txocts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP4TXOCTS]
-		     + stats_inst_offset_64);
-	gather_stats->ip4txpkts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP4TXPKTS]
-		     + stats_inst_offset_64);
-	gather_stats->ip4txfrag =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP4TXFRAGS]
-		     + stats_inst_offset_64);
-	gather_stats->ip4txmcpkts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP4TXMCPKTS]
-		     + stats_inst_offset_64);
-	gather_stats->ip6rxocts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP6RXOCTS]
-		     + stats_inst_offset_64);
-	gather_stats->ip6rxpkts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP6RXPKTS]
-		     + stats_inst_offset_64);
-	gather_stats->ip6txfrags =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP6RXFRAGS]
-		     + stats_inst_offset_64);
-	gather_stats->ip6rxmcpkts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP6RXMCPKTS]
-		     + stats_inst_offset_64);
-	gather_stats->ip6txocts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP6TXOCTS]
-		     + stats_inst_offset_64);
-	gather_stats->ip6txpkts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP6TXPKTS]
-		     + stats_inst_offset_64);
-	gather_stats->ip6txfrags =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP6TXFRAGS]
-		     + stats_inst_offset_64);
-	gather_stats->ip6txmcpkts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP6TXMCPKTS]
-		     + stats_inst_offset_64);
-	gather_stats->tcprxsegs =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_TCPRXSEGS]
-		     + stats_inst_offset_64);
-	gather_stats->tcptxsegs =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_TCPTXSEG]
-		     + stats_inst_offset_64);
-	gather_stats->rdmarxrds =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_RDMARXRDS]
-		     + stats_inst_offset_64);
-	gather_stats->rdmarxsnds =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_RDMARXSNDS]
-		     + stats_inst_offset_64);
-	gather_stats->rdmarxwrs =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_RDMARXWRS]
-		     + stats_inst_offset_64);
-	gather_stats->rdmatxrds =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_RDMATXRDS]
-		     + stats_inst_offset_64);
-	gather_stats->rdmatxsnds =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_RDMATXSNDS]
-		     + stats_inst_offset_64);
-	gather_stats->rdmatxwrs =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_RDMATXWRS]
-		     + stats_inst_offset_64);
-	gather_stats->rdmavbn =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_RDMAVBND]
-		     + stats_inst_offset_64);
-	gather_stats->rdmavinv =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_RDMAVINV]
-		     + stats_inst_offset_64);
-	gather_stats->udprxpkts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_UDPRXPKTS]
-		     + stats_inst_offset_64);
-	gather_stats->udptxpkts =
-		rd64(dev->hw,
-		     dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_UDPTXPKTS]
-		     + stats_inst_offset_64);
+#define get32(index)							\
+	rd32(dev->hw,							\
+	     dev->hw_stats_regs_32[IRDMA_STAT(index)] +			\
+	     stats_inst_offset_32)
+#define get64(index)							\
+	rd64(dev->hw,							\
+	     dev->hw_stats_regs_64[IRDMA_STAT(index)] +			\
+	     stats_inst_offset_64)
+
+	gather_stats->rxvlanerr = get32(RXVLANERR);
+	gather_stats->ip4rxdiscard = get32(IP4RXDISCARD);
+	gather_stats->ip4rxtrunc = get32(IP4RXTRUNC);
+	gather_stats->ip4txnoroute = get32(IP4TXNOROUTE);
+	gather_stats->ip6rxdiscard = get32(IP6RXDISCARD);
+	gather_stats->ip6rxtrunc = get32(IP6RXTRUNC);
+	gather_stats->ip6txnoroute = get32(IP6TXNOROUTE);
+	gather_stats->tcprtxseg = get32(TCPRTXSEG);
+	gather_stats->tcprxopterr = get32(TCPRXOPTERR);
+
+	gather_stats->ip4rxocts = get64(IP4RXOCTS);
+	gather_stats->ip4rxpkts = get64(IP4RXPKTS);
+	gather_stats->ip4rxfrags = get64(IP4RXFRAGS);
+	gather_stats->ip4rxmcpkts = get64(IP4RXMCPKTS);
+	gather_stats->ip4txocts = get64(IP4TXOCTS);
+	gather_stats->ip4txpkts = get64(IP4TXPKTS);
+	gather_stats->ip4txfrag = get64(IP4TXFRAGS);
+	gather_stats->ip4txmcpkts = get64(IP4TXMCPKTS);
+	gather_stats->ip6rxocts = get64(IP6RXOCTS);
+	gather_stats->ip6rxpkts = get64(IP6RXPKTS);
+	gather_stats->ip6rxfrags = get64(IP6RXFRAGS);
+	gather_stats->ip6rxmcpkts = get64(IP6RXMCPKTS);
+	gather_stats->ip6txocts = get64(IP6TXOCTS);
+	gather_stats->ip6txpkts = get64(IP6TXPKTS);
+	gather_stats->ip6txfrags = get64(IP6TXFRAGS);
+	gather_stats->ip6txmcpkts = get64(IP6TXMCPKTS);
+	gather_stats->tcprxsegs = get64(TCPRXSEGS);
+	gather_stats->tcptxsegs = get64(TCPTXSEG);
+	gather_stats->rdmarxrds = get64(RDMARXRDS);
+	gather_stats->rdmarxsnds = get64(RDMARXSNDS);
+	gather_stats->rdmarxwrs = get64(RDMARXWRS);
+	gather_stats->rdmatxrds = get64(RDMATXRDS);
+	gather_stats->rdmatxsnds = get64(RDMATXSNDS);
+	gather_stats->rdmatxwrs = get64(RDMATXWRS);
+	gather_stats->rdmavbn = get64(RDMAVBND);
+	gather_stats->rdmavinv = get64(RDMAVINV);
+	gather_stats->udprxpkts = get64(UDPRXPKTS);
+	gather_stats->udptxpkts = get64(UDPTXPKTS);
 
 	irdma_process_stats(pestat);
 }
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 2941552932431..cc8e7be0614ed 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3634,87 +3634,54 @@ static int irdma_iw_port_immutable(struct ib_device *ibdev, u32 port_num,
 
 static const char *const irdma_hw_stat_names[] = {
 	/* 32bit names */
-	[IRDMA_HW_STAT_INDEX_RXVLANERR] = "rxVlanErrors",
-	[IRDMA_HW_STAT_INDEX_IP4RXDISCARD] = "ip4InDiscards",
-	[IRDMA_HW_STAT_INDEX_IP4RXTRUNC] = "ip4InTruncatedPkts",
-	[IRDMA_HW_STAT_INDEX_IP4TXNOROUTE] = "ip4OutNoRoutes",
-	[IRDMA_HW_STAT_INDEX_IP6RXDISCARD] = "ip6InDiscards",
-	[IRDMA_HW_STAT_INDEX_IP6RXTRUNC] = "ip6InTruncatedPkts",
-	[IRDMA_HW_STAT_INDEX_IP6TXNOROUTE] = "ip6OutNoRoutes",
-	[IRDMA_HW_STAT_INDEX_TCPRTXSEG] = "tcpRetransSegs",
-	[IRDMA_HW_STAT_INDEX_TCPRXOPTERR] = "tcpInOptErrors",
-	[IRDMA_HW_STAT_INDEX_TCPRXPROTOERR] = "tcpInProtoErrors",
-	[IRDMA_HW_STAT_INDEX_RXRPCNPHANDLED] = "cnpHandled",
-	[IRDMA_HW_STAT_INDEX_RXRPCNPIGNORED] = "cnpIgnored",
-	[IRDMA_HW_STAT_INDEX_TXNPCNPSENT] = "cnpSent",
+	[IRDMA_STAT_32(RXVLANERR)]	= "rxVlanErrors",
+	[IRDMA_STAT_32(IP4RXDISCARD)]	= "ip4InDiscards",
+	[IRDMA_STAT_32(IP4RXTRUNC)]	= "ip4InTruncatedPkts",
+	[IRDMA_STAT_32(IP4TXNOROUTE)]	= "ip4OutNoRoutes",
+	[IRDMA_STAT_32(IP6RXDISCARD)]	= "ip6InDiscards",
+	[IRDMA_STAT_32(IP6RXTRUNC)]	= "ip6InTruncatedPkts",
+	[IRDMA_STAT_32(IP6TXNOROUTE)]	= "ip6OutNoRoutes",
+	[IRDMA_STAT_32(TCPRTXSEG)]	= "tcpRetransSegs",
+	[IRDMA_STAT_32(TCPRXOPTERR)]	= "tcpInOptErrors",
+	[IRDMA_STAT_32(TCPRXPROTOERR)]	= "tcpInProtoErrors",
+	[IRDMA_STAT_32(RXRPCNPHANDLED)]	= "cnpHandled",
+	[IRDMA_STAT_32(RXRPCNPIGNORED)]	= "cnpIgnored",
+	[IRDMA_STAT_32(TXNPCNPSENT)]	= "cnpSent",
 
 	/* 64bit names */
-	[IRDMA_HW_STAT_INDEX_IP4RXOCTS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"ip4InOctets",
-	[IRDMA_HW_STAT_INDEX_IP4RXPKTS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"ip4InPkts",
-	[IRDMA_HW_STAT_INDEX_IP4RXFRAGS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"ip4InReasmRqd",
-	[IRDMA_HW_STAT_INDEX_IP4RXMCOCTS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"ip4InMcastOctets",
-	[IRDMA_HW_STAT_INDEX_IP4RXMCPKTS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"ip4InMcastPkts",
-	[IRDMA_HW_STAT_INDEX_IP4TXOCTS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"ip4OutOctets",
-	[IRDMA_HW_STAT_INDEX_IP4TXPKTS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"ip4OutPkts",
-	[IRDMA_HW_STAT_INDEX_IP4TXFRAGS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"ip4OutSegRqd",
-	[IRDMA_HW_STAT_INDEX_IP4TXMCOCTS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"ip4OutMcastOctets",
-	[IRDMA_HW_STAT_INDEX_IP4TXMCPKTS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"ip4OutMcastPkts",
-	[IRDMA_HW_STAT_INDEX_IP6RXOCTS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"ip6InOctets",
-	[IRDMA_HW_STAT_INDEX_IP6RXPKTS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"ip6InPkts",
-	[IRDMA_HW_STAT_INDEX_IP6RXFRAGS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"ip6InReasmRqd",
-	[IRDMA_HW_STAT_INDEX_IP6RXMCOCTS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"ip6InMcastOctets",
-	[IRDMA_HW_STAT_INDEX_IP6RXMCPKTS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"ip6InMcastPkts",
-	[IRDMA_HW_STAT_INDEX_IP6TXOCTS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"ip6OutOctets",
-	[IRDMA_HW_STAT_INDEX_IP6TXPKTS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"ip6OutPkts",
-	[IRDMA_HW_STAT_INDEX_IP6TXFRAGS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"ip6OutSegRqd",
-	[IRDMA_HW_STAT_INDEX_IP6TXMCOCTS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"ip6OutMcastOctets",
-	[IRDMA_HW_STAT_INDEX_IP6TXMCPKTS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"ip6OutMcastPkts",
-	[IRDMA_HW_STAT_INDEX_TCPRXSEGS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"tcpInSegs",
-	[IRDMA_HW_STAT_INDEX_TCPTXSEG + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"tcpOutSegs",
-	[IRDMA_HW_STAT_INDEX_RDMARXRDS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"iwInRdmaReads",
-	[IRDMA_HW_STAT_INDEX_RDMARXSNDS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"iwInRdmaSends",
-	[IRDMA_HW_STAT_INDEX_RDMARXWRS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"iwInRdmaWrites",
-	[IRDMA_HW_STAT_INDEX_RDMATXRDS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"iwOutRdmaReads",
-	[IRDMA_HW_STAT_INDEX_RDMATXSNDS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"iwOutRdmaSends",
-	[IRDMA_HW_STAT_INDEX_RDMATXWRS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"iwOutRdmaWrites",
-	[IRDMA_HW_STAT_INDEX_RDMAVBND + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"iwRdmaBnd",
-	[IRDMA_HW_STAT_INDEX_RDMAVINV + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"iwRdmaInv",
-	[IRDMA_HW_STAT_INDEX_UDPRXPKTS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"RxUDP",
-	[IRDMA_HW_STAT_INDEX_UDPTXPKTS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"TxUDP",
-	[IRDMA_HW_STAT_INDEX_RXNPECNMARKEDPKTS + IRDMA_HW_STAT_INDEX_MAX_32] =
-		"RxECNMrkd",
+	[IRDMA_STAT_64(IP4RXOCTS)]	= "ip4InOctets",
+	[IRDMA_STAT_64(IP4RXPKTS)]	= "ip4InPkts",
+	[IRDMA_STAT_64(IP4RXFRAGS)]	= "ip4InReasmRqd",
+	[IRDMA_STAT_64(IP4RXMCOCTS)]	= "ip4InMcastOctets",
+	[IRDMA_STAT_64(IP4RXMCPKTS)]	= "ip4InMcastPkts",
+	[IRDMA_STAT_64(IP4TXOCTS)]	= "ip4OutOctets",
+	[IRDMA_STAT_64(IP4TXPKTS)]	= "ip4OutPkts",
+	[IRDMA_STAT_64(IP4TXFRAGS)]	= "ip4OutSegRqd",
+	[IRDMA_STAT_64(IP4TXMCOCTS)]	= "ip4OutMcastOctets",
+	[IRDMA_STAT_64(IP4TXMCPKTS)]	= "ip4OutMcastPkts",
+	[IRDMA_STAT_64(IP6RXOCTS)]	= "ip6InOctets",
+	[IRDMA_STAT_64(IP6RXPKTS)]	= "ip6InPkts",
+	[IRDMA_STAT_64(IP6RXFRAGS)]	= "ip6InReasmRqd",
+	[IRDMA_STAT_64(IP6RXMCOCTS)]	= "ip6InMcastOctets",
+	[IRDMA_STAT_64(IP6RXMCPKTS)]	= "ip6InMcastPkts",
+	[IRDMA_STAT_64(IP6TXOCTS)]	= "ip6OutOctets",
+	[IRDMA_STAT_64(IP6TXPKTS)]	= "ip6OutPkts",
+	[IRDMA_STAT_64(IP6TXFRAGS)]	= "ip6OutSegRqd",
+	[IRDMA_STAT_64(IP6TXMCOCTS)]	= "ip6OutMcastOctets",
+	[IRDMA_STAT_64(IP6TXMCPKTS)]	= "ip6OutMcastPkts",
+	[IRDMA_STAT_64(TCPRXSEGS)]	= "tcpInSegs",
+	[IRDMA_STAT_64(TCPTXSEG)]	= "tcpOutSegs",
+	[IRDMA_STAT_64(RDMARXRDS)]	= "iwInRdmaReads",
+	[IRDMA_STAT_64(RDMARXSNDS)]	= "iwInRdmaSends",
+	[IRDMA_STAT_64(RDMARXWRS)]	= "iwInRdmaWrites",
+	[IRDMA_STAT_64(RDMATXRDS)]	= "iwOutRdmaReads",
+	[IRDMA_STAT_64(RDMATXSNDS)]	= "iwOutRdmaSends",
+	[IRDMA_STAT_64(RDMATXWRS)]	= "iwOutRdmaWrites",
+	[IRDMA_STAT_64(RDMAVBND)]	= "iwRdmaBnd",
+	[IRDMA_STAT_64(RDMAVINV)]	= "iwRdmaInv",
+	[IRDMA_STAT_64(UDPRXPKTS)]	= "RxUDP",
+	[IRDMA_STAT_64(UDPTXPKTS)]	= "TxUDP",
+	[IRDMA_STAT_64(RXNPECNMARKEDPKTS)]	= "RxECNMrkd",
 };
 
 static void irdma_get_dev_fw_str(struct ib_device *dev, char *str)

