Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14312FF4ED
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 20:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbhAUTn3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 14:43:29 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:50914 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbhAUTls (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 14:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1611258108; x=1642794108;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=qm0mLlqdJI6345iQYOoNxKGhHu4S4D5WpTwQqAFwwio=;
  b=DnGbHwOgqT+fnoLUXUQd+s3Piyh6e3v/tnxe13uP2fM8xW36neUjVqA9
   nGPqliSgnhCoPkCUxP8tmdmXg7HydUFv1p9xssqxunKisdTYG8dglZg5l
   iNnKXTPQc4DJwUvVKNHG3OgfyBKQGZc4b/4p0bn8k1OMPesfCytgNc+BE
   s=;
X-IronPort-AV: E=Sophos;i="5.79,365,1602547200"; 
   d="scan'208";a="105590197"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-cc689b93.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 21 Jan 2021 19:40:59 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-cc689b93.us-west-2.amazon.com (Postfix) with ESMTPS id 01AFD120DE8;
        Thu, 21 Jan 2021 19:40:58 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.68) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 21 Jan 2021 19:40:54 +0000
Subject: Re: [PATCH for-next 0/2] Host information userspace version
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        "Leybovich, Yossi" <sleybo@amazon.com>
References: <20210105104326.67895-1-galpress@amazon.com>
 <9286e969-09b8-a7d0-ca7e-50b8e3864a11@amazon.com>
 <20210121183512.GC4147@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <206d8797-0188-5949-aaaf-57a6901c48d9@amazon.com>
Date:   Thu, 21 Jan 2021 21:40:49 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210121183512.GC4147@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.68]
X-ClientProxiedBy: EX13D29UWA004.ant.amazon.com (10.43.160.33) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 21/01/2021 20:35, Jason Gunthorpe wrote:
> On Tue, Jan 19, 2021 at 09:17:14AM +0200, Gal Pressman wrote:
>> On 05/01/2021 12:43, Gal Pressman wrote:
>>> The following two patches add the userspace version to the host
>>> information struct reported to the device, used for debugging and
>>> troubleshooting purposes.
>>>
>>> PR was sent:
>>> https://github.com/linux-rdma/rdma-core/pull/918
>>>
>>> Thanks,
>>> Gal
>>
>> Anything stopping this series from being merged?
> 
> Honestly, I'm not very keen on this
> 
> Why does this have to go through a kernel driver, can't you collect
> OS telemetry some other way?

Hmm, it has to go through rdma-core somehow, what sort of component can
rdma-core interact with to pass such data? The only one I could think of is the
RDMA driver :).

As I said, I get your concern, I was going on and off about this as well, but
the userspace version is a very useful piece of information in the context of a
kernel bypass device. It's just as important as the kernel version.
I agree that this is not the place to pass things like gcc version, but I don't
think that's the case here :).

Do you absolutely hate the idea of passing the userspace version, or are you
worried about what's next to come?
If it's the latter, we don't really have plans to push anything similar anytime
soon, and even if we did, I don't think it should block this series.
