Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18D3C12A82
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2019 11:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfECJcg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 May 2019 05:32:36 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:38859 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfECJcg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 May 2019 05:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1556875955; x=1588411955;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=fTs/2iuZenonFhdu3lG/VkX67uoS16NJjDa3IavuUwI=;
  b=lCz8G/8vgZT3en3YQlW70Ga3Y27qTUGDfPBFJMiEGQtZ8nzkQ8UMQqBw
   aBi9RlIibQuDK3Xk8uCQfUu7EGLsTVcDsCeKuwhB6kQtIm8pG8ikv7LUP
   H60YcAWl+dPNX4c1QGKY+jmGAwdjgEEM0tzNtbAOrEyL37YEvqNkJG+NG
   Y=;
X-IronPort-AV: E=Sophos;i="5.60,425,1549929600"; 
   d="scan'208";a="802642576"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 May 2019 09:32:33 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x439WQLm058911
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 3 May 2019 09:32:31 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 3 May 2019 09:32:30 +0000
Received: from [10.95.88.5] (10.43.161.192) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 3 May
 2019 09:32:27 +0000
Subject: Re: [PATCH for-next] RDMA/core: Introduce ratelimited ibdev printk
 functions
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        "Yossi Leybovich" <sleybo@amazon.com>
References: <1556807923-20403-1-git-send-email-galpress@amazon.com>
 <20190502150551.GD18518@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <d96f9977-5bb7-c61b-7b0f-f62084bc57c4@amazon.com>
Date:   Fri, 3 May 2019 12:32:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502150551.GD18518@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.192]
X-ClientProxiedBy: EX13D19UWA004.ant.amazon.com (10.43.160.102) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 02-May-19 18:05, Jason Gunthorpe wrote:
> On Thu, May 02, 2019 at 05:38:43PM +0300, Gal Pressman wrote:
>> Add ratelimited helpers to the ibdev_* printk functions.
>> Implementation inspired by counterpart dev_*_ratelimited functions.
>>
>> Signed-off-by: Gal Pressman <galpress@amazon.com>
>> ---
>> This is a followup patch to the addition of ibdev printk helpers to the
>> subsystem.
>>
>> From quick grep of infiniband drivers, some of the drivers will need this
>> variation when starting to use ibdev printk functions. In addition, I plan to
>> use them in EFA as well.
>> ---
>>  include/rdma/ib_verbs.h | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
> 
> I think we should wait till we get conversions patches that need
> this..

Thanks, I'll drop the patch.
