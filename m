Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6797331EC28
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Feb 2021 17:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhBRQSa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Feb 2021 11:18:30 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:1919 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbhBRPxS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Feb 2021 10:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1613663598; x=1645199598;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=JuVVnetNo4ApOUzoqXLCZptDvIITpAFCtFxvxgOKLc8=;
  b=mPbQN7mr0rdhPmCRoOt419juMWoeRQ++VFXDGukNiq0UliZUYvO7XzCU
   +hfpr30TVIxTPQWbwe2sPz6JQwoybj/Hw2bSXmj1fpQ4aI1+nnZaqmjeN
   LBtFXGDrj25g7GAt1CQWDqKpbGXzpNcEfRwixehoIst2LhQV4S/Latl0X
   s=;
X-IronPort-AV: E=Sophos;i="5.81,187,1610409600"; 
   d="scan'208";a="85047341"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 18 Feb 2021 15:52:24 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id DE879C0667;
        Thu, 18 Feb 2021 15:52:23 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.239) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 18 Feb 2021 15:52:21 +0000
Subject: Re: ibv_req_notify_cq clarification
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>
References: <bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
 <20210218125339.GY4718@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <5287c059-3d8c-93f4-6be4-a6da07ccdb8a@amazon.com>
Date:   Thu, 18 Feb 2021 17:52:16 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210218125339.GY4718@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.239]
X-ClientProxiedBy: EX13D13UWB001.ant.amazon.com (10.43.161.156) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 18/02/2021 14:53, Jason Gunthorpe wrote:
> On Thu, Feb 18, 2021 at 11:13:43AM +0200, Gal Pressman wrote:
>> I'm a bit confused about the meaning of the ibv_req_notify_cq() verb:
>> "Upon the addition of a new CQ entry (CQE) to cq, a completion event will be
>> added to the completion channel associated with the CQ."
>>
>> What is considered a new CQE in this case?
>> The next CQE from the user's perspective, i.e. any new CQE that wasn't consumed
>> by the user's poll cq?
>> Or any new CQE from the device's perspective?
> 
> new CQE from the device perspective.
> 
>> For example, if at the time of ibv_req_notify_cq() call the CQ has received 100
>> completions, but the user hasn't polled his CQ yet, when should he be notified?
>> On the 101 completion or immediately (since there are completions waiting on the
>> CQ)?
> 
> 101 completion
> 
> It is only meaningful to call it when the CQ is empty.

Thanks, so there's an inherent race between the user's CQ poll and the next arm?

Do you know what's the purpose of the consumer index in the arm doorbell that's
implemented by many providers?
