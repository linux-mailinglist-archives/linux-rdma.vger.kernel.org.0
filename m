Return-Path: <linux-rdma+bounces-12055-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E95EB01118
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jul 2025 04:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA034A82F9
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jul 2025 02:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976361487C3;
	Fri, 11 Jul 2025 02:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b0o1sq+f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB75347DD;
	Fri, 11 Jul 2025 02:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752199652; cv=none; b=G9RN1TDJkTsBN3N4fbDV0asVYt5URBZL/ivVJvG8ZAaynGV4nMQjsvIJrA8OVRFSF+0rqzwa1rt5NrKF8jvYSbk9glItGO9H7wEntrJuxdxRjmRoJEpPA8nq+d2PHkMRFzHHwXOz+wdYYK3hIhskXuEHlrL7Zmp8x8pnOufkWU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752199652; c=relaxed/simple;
	bh=PvjSKPyD0gXbh2bB6YpiAqsa881j4RTXn+Ts3T8ihPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xte4W+9m/6bPNl3PQAdmGl1l6KofGvP6aC909kGj2aIkH9Yhq3USBVjufNuZSR3TfQkR5gsyn/Rh93oth9pS1PHGmAPevpFvclCQla/psQNDcGiKDa3Hjd9czMY1ccKGu5eEEQV/nfG3cNkdt42CyRTTupOQjLrIY/mtX8TUDPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b0o1sq+f; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752199649; x=1783735649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PvjSKPyD0gXbh2bB6YpiAqsa881j4RTXn+Ts3T8ihPM=;
  b=b0o1sq+fiQ9oUkAwWKvaPFjoh6Jgx9TcAEHn0kT3jiUI0W4le81yjwCs
   WBUSZR5VqUVu2a14xyQN/JQbwBRrutUBPGFRzwVoVpi83Dv0pwqWXUhgK
   wmsjmlR1DLsmxJHqT4QrYfvjM5gmucyQ0LMk/5qilbqmHBMrVNZbtxGvT
   jTqkFQWnGw97I0kP+szuYdmP7IdPuzD9XcdkJ+M2VSjyyJdvNQ8CnDrr2
   cJmJ1aoKC9jBaIfqiXnJtoyhdThpsBzfjKHOIamyF8fPKzZJHDDnd5sDb
   6BZMfAV0u/Cw7pX4Nm5OkwfcuPFLUitxXymm395cFfwA3kH64/RHkp4un
   g==;
X-CSE-ConnectionGUID: SxJy35KLRX+crdHurMv2CA==
X-CSE-MsgGUID: UR7Y/F2TSGG2EcY+mgmv9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="77040273"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="77040273"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 19:07:29 -0700
X-CSE-ConnectionGUID: ezwbokgsSPCaJxheSsnC4A==
X-CSE-MsgGUID: 56D/N/8bSouThmQuhjJlFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="160583219"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 10 Jul 2025 19:07:24 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ua3AY-0005jj-1k;
	Fri, 11 Jul 2025 02:07:22 +0000
Date: Fri, 11 Jul 2025 10:06:59 +0800
From: kernel test robot <lkp@intel.com>
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Saeed Mahameed <saeed@kernel.org>,
	Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-rdma@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V2 2/3] net/mlx5e: Add device PCIe congestion
 ethtool stats
Message-ID: <202507110932.iOkSE74e-lkp@intel.com>
References: <1752130292-22249-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752130292-22249-3-git-send-email-tariqt@nvidia.com>

Hi Tariq,

kernel test robot noticed the following build errors:

[auto build test ERROR on c65d34296b2252897e37835d6007bbd01b255742]

url:    https://github.com/intel-lab-lkp/linux/commits/Tariq-Toukan/net-mlx5e-Create-destroy-PCIe-Congestion-Event-object/20250710-145940
base:   c65d34296b2252897e37835d6007bbd01b255742
patch link:    https://lore.kernel.org/r/1752130292-22249-3-git-send-email-tariqt%40nvidia.com
patch subject: [PATCH net-next V2 2/3] net/mlx5e: Add device PCIe congestion ethtool stats
config: powerpc-randconfig-003-20250711 (https://download.01.org/0day-ci/archive/20250711/202507110932.iOkSE74e-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 01c97b4953e87ae455bd4c41e3de3f0f0f29c61c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250711/202507110932.iOkSE74e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507110932.iOkSE74e-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "mlx5e_pcie_cong_event_supported" [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

