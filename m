Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C95113D4D0
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 08:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgAPHFg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 02:05:36 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:59693 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgAPHFf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 02:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1579158335; x=1610694335;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=KzQDJi+mvs61cuqF5xP2OCB5fbP5AGaNZedBSvwVwno=;
  b=J7QgGzjlLSneiE5OTL6xrM6r/u+9CI/b85wskWiDEnhQE3054f7B/qQa
   VSMnjU4/IfEPkGJfC5PHM5TPSh3UT87zaf1em5saRd6Ydu/+ChjZ3OXej
   3qH9ES+cieZYUMavlKzzQ57L0enrhHB+fwVN8+AyH7S6+uwiaTrhD3AqQ
   U=;
IronPort-SDR: TcFW19vpGF45NZkCZ6yiHlr6N9tyvdiXAoeLs1AssGhoVPCEBvz4TQhrwdppMB6OKLFvUEpyG+
 gi16OK6kLTrQ==
X-IronPort-AV: E=Sophos;i="5.70,325,1574121600"; 
   d="scan'208";a="12683672"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 16 Jan 2020 07:05:34 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id E9BBBA1D0D;
        Thu, 16 Jan 2020 07:05:31 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Thu, 16 Jan 2020 07:05:31 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.95) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 16 Jan 2020 07:05:26 +0000
Subject: Re: [PATCH for-next 1/6] RDMA/efa: Unified getters/setters for device
 structs bitmask access
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Daniel Kranzdorf <dkkranzd@amazon.com>,
        Firas JahJah <firasj@amazon.com>
References: <20200114085706.82229-1-galpress@amazon.com>
 <20200114085706.82229-2-galpress@amazon.com>
 <20200115193116.GA11226@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <c93a1a50-a3ca-3a65-47fa-447147ccfb25@amazon.com>
Date:   Thu, 16 Jan 2020 09:05:22 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200115193116.GA11226@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.95]
X-ClientProxiedBy: EX13D27UWA002.ant.amazon.com (10.43.160.30) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 15/01/2020 21:31, Jason Gunthorpe wrote:
> On Tue, Jan 14, 2020 at 10:57:01AM +0200, Gal Pressman wrote:
>> diff --git a/drivers/infiniband/hw/efa/efa_common_defs.h b/drivers/infiniband/hw/efa/efa_common_defs.h
>> index c559ec08898e..845ea5ca9388 100644
>> +++ b/drivers/infiniband/hw/efa/efa_common_defs.h
>> @@ -9,6 +9,12 @@
>>  #define EFA_COMMON_SPEC_VERSION_MAJOR        2
>>  #define EFA_COMMON_SPEC_VERSION_MINOR        0
>>  
>> +#define EFA_GET(ptr, type) \
>> +	((*(ptr) & type##_MASK) >> type##_SHIFT)
>> +
>> +#define EFA_SET(ptr, type, value) \
>> +	({ *(ptr) |= ((value) << type##_SHIFT) & type##_MASK; })
>> +
> 
> Why not just GENMASK properly? You don't need MASK and SHIFT, it is
> supposed to be written like:
> 
>   #define EFA_ADMIN_REG_MR_CMD_MEM_ADDR_PHY_MODE_EN GENMASK(8,7)
> 
>   *ptr |= FIELD_PREP(val, EFA_ADMIN_REG_MR_CMD_MEM_ADDR_PHY_MODE_EN)
> 
> FIELD_PREP automatically deduces the correct shift.
> 
> And it would be much nicer if this had some type safety.
> 
> You should review the stuff Leon is prepping here:
> 
> https://github.com/jgunthorpe/linux/commit/453e85ed7aa46db22d8be16f9b0c88b17b8968af
> 
> Which is basically doing the same sorts of things, but with better
> type safety and no need for the various structs

I'll take a look, thanks.
