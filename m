Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF2D59297A
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Aug 2022 08:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240419AbiHOGSa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Aug 2022 02:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiHOGSI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 15 Aug 2022 02:18:08 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D15E1A05B
        for <linux-rdma@vger.kernel.org>; Sun, 14 Aug 2022 23:18:06 -0700 (PDT)
Message-ID: <83de3270-220a-b08c-a969-dbd292553288@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660544284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10OZ8CCdQQDxpKRFMYxG7FT2N4YatHRf5zOxl2Gw8vY=;
        b=VRbgzkHpOvy18NGEH8gU/HCClQToM7MezyukxOvpXYAYOF++DwrZY7TlznECqoddMJB9MR
        WZtyowfdjc04RKyOiU86VH56viK6ZoldZsplXEO5vs1eGVBVFRXwFVq/IESzSOYBcmlBuD
        kJxYd5YXkYOhXS0fILnbpZ73imoxVXw=
Date:   Mon, 15 Aug 2022 09:17:54 +0300
MIME-Version: 1.0
Subject: Re: [PATCH for-next] RDMA/efa: Support CQ receive entries with source
 GID
Content-Language: en-US
To:     "Margolin, Michael" <mrgolin@amazon.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     "Jahjah, Firas" <firasj@amazon.com>,
        "Leybovich, Yossi" <sleybo@amazon.com>,
        "Kranzdorf, Daniel" <dkkranzd@amazon.com>
References: <20220809151636.788-1-mrgolin@amazon.com>
 <36725261-998d-63c2-bc0e-115157acb061@linux.dev>
 <491d9db3-650d-fce5-a6ca-d44b2f55f3e8@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Gal Pressman <gal.pressman@linux.dev>
In-Reply-To: <491d9db3-650d-fce5-a6ca-d44b2f55f3e8@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 14/08/2022 18:04, Margolin, Michael wrote:
> On 8/14/2022 2:38 PM, Gal Pressman wrote:
>> On 09/08/2022 18:16, Michael Margolin wrote:
>>> Add a parameter for create CQ admin command to set source address on
>>> receive completion descriptors. Report capability for this feature
>>> through query device verb.
>>>
>>> Reviewed-by: Firas Jahjah <firasj@amazon.com>
>>> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
>>> Signed-off-by: Daniel Kranzdorf <dkkranzd@amazon.com>
>>> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
>>> ---
>>>  drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 6 +++++-
>>>  drivers/infiniband/hw/efa/efa_com_cmd.c         | 5 ++++-
>>>  drivers/infiniband/hw/efa/efa_com_cmd.h         | 1 +
>>>  drivers/infiniband/hw/efa/efa_verbs.c           | 4 +++-
>>>  include/uapi/rdma/efa-abi.h                     | 4 +++-
>>>  5 files changed, 16 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
>>> index 0b0b93b529f3..d4b9226088bd 100644
>>> --- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
>>> +++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
>>> @@ -444,7 +444,10 @@ struct efa_admin_create_cq_cmd {
>>>       /*
>>>        * 4:0 : cq_entry_size_words - size of CQ entry in
>>>        *    32-bit words, valid values: 4, 8.
>>> -      * 7:5 : reserved7 - MBZ
>>> +      * 5 : set_src_addr - If set, source address will be
>>> +      *    filled on RX completions from unknown senders.
>>> +      *    Requires 8 words CQ entry size.
>>> +      * 7:6 : reserved7 - MBZ
>>>        */
>>>       u8 cq_caps_2;
>>>
>>> @@ -980,6 +983,7 @@ struct efa_admin_host_info {
>>>  #define EFA_ADMIN_CREATE_CQ_CMD_INTERRUPT_MODE_ENABLED_MASK BIT(5)
>>>  #define EFA_ADMIN_CREATE_CQ_CMD_VIRT_MASK                   BIT(6)
>>>  #define EFA_ADMIN_CREATE_CQ_CMD_CQ_ENTRY_SIZE_WORDS_MASK    GENMASK(4, 0)
>>> +#define EFA_ADMIN_CREATE_CQ_CMD_SET_SRC_ADDR_MASK           BIT(5)
>>>
>>>  /* create_cq_resp */
>>>  #define EFA_ADMIN_CREATE_CQ_RESP_DB_VALID_MASK              BIT(0)
>>> diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
>>> index fb405da4e1db..8f8885e002ba 100644
>>> --- a/drivers/infiniband/hw/efa/efa_com_cmd.c
>>> +++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
>>> @@ -168,7 +168,10 @@ int efa_com_create_cq(struct efa_com_dev *edev,
>>>                       EFA_ADMIN_CREATE_CQ_CMD_INTERRUPT_MODE_ENABLED, 1);
>>>               create_cmd.eqn = params->eqn;
>>>       }
>>> -
>>> +     if (params->set_src_addr) {
>>> +             EFA_SET(&create_cmd.cq_caps_2,
>>> +                     EFA_ADMIN_CREATE_CQ_CMD_SET_SRC_ADDR, 1);
>>> +     }
>> Don't you need to validate the CQE size requested by the user somewhere?
>> I assume you must use 32 bytes completions for this.
> This is a good point. Requested CQE size is validated against command
> feature bits in the device FW. In a case of user requesting for a wrong
> or unsupported configuration efa_com_cmd_exec() will return an
> appropriate error code. This is to avoid driver dependency on CQE
> structure or size.
>
>
> Michael
>

The driver usually terminates bad inputs before they get to the device
to prevent unnecessary noise.
As of today, command failures are unexpected so we have a ibdev_err to
indicate that something went very wrong, I don't think you want to allow
a non-root user to flood your device (and dmesg) with errors.
