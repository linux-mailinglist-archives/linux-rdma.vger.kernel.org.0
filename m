Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7603CD5EF
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jul 2021 15:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbhGSNCE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jul 2021 09:02:04 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:21105 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239599AbhGSNB4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Jul 2021 09:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1626702156; x=1658238156;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=7Mw7rEbDLp0kc96L8ADYqch5cIwwGN/wenVsiNSdaT4=;
  b=qKf1AzZsMLyGRsvYKnEXzNmpaaaBOYz4pCupXuPUWM1V/SfvxaX5YlbQ
   BWml+Rq5kNjoa4lc2DPDNUVreHHhn4wBOJZxqKW44Q2E8jc7GNZ5Ev+uA
   ag9HqXdCvWnDiSf1hM+FSPOSQgzOF9iEIpzZfyjVoXw+aH4AF1ug0wTIo
   Q=;
X-IronPort-AV: E=Sophos;i="5.84,252,1620691200"; 
   d="scan'208";a="146396045"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-2a-6c5d6e09.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 19 Jul 2021 13:42:28 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-6c5d6e09.us-west-2.amazon.com (Postfix) with ESMTPS id AE304A4AD8;
        Mon, 19 Jul 2021 13:42:26 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.160.85) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Mon, 19 Jul 2021 13:42:16 +0000
Subject: Re: [PATCH rdma-next 8/9] RDMA: Globally allocate and release QP
 memory
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
References: <cover.1626609283.git.leonro@nvidia.com>
 <5b3bff16da4b6f925c872594262cd8ed72b301cd.1626609283.git.leonro@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <abfc0d32-eab8-97d4-5734-508b6c46fe98@amazon.com>
Date:   Mon, 19 Jul 2021 16:42:11 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5b3bff16da4b6f925c872594262cd8ed72b301cd.1626609283.git.leonro@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.85]
X-ClientProxiedBy: EX13D18UWC003.ant.amazon.com (10.43.162.237) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 18/07/2021 15:00, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Convert QP object to follow IB/core general allocation scheme.
> That change allows us to make sure that restrack properly kref
> the memory.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

EFA and core parts look good to me.
Reviewed-by: Gal Pressman <galpress@amazon.com>
Tested-by: Gal Pressman <galpress@amazon.com>

> +static inline void *rdma_zalloc_obj(struct ib_device *dev, size_t size,
> +				    gfp_t gfp, bool is_numa_aware)
> +{
> +	if (is_numa_aware && dev->ops.get_numa_node)

Honestly I think it's better to return an error if a numa aware allocation is
requested and get_numa_node is not provided.

> +		return kzalloc_node(size, gfp, dev->ops.get_numa_node(dev));
> +
> +	return kzalloc(size, gfp);
> +}
