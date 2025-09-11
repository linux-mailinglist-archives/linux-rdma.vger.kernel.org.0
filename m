Return-Path: <linux-rdma+bounces-13260-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4187B52526
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 02:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E313C3AAEDC
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 00:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B947A1DF25C;
	Thu, 11 Sep 2025 00:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wl5+Y0WJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D841B87E8;
	Thu, 11 Sep 2025 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757551827; cv=none; b=qcUNAoMqjERU9jyVfDUw1pGK5/qRsXjF+S14vohg+mrPC3LSAjT4MyjYMvmatlO3iVb7h2SZSQvVS1bGCYduZQV8jBWahlfN79QanRjErsgVTAf0D4imArlpQePA3yb51+VGPPn34OpTtoav+5g1LXgbt6Jt+nrQKu3buzQPXFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757551827; c=relaxed/simple;
	bh=A76aGIR2EwfWFfUwX1es0QXy0rQMc78ou968n8hgkac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofiNo99xS9Ilj8AFHC5cSkL5shf4lfK76JYxxw7ga6HqTW9Ak/+egkOaja8SToI78DpP1k3LHtyrI++Tkx81bdLJh1LQDhNYgklR+1qm/eVEhYzc4NJd3EOu+QlY2cD1dfwnCAxXHyV9Ue3bTKbMtZUew4NBYRFxlFG8CRZUTto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wl5+Y0WJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757551825; x=1789087825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=A76aGIR2EwfWFfUwX1es0QXy0rQMc78ou968n8hgkac=;
  b=Wl5+Y0WJfJT4KUjZpNOyJf4NEaLCx3smEjSqb7ZqnTXnPFoYZZLRMEmM
   rKj9Fzn48h86J15p/ODbeEN+G6ZYx7tF/nFkC2OTt6637odhEwTSqd/yS
   yd5ETHp2TqUCRzR2MiRKu9dIHZfiYIFEpzyk3a02IDJwW0TsmUL7/98c0
   lHHydL6Wjt3U0WIh3DooniPi+z5Yco4gBglM0E6ObNcSKyIHsV3LYuJto
   dZYk0+QpyAkjNl0sfxBUitKTMTX81oKQjRCnYmWDyPq3I41oqrMA3bDGD
   pYKpev8EgO3dTbkcYc0NhTuYLEGfWP73zkmVkl+0Yt7Ht1qKXbOSU3+cV
   g==;
X-CSE-ConnectionGUID: CpF9ZIJvQRSYFT09dsq1wQ==
X-CSE-MsgGUID: NKonsyTdQvqcAPbJ/x98iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="63510129"
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="63510129"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 17:50:25 -0700
X-CSE-ConnectionGUID: GbBlypPeTR6UCAhNfBb1iQ==
X-CSE-MsgGUID: DIFdLX4ZRg+tvq9EN3HS0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="204534546"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 10 Sep 2025 17:50:22 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwVVz-0006OJ-2R;
	Thu, 11 Sep 2025 00:50:19 +0000
Date: Thu, 11 Sep 2025 08:49:36 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	stable@vger.kernel.org,
	=?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] rds: ib: Increment i_fastreg_wrs before bailing
 out
Message-ID: <202509110810.t8tVEIDs-lkp@intel.com>
References: <20250910110501.350238-1-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250910110501.350238-1-haakon.bugge@oracle.com>

Hi Håkon,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/H-kon-Bugge/rds-ib-Increment-i_fastreg_wrs-before-bailing-out/20250910-190558
base:   net/main
patch link:    https://lore.kernel.org/r/20250910110501.350238-1-haakon.bugge%40oracle.com
patch subject: [PATCH net v3] rds: ib: Increment i_fastreg_wrs before bailing out
config: x86_64-buildonly-randconfig-001-20250911 (https://download.01.org/0day-ci/archive/20250911/202509110810.t8tVEIDs-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250911/202509110810.t8tVEIDs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509110810.t8tVEIDs-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/rds/ib_frmr.c: In function 'rds_ib_post_reg_frmr':
>> net/rds/ib_frmr.c:183:1: warning: label 'out' defined but not used [-Wunused-label]
     183 | out:
         | ^~~


vim +/out +183 net/rds/ib_frmr.c

1659185fb4d002 Avinash Repaka    2016-03-01  122  
1659185fb4d002 Avinash Repaka    2016-03-01  123  static int rds_ib_post_reg_frmr(struct rds_ib_mr *ibmr)
1659185fb4d002 Avinash Repaka    2016-03-01  124  {
1659185fb4d002 Avinash Repaka    2016-03-01  125  	struct rds_ib_frmr *frmr = &ibmr->u.frmr;
1659185fb4d002 Avinash Repaka    2016-03-01  126  	struct ib_reg_wr reg_wr;
3e56c2f856d7ab Santosh Shilimkar 2016-12-04  127  	int ret, off = 0;
1659185fb4d002 Avinash Repaka    2016-03-01  128  
1659185fb4d002 Avinash Repaka    2016-03-01  129  	while (atomic_dec_return(&ibmr->ic->i_fastreg_wrs) <= 0) {
1659185fb4d002 Avinash Repaka    2016-03-01  130  		atomic_inc(&ibmr->ic->i_fastreg_wrs);
1659185fb4d002 Avinash Repaka    2016-03-01  131  		cpu_relax();
1659185fb4d002 Avinash Repaka    2016-03-01  132  	}
1659185fb4d002 Avinash Repaka    2016-03-01  133  
fb4b1373dcab08 Gerd Rausch       2021-08-17  134  	ret = ib_map_mr_sg_zbva(frmr->mr, ibmr->sg, ibmr->sg_dma_len,
3e56c2f856d7ab Santosh Shilimkar 2016-12-04  135  				&off, PAGE_SIZE);
cc67d6c0924d12 Håkon Bugge       2025-09-10  136  	if (unlikely(ret != ibmr->sg_dma_len)) {
cc67d6c0924d12 Håkon Bugge       2025-09-10  137  		ret = ret < 0 ? ret : -EINVAL;
cc67d6c0924d12 Håkon Bugge       2025-09-10  138  		goto out_inc;
cc67d6c0924d12 Håkon Bugge       2025-09-10  139  	}
1659185fb4d002 Avinash Repaka    2016-03-01  140  
cc67d6c0924d12 Håkon Bugge       2025-09-10  141  	if (cmpxchg(&frmr->fr_state, FRMR_IS_FREE, FRMR_IS_INUSE) != FRMR_IS_FREE) {
cc67d6c0924d12 Håkon Bugge       2025-09-10  142  		ret = -EBUSY;
cc67d6c0924d12 Håkon Bugge       2025-09-10  143  		goto out_inc;
cc67d6c0924d12 Håkon Bugge       2025-09-10  144  	}
3a2886cca703fd Gerd Rausch       2019-07-16  145  
3a2886cca703fd Gerd Rausch       2019-07-16  146  	atomic_inc(&ibmr->ic->i_fastreg_inuse_count);
3a2886cca703fd Gerd Rausch       2019-07-16  147  
1659185fb4d002 Avinash Repaka    2016-03-01  148  	/* Perform a WR for the fast_reg_mr. Each individual page
1659185fb4d002 Avinash Repaka    2016-03-01  149  	 * in the sg list is added to the fast reg page list and placed
1659185fb4d002 Avinash Repaka    2016-03-01  150  	 * inside the fast_reg_mr WR.  The key used is a rolling 8bit
1659185fb4d002 Avinash Repaka    2016-03-01  151  	 * counter, which should guarantee uniqueness.
1659185fb4d002 Avinash Repaka    2016-03-01  152  	 */
1659185fb4d002 Avinash Repaka    2016-03-01  153  	ib_update_fast_reg_key(frmr->mr, ibmr->remap_count++);
5f33141d2fc05a Gerd Rausch       2019-07-16  154  	frmr->fr_reg = true;
1659185fb4d002 Avinash Repaka    2016-03-01  155  
1659185fb4d002 Avinash Repaka    2016-03-01  156  	memset(&reg_wr, 0, sizeof(reg_wr));
1659185fb4d002 Avinash Repaka    2016-03-01  157  	reg_wr.wr.wr_id = (unsigned long)(void *)ibmr;
1659185fb4d002 Avinash Repaka    2016-03-01  158  	reg_wr.wr.opcode = IB_WR_REG_MR;
1659185fb4d002 Avinash Repaka    2016-03-01  159  	reg_wr.wr.num_sge = 0;
1659185fb4d002 Avinash Repaka    2016-03-01  160  	reg_wr.mr = frmr->mr;
1659185fb4d002 Avinash Repaka    2016-03-01  161  	reg_wr.key = frmr->mr->rkey;
1659185fb4d002 Avinash Repaka    2016-03-01  162  	reg_wr.access = IB_ACCESS_LOCAL_WRITE |
1659185fb4d002 Avinash Repaka    2016-03-01  163  			IB_ACCESS_REMOTE_READ |
1659185fb4d002 Avinash Repaka    2016-03-01  164  			IB_ACCESS_REMOTE_WRITE;
1659185fb4d002 Avinash Repaka    2016-03-01  165  	reg_wr.wr.send_flags = IB_SEND_SIGNALED;
1659185fb4d002 Avinash Repaka    2016-03-01  166  
f112d53b435692 Bart Van Assche   2018-07-18  167  	ret = ib_post_send(ibmr->ic->i_cm_id->qp, &reg_wr.wr, NULL);
1659185fb4d002 Avinash Repaka    2016-03-01  168  	if (unlikely(ret)) {
1659185fb4d002 Avinash Repaka    2016-03-01  169  		/* Failure here can be because of -ENOMEM as well */
3a2886cca703fd Gerd Rausch       2019-07-16  170  		rds_transition_frwr_state(ibmr, FRMR_IS_INUSE, FRMR_IS_STALE);
3a2886cca703fd Gerd Rausch       2019-07-16  171  
1659185fb4d002 Avinash Repaka    2016-03-01  172  		if (printk_ratelimit())
1659185fb4d002 Avinash Repaka    2016-03-01  173  			pr_warn("RDS/IB: %s returned error(%d)\n",
1659185fb4d002 Avinash Repaka    2016-03-01  174  				__func__, ret);
cc67d6c0924d12 Håkon Bugge       2025-09-10  175  		goto out_inc;
1659185fb4d002 Avinash Repaka    2016-03-01  176  	}
5f33141d2fc05a Gerd Rausch       2019-07-16  177  
5f33141d2fc05a Gerd Rausch       2019-07-16  178  	/* Wait for the registration to complete in order to prevent an invalid
5f33141d2fc05a Gerd Rausch       2019-07-16  179  	 * access error resulting from a race between the memory region already
5f33141d2fc05a Gerd Rausch       2019-07-16  180  	 * being accessed while registration is still pending.
5f33141d2fc05a Gerd Rausch       2019-07-16  181  	 */
5f33141d2fc05a Gerd Rausch       2019-07-16  182  	wait_event(frmr->fr_reg_done, !frmr->fr_reg);
5f33141d2fc05a Gerd Rausch       2019-07-16 @183  out:
cc67d6c0924d12 Håkon Bugge       2025-09-10  184  	return ret;
5f33141d2fc05a Gerd Rausch       2019-07-16  185  
cc67d6c0924d12 Håkon Bugge       2025-09-10  186  out_inc:
cc67d6c0924d12 Håkon Bugge       2025-09-10  187  	atomic_inc(&ibmr->ic->i_fastreg_wrs);
1659185fb4d002 Avinash Repaka    2016-03-01  188  	return ret;
1659185fb4d002 Avinash Repaka    2016-03-01  189  }
1659185fb4d002 Avinash Repaka    2016-03-01  190  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

