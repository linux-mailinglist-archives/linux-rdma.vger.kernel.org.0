Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FE339EA38
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 01:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhFGXjK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 19:39:10 -0400
Received: from smtprelay0088.hostedemail.com ([216.40.44.88]:34326 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230306AbhFGXjK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Jun 2021 19:39:10 -0400
Received: from omf09.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id AB5A118077354;
        Mon,  7 Jun 2021 23:37:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 82C8B1E04D6;
        Mon,  7 Jun 2021 23:37:16 +0000 (UTC)
Message-ID: <6147b2a2a5992525482f2cf61d2939b110062d8c.camel@perches.com>
Subject: Re: irdma: utils.c typos in irdma_cqp_gather_stats_gen1 ?
From:   Joe Perches <joe@perches.com>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 07 Jun 2021 16:37:15 -0700
In-Reply-To: <7bc8c264a70a4026b3bc7d9edd9e8945@intel.com>
References: <9e07e80d8aa464447323670fd810f455d53f76f3.camel@perches.com>
         <d41c5503b5b74996af3f3c1853a67935@intel.com>
         <e3242b18d12db4bff77127d82d5e788b7712035a.camel@perches.com>
         <7bc8c264a70a4026b3bc7d9edd9e8945@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.90
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 82C8B1E04D6
X-Stat-Signature: d45niqe4yw5xhxfs6gdho5hrae19i1aj
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18hao3+0yMIuOu06omwYSzKFt0v/HHg0tw=
X-HE-Tag: 1623109036-565830
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 2021-06-07 at 22:40 +0000, Saleem, Shiraz wrote:
> > Subject: Re: irdma: utils.c typos in irdma_cqp_gather_stats_gen1 ?
> > 
> > On Mon, 2021-06-07 at 14:54 +0000, Saleem, Shiraz wrote:
> > > > Subject: irdma: utils.c typos in irdma_cqp_gather_stats_gen1 ?
> > > > 
> > > > There are some odd mismatches in field and access index.
> > > > These may be simple cut/paste typos.
> > > > 
> > > > Are these intentional?
> > > 
> > > No. Accidental. Likely cut/copy mistake. I will send a fix. Thanks
> > > Joe!
> > 
> > Reason is I was refactoring what I thought was rather templated and
> > overly verbose
> > code.
> > 
> > Here's a possible patch (with probable corrections to these index
> > typos):
> 
> Looks reasonable to me. Wondering if irdma_update_stats should also
> use your IRDMA_STAT macro.

Probably, and it could really a macro or two of its own.

And it looks like that block has it's own copy/paste defects.

Maybe:
---
 drivers/infiniband/hw/irdma/ctrl.c | 219 +++++++++----------------------------
 1 file changed, 51 insertions(+), 168 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index 5aa112067bce8..90c6f82ea0c8d 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -5484,174 +5484,57 @@ void irdma_update_stats(struct irdma_dev_hw_stats *hw_stats,
 {
 	u64 *stats_val = hw_stats->stats_val_32;
 
-	stats_val[IRDMA_HW_STAT_INDEX_RXVLANERR] +=
-		IRDMA_STATS_DELTA(gather_stats->rxvlanerr,
-				  last_gather_stats->rxvlanerr,
-				  IRDMA_MAX_STATS_32);
-	stats_val[IRDMA_HW_STAT_INDEX_IP4RXDISCARD] +=
-		IRDMA_STATS_DELTA(gather_stats->ip4rxdiscard,
-				  last_gather_stats->ip4rxdiscard,
-				  IRDMA_MAX_STATS_32);
-	stats_val[IRDMA_HW_STAT_INDEX_IP4RXTRUNC] +=
-		IRDMA_STATS_DELTA(gather_stats->ip4rxtrunc,
-				  last_gather_stats->ip4rxtrunc,
-				  IRDMA_MAX_STATS_32);
-	stats_val[IRDMA_HW_STAT_INDEX_IP4TXNOROUTE] +=
-		IRDMA_STATS_DELTA(gather_stats->ip4txnoroute,
-				  last_gather_stats->ip4txnoroute,
-				  IRDMA_MAX_STATS_32);
-	stats_val[IRDMA_HW_STAT_INDEX_IP6RXDISCARD] +=
-		IRDMA_STATS_DELTA(gather_stats->ip6rxdiscard,
-				  last_gather_stats->ip6rxdiscard,
-				  IRDMA_MAX_STATS_32);
-	stats_val[IRDMA_HW_STAT_INDEX_IP6RXTRUNC] +=
-		IRDMA_STATS_DELTA(gather_stats->ip6rxtrunc,
-				  last_gather_stats->ip6rxtrunc,
-				  IRDMA_MAX_STATS_32);
-	stats_val[IRDMA_HW_STAT_INDEX_IP6TXNOROUTE] +=
-		IRDMA_STATS_DELTA(gather_stats->ip6txnoroute,
-				  last_gather_stats->ip6txnoroute,
-				  IRDMA_MAX_STATS_32);
-	stats_val[IRDMA_HW_STAT_INDEX_TCPRTXSEG] +=
-		IRDMA_STATS_DELTA(gather_stats->tcprtxseg,
-				  last_gather_stats->tcprtxseg,
-				  IRDMA_MAX_STATS_32);
-	stats_val[IRDMA_HW_STAT_INDEX_TCPRXOPTERR] +=
-		IRDMA_STATS_DELTA(gather_stats->tcprxopterr,
-				  last_gather_stats->tcprxopterr,
-				  IRDMA_MAX_STATS_32);
-	stats_val[IRDMA_HW_STAT_INDEX_TCPRXPROTOERR] +=
-		IRDMA_STATS_DELTA(gather_stats->tcprxprotoerr,
-				  last_gather_stats->tcprxprotoerr,
-				  IRDMA_MAX_STATS_32);
-	stats_val[IRDMA_HW_STAT_INDEX_RXRPCNPHANDLED] +=
-		IRDMA_STATS_DELTA(gather_stats->rxrpcnphandled,
-				  last_gather_stats->rxrpcnphandled,
-				  IRDMA_MAX_STATS_32);
-	stats_val[IRDMA_HW_STAT_INDEX_RXRPCNPIGNORED] +=
-		IRDMA_STATS_DELTA(gather_stats->rxrpcnpignored,
-				  last_gather_stats->rxrpcnpignored,
-				  IRDMA_MAX_STATS_32);
-	stats_val[IRDMA_HW_STAT_INDEX_TXNPCNPSENT] +=
-		IRDMA_STATS_DELTA(gather_stats->txnpcnpsent,
-				  last_gather_stats->txnpcnpsent,
-				  IRDMA_MAX_STATS_32);
+#define irdma_update_stat(index, var, size)				\
+	stats_val[IRDMA_STAT(index)] +=					\
+		IRDMA_STATS_DELTA(gather_stats->var,			\
+				  last_gather_stats->var,		\
+				  IRDMA_MAX_STATS_##size)
+
+	irdma_update_stat(RXVLANERR, rxvlanerr, 32);
+	irdma_update_stat(IP4RXDISCARD, ip4rxdiscard, 32);
+	irdma_update_stat(IP4RXTRUNC, ip4rxtrunc, 32);
+	irdma_update_stat(IP4TXNOROUTE, ip4txnoroute, 32);
+	irdma_update_stat(IP6RXDISCARD, ip6rxdiscard, 32);
+	irdma_update_stat(IP6RXTRUNC, ip6rxtrunc, 32);
+	irdma_update_stat(IP6TXNOROUTE, ip6txnoroute, 32);
+	irdma_update_stat(TCPRTXSEG, tcprtxseg, 32);
+	irdma_update_stat(TCPRXOPTERR, tcprxopterr, 32);
+	irdma_update_stat(TCPRXPROTOERR, tcprxprotoerr, 32);
+	irdma_update_stat(RXRPCNPHANDLED, rxrpcnphandled, 32);
+	irdma_update_stat(RXRPCNPIGNORED, rxrpcnpignored, 32);
+	irdma_update_stat(TXNPCNPSENT, txnpcnpsent, 32);
+
 	stats_val = hw_stats->stats_val_64;
-	stats_val[IRDMA_HW_STAT_INDEX_IP4RXOCTS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip4rxocts,
-				  last_gather_stats->ip4rxocts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP4RXPKTS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip4rxpkts,
-				  last_gather_stats->ip4rxpkts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP4RXFRAGS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip4txfrag,
-				  last_gather_stats->ip4txfrag,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP4RXMCPKTS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip4rxmcpkts,
-				  last_gather_stats->ip4rxmcpkts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP4TXOCTS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip4txocts,
-				  last_gather_stats->ip4txocts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP4TXPKTS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip4txpkts,
-				  last_gather_stats->ip4txpkts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP4TXFRAGS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip4txfrag,
-				  last_gather_stats->ip4txfrag,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP4TXMCPKTS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip4txmcpkts,
-				  last_gather_stats->ip4txmcpkts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP6RXOCTS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip6rxocts,
-				  last_gather_stats->ip6rxocts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP6RXPKTS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip6rxpkts,
-				  last_gather_stats->ip6rxpkts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP6RXFRAGS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip6txfrags,
-				  last_gather_stats->ip6txfrags,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP6RXMCPKTS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip6rxmcpkts,
-				  last_gather_stats->ip6rxmcpkts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP6TXOCTS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip6txocts,
-				  last_gather_stats->ip6txocts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP6TXPKTS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip6txpkts,
-				  last_gather_stats->ip6txpkts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP6TXFRAGS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip6txfrags,
-				  last_gather_stats->ip6txfrags,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_IP6TXMCPKTS] +=
-		IRDMA_STATS_DELTA(gather_stats->ip6txmcpkts,
-				  last_gather_stats->ip6txmcpkts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_TCPRXSEGS] +=
-		IRDMA_STATS_DELTA(gather_stats->tcprxsegs,
-				  last_gather_stats->tcprxsegs,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_TCPTXSEG] +=
-		IRDMA_STATS_DELTA(gather_stats->tcptxsegs,
-				  last_gather_stats->tcptxsegs,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_RDMARXRDS] +=
-		IRDMA_STATS_DELTA(gather_stats->rdmarxrds,
-				  last_gather_stats->rdmarxrds,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_RDMARXSNDS] +=
-		IRDMA_STATS_DELTA(gather_stats->rdmarxsnds,
-				  last_gather_stats->rdmarxsnds,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_RDMARXWRS] +=
-		IRDMA_STATS_DELTA(gather_stats->rdmarxwrs,
-				  last_gather_stats->rdmarxwrs,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_RDMATXRDS] +=
-		IRDMA_STATS_DELTA(gather_stats->rdmatxrds,
-				  last_gather_stats->rdmatxrds,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_RDMATXSNDS] +=
-		IRDMA_STATS_DELTA(gather_stats->rdmatxsnds,
-				  last_gather_stats->rdmatxsnds,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_RDMATXWRS] +=
-		IRDMA_STATS_DELTA(gather_stats->rdmatxwrs,
-				  last_gather_stats->rdmatxwrs,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_RDMAVBND] +=
-		IRDMA_STATS_DELTA(gather_stats->rdmavbn,
-				  last_gather_stats->rdmavbn,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_RDMAVINV] +=
-		IRDMA_STATS_DELTA(gather_stats->rdmavinv,
-				  last_gather_stats->rdmavinv,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_UDPRXPKTS] +=
-		IRDMA_STATS_DELTA(gather_stats->udprxpkts,
-				  last_gather_stats->udprxpkts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_UDPTXPKTS] +=
-		IRDMA_STATS_DELTA(gather_stats->udptxpkts,
-				  last_gather_stats->udptxpkts,
-				  IRDMA_MAX_STATS_48);
-	stats_val[IRDMA_HW_STAT_INDEX_RXNPECNMARKEDPKTS] +=
-		IRDMA_STATS_DELTA(gather_stats->rxnpecnmrkpkts,
-				  last_gather_stats->rxnpecnmrkpkts,
-				  IRDMA_MAX_STATS_48);
+
+	irdma_update_stat(IP4RXOCTS, ip4rxocts, 48);
+	irdma_update_stat(IP4RXPKTS, ip4rxpkts, 48);
+	irdma_update_stat(IP4RXFRAGS, ip4rxfrags, 48);
+	irdma_update_stat(IP4RXMCPKTS, ip4rxmcpkts, 48);
+	irdma_update_stat(IP4TXOCTS, ip4txocts, 48);
+	irdma_update_stat(IP4TXPKTS, ip4txpkts, 48);
+	irdma_update_stat(IP4TXFRAGS, ip4txfrag, 48);
+	irdma_update_stat(IP4TXMCPKTS, ip4txmcpkts, 48);
+	irdma_update_stat(IP6RXOCTS, ip6rxocts, 48);
+	irdma_update_stat(IP6RXPKTS, ip6rxpkts, 48);
+	irdma_update_stat(IP6RXFRAGS, ip6rxfrags, 48);
+	irdma_update_stat(IP6RXMCPKTS, ip6rxmcpkts, 48);
+	irdma_update_stat(IP6TXOCTS, ip6txocts, 48);
+	irdma_update_stat(IP6TXPKTS, ip6txpkts, 48);
+	irdma_update_stat(IP6TXFRAGS, ip6txfrags, 48);
+	irdma_update_stat(IP6TXMCPKTS, ip6txmcpkts, 48);
+	irdma_update_stat(TCPRXSEGS, tcprxsegs, 48);
+	irdma_update_stat(TCPTXSEG, tcptxsegs, 48);
+	irdma_update_stat(RDMARXRDS, rdmarxrds, 48);
+	irdma_update_stat(RDMARXSNDS, rdmarxsnds, 48);
+	irdma_update_stat(RDMARXWRS, rdmarxwrs, 48);
+	irdma_update_stat(RDMATXRDS, rdmatxrds, 48);
+	irdma_update_stat(RDMATXSNDS, rdmatxsnds, 48);
+	irdma_update_stat(RDMATXWRS, rdmatxwrs, 48);
+	irdma_update_stat(RDMAVBND, rdmavbn, 48);
+	irdma_update_stat(RDMAVINV, rdmavinv, 48);
+	irdma_update_stat(UDPRXPKTS, udprxpkts, 48);
+	irdma_update_stat(UDPTXPKTS, udptxpkts, 48);
+	irdma_update_stat(RXNPECNMARKEDPKTS, rxnpecnmrkpkts, 48);
+
 	memcpy(last_gather_stats, gather_stats, sizeof(*last_gather_stats));
 }

