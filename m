Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 335E45B8E2
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2019 12:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbfGAKUl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 1 Jul 2019 06:20:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:1035 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfGAKUl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 1 Jul 2019 06:20:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2019 03:20:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,439,1557212400"; 
   d="scan'208";a="165299418"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga007.fm.intel.com with ESMTP; 01 Jul 2019 03:20:38 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 1 Jul 2019 03:20:40 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 1 Jul 2019 03:20:40 -0700
Received: from crsmsx152.amr.corp.intel.com (172.18.7.35) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 1 Jul 2019 03:20:39 -0700
Received: from crsmsx102.amr.corp.intel.com ([169.254.2.240]) by
 CRSMSX152.amr.corp.intel.com ([169.254.5.100]) with mapi id 14.03.0439.000;
 Mon, 1 Jul 2019 04:20:38 -0600
From:   "Pine, Kevin" <kevin.pine@intel.com>
To:     Leon Romanovsky <leon@kernel.org>,
        "Estela, Henry R" <henry.r.estela@intel.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: RE: [ANNOUNCE] qperf maintainer change
Thread-Topic: [ANNOUNCE] qperf maintainer change
Thread-Index: AdUoWkIZ6zEeJV79T+2RknB0h0VVqwHPVikAABe1BZA=
Date:   Mon, 1 Jul 2019 10:20:38 +0000
Message-ID: <E40FE939485AD2408750F67A0FFD42C93BCE773A@CRSMSX102.amr.corp.intel.com>
References: <152F98E1C68AAF499EABB07558C80F3B421A3FEA@ORSMSX106.amr.corp.intel.com>
 <20190630170026.GI4727@mtr-leonro.mtl.com>
In-Reply-To: <20190630170026.GI4727@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTBhZGYwYjctODVhMi00YTc4LThhZjgtMmU1ZjE1YjE1MTFhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoienRXeDYyXC9TdXVwVWZNQkVaTmZCSnY3dFd0ZnhzXC9vb2xDeDVuaE1FeWg5V1ZIbGRXYXcrOTlYZnNkMWRud1pFIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I apologize.  I had given it to Henry in a separate email but didn't reply to your other email.

My github username should be "kevpine" and my email is kevin.pine@intel.com.

Thanks,

Kevin

-----Original Message-----
From: Leon Romanovsky [mailto:leon@kernel.org] 
Sent: Sunday, June 30, 2019 1:00 PM
To: Estela, Henry R <henry.r.estela@intel.com>
Cc: linux-rdma@vger.kernel.org; Pine, Kevin <kevin.pine@intel.com>; Weiny, Ira <ira.weiny@intel.com>
Subject: Re: [ANNOUNCE] qperf maintainer change

On Fri, Jun 21, 2019 at 06:00:29PM +0000, Estela, Henry R wrote:
> Hello,
> I am passing on the role of qperf maintainer to Kevin Pine, since I am no longer working on RDMA related software.
>
> Leon, could you add him to the github repo?

I see that no response was for my private email, so I'll request it again.

Please provide github username, so I'll be able to transfer access rights.

Thanks

>
> Thanks,
> Henry
>
