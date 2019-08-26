Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A97759D1D0
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 16:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbfHZOjb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 10:39:31 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:20597 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729753AbfHZOjb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Aug 2019 10:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566830370; x=1598366370;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Vbn1kZPOKFt5j/QtS7xdD6lJRyn0mgeYEO0bNq8dq+c=;
  b=b2knjo1IeyCW1RvdJhS1heqcEmL3aWXvyHrtNJ8JhBup+xJoWvnVfj3k
   YaflhOi4pOigXEkPvdZrkjIriAt/AUrC/HlnZ61NXXTJeeGPOywzOiy6r
   Jz07EU/ZD4ai/xjA3Hd+A75/796c+HSf+GmS60Jr4Ed1b0f+6evca5yJD
   g=;
X-IronPort-AV: E=Sophos;i="5.64,433,1559520000"; 
   d="scan'208";a="781515266"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 26 Aug 2019 14:39:28 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS id 1D319A215B;
        Mon, 26 Aug 2019 14:39:28 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 26 Aug 2019 14:39:27 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.222) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 26 Aug 2019 14:39:24 +0000
Subject: Re: ib_umem_get and DMA_API_DEBUG question
To:     Leon Romanovsky <leon@kernel.org>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>
References: <526c5b18-5853-c8dc-e112-31287a46e707@amazon.com>
 <20190826142320.GD4584@mtr-leonro.mtl.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <dd49fea6-9d2f-3727-2409-afd4ce3e4bba@amazon.com>
Date:   Mon, 26 Aug 2019 17:39:19 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826142320.GD4584@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.222]
X-ClientProxiedBy: EX13D01UWB004.ant.amazon.com (10.43.161.157) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 26/08/2019 17:23, Leon Romanovsky wrote:
> On Mon, Aug 26, 2019 at 05:05:12PM +0300, Gal Pressman wrote:
>> Hi all,
>>
>> Lately I've been seeing DMA-API call traces on our automated testing runs which
>> complain about overlapping mappings of the same cacheline [1].
>> The problem is (most likely) caused due to multiple calls to ibv_reg_mr with the
>> same address, which as a result DMA maps the same physical addresses more than 7
>> (ACTIVE_CACHELINE_MAX_OVERLAP) times.
>>
>> Is this considered a bad behavior by the test? Should this be caught by
>> ib_core/driver somehow?
> 
> If I'm not mistaken here, but we (Mellanox) decided that it is a bug in
> DMA debug code.

Thanks a lot Leon, good to know that it's not just an EFA thing.

In case you remember, is it a bug in the sense that the trace is a false alarm
or is it a bug that could cause real issues?
Did you guys by any chance analyze what are the consequences of this?
