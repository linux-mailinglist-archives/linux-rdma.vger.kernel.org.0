Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1A72FB88B
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 15:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbhASNCU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 08:02:20 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:17042 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731809AbhASJMB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jan 2021 04:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1611047521; x=1642583521;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=kXjXIJHk/gTkBY0EGuKxQJyXKMNF8JNVpvECwxWp7ws=;
  b=GxDeyK5/P2bLd4+3T15Cvmk5gibWMj/c+lHkeeAKOG3p67Qe6/xmpyUp
   pYBrwAPgYX/j62AzOR8hdn/xN7dSRNQHgxGlVLna4MJn4gNmfTpFkt0PM
   3KghXb/r8SMUN+U3gFqOpr1tv2hpo02f0Kdx+lJ+4L9AqLxwKDT5HeAXo
   g=;
X-IronPort-AV: E=Sophos;i="5.79,358,1602547200"; 
   d="scan'208";a="104818012"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 19 Jan 2021 09:11:10 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS id C62FEA2047;
        Tue, 19 Jan 2021 09:11:08 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.68) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 19 Jan 2021 09:11:05 +0000
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
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <91c354f0-ada7-85d5-8496-122a3a54354a@amazon.com>
Date:   Tue, 19 Jan 2021 11:10:59 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210119084632.GI21258@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.68]
X-ClientProxiedBy: EX13D40UWA004.ant.amazon.com (10.43.160.36) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 19/01/2021 10:46, Leon Romanovsky wrote:
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
> It is unclear when this forwarding of non-verbs data to the FW will stop.

This was already discussed in the PR. Not everything should be passed through
this interface, there should be a limit and it should be examined per case.
rdma-core version is clearly related to an RDMA device.

BTW, if you have any concerns about a patch you can state them, you don't have
to ignore it and wait for the submitter to ask what's wrong..
