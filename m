Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3BD18684
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2019 10:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbfEIIGD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 May 2019 04:06:03 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:28947 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfEIIGD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 May 2019 04:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1557389162; x=1588925162;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=2dSy8FtSeehZesl0lIlXdEsn2LKWNEOnhX0R8Hu72u0=;
  b=dIqh8R56n4AhttAIzq1eIyx7MyfOb8CZ/ngOUyyduoqqIhos2ZWgNqk8
   c9R1xXNxfgUm9aR5GwEfdSgf3nPBNdyJfznF6u+/io9+vRlEjhnV1quJA
   glN8TXcEqIb+qtcdWseyyErNmCec8Q8JNiqMYdeq7qSDziVhPkqd9cdXj
   s=;
X-IronPort-AV: E=Sophos;i="5.60,449,1549929600"; 
   d="scan'208";a="803699324"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 May 2019 08:05:57 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x4985shk116281
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 9 May 2019 08:05:55 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 9 May 2019 08:05:54 +0000
Received: from [10.95.94.92] (10.43.160.90) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 9 May
 2019 08:05:51 +0000
Subject: Re: [PATCH rdma-next v1 2/6] RDMA/umem: Add API to find best driver
 supported page size in an MR
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Shiraz Saleem <shiraz.saleem@intel.com>, <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>
References: <20190219145745.13476-1-shiraz.saleem@intel.com>
 <20190219145745.13476-3-shiraz.saleem@intel.com>
 <38b551a5-4177-efba-9fc0-d49dd9054615@amazon.com>
 <20190508185003.GF32282@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <e91a7280-4d2c-031b-48a4-094a6ce297a2@amazon.com>
Date:   Thu, 9 May 2019 11:05:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508185003.GF32282@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.90]
X-ClientProxiedBy: EX13D24UWA001.ant.amazon.com (10.43.160.138) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 08-May-19 21:50, Jason Gunthorpe wrote:
> On Thu, Apr 04, 2019 at 11:36:35AM +0300, Gal Pressman wrote:
>> On 19-Feb-19 16:57, Shiraz Saleem wrote:
>>> This helper iterates through the SG list to find the best page size to use
>>> from a bitmap of HW supported page sizes. Drivers that support multiple
>>> page sizes, but not mixed pages in an MR can use this API.
>>>
>>> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
>>> Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
>>> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
>>
>> I've tested this patch comparing our existing efa_cont_pages() implementation vs
>> ib_umem_find_single_pg_size() running different test suites:
> 
> This stuff has been merged, so please send a patch for EFA to use it
> now..

Sure, the patch will be a part of my next submission.
