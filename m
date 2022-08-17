Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC29596E45
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Aug 2022 14:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbiHQMSb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Aug 2022 08:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236698AbiHQMSa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Aug 2022 08:18:30 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5E133379
        for <linux-rdma@vger.kernel.org>; Wed, 17 Aug 2022 05:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660738708; x=1692274708;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=04zyyO0sPL9KiuZOzvxcZXRwJluabb0Bsc2KNxTS0Lg=;
  b=KJDd/9vhShomcu8Z/agYmUxGECBZ2/eEGTr2ldV2Ol6W5fPPo+Ofls7Z
   mgnzC1qkQhWQ2lAvV+7rfe+6ZGldy7F0YrXXYR0u81sa8Iqbf0L+jrDkx
   XyevzJeJf7ALKn0wKG44N7Iea4bPBbolw/Kk2gWMmNSX3mRkmLtNjQmA1
   c=;
X-IronPort-AV: E=Sophos;i="5.93,243,1654560000"; 
   d="scan'208";a="1045211726"
Subject: Re: [PATCH for-next] RDMA/efa: Support CQ receive entries with source GID
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-35b1f9a2.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 12:18:11 +0000
Received: from EX13D09EUC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-35b1f9a2.us-east-1.amazon.com (Postfix) with ESMTPS id 11290201292;
        Wed, 17 Aug 2022 12:18:09 +0000 (UTC)
Received: from [192.168.92.243] (10.43.160.201) by
 EX13D09EUC002.ant.amazon.com (10.43.164.73) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 17 Aug 2022 12:18:06 +0000
Message-ID: <a096d37b-e636-d621-8065-195d7cba627c@amazon.com>
Date:   Wed, 17 Aug 2022 15:18:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Jahjah, Firas" <firasj@amazon.com>,
        "Leybovich, Yossi" <sleybo@amazon.com>,
        "Kranzdorf, Daniel" <dkkranzd@amazon.com>
References: <20220809151636.788-1-mrgolin@amazon.com>
 <YvuiKpvLtBvKVhkO@unreal>
From:   "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <YvuiKpvLtBvKVhkO@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.201]
X-ClientProxiedBy: EX13D27UWA001.ant.amazon.com (10.43.160.19) To
 EX13D09EUC002.ant.amazon.com (10.43.164.73)
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 8/16/2022 4:56 PM, Leon Romanovsky wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Tue, Aug 09, 2022 at 06:16:36PM +0300, Michael Margolin wrote:
>> Add a parameter for create CQ admin command to set source address on
>> receive completion descriptors. Report capability for this feature
>> through query device verb.
>>
>> Reviewed-by: Firas Jahjah <firasj@amazon.com>
>> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
>> Signed-off-by: Daniel Kranzdorf <dkkranzd@amazon.com>
>> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
>> ---
>>  drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 6 +++++-
>>  drivers/infiniband/hw/efa/efa_com_cmd.c         | 5 ++++-
>>  drivers/infiniband/hw/efa/efa_com_cmd.h         | 1 +
>>  drivers/infiniband/hw/efa/efa_verbs.c           | 4 +++-
>>  include/uapi/rdma/efa-abi.h                     | 4 +++-
>>  5 files changed, 16 insertions(+), 4 deletions(-)
> <...>
>
>> diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
>> index c33010bbf9e8..c6234336543d 100644
>> --- a/drivers/infiniband/hw/efa/efa_com_cmd.h
>> +++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
>> @@ -76,6 +76,7 @@ struct efa_com_create_cq_params {
>>       u16 eqn;
>>       u8 entry_size_in_bytes;
>>       bool interrupt_mode_enabled;
>> +     bool set_src_addr;
> Please use "u8 xxx : 1" instead of bool in structs.
>
> Thanks

Thanks Leon for your reply.

Is this a convention in the subsystem? This is an internal struct used
only to bind several variables for a function call and I think using
bool makes it more readable.

Of course if it's essential I will change this.


Michael

