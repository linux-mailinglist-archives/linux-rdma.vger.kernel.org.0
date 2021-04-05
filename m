Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C433541FC
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Apr 2021 14:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbhDEMQU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Apr 2021 08:16:20 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:44530 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhDEMQU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Apr 2021 08:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1617624974; x=1649160974;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=fIYpMqGS9xXswKpNRlA2G1kNtgIuvOruHEvcndiROPg=;
  b=gpQWRoUqO4PPfUDZYCUDtz0mGQMHC1oE52muVvfNM7KSlnay86ZuZlPv
   n8oFhg3P3xlP/SKKhbEErgwj2KZvTZFeSbObhJfZdoXhLV7WZF4I9hGZJ
   UwB68ZbcJct2wFSdZWILQ/gcNJf5vVc3RhjfDt9da0zLnMsuvh41uBbi9
   c=;
X-IronPort-AV: E=Sophos;i="5.81,306,1610409600"; 
   d="scan'208";a="125218423"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 05 Apr 2021 12:16:13 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with ESMTPS id 430C4A1CFE;
        Mon,  5 Apr 2021 12:16:11 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.244) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 5 Apr 2021 12:16:07 +0000
Subject: Re: [PATCH for-next] RDMA/nldev: Add copy-on-fork attribute to get
 sys command
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20210405114722.98904-1-galpress@amazon.com>
 <YGr7EajqXvSGyZfy@unreal> <YGr7bY9CcQoDXSb2@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <3e4ffb42-8d91-cf5b-893d-cb9033620ee3@amazon.com>
Date:   Mon, 5 Apr 2021 15:16:01 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YGr7bY9CcQoDXSb2@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.244]
X-ClientProxiedBy: EX13D43UWC001.ant.amazon.com (10.43.162.69) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 05/04/2021 14:58, Leon Romanovsky wrote:
> On Mon, Apr 05, 2021 at 02:57:05PM +0300, Leon Romanovsky wrote:
>> On Mon, Apr 05, 2021 at 02:47:21PM +0300, Gal Pressman wrote:
>>> The new attribute indicates that the kernel copies DMA pages on fork,
>>> hence libibverbs' fork support through madvise and MADV_DONTFORK is not
>>> needed.
>>>
>>> The introduced attribute is always reported as supported since the
>>> kernel has the patch that added the copy-on-fork behavior. This allows
>>> the userspace library to identify older vs newer kernel versions.
>>> Extra care should be taken when backporting this patch as it relies on
>>> the fact that the copy-on-fork patch is merged, hence no check for
>>> support is added.
>>
>> Please be more specific, add SHA-1 of that patch and wrote the same
>> comment near "err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK,
>> 1);" line.
> 
> And rdmatool should be updated too.

Sure.
