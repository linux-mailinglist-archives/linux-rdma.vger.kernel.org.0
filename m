Return-Path: <linux-rdma+bounces-2841-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9878FB519
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 16:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7A51C219B2
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 14:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0764D12AAE0;
	Tue,  4 Jun 2024 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJ39MTu8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C83F1B809;
	Tue,  4 Jun 2024 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510912; cv=none; b=loP4Bj2yc4LCT+jkZmpf/Ijdce3ory8DAGZW1vG/RvsldQODRWL2oC576JEO7E6EBZyY3u5GnMn9Sqw0Pw6ZBNp9PEFpNRaoEJHvkInnRXpDgbbSPybUVIdtq+fj//REkvAPn3ZyBxjWNhBJG0P9jAnvy48YuA3jy8C5FteLVqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510912; c=relaxed/simple;
	bh=eRJpt9PCLXP0/RSE6C8YUTUohYxAi/Axl+foQTY055s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X+hLVDFXqzbjirIMbXENM5mY9YQgnqn92oBNoVldg8aYAweG/kpwTARkmXhHSBGrr0DOpgT61bL5k2I2/9aGq3gvPxjxEFdbKPiL6PO/BZfXoeFtccE/eYsP+bo3uas2V9uqL0ZkGzW/+eyS7HG+HxnE7dlWDpRLrLVnRER8e0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJ39MTu8; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717510911; x=1749046911;
  h=date:from:to:cc:subject:message-id:reply-to:mime-version;
  bh=eRJpt9PCLXP0/RSE6C8YUTUohYxAi/Axl+foQTY055s=;
  b=IJ39MTu8tykVSoLpxGTOguX5KBH0SDIIc3a6AFoSZ2zQx2FZw0haizix
   csabr1hsmV1irDSi7Hu3acSL6tKTXtst0PMSsySRKFKYu+467kAnoBcWK
   2zBFogDK4A/SywN7bpDV3r1EZ5kE/JtPnvUViC9SOPee8dBt4yDf9oFbb
   xxS56R8VfvAt/XaDKumJQTqTwtCFdoS2Yp3fxrFKyY9lKCk8+HS5dzHxK
   +ensY2ExX+X/wzG4frOqZ35W1LrPvSXsMV7Qu9IpmJZFdw4c7zj5CWFvU
   EjpfYJjFK2epOaDSvZcKe9bmyHO/aszu9/NyYCoDHyb5nImM5HlvJuvLB
   A==;
X-CSE-ConnectionGUID: ebKYIfEjSmaTl0HkhNo4Jw==
X-CSE-MsgGUID: ZOwcBaO2SRux5dqadQRfQQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13902479"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="13902479"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 07:21:50 -0700
X-CSE-ConnectionGUID: EGfyRFPBTyudj+eM5T2AnQ==
X-CSE-MsgGUID: gsf4b1s6QN+uivwMzhV3Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="42215280"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 07:21:45 -0700
Date: Tue, 4 Jun 2024 17:21:51 +0300
From: Imre Deak <imre.deak@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	RDMA mailing list <linux-rdma@vger.kernel.org>,
	Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rc] workqueue: Reimplement UAF fix to avoid lockdep
 worning
Message-ID: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org>
Reply-To: imre.deak@intel.com
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I see a similar issue, a corruption in the lock_keys_hash while
alloc_workqueue()->lockdep_register_key() iterates it, see [1] for the
stacktrace.

Not sure if related or even will solve [1], but [2] will revert

commit 7e89efc6e9e4 ("PCI: Lock upstream bridge for pci_reset_function()")

which does

lockdep_register_key(&dev->cfg_access_key);

in pci_device_add() and doesn't unregister the key when the pci device is
removed (and potentially freed); so basically 7e89efc6e9e4 was missing a

lockdep_unregister_key();

in pci_destroy_dev().

Based on the above I wonder if 7e89efc6e9e4 could also lead to the
corruption of lock_keys_hash after a pci device is removed.

--Imre

[1] https://intel-gfx-ci.01.org/tree/drm-tip/IGT_7875/bat-atsm-1/dmesg0.txt
[2] https://lore.kernel.org/all/171711746402.1628941.14575335981264103013.stgit@dwillia2-xfh.jf.intel.com/

