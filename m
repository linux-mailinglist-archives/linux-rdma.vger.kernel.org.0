Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D826DC6B8
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Apr 2023 14:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjDJMYp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Apr 2023 08:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDJMYo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Apr 2023 08:24:44 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAD4527E
        for <linux-rdma@vger.kernel.org>; Mon, 10 Apr 2023 05:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1681129484; x=1712665484;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject;
  bh=cy6v9efuG1LAl0D/6c9KWLqHDEFKWkLtkfBeQCyxPko=;
  b=UtDQvznnq+YdAbyzVyrRFbdNNVd2KQBiVK+j5n+BNFQdVepyMGGgKDa7
   hFLcloVk+7p7L7zluM6B0ScyfVVm7MOksGOPeXzT8PoSMEmiaeeVBgTRb
   1QnAySTinUpkbA6hXKXOJTyebZH91ne5tuQ1gi4TwPELgos9NQBjSUKOd
   U=;
X-IronPort-AV: E=Sophos;i="5.98,333,1673913600"; 
   d="scan'208";a="202764119"
Subject: Re: [PATCH] RDMA/efa: Add rdma write capability to device caps
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 12:24:38 +0000
Received: from EX19D014EUA004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com (Postfix) with ESMTPS id 427CF40D74;
        Mon, 10 Apr 2023 12:24:37 +0000 (UTC)
Received: from EX19D045EUC003.ant.amazon.com (10.252.61.236) by
 EX19D014EUA004.ant.amazon.com (10.252.50.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 10 Apr 2023 12:24:36 +0000
Received: from [192.168.7.165] (10.1.213.8) by EX19D045EUC003.ant.amazon.com
 (10.252.61.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Mon, 10 Apr
 2023 12:24:33 +0000
Message-ID: <0c307561-8ee1-061b-6ba3-ceb74eb3a1c8@amazon.com>
Date:   Mon, 10 Apr 2023 15:24:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
From:   "Nachum, Yonatan" <ynachum@amazon.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <sleybo@amazon.com>, <mrgolin@amazon.com>,
        Firas Jahjah <firasj@amazon.com>
References: <20230404154313.35194-1-ynachum@amazon.com>
 <20230409073228.GA14869@unreal>
 <f738b558-f0d9-e69e-0939-a80594063d4c@amazon.com>
 <20230409172146.GJ182481@unreal>
Content-Language: en-US
In-Reply-To: <20230409172146.GJ182481@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.1.213.8]
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D045EUC003.ant.amazon.com (10.252.61.236)
X-Spam-Status: No, score=-5.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>>>
>>>>       access_flags &= ~IB_ACCESS_OPTIONAL;
>>>>       if (access_flags & ~supp_access_flags) {
>>>> diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
>>>> index 74406b4817ce..d94c32f28804 100644
>>>> --- a/include/uapi/rdma/efa-abi.h
>>>> +++ b/include/uapi/rdma/efa-abi.h
>>>> @@ -121,6 +121,7 @@ enum {
>>>>       EFA_QUERY_DEVICE_CAPS_CQ_NOTIFICATIONS = 1 << 2,
>>>>       EFA_QUERY_DEVICE_CAPS_CQ_WITH_SGID     = 1 << 3,
>>>>       EFA_QUERY_DEVICE_CAPS_DATA_POLLING_128 = 1 << 4,
>>>> +     EFA_QUERY_DEVICE_CAPS_RDMA_WRITE = 1 << 5,
>>>
>>> Why do you need special device capability while all rdma-core users
>>> set IBV_ACCESS_REMOTE_WRITE anyway without relying on anything from
>>> providers?
>>>
>>> Thanks
>>
>> We need to query the device because not every device supprort the same RDMA capabilities. Upper layers in the SW stack needs this supported flags to indicate which flows they can use. In addition this is identical to the existing RDMA read support in our code.
> 
> Nice, but it doesn't answer my question. Please pay attention to the
> second part of my question "while all rdma-core ....".
> 
> Thanks
> 

There are rdma-core users that doesn’t fail on unsupported features but fallback to supported ones. One example is Libfabric EFA provider that emulates RDMA write by read if device write isn’t supported but there are other similar examples. Correct way doing this in user code is by querying rdma-core for device supported capabilities, then selecting a suitable work flow. This is why existing and the additional capability bits are required.

Thanks
