Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18071CCBD1
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2020 17:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgEJPLH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 May 2020 11:11:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbgEJPLH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 10 May 2020 11:11:07 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07C1420735;
        Sun, 10 May 2020 15:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589123466;
        bh=NR3FVp5pSDvPBuZweGicJfCB83hDSy/Qwj/V6gJa6iE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c7OF/C7TDKN5Fit7THXZA3ZWj43cj4Y8sK+t1QoxWggpvQ+DqyJqLAuVFmjb1qBXg
         tZABbcO5xv6V313R/biT30tw8Jx2XZDuu4LHIVr+/vE5zvfZAIqQp297QWuFJfi5jq
         eOoj1aqf9u05ZmP+KwZFn8Ve2ARlJ5aEfmOVvwJg=
Date:   Sun, 10 May 2020 18:11:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     kbuild test robot <lkp@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>, kbuild-all@lists.01.org,
        linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Guy Tzalik <gtzalik@amazon.com>
Subject: Re: [PATCH for-next 2/2] RDMA/efa: Report host information to the
 device
Message-ID: <20200510151102.GC199306@unreal>
References: <20200510115918.46246-3-galpress@amazon.com>
 <202005102140.IhOTb4Th%lkp@intel.com>
 <2b98035f-aa55-1b11-7012-fddca885ba4f@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b98035f-aa55-1b11-7012-fddca885ba4f@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 10, 2020 at 05:40:21PM +0300, Gal Pressman wrote:
> On 10/05/2020 16:42, kbuild test robot wrote:
> > Hi Gal,
> >
> > I love your patch! Yet something to improve:
> >
> > [auto build test ERROR on rdma/for-next]
> > [also build test ERROR on v5.7-rc4 next-20200508]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> >
> > url:    https://github.com/0day-ci/linux/commits/Gal-Pressman/EFA-host-information/20200510-200519
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> > config: riscv-allyesconfig (attached as .config)
> > compiler: riscv64-linux-gcc (GCC) 9.3.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=riscv
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    drivers/infiniband/hw/efa/efa_main.c: In function 'efa_set_host_info':
> >>> drivers/infiniband/hw/efa/efa_main.c:214:21: error: 'LINUX_VERSION_CODE' undeclared (first use in this function)
> >      214 |  hinf->kernel_ver = LINUX_VERSION_CODE;
> >          |                     ^~~~~~~~~~~~~~~~~~
> >    drivers/infiniband/hw/efa/efa_main.c:214:21: note: each undeclared identifier is reported only once for each function it appears in
> >
> > vim +/LINUX_VERSION_CODE +214 drivers/infiniband/hw/efa/efa_main.c
> >
> >    190
> >    191	static void efa_set_host_info(struct efa_dev *dev)
> >    192	{
> >    193		struct efa_admin_set_feature_resp resp = {};
> >    194		struct efa_admin_set_feature_cmd cmd = {};
> >    195		struct efa_admin_host_info *hinf;
> >    196		u32 bufsz = sizeof(*hinf);
> >    197		dma_addr_t hinf_dma;
> >    198
> >    199		if (!efa_com_check_supported_feature_id(&dev->edev,
> >    200							EFA_ADMIN_HOST_INFO))
> >    201			return;
> >    202
> >    203		/* Failures in host info set shall not disturb probe */
> >    204		hinf = dma_alloc_coherent(&dev->pdev->dev, bufsz, &hinf_dma,
> >    205					  GFP_KERNEL);
> >    206		if (!hinf)
> >    207			return;
> >    208
> >    209		strlcpy(hinf->os_dist_str, utsname()->release,
> >    210			min(sizeof(hinf->os_dist_str), sizeof(utsname()->release)));
> >    211		hinf->os_type = EFA_ADMIN_OS_LINUX;
> >    212		strlcpy(hinf->kernel_ver_str, utsname()->version,
> >    213			min(sizeof(hinf->kernel_ver_str), sizeof(utsname()->version)));
> >  > 214		hinf->kernel_ver = LINUX_VERSION_CODE;
> >    215		EFA_SET(&hinf->bdf, EFA_ADMIN_HOST_INFO_BUS, dev->pdev->bus->number);
> >    216		EFA_SET(&hinf->bdf, EFA_ADMIN_HOST_INFO_DEVICE,
> >    217			PCI_SLOT(dev->pdev->devfn));
> >    218		EFA_SET(&hinf->bdf, EFA_ADMIN_HOST_INFO_FUNCTION,
> >    219			PCI_FUNC(dev->pdev->devfn));
> >    220		EFA_SET(&hinf->spec_ver, EFA_ADMIN_HOST_INFO_SPEC_MAJOR,
> >    221			EFA_COMMON_SPEC_VERSION_MAJOR);
> >    222		EFA_SET(&hinf->spec_ver, EFA_ADMIN_HOST_INFO_SPEC_MINOR,
> >    223			EFA_COMMON_SPEC_VERSION_MINOR);
> >    224		EFA_SET(&hinf->flags, EFA_ADMIN_HOST_INFO_INTREE, 1);
> >    225
> >    226		efa_com_set_feature_ex(&dev->edev, &resp, &cmd, EFA_ADMIN_HOST_INFO,
> >    227				       hinf_dma, bufsz);
> >    228
> >    229		dma_free_coherent(&dev->pdev->dev, bufsz, hinf, hinf_dma);
> >    230	}
> >    231
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> >
>
> Thanks robot, I'm missing an #include <linux/version.h> in efa_main.c.

I'm not so sure that you can use that header.
You need to use "#include <generated/utsrelease.h>" instead of
LINUX_VERSION.

Thanks
