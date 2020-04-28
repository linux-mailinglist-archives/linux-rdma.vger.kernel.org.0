Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE201BB430
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2020 04:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgD1Cxm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 22:53:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:61039 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgD1Cxl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 22:53:41 -0400
IronPort-SDR: JL5nPF64IbPHL5xtvvlvegJRro3ROHcp+JEN0FkQsrZAnOea/TuKXXxmh50Kc/yjlUFBU3CRa3
 KU18U6YmCUIA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 19:53:41 -0700
IronPort-SDR: yNvb2rrWHvnoCjWJESO9jRz5BlNo2W1UN5DYceD9TtPBq1wdP/C4CHX8b7Qsq08bqta9Y1ZWQG
 ca0wuJ4F9wFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,326,1583222400"; 
   d="scan'208";a="249052081"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Apr 2020 19:53:39 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jTGNO-0009z1-ND; Tue, 28 Apr 2020 10:53:38 +0800
Date:   Tue, 28 Apr 2020 10:52:36 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Weihang Li <liweihang@huawei.com>, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     kbuild-all@lists.01.org, leon@kernel.org,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v3 for-next 1/5] RDMA/hns: Optimize PBL buffer allocation
 process
Message-ID: <202004280904.BP6w786k%lkp@intel.com>
References: <1587883377-22975-2-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587883377-22975-2-git-send-email-liweihang@huawei.com>
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

url:    https://github.com/0day-ci/linux/commits/Weihang-Li/RDMA-hns-Refactor-process-of-buffer-allocation-and-calculation/20200428-015905
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-191-gc51a0382-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/infiniband/hw/hns/hns_roce_mr.c:375:6: sparse: sparse: symbol 'hns_roce_mr_free' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
