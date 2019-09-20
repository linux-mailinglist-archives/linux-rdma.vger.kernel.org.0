Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64FDEB90CC
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2019 15:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfITNkC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Sep 2019 09:40:02 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:30172 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfITNkC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Sep 2019 09:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568986801; x=1600522801;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=1v3R+9+ruxzn0qZecp9Uv9GZk+babxpJBnzXg063FJE=;
  b=CYm0fE3biiMhNx902X5C8Rmc6cu72hOOQsWMyDCA3GAjRHf8b/1DEu3/
   zPLs6UtJPumBE3iVpgGF1Ab+0Awa60FYN4gRQ3h1JrZF2CgtYnGDxHoEf
   JUlfV4UJbl/ue1ofMzI+/7eUAcasxR6GdfnBrMe5lzbffTlQlD3FOVCq/
   0=;
X-IronPort-AV: E=Sophos;i="5.64,528,1559520000"; 
   d="scan'208";a="834975016"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 20 Sep 2019 13:39:26 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (Postfix) with ESMTPS id 2ECD6A0763;
        Fri, 20 Sep 2019 13:39:21 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 20 Sep 2019 13:39:20 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.116) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 20 Sep 2019 13:39:15 +0000
Subject: Re: [PATCH v11 rdma-next 5/7] RDMA/qedr: Use the common mmap API
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <michal.kalderon@marvell.com>
CC:     <mkalderon@marvell.com>, <aelior@marvell.com>,
        <dledford@redhat.com>, <bmt@zurich.ibm.com>, <sleybo@amazon.com>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-6-michal.kalderon@marvell.com>
 <20190919175546.GD4132@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <af160e72-bcc3-c511-8757-a21b33bd9e5c@amazon.com>
Date:   Fri, 20 Sep 2019 16:39:10 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190919175546.GD4132@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.116]
X-ClientProxiedBy: EX13D32UWA003.ant.amazon.com (10.43.160.167) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 19/09/2019 20:55, Jason Gunthorpe wrote:
> Huh. If you recall we did all this work with the XA and the free
> callback because you said qedr was mmaping BAR pages that had some HW
> lifetime associated with them, and the HW resource was not to be
> reallocated until all users were gone.
> 
> I think it would be a better example of this API if you pulled the
> 
>  	dev->ops->rdma_remove_user(dev->rdma_ctx, ctx->dpi);
> 
> Into qedr_mmap_free().
> 
> Then the rdma_user_mmap_entry_remove() will call it naturally as it
> does entry_put() and if we are destroying the ucontext we already know
> the mmaps are destroyed.
> 
> Maybe the same basic comment for EFA, not sure. Gal?

That's what EFA already does in this series, no?
We no longer remove entries on dealloc_ucontext, only when the entry is freed.
