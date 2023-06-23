Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC7773B92C
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 15:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjFWNzo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jun 2023 09:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjFWNzn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Jun 2023 09:55:43 -0400
Received: from out-2.mta1.migadu.com (out-2.mta1.migadu.com [95.215.58.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9F51B3
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 06:55:41 -0700 (PDT)
Message-ID: <41e27ce0-459c-0cc1-8ce1-9037f46160a0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687528540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o+iaLN/XygqcKcRkH1+ptdq+3ukyooiDn99Lag45MUQ=;
        b=J3M3gvY5bxClo85YAnKsAepgInkSLsG9/UafooA/N5gKFCg0K31YUB1e1anWchnnXsE2D6
        loWq7kqxtIPV9KLmCl/pktehndkpsd2ysIpg/hWoAe8fFZArkuH5T60ePLtMHndtPcMtN8
        Ca4FJyPApq4GIoFstlzEdk0lfI/fUyw=
Date:   Fri, 23 Jun 2023 21:55:24 +0800
MIME-Version: 1.0
Subject: Re: RE: [PATCH v6 3/8] RDMA/nldev: Add dellink function pointer
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "parav@nvidia.com" <parav@nvidia.com>,
        "lehrer@gmail.com" <lehrer@gmail.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Cc:     Rain River <rain.1986.08.12@gmail.com>
References: <20230623095749.485873-1-yanjun.zhu@intel.com>
 <20230623095749.485873-4-yanjun.zhu@intel.com>
 <SN7PR15MB5755365175AB370E9AFB19DB9923A@SN7PR15MB5755.namprd15.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <SN7PR15MB5755365175AB370E9AFB19DB9923A@SN7PR15MB5755.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/6/23 18:11, Bernard Metzler 写道:
> 
> 
>> -----Original Message-----
>> From: Zhu Yanjun <yanjun.zhu@intel.com>
>> Sent: Friday, 23 June 2023 11:58
>> To: zyjzyj2000@gmail.com; jgg@ziepe.ca; leon@kernel.org; linux-
>> rdma@vger.kernel.org; parav@nvidia.com; lehrer@gmail.com;
>> rpearsonhpe@gmail.com
>> Cc: Zhu Yanjun <yanjun.zhu@linux.dev>; Rain River
>> <rain.1986.08.12@gmail.com>
>> Subject: [EXTERNAL] [PATCH v6 3/8] RDMA/nldev: Add dellink function pointer
>>
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> The newlink function pointer is added. And the sock listening on port 4791
>> is added in the newlink function. So the dellink function is needed to
>> remove the sock.
>>
>> Tested-by: Rain River <rain.1986.08.12@gmail.com>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/core/nldev.c | 6 ++++++
>>   include/rdma/rdma_netlink.h     | 2 ++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/infiniband/core/nldev.c
>> b/drivers/infiniband/core/nldev.c
>> index d5d3e4f0de77..97a62685ed5b 100644
>> --- a/drivers/infiniband/core/nldev.c
>> +++ b/drivers/infiniband/core/nldev.c
>> @@ -1758,6 +1758,12 @@ static int nldev_dellink(struct sk_buff *skb, struct
>> nlmsghdr *nlh,
>>   		return -EINVAL;
>>   	}
>>
>> +	if (device->link_ops) {
>> +		err = device->link_ops->dellink(device);
> 
> That assumes delink() being populated by all drivers
> having link_ops in place. It crashes for drivers
> like siw.

Good catch. Thanks, I will fix it.

Zhu Yanjun

> 
> 
>> +		if (err)
>> +			return err;
>> +	}
>> +
>>   	ib_unregister_device_and_put(device);
>>   	return 0;
>>   }
>> diff --git a/include/rdma/rdma_netlink.h b/include/rdma/rdma_netlink.h
>> index c2a79aeee113..bf9df004061f 100644
>> --- a/include/rdma/rdma_netlink.h
>> +++ b/include/rdma/rdma_netlink.h
>> @@ -5,6 +5,7 @@
>>
>>   #include <linux/netlink.h>
>>   #include <uapi/rdma/rdma_netlink.h>
>> +#include <rdma/ib_verbs.h>
>>
>>   enum {
>>   	RDMA_NLDEV_ATTR_EMPTY_STRING = 1,
>> @@ -114,6 +115,7 @@ struct rdma_link_ops {
>>   	struct list_head list;
>>   	const char *type;
>>   	int (*newlink)(const char *ibdev_name, struct net_device *ndev);
>> +	int (*dellink)(struct ib_device *dev);
>>   };
>>
>>   void rdma_link_register(struct rdma_link_ops *ops);
>> --
>> 2.27.0
> 

