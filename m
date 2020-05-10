Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793721CCB95
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2020 16:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgEJOkt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 May 2020 10:40:49 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:10942 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbgEJOkt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 May 2020 10:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589121649; x=1620657649;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=QcUVNDnGRkN6XhdBTx4Q4slh1Mn/+JMcPpEMnQEvHS0=;
  b=O3pNaFOwtyj1Cy8B2rDhxrRaMjhDleMJsxI3gYfVhixnD2T/3rh/tz9z
   lqbMD62rlzv1DhVnAYuKKrd5Gdq6Q03pAxz5Ao+VezeUL5YrqReNdZQZ7
   pa/ivmEx45Tpa6zTwhsrFs09yLftakcZTbA6ABB4sBtStwZxzTcrnrh0E
   4=;
IronPort-SDR: HRmKk1Tf49+AS0Dri3k/H2piP4X3B6UKnvQ4kVztRjQQedM8pniGVj20s10L7k7n3WkZK82p+w
 vIQPFBjRcNSw==
X-IronPort-AV: E=Sophos;i="5.73,376,1583193600"; 
   d="scan'208";a="43756880"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 10 May 2020 14:40:33 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id 6174BA21AE;
        Sun, 10 May 2020 14:40:32 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 10 May 2020 14:40:31 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.65) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 10 May 2020 14:40:27 +0000
Subject: Re: [PATCH for-next 2/2] RDMA/efa: Report host information to the
 device
To:     kbuild test robot <lkp@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Doug Ledford" <dledford@redhat.com>
CC:     <kbuild-all@lists.01.org>, <linux-rdma@vger.kernel.org>,
        "Alexander Matushevsky" <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Guy Tzalik <gtzalik@amazon.com>
References: <20200510115918.46246-3-galpress@amazon.com>
 <202005102140.IhOTb4Th%lkp@intel.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <2b98035f-aa55-1b11-7012-fddca885ba4f@amazon.com>
Date:   Sun, 10 May 2020 17:40:21 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <202005102140.IhOTb4Th%lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.65]
X-ClientProxiedBy: EX13D29UWC002.ant.amazon.com (10.43.162.254) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/05/2020 16:42, kbuild test robot wrote:
> Hi Gal,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on rdma/for-next]
> [also build test ERROR on v5.7-rc4 next-20200508]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Gal-Pressman/EFA-host-information/20200510-200519
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> config: riscv-allyesconfig (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=riscv 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/infiniband/hw/efa/efa_main.c: In function 'efa_set_host_info':
>>> drivers/infiniband/hw/efa/efa_main.c:214:21: error: 'LINUX_VERSION_CODE' undeclared (first use in this function)
>      214 |  hinf->kernel_ver = LINUX_VERSION_CODE;
>          |                     ^~~~~~~~~~~~~~~~~~
>    drivers/infiniband/hw/efa/efa_main.c:214:21: note: each undeclared identifier is reported only once for each function it appears in
> 
> vim +/LINUX_VERSION_CODE +214 drivers/infiniband/hw/efa/efa_main.c
> 
>    190	
>    191	static void efa_set_host_info(struct efa_dev *dev)
>    192	{
>    193		struct efa_admin_set_feature_resp resp = {};
>    194		struct efa_admin_set_feature_cmd cmd = {};
>    195		struct efa_admin_host_info *hinf;
>    196		u32 bufsz = sizeof(*hinf);
>    197		dma_addr_t hinf_dma;
>    198	
>    199		if (!efa_com_check_supported_feature_id(&dev->edev,
>    200							EFA_ADMIN_HOST_INFO))
>    201			return;
>    202	
>    203		/* Failures in host info set shall not disturb probe */
>    204		hinf = dma_alloc_coherent(&dev->pdev->dev, bufsz, &hinf_dma,
>    205					  GFP_KERNEL);
>    206		if (!hinf)
>    207			return;
>    208	
>    209		strlcpy(hinf->os_dist_str, utsname()->release,
>    210			min(sizeof(hinf->os_dist_str), sizeof(utsname()->release)));
>    211		hinf->os_type = EFA_ADMIN_OS_LINUX;
>    212		strlcpy(hinf->kernel_ver_str, utsname()->version,
>    213			min(sizeof(hinf->kernel_ver_str), sizeof(utsname()->version)));
>  > 214		hinf->kernel_ver = LINUX_VERSION_CODE;
>    215		EFA_SET(&hinf->bdf, EFA_ADMIN_HOST_INFO_BUS, dev->pdev->bus->number);
>    216		EFA_SET(&hinf->bdf, EFA_ADMIN_HOST_INFO_DEVICE,
>    217			PCI_SLOT(dev->pdev->devfn));
>    218		EFA_SET(&hinf->bdf, EFA_ADMIN_HOST_INFO_FUNCTION,
>    219			PCI_FUNC(dev->pdev->devfn));
>    220		EFA_SET(&hinf->spec_ver, EFA_ADMIN_HOST_INFO_SPEC_MAJOR,
>    221			EFA_COMMON_SPEC_VERSION_MAJOR);
>    222		EFA_SET(&hinf->spec_ver, EFA_ADMIN_HOST_INFO_SPEC_MINOR,
>    223			EFA_COMMON_SPEC_VERSION_MINOR);
>    224		EFA_SET(&hinf->flags, EFA_ADMIN_HOST_INFO_INTREE, 1);
>    225	
>    226		efa_com_set_feature_ex(&dev->edev, &resp, &cmd, EFA_ADMIN_HOST_INFO,
>    227				       hinf_dma, bufsz);
>    228	
>    229		dma_free_coherent(&dev->pdev->dev, bufsz, hinf, hinf_dma);
>    230	}
>    231	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

Thanks robot, I'm missing an #include <linux/version.h> in efa_main.c.
