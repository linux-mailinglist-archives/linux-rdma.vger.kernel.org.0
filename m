Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 393C711CCCF
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 13:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfLLMKs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 07:10:48 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:10474 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728996AbfLLMKs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Dec 2019 07:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576152647; x=1607688647;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=IjCFRzWON9rJgnZo0jNdRDXJF1z083Lh5WgdDsRG8k8=;
  b=btmETCZPHZUlhp68TFLjDqEtrF997U2KpvcYeHUpbnvgM7p5kGdKIYCN
   MgD5gRbJ6Jx8abvYUPC/LPfuCzS1NW9R58zA828Xr4wuY1AAvmutKRoQj
   yH6fJHWEGwa9svH+Yj7Gh8OgsEtHDogJW6c751wQkVxchwqQ9kAeOlgPE
   o=;
IronPort-SDR: wnwSLi2X93c+EWQX+sZvq/5Ca9tiKM8HI59BmLIYxpS8tAY1odPp1C9IHUPizrKvHVVythAMyn
 xCnJbhKFVBtQ==
X-IronPort-AV: E=Sophos;i="5.69,305,1571702400"; 
   d="scan'208";a="14500165"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 12 Dec 2019 12:10:34 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id E600CA2184;
        Thu, 12 Dec 2019 12:10:29 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Dec 2019 12:10:29 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.109) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Dec 2019 12:10:23 +0000
Subject: Re: [PATCH] RDMA/cma: Fix checkpatch error
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Max Hirsch <max.hirsch@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Danit Goldberg <danitg@mellanox.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dag Moxnes <dag.moxnes@oracle.com>,
        Myungho Jung <mhjungk@gmail.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20191211111628.2955-1-max.hirsch@gmail.com>
 <20191211162654.GD6622@ziepe.ca> <20191212084907.GU67461@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <e5123cbb-9871-d9c3-62e9-5b3172d1adf8@amazon.com>
Date:   Thu, 12 Dec 2019 14:10:12 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191212084907.GU67461@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.109]
X-ClientProxiedBy: EX13D27UWB004.ant.amazon.com (10.43.161.101) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/12/2019 10:49, Leon Romanovsky wrote:
> On Wed, Dec 11, 2019 at 12:26:54PM -0400, Jason Gunthorpe wrote:
>> On Wed, Dec 11, 2019 at 11:16:26AM +0000, Max Hirsch wrote:
>>> When running checkpatch on cma.c the following error was found:
>>
>> I think checkpatch will complain about your patch, did you run it?
> 
> Jason, Doug
> 
> I would like to ask to refrain from accepting checkpatch.pl patches
> which are not part of other large submission. Such standalone cleanups
> do more harm than actual benefit from them for old and more or less
> stable code (e.g. RDMA-CM).

Sounds like a great approach to prevent new developers from contributing code.
You have to start somewhere and checkpatch patches are a good entry point for
such developers, discouraging them will only hurt us in the long term.

Linus had an interesting post on the subject:
https://lkml.org/lkml/2004/12/20/255
