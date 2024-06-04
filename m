Return-Path: <linux-rdma+bounces-2842-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC348FB53F
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 16:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB9D1C220B4
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 14:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6771132C3B;
	Tue,  4 Jun 2024 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RmSUYrp7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBE8C13B;
	Tue,  4 Jun 2024 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511422; cv=none; b=PtFMcL1ibl7LJGJB6/ftv4jCNlCssVfKn7AJuu2X3pUZ/4t/vrwpLURIxMfhrVlC1SWciBMMyXwojU03uh/aqeZNDmaQpsvukkND5if4jnhXBaYFMB2GVoVBoHR0uvJQk0TmMtnYlHjVedCmWQiXeIHty0PdjMCpqZ3IZzMXiIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511422; c=relaxed/simple;
	bh=pb5O3feP9MBcD9HFqOeYqFq6wpe3pb56Wi1DLNCgN6g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ewLDbEtHWMldCxlQwODz/FmXMSerBEIYgVym3sI0A7zh2KzaqZeCNCbcxIndtyVuKPkfsF5FnNMCBx54DhRnu/fy5R0iPl7b4A/zvL2s7aVT6hRFXbpVQPeVpB1dSFr+UTeGXUcKUMbWC+yby5OSAgEkyCec06BIFfu7w9jQut4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RmSUYrp7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717511421; x=1749047421;
  h=date:from:to:cc:subject:message-id:reply-to:mime-version:
   in-reply-to;
  bh=pb5O3feP9MBcD9HFqOeYqFq6wpe3pb56Wi1DLNCgN6g=;
  b=RmSUYrp7Cax6e961lFnaka5V8YpCJbk4wjhFt0olNdxdDafyNyiCF8Mq
   yIqQs26hpb9R9SSwVF2vPXlOhP+wqcoWvCUNG/j0IOw/tfk2kwglz9W5J
   bq2vnZrRyJw5o3qgVckaBxqgIwVJRpf9suFtNmtWoG5oxjss+PpU5tXhs
   rw5IpEmX3TbObmgKIztKyKLQ9h6bJBLDATo2jZYf9g31/WTVzhDU6bP1w
   8jlSXAkSTOoXOLsarA+OrksMDO78NFJASGIADV9X4y1vYdSt3UDkecF8F
   hTyIjxSiblytuVDoeq4VwgFmMXkn78vx/fRktRHlZS47iLwfXcq+PGCrr
   w==;
X-CSE-ConnectionGUID: NSrcU4NdRFWHxOUCYzR9pA==
X-CSE-MsgGUID: HzmxIyLsTmmttmRVVNXcSA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13903401"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="13903401"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 07:30:20 -0700
X-CSE-ConnectionGUID: wXjjIbI8TRKlbEio1BhF6Q==
X-CSE-MsgGUID: BTDdzXZPTXyO9p7u4zWRxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="42219615"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 07:30:18 -0700
Date: Tue, 4 Jun 2024 17:30:23 +0300
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
Message-ID: <Zl8k/8/yQLnZcGd3@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org>

Hi,

[Sorry for the previous message, resending it now
 with proper In-reply-to: header added.]

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


