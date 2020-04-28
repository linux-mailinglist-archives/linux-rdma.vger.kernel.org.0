Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29631BB68B
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2020 08:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgD1G37 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Apr 2020 02:29:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:10485 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgD1G37 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Apr 2020 02:29:59 -0400
IronPort-SDR: mvuQ5UQw0x8EZwxKBdscbkAfVgz0CyNRtqzU+WG/5ZerKpdZj1hma/cepHUxaeCRXU8lA+iDNr
 2wWKlFsgKXOg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 23:29:59 -0700
IronPort-SDR: fDAXYCV0bAOCNZpla2jecQ7+7Xc+so8N9MFiRu5oKyU4orx/OXhGPSxXDonkie6G4VH+Nnhu1J
 qwhlIKc4UIig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,327,1583222400"; 
   d="scan'208";a="459129378"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 27 Apr 2020 23:29:52 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jTJke-00030L-Ag; Tue, 28 Apr 2020 14:29:52 +0800
Date:   Tue, 28 Apr 2020 14:29:40 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Weihang Li <liweihang@huawei.com>, dledford@redhat.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, selvin.xavier@broadcom.com,
        devesh.sharma@broadcom.com, somnath.kotur@broadcom.com,
        sriharsha.basavapatna@broadcom.com, bharat@chelsio.com,
        galpress@amazon.com, sleybo@amazon.com, faisal.latif@intel.com,
        shiraz.saleem@intel.com, yishaih@mellanox.com,
        mkalderon@marvell.com, aelior@marvell.com, benve@cisco.com,
        neescoba@cisco.com, pkaustub@cisco.com, aditr@vmware.com,
        pv-drivers@vmware.com, monis@mellanox.com, kamalheib1@gmail.com,
        parav@mellanox.com, markz@mellanox.com, rd.dunlab@gmail.com,
        dennis.dalessandro@intel.com
Cc:     kbuild-all@lists.01.org, leon@kernel.org,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com,
        bharat@chelsio.com, galpress@amazon.com
Subject: Re: [PATCH for-next] RDMA/core: Assign the name of device when
 allocating ib_device
Message-ID: <202004281415.H8iL0WCN%lkp@intel.com>
References: <1587893517-11824-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587893517-11824-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Weihang,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v5.7-rc3 next-20200424]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Weihang-Li/RDMA-core-Assign-the-name-of-device-when-allocating-ib_device/20200428-022647
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-191-gc51a0382-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/infiniband/sw/rdmavt/vt.c:94:15: sparse: sparse: not enough arguments for function _ib_alloc_device
>> drivers/infiniband/sw/rdmavt/vt.c:94:15: sparse: sparse: cast from unknown type
>> drivers/infiniband/sw/rdmavt/vt.c:94:15: sparse: sparse: not enough arguments for function _ib_alloc_device
>> drivers/infiniband/sw/rdmavt/vt.c:94:15: sparse: sparse: not enough arguments for function _ib_alloc_device
>> drivers/infiniband/sw/rdmavt/vt.c:636:33: sparse: sparse: too many arguments for function ib_register_device
--
>> drivers/infiniband/sw/siw/siw_main.c:326:16: sparse: sparse: macro "ib_alloc_device" requires 3 arguments, but only 2 given
   drivers/infiniband/sw/siw/iwarp.h:196:22: sparse: sparse: invalid bitfield specifier for type restricted __be32.
   drivers/infiniband/sw/siw/iwarp.h:197:22: sparse: sparse: invalid bitfield specifier for type restricted __be32.
   drivers/infiniband/sw/siw/iwarp.h:198:22: sparse: sparse: invalid bitfield specifier for type restricted __be32.
   drivers/infiniband/sw/siw/iwarp.h:199:23: sparse: sparse: invalid bitfield specifier for type restricted __be32.
   drivers/infiniband/sw/siw/iwarp.h:200:23: sparse: sparse: invalid bitfield specifier for type restricted __be32.
   drivers/infiniband/sw/siw/iwarp.h:201:23: sparse: sparse: invalid bitfield specifier for type restricted __be32.
   drivers/infiniband/sw/siw/iwarp.h:202:25: sparse: sparse: invalid bitfield specifier for type restricted __be32.
>> drivers/infiniband/sw/siw/siw_main.c:70:32: sparse: sparse: too many arguments for function ib_register_device
   drivers/infiniband/sw/siw/siw_main.c:326:16: sparse: sparse: undefined identifier 'ib_alloc_device'

vim +94 drivers/infiniband/sw/rdmavt/vt.c

0194621b225348 Dennis Dalessandro 2016-01-06   76  
90793f7179478d Dennis Dalessandro 2016-02-14   77  /**
90793f7179478d Dennis Dalessandro 2016-02-14   78   * rvt_alloc_device - allocate rdi
90793f7179478d Dennis Dalessandro 2016-02-14   79   * @size: how big of a structure to allocate
90793f7179478d Dennis Dalessandro 2016-02-14   80   * @nports: number of ports to allocate array slots for
90793f7179478d Dennis Dalessandro 2016-02-14   81   *
90793f7179478d Dennis Dalessandro 2016-02-14   82   * Use IB core device alloc to allocate space for the rdi which is assumed to be
90793f7179478d Dennis Dalessandro 2016-02-14   83   * inside of the ib_device. Any extra space that drivers require should be
90793f7179478d Dennis Dalessandro 2016-02-14   84   * included in size.
90793f7179478d Dennis Dalessandro 2016-02-14   85   *
90793f7179478d Dennis Dalessandro 2016-02-14   86   * We also allocate a port array based on the number of ports.
90793f7179478d Dennis Dalessandro 2016-02-14   87   *
90793f7179478d Dennis Dalessandro 2016-02-14   88   * Return: pointer to allocated rdi
90793f7179478d Dennis Dalessandro 2016-02-14   89   */
ff6acd69518e0a Dennis Dalessandro 2016-01-22   90  struct rvt_dev_info *rvt_alloc_device(size_t size, int nports)
ff6acd69518e0a Dennis Dalessandro 2016-01-22   91  {
042932f7a32741 Colin Ian King     2018-03-01   92  	struct rvt_dev_info *rdi;
ff6acd69518e0a Dennis Dalessandro 2016-01-22   93  
459cc69fa4c17c Leon Romanovsky    2019-01-30  @94  	rdi = container_of(_ib_alloc_device(size), struct rvt_dev_info, ibdev);
ff6acd69518e0a Dennis Dalessandro 2016-01-22   95  	if (!rdi)
ff6acd69518e0a Dennis Dalessandro 2016-01-22   96  		return rdi;
ff6acd69518e0a Dennis Dalessandro 2016-01-22   97  
ff6acd69518e0a Dennis Dalessandro 2016-01-22   98  	rdi->ports = kcalloc(nports,
ff6acd69518e0a Dennis Dalessandro 2016-01-22   99  			     sizeof(struct rvt_ibport **),
ff6acd69518e0a Dennis Dalessandro 2016-01-22  100  			     GFP_KERNEL);
ff6acd69518e0a Dennis Dalessandro 2016-01-22  101  	if (!rdi->ports)
ff6acd69518e0a Dennis Dalessandro 2016-01-22  102  		ib_dealloc_device(&rdi->ibdev);
ff6acd69518e0a Dennis Dalessandro 2016-01-22  103  
ff6acd69518e0a Dennis Dalessandro 2016-01-22  104  	return rdi;
ff6acd69518e0a Dennis Dalessandro 2016-01-22  105  }
ff6acd69518e0a Dennis Dalessandro 2016-01-22  106  EXPORT_SYMBOL(rvt_alloc_device);
ff6acd69518e0a Dennis Dalessandro 2016-01-22  107  

:::::: The code at line 94 was first introduced by commit
:::::: 459cc69fa4c17caf21de596693d8a07170820a58 RDMA: Provide safe ib_alloc_device() function

:::::: TO: Leon Romanovsky <leonro@mellanox.com>
:::::: CC: Jason Gunthorpe <jgg@mellanox.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
