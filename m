Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BE65983F3
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Aug 2022 15:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243265AbiHRNRx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Aug 2022 09:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242785AbiHRNRw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Aug 2022 09:17:52 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B7F844C7
        for <linux-rdma@vger.kernel.org>; Thu, 18 Aug 2022 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660828669; x=1692364669;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fb+ANQOc/neq3dsheXNt3PPcSOrjHV5ttaVH4C74tAg=;
  b=i619vsYFZnbUuG9W8+doNaN89rbYEM9s2YEcR63H2ZMpucpa7VUZR64I
   Wy8eOn6WFPWVthfnUU6CaDYgHCi34DzPTtq6h4UM7nlvZTRolwXq0b54D
   46vOv3so90E5ZtgoI2c7ZqRwjlBHBdlCBtsKnLgMUaUiIEfKG/XgJcB6T
   Y=;
X-IronPort-AV: E=Sophos;i="5.93,246,1654560000"; 
   d="scan'208";a="231145967"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-8be8ed69.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 13:17:35 +0000
Received: from EX13D09EUC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-8be8ed69.us-east-1.amazon.com (Postfix) with ESMTPS id 393A5C0A8F;
        Thu, 18 Aug 2022 13:17:33 +0000 (UTC)
Received: from [10.218.51.17] (10.43.162.158) by EX13D09EUC002.ant.amazon.com
 (10.43.164.73) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Thu, 18 Aug
 2022 13:17:30 +0000
Message-ID: <744b1b25-a508-c624-cabe-1623059afd95@amazon.com>
Date:   Thu, 18 Aug 2022 16:17:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH for-next] RDMA/efa: Support CQ receive entries with source
 GID
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Jahjah, Firas" <firasj@amazon.com>,
        "Leybovich, Yossi" <sleybo@amazon.com>,
        "Kranzdorf, Daniel" <dkkranzd@amazon.com>
References: <20220809151636.788-1-mrgolin@amazon.com>
 <YvuiKpvLtBvKVhkO@unreal> <a096d37b-e636-d621-8065-195d7cba627c@amazon.com>
 <YvzfN6Ns7iaUmyGa@nvidia.com>
Content-Language: en-US
From:   "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <YvzfN6Ns7iaUmyGa@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.158]
X-ClientProxiedBy: EX13D18UWC002.ant.amazon.com (10.43.162.88) To
 EX13D09EUC002.ant.amazon.com (10.43.164.73)
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 8/17/2022 3:29 PM, Jason Gunthorpe wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Wed, Aug 17, 2022 at 03:18:01PM +0300, Margolin, Michael wrote:
>> On 8/16/2022 4:56 PM, Leon Romanovsky wrote:
>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>>
>>>
>>>
>>> On Tue, Aug 09, 2022 at 06:16:36PM +0300, Michael Margolin wrote:
>>>> Add a parameter for create CQ admin command to set source address on
>>>> receive completion descriptors. Report capability for this feature
>>>> through query device verb.
>>>>
>>>> Reviewed-by: Firas Jahjah <firasj@amazon.com>
>>>> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
>>>> Signed-off-by: Daniel Kranzdorf <dkkranzd@amazon.com>
>>>> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
>>>> ---
>>>>  drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 6 +++++-
>>>>  drivers/infiniband/hw/efa/efa_com_cmd.c         | 5 ++++-
>>>>  drivers/infiniband/hw/efa/efa_com_cmd.h         | 1 +
>>>>  drivers/infiniband/hw/efa/efa_verbs.c           | 4 +++-
>>>>  include/uapi/rdma/efa-abi.h                     | 4 +++-
>>>>  5 files changed, 16 insertions(+), 4 deletions(-)
>>> <...>
>>>
>>>> diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
>>>> index c33010bbf9e8..c6234336543d 100644
>>>> --- a/drivers/infiniband/hw/efa/efa_com_cmd.h
>>>> +++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
>>>> @@ -76,6 +76,7 @@ struct efa_com_create_cq_params {
>>>>       u16 eqn;
>>>>       u8 entry_size_in_bytes;
>>>>       bool interrupt_mode_enabled;
>>>> +     bool set_src_addr;
>>> Please use "u8 xxx : 1" instead of bool in structs.
>>>
>>> Thanks
>> Thanks Leon for your reply.
>>
>> Is this a convention in the subsystem? This is an internal struct used
>> only to bind several variables for a function call and I think using
>> bool makes it more readable.
>>
>> Of course if it's essential I will change this.
> You should use bool xx:1 in cases like this and join all the bools in
> your struct into a bitfield - unless you can justify them being split
> eg due to needing a READ_ONCE/etc or something
>
> This is expected across the kernel.
>
> Jason

Thank you for your clarification, seems reasonable to me.

Sending v2 patch with all the requested changes.


Michael

