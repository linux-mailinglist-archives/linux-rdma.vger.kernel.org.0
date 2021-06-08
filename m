Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FA639FC38
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 18:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhFHQT7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 8 Jun 2021 12:19:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:58990 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230222AbhFHQT6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Jun 2021 12:19:58 -0400
IronPort-SDR: o2nClvxJSC+m4HnHfxX45b2m26h+4Zc1TBGAVz0Dk2scs1zkzavUMRXhUZh0RVhcqYRbV2ykph
 0t+fDa/3wpnA==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="204903120"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="204903120"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 09:18:05 -0700
IronPort-SDR: uU1v7fLi1Ekq+TjSizPLVILzOEAg8ij5b63LrkyUuj5VysbCot24pOgNBb+HJuktN2N35QD6mZ
 bYgDN+KTAwoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="619358458"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 08 Jun 2021 09:18:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 8 Jun 2021 09:18:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 8 Jun 2021 09:18:03 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2242.008;
 Tue, 8 Jun 2021 09:18:03 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Joe Perches <joe@perches.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: irdma: utils.c typos in irdma_cqp_gather_stats_gen1 ?
Thread-Topic: irdma: utils.c typos in irdma_cqp_gather_stats_gen1 ?
Thread-Index: AQHXWnC6BhX5oDUlRUmhwRc1TlnwJqsHGdlAgAIELQD//9K5YIAAu9CAgACgZAA=
Date:   Tue, 8 Jun 2021 16:18:03 +0000
Message-ID: <38e0a7b9c19543c2aee679bdd346c5a9@intel.com>
References: <9e07e80d8aa464447323670fd810f455d53f76f3.camel@perches.com>
         <d41c5503b5b74996af3f3c1853a67935@intel.com>
         <e3242b18d12db4bff77127d82d5e788b7712035a.camel@perches.com>
         <7bc8c264a70a4026b3bc7d9edd9e8945@intel.com>
 <6147b2a2a5992525482f2cf61d2939b110062d8c.camel@perches.com>
In-Reply-To: <6147b2a2a5992525482f2cf61d2939b110062d8c.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: Re: irdma: utils.c typos in irdma_cqp_gather_stats_gen1 ?
> 
> On Mon, 2021-06-07 at 22:40 +0000, Saleem, Shiraz wrote:
> > > Subject: Re: irdma: utils.c typos in irdma_cqp_gather_stats_gen1 ?
> > >
> > > On Mon, 2021-06-07 at 14:54 +0000, Saleem, Shiraz wrote:
> > > > > Subject: irdma: utils.c typos in irdma_cqp_gather_stats_gen1 ?
> > > > >
> > > > > There are some odd mismatches in field and access index.
> > > > > These may be simple cut/paste typos.
> > > > >
> > > > > Are these intentional?
> > > >
> > > > No. Accidental. Likely cut/copy mistake. I will send a fix. Thanks
> > > > Joe!
> > >
> > > Reason is I was refactoring what I thought was rather templated and
> > > overly verbose code.
> > >
> > > Here's a possible patch (with probable corrections to these index
> > > typos):
> >
> > Looks reasonable to me. Wondering if irdma_update_stats should also
> > use your IRDMA_STAT macro.
> 
> Probably, and it could really a macro or two of its own.
> 
> And it looks like that block has it's own copy/paste defects.
> 
> Maybe:
> ---
>  drivers/infiniband/hw/irdma/ctrl.c | 219 +++++++++----------------------------
>  1 file changed, 51 insertions(+), 168 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
> index 5aa112067bce8..90c6f82ea0c8d 100644
> --- a/drivers/infiniband/hw/irdma/ctrl.c
> +++ b/drivers/infiniband/hw/irdma/ctrl.c
> @@ -5484,174 +5484,57 @@ void irdma_update_stats(struct irdma_dev_hw_stats
> *hw_stats,  {
>  	u64 *stats_val = hw_stats->stats_val_32;
> 
> -	stats_val[IRDMA_HW_STAT_INDEX_RXVLANERR] +=
> -		IRDMA_STATS_DELTA(gather_stats->rxvlanerr,
> -				  last_gather_stats->rxvlanerr,
> -				  IRDMA_MAX_STATS_32);
> -	stats_val[IRDMA_HW_STAT_INDEX_IP4RXDISCARD] +=
> -		IRDMA_STATS_DELTA(gather_stats->ip4rxdiscard,
> -				  last_gather_stats->ip4rxdiscard,
> -				  IRDMA_MAX_STATS_32);
> -	stats_val[IRDMA_HW_STAT_INDEX_IP4RXTRUNC] +=
> -		IRDMA_STATS_DELTA(gather_stats->ip4rxtrunc,
> -				  last_gather_stats->ip4rxtrunc,
> -				  IRDMA_MAX_STATS_32);
> -	stats_val[IRDMA_HW_STAT_INDEX_IP4TXNOROUTE] +=
> -		IRDMA_STATS_DELTA(gather_stats->ip4txnoroute,
> -				  last_gather_stats->ip4txnoroute,
> -				  IRDMA_MAX_STATS_32);
> -	stats_val[IRDMA_HW_STAT_INDEX_IP6RXDISCARD] +=
> -		IRDMA_STATS_DELTA(gather_stats->ip6rxdiscard,
> -				  last_gather_stats->ip6rxdiscard,
> -				  IRDMA_MAX_STATS_32);
> -	stats_val[IRDMA_HW_STAT_INDEX_IP6RXTRUNC] +=
> -		IRDMA_STATS_DELTA(gather_stats->ip6rxtrunc,
> -				  last_gather_stats->ip6rxtrunc,
> -				  IRDMA_MAX_STATS_32);
> -	stats_val[IRDMA_HW_STAT_INDEX_IP6TXNOROUTE] +=
> -		IRDMA_STATS_DELTA(gather_stats->ip6txnoroute,
> -				  last_gather_stats->ip6txnoroute,
> -				  IRDMA_MAX_STATS_32);
> -	stats_val[IRDMA_HW_STAT_INDEX_TCPRTXSEG] +=
> -		IRDMA_STATS_DELTA(gather_stats->tcprtxseg,
> -				  last_gather_stats->tcprtxseg,
> -				  IRDMA_MAX_STATS_32);
> -	stats_val[IRDMA_HW_STAT_INDEX_TCPRXOPTERR] +=
> -		IRDMA_STATS_DELTA(gather_stats->tcprxopterr,
> -				  last_gather_stats->tcprxopterr,
> -				  IRDMA_MAX_STATS_32);
> -	stats_val[IRDMA_HW_STAT_INDEX_TCPRXPROTOERR] +=
> -		IRDMA_STATS_DELTA(gather_stats->tcprxprotoerr,
> -				  last_gather_stats->tcprxprotoerr,
> -				  IRDMA_MAX_STATS_32);
> -	stats_val[IRDMA_HW_STAT_INDEX_RXRPCNPHANDLED] +=
> -		IRDMA_STATS_DELTA(gather_stats->rxrpcnphandled,
> -				  last_gather_stats->rxrpcnphandled,
> -				  IRDMA_MAX_STATS_32);
> -	stats_val[IRDMA_HW_STAT_INDEX_RXRPCNPIGNORED] +=
> -		IRDMA_STATS_DELTA(gather_stats->rxrpcnpignored,
> -				  last_gather_stats->rxrpcnpignored,
> -				  IRDMA_MAX_STATS_32);
> -	stats_val[IRDMA_HW_STAT_INDEX_TXNPCNPSENT] +=
> -		IRDMA_STATS_DELTA(gather_stats->txnpcnpsent,
> -				  last_gather_stats->txnpcnpsent,
> -				  IRDMA_MAX_STATS_32);
> +#define irdma_update_stat(index, var, size)				\

Maybe var --> name. Other than that looks good.


> +	stats_val[IRDMA_STAT(index)] +=					\
> +		IRDMA_STATS_DELTA(gather_stats->var,			\
> +				  last_gather_stats->var,		\
> +				  IRDMA_MAX_STATS_##size)
> +
> +	irdma_update_stat(RXVLANERR, rxvlanerr, 32);
> +	irdma_update_stat(IP4RXDISCARD, ip4rxdiscard, 32);
> +	irdma_update_stat(IP4RXTRUNC, ip4rxtrunc, 32);
> +	irdma_update_stat(IP4TXNOROUTE, ip4txnoroute, 32);
> +	irdma_update_stat(IP6RXDISCARD, ip6rxdiscard, 32);
> +	irdma_update_stat(IP6RXTRUNC, ip6rxtrunc, 32);
> +	irdma_update_stat(IP6TXNOROUTE, ip6txnoroute, 32);
> +	irdma_update_stat(TCPRTXSEG, tcprtxseg, 32);
> +	irdma_update_stat(TCPRXOPTERR, tcprxopterr, 32);
> +	irdma_update_stat(TCPRXPROTOERR, tcprxprotoerr, 32);
> +	irdma_update_stat(RXRPCNPHANDLED, rxrpcnphandled, 32);
> +	irdma_update_stat(RXRPCNPIGNORED, rxrpcnpignored, 32);
> +	irdma_update_stat(TXNPCNPSENT, txnpcnpsent, 32);
> +
>  	stats_val = hw_stats->stats_val_64;
> -	stats_val[IRDMA_HW_STAT_INDEX_IP4RXOCTS] +=
> -		IRDMA_STATS_DELTA(gather_stats->ip4rxocts,
> -				  last_gather_stats->ip4rxocts,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_IP4RXPKTS] +=
> -		IRDMA_STATS_DELTA(gather_stats->ip4rxpkts,
> -				  last_gather_stats->ip4rxpkts,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_IP4RXFRAGS] +=
> -		IRDMA_STATS_DELTA(gather_stats->ip4txfrag,
> -				  last_gather_stats->ip4txfrag,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_IP4RXMCPKTS] +=
> -		IRDMA_STATS_DELTA(gather_stats->ip4rxmcpkts,
> -				  last_gather_stats->ip4rxmcpkts,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_IP4TXOCTS] +=
> -		IRDMA_STATS_DELTA(gather_stats->ip4txocts,
> -				  last_gather_stats->ip4txocts,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_IP4TXPKTS] +=
> -		IRDMA_STATS_DELTA(gather_stats->ip4txpkts,
> -				  last_gather_stats->ip4txpkts,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_IP4TXFRAGS] +=
> -		IRDMA_STATS_DELTA(gather_stats->ip4txfrag,
> -				  last_gather_stats->ip4txfrag,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_IP4TXMCPKTS] +=
> -		IRDMA_STATS_DELTA(gather_stats->ip4txmcpkts,
> -				  last_gather_stats->ip4txmcpkts,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_IP6RXOCTS] +=
> -		IRDMA_STATS_DELTA(gather_stats->ip6rxocts,
> -				  last_gather_stats->ip6rxocts,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_IP6RXPKTS] +=
> -		IRDMA_STATS_DELTA(gather_stats->ip6rxpkts,
> -				  last_gather_stats->ip6rxpkts,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_IP6RXFRAGS] +=
> -		IRDMA_STATS_DELTA(gather_stats->ip6txfrags,
> -				  last_gather_stats->ip6txfrags,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_IP6RXMCPKTS] +=
> -		IRDMA_STATS_DELTA(gather_stats->ip6rxmcpkts,
> -				  last_gather_stats->ip6rxmcpkts,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_IP6TXOCTS] +=
> -		IRDMA_STATS_DELTA(gather_stats->ip6txocts,
> -				  last_gather_stats->ip6txocts,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_IP6TXPKTS] +=
> -		IRDMA_STATS_DELTA(gather_stats->ip6txpkts,
> -				  last_gather_stats->ip6txpkts,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_IP6TXFRAGS] +=
> -		IRDMA_STATS_DELTA(gather_stats->ip6txfrags,
> -				  last_gather_stats->ip6txfrags,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_IP6TXMCPKTS] +=
> -		IRDMA_STATS_DELTA(gather_stats->ip6txmcpkts,
> -				  last_gather_stats->ip6txmcpkts,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_TCPRXSEGS] +=
> -		IRDMA_STATS_DELTA(gather_stats->tcprxsegs,
> -				  last_gather_stats->tcprxsegs,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_TCPTXSEG] +=
> -		IRDMA_STATS_DELTA(gather_stats->tcptxsegs,
> -				  last_gather_stats->tcptxsegs,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_RDMARXRDS] +=
> -		IRDMA_STATS_DELTA(gather_stats->rdmarxrds,
> -				  last_gather_stats->rdmarxrds,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_RDMARXSNDS] +=
> -		IRDMA_STATS_DELTA(gather_stats->rdmarxsnds,
> -				  last_gather_stats->rdmarxsnds,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_RDMARXWRS] +=
> -		IRDMA_STATS_DELTA(gather_stats->rdmarxwrs,
> -				  last_gather_stats->rdmarxwrs,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_RDMATXRDS] +=
> -		IRDMA_STATS_DELTA(gather_stats->rdmatxrds,
> -				  last_gather_stats->rdmatxrds,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_RDMATXSNDS] +=
> -		IRDMA_STATS_DELTA(gather_stats->rdmatxsnds,
> -				  last_gather_stats->rdmatxsnds,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_RDMATXWRS] +=
> -		IRDMA_STATS_DELTA(gather_stats->rdmatxwrs,
> -				  last_gather_stats->rdmatxwrs,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_RDMAVBND] +=
> -		IRDMA_STATS_DELTA(gather_stats->rdmavbn,
> -				  last_gather_stats->rdmavbn,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_RDMAVINV] +=
> -		IRDMA_STATS_DELTA(gather_stats->rdmavinv,
> -				  last_gather_stats->rdmavinv,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_UDPRXPKTS] +=
> -		IRDMA_STATS_DELTA(gather_stats->udprxpkts,
> -				  last_gather_stats->udprxpkts,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_UDPTXPKTS] +=
> -		IRDMA_STATS_DELTA(gather_stats->udptxpkts,
> -				  last_gather_stats->udptxpkts,
> -				  IRDMA_MAX_STATS_48);
> -	stats_val[IRDMA_HW_STAT_INDEX_RXNPECNMARKEDPKTS] +=
> -		IRDMA_STATS_DELTA(gather_stats->rxnpecnmrkpkts,
> -				  last_gather_stats->rxnpecnmrkpkts,
> -				  IRDMA_MAX_STATS_48);
> +
> +	irdma_update_stat(IP4RXOCTS, ip4rxocts, 48);
> +	irdma_update_stat(IP4RXPKTS, ip4rxpkts, 48);
> +	irdma_update_stat(IP4RXFRAGS, ip4rxfrags, 48);
> +	irdma_update_stat(IP4RXMCPKTS, ip4rxmcpkts, 48);
> +	irdma_update_stat(IP4TXOCTS, ip4txocts, 48);
> +	irdma_update_stat(IP4TXPKTS, ip4txpkts, 48);
> +	irdma_update_stat(IP4TXFRAGS, ip4txfrag, 48);
> +	irdma_update_stat(IP4TXMCPKTS, ip4txmcpkts, 48);
> +	irdma_update_stat(IP6RXOCTS, ip6rxocts, 48);
> +	irdma_update_stat(IP6RXPKTS, ip6rxpkts, 48);
> +	irdma_update_stat(IP6RXFRAGS, ip6rxfrags, 48);
> +	irdma_update_stat(IP6RXMCPKTS, ip6rxmcpkts, 48);
> +	irdma_update_stat(IP6TXOCTS, ip6txocts, 48);
> +	irdma_update_stat(IP6TXPKTS, ip6txpkts, 48);
> +	irdma_update_stat(IP6TXFRAGS, ip6txfrags, 48);
> +	irdma_update_stat(IP6TXMCPKTS, ip6txmcpkts, 48);
> +	irdma_update_stat(TCPRXSEGS, tcprxsegs, 48);
> +	irdma_update_stat(TCPTXSEG, tcptxsegs, 48);
> +	irdma_update_stat(RDMARXRDS, rdmarxrds, 48);
> +	irdma_update_stat(RDMARXSNDS, rdmarxsnds, 48);
> +	irdma_update_stat(RDMARXWRS, rdmarxwrs, 48);
> +	irdma_update_stat(RDMATXRDS, rdmatxrds, 48);
> +	irdma_update_stat(RDMATXSNDS, rdmatxsnds, 48);
> +	irdma_update_stat(RDMATXWRS, rdmatxwrs, 48);
> +	irdma_update_stat(RDMAVBND, rdmavbn, 48);
> +	irdma_update_stat(RDMAVINV, rdmavinv, 48);
> +	irdma_update_stat(UDPRXPKTS, udprxpkts, 48);
> +	irdma_update_stat(UDPTXPKTS, udptxpkts, 48);
> +	irdma_update_stat(RXNPECNMARKEDPKTS, rxnpecnmrkpkts, 48);
> +
>  	memcpy(last_gather_stats, gather_stats, sizeof(*last_gather_stats));  }

