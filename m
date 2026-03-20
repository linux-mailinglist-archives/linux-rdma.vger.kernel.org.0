Return-Path: <linux-rdma+bounces-18445-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BYvLi4vvWmI7QIAu9opvQ
	(envelope-from <linux-rdma+bounces-18445-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 12:27:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CF12D989C
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 12:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D208F301CEC8
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 11:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244C53A759D;
	Fri, 20 Mar 2026 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2tW37oF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5DB3A75B9
	for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774005988; cv=none; b=p5xYnLGd5fWuAsOppjNNzwdeNcDF8OAGnIR7xJYKBld3RlGPcBzLWtHtJOx2De9fmL+qe0OVCtnOejpBdUewCgE45eCPBWwOFL2rWvQfpEcmYRq+qdeHG+q+cH8ixQNWVdr1s6gUF8rE+Jfgx7TBpZBPDzUkedgv2J9JgRRxp2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774005988; c=relaxed/simple;
	bh=S9kyTw6v4Hvvnd2vtU8jxbZDobP6TI13uDpyigbSNUQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TvccyotI5BLwShMoj/Phk3vDNVl5itFzfn7rvE3tCsiX4lkS3qtMDrDaCZ37sfZUsT6y1MDw3AP14HSAusCX5oH3SF1IthPM0f6ndP7RD9I7kRC4xNjDiqV4r3gDbEQccbfc9nlITyBYM5YgkZODbTpEOqeAWcay0FAjtXk4EK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2tW37oF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774005986; x=1805541986;
  h=date:from:to:cc:subject:message-id;
  bh=S9kyTw6v4Hvvnd2vtU8jxbZDobP6TI13uDpyigbSNUQ=;
  b=Y2tW37oF2JsKqg3qVu3Aw01QwX2bIdokx6HAZrFTRGKbE+eCDTqrDxaW
   W3e3+sEeOGc1aZsYc42kuumpfiUKtZ/eZ8jEUeXHz4lkhhwu7K+/LR5d6
   NYtqFNbI2lXC1ltvCBxeGnybB/6ivrCuPUBeRfg/rnPloL2IeZoR/FlEh
   dCuZWyY+VXbiXMAuLOCyH0iozGR3pCtZ/x2rdyrhEQFfftr6cafcx3npU
   Ga0FztYq0Vww8OFAQZzkLqtA4fexurP7VJxbPot2MGnsY+MKdC4Ay3QP+
   WXvARy0pxORezaq7KSL2ZbN7dT3a7deWzSPabxwf7SILtlzG32AZHUg+u
   A==;
X-CSE-ConnectionGUID: UVawA5p+QUmlhP53rFXzTA==
X-CSE-MsgGUID: 47Kxv1xDTuy6EUiJWimmvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="100543762"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="100543762"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 04:25:56 -0700
X-CSE-ConnectionGUID: DZu7TnBDRKGQLo7HNJd67Q==
X-CSE-MsgGUID: mTWEXM1tSReEShQfv2+WOQ==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO a51c2a36b9df) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 20 Mar 2026 04:25:53 -0700
Received: from kbuild by a51c2a36b9df with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3XzD-000000002In-0dA4;
	Fri, 20 Mar 2026 11:25:51 +0000
Date: Fri, 20 Mar 2026 19:21:48 +0800
From: kernel test robot <lkp@intel.com>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>
Subject: [rdma:wip/leon-for-next 47/53]
 drivers/infiniband/hw/mana/main.c:696:3: error: expected ')'
Message-ID: <202603201909.6pvOE0KP-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18445-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.965];
	TAGGED_RCPT(0.00)[linux-rdma,lists];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B6CF12D989C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
head:   90b7abe25ce9b8ea6b97c534cb0f037155013bb8
commit: 684603da1e156756affe3a9f6070428d72dcf944 [47/53] RDMA/mana_ib: cleanup the usage of mana_gd_send_request()
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20260320/202603201909.6pvOE0KP-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260320/202603201909.6pvOE0KP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603201909.6pvOE0KP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/infiniband/hw/mana/main.c:696:3: error: expected ')'
     696 |                 return err;
         |                 ^
   drivers/infiniband/hw/mana/main.c:695:5: note: to match this '('
     695 |         if (err
         |            ^
   1 error generated.


vim +696 drivers/infiniband/hw/mana/main.c

98b889c43935c4 Konstantin Taranov 2024-04-10  682  
c390828d4d7b45 Konstantin Taranov 2025-05-07  683  int mana_eth_query_adapter_caps(struct mana_ib_dev *dev)
c390828d4d7b45 Konstantin Taranov 2025-05-07  684  {
c390828d4d7b45 Konstantin Taranov 2025-05-07  685  	struct mana_ib_adapter_caps *caps = &dev->adapter_caps;
c390828d4d7b45 Konstantin Taranov 2025-05-07  686  	struct gdma_query_max_resources_resp resp = {};
c390828d4d7b45 Konstantin Taranov 2025-05-07  687  	struct gdma_general_req req = {};
c390828d4d7b45 Konstantin Taranov 2025-05-07  688  	int err;
c390828d4d7b45 Konstantin Taranov 2025-05-07  689  
c390828d4d7b45 Konstantin Taranov 2025-05-07  690  	mana_gd_init_req_hdr(&req.hdr, GDMA_QUERY_MAX_RESOURCES,
c390828d4d7b45 Konstantin Taranov 2025-05-07  691  			     sizeof(req), sizeof(resp));
c390828d4d7b45 Konstantin Taranov 2025-05-07  692  
684603da1e1567 Konstantin Taranov 2026-03-18  693  	err = mana_gd_send_request(mdev_to_gc(dev), sizeof(req), &req,
684603da1e1567 Konstantin Taranov 2026-03-18  694  				   sizeof(resp), &resp);
684603da1e1567 Konstantin Taranov 2026-03-18  695  	if (err
c390828d4d7b45 Konstantin Taranov 2025-05-07 @696  		return err;
c390828d4d7b45 Konstantin Taranov 2025-05-07  697  
c390828d4d7b45 Konstantin Taranov 2025-05-07  698  	caps->max_qp_count = min_t(u32, resp.max_sq, resp.max_rq);
c390828d4d7b45 Konstantin Taranov 2025-05-07  699  	caps->max_cq_count = resp.max_cq;
c390828d4d7b45 Konstantin Taranov 2025-05-07  700  	caps->max_mr_count = resp.max_mst;
c390828d4d7b45 Konstantin Taranov 2025-05-07  701  	caps->max_pd_count = 0x6000;
c390828d4d7b45 Konstantin Taranov 2025-05-07  702  	caps->max_qp_wr = min_t(u32,
c390828d4d7b45 Konstantin Taranov 2025-05-07  703  				0x100000 / GDMA_MAX_SQE_SIZE,
c390828d4d7b45 Konstantin Taranov 2025-05-07  704  				0x100000 / GDMA_MAX_RQE_SIZE);
c390828d4d7b45 Konstantin Taranov 2025-05-07  705  	caps->max_send_sge_count = 30;
c390828d4d7b45 Konstantin Taranov 2025-05-07  706  	caps->max_recv_sge_count = 15;
c390828d4d7b45 Konstantin Taranov 2025-05-07  707  	caps->page_size_cap = PAGE_SZ_BM;
c390828d4d7b45 Konstantin Taranov 2025-05-07  708  
c390828d4d7b45 Konstantin Taranov 2025-05-07  709  	return 0;
c390828d4d7b45 Konstantin Taranov 2025-05-07  710  }
c390828d4d7b45 Konstantin Taranov 2025-05-07  711  

:::::: The code at line 696 was first introduced by commit
:::::: c390828d4d7b453c21c6fc0787c714db82731093 RDMA/mana_ib: Add support of mana_ib for RNIC and ETH nic

:::::: TO: Konstantin Taranov <kotaranov@microsoft.com>
:::::: CC: Leon Romanovsky <leon@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

