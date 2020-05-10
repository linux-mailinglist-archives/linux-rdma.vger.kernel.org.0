Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14B61CCB42
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2020 15:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgEJNGD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 May 2020 09:06:03 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:35628 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbgEJNGD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 May 2020 09:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589115961; x=1620651961;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=t3V6d45gdodeXd39wyxjEj/oCFssTbhusLsB3TsbE8k=;
  b=R3WgPpWJGZ7A9I1OhjhdPSGRV1+RMLil0ZAIH7Jh9uMO1K48f4L7rJtj
   tUaSQZKDyBOW2b/4sn3nLtjCVSJg3jSJtJiPWeDNlzKRk12NG/km37jMY
   s/0afdLQd/eYY+CkHllOVmXmmSxYl/Yc53Ceg8mReUIzKuIWSq38ThLT5
   E=;
IronPort-SDR: DWx7829xcX4B28p1MUXXR9Fa6yuvmic8PRTHkl9u4wGM6fqpO8CEYsH4nXWhIT6FXYxE4J7pux
 fogYkBot8zrQ==
X-IronPort-AV: E=Sophos;i="5.73,375,1583193600"; 
   d="scan'208";a="42332080"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 10 May 2020 13:06:00 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id 72010A24E7;
        Sun, 10 May 2020 13:05:56 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 10 May 2020 13:05:55 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.65) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 10 May 2020 13:05:51 +0000
Subject: Re: [PATCH for-next 2/2] RDMA/efa: Report host information to the
 device
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        "Firas JahJah" <firasj@amazon.com>, Guy Tzalik <gtzalik@amazon.com>
References: <20200510115918.46246-1-galpress@amazon.com>
 <20200510115918.46246-3-galpress@amazon.com> <20200510122949.GB199306@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <5612e79f-76e5-7f87-8321-5114d414015e@amazon.com>
Date:   Sun, 10 May 2020 16:05:45 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510122949.GB199306@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.65]
X-ClientProxiedBy: EX13D35UWC001.ant.amazon.com (10.43.162.197) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/05/2020 15:29, Leon Romanovsky wrote:
> On Sun, May 10, 2020 at 02:59:18PM +0300, Gal Pressman wrote:
>> diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
>> index 96b104ab5415..efdeebc9ea9b 100644
>> --- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
>> +++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
>> @@ -37,7 +37,7 @@ enum efa_admin_aq_feature_id {
>>  	EFA_ADMIN_NETWORK_ATTR                      = 3,
>>  	EFA_ADMIN_QUEUE_ATTR                        = 4,
>>  	EFA_ADMIN_HW_HINTS                          = 5,
>> -	EFA_ADMIN_FEATURES_OPCODE_NUM               = 8,
>> +	EFA_ADMIN_HOST_INFO                         = 6,
>>  };
>>
>>  /* QP transport type */
>> @@ -799,6 +799,55 @@ struct efa_admin_mmio_req_read_less_resp {
>>  	u32 reg_val;
>>  };
>>
>> +enum efa_admin_os_type {
>> +	EFA_ADMIN_OS_LINUX                          = 0,
>> +	EFA_ADMIN_OS_WINDOWS                        = 1,
> 
> Not used.

That's the device interface..

> 
>> +};
>> +
>> +struct efa_admin_host_info {
>> +	/* OS distribution string format */
>> +	u8 os_dist_str[128];
>> +
>> +	/* Defined in enum efa_admin_os_type */
>> +	u32 os_type;
>> +
>> +	/* Kernel version string format */
>> +	u8 kernel_ver_str[32];
>> +
>> +	/* Kernel version numeric format */
>> +	u32 kernel_ver;
>> +
>> +	/*
>> +	 * 7:0 : driver_module_type
>> +	 * 15:8 : driver_sub_minor
>> +	 * 23:16 : driver_minor
>> +	 * 31:24 : driver_major
>> +	 */
>> +	u32 driver_ver;
> 
> No to this.

Same, this is the device interface.
And obviously it's not used as we don't have a driver version.

> 
>> +
>> +	/*
>> +	 * Device's Bus, Device and Function
>> +	 * 2:0 : function
>> +	 * 7:3 : device
>> +	 * 15:8 : bus
>> +	 */
>> +	u16 bdf;
>> +
>> +	/*
>> +	 * Spec version
>> +	 * 7:0 : spec_minor
>> +	 * 15:8 : spec_major
>> +	 */
>> +	u16 spec_ver;
>> +
>> +	/*
>> +	 * 0 : intree - Intree driver
>> +	 * 1 : gdr - GPUDirect RDMA supported
>> +	 * 31:2 : reserved2
>> +	 */
>> +	u32 flags;
>> +};
>> +
>>  /* create_qp_cmd */
>>  #define EFA_ADMIN_CREATE_QP_CMD_SQ_VIRT_MASK                BIT(0)
>>  #define EFA_ADMIN_CREATE_QP_CMD_RQ_VIRT_MASK                BIT(1)
>> @@ -820,4 +869,17 @@ struct efa_admin_mmio_req_read_less_resp {
>>  /* feature_device_attr_desc */
>>  #define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_READ_MASK   BIT(0)
>>
>> +/* host_info */
>> +#define EFA_ADMIN_HOST_INFO_DRIVER_MODULE_TYPE_MASK         GENMASK(7, 0)
>> +#define EFA_ADMIN_HOST_INFO_DRIVER_SUB_MINOR_MASK           GENMASK(15, 8)
>> +#define EFA_ADMIN_HOST_INFO_DRIVER_MINOR_MASK               GENMASK(23, 16)
>> +#define EFA_ADMIN_HOST_INFO_DRIVER_MAJOR_MASK               GENMASK(31, 24)
> 
> Not in use.

Same.

> 
>> +#define EFA_ADMIN_HOST_INFO_FUNCTION_MASK                   GENMASK(2, 0)
>> +#define EFA_ADMIN_HOST_INFO_DEVICE_MASK                     GENMASK(7, 3)
>> +#define EFA_ADMIN_HOST_INFO_BUS_MASK                        GENMASK(15, 8)
>> +#define EFA_ADMIN_HOST_INFO_SPEC_MINOR_MASK                 GENMASK(7, 0)
>> +#define EFA_ADMIN_HOST_INFO_SPEC_MAJOR_MASK                 GENMASK(15, 8)
>> +#define EFA_ADMIN_HOST_INFO_INTREE_MASK                     BIT(0)
>> +#define EFA_ADMIN_HOST_INFO_GDR_MASK                        BIT(1)
>> +
>>  #endif /* _EFA_ADMIN_CMDS_H_ */
>> +static void efa_set_host_info(struct efa_dev *dev)
>> +{
>> +	struct efa_admin_set_feature_resp resp = {};
>> +	struct efa_admin_set_feature_cmd cmd = {};
>> +	struct efa_admin_host_info *hinf;
>> +	u32 bufsz = sizeof(*hinf);
>> +	dma_addr_t hinf_dma;
>> +
>> +	if (!efa_com_check_supported_feature_id(&dev->edev,
>> +						EFA_ADMIN_HOST_INFO))
>> +		return;
>> +
>> +	/* Failures in host info set shall not disturb probe */
>> +	hinf = dma_alloc_coherent(&dev->pdev->dev, bufsz, &hinf_dma,
>> +				  GFP_KERNEL);
>> +	if (!hinf)
>> +		return;
>> +
>> +	strlcpy(hinf->os_dist_str, utsname()->release,
>> +		min(sizeof(hinf->os_dist_str), sizeof(utsname()->release)));
>> +	hinf->os_type = EFA_ADMIN_OS_LINUX;
>> +	strlcpy(hinf->kernel_ver_str, utsname()->version,
>> +		min(sizeof(hinf->kernel_ver_str), sizeof(utsname()->version)));
>> +	hinf->kernel_ver = LINUX_VERSION_CODE;
>> +	EFA_SET(&hinf->bdf, EFA_ADMIN_HOST_INFO_BUS, dev->pdev->bus->number);
>> +	EFA_SET(&hinf->bdf, EFA_ADMIN_HOST_INFO_DEVICE,
>> +		PCI_SLOT(dev->pdev->devfn));
>> +	EFA_SET(&hinf->bdf, EFA_ADMIN_HOST_INFO_FUNCTION,
>> +		PCI_FUNC(dev->pdev->devfn));
>> +	EFA_SET(&hinf->spec_ver, EFA_ADMIN_HOST_INFO_SPEC_MAJOR,
>> +		EFA_COMMON_SPEC_VERSION_MAJOR);
>> +	EFA_SET(&hinf->spec_ver, EFA_ADMIN_HOST_INFO_SPEC_MINOR,
>> +		EFA_COMMON_SPEC_VERSION_MINOR);
>> +	EFA_SET(&hinf->flags, EFA_ADMIN_HOST_INFO_INTREE, 1);
> 
> Ohhh, so users will change this line voluntarily?

Are you worried with out of tree users?
