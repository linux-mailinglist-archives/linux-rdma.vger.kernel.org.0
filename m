Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1437F58D
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 13:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfD3L2P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 07:28:15 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:34044 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfD3L2P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Apr 2019 07:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1556623693; x=1588159693;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=5OTHcJremHq/X8ta2FliQMEZRk9wMfhoqH6AyOa8bUg=;
  b=D+iwjgL5sUzHaAmq8NtWGwJZteYjhm3K9AqAgz3aM/m6r1dJB0WvZxTp
   AiPe4/GKpret5oZIOhe88jNmSiJ9y03dyIqrXMNu0VGa9Bb1LPSoAuF9/
   sM0StJ5vGQGSbwtzQrgGsqVgEKKE/4Myo2llPxWiY+cNf5PWylHmPMjc3
   0=;
X-IronPort-AV: E=Sophos;i="5.60,413,1549929600"; 
   d="scan'208";a="394602423"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Apr 2019 11:28:00 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x3UBRseA058775
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 30 Apr 2019 11:27:59 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Apr 2019 11:27:59 +0000
Received: from [10.95.87.116] (10.43.162.83) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 30 Apr
 2019 11:27:55 +0000
Subject: Re: [PATCH for-next] RDMA/uverbs: Initialize udata struct on destroy
 flows
To:     Leon Romanovsky <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <1556613999-14823-1-git-send-email-galpress@amazon.com>
 <20190430111814.GE6705@mtr-leonro.mtl.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <45a1912f-b811-ad4b-cf66-ac02edb4b811@amazon.com>
Date:   Tue, 30 Apr 2019 14:27:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430111814.GE6705@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.83]
X-ClientProxiedBy: EX13D25UWC003.ant.amazon.com (10.43.162.129) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 30-Apr-19 14:18, Leon Romanovsky wrote:
> On Tue, Apr 30, 2019 at 11:46:39AM +0300, Gal Pressman wrote:
>> Cited commit introduced the udata parameter to different destroy flows
>> but the uapi method definition does not have udata (i.e has_udata flag
>> is not set). As a result, an uninitialized udata struct is being passed
>> down to the driver callbacks.
>>
>> Fix that by clearing the driver udata even in cases where has_udata flag
>> is not set.
>>
>> Fixes: c4367a26357b ("IB: Pass uverbs_attr_bundle down ib_x destroy path")
>> Cc: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
>> Co-developed-by: Jason Gunthorpe <jgg@ziepe.ca>
> 
> What is wrong with Signed-off-by that caused you to add new tag?

Jason is the one that originally wrote and sent the code, this tag seems
appropriate.
Obviously I don't mind removing it, it's there to give him credit..

> 
>> Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
>> Signed-off-by: Gal Pressman <galpress@amazon.com>
>> ---
>>  drivers/infiniband/core/uverbs_ioctl.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
>> index cfbef25b3a73..829b0c6944d8 100644
>> --- a/drivers/infiniband/core/uverbs_ioctl.c
>> +++ b/drivers/infiniband/core/uverbs_ioctl.c
>> @@ -453,6 +453,8 @@ static int ib_uverbs_run_method(struct bundle_priv *pbundle,
>>  		uverbs_fill_udata(&pbundle->bundle,
>>  				  &pbundle->bundle.driver_udata,
>>  				  UVERBS_ATTR_UHW_IN, UVERBS_ATTR_UHW_OUT);
>> +	else
>> +		pbundle->bundle.driver_udata = (struct ib_udata){};
>>
>>  	if (destroy_bkey != UVERBS_API_ATTR_BKEY_LEN) {
>>  		struct uverbs_obj_attr *destroy_attr =
>> --
>> 2.7.4
>>
