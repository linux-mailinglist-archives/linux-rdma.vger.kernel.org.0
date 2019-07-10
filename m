Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 671E664AFC
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 18:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfGJQyg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 10 Jul 2019 12:54:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:39151 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbfGJQyg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 10 Jul 2019 12:54:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 09:54:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,475,1557212400"; 
   d="scan'208";a="176895849"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2019 09:54:35 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 10 Jul 2019 09:54:35 -0700
Received: from fmsmsx120.amr.corp.intel.com ([169.254.15.50]) by
 FMSMSX153.amr.corp.intel.com ([169.254.9.7]) with mapi id 14.03.0439.000;
 Wed, 10 Jul 2019 09:54:35 -0700
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     "Arumugam, Kamenee" <kamenee.arumugam@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        "Gal Pressman" <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: RE: [PATCH] [net-next] IB/hfi1: removed shadowed 'err' variable
Thread-Topic: [PATCH] [net-next] IB/hfi1: removed shadowed 'err' variable
Thread-Index: AQHVNyCJ5TfGclcubk6fluS/xx2pgqbEEUTA
Date:   Wed, 10 Jul 2019 16:54:33 +0000
Message-ID: <32E1700B9017364D9B60AED9960492BC70E0B90C@fmsmsx120.amr.corp.intel.com>
References: <20190710130802.1878874-1-arnd@arndb.de>
In-Reply-To: <20190710130802.1878874-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDAzNjliNTUtZGQxNy00NGZjLWE3N2UtZDUxODExNTRkNzcyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieUVOUWNVNGEzaFI0cnFYUTFveUVOSDNMckVmSDdEUGF4ckpDOTF5cURcL29RNnVoRjhRY1k3TXN5cHA4NFRTZUYifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH] [net-next] IB/hfi1: removed shadowed 'err' variable
> 
> I can't think of any reason for the inner variable declaration, so
> remove it to avoid the issue.
> 

I agree!

> Fixes: 239b0e52d8aa ("IB/hfi1: Move rvt_cq_wc struct into uapi directory")

Thanks for catching this!

Acked-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
