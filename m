Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826636E0F17
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Apr 2023 15:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjDMNp1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Apr 2023 09:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjDMNpL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Apr 2023 09:45:11 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3752E8A74
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 06:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1681393469; x=1712929469;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=WXHXmZ68UxSmnBed6U8VaIp34P+fQdog7olA31mbIWs=;
  b=I1lTaStAwUtrcODkiPIRgg9dA20Y08F3mwGEz6DJ2kxZtpKx7sD0JO8D
   lMl5Wde6u3Rzw334/FNyKl0v6j0w/BQc2S2SZ52ri0Dg5Ji5Mic1aPtDK
   +NuVRzJEFuQRFC3HvY8Ici4R+7qVn9trM07pxgqZItejp9wxliRbNIrge
   w=;
X-IronPort-AV: E=Sophos;i="5.99,193,1677542400"; 
   d="scan'208";a="204152280"
Subject: Re: [PATCH] RDMA/efa: Add rdma write capability to device caps
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 13:43:39 +0000
Received: from EX19D010EUA004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com (Postfix) with ESMTPS id 5C9D840DC8;
        Thu, 13 Apr 2023 13:43:35 +0000 (UTC)
Received: from EX19D045EUC003.ant.amazon.com (10.252.61.236) by
 EX19D010EUA004.ant.amazon.com (10.252.50.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 13 Apr 2023 13:43:34 +0000
Received: from [192.168.145.111] (10.85.143.178) by
 EX19D045EUC003.ant.amazon.com (10.252.61.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 13 Apr 2023 13:43:31 +0000
Message-ID: <960d7702-29e4-a6cd-df5b-85c5e1e74ec0@amazon.com>
Date:   Thu, 13 Apr 2023 16:43:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
CC:     <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <sleybo@amazon.com>, <mrgolin@amazon.com>,
        Firas Jahjah <firasj@amazon.com>
References: <20230404154313.35194-1-ynachum@amazon.com>
 <20230409073228.GA14869@unreal>
 <f738b558-f0d9-e69e-0939-a80594063d4c@amazon.com>
 <20230409172146.GJ182481@unreal>
 <0c307561-8ee1-061b-6ba3-ceb74eb3a1c8@amazon.com>
 <20230410123812.GT182481@unreal>
 <5b9f3728-1fc7-4a87-f516-286718e94dc6@amazon.com>
 <20230413082205.GB17993@unreal>
From:   "Nachum, Yonatan" <ynachum@amazon.com>
In-Reply-To: <20230413082205.GB17993@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.85.143.178]
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D045EUC003.ant.amazon.com (10.252.61.236)
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>>>>>>>>
>>>>>>>>       access_flags &= ~IB_ACCESS_OPTIONAL;
>>>>>>>>       if (access_flags & ~supp_access_flags) {
>>>>>>>> diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
>>>>>>>> index 74406b4817ce..d94c32f28804 100644
>>>>>>>> --- a/include/uapi/rdma/efa-abi.h
>>>>>>>> +++ b/include/uapi/rdma/efa-abi.h
>>>>>>>> @@ -121,6 +121,7 @@ enum {
>>>>>>>>       EFA_QUERY_DEVICE_CAPS_CQ_NOTIFICATIONS = 1 << 2,
>>>>>>>>       EFA_QUERY_DEVICE_CAPS_CQ_WITH_SGID     = 1 << 3,
>>>>>>>>       EFA_QUERY_DEVICE_CAPS_DATA_POLLING_128 = 1 << 4,
>>>>>>>> +     EFA_QUERY_DEVICE_CAPS_RDMA_WRITE = 1 << 5,
>>>>>>>
>>>>>>> Why do you need special device capability while all rdma-core users
>>>>>>> set IBV_ACCESS_REMOTE_WRITE anyway without relying on anything from
>>>>>>> providers?
>>>>>>>
>>>>>>> Thanks
>>>>>>
>>>>>> We need to query the device because not every device supprort the same RDMA capabilities. Upper layers in the SW stack needs this supported flags to indicate which flows they can use. In addition this is identical to the existing RDMA read support in our code.
>>>>>
>>>>> Nice, but it doesn't answer my question. Please pay attention to the
>>>>> second part of my question "while all rdma-core ....".
>>>>>
>>>>> Thanks
>>>>>
>>>>
>>>> There are rdma-core users that doesn’t fail on unsupported features but fallback to supported ones. One example is Libfabric EFA provider that emulates RDMA write by read if device write isn’t supported but there are other similar examples. Correct way doing this in user code is by querying rdma-core for device supported capabilities, then selecting a suitable work flow. This is why existing and the additional capability bits are required.
>>>
>>> AFAIK, RDMA write is different here as fallback is performed in the kernel and
>>> not in the rdma-core provider. So why should EFA be different here?
>>>
>>> BTW, Please fix your mailer to break lines, so we will be able to reply
>>> on specific sentence with less effort.
>>>
>>> Thanks
>>
>> Can you please elaborate more on the fallback performed in the kernel?
>> What kind of fallback being performed? Is it in create MR/QP?
>> Does the fallback happens when providing unsupported write capability
>> and to what it fallback to?
> 
> OK, looked again, "Fallback" was in my imagination, sorry about that.
> 
> But my main question is continued to be, how other vendors which support
> RDMA write work without capability?
> 
> Thanks

Vendors that always support RDMA write don’t need a query for this capability.
Some EFA devices don’t support write capability so we provide the ability to
query the device to know if write is supported.
It is like mlx5 support query capabilities through direct verb.

Thanks
