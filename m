Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66ED898B73
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 08:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbfHVGfs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 02:35:48 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:60946 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfHVGfs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Aug 2019 02:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566455747; x=1597991747;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ID8xrB+nKKPtOMHXkUpmlUuiD8Xq1/U2Vwx/gHJc3PE=;
  b=i+hWZccrwdZyhS05zCjQKOAsSeCmVK/VdmtQykEgBOBur+XaV8J0PU5O
   aDnBG1MXLzLxVsUHztQvVC5eWlB+ZrVBMzIXjE9KnwX+Yw1N7XZtqxbCI
   7lekqphas5t+l6Cz5ndb74O0SqYq/PXSgQxYXm+tEUtrSnOV7gU9yGwQh
   Y=;
X-IronPort-AV: E=Sophos;i="5.64,415,1559520000"; 
   d="scan'208";a="822563180"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 22 Aug 2019 06:35:45 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id A9A3FA277F;
        Thu, 22 Aug 2019 06:35:44 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 22 Aug 2019 06:35:44 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.177) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 22 Aug 2019 06:35:40 +0000
Subject: Re: [PATCH] siw: Fix potential NULL pointer in siw_connect().
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        <linux-rdma@vger.kernel.org>
References: <20190819140257.19319-1-bmt@zurich.ibm.com>
 <30814d3ca3b06c83b31f9255f140fdf2115e83e5.camel@redhat.com>
 <20190821125645.GE3964@kadam>
 <adc716f5d2105a3cc7978873cd0f14503ae323d8.camel@redhat.com>
 <20190821141225.GB8653@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <d13ab5d2-bdfa-2c42-7d92-807b059da7a2@amazon.com>
Date:   Thu, 22 Aug 2019 09:35:34 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821141225.GB8653@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.177]
X-ClientProxiedBy: EX13D17UWB001.ant.amazon.com (10.43.161.252) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 21/08/2019 17:12, Jason Gunthorpe wrote:
> On Wed, Aug 21, 2019 at 09:39:50AM -0400, Doug Ledford wrote:
>> On Wed, 2019-08-21 at 15:56 +0300, Dan Carpenter wrote:
>>> On Tue, Aug 20, 2019 at 12:05:33PM -0400, Doug Ledford wrote:
>>>> Please take a look (I pushed it out to my wip/dl-for-rc branch) so
>>>> you
>>>> can see what I mean about how to make both a simple subject line and
>>>> a
>>>> decent commit message.  Also, no final punctuation on the subject
>>>> line,
>>>> and try to keep the subject length <= 50 chars total.  If you have
>>>> to go
>>>> over to have a decent subject, then so be it, but we strive for that
>>>> 50
>>>> char limit to make a subject stay on one line when displayed using
>>>> git
>>>> log --oneline.
>>>
>>> 50 is really small.
>>
>> 50 is the vim syntax highlighting suggested limit.  You can go over,
>> which is why I indicated it was a soft limit, but there you are.  It
>> leaves room for the displayed hash length to grow as well.
> 
> I use 75 for all text in the commit message, as per
> Documentation/process/submitting-patches.rst
> 
> People using 'git log --oneline' should have terminals wider than 80
> :)
> 
> The bigger question is if the first character after the subject tag
> should be uppper case or lower case <hum>

I was thinking about that lately as well, it seems like git patches (which are
pretty similar to the kernel) use lower-case letter [1].

RDMA subsystem mostly sticks to capital letter though:
$ git log --oneline -- drivers/infiniband/ | egrep ": [a-z]" | wc -l
1364

$ git log --oneline -- drivers/infiniband/ | egrep ": [A-Z]" | wc -l
8069

Things look different when checking the entire tree:
$ git log --oneline | egrep ": [a-z]" | wc -l
514596

$ git log --oneline | egrep ": [A-Z]" | wc -l
356939

[1] https://github.com/git/git/blob/master/Documentation/SubmittingPatches#L118
