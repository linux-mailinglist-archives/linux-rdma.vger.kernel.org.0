Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617AA1CDA6F
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 14:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgEKMsM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 08:48:12 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:54711 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgEKMsM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 May 2020 08:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589201291; x=1620737291;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=uVPg/SoG6p6LREkJ54nRBJdoZ3bGNUQwTTMWL8yFLvc=;
  b=Fs9K0NZ5t0d6cqGlwXzeMSBw/2aQpSJKCtLbPYsQWX4clPt1BRsYid6z
   kIRvXEawL4M0h/4gIVtHa9g3w+SI9apBE13hp2/KUaZySfWoRl+76oT/d
   +GERWwPH6wc8oyXG/vcGrTX5HoEcEFbSqLw3Ct/1FPnwxckhnMytfUK/o
   A=;
IronPort-SDR: E9I9qdMIHPAV2oEe4R1Uy2Nl9k66B0Cg3e0yRCAy1AKDgffsfYMiQG/Squ86RlRxQ96atanod3
 CkOAFqjKwjsA==
X-IronPort-AV: E=Sophos;i="5.73,380,1583193600"; 
   d="scan'208";a="43933899"
Received: from sea32-co-svc-lb4-vlan2.sea.corp.amazon.com (HELO email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.47.23.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 11 May 2020 12:48:09 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (Postfix) with ESMTPS id C0AE2A18BF;
        Mon, 11 May 2020 12:48:07 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 11 May 2020 12:48:07 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.247) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 11 May 2020 12:48:02 +0000
Subject: Re: [PATCH for-next 2/2] RDMA/efa: Report host information to the
 device
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        "Firas JahJah" <firasj@amazon.com>, Guy Tzalik <gtzalik@amazon.com>
References: <20200510115918.46246-1-galpress@amazon.com>
 <20200510115918.46246-3-galpress@amazon.com> <20200510122949.GB199306@unreal>
 <5612e79f-76e5-7f87-8321-5114d414015e@amazon.com>
 <20200510151622.GD199306@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <2f15e2fb-22d2-2d8e-50f0-9fa7964f7104@amazon.com>
Date:   Mon, 11 May 2020 15:47:57 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200510151622.GD199306@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.247]
X-ClientProxiedBy: EX13D32UWB004.ant.amazon.com (10.43.161.36) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/05/2020 18:16, Leon Romanovsky wrote:
> On Sun, May 10, 2020 at 04:05:45PM +0300, Gal Pressman wrote:
>> On 10/05/2020 15:29, Leon Romanovsky wrote:
>>> On Sun, May 10, 2020 at 02:59:18PM +0300, Gal Pressman wrote:
>>>> diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
>>>> index 96b104ab5415..efdeebc9ea9b 100644
>>>> --- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
>>>> +++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
>>>> @@ -37,7 +37,7 @@ enum efa_admin_aq_feature_id {
>>>>  	EFA_ADMIN_NETWORK_ATTR                      = 3,
>>>>  	EFA_ADMIN_QUEUE_ATTR                        = 4,
>>>>  	EFA_ADMIN_HW_HINTS                          = 5,
>>>> -	EFA_ADMIN_FEATURES_OPCODE_NUM               = 8,
>>>> +	EFA_ADMIN_HOST_INFO                         = 6,
>>>>  };
>>>>
>>>>  /* QP transport type */
>>>> @@ -799,6 +799,55 @@ struct efa_admin_mmio_req_read_less_resp {
>>>>  	u32 reg_val;
>>>>  };
>>>>
>>>> +enum efa_admin_os_type {
>>>> +	EFA_ADMIN_OS_LINUX                          = 0,
>>>> +	EFA_ADMIN_OS_WINDOWS                        = 1,
>>>
>>> Not used.
>>
>> That's the device interface..
> 
> It doesn't matter, we don't add code/defines that are not in use.

First of all, that's not true, look at mlx5 device spec for example.
It's 10k lines long and has many unused values..

I don't think we should go as far as commits like 1759d322f4ba ("net/mlx5: Add
hardware definitions for sub functions") which adds new commands interface
without implementing it (nor does any following patch), but exposing the related
bits directly in the scope of the feature that's being introduced is different.

The driver version fields that you don't like are going to stay there as they're
the device ABI, and IMHO "hiding" them as reserved has zero upsides and won't
change the fact that they're unused.
