Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7D139DFBD
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 16:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhFGO4k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 7 Jun 2021 10:56:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:62085 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231572AbhFGO4f (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 10:56:35 -0400
IronPort-SDR: iTMHYq08JzF+VPmegVYPofRLPBePy+KwlFlW+m4u0zFrImtaegx8ckmf4hvPOTZxMPoxAvFu44
 7DW6YVRRyiVQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="202775041"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="202775041"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 07:54:37 -0700
IronPort-SDR: gMNzRSLD6+uU62zSbbpNymDshRLYRdUq72k6ZAsvFkzl4lTnsvV+zt7zBZcBpn2KAbGUzYdAFo
 /rl5CkP+i1iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="440074325"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga007.jf.intel.com with ESMTP; 07 Jun 2021 07:54:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 7 Jun 2021 07:54:36 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 7 Jun 2021 07:54:36 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2242.008;
 Mon, 7 Jun 2021 07:54:36 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Joe Perches <joe@perches.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: irdma: utils.c typos in irdma_cqp_gather_stats_gen1 ?
Thread-Topic: irdma: utils.c typos in irdma_cqp_gather_stats_gen1 ?
Thread-Index: AQHXWnC6BhX5oDUlRUmhwRc1TlnwJqsHGdlA
Date:   Mon, 7 Jun 2021 14:54:36 +0000
Message-ID: <d41c5503b5b74996af3f3c1853a67935@intel.com>
References: <9e07e80d8aa464447323670fd810f455d53f76f3.camel@perches.com>
In-Reply-To: <9e07e80d8aa464447323670fd810f455d53f76f3.camel@perches.com>
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

> Subject: irdma: utils.c typos in irdma_cqp_gather_stats_gen1 ?
> 
> There are some odd mismatches in field and access index.
> These may be simple cut/paste typos.
> 
> Are these intentional?

No. Accidental. Likely cut/copy mistake. I will send a fix. Thanks Joe!

Shiraz

> 
> ip4txfrag is set to the value from IP4RXFRAGS
> 
> 915cc7ac0f8e2a (Mustafa Ismail 2021-06-02 15:51:34 -0500 1753)  gather_stats-
> >ip4txfrag =
> 915cc7ac0f8e2a (Mustafa Ismail 2021-06-02 15:51:34 -0500 1754)          rd64(dev-
> >hw,
> 915cc7ac0f8e2a (Mustafa Ismail 2021-06-02 15:51:34 -0500 1755)               dev-
> >hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP4RXFRAGS]
> 915cc7ac0f8e2a (Mustafa Ismail 2021-06-02 15:51:34 -0500 1756)               +
> stats_inst_offset_64);
> 
> ip4txfrag is set again a few lines later, so the case above is probably a defect.
> 
> 915cc7ac0f8e2a (Mustafa Ismail 2021-06-02 15:51:34 -0500 1769)  gather_stats-
> >ip4txfrag =
> 915cc7ac0f8e2a (Mustafa Ismail 2021-06-02 15:51:34 -0500 1770)          rd64(dev-
> >hw,
> 915cc7ac0f8e2a (Mustafa Ismail 2021-06-02 15:51:34 -0500 1771)               dev-
> >hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP4TXFRAGS]
> 915cc7ac0f8e2a (Mustafa Ismail 2021-06-02 15:51:34 -0500 1772)               +
> stats_inst_offset_64);
> 
> And here ip6txfrag is set to the value of IP6RXFRAGS
> 
> 915cc7ac0f8e2a (Mustafa Ismail 2021-06-02 15:51:34 -0500 1785)  gather_stats-
> >ip6txfrags =
> 915cc7ac0f8e2a (Mustafa Ismail 2021-06-02 15:51:34 -0500 1786)          rd64(dev-
> >hw,
> 915cc7ac0f8e2a (Mustafa Ismail 2021-06-02 15:51:34 -0500 1787)               dev-
> >hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP6RXFRAGS]
> 915cc7ac0f8e2a (Mustafa Ismail 2021-06-02 15:51:34 -0500 1788)               +
> stats_inst_offset_64);
> 

