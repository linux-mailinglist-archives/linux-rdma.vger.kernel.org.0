Return-Path: <linux-rdma+bounces-558-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3AF826DC1
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 13:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16131C22408
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 12:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094093FE59;
	Mon,  8 Jan 2024 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lTWz1AL+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7886D3FE5A
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jan 2024 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704716723; x=1736252723;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=qpP3EtV3VIIbrAXlZuWzvlu80XfOPiwteeioMtCKzQQ=;
  b=lTWz1AL+fA4SIg2onHvxwXSOkCVbqQj0xytUGRSbqfsu+fI96CBWuoc2
   HX+dShh+YXIiRg0BWudFAE6D3hHvrXyBGQ4o7x35oXdHkYg4+xbsRR6dY
   5oEh/pxnheFVDIDh9azgN/+3WRRWcWm9MNFULFFFlrMOleFKwUd1WNpNN
   Y=;
X-IronPort-AV: E=Sophos;i="6.04,341,1695686400"; 
   d="scan'208";a="388294698"
Subject: Re: [PATCH for-next v4] RDMA/efa: Add EFA query MR support
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 12:25:18 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id DA1CA8AE82;
	Mon,  8 Jan 2024 12:25:17 +0000 (UTC)
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:50280]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.10.193:2525] with esmtp (Farcaster)
 id 26bd2c88-b333-47af-adb0-df611c187a4e; Mon, 8 Jan 2024 12:25:16 +0000 (UTC)
X-Farcaster-Flow-ID: 26bd2c88-b333-47af-adb0-df611c187a4e
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jan 2024 12:25:16 +0000
Received: from [192.168.136.44] (10.85.143.179) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jan 2024 12:25:13 +0000
Message-ID: <db768ebc-ebd5-40c4-ae68-a1f552d390a1@amazon.com>
Date: Mon, 8 Jan 2024 14:25:08 +0200
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
References: <20240104095155.10676-1-mrgolin@amazon.com>
 <20240107100256.GA12803@unreal>
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20240107100256.GA12803@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)

Thanks Leon.

On 1/7/2024 12:02 PM, Leon Romanovsky wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Thu, Jan 04, 2024 at 09:51:55AM +0000, Michael Margolin wrote:
>> Add EFA driver uapi definitions and register a new query MR method that
>> currently returns the physical interconnects the device is using to
>> reach the MR. Update admin definitions and efa-abi accordingly.
>>
>> Reviewed-by: Anas Mousa <anasmous@amazon.com>
>> Reviewed-by: Firas Jahjah <firasj@amazon.com>
>> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
>> ---
>>  drivers/infiniband/hw/efa/efa.h               | 12 +++-
>>  .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 33 ++++++++-
>>  drivers/infiniband/hw/efa/efa_com_cmd.c       | 11 ++-
>>  drivers/infiniband/hw/efa/efa_com_cmd.h       | 12 +++-
>>  drivers/infiniband/hw/efa/efa_main.c          |  7 +-
>>  drivers/infiniband/hw/efa/efa_verbs.c         | 71 ++++++++++++++++++-
>>  include/uapi/rdma/efa-abi.h                   | 21 +++++-
>>  7 files changed, 160 insertions(+), 7 deletions(-)
> It is already fourth version of this patch and not a single word about
> the changes. Please add changelog in your next submissions.
>
> Applied this patch with the following change.
>
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index 8f4435706e4d..2f412db2edcd 100644
> --- a/drivers/infiniband/hw/efa/efa_verbs.c
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -1748,7 +1748,7 @@ static int UVERBS_HANDLER(EFA_IB_METHOD_MR_QUERY)(struct uverbs_attr_bundle *att
>  {
>         struct ib_mr *ibmr = uverbs_attr_get_obj(attrs, EFA_IB_ATTR_QUERY_MR_HANDLE);
>         struct efa_mr *mr = to_emr(ibmr);
> -       u16 ic_id_validity;
> +       u16 ic_id_validity = 0;
>         int ret;
>
>         ret = uverbs_copy_to(attrs, EFA_IB_ATTR_QUERY_MR_RESP_RECV_IC_ID,
> @@ -1766,12 +1766,12 @@ static int UVERBS_HANDLER(EFA_IB_METHOD_MR_QUERY)(struct uverbs_attr_bundle *att
>         if (ret)
>                 return ret;
>
> -       ic_id_validity = (mr->ic_info.recv_ic_id_valid ?
> -                         EFA_QUERY_MR_VALIDITY_RECV_IC_ID : 0) |
> -                        (mr->ic_info.rdma_read_ic_id_valid ?
> -                         EFA_QUERY_MR_VALIDITY_RDMA_READ_IC_ID : 0) |
> -                        (mr->ic_info.rdma_recv_ic_id_valid ?
> -                         EFA_QUERY_MR_VALIDITY_RDMA_RECV_IC_ID : 0);
> +       if (mr->ic_info.recv_ic_id_valid)
> +               ic_id_validity |= EFA_QUERY_MR_VALIDITY_RECV_IC_ID;
> +       if (mr->ic_info.rdma_read_ic_id_valid)
> +               ic_id_validity |= EFA_QUERY_MR_VALIDITY_RDMA_READ_IC_ID;
> +       if (mr->ic_info.rdma_recv_ic_id_valid)
> +               ic_id_validity |= EFA_QUERY_MR_VALIDITY_RDMA_RECV_IC_ID;
>
>         return uverbs_copy_to(attrs, EFA_IB_ATTR_QUERY_MR_RESP_IC_ID_VALIDITY,
>                               &ic_id_validity, sizeof(ic_id_validity));
>

