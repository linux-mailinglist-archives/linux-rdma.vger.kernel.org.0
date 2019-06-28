Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9FD35A30C
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2019 20:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfF1SBa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 28 Jun 2019 14:01:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:36474 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbfF1SBa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jun 2019 14:01:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 11:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,428,1557212400"; 
   d="scan'208";a="314201127"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga004.jf.intel.com with ESMTP; 28 Jun 2019 11:01:28 -0700
Received: from fmsmsx162.amr.corp.intel.com (10.18.125.71) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 28 Jun 2019 11:01:28 -0700
Received: from fmsmsx123.amr.corp.intel.com ([169.254.7.123]) by
 fmsmsx162.amr.corp.intel.com ([169.254.5.43]) with mapi id 14.03.0439.000;
 Fri, 28 Jun 2019 11:01:28 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     oulijun <oulijun@huawei.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [BUGReport for rdma in kernel5.2-rc4]
Thread-Topic: [BUGReport for rdma in kernel5.2-rc4]
Thread-Index: AQHVLcuxTkykfRtkqk2UuoXnRYz1BaaxWaVA
Date:   Fri, 28 Jun 2019 18:01:28 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7A6838463@fmsmsx123.amr.corp.intel.com>
References: <eaa1f156-c9df-f2f6-3c23-f2c1b23e484c@huawei.com>
In-Reply-To: <eaa1f156-c9df-f2f6-3c23-f2c1b23e484c@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzk0MDUzZTAtMTY0Yi00NWU5LWFkNDgtOGQ5OTgxYWExYmZhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZllHcEttQmVsbWt3VHdqaHRhM2tiVXpcL3dIR25RNTNJbDMyNEx6MUt2NDB0cmpQMUZpUWFQMjlLZVFIUVwvR3FIIn0=
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

> Subject: [BUGReport for rdma in kernel5.2-rc4]
> 
> 
> Hi Shiraz & Jason,
> 
> We have observed a crash when run perftest on a hisilicon arm64 platform in
> kernel-5.2-rc4.
> 
> We also tested with different kernel version and found it started from the the
> following commit:
>    d10bcf947a3e ("RDMA/umem: Combine contiguous PAGE_SIZE regions in
> SGEs")
> 
> Could you please share any hint how to resolve this kind issue?
> Thanks!
> 

Hi Lijun - I am presuming you had this fix too?

"RDMA/umem: Handle page combining avoidance correctly in ib_umem_add_sg_table()"
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/drivers/infiniband/core/umem.c?h=v5.2-rc4&id=7872168a839144dbbfb33125262dab0673f9ddf5

As Jason mentioned, provide the stack backtrace.

Shiraz
