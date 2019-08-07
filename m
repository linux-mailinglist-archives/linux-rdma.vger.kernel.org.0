Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4467884B08
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 13:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbfHGLtR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 07:49:17 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:31956 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfHGLtR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Aug 2019 07:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1565178556; x=1596714556;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=eLIOYNW3hq52dycV+MbVoAQsrwfbvz8vKtxrq3ps+dc=;
  b=WH+WrygaCbdbZwGKYeI25Yj1n3IMQ/yiu8ixodVsEPzWUkpsXy68SEwh
   21ZvFLtpsvbipF1EbUSC3amcj92UyQ3Mojv984dKI97KP7ytmIY9n04yj
   oj4gPdwhDc04salbj0qaiQ3BclysuENQgxey4BP/9ZMLJGOhVcNh7oMV1
   M=;
X-IronPort-AV: E=Sophos;i="5.64,357,1559520000"; 
   d="scan'208";a="778148186"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 07 Aug 2019 11:49:14 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id 011B1A212B;
        Wed,  7 Aug 2019 11:49:13 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 7 Aug 2019 11:49:13 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.88) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 7 Aug 2019 11:49:09 +0000
Subject: Re: [PATCH rdma-next 2/6] RDMA/umem: Add ODP type indicator within
 ib_umem_odp
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
References: <20190807103403.8102-1-leon@kernel.org>
 <20190807103403.8102-3-leon@kernel.org>
 <20441b80-b901-9e42-90e0-f1cf17ac6d5b@amazon.com>
 <20190807114451.GD1571@mellanox.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <7c942fe3-cfba-e50a-c8e1-73d3a8ca80a5@amazon.com>
Date:   Wed, 7 Aug 2019 14:49:05 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807114451.GD1571@mellanox.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.88]
X-ClientProxiedBy: EX13D01UWA004.ant.amazon.com (10.43.160.99) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 07/08/2019 14:44, Jason Gunthorpe wrote:
> On Wed, Aug 07, 2019 at 02:23:03PM +0300, Gal Pressman wrote:
>> On 07/08/2019 13:33, Leon Romanovsky wrote:
>>> +static inline void ib_umem_odp_set_type(struct ib_umem_odp *umem_odp,
>>> +					unsigned long start, size_t end)
>>
>> Consider renaming 'end' to 'size'?
>>
>>> +{
>>> +	if (!start && !end)
>>
>> According to the man pages, To create an implicit ODP MR, IBV_ACCESS_ON_DEMAND
>> should be set, addr should be 0 and length should be SIZE_MAX.
>> Why check end against zero?
> 
> Because that isn't how it works at the umem level. The driver detects
> tha above and triggers a special umem creation flow that has a 0
> length umem.

I see, thanks!
