Return-Path: <linux-rdma+bounces-15165-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD39CD7252
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 21:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B03430285C5
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 20:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3BE30C343;
	Mon, 22 Dec 2025 20:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Imq7yQuJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C142D0606;
	Mon, 22 Dec 2025 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766436644; cv=none; b=PT9fxTtUj5F3X81Z6LC8vgPckScdDEwv168RXg/HG29SSTzn3zb5ezr+bTqe3q+lx52CZqmklgHYG4bAkbeBkMbf0UNwite3n/DV5xKZyBDHrEaoiVUI26gPCiuQS3H1B1blvkfCs5xAskGzuoeo0bgCKNumx0PC+y9pmmcixxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766436644; c=relaxed/simple;
	bh=Zvqi5xQ4MFDavqSnyNRsyO7BhhjiJQNzY2OWmWHDbVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOPbz71qcJnFq2qLXe35WW/Y1XFd/3uEdstmjF1n4TuM/aI3dse0xQm1c+xNoYjsnS0bj4fByb/AdOHIuyhyTah7ifWXOSurqMRYHJIgUMhcLz6qJ3dOiO9VKexrjO5js1KQg5zuA8e3KEgrjf/hnxfFCfSe1libSqLgCM4z9Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Imq7yQuJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766436642; x=1797972642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zvqi5xQ4MFDavqSnyNRsyO7BhhjiJQNzY2OWmWHDbVQ=;
  b=Imq7yQuJTFaFxFOpawyQjpjpAsb3j91Ow3vhcptFA85yn7kMVM0Cp1z7
   RS1WO8F+3Pb8U2viVeIWgCTi633JQDwudbaul/5BvcpsQrtaLKG/xikCQ
   Hy5KgAHh88CxlqL3NbE8VTh+q3rB/5w2ZkQrUsioguvydZfJBM8NKzeAO
   HPhlt0qg1Rg27eA2UzQUqoIKn5bywWNE2fGjhQT/XyWArfr7007bGMP+5
   K3nNvo6HYwkUt7nuKfjbycgpS2s8RYTDmAFNBXnqwwFhlq5SXcIibbL0N
   5DmIeZso/JK/SN2MyfKoDObC9Hy8oJ0eGffHwzZsBgB0RNqSk8ZwzKOft
   Q==;
X-CSE-ConnectionGUID: oOqZEo3NQvmWBQzkOo/w9g==
X-CSE-MsgGUID: 6fpF02MaRA20Ga0twq7SrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="70871952"
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="70871952"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 12:50:41 -0800
X-CSE-ConnectionGUID: nT72CQu4QnGtDzq3W2AFEQ==
X-CSE-MsgGUID: NjFi6cv2QGKWnryxLNRXTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="204139489"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 22 Dec 2025 12:50:40 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXmrN-00000000161-43SP;
	Mon, 22 Dec 2025 20:50:31 +0000
Date: Tue, 23 Dec 2025 04:49:38 +0800
From: kernel test robot <lkp@intel.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>, zyjzyj2000@gmail.com, jgg@ziepe.ca,
	leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 2/2] RDMA/rxe: Replace struct rxe_sge with struct
 ib_sge
Message-ID: <202512230416.lX0ue12Z-lkp@intel.com>
References: <20251221233404.332108-2-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221233404.332108-2-yanjun.zhu@linux.dev>

Hi Zhu,

kernel test robot noticed the following build errors:

[auto build test ERROR on rdma/for-next]
[also build test ERROR on linus/master v6.19-rc2 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhu-Yanjun/RDMA-rxe-Replace-struct-rxe_sge-with-struct-ib_sge/20251222-074206
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20251221233404.332108-2-yanjun.zhu%40linux.dev
patch subject: [PATCH v2 2/2] RDMA/rxe: Replace struct rxe_sge with struct ib_sge
config: x86_64-buildonly-randconfig-006-20251222 (https://download.01.org/0day-ci/archive/20251223/202512230416.lX0ue12Z-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251223/202512230416.lX0ue12Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512230416.lX0ue12Z-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/rdma/rdma_user_rxe.h:141:3: error: array has incomplete element type 'struct ib_sge'
     141 |                 __DECLARE_FLEX_ARRAY(struct ib_sge, sge);
         |                 ^
   usr/include/linux/stddef.h:56:12: note: expanded from macro '__DECLARE_FLEX_ARRAY'
      56 |                 TYPE NAME[]; \
         |                          ^
   ./usr/include/rdma/rdma_user_rxe.h:141:31: note: forward declaration of 'struct ib_sge'
     141 |                 __DECLARE_FLEX_ARRAY(struct ib_sge, sge);
         |                                             ^
   1 error generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

