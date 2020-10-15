Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BBB28F0DB
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Oct 2020 13:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgJOLXa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Oct 2020 07:23:30 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:56668 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgJOLXa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Oct 2020 07:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1602761009; x=1634297009;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=aarV7amAPviKx71nKuyfKWuaD7vLMoyaww1CdaPbi80=;
  b=ShAX9V7SKJOHYDK7qMPLI3Y/i9ilD4t/efRJp11gJTVdnVFyWp6IrwR4
   0uCxtY6u1BEEkMeqYRv23MfvI4JOiW/3dEf2wxxlybJRixKWMqTPmQMks
   fvrmdFq0crC4QYmUoGsWEyQOY61nXR+Wsmgk+5+itqT2nRjFKq+pFwDWJ
   0=;
X-IronPort-AV: E=Sophos;i="5.77,378,1596499200"; 
   d="scan'208";a="76697856"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 15 Oct 2020 11:23:22 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS id 3B0C2A1FB1;
        Thu, 15 Oct 2020 11:23:20 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.24) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 15 Oct 2020 11:23:17 +0000
Subject: Re: dynamic-sg patch has broken rdma_rxe
To:     Maor Gottlieb <maorg@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
CC:     <linux-rdma@vger.kernel.org>
References: <0fdfc60e-ea93-8cf2-b23a-ce5d07d5fe33@gmail.com>
 <20201014225125.GC5316@nvidia.com>
 <e2763434-2f4f-9971-ae9d-62bab62b2e93@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <63997d02-827c-5a0d-c6a1-427cbeb4ef27@amazon.com>
Date:   Thu, 15 Oct 2020 14:23:11 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <e2763434-2f4f-9971-ae9d-62bab62b2e93@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.161.24]
X-ClientProxiedBy: EX13D41UWB004.ant.amazon.com (10.43.161.135) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 15/10/2020 10:44, Maor Gottlieb wrote:
> 
> On 10/15/2020 1:51 AM, Jason Gunthorpe wrote:
>> On Tue, Oct 13, 2020 at 09:33:14AM -0500, Bob Pearson wrote:
>>> Jason,
>>>
>>> Just pulled for-next and now hit the following warning.
>>> Register user space memory is not longer working.
>>> I am trying to debug this but if you have any idea where to look let me know.
>> The offset_in_page is wrong, but it is protecting some other logic..
>>
>> Maor? Leon? Can you sort it out tomorrow?
> 
> Leon and I investigated it. This check existed before my series to protect the
> alloc_table_from_pages logic. It's still relevant.
> This patch that broke it:  54816d3e69d1 ("RDMA: Explicitly pass in the
> dma_device to ib_register_device"), and according to below link it was
> expected.  The safest approach is to set the max_segment_size back the 2GB in
> all drivers. What do you think?
> 
> https://lore.kernel.org/linux-rdma/20200923072111.GA31828@infradead.org/

FWIW, EFA is broken as well (same call trace) so it's not just software drivers.
