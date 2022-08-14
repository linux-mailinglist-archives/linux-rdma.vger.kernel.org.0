Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EE659204F
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Aug 2022 17:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiHNPFE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 14 Aug 2022 11:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiHNPFD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 14 Aug 2022 11:05:03 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EF419284
        for <linux-rdma@vger.kernel.org>; Sun, 14 Aug 2022 08:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660489503; x=1692025503;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hbOJJwbB0CHulqAs4i0V7FDy4WSPTN3/Iobrn0i26mk=;
  b=Vg3AR102Zyh+7lB4mRxTWU0W0UhIemP24RzgzURhQvp4vEli42rWbtYj
   XvZgDxYVb/L51ZwX1yzFnv9BJx6xmVJBORRwp+2lZyJHD80HjCWXQPnlh
   JOWYTWPOzQaLMRSJErXkzSNdJnD5LSHfLtwZ/y50NBSIz/czbcimVveOR
   A=;
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-8bf71a74.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 15:04:52 +0000
Received: from EX13D09EUC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-8bf71a74.us-east-1.amazon.com (Postfix) with ESMTPS id 7391AC1772;
        Sun, 14 Aug 2022 15:04:51 +0000 (UTC)
Received: from [192.168.93.210] (10.43.162.134) by
 EX13D09EUC002.ant.amazon.com (10.43.164.73) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Sun, 14 Aug 2022 15:04:47 +0000
Message-ID: <491d9db3-650d-fce5-a6ca-d44b2f55f3e8@amazon.com>
Date:   Sun, 14 Aug 2022 18:04:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH for-next] RDMA/efa: Support CQ receive entries with source
 GID
Content-Language: en-US
To:     Gal Pressman <gal.pressman@linux.dev>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "Jahjah, Firas" <firasj@amazon.com>,
        "Leybovich, Yossi" <sleybo@amazon.com>,
        "Kranzdorf, Daniel" <dkkranzd@amazon.com>
References: <20220809151636.788-1-mrgolin@amazon.com>
 <36725261-998d-63c2-bc0e-115157acb061@linux.dev>
From:   "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <36725261-998d-63c2-bc0e-115157acb061@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.134]
X-ClientProxiedBy: EX13D22UWC003.ant.amazon.com (10.43.162.250) To
 EX13D09EUC002.ant.amazon.com (10.43.164.73)
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/14/2022 2:38 PM, Gal Pressman wrote:
> On 09/08/2022 18:16, Michael Margolin wrote:
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
>>
>> diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
>> index 0b0b93b529f3..d4b9226088bd 100644
>> --- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
>> +++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
>> @@ -444,7 +444,10 @@ struct efa_admin_create_cq_cmd {
>>       /*
>>        * 4:0 : cq_entry_size_words - size of CQ entry in
>>        *    32-bit words, valid values: 4, 8.
>> -      * 7:5 : reserved7 - MBZ
>> +      * 5 : set_src_addr - If set, source address will be
>> +      *    filled on RX completions from unknown senders.
>> +      *    Requires 8 words CQ entry size.
>> +      * 7:6 : reserved7 - MBZ
>>        */
>>       u8 cq_caps_2;
>>
>> @@ -980,6 +983,7 @@ struct efa_admin_host_info {
>>  #define EFA_ADMIN_CREATE_CQ_CMD_INTERRUPT_MODE_ENABLED_MASK BIT(5)
>>  #define EFA_ADMIN_CREATE_CQ_CMD_VIRT_MASK                   BIT(6)
>>  #define EFA_ADMIN_CREATE_CQ_CMD_CQ_ENTRY_SIZE_WORDS_MASK    GENMASK(4, 0)
>> +#define EFA_ADMIN_CREATE_CQ_CMD_SET_SRC_ADDR_MASK           BIT(5)
>>
>>  /* create_cq_resp */
>>  #define EFA_ADMIN_CREATE_CQ_RESP_DB_VALID_MASK              BIT(0)
>> diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
>> index fb405da4e1db..8f8885e002ba 100644
>> --- a/drivers/infiniband/hw/efa/efa_com_cmd.c
>> +++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
>> @@ -168,7 +168,10 @@ int efa_com_create_cq(struct efa_com_dev *edev,
>>                       EFA_ADMIN_CREATE_CQ_CMD_INTERRUPT_MODE_ENABLED, 1);
>>               create_cmd.eqn = params->eqn;
>>       }
>> -
>> +     if (params->set_src_addr) {
>> +             EFA_SET(&create_cmd.cq_caps_2,
>> +                     EFA_ADMIN_CREATE_CQ_CMD_SET_SRC_ADDR, 1);
>> +     }
> Don't you need to validate the CQE size requested by the user somewhere?
> I assume you must use 32 bytes completions for this.

This is a good point. Requested CQE size is validated against command
feature bits in the device FW. In a case of user requesting for a wrong
or unsupported configuration efa_com_cmd_exec() will return an
appropriate error code. This is to avoid driver dependency on CQE
structure or size.


Michael

