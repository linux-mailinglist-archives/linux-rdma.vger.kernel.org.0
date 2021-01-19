Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBDF2FB89F
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 15:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbhASNXm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 08:23:42 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:1476 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404454AbhASNUd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jan 2021 08:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1611062433; x=1642598433;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=xH3+LA2qNBIbQD4GWagHPEPKbwkKXcR0ynHj5mgkYUY=;
  b=coG+Fdzc+6aIdyk2PpXJLoMaJu+bHEY7buSehK6kD6rLQPFPCJiuznnQ
   MKJu7KkonVrdhGR/eGKSc9Ge1L0AqJ28wAyC0RfZou7wiSbSqOKQda9xV
   MMOAnv5sr/i8g7XeDKT+ML0e2vsRwaQD/sSyqttjumygX76rS2UySZLxz
   o=;
X-IronPort-AV: E=Sophos;i="5.79,358,1602547200"; 
   d="scan'208";a="79996660"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 19 Jan 2021 13:19:26 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id 3A49AA2904;
        Tue, 19 Jan 2021 13:19:25 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.94) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 19 Jan 2021 13:19:21 +0000
Subject: Re: [PATCH for-next 0/2] Host information userspace version
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        "Leybovich, Yossi" <sleybo@amazon.com>
References: <20210105104326.67895-1-galpress@amazon.com>
 <9286e969-09b8-a7d0-ca7e-50b8e3864a11@amazon.com>
 <20210119084632.GI21258@unreal>
 <91c354f0-ada7-85d5-8496-122a3a54354a@amazon.com>
 <20210119115808.GJ21258@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <1cb7058a-0bde-943b-64b7-d2a39337a085@amazon.com>
Date:   Tue, 19 Jan 2021 15:19:15 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210119115808.GJ21258@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.94]
X-ClientProxiedBy: EX13D50UWA002.ant.amazon.com (10.43.163.10) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 19/01/2021 13:58, Leon Romanovsky wrote:
> On Tue, Jan 19, 2021 at 11:10:59AM +0200, Gal Pressman wrote:
>> On 19/01/2021 10:46, Leon Romanovsky wrote:
>>> On Tue, Jan 19, 2021 at 09:17:14AM +0200, Gal Pressman wrote:
>>>> On 05/01/2021 12:43, Gal Pressman wrote:
>>>>> The following two patches add the userspace version to the host
>>>>> information struct reported to the device, used for debugging and
>>>>> troubleshooting purposes.
>>>>>
>>>>> PR was sent:
>>>>> https://github.com/linux-rdma/rdma-core/pull/918
>>>>>
>>>>> Thanks,
>>>>> Gal
>>>>
>>>> Anything stopping this series from being merged?
>>>
>>> It is unclear when this forwarding of non-verbs data to the FW will stop.
>>
>> This was already discussed in the PR. Not everything should be passed through
>> this interface, there should be a limit and it should be examined per case.
>> rdma-core version is clearly related to an RDMA device.
> 
> "Clearly or not" - it depends on the observer.
> 
>>
>> BTW, if you have any concerns about a patch you can state them, you don't have
>> to ignore it and wait for the submitter to ask what's wrong..
> 
> Didn't you mistake me with anyone else?

No, you decided to answer my original question :).

> I'm reviewer in the kernel exactly like you and it gives me nice thing - ignore patches.

Don't get me wrong, your review is very appreciated, but this series is 20 LOC
which you already reviewed two weeks ago, and I replied to all comments.
Ignoring patches is fine, but please don't review, ignore and wait for the last
minute to say they shouldn't be merged.
