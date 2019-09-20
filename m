Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 536BFB90AC
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2019 15:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfITNbO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Sep 2019 09:31:14 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:40490 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfITNbO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Sep 2019 09:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568986273; x=1600522273;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=jy9RK6eWgxRFQtEUkzZwXcRSEKw3bG1rCIPVd0y7GiU=;
  b=LzHX3LOxsb+jGfip0mEjC4hyfsO8ijQ7sJ2jOGll440GA0LTcYJDBFkp
   O/Gp6wS2TIkzw4dE8x1r30cjIwGQiPEpDd74Vhrtjwj0/8EmGdj3V15XG
   WS3+X5xthQphGlsc2kl37B+G48nW3I572VWcP3ZaD/LmWlgtkPX9wo3Jd
   0=;
X-IronPort-AV: E=Sophos;i="5.64,528,1559520000"; 
   d="scan'208";a="751858059"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 20 Sep 2019 13:31:07 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id D2AC9A2A01;
        Fri, 20 Sep 2019 13:31:04 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 20 Sep 2019 13:31:04 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.16) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 20 Sep 2019 13:30:58 +0000
Subject: Re: [PATCH v11 rdma-next 6/7] RDMA/qedr: Add doorbell overflow
 recovery support
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <michal.kalderon@marvell.com>
CC:     <mkalderon@marvell.com>, <aelior@marvell.com>,
        <dledford@redhat.com>, <bmt@zurich.ibm.com>, <sleybo@amazon.com>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-7-michal.kalderon@marvell.com>
 <20190919180224.GE4132@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <a0e19fb2-cd5c-4394-16d6-75ac856340b4@amazon.com>
Date:   Fri, 20 Sep 2019 16:30:52 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190919180224.GE4132@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.16]
X-ClientProxiedBy: EX13D07UWA002.ant.amazon.com (10.43.160.77) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 19/09/2019 21:02, Jason Gunthorpe wrote:
> On Thu, Sep 05, 2019 at 01:01:16PM +0300, Michal Kalderon wrote:
> 
>> @@ -347,6 +360,9 @@ void qedr_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
>>  {
>>  	struct qedr_user_mmap_entry *entry = get_qedr_mmap_entry(rdma_entry);
>>  
>> +	if (entry->mmap_flag == QEDR_USER_MMAP_PHYS_PAGE)
>> +		free_page((unsigned long)phys_to_virt(entry->address));
>> +
> 
> While it isn't wrong it do it this way, we don't need this mmap_free()
> stuff for normal CPU pages. Those are refcounted and qedr can simply
> call free_page() during the teardown of the uobject that is using the
> this page. This is what other drivers already do.

This is pretty much what EFA does as well.
When we allocate pages for the user (CQ for example), we DMA map them and later
on mmap them to the user. We expect those pages to remain until the entry is
freed, how can we call free_page, who is holding a refcount on those except for
the driver?
