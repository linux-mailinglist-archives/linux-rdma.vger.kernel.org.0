Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20867008F5
	for <lists+linux-rdma@lfdr.de>; Fri, 12 May 2023 15:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbjELNRt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 May 2023 09:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240972AbjELNRs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 May 2023 09:17:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1192689;
        Fri, 12 May 2023 06:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683897459; x=1715433459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v3ur4im9RMBVOzsWz/PbY2NOqCZy1ova0YsE+zQNmWo=;
  b=OId8rLo3ygd0DARO4RUCtgZNdIlJma94kTihxye1zJCe4dMN2BV12Luq
   gxSixrl2S2VAqnaV8wnLbGszs6inMzYLhYULDZCa5JiZENJTXEusAvmT1
   gUSxm9otk5KQvnIeDe0Zx6Ul6Ww+MXHondx8pSfMusRSkrWa6oJJwOELl
   68N/bO6awE2NoafruZ2+b0KE77JkIB96VNyC3MyEZsc2hOOU0gM9RUNww
   vgxLFvS80XpZjHSo9b7a0t3x9Y49/0J2hUuYeDuECXJiizQR1u6F3Ol+9
   QsM9I9HMcjF1zfnyhoLimrJHIfTj2deM5DhyG1+hU29ySJ0tAkiUnAYG4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="414155598"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="414155598"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 06:13:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="730817781"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="730817781"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 12 May 2023 06:13:48 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxSah-0004sP-1q;
        Fri, 12 May 2023 13:13:47 +0000
Date:   Fri, 12 May 2023 21:13:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        pabeni@redhat.com, song@kernel.org, sdf@google.com,
        haoluo@google.com, yhs@fb.com, edumazet@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        guwen@linux.alibaba.com
Cc:     oe-kbuild-all@lists.linux.dev, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 2/5] net/smc: allow smc to negotiate
 protocols on policies
Message-ID: <202305122104.msaKEOV1-lkp@intel.com>
References: <1683872684-64872-3-git-send-email-alibuda@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683872684-64872-3-git-send-email-alibuda@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Wythe,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/D-Wythe/net-smc-move-smc_sock-related-structure-definition/20230512-142700
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/1683872684-64872-3-git-send-email-alibuda%40linux.alibaba.com
patch subject: [PATCH bpf-next v1 2/5] net/smc: allow smc to negotiate protocols on policies
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20230512/202305122104.msaKEOV1-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/db8daea84b78121c3612ad5e5ba1d1eaac2f4171
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review D-Wythe/net-smc-move-smc_sock-related-structure-definition/20230512-142700
        git checkout db8daea84b78121c3612ad5e5ba1d1eaac2f4171
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305122104.msaKEOV1-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "bpf_struct_ops_get" [net/smc/smc.ko] undefined!
>> ERROR: modpost: "bpf_struct_ops_put" [net/smc/smc.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
