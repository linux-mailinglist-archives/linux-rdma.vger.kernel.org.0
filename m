Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8649E2A4
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 10:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfH0I2g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 04:28:36 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:13337 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfH0I2f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Aug 2019 04:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566894515; x=1598430515;
  h=subject:to:references:cc:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=G7H+QouqGSpwgOsiTCuPsPrWleoif0FFIIbMT7Oz3pg=;
  b=czNucGoXg+r28gnBiZnWlor0fXVXdRcBQjwJFZv+pbDoKaXTX+jt+2YI
   Cu3sH8Dh0tPZxg/iL5cuGowxB9OAJmELfNJO5oW3xZBCcnskppE2/aV4I
   EtSazaJRuNhP23uLb0OW6qWhYHAhwh/UuvkrWhlTBNATjs0EtNDu8Ga/2
   0=;
X-IronPort-AV: E=Sophos;i="5.64,436,1559520000"; 
   d="scan'208";a="417882302"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 27 Aug 2019 08:28:30 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id A21091A0E3A;
        Tue, 27 Aug 2019 08:28:29 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 27 Aug 2019 08:28:29 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.100) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 27 Aug 2019 08:28:25 +0000
Subject: Re: ib_umem_get and DMA_API_DEBUG question
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <526c5b18-5853-c8dc-e112-31287a46e707@amazon.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <9bae7550-35cf-b183-1e1c-fd1f8e01ef79@amazon.com>
Date:   Tue, 27 Aug 2019 11:28:20 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <526c5b18-5853-c8dc-e112-31287a46e707@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D23UWA002.ant.amazon.com (10.43.160.40) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 26/08/2019 17:05, Gal Pressman wrote:
> Hi all,
> 
> Lately I've been seeing DMA-API call traces on our automated testing runs which
> complain about overlapping mappings of the same cacheline [1].
> The problem is (most likely) caused due to multiple calls to ibv_reg_mr with the
> same address, which as a result DMA maps the same physical addresses more than 7
> (ACTIVE_CACHELINE_MAX_OVERLAP) times.

BTW, on rare occasions I'm seeing the boundary check in check_sg_segment [1]
fail as well. I don't have a stable repro for it though.

Is this a known issue as well? The comment there states it might be a bug in the
DMA API implementation, but I'm not sure.

[1] https://elixir.bootlin.com/linux/v5.3-rc3/source/kernel/dma/debug.c#L1230
