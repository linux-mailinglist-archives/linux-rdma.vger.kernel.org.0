Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3101B9A9A
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 10:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgD0Ipo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 04:45:44 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:14785 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgD0Ipo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Apr 2020 04:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587977144; x=1619513144;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=hCHxfjvRBeHA5K+4j1k1UXzR2Cb8xWU8MbKfbNsgJL8=;
  b=Iaf3L/2vQZh66UWQdSXDI/3naiwBJdW4/CIhcOpIeYZ1ncfe4BIO0Jpw
   uVaomn0yIBJNZ2SIPjKTWFkZCco1JSpmarkwthfjFOYZJqRre9Jl3qRzQ
   WMxV7O3dxf2oT0+WhYIQGppTr9a8NpByxyyqdnsFuPD+O2dBzxJ3RZyAl
   w=;
IronPort-SDR: SeWXiGykPaqUqEPqk9KQpUTMgLPM+WlG8VPf+DKo4tWU9FxOlmQNSpDdHDKxLiwLKaMsMJsiw4
 fg4/VyN9pZ2A==
X-IronPort-AV: E=Sophos;i="5.73,323,1583193600"; 
   d="scan'208";a="41039571"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 27 Apr 2020 08:45:41 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id AD911A2147;
        Mon, 27 Apr 2020 08:45:39 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 27 Apr 2020 08:45:38 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.8) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 27 Apr 2020 08:45:26 +0000
Subject: Re: [PATCH for-next] RDMA/core: Assign the name of device when
 allocating ib_device
To:     Weihang Li <liweihang@huawei.com>, <dledford@redhat.com>,
        <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, <selvin.xavier@broadcom.com>,
        <devesh.sharma@broadcom.com>, <somnath.kotur@broadcom.com>,
        <sriharsha.basavapatna@broadcom.com>, <bharat@chelsio.com>,
        <sleybo@amazon.com>, <faisal.latif@intel.com>,
        <shiraz.saleem@intel.com>, <yishaih@mellanox.com>,
        <mkalderon@marvell.com>, <aelior@marvell.com>, <benve@cisco.com>,
        <neescoba@cisco.com>, <pkaustub@cisco.com>, <aditr@vmware.com>,
        <pv-drivers@vmware.com>, <monis@mellanox.com>,
        <kamalheib1@gmail.com>, <parav@mellanox.com>, <markz@mellanox.com>,
        <rd.dunlab@gmail.com>, <dennis.dalessandro@intel.com>
References: <1587893517-11824-1-git-send-email-liweihang@huawei.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <cf1dc2dd-89e5-2fcc-845f-925fb531adc1@amazon.com>
Date:   Mon, 27 Apr 2020 11:45:21 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587893517-11824-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.8]
X-ClientProxiedBy: EX13D11UWB002.ant.amazon.com (10.43.161.20) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 26/04/2020 12:31, Weihang Li wrote:
> If the name of a device is assigned during ib_register_device(), some
> drivers have to use dev_*() for printing before register device. Bring
> assign_name() into ib_alloc_device(), so that drivers can use ibdev_*()
> anywhere.
> 
> Signed-off-by: Weihang Li <liweihang@huawei.com>

Reviewed-by: Gal Pressman <galpress@amazon.com>

[...]

> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 2a8c389..5560d79 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -6017,7 +6017,7 @@ static int __hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
>  	struct hns_roce_dev *hr_dev;
>  	int ret;
>  
> -	hr_dev = ib_alloc_device(hns_roce_dev, ib_dev);
> +	hr_dev = ib_alloc_device(hns_roce_dev, ib_dev, "hns%d");

This name is missing an underscore.
As some of the drivers now pass the name in two call sites, it's better to
define it in one place in order to prevent mistakes like these.
