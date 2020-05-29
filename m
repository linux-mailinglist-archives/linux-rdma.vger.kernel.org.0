Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D311E819C
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2020 17:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgE2PUf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 29 May 2020 11:20:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:39015 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbgE2PUf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 29 May 2020 11:20:35 -0400
IronPort-SDR: rzDLvUskscPDCmNRaoBpyzZvv1jBTJzSOZZzOUSnzAeuZHncCRhuo41ET/u/mtiKNNt5j3BPTO
 WDl8Zdu1N/vg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 08:20:34 -0700
IronPort-SDR: EZM+Ajo5//BklKjumLHfefBqvA/UGMuQw99nKPjcCKyVTLBz+R0eaUZ++i9pBFK06EymCFSxCe
 SaCW/mmyS1RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,449,1583222400"; 
   d="scan'208";a="469535352"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga006.fm.intel.com with ESMTP; 29 May 2020 08:20:34 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 29 May 2020 08:20:34 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.63]) by
 FMSMSX109.amr.corp.intel.com ([169.254.15.75]) with mapi id 14.03.0439.000;
 Fri, 29 May 2020 08:20:34 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        Krishnamraju Eraparaju <krishna2@chelsio.com>
CC:     "Latif, Faisal" <faisal.latif@intel.com>,
        "mkalderon@marvell.com" <mkalderon@marvell.com>,
        "aelior@marvell.com" <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "bharat@chelsio.com" <bharat@chelsio.com>,
        "nirranjan@chelsio.com" <nirranjan@chelsio.com>
Subject: RE: Re: Re: Re: [RFC PATCH] RDMA/siw: Experimental e2e negotiation
 of GSO usage.
Thread-Topic: Re: Re: Re: [RFC PATCH] RDMA/siw: Experimental e2e negotiation
 of GSO usage.
Thread-Index: AQHWEmvnKkz9zIQFBEipcoJE2SWNr6h6eCsAgAAS7oCAFPTOAIAKbsMAgAMhEYCABpJ/gIACYWQAgAB/RYCAAY/+gIAAHuKAgAGeYQCAAAIQgIARSWeAgAM2HJA=
Date:   Fri, 29 May 2020 15:20:33 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7EE045C10@fmsmsx124.amr.corp.intel.com>
References: <20200515135802.GB15967@chelsio.com>,<20200507110651.GA19184@chelsio.com>
 <20200428200043.GA930@chelsio.com> <20200415105135.GA8246@chelsio.com>
 <20200414144822.2365-1-bmt@zurich.ibm.com>
 <OFA289A103.141EDDE1-ON0025854B.003ED42A-0025854B.0041DBD8@notes.na.collabserv.com>
 <OF0315D264.505117BA-ON0025855F.0039BD43-0025855F.003E3C2B@notes.na.collabserv.com>
 <OFF3B8551C.FB7A8965-ON00258565.0043E6E2-00258565.00550882@notes.na.collabserv.com>
 <OF8C4B32A9.212C6DC0-ON00258567.0031506F-00258567.003EBFFB@notes.na.collabserv.com>
 <OF5AE22DD2.A8A5C20E-ON00258568.004804AF-00258568.00481A8E@notes.na.collabserv.com>
 <20200515135038.GA15967@chelsio.com>
 <OFD36340BE.9065DAAE-ON00258574.0049B60E-00258574.004CA5BC@notes.na.collabserv.com>
In-Reply-To: <OFD36340BE.9065DAAE-ON00258574.0049B60E-00258574.004CA5BC@notes.na.collabserv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: RE: Re: Re: Re: [RFC PATCH] RDMA/siw: Experimental e2e negotiation
> of GSO usage.
> 
> 
> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----
> 
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
> >Date: 05/15/2020 03:58PM
> >Cc: faisal.latif@intel.com, shiraz.saleem@intel.com,
> >mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
> >jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
> >nirranjan@chelsio.com
> >Subject: [EXTERNAL] Re: Re: Re: Re: [RFC PATCH] RDMA/siw:
> >Experimental e2e negotiation of GSO usage.
> >
> >Here is the rough prototype of iwpmd approach(only kernel part).
> >Please take a look.
> 
> 
> This indeed looks like a possible solution, which would not affect the wire
> protocol.
> 
> Before we move ahead with that story in any direction, I would really really
> appreciate to hear what other iWarp vendors have to say.
> 
> 0) would other vendors care about better performance
>    in a mixed hardware/software iwarp setting?
> 
> 1) what are the capabilities of other adapters in that
>    respect, e.g. what is the maximum FPDU length it
>    can process?
> 
> 2) would other adapters be able to send larger FPDUs
>    than MTU size?
> 
> 3) what would be the preferred solution - using spare
>    MPA protocol bits to signal capabilities or
>    extending the proprietary iwarp port mapper with that
>    functionality?
> 
> Thanks very much!
> Bernard.
> 

Hi Bernard -  If we receive larger FPDU than MTU its handled in software
and therefore is a hit on perf. We do support jumbo packets but we do not
transmit FPDUs greater than MTU size. I recommend we do not add
unspec'd bits into the MPA protocol for gso negotiation. netlink based
approach or iwpmd sounds more reasonable.

Hope this helps.

Shiraz

