Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4FB3B7BE
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 16:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390122AbfFJOvG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 10 Jun 2019 10:51:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:19112 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389123AbfFJOvG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 10:51:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 07:51:05 -0700
X-ExtLoop1: 1
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga003.jf.intel.com with ESMTP; 10 Jun 2019 07:51:05 -0700
Received: from fmsmsx117.amr.corp.intel.com (10.18.116.17) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 10 Jun 2019 07:51:05 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.88]) by
 fmsmsx117.amr.corp.intel.com ([169.254.3.141]) with mapi id 14.03.0415.000;
 Mon, 10 Jun 2019 07:51:04 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     'Jason Gunthorpe' <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>
CC:     "Latif, Faisal" <faisal.latif@intel.com>,
        "larrystevenwise@gmail.com" <larrystevenwise@gmail.com>
Subject: RE: Remove nes
Thread-Topic: Remove nes
Thread-Index: AQHVHU2BsVG3v9Y7wk6K9Z3x3tF/aKaQZBcQ
Date:   Mon, 10 Jun 2019 14:51:04 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7A5B25C03@fmsmsx124.amr.corp.intel.com>
References: <20190607162430.GL14802@ziepe.ca>
In-Reply-To: <20190607162430.GL14802@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZWE5NWQzNDEtODQ3My00MjZjLTk3NWEtOGIxMjY3NGUxMGJlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQjdFelhoUHcxNEI1TUFZU1lVSEJDZkhTUlhMWG01b2dwY3lRSnBhdGowdVZCaTR5azRBZHpTQlRPdmRyVytyQiJ9
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

> Subject: RFC: Remove nes
> 
> Since we have gained another two (EFA, SIW) drivers lately, I'd really like to
> remove NES as we have in the past for other drivers.
> 
> This hardware was proposed to be removed at the last purge, but I think that Steve
> still wanted to keep it for some reason. I suppose that has changed now.
> 
> If I recall the reasons for removal were basically:
>  - Does not support modern FRWR, which is now becoming mandatory for ULPs
>  - Does not support 64 bit physical addresses, so is useless on modern
>    servers
>  - Possibly nobody has even loaded the module in years. Wouldn't be
>    surprised to learn it is broken with all the recent churn.

Intel agrees with removing nes support.

