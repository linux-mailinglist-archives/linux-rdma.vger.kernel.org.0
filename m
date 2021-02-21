Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A26A32095B
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Feb 2021 10:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhBUJ0C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Feb 2021 04:26:02 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:6308 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhBUJZ7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Feb 2021 04:25:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1613899559; x=1645435559;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=bD/dqpgXUyW6ZvN2ottxeox9axwAonJXCC7bvYLk774=;
  b=M81BokOuqRy6k/1VR+aCJqhdjcfyCE89zMsGLDPYfiVDjUQkeaZ6lY2o
   x4byKzO1MhoN8/l/NAEDtp/+uLUZMJI49Yyy+OnWrfn8E4lhlwRuCPB8U
   0h04mvO9yb3xM83c4MAQOwATndPbrWKmeH2fFQvsaYqVt/PwRhk5I1HpP
   8=;
X-IronPort-AV: E=Sophos;i="5.81,194,1610409600"; 
   d="scan'208";a="85966087"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 21 Feb 2021 09:25:12 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id 93E65A2047;
        Sun, 21 Feb 2021 09:25:10 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.225) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 21 Feb 2021 09:25:07 +0000
Subject: Re: ibv_req_notify_cq clarification
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>
References: <bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
 <20210218125339.GY4718@ziepe.ca>
 <5287c059-3d8c-93f4-6be4-a6da07ccdb8a@amazon.com>
 <20210218162329.GZ4718@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <51a8fa8c-7529-9ef9-bb52-eccaaef3a666@amazon.com>
Date:   Sun, 21 Feb 2021 11:25:02 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210218162329.GZ4718@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.225]
X-ClientProxiedBy: EX13D41UWC004.ant.amazon.com (10.43.162.31) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 18/02/2021 18:23, Jason Gunthorpe wrote:
> On Thu, Feb 18, 2021 at 05:52:16PM +0200, Gal Pressman wrote:
>> On 18/02/2021 14:53, Jason Gunthorpe wrote:
>>> On Thu, Feb 18, 2021 at 11:13:43AM +0200, Gal Pressman wrote:
>>>> I'm a bit confused about the meaning of the ibv_req_notify_cq() verb:
>>>> "Upon the addition of a new CQ entry (CQE) to cq, a completion event will be
>>>> added to the completion channel associated with the CQ."
>>>>
>>>> What is considered a new CQE in this case?
>>>> The next CQE from the user's perspective, i.e. any new CQE that wasn't consumed
>>>> by the user's poll cq?
>>>> Or any new CQE from the device's perspective?
>>>
>>> new CQE from the device perspective.
>>>
>>>> For example, if at the time of ibv_req_notify_cq() call the CQ has received 100
>>>> completions, but the user hasn't polled his CQ yet, when should he be notified?
>>>> On the 101 completion or immediately (since there are completions waiting on the
>>>> CQ)?
>>>
>>> 101 completion
>>>
>>> It is only meaningful to call it when the CQ is empty.
>>
>> Thanks, so there's an inherent race between the user's CQ poll and the next arm?
> 
> I think the specs or man pages talk about this, the application has to
> observe empty, do arm, then poll again then sleep on the cq if empty.
> 
>> Do you know what's the purpose of the consumer index in the arm doorbell that's
>> implemented by many providers?
> 
> The consumer index is needed by HW to prevent CQ overflow, presumably
> the drivers push to reduce the cases where the HW has to read it from
> PCI

Thanks, that makes sense.

I found the following sentence in CX PRM:
"If new CQEs are posted to the CQ after the reporting of a completion event and
these CQEs are not yet consumed, then an event will be generated immediately
after the request for notification is executed."

Doesn't that contradict the expected behavior?
