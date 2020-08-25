Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2C22513E4
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 10:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgHYINY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 04:13:24 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:32928 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgHYINY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Aug 2020 04:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598343204; x=1629879204;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=EjecvEs2Ij1SRjS290w5qqjFbraqr0rvt5Kv9VUZ9kI=;
  b=c0cUmVwd6J7bnvIpfwJdDI5uhwyTWsTsyU/CLbbtSzdpG1yFF66p3VZv
   kCegiyWkchuDwNb2EuUTT3k8z+X+p0Wtb4GYO66DINfHaubbFm4y+/FXN
   6xctC24aE3qKvIwhUzB5sFK3G3dlUhmhXkde579ATEJSdZq/du0BkV0Rr
   k=;
X-IronPort-AV: E=Sophos;i="5.76,351,1592870400"; 
   d="scan'208";a="49733277"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 25 Aug 2020 08:13:21 +0000
Received: from EX13D19EUB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS id C36AFA20D7;
        Tue, 25 Aug 2020 08:13:18 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.55) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 25 Aug 2020 08:13:08 +0000
Subject: Re: [PATCH rdma-next 02/10] RDMA: Restore ability to fail on AH
 destroy
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Lijun Ou <oulijun@huawei.com>, <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
References: <20200824103247.1088464-1-leon@kernel.org>
 <20200824103247.1088464-3-leon@kernel.org>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <ae7907f6-f392-10e2-642a-9e34f1ff9c37@amazon.com>
Date:   Tue, 25 Aug 2020 11:13:03 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824103247.1088464-3-leon@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.55]
X-ClientProxiedBy: EX13D46UWC003.ant.amazon.com (10.43.162.119) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 24/08/2020 13:32, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Like any other IB verbs objects, AH are refcounted by ib_core. The release
> of those objects is controlled by ib_core with promise that AH destroy
> can't fail.
> 
> Being SW object for now, this change makes dealloc_ah() to behave like
> any other destroy IB flows.

Maybe I'm misreading this, but AH isn't necessarily a software object. It's a HW
object as well in some of the drivers.

> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index 660a69943e02..426c5f687c7b 100644
> --- a/drivers/infiniband/hw/efa/efa_verbs.c
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -1875,7 +1875,7 @@ int efa_create_ah(struct ib_ah *ibah,
>  	return err;
>  }
> 
> -void efa_destroy_ah(struct ib_ah *ibah, u32 flags)
> +int efa_destroy_ah(struct ib_ah *ibah, u32 flags)
>  {
>  	struct efa_dev *dev = to_edev(ibah->pd->device);
>  	struct efa_ah *ah = to_eah(ibah);
> @@ -1885,10 +1885,11 @@ void efa_destroy_ah(struct ib_ah *ibah, u32 flags)
>  	if (!(flags & RDMA_DESTROY_AH_SLEEPABLE)) {
>  		ibdev_dbg(&dev->ibdev,
>  			  "Destroy address handle is not supported in atomic context\n");
> -		return;
> +		return -EINVAL;

-EOPNOTSUPP.

>  	}
> 
>  	efa_ah_destroy(dev, ah);
> +	return 0;
>  }
