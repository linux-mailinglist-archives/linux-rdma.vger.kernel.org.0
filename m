Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8566B6DBFA9
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Apr 2023 13:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjDIL2U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Apr 2023 07:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIL2T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Apr 2023 07:28:19 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0B140C0
        for <linux-rdma@vger.kernel.org>; Sun,  9 Apr 2023 04:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1681039699; x=1712575699;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject;
  bh=+nQ7nT8UQXFKkEwS9iQSSbyfgnVp+j1PiM+sswCakTg=;
  b=d/0EMWRxQr9naesYDg8QW+sTqxqJSO38xSaMvCtRNvnEQOY9bCFkfqci
   IgFayu0ROyTEO0A6O526EEh/WDErQjPolChsqbD9ghcd/VBzmbU2umlNi
   ee72ouH2QFeEFLM5BAvvQe1zxHZLZvAio3c2AkJp04s60fMekJFustZrr
   M=;
X-IronPort-AV: E=Sophos;i="5.98,331,1673913600"; 
   d="scan'208";a="312002535"
Subject: Re: [PATCH] RDMA/efa: Add rdma write capability to device caps
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2023 11:28:16 +0000
Received: from EX19D003EUA003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com (Postfix) with ESMTPS id 5386E451ED;
        Sun,  9 Apr 2023 11:28:15 +0000 (UTC)
Received: from EX19D045EUC003.ant.amazon.com (10.252.61.236) by
 EX19D003EUA003.ant.amazon.com (10.252.50.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 9 Apr 2023 11:28:14 +0000
Received: from [192.168.149.8] (10.85.143.179) by
 EX19D045EUC003.ant.amazon.com (10.252.61.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 9 Apr 2023 11:28:10 +0000
Message-ID: <f738b558-f0d9-e69e-0939-a80594063d4c@amazon.com>
Date:   Sun, 9 Apr 2023 14:28:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
From:   "Nachum, Yonatan" <ynachum@amazon.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <sleybo@amazon.com>, <matua@amazon.com>, <mrgolin@amazon.com>,
        Firas Jahjah <firasj@amazon.com>
References: <20230404154313.35194-1-ynachum@amazon.com>
 <20230409073228.GA14869@unreal>
In-Reply-To: <20230409073228.GA14869@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.85.143.179]
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D045EUC003.ant.amazon.com (10.252.61.236)
X-Spam-Status: No, score=-5.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>
>>       access_flags &= ~IB_ACCESS_OPTIONAL;
>>       if (access_flags & ~supp_access_flags) {
>> diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
>> index 74406b4817ce..d94c32f28804 100644
>> --- a/include/uapi/rdma/efa-abi.h
>> +++ b/include/uapi/rdma/efa-abi.h
>> @@ -121,6 +121,7 @@ enum {
>>       EFA_QUERY_DEVICE_CAPS_CQ_NOTIFICATIONS = 1 << 2,
>>       EFA_QUERY_DEVICE_CAPS_CQ_WITH_SGID     = 1 << 3,
>>       EFA_QUERY_DEVICE_CAPS_DATA_POLLING_128 = 1 << 4,
>> +     EFA_QUERY_DEVICE_CAPS_RDMA_WRITE = 1 << 5,
> 
> Why do you need special device capability while all rdma-core users
> set IBV_ACCESS_REMOTE_WRITE anyway without relying on anything from
> providers?
> 
> Thanks

We need to query the device because not every device supprort the same RDMA capabilities. Upper layers in the SW stack needs this supported flags to indicate which flows they can use. In addition this is identical to the existing RDMA read support in our code. 

Thanks.
