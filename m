Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53A923FD5A
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Aug 2020 10:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgHIIgF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Aug 2020 04:36:05 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:42954 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgHIIgF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Aug 2020 04:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1596962165; x=1628498165;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=G6sNgHTlfA39QjdSkKJD9tDLhIyODeSKXQPkPpdaSbM=;
  b=tt6tce1UlUrCjPvBtr1vNOd2KUAlsur2zG+R+MOOo9qPASiNrxqRzubC
   6fFgrW4oB/ZwPRpQ3qnda54pd1nHR/pLd7uY4p9t5h5iWuyxSuHw5EJYb
   9Gu+pKJ5UndTrav1FY7M5qdBwfPyTJ9wSCoE6nyRpErt/637/xEVbxCWL
   Y=;
IronPort-SDR: qEEIWK+V6ELPO6t2XtOAyIEnDrIehEVP+f4d2bt2EDMPZkAfnd+p6Jo9HC9GjmJYSOulrwYepf
 EHNnDNgu1r/A==
X-IronPort-AV: E=Sophos;i="5.75,453,1589241600"; 
   d="scan'208";a="65346983"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 09 Aug 2020 08:36:03 +0000
Received: from EX13MTAUEB002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id C9A43A176B;
        Sun,  9 Aug 2020 08:36:01 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEB002.ant.amazon.com (10.43.60.12) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 9 Aug 2020 08:36:01 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.145) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 9 Aug 2020 08:35:57 +0000
Subject: Re: [PATCH 0/4] Infiniband Subsystem: Remove pci-dma-compat wrapper
 APIs.
To:     Suraj Upadhyay <usuraj35@gmail.com>, <dledford@redhat.com>,
        <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <cover.1596957073.git.usuraj35@gmail.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <9220090e-7340-df50-a998-57a5e7752f90@amazon.com>
Date:   Sun, 9 Aug 2020 11:35:51 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1596957073.git.usuraj35@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.145]
X-ClientProxiedBy: EX13D21UWA004.ant.amazon.com (10.43.160.252) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 09/08/2020 10:24, Suraj Upadhyay wrote:
> Hii Developers,
> 
> 	This patch series will replace all the legacy pci-dma-compat wrappers
> with the dma-mapping APIs directly in the INFINIBAND Subsystem.
> 
> This task is done through a coccinelle script which is described in each commit
> message.
> 
> The changes are compile tested.
> 
> Thanks,
> 
> Suraj Upadhyay.
> 
> Suraj Upadhyay (4):
>   IB/hfi1: Remove pci-dma-compat wrapper APIs
>   IB/mthca: Remove pci-dma-compat wrapper APIs
>   RDMA/qib: Remove pci-dma-compat wrapper APIs
>   RDMA/pvrdma: Remove pci-dma-compat wrapper APIs
> 
>  drivers/infiniband/hw/hfi1/pcie.c             |  8 +++----
>  drivers/infiniband/hw/hfi1/user_exp_rcv.c     | 13 +++++------
>  drivers/infiniband/hw/mthca/mthca_eq.c        | 21 +++++++++--------
>  drivers/infiniband/hw/mthca/mthca_main.c      |  8 +++----
>  drivers/infiniband/hw/mthca/mthca_memfree.c   | 23 +++++++++++--------
>  drivers/infiniband/hw/qib/qib_file_ops.c      | 12 +++++-----
>  drivers/infiniband/hw/qib/qib_init.c          |  4 ++--
>  drivers/infiniband/hw/qib/qib_pcie.c          |  8 +++----
>  drivers/infiniband/hw/qib/qib_user_pages.c    | 12 +++++-----
>  .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  6 ++---
>  10 files changed, 59 insertions(+), 56 deletions(-)
> 

The efa patch isn't listed here, and it shows as patch 5/4?
