Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5EF9E16BC
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 11:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390292AbfJWJzi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 05:55:38 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:64619 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390924AbfJWJzi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 05:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1571824537; x=1603360537;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=jAzxOdJcDX4caGHaEO9x5QoAMCRPhnkwbN5EtpOgTU4=;
  b=VPo+dblAU3lNNZ88Nk/FXwK1SxvROeKVx/I5HB/twm082clbf1wM9vo1
   dmUIQUnjMzurPTFX02Z5XSm3lomYVt3H4EHLelyivh+U7YnD9vKCxlM2O
   mJHOtG5N1c16GGx/PGnLl+YJynnN/7YRDcUf09e7mWcRS72rQbW4tJvVm
   k=;
X-IronPort-AV: E=Sophos;i="5.68,220,1569283200"; 
   d="scan'208";a="432527410"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 23 Oct 2019 09:55:36 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS id 8C3D5A1F30;
        Wed, 23 Oct 2019 09:55:35 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 23 Oct 2019 09:55:34 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.115) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 23 Oct 2019 09:55:32 +0000
Subject: Re: [PATCH for-next 0/4] EFA RDMA read support
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
References: <20190910134301.4194-1-galpress@amazon.com>
 <24527b2a-3bd2-cee5-0383-277c6e72af5c@amazon.com>
 <20191021173119.GG25178@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <f7767c14-25d6-f9d0-8f31-2e53e3480543@amazon.com>
Date:   Wed, 23 Oct 2019 12:55:27 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021173119.GG25178@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.115]
X-ClientProxiedBy: EX13D19UWA004.ant.amazon.com (10.43.160.102) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 21/10/2019 20:31, Jason Gunthorpe wrote:
> On Sun, Oct 20, 2019 at 10:03:27AM +0300, Gal Pressman wrote:
>> On 10/09/2019 16:42, Gal Pressman wrote:
>>> Hi,
>>>
>>> The following series introduces RDMA read support and capabilities
>>> reporting to the EFA driver.
>>>
>>> The first two patches aren't directly related to RDMA read, but refactor
>>> some bits in the device capabilities struct.
>>>
>>> The last two patches add support for remote read access in MR
>>> registration and expose the RDMA read related attributes to the
>>> userspace library.
>>>
>>> PR was sent:
>>> https://github.com/linux-rdma/rdma-core/pull/576
>>
>> Should I resubmit patches 2-4?
> 
> No it is still on patchworks. You said not to apply your series until
> you said it was OK

Thanks, is it possible to send a mail when the series is reviewed/ready to merge
and waiting to be applied?

Specifically for this feature, it seems we are going to need a capability bit
for the RDMA read functionality, so I'll respin the kernel and userspace and
submit again.
You can drop this one from patchworks.
