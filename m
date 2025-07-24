Return-Path: <linux-rdma+bounces-12460-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A27B10F24
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jul 2025 17:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFEE1AC452D
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jul 2025 15:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCF62EA142;
	Thu, 24 Jul 2025 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aas5qbSG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EA42EA47C;
	Thu, 24 Jul 2025 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372185; cv=none; b=EAnji8cu2fRkgnPAzKWctzWYA6dYL68u73P7c5AZ+Vad0qbCJKZFjT+uRGnfb536ROca+lWljdIA1aXTeOhXX+g+Pcd24BgQrwNV3XBj3WlJtX9y2QgmXnOyRK/7+3cHl/XNyp/zao6ZROHuLVKSjEMvBOt4pUgjRt26xE+SfIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372185; c=relaxed/simple;
	bh=sNJ2h6Ap7KFwg/ZbaSyay24DtDTQRIN/McCeI0fFGUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUnkNMMYwtSJ18wmWGJZ4mD6a0NqCEAFvpOyj9qy4OtKiBZTEUHHrFbMVCzUE6PSBFctLE2YY7oLTBr11mhs8KFoK5kBjInZtSfsyxBgouPNERMIsc3ETl+veEnixJgzGJT8Y3gz4yE9Ugbc7hoRiCazIsyuSRAIhPUQlW6yYJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aas5qbSG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753372185; x=1784908185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sNJ2h6Ap7KFwg/ZbaSyay24DtDTQRIN/McCeI0fFGUo=;
  b=aas5qbSG6l4iAjLuiVaYSYMs0Cq/YJ99AMY1dWF3jHqAMfv347Oklf/j
   u6H4Sv5gxMx/t0xAtslnyC0ChPVsfkSYrasSCufo9z7RiiE2I0QPpWiHT
   IYw8BRoDp7nppFq7VwwZG2QPC1RJPQadHv8AvVP6IGFPLF900UU0VXRGr
   lSclZXSwf5k/bNLhLonaYmTIzLwxJtr37MyojVHohSAvbldMA/IReBVWi
   9ScYu52ovZ7CYtUZqkFEhnLqJYqCF/3tVwZGudlD7RAW60AMg6MKe7skn
   EYaLSW374W04ICDbCUcFE/GIcC02pVK/WioX/ZkM4U8x+Y+H1gyrNQD6/
   g==;
X-CSE-ConnectionGUID: 1Q8qQjo/QbKgJC6vhzas1g==
X-CSE-MsgGUID: ld56rzFdRGGPWcUZve+veQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="54784187"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="54784187"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 08:49:44 -0700
X-CSE-ConnectionGUID: kaPTYs0OQ3ajAUsrZrNoZw==
X-CSE-MsgGUID: Nfo/aoShRnyGt7OS4nzvFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="160451160"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 24 Jul 2025 08:49:39 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueyCO-000KZr-1E;
	Thu, 24 Jul 2025 15:49:36 +0000
Date: Thu, 24 Jul 2025 23:49:11 +0800
From: kernel test robot <lkp@intel.com>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>, shannon.nelson@amd.com,
	brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, jgg@ziepe.ca,
	leon@kernel.org, andrew+netdev@lunn.ch
Cc: oe-kbuild-all@lists.linux.dev, allen.hubbe@amd.com,
	nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: Re: [PATCH v4 14/14] RDMA/ionic: Add Makefile/Kconfig to kernel
 build environment
Message-ID: <202507242337.xwu7Zm2I-lkp@intel.com>
References: <20250723173149.2568776-15-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723173149.2568776-15-abhijit.gangurde@amd.com>

Hi Abhijit,

kernel test robot noticed the following build errors:

[auto build test ERROR on e1bed9a94da86a7c01b985c2e9a030207269cbc7]

url:    https://github.com/intel-lab-lkp/linux/commits/Abhijit-Gangurde/net-ionic-Create-an-auxiliary-device-for-rdma-driver/20250724-014031
base:   e1bed9a94da86a7c01b985c2e9a030207269cbc7
patch link:    https://lore.kernel.org/r/20250723173149.2568776-15-abhijit.gangurde%40amd.com
patch subject: [PATCH v4 14/14] RDMA/ionic: Add Makefile/Kconfig to kernel build environment
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20250724/202507242337.xwu7Zm2I-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250724/202507242337.xwu7Zm2I-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507242337.xwu7Zm2I-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/infiniband/hw/ionic/ionic_ibdev.c:235:24: error: initialization of 'struct ib_mr * (*)(struct ib_pd *, u64,  u64,  u64,  int,  struct ib_dmah *, struct ib_udata *)' {aka 'struct ib_mr * (*)(struct ib_pd *, long long unsigned int,  long long unsigned int,  long long unsigned int,  int,  struct ib_dmah *, struct ib_udata *)'} from incompatible pointer type 'struct ib_mr * (*)(struct ib_pd *, u64,  u64,  u64,  int,  struct ib_udata *)' {aka 'struct ib_mr * (*)(struct ib_pd *, long long unsigned int,  long long unsigned int,  long long unsigned int,  int,  struct ib_udata *)'} [-Wincompatible-pointer-types]
     235 |         .reg_user_mr = ionic_reg_user_mr,
         |                        ^~~~~~~~~~~~~~~~~
   drivers/infiniband/hw/ionic/ionic_ibdev.c:235:24: note: (near initialization for 'ionic_dev_ops.reg_user_mr')
   In file included from drivers/infiniband/hw/ionic/ionic_ibdev.c:12:
   drivers/infiniband/hw/ionic/ionic_ibdev.h:469:15: note: 'ionic_reg_user_mr' declared here
     469 | struct ib_mr *ionic_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
         |               ^~~~~~~~~~~~~~~~~
>> drivers/infiniband/hw/ionic/ionic_ibdev.c:236:31: error: initialization of 'struct ib_mr * (*)(struct ib_pd *, u64,  u64,  u64,  int,  int,  struct ib_dmah *, struct uverbs_attr_bundle *)' {aka 'struct ib_mr * (*)(struct ib_pd *, long long unsigned int,  long long unsigned int,  long long unsigned int,  int,  int,  struct ib_dmah *, struct uverbs_attr_bundle *)'} from incompatible pointer type 'struct ib_mr * (*)(struct ib_pd *, u64,  u64,  u64,  int,  int,  struct uverbs_attr_bundle *)' {aka 'struct ib_mr * (*)(struct ib_pd *, long long unsigned int,  long long unsigned int,  long long unsigned int,  int,  int,  struct uverbs_attr_bundle *)'} [-Wincompatible-pointer-types]
     236 |         .reg_user_mr_dmabuf = ionic_reg_user_mr_dmabuf,
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/infiniband/hw/ionic/ionic_ibdev.c:236:31: note: (near initialization for 'ionic_dev_ops.reg_user_mr_dmabuf')
   drivers/infiniband/hw/ionic/ionic_ibdev.h:471:15: note: 'ionic_reg_user_mr_dmabuf' declared here
     471 | struct ib_mr *ionic_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 offset,
         |               ^~~~~~~~~~~~~~~~~~~~~~~~


vim +235 drivers/infiniband/hw/ionic/ionic_ibdev.c

5bac24d9a932cb6 Abhijit Gangurde 2025-07-23  218  
2dd4118243d6859 Abhijit Gangurde 2025-07-23  219  static const struct ib_device_ops ionic_dev_ops = {
2dd4118243d6859 Abhijit Gangurde 2025-07-23  220  	.owner = THIS_MODULE,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  221  	.driver_id = RDMA_DRIVER_IONIC,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  222  	.uverbs_abi_ver = IONIC_ABI_VERSION,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  223  
2dd4118243d6859 Abhijit Gangurde 2025-07-23  224  	.alloc_ucontext = ionic_alloc_ucontext,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  225  	.dealloc_ucontext = ionic_dealloc_ucontext,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  226  	.mmap = ionic_mmap,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  227  	.mmap_free = ionic_mmap_free,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  228  	.alloc_pd = ionic_alloc_pd,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  229  	.dealloc_pd = ionic_dealloc_pd,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  230  	.create_ah = ionic_create_ah,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  231  	.query_ah = ionic_query_ah,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  232  	.destroy_ah = ionic_destroy_ah,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  233  	.create_user_ah = ionic_create_ah,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  234  	.get_dma_mr = ionic_get_dma_mr,
2dd4118243d6859 Abhijit Gangurde 2025-07-23 @235  	.reg_user_mr = ionic_reg_user_mr,
2dd4118243d6859 Abhijit Gangurde 2025-07-23 @236  	.reg_user_mr_dmabuf = ionic_reg_user_mr_dmabuf,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  237  	.dereg_mr = ionic_dereg_mr,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  238  	.alloc_mr = ionic_alloc_mr,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  239  	.map_mr_sg = ionic_map_mr_sg,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  240  	.alloc_mw = ionic_alloc_mw,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  241  	.dealloc_mw = ionic_dealloc_mw,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  242  	.create_cq = ionic_create_cq,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  243  	.destroy_cq = ionic_destroy_cq,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  244  	.create_qp = ionic_create_qp,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  245  	.modify_qp = ionic_modify_qp,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  246  	.query_qp = ionic_query_qp,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  247  	.destroy_qp = ionic_destroy_qp,
2dd4118243d6859 Abhijit Gangurde 2025-07-23  248  
423894d5361e62f Abhijit Gangurde 2025-07-23  249  	.post_send = ionic_post_send,
423894d5361e62f Abhijit Gangurde 2025-07-23  250  	.post_recv = ionic_post_recv,
423894d5361e62f Abhijit Gangurde 2025-07-23  251  	.poll_cq = ionic_poll_cq,
423894d5361e62f Abhijit Gangurde 2025-07-23  252  	.req_notify_cq = ionic_req_notify_cq,
423894d5361e62f Abhijit Gangurde 2025-07-23  253  
5bac24d9a932cb6 Abhijit Gangurde 2025-07-23  254  	.query_device = ionic_query_device,
5bac24d9a932cb6 Abhijit Gangurde 2025-07-23  255  	.query_port = ionic_query_port,
5bac24d9a932cb6 Abhijit Gangurde 2025-07-23  256  	.get_link_layer = ionic_get_link_layer,
5bac24d9a932cb6 Abhijit Gangurde 2025-07-23  257  	.query_pkey = ionic_query_pkey,
5bac24d9a932cb6 Abhijit Gangurde 2025-07-23  258  	.modify_device = ionic_modify_device,
5bac24d9a932cb6 Abhijit Gangurde 2025-07-23  259  	.get_port_immutable = ionic_get_port_immutable,
5bac24d9a932cb6 Abhijit Gangurde 2025-07-23  260  	.get_dev_fw_str = ionic_get_dev_fw_str,
5bac24d9a932cb6 Abhijit Gangurde 2025-07-23  261  	.get_vector_affinity = ionic_get_vector_affinity,
5bac24d9a932cb6 Abhijit Gangurde 2025-07-23  262  	.device_group = &ionic_rdma_attr_group,
5bac24d9a932cb6 Abhijit Gangurde 2025-07-23  263  	.disassociate_ucontext = ionic_disassociate_ucontext,
5bac24d9a932cb6 Abhijit Gangurde 2025-07-23  264  
2dd4118243d6859 Abhijit Gangurde 2025-07-23  265  	INIT_RDMA_OBJ_SIZE(ib_ucontext, ionic_ctx, ibctx),
2dd4118243d6859 Abhijit Gangurde 2025-07-23  266  	INIT_RDMA_OBJ_SIZE(ib_pd, ionic_pd, ibpd),
2dd4118243d6859 Abhijit Gangurde 2025-07-23  267  	INIT_RDMA_OBJ_SIZE(ib_ah, ionic_ah, ibah),
2dd4118243d6859 Abhijit Gangurde 2025-07-23  268  	INIT_RDMA_OBJ_SIZE(ib_cq, ionic_vcq, ibcq),
2dd4118243d6859 Abhijit Gangurde 2025-07-23  269  	INIT_RDMA_OBJ_SIZE(ib_qp, ionic_qp, ibqp),
2dd4118243d6859 Abhijit Gangurde 2025-07-23  270  	INIT_RDMA_OBJ_SIZE(ib_mw, ionic_mr, ibmw),
2dd4118243d6859 Abhijit Gangurde 2025-07-23  271  };
2dd4118243d6859 Abhijit Gangurde 2025-07-23  272  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

