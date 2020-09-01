Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90CB25886E
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Sep 2020 08:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgIAGqk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 02:46:40 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:48941 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgIAGqj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Sep 2020 02:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598942799; x=1630478799;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=RrL6bD8gtLM1bJZdVZcnOfWl17jce+mS6zVhCacTins=;
  b=ZOaaYwJUcGfq0CpZ46t5czEoUws+5YGg3ONOzxtNosbIyeKxL1h8cLME
   C/9HorZorXyg/8392gKtikgj8NdxeaxjL2tmFdy8HE0nXHjoLKftDTGk4
   NlVzO5dcMiuH3lqDTDZUpG5Sd5McMdWV03S2xRheU2mN6aJB3CTMuiSMk
   M=;
X-IronPort-AV: E=Sophos;i="5.76,378,1592870400"; 
   d="scan'208";a="51163266"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 01 Sep 2020 06:46:37 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id 9940EA1D2E;
        Tue,  1 Sep 2020 06:46:36 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.160.100) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 1 Sep 2020 06:46:33 +0000
Subject: Re: [PATCH for-next] RDMA/core: Add a debug print when a driver is
 marked as non-kverbs provider
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
References: <20200818083831.92212-1-galpress@amazon.com>
 <20200831162828.GB24045@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <51d521b5-5f21-f6c5-c6c9-b4f0ed8223c9@amazon.com>
Date:   Tue, 1 Sep 2020 09:46:28 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200831162828.GB24045@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D21UWB002.ant.amazon.com (10.43.161.177) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 31/08/2020 19:28, Jason Gunthorpe wrote:
> On Tue, Aug 18, 2020 at 11:38:31AM +0300, Gal Pressman wrote:
>> Add a debug print which is emitted when a certain driver is marked as
>> non-kverbs provider. This allows for easier understanding of why kverbs
>> functionality isn't working in such cases.
>>
>> In addition, print the name of the first mandatory verb that is missing.
>> This brings back use for the unused name field.
>>
>> Signed-off-by: Gal Pressman <galpress@amazon.com>
>> ---
>>  drivers/infiniband/core/device.c | 4 ++++
>>  1 file changed, 4 insertions(+)
> 
> Kinda wondering why here? The debug level doesn't print by default
> does it?

Nope, I assume that a user that wants to debug why things aren't working is
going to enable debug prints. What do you mean by where here? Do you have a more
appropriate place in mind?

I thought this could be helpful, I can remove the print and the name field if
you prefer.
