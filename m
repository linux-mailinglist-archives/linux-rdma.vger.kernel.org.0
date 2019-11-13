Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1C7AFB1D8
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2019 14:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfKMNz0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Nov 2019 08:55:26 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:54613 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfKMNz0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Nov 2019 08:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1573653326; x=1605189326;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=iIiYyqy3+v7h0DhRWndZafBxyMYnvSa/OIOzxrOzoG4=;
  b=TarxC9U2L3fgsJ2hZimcevNI47umeonmF9+ME6IokW0YTVZo1zhlrVVG
   O9WgHisif2CYP2MUUzoxDJcxLlMMusx9CvddZijon1sx9fHE3X5LQDUTV
   1+E5TE5K87wNm5tjyScj17EfiYc26nGo6JMFzWVWxMZnK5qUois6aRlIC
   Q=;
IronPort-SDR: l5Uqu/8gT/UHixcRKzwHPAu03fWphwMIy5wfrDX9fbB2ODmbl9YUjeBWv9Tr3DYS/x8GaMKbfo
 dj5fJfZ/UvCA==
X-IronPort-AV: E=Sophos;i="5.68,300,1569283200"; 
   d="scan'208";a="4203078"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 13 Nov 2019 13:55:24 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS id A3222A21DA;
        Wed, 13 Nov 2019 13:55:23 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 13 Nov 2019 13:55:23 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.213) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 13 Nov 2019 13:55:19 +0000
Subject: Re: [PATCH for-rc] RDMA/efa: Clear the admin command buffer prior to
 its submission
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        "Daniel Kranzdorf" <dkkranzd@amazon.com>,
        Firas JahJah <firasj@amazon.com>
References: <20191112092608.46964-1-galpress@amazon.com>
 <20191113001730.GA28611@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <85aac664-a34e-4759-8f3c-9d774596d3d4@amazon.com>
Date:   Wed, 13 Nov 2019 15:55:13 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191113001730.GA28611@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.213]
X-ClientProxiedBy: EX13D03UWA003.ant.amazon.com (10.43.160.39) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 13/11/2019 2:17, Jason Gunthorpe wrote:
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
> This is quite late in the -rc cycle for such a vauge description. What
> is the user visible impact of passing non-zero memory beyond the
> command length?

Currently providing non-zero memory will not have any user visible impact.
However, since admin commands are extendable (in a backwards compatible way)
everything beyond the size of the command must be cleared to prevent issues in
the future.
