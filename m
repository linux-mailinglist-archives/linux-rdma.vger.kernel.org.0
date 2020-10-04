Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FD1282A54
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 13:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgJDLDa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Oct 2020 07:03:30 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:64667 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgJDLDa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 4 Oct 2020 07:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1601809410; x=1633345410;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=i0VecxD3MvungItxpjLlNqsevMBiu1WD3KvND+xf6EY=;
  b=OqZjY6+RVkEQbkEkzjpArkH0ojhy4NU9kg59tw3VJgaah2oXLK3zYnbb
   6z8EMkPYqISST16CQLF7yJz0jHczXm/Ryq3oVpAgxb7XJegOA8CUUAamf
   xILgv43VEUEVp9SSNW1Ps4I0chRkUqUQgj2DLwDqEd1f/KXbd33cYFLKo
   4=;
X-IronPort-AV: E=Sophos;i="5.77,335,1596499200"; 
   d="scan'208";a="73167691"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 04 Oct 2020 11:03:27 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 26C2922560D;
        Sun,  4 Oct 2020 11:03:25 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.160.137) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 4 Oct 2020 11:03:12 +0000
Subject: Re: [PATCH 06/11] RDMA: Check attr_mask during modify_qp
To:     Jason Gunthorpe <jgg@nvidia.com>, Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, Weihang Li <liweihang@huawei.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Lijun Ou <oulijun@huawei.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
References: <6-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <06064431-fd1b-463d-c022-31f035b697bf@amazon.com>
Date:   Sun, 4 Oct 2020 14:02:52 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <6-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.137]
X-ClientProxiedBy: EX13D28UWB003.ant.amazon.com (10.43.161.60) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 04/10/2020 2:20, Jason Gunthorpe wrote:
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index 191e0843f090c8..e3d9a5a5f4d992 100644
> --- a/drivers/infiniband/hw/efa/efa_verbs.c
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -917,6 +917,9 @@ int efa_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
>  	enum ib_qp_state new_state;
>  	int err;
>  
> +	if (qp_attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
> +		return -EOPNOTSUPP;

This is kinda redundant, we have a more strict check in efa_modify_qp_validate.
