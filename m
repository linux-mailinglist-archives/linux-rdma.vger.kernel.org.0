Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F67F53F816
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jun 2022 10:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiFGIWw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jun 2022 04:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiFGIWv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jun 2022 04:22:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9E9647F
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jun 2022 01:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654590170; x=1686126170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KfBu+40CHuSwNPwvJbAfdJ/754vKKtUQFq7jEjcR2YU=;
  b=FHqNabOsYqlRQ5ppgRJB7BHNOePxarA53/sPbxUycAYI9uSn18xnjONE
   AyhxmgN87pP/h+cwD+l1EMXZrIyIp1PhplxYyVs/gSi00Y0UIRmgL5jKf
   jiQMEYmFbt62KgCrbd+pfbi2MDaTxJXDvCCynblAtLTHv21j6CkRSrzMx
   MMr2eZ8gS+03DWEe+nib4hzer+W+knJ3i1YmdSg4JAsguSUJOXSYnyU/o
   /XlvkFPMH6ex4iCYid1ltr4Cp0UZKerVJ9rOh0n4SER+R3K76h+qiaOl4
   c4iAsEjUkbVIuFSWZK9x4/63jr0R09+2lCEhDPb4z1fjeA3G40NlxPEaA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="274249272"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="274249272"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 01:22:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="826257090"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jun 2022 01:22:48 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyUUB-000DVl-EW;
        Tue, 07 Jun 2022 08:22:47 +0000
Date:   Tue, 7 Jun 2022 16:21:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gerd Rausch <gerd.rausch@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/addr: Refresh neighbour entries upon
 "rdma_resolve_addr"
Message-ID: <202206071656.1c2rEvO3-lkp@intel.com>
References: <eb4e348ec730900a47caeeb08fe4aff903337675.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb4e348ec730900a47caeeb08fe4aff903337675.camel@oracle.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Gerd,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v5.19-rc1 next-20220607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Gerd-Rausch/RDMA-addr-Refresh-neighbour-entries-upon-rdma_resolve_addr/20220607-033902
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220607/202206071656.1c2rEvO3-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://github.com/intel-lab-lkp/linux/commit/b804d2f0ef3768bdf684b2769f8d9fd1306476e7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gerd-Rausch/RDMA-addr-Refresh-neighbour-entries-upon-rdma_resolve_addr/20220607-033902
        git checkout b804d2f0ef3768bdf684b2769f8d9fd1306476e7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/infiniband/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/infiniband/core/addr.c:425:56: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] key @@     got restricted __be32 [usertype] dst_ip @@
   drivers/infiniband/core/addr.c:425:56: sparse:     expected unsigned int [usertype] key
   drivers/infiniband/core/addr.c:425:56: sparse:     got restricted __be32 [usertype] dst_ip

vim +425 drivers/infiniband/core/addr.c

   383	
   384	static int addr4_resolve(struct sockaddr *src_sock,
   385				 const struct sockaddr *dst_sock,
   386				 struct rdma_dev_addr *addr,
   387				 struct rtable **prt)
   388	{
   389		struct sockaddr_in *src_in = (struct sockaddr_in *)src_sock;
   390		const struct sockaddr_in *dst_in =
   391				(const struct sockaddr_in *)dst_sock;
   392	
   393		__be32 src_ip = src_in->sin_addr.s_addr;
   394		__be32 dst_ip = dst_in->sin_addr.s_addr;
   395		struct rtable *rt;
   396		struct flowi4 fl4;
   397		struct net_device *dev;
   398		struct neighbour *neigh;
   399		int ret;
   400	
   401		memset(&fl4, 0, sizeof(fl4));
   402		fl4.daddr = dst_ip;
   403		fl4.saddr = src_ip;
   404		fl4.flowi4_oif = addr->bound_dev_if;
   405		rt = ip_route_output_key(addr->net, &fl4);
   406		ret = PTR_ERR_OR_ZERO(rt);
   407		if (ret)
   408			return ret;
   409	
   410		src_in->sin_addr.s_addr = fl4.saddr;
   411	
   412		addr->hoplimit = ip4_dst_hoplimit(&rt->dst);
   413	
   414		/* trigger ARP-entry refresh if necessary,
   415		 * the same way "ip_finish_output2" does
   416		 */
   417		if (addr->bound_dev_if) {
   418			dev = dev_get_by_index(addr->net, addr->bound_dev_if);
   419		} else {
   420			dev = rt->dst.dev;
   421			dev_hold(dev);
   422		}
   423		if (dev) {
   424			rcu_read_lock_bh();
 > 425			neigh = __ipv4_neigh_lookup_noref(dev, dst_ip);
   426			if (neigh)
   427				neigh_event_send(neigh, NULL);
   428			rcu_read_unlock_bh();
   429			dev_put(dev);
   430		}
   431	
   432		*prt = rt;
   433		return 0;
   434	}
   435	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
