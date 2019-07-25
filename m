Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB47774C24
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 12:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387774AbfGYKtr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 06:49:47 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:34410 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbfGYKtr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Jul 2019 06:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564051786; x=1595587786;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=OWpIJPp8vTM7NhZuKyhjQuW7IzEfz4ncY652DNA/fvA=;
  b=qlO46YTQdphe4FxP5stHmIYB5jL8lFrf3MrZ8diM7Yl/bIdbAbEPQJ64
   3Vk700aMMcZgbsTNBCrVRI9k2xLuu00frW9c2MfPJQmCQIpwyTND9WL8p
   Or7vDP9lgtmcRKr+qTSKufkSn9shLtNWoSYqyjK33sHwNuCpxpTMhFUy5
   o=;
X-IronPort-AV: E=Sophos;i="5.64,306,1559520000"; 
   d="scan'208";a="687855569"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 25 Jul 2019 10:49:43 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id 73C47A2326;
        Thu, 25 Jul 2019 10:49:43 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 25 Jul 2019 10:49:42 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.30) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 25 Jul 2019 10:49:39 +0000
Subject: Re: [PATCH for-next] RDMA/efa: Expose device statistics
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        "Firas JahJah" <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20190707142038.23191-1-galpress@amazon.com>
 <20190724190331.GA25015@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <030e1429-d6ac-3538-6fd6-682c5fa5f93a@amazon.com>
Date:   Thu, 25 Jul 2019 13:49:34 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724190331.GA25015@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.30]
X-ClientProxiedBy: EX13D24UWB004.ant.amazon.com (10.43.161.4) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 24/07/2019 22:03, Jason Gunthorpe wrote:
> On Sun, Jul 07, 2019 at 05:20:38PM +0300, Gal Pressman wrote:
>> Expose hardware statistics through the sysfs api:
>> /sys/class/infiniband/efa_0/hw_counters/*.
>>
>> Reviewed-by: Firas JahJah <firasj@amazon.com>
>> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
>> Signed-off-by: Gal Pressman <galpress@amazon.com>
>> ---
>>  drivers/infiniband/hw/efa/efa.h         |  3 +
>>  drivers/infiniband/hw/efa/efa_com_cmd.c | 35 +++++++++++
>>  drivers/infiniband/hw/efa/efa_com_cmd.h | 23 +++++++
>>  drivers/infiniband/hw/efa/efa_main.c    |  2 +
>>  drivers/infiniband/hw/efa/efa_verbs.c   | 79 +++++++++++++++++++++++++
>>  5 files changed, 142 insertions(+)
> 
> Am I right that this patch needs 
> 
> https://patchwork.kernel.org/patch/11053949/
> 
> before it won't crash?

That's right.
I'm going to resubmit this patch regardless to remove the 'if (port_num)' check
in efa_alloc_hw_stats as the exposed device stats are the same as the port stats
(only port 1) and some userspace tools use the port stats.

I'll make sure to note the patch dependency in v2.
