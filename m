Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EA2254588
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 14:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgH0M7N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 08:59:13 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:28025 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgH0M7B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Aug 2020 08:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598533142; x=1630069142;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=pvCCIFjp4UZElJPc6NhKvHuFdMnK/fGdnUBy32iK3xA=;
  b=jdEPUhn0sCpBzx6xJPsdRkLVRFkB4bmsltFkHY+bYxTX/ZW5xopc4bre
   QJhIGB+TQnIeVVZfItQ2dZwB7gHynKpMi7IZ8fl9347F/eEzC1Q0c9bSl
   ioYaD5EXFBVGitUItTB2+VU+yIKblZJqMx71kzdmWQVxdR/b5YRAxhwzA
   0=;
X-IronPort-AV: E=Sophos;i="5.76,359,1592870400"; 
   d="scan'208";a="50329860"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 27 Aug 2020 12:58:35 +0000
Received: from EX13D19EUB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id 31FD0A1903;
        Thu, 27 Aug 2020 12:58:32 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.160.183) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 27 Aug 2020 12:58:28 +0000
Subject: Re: [PATCH for-next] RDMA/usnic: Remove the query_pkey callback
To:     =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Kamal Heib <kamalheib1@gmail.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Christian Benvenuti <benve@cisco.com>
References: <20200820125346.111902-1-kamalheib1@gmail.com>
 <efb8ce2b-fb37-2950-36fd-fb45b845632a@amazon.com>
 <20200820135338.GA114615@kheib-workstation>
 <20200827075356.GA394866@kheib-workstation>
 <4be87aa7-bc3c-d8f1-05e2-9276125cacc2@amazon.com>
 <20200827120139.GL24045@ziepe.ca>
 <ACEC991F-E03B-49F5-95D0-42C78CC2B78E@oracle.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <0f1aa022-3271-bec3-146d-eb3daa518447@amazon.com>
Date:   Thu, 27 Aug 2020 15:58:23 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <ACEC991F-E03B-49F5-95D0-42C78CC2B78E@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.183]
X-ClientProxiedBy: EX13D30UWB002.ant.amazon.com (10.43.161.110) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 27/08/2020 15:20, Håkon Bugge wrote:
>> On 27 Aug 2020, at 14:01, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>> On Thu, Aug 27, 2020 at 11:20:16AM +0300, Gal Pressman wrote:
>>> On 27/08/2020 10:53, Kamal Heib wrote:
>>>> On Thu, Aug 20, 2020 at 04:53:38PM +0300, Kamal Heib wrote:
>>>>> On Thu, Aug 20, 2020 at 04:11:23PM +0300, Gal Pressman wrote:
>>>>>> On 20/08/2020 15:53, Kamal Heib wrote:
>>>>>>> Now that the query_pkey() isn't mandatory by the RDMA core, this
>>>>>>> callback can be removed from the usnic provider.
>>>>>>
>>>>>> Not directly related to this patch, but pyverbs has a test which verifies that
>>>>>> max_pkeys > 0, maybe this check should be removed.
>>>>>
>>>>> Or changed to work only for node_type == e.IBV_NODE_CA?
>>>>>
>>>>> Thanks,
>>>>> Kamal
>>>>
>>>> BTW, do the efa care about pkey?
>>>
>>> Depends.. We only support the default pkey so it doesn't do much in terms of
>>> functionality, but we still need to support it as part of the QP state machine
>>> for modify QP.
>>
>> Does the pkey appear on the wire, or is it just some cruft for API sake?
> 
> On the wire. Included in the BTH (Base Transfer Header).

He was probably asking specifically about EFA.
I can't share any details about the wire protocol, does it matter?
