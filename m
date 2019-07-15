Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B486F69A3E
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2019 19:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbfGORzE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 15 Jul 2019 13:55:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:54303 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729941AbfGORzE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 15 Jul 2019 13:55:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2019 10:55:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,493,1557212400"; 
   d="scan'208";a="157883318"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga007.jf.intel.com with ESMTP; 15 Jul 2019 10:55:03 -0700
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 15 Jul 2019 10:55:02 -0700
Received: from fmsmsx120.amr.corp.intel.com ([169.254.15.50]) by
 FMSMSX155.amr.corp.intel.com ([169.254.5.80]) with mapi id 14.03.0439.000;
 Mon, 15 Jul 2019 10:55:02 -0700
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 0/6] More 5.3 patches
Thread-Topic: [PATCH 0/6] More 5.3 patches
Thread-Index: AQHVOyzL+PXaI1F4XkKHg1EwLEsgCabMa5mA//+KxsA=
Date:   Mon, 15 Jul 2019 17:55:02 +0000
Message-ID: <32E1700B9017364D9B60AED9960492BC70E15005@fmsmsx120.amr.corp.intel.com>
References: <20190715164423.74174.4994.stgit@awfm-01.aw.intel.com>
 <20190715175409.GA4970@ziepe.ca>
In-Reply-To: <20190715175409.GA4970@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWE4MDU4MDItYzhmOS00YTY3LTg2YmQtYmU3Y2I3NTIwODQzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiS0tzWWpYYlFReUJyWXFoRHFnd081bUYzVThIdzByaFptblAwZk9McnpQWnhDWFwvUVhlcWdDNXFSbnVla2ZrY1UifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: Re: [PATCH 0/6] More 5.3 patches
> 
> On Mon, Jul 15, 2019 at 12:45:14PM -0400, Mike Marciniszyn wrote:
> > The following series contains fixes and a cleanup.
> >
> > I noticed that 5.3 rc1 hasn't happened yet? So I'm not quite sure of
> > the destination here.
> 
> You shouldn't send patches during the merge window. If they don't
> apply cleanly to rc1 they will need resend.
> 

They apply cleanly to for-next and rdma/for-next.

Mike
