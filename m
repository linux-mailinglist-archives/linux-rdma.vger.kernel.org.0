Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3128959C751
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Aug 2022 20:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237876AbiHVSxi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Aug 2022 14:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbiHVSxV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Aug 2022 14:53:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA274DB41
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 11:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661194294; x=1692730294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GKxHWX4aEtDR54Skii1cR1zRRFyFuVmdPBz2s2fFaM4=;
  b=ilgw+6PjIQbsXkNSOorNsgX5Nn9f9QG31n0I1AG7gC1cTQvP81h2NevR
   sEtVDXsCeVU7PiQunpdxKI4et8B/2IliCZ684B4CUXVcHl/OkrSIcJsD6
   sZtzRwXzs46O7zaSQpNxk6LZtXY0Roj17/vL3p8ute3VV7096WijJGqX4
   iMokVFVR+yInaE1lswdhpfVN9/mNiNCquPk8gaAD+GCWUB3IqLULArEsr
   +AJZy/F9YsHiQ9QpisqT+G+hP0Do26nrqotCjQy5rHdNCC7FMKUenhFnU
   ms0Yd6Jo3k18v3HEfurVd/6Z83bHNjrqbkujfeOzWDvYTIJCWHFBXab1S
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="292235987"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="292235987"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 11:50:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="585642556"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Aug 2022 11:50:00 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQCUq-0000aZ-0F;
        Mon, 22 Aug 2022 18:50:00 +0000
Date:   Tue, 23 Aug 2022 02:49:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>, yanjun.zhu@linux.dev,
        jgg@ziepe.ca, leon@kernel.org
Cc:     kbuild-all@lists.01.org, linux-rdma@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH] RDMA/rxe: No need to check IPV6 in rxe_find_route
Message-ID: <202208230225.DS04ZlXH-lkp@intel.com>
References: <20220822112355.17635-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822112355.17635-1-guoqing.jiang@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Guoqing,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rdma/for-next]
[also build test ERROR on linus/master v6.0-rc2 next-20220822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guoqing-Jiang/RDMA-rxe-No-need-to-check-IPV6-in-rxe_find_route/20220822-192520
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
config: ia64-buildonly-randconfig-r005-20220822 (https://download.01.org/0day-ci/archive/20220823/202208230225.DS04ZlXH-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9d154e806104f75aae6c66dfd78ecd5e67c7e00d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Guoqing-Jiang/RDMA-rxe-No-need-to-check-IPV6-in-rxe_find_route/20220822-192520
        git checkout 9d154e806104f75aae6c66dfd78ecd5e67c7e00d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/infiniband/sw/rxe/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/infiniband/sw/rxe/rxe_net.c: In function 'rxe_find_route':
>> drivers/infiniband/sw/rxe/rxe_net.c:118:41: error: implicit declaration of function 'rt6_get_cookie' [-Werror=implicit-function-declaration]
     118 |                                         rt6_get_cookie((struct rt6_info *)dst);
         |                                         ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/rt6_get_cookie +118 drivers/infiniband/sw/rxe/rxe_net.c

8700e3e7c4857d Moni Shoua      2016-06-16   88  
3db2bceb29fd9a Parav Pandit    2018-08-28   89  static struct dst_entry *rxe_find_route(struct net_device *ndev,
4ed6ad1eb30e20 yonatanc        2017-04-20   90  					struct rxe_qp *qp,
4ed6ad1eb30e20 yonatanc        2017-04-20   91  					struct rxe_av *av)
4ed6ad1eb30e20 yonatanc        2017-04-20   92  {
4ed6ad1eb30e20 yonatanc        2017-04-20   93  	struct dst_entry *dst = NULL;
4ed6ad1eb30e20 yonatanc        2017-04-20   94  
4ed6ad1eb30e20 yonatanc        2017-04-20   95  	if (qp_type(qp) == IB_QPT_RC)
4ed6ad1eb30e20 yonatanc        2017-04-20   96  		dst = sk_dst_get(qp->sk->sk);
4ed6ad1eb30e20 yonatanc        2017-04-20   97  
b9109b7ddb13a5 Andrew Boyer    2017-08-28   98  	if (!dst || !dst_check(dst, qp->dst_cookie)) {
4ed6ad1eb30e20 yonatanc        2017-04-20   99  		if (dst)
4ed6ad1eb30e20 yonatanc        2017-04-20  100  			dst_release(dst);
4ed6ad1eb30e20 yonatanc        2017-04-20  101  
e0d696d201dd5d Jason Gunthorpe 2020-10-15  102  		if (av->network_type == RXE_NETWORK_TYPE_IPV4) {
4ed6ad1eb30e20 yonatanc        2017-04-20  103  			struct in_addr *saddr;
4ed6ad1eb30e20 yonatanc        2017-04-20  104  			struct in_addr *daddr;
4ed6ad1eb30e20 yonatanc        2017-04-20  105  
4ed6ad1eb30e20 yonatanc        2017-04-20  106  			saddr = &av->sgid_addr._sockaddr_in.sin_addr;
4ed6ad1eb30e20 yonatanc        2017-04-20  107  			daddr = &av->dgid_addr._sockaddr_in.sin_addr;
43c9fc509fa59d Martin Wilck    2018-02-14  108  			dst = rxe_find_route4(ndev, saddr, daddr);
e0d696d201dd5d Jason Gunthorpe 2020-10-15  109  		} else if (av->network_type == RXE_NETWORK_TYPE_IPV6) {
4ed6ad1eb30e20 yonatanc        2017-04-20  110  			struct in6_addr *saddr6;
4ed6ad1eb30e20 yonatanc        2017-04-20  111  			struct in6_addr *daddr6;
4ed6ad1eb30e20 yonatanc        2017-04-20  112  
4ed6ad1eb30e20 yonatanc        2017-04-20  113  			saddr6 = &av->sgid_addr._sockaddr_in6.sin6_addr;
4ed6ad1eb30e20 yonatanc        2017-04-20  114  			daddr6 = &av->dgid_addr._sockaddr_in6.sin6_addr;
43c9fc509fa59d Martin Wilck    2018-02-14  115  			dst = rxe_find_route6(ndev, saddr6, daddr6);
b9109b7ddb13a5 Andrew Boyer    2017-08-28  116  			if (dst)
b9109b7ddb13a5 Andrew Boyer    2017-08-28  117  				qp->dst_cookie =
b9109b7ddb13a5 Andrew Boyer    2017-08-28 @118  					rt6_get_cookie((struct rt6_info *)dst);
4ed6ad1eb30e20 yonatanc        2017-04-20  119  		}
24c937b39dfb10 Vijay Immanuel  2018-06-18  120  
24c937b39dfb10 Vijay Immanuel  2018-06-18  121  		if (dst && (qp_type(qp) == IB_QPT_RC)) {
24c937b39dfb10 Vijay Immanuel  2018-06-18  122  			dst_hold(dst);
24c937b39dfb10 Vijay Immanuel  2018-06-18  123  			sk_dst_set(qp->sk->sk, dst);
24c937b39dfb10 Vijay Immanuel  2018-06-18  124  		}
4ed6ad1eb30e20 yonatanc        2017-04-20  125  	}
4ed6ad1eb30e20 yonatanc        2017-04-20  126  	return dst;
4ed6ad1eb30e20 yonatanc        2017-04-20  127  }
4ed6ad1eb30e20 yonatanc        2017-04-20  128  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
