Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D55C571348
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 09:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388395AbfGWHwM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 03:52:12 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:43316 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfGWHwM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jul 2019 03:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1563868331; x=1595404331;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=bypiiU9/XsnsmRS1uu7TyzY+JVg4w0MEcVIdLiqnvwI=;
  b=BBK0+SE/eYcFT+Ndydbq1XPCESHodVhjYLkF+eCHCIgCIrQVGj0OhQ3C
   TvwL9KR6iIxddRLDxUf2LKeoErgJ+v4D1H7cScmB8BtQirjx9CnCzCjvQ
   hIFOIf7LDwOLlERgdW3rCQE3qcZX6SCY9B9qTxExAyTHs9ENm04rSUmVK
   g=;
X-IronPort-AV: E=Sophos;i="5.64,298,1559520000"; 
   d="scan'208";a="687135342"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 23 Jul 2019 07:52:06 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with ESMTPS id 7D49DA1BC5;
        Tue, 23 Jul 2019 07:52:06 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 23 Jul 2019 07:52:05 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.85) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 23 Jul 2019 07:52:02 +0000
Subject: Re: BUG: KASAN: null-ptr-deref in
 rdma_counter_get_hwstat_value+0x19d/0x260 in for-next branch
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Mark Zhang <markz@mellanox.com>,
        "Doug Ledford" <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
References: <137e1a30-1c78-27f7-2466-070867b97256@amazon.com>
 <20190722175236.GF5125@mtr-leonro.mtl.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <5d082181-9f6e-154c-2b8f-52b9c158fedc@amazon.com>
Date:   Tue, 23 Jul 2019 10:51:57 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722175236.GF5125@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.85]
X-ClientProxiedBy: EX13D15UWA003.ant.amazon.com (10.43.160.182) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 22/07/2019 20:52, Leon Romanovsky wrote:
> On Mon, Jul 22, 2019 at 06:10:01PM +0300, Gal Pressman wrote:
>> Hi,
>>
>> I pulled the latest for-next branch (5.3-rc1) which includes the new stats stuff
>> and applied a patch to enable EFA stats [1], and I'm getting the following trace
>> [2]. The EFA patch isn't merged yet so it could cause some extra noise, but this
>> did not happen before the core statistics patches were merged.
>>
>> From a quick look it seems that 'port_counter->hstats' is only initialized for
>> ports 1..num_ports (i.e not initialized for port 0, device stats) in
>> rdma_counter_init rdma_for_each_port loop.
>>
>> As a result, rdma_counter_get_hwstat_value hits a NULL pointer dereference when
>> querying device statistics as it tries to access an uninitialized hstats field in:
>> sum += port_counter->hstats->value[index];
>>
>> I'm thinking of adding a check similar to the one that exists in
>> counter_history_stat_update and return 0 in case of !port_counter->hstats.
>> What do you guys think?
> 
> It is in my queue, I waited for -rc1 to start sending.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/commit/?h=rdma-next&id=32f6bc477e9432776d6938beeda1905198485f5e

Thanks, good to know that it's the same fix.
