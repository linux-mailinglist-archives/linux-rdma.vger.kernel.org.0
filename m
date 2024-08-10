Return-Path: <linux-rdma+bounces-4293-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AAD94DA2A
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Aug 2024 04:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F442825A3
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Aug 2024 02:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAFA139CEE;
	Sat, 10 Aug 2024 02:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DpGDdz8Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F5B13211F
	for <linux-rdma@vger.kernel.org>; Sat, 10 Aug 2024 02:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723257347; cv=none; b=NysYilgnCo9fmf3xJRpEZPgR9eGvfudfOCCZqGzEzwqGCmMEtutMuSFBvudfGFFw9wMVHnxuGekPbtk0ZRoanldzEbvDc4TOIilTp0upwgjem9rNgizQC3HPirujOY02dfJEVTuM9KiNjO4Mh8JkYxtqhBfyUskumpvqXgOAz6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723257347; c=relaxed/simple;
	bh=bHAfvRQVCW2WoXLJQwLJ3Obk6dkiANrFkG2jTPUkdBU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J9plRaaMJLAarP4Kho5JMuIjCat5yM57yBCffelY6ajFpyJgvrLv+mSUs8p+lHY5qQs/Hx0UXOAytcuEagHH0HYNWguhJnN5H+Dmkz2oAzOKk9MRYZ0EibDRQlVGcGPhNSpwJqfKDYK27hAeDL202gLJW+rn//RZx6HzuyNrav4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DpGDdz8Y; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723257344; x=1754793344;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bHAfvRQVCW2WoXLJQwLJ3Obk6dkiANrFkG2jTPUkdBU=;
  b=DpGDdz8YoR+/wnsAwFEU+ZOLfzfIrRJSOB7Q5DQlqZ2RNjrT9fRY9Ahx
   XVvCQW3kFmzbd1fOFcMrgvgIc4hZjz5YtrbacJDafdJqNNWcZDWnfjCtq
   oPvfmoR9uJeH6E9T5OHSHniuubw+gE1r9CkAHODxXISiDT9zDYiYVECVl
   n1m2Xv57ytpgYTBZI53wYnBikulJUMq4ElFt238Q8yq0kLs1NZ3XE+q9W
   eHb7bMLLqEzaepxxJlXd8VlZ1g/xSDE8Zn6o77JkWZI3dCVmfUIh0UcNK
   wFFMpZx5d+F90Rw9hjsNMQPYcdfJDl3sDWzbh0yQj9fxcQcBn7tSEtpwx
   g==;
X-CSE-ConnectionGUID: yLApQDFXT+SM49EwbsUAwg==
X-CSE-MsgGUID: t4/VkKilRP2jE6shnmCPOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21253200"
X-IronPort-AV: E=Sophos;i="6.09,278,1716274800"; 
   d="scan'208";a="21253200"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 19:35:44 -0700
X-CSE-ConnectionGUID: x5rnoTUyQWiu3iEW7RjTOg==
X-CSE-MsgGUID: hRfKanXTRYCChVW1NKfclA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,278,1716274800"; 
   d="scan'208";a="88385950"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 09 Aug 2024 19:35:41 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scbwF-0009WB-1O;
	Sat, 10 Aug 2024 02:34:51 +0000
Date: Sat, 10 Aug 2024 10:34:21 +0800
From: kernel test robot <lkp@intel.com>
To: Chengchang Tang <tangchengchang@huawei.com>
Cc: oe-kbuild-all@lists.linux.dev, Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	Junxian Huang <huangjunxian6@hisilicon.com>
Subject: [rdma:wip/leon-for-next 4/8] ib_core_uverbs.c:undefined reference to
 `zap_vma_ptes'
Message-ID: <202408101048.12TWk54A-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
head:   d222b19c595f63d0537273c638a290c7eb2c0f02
commit: 577b3696166ab0f6a3eab1bf2a6a28ec8b5b8932 [4/8] RDMA/core: Provide rdma_user_mmap_disassociate() to disassociate mmap pages
config: m68k-randconfig-r052-20240810 (https://download.01.org/0day-ci/archive/20240810/202408101048.12TWk54A-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240810/202408101048.12TWk54A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408101048.12TWk54A-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_submit_intr_urb':
   btmtk.c:(.text+0x618): undefined reference to `usb_alloc_urb'
   m68k-linux-ld: btmtk.c:(.text+0x62c): undefined reference to `usb_free_urb'
   m68k-linux-ld: btmtk.c:(.text+0x6e4): undefined reference to `usb_anchor_urb'
   m68k-linux-ld: btmtk.c:(.text+0x6ee): undefined reference to `usb_submit_urb'
   m68k-linux-ld: btmtk.c:(.text+0x734): undefined reference to `usb_unanchor_urb'
   m68k-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_submit_wmt_recv_urb':
   btmtk.c:(.text+0x76c): undefined reference to `usb_alloc_urb'
   m68k-linux-ld: btmtk.c:(.text+0x798): undefined reference to `usb_free_urb'
   m68k-linux-ld: btmtk.c:(.text+0x878): undefined reference to `usb_anchor_urb'
   m68k-linux-ld: btmtk.c:(.text+0x884): undefined reference to `usb_submit_urb'
   m68k-linux-ld: btmtk.c:(.text+0x8ca): undefined reference to `usb_unanchor_urb'
   m68k-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_suspend':
   btmtk.c:(.text+0x8ea): undefined reference to `usb_kill_anchored_urbs'
   m68k-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_uhw_reg_write':
   btmtk.c:(.text+0xd60): undefined reference to `usb_control_msg'
   m68k-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_uhw_reg_read':
   btmtk.c:(.text+0xe02): undefined reference to `usb_control_msg'
   m68k-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_wmt_recv':
   btmtk.c:(.text+0xff0): undefined reference to `usb_anchor_urb'
   m68k-linux-ld: btmtk.c:(.text+0xffc): undefined reference to `usb_submit_urb'
   m68k-linux-ld: btmtk.c:(.text+0x104e): undefined reference to `usb_unanchor_urb'
   m68k-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_intr_complete':
   btmtk.c:(.text+0x11c2): undefined reference to `usb_anchor_urb'
   m68k-linux-ld: btmtk.c:(.text+0x11ce): undefined reference to `usb_submit_urb'
   m68k-linux-ld: btmtk.c:(.text+0x121e): undefined reference to `usb_unanchor_urb'
   m68k-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_isointf_init.constprop.0':
   btmtk.c:(.text+0x12bc): undefined reference to `usb_set_interface'
   m68k-linux-ld: btmtk.c:(.text+0x1304): undefined reference to `usb_kill_anchored_urbs'
   m68k-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_reg_read':
   btmtk.c:(.text+0x1470): undefined reference to `usb_control_msg'
   m68k-linux-ld: drivers/bluetooth/btmtk.o: in function `alloc_mtk_intr_urb':
   btmtk.c:(.text+0x1d76): undefined reference to `usb_alloc_urb'
   m68k-linux-ld: drivers/infiniband/core/ib_core_uverbs.o: in function `uverbs_user_mmap_disassociate':
>> ib_core_uverbs.c:(.text+0x648): undefined reference to `zap_vma_ptes'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

