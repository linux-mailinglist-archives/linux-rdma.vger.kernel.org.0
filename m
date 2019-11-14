Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 062E6FCAA2
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2019 17:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfKNQRT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Nov 2019 11:17:19 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:35790 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfKNQRT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Nov 2019 11:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1573748239; x=1605284239;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=t9i8w1C1iCqG5KD6oyUpMj2VdDuyhQUUZD3HpiaWuz8=;
  b=Mu8FVDajgFICA0M4FDcnjF21L8TwKMXuN7hzr+Ha/hhfsEIfqPZFkw61
   B4g+YUtVrYegB3rFPw3HrKwQRbYzZwX3VgYy1Gxqarjk8UysoPHxkws3u
   8P2x+g23OZpYSbcBD7KeyOqcgjp+pW0200UXqDKNQJn7iwkqkX2BiG8LB
   E=;
IronPort-SDR: oVvt5g39QoWg8J0SauCM7mQMAds4KoFjAq7HH+5VDMjqzAUw3Y/R5wW3jvqOK55qtJ+Se28WiT
 YmVbi/WNHkjw==
X-IronPort-AV: E=Sophos;i="5.68,304,1569283200"; 
   d="scan'208";a="7343839"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 14 Nov 2019 16:17:16 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (Postfix) with ESMTPS id 6BD95A2415;
        Thu, 14 Nov 2019 16:17:14 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 14 Nov 2019 16:17:13 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.54) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 14 Nov 2019 16:17:10 +0000
Subject: Re: [PATCH for-rc] RDMA/efa: Clear the admin command buffer prior to
 its submission
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        "Daniel Kranzdorf" <dkkranzd@amazon.com>,
        Firas JahJah <firasj@amazon.com>
References: <20191112092608.46964-1-galpress@amazon.com>
 <20191114155913.GA11028@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <3abc3f93-aa71-cc0e-17dd-7bfed8625eca@amazon.com>
Date:   Thu, 14 Nov 2019 18:17:05 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191114155913.GA11028@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.54]
X-ClientProxiedBy: EX13D01UWB002.ant.amazon.com (10.43.161.136) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 14/11/2019 17:59, Jason Gunthorpe wrote:
> On Tue, Nov 12, 2019 at 11:26:08AM +0200, Gal Pressman wrote:
>> We cannot rely on the entry memcpy as we only copy the actual size of
>> the command, the rest of the bytes must be memset to zero.
>>
>> Fixes: 0420e542569b ("RDMA/efa: Implement functions that submit and complete admin commands")
>> Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
>> Reviewed-by: Firas JahJah <firasj@amazon.com>
>> Signed-off-by: Gal Pressman <galpress@amazon.com>
>> ---
>>  drivers/infiniband/hw/efa/efa_com.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> This isn't really -rc material since the device will have to be
> compatible with these old kernels for quite some time.

That's why I pushed it to -rc, this bug fix must be applied to these kernels
(5.2, 5.3) as well through stable.

If we're trying to avoid pushing this change late in the -rc cycle, I'm fine
with this patch going through -next and backported to 5.4 stable as well.
