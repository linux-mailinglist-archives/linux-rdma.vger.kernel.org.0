Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D041CDA40
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 14:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbgEKMlV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 08:41:21 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:48804 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbgEKMlV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 May 2020 08:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589200881; x=1620736881;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=PuTjKrvuWSBiMVAOZgYZI9h0FuBYAz0WBUsE6AgO4JI=;
  b=VMM/rZRanZmeaAYVO8fzpOoMaajC7vbfil2okf+OdAzuKUs0uCRt1uD8
   trNJHpQbQOfZBxQj8xfsxLTsYRh2pHL8i4du0bgI6OnIrem956pu++Xyi
   0cBMHxXe16qW7UHYkHpjbEcDhZuiJ9JLLhYp1HuRkWN5omZhpKWBpysvH
   w=;
IronPort-SDR: oPEzh7OPi6Ug7sN0q57wjbp3WnkqmqUp7vETp1GtjlwvqJeeq6DbFcMl/k8cSIXOJ4eheLVCjG
 zxAQk1RJcW1A==
X-IronPort-AV: E=Sophos;i="5.73,379,1583193600"; 
   d="scan'208";a="29669544"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 11 May 2020 12:40:58 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id 908CEA1C9C;
        Mon, 11 May 2020 12:40:56 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 11 May 2020 12:40:55 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.200) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 11 May 2020 12:40:49 +0000
Subject: Re: [PATCH for-next 2/2] RDMA/efa: Report host information to the
 device
To:     Leon Romanovsky <leon@kernel.org>
CC:     kbuild test robot <lkp@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Doug Ledford" <dledford@redhat.com>, <kbuild-all@lists.01.org>,
        <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        "Firas JahJah" <firasj@amazon.com>, Guy Tzalik <gtzalik@amazon.com>
References: <20200510115918.46246-3-galpress@amazon.com>
 <202005102140.IhOTb4Th%lkp@intel.com>
 <2b98035f-aa55-1b11-7012-fddca885ba4f@amazon.com>
 <20200510151102.GC199306@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <8ed8dac8-4ca5-2401-a51c-7dc40bc7c4de@amazon.com>
Date:   Mon, 11 May 2020 15:40:35 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200510151102.GC199306@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.200]
X-ClientProxiedBy: EX13D08UWC001.ant.amazon.com (10.43.162.110) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/05/2020 18:11, Leon Romanovsky wrote:
> On Sun, May 10, 2020 at 05:40:21PM +0300, Gal Pressman wrote:
>> On 10/05/2020 16:42, kbuild test robot wrote:
>>> Hi Gal,
>>>
>>> I love your patch! Yet something to improve:
>>>
>>> [auto build test ERROR on rdma/for-next]
>>> [also build test ERROR on v5.7-rc4 next-20200508]
>>> [if your patch is applied to the wrong git tree, please drop us a note to help
>>> improve the system. BTW, we also suggest to use '--base' option to specify the
>>> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>>>
>>> url:    https://github.com/0day-ci/linux/commits/Gal-Pressman/EFA-host-information/20200510-200519
>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
>>> config: riscv-allyesconfig (attached as .config)
>>> compiler: riscv64-linux-gcc (GCC) 9.3.0
>>> reproduce:
>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>         chmod +x ~/bin/make.cross
>>>         # save the attached .config to linux build tree
>>>         COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=riscv
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>    drivers/infiniband/hw/efa/efa_main.c: In function 'efa_set_host_info':
>>>>> drivers/infiniband/hw/efa/efa_main.c:214:21: error: 'LINUX_VERSION_CODE' undeclared (first use in this function)
>>>      214 |  hinf->kernel_ver = LINUX_VERSION_CODE;
>>>          |                     ^~~~~~~~~~~~~~~~~~
>>>    drivers/infiniband/hw/efa/efa_main.c:214:21: note: each undeclared identifier is reported only once for each function it appears in
>>>
>>> vim +/LINUX_VERSION_CODE +214 drivers/infiniband/hw/efa/efa_main.c
>>>
>>>    190
>>>    191	static void efa_set_host_info(struct efa_dev *dev)
>>>    192	{
>>>    193		struct efa_admin_set_feature_resp resp = {};
>>>    194		struct efa_admin_set_feature_cmd cmd = {};
>>>    195		struct efa_admin_host_info *hinf;
>>>    196		u32 bufsz = sizeof(*hinf);
>>>    197		dma_addr_t hinf_dma;
>>>    198
>>>    199		if (!efa_com_check_supported_feature_id(&dev->edev,
>>>    200							EFA_ADMIN_HOST_INFO))
>>>    201			return;
>>>    202
>>>    203		/* Failures in host info set shall not disturb probe */
>>>    204		hinf = dma_alloc_coherent(&dev->pdev->dev, bufsz, &hinf_dma,
>>>    205					  GFP_KERNEL);
>>>    206		if (!hinf)
>>>    207			return;
>>>    208
>>>    209		strlcpy(hinf->os_dist_str, utsname()->release,
>>>    210			min(sizeof(hinf->os_dist_str), sizeof(utsname()->release)));
>>>    211		hinf->os_type = EFA_ADMIN_OS_LINUX;
>>>    212		strlcpy(hinf->kernel_ver_str, utsname()->version,
>>>    213			min(sizeof(hinf->kernel_ver_str), sizeof(utsname()->version)));
>>>  > 214		hinf->kernel_ver = LINUX_VERSION_CODE;
>>>    215		EFA_SET(&hinf->bdf, EFA_ADMIN_HOST_INFO_BUS, dev->pdev->bus->number);
>>>    216		EFA_SET(&hinf->bdf, EFA_ADMIN_HOST_INFO_DEVICE,
>>>    217			PCI_SLOT(dev->pdev->devfn));
>>>    218		EFA_SET(&hinf->bdf, EFA_ADMIN_HOST_INFO_FUNCTION,
>>>    219			PCI_FUNC(dev->pdev->devfn));
>>>    220		EFA_SET(&hinf->spec_ver, EFA_ADMIN_HOST_INFO_SPEC_MAJOR,
>>>    221			EFA_COMMON_SPEC_VERSION_MAJOR);
>>>    222		EFA_SET(&hinf->spec_ver, EFA_ADMIN_HOST_INFO_SPEC_MINOR,
>>>    223			EFA_COMMON_SPEC_VERSION_MINOR);
>>>    224		EFA_SET(&hinf->flags, EFA_ADMIN_HOST_INFO_INTREE, 1);
>>>    225
>>>    226		efa_com_set_feature_ex(&dev->edev, &resp, &cmd, EFA_ADMIN_HOST_INFO,
>>>    227				       hinf_dma, bufsz);
>>>    228
>>>    229		dma_free_coherent(&dev->pdev->dev, bufsz, hinf, hinf_dma);
>>>    230	}
>>>    231
>>>
>>> ---
>>> 0-DAY CI Kernel Test Service, Intel Corporation
>>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>>
>>
>> Thanks robot, I'm missing an #include <linux/version.h> in efa_main.c.
> 
> I'm not so sure that you can use that header.
> You need to use "#include <generated/utsrelease.h>" instead of
> LINUX_VERSION.

Are you sure about that?
I think <generated/utsrelease.h> is used for UTS_RELEASE define.
