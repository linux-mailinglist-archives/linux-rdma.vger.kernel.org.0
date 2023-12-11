Return-Path: <linux-rdma+bounces-373-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0DD80D45F
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 18:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9248B2151E
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 17:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55CF4E63F;
	Mon, 11 Dec 2023 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Z9CY9ZQs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86ADC8
	for <linux-rdma@vger.kernel.org>; Mon, 11 Dec 2023 09:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702316820; x=1733852820;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=7ioG+Mv61p8XpnO01tZ/Xq2061H7UKGKfJlCOsOYhv0=;
  b=Z9CY9ZQsHWYxb5ujPA4TC7QplSWamCPnXBrTsDklmfxQScIU5sljNrKX
   qt1CdkZZc7lOnLSd/1gEZpOcICA03lDWfv6XdNXRhNfN/rmQr9zQLASKJ
   oaR7MKorVnX0+2ewRE5Sz6gN24Ic40vI1djZd53k0FwZmorCUriwBRHyq
   k=;
X-IronPort-AV: E=Sophos;i="6.04,268,1695686400"; 
   d="scan'208";a="624550014"
Subject: Re: [PATCH for-next v2] RDMA/efa: Add EFA query MR support
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 17:46:57 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id 18A19895D8;
	Mon, 11 Dec 2023 17:46:56 +0000 (UTC)
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:27571]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.6.151:2525] with esmtp (Farcaster)
 id 9214a2b1-6867-4635-96f9-a48185b83051; Mon, 11 Dec 2023 17:46:55 +0000 (UTC)
X-Farcaster-Flow-ID: 9214a2b1-6867-4635-96f9-a48185b83051
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 17:46:49 +0000
Received: from [192.168.130.6] (10.85.143.179) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 17:46:45 +0000
Message-ID: <f0c9275f-130a-478e-86d2-865349606bcf@amazon.com>
Date: Mon, 11 Dec 2023 19:46:40 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, <sleybo@amazon.com>,
	<matua@amazon.com>, <gal.pressman@linux.dev>, Anas Mousa
	<anasmous@amazon.com>, Firas Jahjah <firasj@amazon.com>
References: <20231207142748.10345-1-mrgolin@amazon.com>
 <20231211081032.GB4870@unreal>
 <c9bfd0e3-3640-46da-8a9b-4391c90ed1aa@amazon.com>
 <20231211112623.GE4870@unreal>
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20231211112623.GE4870@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 12/11/2023 1:26 PM, Leon Romanovsky wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Mon, Dec 11, 2023 at 12:35:34PM +0200, Margolin, Michael wrote:
>> On 12/11/2023 10:10 AM, Leon Romanovsky wrote:
>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>>
>>>
>>>
>>> On Thu, Dec 07, 2023 at 02:27:48PM +0000, Michael Margolin wrote:
>>>> Add EFA driver uapi definitions and register a new query MR method that
>>>> currently returns the physical PCI buses' IDs the device is using to
>>>> reach the MR. Update admin definitions and efa-abi accordingly.
>>>>
>>>> Reviewed-by: Anas Mousa <anasmous@amazon.com>
>>>> Reviewed-by: Firas Jahjah <firasj@amazon.com>
>>>> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
>>>> ---
>>>>  drivers/infiniband/hw/efa/efa.h               |  5 +-
>>>>  .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 31 ++++++++
>>>>  drivers/infiniband/hw/efa/efa_com_cmd.c       |  6 ++
>>>>  drivers/infiniband/hw/efa/efa_com_cmd.h       |  4 +
>>>>  drivers/infiniband/hw/efa/efa_main.c          |  5 ++
>>>>  drivers/infiniband/hw/efa/efa_verbs.c         | 77 +++++++++++++++++++
>>>>  include/uapi/rdma/efa-abi.h                   | 19 +++++
>>>>  7 files changed, 146 insertions(+), 1 deletion(-)
>>> <...>
>>>
>>>> +     /*
>>>> +      * Mask indicating which fields have valid values
>>>> +      * 0 : recv_pci_bus_id
>>>> +      * 1 : rdma_read_pci_bus_id
>>>> +      * 2 : rdma_recv_pci_bus_id
>>>> +      */
>>>> +     u8 validity;
>>> <...>
>>>
>>>>  #define EFA_GID_SIZE 16
>>>> +#define EFA_INVALID_PCI_BUS_ID 0xffff
>>> Is 0xffff value guaranteed by PCI subsystem to be invalid? Why don't you
>>> provide "validity" field to userspace instead?
>> The 0xffff value in only used internally in the driver to indicate an
>> invalid id and isn't exposed to userspace. For userspace there is a
>> validity field as you suggested:
>>
>> +       return uverbs_copy_to(attrs,
>> EFA_IB_ATTR_QUERY_MR_RESP_PCI_BUS_ID_VALIDITY,
>> +                             &pci_bus_id_validity,
>> sizeof(pci_bus_id_validity));
> So please rely on your EFA_GET(&cmd_completion.validity, EFA_ADMIN_XXX_PCI_BUS_ID)
> checks when you fill pci_bus_id_validity and not on 0xffff value which can be
> valid from PCI perspective.
>
> Thanks

0xffff can't practically be a valid PCI id in this context, but anyway
changed to use validity fields through all the code to be clear on that
andto be more consistent. Sending v3 patch.

Thanks


