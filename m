Return-Path: <linux-rdma+bounces-4929-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407A19777E7
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 06:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB7F284B70
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 04:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089AD1C68A3;
	Fri, 13 Sep 2024 04:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JHtX2ZyK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D961C2DC1;
	Fri, 13 Sep 2024 04:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726201659; cv=none; b=gYUcXych8geF/0/TQWgeSUsHF9IzM+ZVylOj31griIVd2lmsOrPtTJK8s2O5D3Wb8DfPCokzRg1Z004sJlwXO3kD2pKR6rnGHe6phtrEZLqklEOt4rtlg3ciX6ZjjXwV+wB+elfV5kf5ZIkkWQ268L0cJRi+1mqNZsdi01VGT5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726201659; c=relaxed/simple;
	bh=tbKUVez8SwkZSBzbLioNUgUfCc/l7sq/rOH7qiyc8ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipdpDD9nOCpzGgbjtsqNeCyL4hBQdqvS4uv0HCWI+qfTqZQHkJyI5BO7qpiBD7ozvDIseoVcNzt+qNIfUkMhRGWErJDTaQfwjbV6dIQ3lT7Ktj9uqMgHOpzg9/e2k/WK/HpAuTIhbDfYzIu/swBZT5VqOBeKAHWH6AeNFL7SAFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JHtX2ZyK; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726201657; x=1757737657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tbKUVez8SwkZSBzbLioNUgUfCc/l7sq/rOH7qiyc8ew=;
  b=JHtX2ZyKLAbd+F+fTvaRd5Ic9zcC9gdF3fx4zmVyPJmLSB8rJoyd2nLN
   X7H/fL3+NKU+ukbH2qKCTRycyWGUy1cdlqvYD5YBesPsB4RwByDCkTK7R
   QZ8FpRv70VxRsSld9JBxmFlvtM58B1xWOQAJzlah2ElPZ9I2TlnN3j3ex
   SExi+BNtPzoCU8IXVpRJhDfQEWfVVwpagUvyq13TKIR1nvzPsK1d1Xfqr
   /VpTbJ+vQkjAwc8ir7rVpeSlCdf832hZ+jLJMOnYg6dN7R43TMJLvlOcw
   2vy18Se56sAIqRhtfsg+O9rfLCiRE+Nz/ELF4nxTiZly0eT2NzrFR2y6d
   Q==;
X-CSE-ConnectionGUID: W5l7Nr5NRmCrH/nCT969zw==
X-CSE-MsgGUID: 6JMfmj1nTK+GHMKtFXKjBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24964578"
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="24964578"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 21:27:37 -0700
X-CSE-ConnectionGUID: lIgpTRjfTuy1UtoCTbLbxA==
X-CSE-MsgGUID: dhoszQ9qQNG3YtMwXpmvQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="98624621"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 12 Sep 2024 21:27:34 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soxu7-00060l-2K;
	Fri, 13 Sep 2024 04:27:31 +0000
Date: Fri, 13 Sep 2024 12:26:46 +0800
From: kernel test robot <lkp@intel.com>
To: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>,
	Ido Schimmel <idosch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] mlx4: Use MLX4_ATTR_CABLE_INFO instead of
 0xFF60 magic value
Message-ID: <202409131225.ZqIX7nce-lkp@intel.com>
References: <12a1d143-35d6-43f3-b8b3-ab0198f5540a@ans.pl>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12a1d143-35d6-43f3-b8b3-ab0198f5540a@ans.pl>

Hi Krzysztof,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Krzysztof-Ol-dzki/mlx4-Use-MLX4_ATTR_CABLE_INFO-instead-of-0xFF60-magic-value/20240912-144426
base:   net-next/main
patch link:    https://lore.kernel.org/r/12a1d143-35d6-43f3-b8b3-ab0198f5540a%40ans.pl
patch subject: [PATCH net-next 2/4] mlx4: Use MLX4_ATTR_CABLE_INFO instead of 0xFF60 magic value
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240913/202409131225.ZqIX7nce-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240913/202409131225.ZqIX7nce-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409131225.ZqIX7nce-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/infiniband/hw/mlx4/main.c: In function 'ib_link_query_port':
>> drivers/infiniband/hw/mlx4/main.c:722:35: error: 'MLX4_ATTR_EXTENDED_PORT_INFO' undeclared (first use in this function)
     722 |                 in_mad->attr_id = MLX4_ATTR_EXTENDED_PORT_INFO;
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/infiniband/hw/mlx4/main.c:722:35: note: each undeclared identifier is reported only once for each function it appears in


vim +/MLX4_ATTR_EXTENDED_PORT_INFO +722 drivers/infiniband/hw/mlx4/main.c

225c7b1feef1b4 Roland Dreier    2007-05-08  654  
1fb7f8973f51ca Mark Bloch       2021-03-01  655  static int ib_link_query_port(struct ib_device *ibdev, u32 port,
0a9a01884d447c Jack Morgenstein 2012-08-03  656  			      struct ib_port_attr *props, int netw_view)
fa417f7b520ee6 Eli Cohen        2010-10-24  657  {
a45e5f1859579f Ruan Jinjie      2023-07-28  658  	struct ib_smp *in_mad;
a45e5f1859579f Ruan Jinjie      2023-07-28  659  	struct ib_smp *out_mad;
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  660  	int ext_active_speed;
0a9a01884d447c Jack Morgenstein 2012-08-03  661  	int mad_ifc_flags = MLX4_MAD_IFC_IGNORE_KEYS;
a9c766bb75ee2c Or Gerlitz       2012-01-11  662  	int err = -ENOMEM;
a9c766bb75ee2c Or Gerlitz       2012-01-11  663  
a9c766bb75ee2c Or Gerlitz       2012-01-11  664  	in_mad  = kzalloc(sizeof *in_mad, GFP_KERNEL);
a9c766bb75ee2c Or Gerlitz       2012-01-11  665  	out_mad = kmalloc(sizeof *out_mad, GFP_KERNEL);
a9c766bb75ee2c Or Gerlitz       2012-01-11  666  	if (!in_mad || !out_mad)
a9c766bb75ee2c Or Gerlitz       2012-01-11  667  		goto out;
a9c766bb75ee2c Or Gerlitz       2012-01-11  668  
d82e2b27ad3a4f Leon Romanovsky  2022-01-05  669  	ib_init_query_mad(in_mad);
a9c766bb75ee2c Or Gerlitz       2012-01-11  670  	in_mad->attr_id  = IB_SMP_ATTR_PORT_INFO;
a9c766bb75ee2c Or Gerlitz       2012-01-11  671  	in_mad->attr_mod = cpu_to_be32(port);
a9c766bb75ee2c Or Gerlitz       2012-01-11  672  
0a9a01884d447c Jack Morgenstein 2012-08-03  673  	if (mlx4_is_mfunc(to_mdev(ibdev)->dev) && netw_view)
0a9a01884d447c Jack Morgenstein 2012-08-03  674  		mad_ifc_flags |= MLX4_MAD_IFC_NET_VIEW;
0a9a01884d447c Jack Morgenstein 2012-08-03  675  
0a9a01884d447c Jack Morgenstein 2012-08-03  676  	err = mlx4_MAD_IFC(to_mdev(ibdev), mad_ifc_flags, port, NULL, NULL,
a9c766bb75ee2c Or Gerlitz       2012-01-11  677  				in_mad, out_mad);
a9c766bb75ee2c Or Gerlitz       2012-01-11  678  	if (err)
a9c766bb75ee2c Or Gerlitz       2012-01-11  679  		goto out;
a9c766bb75ee2c Or Gerlitz       2012-01-11  680  
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  681  
225c7b1feef1b4 Roland Dreier    2007-05-08  682  	props->lid		= be16_to_cpup((__be16 *) (out_mad->data + 16));
225c7b1feef1b4 Roland Dreier    2007-05-08  683  	props->lmc		= out_mad->data[34] & 0x7;
225c7b1feef1b4 Roland Dreier    2007-05-08  684  	props->sm_lid		= be16_to_cpup((__be16 *) (out_mad->data + 18));
225c7b1feef1b4 Roland Dreier    2007-05-08  685  	props->sm_sl		= out_mad->data[36] & 0xf;
225c7b1feef1b4 Roland Dreier    2007-05-08  686  	props->state		= out_mad->data[32] & 0xf;
225c7b1feef1b4 Roland Dreier    2007-05-08  687  	props->phys_state	= out_mad->data[33] >> 4;
225c7b1feef1b4 Roland Dreier    2007-05-08  688  	props->port_cap_flags	= be32_to_cpup((__be32 *) (out_mad->data + 20));
0a9a01884d447c Jack Morgenstein 2012-08-03  689  	if (netw_view)
0a9a01884d447c Jack Morgenstein 2012-08-03  690  		props->gid_tbl_len = out_mad->data[50];
0a9a01884d447c Jack Morgenstein 2012-08-03  691  	else
5ae2a7a836be66 Roland Dreier    2007-06-18  692  		props->gid_tbl_len = to_mdev(ibdev)->dev->caps.gid_table_len[port];
149983af609e8f Dotan Barak      2007-06-26  693  	props->max_msg_sz	= to_mdev(ibdev)->dev->caps.max_msg_sz;
5ae2a7a836be66 Roland Dreier    2007-06-18  694  	props->pkey_tbl_len	= to_mdev(ibdev)->dev->caps.pkey_table_len[port];
225c7b1feef1b4 Roland Dreier    2007-05-08  695  	props->bad_pkey_cntr	= be16_to_cpup((__be16 *) (out_mad->data + 46));
225c7b1feef1b4 Roland Dreier    2007-05-08  696  	props->qkey_viol_cntr	= be16_to_cpup((__be16 *) (out_mad->data + 48));
225c7b1feef1b4 Roland Dreier    2007-05-08  697  	props->active_width	= out_mad->data[31] & 0xf;
225c7b1feef1b4 Roland Dreier    2007-05-08  698  	props->active_speed	= out_mad->data[35] >> 4;
225c7b1feef1b4 Roland Dreier    2007-05-08  699  	props->max_mtu		= out_mad->data[41] & 0xf;
225c7b1feef1b4 Roland Dreier    2007-05-08  700  	props->active_mtu	= out_mad->data[36] >> 4;
225c7b1feef1b4 Roland Dreier    2007-05-08  701  	props->subnet_timeout	= out_mad->data[51] & 0x1f;
225c7b1feef1b4 Roland Dreier    2007-05-08  702  	props->max_vl_num	= out_mad->data[37] >> 4;
225c7b1feef1b4 Roland Dreier    2007-05-08  703  	props->init_type_reply	= out_mad->data[41] >> 4;
225c7b1feef1b4 Roland Dreier    2007-05-08  704  
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  705  	/* Check if extended speeds (EDR/FDR/...) are supported */
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  706  	if (props->port_cap_flags & IB_PORT_EXTENDED_SPEEDS_SUP) {
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  707  		ext_active_speed = out_mad->data[62] >> 4;
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  708  
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  709  		switch (ext_active_speed) {
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  710  		case 1:
2e96691c31ecf7 Or Gerlitz       2012-02-28  711  			props->active_speed = IB_SPEED_FDR;
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  712  			break;
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  713  		case 2:
2e96691c31ecf7 Or Gerlitz       2012-02-28  714  			props->active_speed = IB_SPEED_EDR;
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  715  			break;
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  716  		}
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  717  	}
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  718  
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  719  	/* If reported active speed is QDR, check if is FDR-10 */
2e96691c31ecf7 Or Gerlitz       2012-02-28  720  	if (props->active_speed == IB_SPEED_QDR) {
d82e2b27ad3a4f Leon Romanovsky  2022-01-05  721  		ib_init_query_mad(in_mad);
a5e12dff757b56 Marcel Apfelbaum 2011-10-03 @722  		in_mad->attr_id = MLX4_ATTR_EXTENDED_PORT_INFO;
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  723  		in_mad->attr_mod = cpu_to_be32(port);
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  724  
0a9a01884d447c Jack Morgenstein 2012-08-03  725  		err = mlx4_MAD_IFC(to_mdev(ibdev), mad_ifc_flags, port,
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  726  				   NULL, NULL, in_mad, out_mad);
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  727  		if (err)
bf6b47deb40f9f Jesper Juhl      2012-04-11  728  			goto out;
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  729  
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  730  		/* Checking LinkSpeedActive for FDR-10 */
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  731  		if (out_mad->data[15] & 0x1)
2e96691c31ecf7 Or Gerlitz       2012-02-28  732  			props->active_speed = IB_SPEED_FDR10;
a5e12dff757b56 Marcel Apfelbaum 2011-10-03  733  	}
d2ef406866620f Or Gerlitz       2012-04-02  734  
d2ef406866620f Or Gerlitz       2012-04-02  735  	/* Avoid wrong speed value returned by FW if the IB link is down. */
d2ef406866620f Or Gerlitz       2012-04-02  736  	if (props->state == IB_PORT_DOWN)
d2ef406866620f Or Gerlitz       2012-04-02  737  		 props->active_speed = IB_SPEED_SDR;
d2ef406866620f Or Gerlitz       2012-04-02  738  
a9c766bb75ee2c Or Gerlitz       2012-01-11  739  out:
a9c766bb75ee2c Or Gerlitz       2012-01-11  740  	kfree(in_mad);
a9c766bb75ee2c Or Gerlitz       2012-01-11  741  	kfree(out_mad);
a9c766bb75ee2c Or Gerlitz       2012-01-11  742  	return err;
fa417f7b520ee6 Eli Cohen        2010-10-24  743  }
fa417f7b520ee6 Eli Cohen        2010-10-24  744  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

