Return-Path: <linux-rdma+bounces-536-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB60823EEA
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jan 2024 10:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA101F2320D
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jan 2024 09:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6776C208D1;
	Thu,  4 Jan 2024 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VnEY2qwh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0668A208C2
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jan 2024 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704361870; x=1735897870;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=ViavYJEIIP5FH8BAk48ds/hllZfjIZ0qJZ++26wIdRQ=;
  b=VnEY2qwhvSKETwcrCt4pUFFdkVzYNcrhGcZQgfXn9eyN2W+pa1ey8b/s
   tI4XxIA4MycS1pJvNZaHMSsZOga9NpDQXb5OT6AMVqxvzW5kYPv984bJj
   X/eIZVj/Yhk+6VIE95JNCzeQgyCChAPEDgSpTZ4FxUVgW7wK3eEzpFvcl
   o=;
X-IronPort-AV: E=Sophos;i="6.04,330,1695686400"; 
   d="scan'208";a="695527182"
Subject: Re: [PATCH for-next v3] RDMA/efa: Add EFA query MR support
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-44b6fc51.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 09:50:47 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-44b6fc51.us-west-2.amazon.com (Postfix) with ESMTPS id 57ADCA0C41;
	Thu,  4 Jan 2024 09:50:46 +0000 (UTC)
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:61853]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.10.193:2525] with esmtp (Farcaster)
 id 4ef0f971-86a2-4e6d-97a6-dfce25f321b0; Thu, 4 Jan 2024 09:50:45 +0000 (UTC)
X-Farcaster-Flow-ID: 4ef0f971-86a2-4e6d-97a6-dfce25f321b0
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 4 Jan 2024 09:50:41 +0000
Received: from [192.168.135.168] (10.85.143.176) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 4 Jan 2024 09:50:37 +0000
Message-ID: <3ae9207f-1159-42e6-a972-0dfb085e9f82@amazon.com>
Date: Thu, 4 Jan 2024 11:50:33 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <leon@kernel.org>, <linux-rdma@vger.kernel.org>, <sleybo@amazon.com>,
	<matua@amazon.com>, <gal.pressman@linux.dev>, Anas Mousa
	<anasmous@amazon.com>, Firas Jahjah <firasj@amazon.com>
References: <20231211174715.7369-1-mrgolin@amazon.com>
 <20231211175019.GK2944114@nvidia.com>
 <c9790d7c-e904-4014-a238-343f376a08b9@amazon.com>
 <20240102234713.GL50406@nvidia.com>
 <d6394917-802d-4d37-8141-c4f462583943@amazon.com>
 <20240103133702.GN50406@nvidia.com>
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20240103133702.GN50406@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D046UWB001.ant.amazon.com (10.13.139.187) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 1/3/2024 3:37 PM, Jason Gunthorpe wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Wed, Jan 03, 2024 at 03:33:41PM +0200, Margolin, Michael wrote:
>
>> I would like it to be as opaque as possible but on the other hand to express
>> that the mentioned 'interconnect path' relates specifically to PCI path.
> Who cares it is a "PCI path" if the the thing is totally invisible? It
> is some hidden implementation detail of your device that today happens
> to be PCI.
>
> There are many ways to get interconnect multipath coming, including
> PCIe UIO.
>
> Jason

Ok, changed according to your suggestion.

Michael


