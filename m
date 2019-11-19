Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22DCB102DCB
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 21:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfKSUuT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 15:50:19 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:46672 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfKSUuT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 15:50:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1574196618; x=1605732618;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=URuR4/vnlL1tBV0DX1t6c5/dOgpbT4Edhln8DThtqcY=;
  b=G9PwvlVkeJX2dbPWBbCql6kL8Gu5OgB9I3R//eenPnuk436eFRBBIf2r
   3AP4F04ikKPaq/0CrS+2RDnSYArJ63+edn7ox00j7BV/EplM6DVNo3zsy
   6tIRJSTGJhl4GBnn0/KD4qbol4694zbH/JV+/DWdlKGASIcKVeOJtsUzO
   8=;
IronPort-SDR: X0m6qzYU964rbtPzH3VmCkhaKHie/tGBYlQmOQh1rmqrnUdftdnpl5RwLCGH6lF6K65JA68kdF
 C2TnBN+G8Uyw==
X-IronPort-AV: E=Sophos;i="5.69,219,1571702400"; 
   d="scan'208";a="4783341"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 19 Nov 2019 20:50:16 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id 2FF5EA2525;
        Tue, 19 Nov 2019 20:50:16 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 19 Nov 2019 20:50:15 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.160) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 19 Nov 2019 20:50:11 +0000
Subject: Re: [PATCH for-next 3/3] RDMA/efa: Expose RDMA read related
 attributes
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        "Daniel Kranzdorf" <dkkranzd@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20191112091737.40204-1-galpress@amazon.com>
 <20191112091737.40204-4-galpress@amazon.com>
 <20191119195637.GA17863@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <60eb8f53-5284-6824-a723-f2e3fc79e921@amazon.com>
Date:   Tue, 19 Nov 2019 22:50:06 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191119195637.GA17863@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.160]
X-ClientProxiedBy: EX13D22UWB004.ant.amazon.com (10.43.161.165) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 19/11/2019 21:56, Jason Gunthorpe wrote:
> On Tue, Nov 12, 2019 at 11:17:37AM +0200, Gal Pressman wrote:
>> diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
>> index 9599a2a62be8..442804572118 100644
>> +++ b/include/uapi/rdma/efa-abi.h
>> @@ -90,12 +90,21 @@ struct efa_ibv_create_ah_resp {
>>  	__u8 reserved_30[2];
>>  };
>>  
>> +enum {
>> +	EFA_QUERY_DEVICE_CAPS_RDMA_READ = 1 << 0,
>> +};
> 
> This doesn't seem needed, caps should only be used if a zero filled
> reply from an old kernel is not OK.

This isn't a compatibility mask, it's our way to indicate the userspace whether
the device supports RDMA read. Old kernel/lack of support will return 0, new
kernel will return 0/1 according to the device support.

>>  struct efa_ibv_ex_query_device_resp {
>>  	__u32 comp_mask;
>>  	__u32 max_sq_wr;
>>  	__u32 max_rq_wr;
>>  	__u16 max_sq_sge;
>>  	__u16 max_rq_sge;
>> +	__u32 max_rdma_size;
>> +	__u16 max_wr_rdma_sge;
>> +	__u8 reserved_b0[2];
>> +	__u32 device_caps;
>> +	__u8 reserved_e0[4];
>>  };
> 
> This has the same problem as we talked about in userspace, the
> max_wr_rdma_sge duplicates the field in the normal query_device
> response

Sure, will remove from both.
