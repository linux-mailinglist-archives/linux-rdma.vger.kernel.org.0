Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD612E30C
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2019 19:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfE2RUI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 29 May 2019 13:20:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:58052 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfE2RUI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 May 2019 13:20:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 10:20:07 -0700
X-ExtLoop1: 1
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2019 10:20:05 -0700
Received: from fmsmsx123.amr.corp.intel.com (10.18.125.38) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 29 May 2019 10:20:04 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.29]) by
 fmsmsx123.amr.corp.intel.com ([169.254.7.159]) with mapi id 14.03.0415.000;
 Wed, 29 May 2019 10:20:04 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Firas JahJah <firasj@amazon.com>
Subject: RE: [PATCH for-rc 4/6] RDMA/efa: Use API to get contiguous memory
 blocks aligned to device supported page size
Thread-Topic: [PATCH for-rc 4/6] RDMA/efa: Use API to get contiguous memory
 blocks aligned to device supported page size
Thread-Index: AQHVFVN3lHBhqcKgs0S/UVTrJ3hegqaCv1EA//+W7GA=
Date:   Wed, 29 May 2019 17:20:03 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7A5B07AB2@fmsmsx124.amr.corp.intel.com>
References: <20190528124618.77918-1-galpress@amazon.com>
 <20190528124618.77918-5-galpress@amazon.com>
 <20190529161938.GA14765@ziepe.ca>
In-Reply-To: <20190529161938.GA14765@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzlmOTIyMWItYzY3MS00NzhkLThiZTEtNDM4YWE0ZDc5ZmZhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZU5aeEJaYlV6U0c1T2JZRDZGYTk3OHFKUzRZNjNya1wvNjVxdXRIWHMwc3BVNmF1YmVqNDZzVVhldWFWQWJ6MncifQ==
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

> Subject: Re: [PATCH for-rc 4/6] RDMA/efa: Use API to get contiguous memory
> blocks aligned to device supported page size
> 
> On Tue, May 28, 2019 at 03:46:16PM +0300, Gal Pressman wrote:
> > @@ -1500,13 +1443,17 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64
> start, u64 length,
> >  	params.iova = virt_addr;
> >  	params.mr_length_in_bytes = length;
> >  	params.permissions = access_flags & 0x1;
> > -	max_page_shift = fls64(dev->dev_attr.page_size_cap);
> >
> > -	efa_cont_pages(mr->umem, start, max_page_shift, &npages,
> > -		       &params.page_shift, &params.page_num);
> > +	pg_sz = ib_umem_find_best_pgsz(mr->umem,
> > +				       dev->dev_attr.page_size_cap,
> > +				       virt_addr);
> 
> I think this needs to check pg_sz is not zero..
> 

What is the smallest page size this driver supports?

