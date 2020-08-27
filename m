Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12944254675
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 16:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgH0OJ2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 10:09:28 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:3568 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgH0OJR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Aug 2020 10:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598537356; x=1630073356;
  h=to:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding:subject;
  bh=j+U9gCdrBTb9w2vDO85Vcm5Ol6WaJyYt1tcU+GVW4l4=;
  b=i3VK7vmFBSFKkHuCZUvB1lPm6/x10fTOhgF6DbxAm86zm9DfGs+f78yY
   uxIg+iJ03bR01Usqlal0mEzadSbf4HcqwpkhErYQVJWXBd92BbDm4vAXG
   G3LZRJF51CqkO90RbUc8W251QfRMc85vwZ1KkHgzZEdQQjWmCkklkKNXa
   I=;
X-IronPort-AV: E=Sophos;i="5.76,359,1592870400"; 
   d="scan'208";a="63200867"
Subject: Re: [PATCH for-next] RDMA/usnic: Remove the query_pkey callback
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 27 Aug 2020 14:09:11 +0000
Received: from EX13D19EUB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id 52AAEA21C8;
        Thu, 27 Aug 2020 14:09:08 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.40) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 27 Aug 2020 14:09:04 +0000
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Kamal Heib <kamalheib1@gmail.com>,
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
 <0f1aa022-3271-bec3-146d-eb3daa518447@amazon.com>
 <20200827130158.GS24045@ziepe.ca>
 <0b734c22-0064-b674-f987-4eb94aae8545@amazon.com>
 <20200827135558.GT24045@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <55741e03-63f5-a6f4-c5fe-2b5491eb5e58@amazon.com>
Date:   Thu, 27 Aug 2020 17:08:58 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200827135558.GT24045@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.162.40]
X-ClientProxiedBy: EX13D44UWC004.ant.amazon.com (10.43.162.209) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 27/08/2020 16:55, Jason Gunthorpe wrote:
> On Thu, Aug 27, 2020 at 04:10:27PM +0300, Gal Pressman wrote:
>> On 27/08/2020 16:01, Jason Gunthorpe wrote:
>>> On Thu, Aug 27, 2020 at 03:58:23PM +0300, Gal Pressman wrote:
>>>> On 27/08/2020 15:20, Håkon Bugge wrote:
>>>>>> On 27 Aug 2020, at 14:01, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>>>>> On Thu, Aug 27, 2020 at 11:20:16AM +0300, Gal Pressman wrote:
>>>>>>> On 27/08/2020 10:53, Kamal Heib wrote:
>>>>>>>> On Thu, Aug 20, 2020 at 04:53:38PM +0300, Kamal Heib wrote:
>>>>>>>>> On Thu, Aug 20, 2020 at 04:11:23PM +0300, Gal Pressman wrote:
>>>>>>>>>> On 20/08/2020 15:53, Kamal Heib wrote:
>>>>>>>>>>> Now that the query_pkey() isn't mandatory by the RDMA core, this
>>>>>>>>>>> callback can be removed from the usnic provider.
>>>>>>>>>>
>>>>>>>>>> Not directly related to this patch, but pyverbs has a test which verifies that
>>>>>>>>>> max_pkeys > 0, maybe this check should be removed.
>>>>>>>>>
>>>>>>>>> Or changed to work only for node_type == e.IBV_NODE_CA?
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Kamal
>>>>>>>>
>>>>>>>> BTW, do the efa care about pkey?
>>>>>>>
>>>>>>> Depends.. We only support the default pkey so it doesn't do much in terms of
>>>>>>> functionality, but we still need to support it as part of the QP state machine
>>>>>>> for modify QP.
>>>>>>
>>>>>> Does the pkey appear on the wire, or is it just some cruft for API sake?
>>>>>
>>>>> On the wire. Included in the BTH (Base Transfer Header).
>>>>
>>>> He was probably asking specifically about EFA.
>>>> I can't share any details about the wire protocol, does it matter?
>>>
>>> If it isn't actually used for anything then the driver shouldn't
>>> expose PKEY at all, if you do use it then leave it.
>>
>> How would that work? How can you not expose pkeys and still have ibv_ud_pingpong
>> work?
>> You mean remove query_pkey, but still support IBV_QP_PKEY_INDEX in modify_qp?
> 
> iWarp doesn't use PKEY at all, so you'd have to follow their
> model. Some of the userspace that assumes IB would probably need
> fixing (eg ud pingpong does not support iwarp)

Thanks, I'd rather keep supporting the default pkey only.
