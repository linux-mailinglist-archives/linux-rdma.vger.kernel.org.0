Return-Path: <linux-rdma+bounces-9733-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5B7A98905
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 14:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1526F7AE3BC
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 11:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265521C6FE1;
	Wed, 23 Apr 2025 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MgxPtVC+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F8F2701D5;
	Wed, 23 Apr 2025 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745409625; cv=none; b=Vr/zP4gszffu7aKXWE9BJ2GqBLxnI9frLd1Vwanv/u2/T4BucCMS8sUNkSsDQLguRiR3s514uonnYU81gyVZCPq+Ed3ChLE6k0Ov5s2dn/Nt7oekDnqDwOjen0TOywZZCtN6JiLMqVXPGTJ4yfReWKNtAF+1cfdysiIfRF1Z6lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745409625; c=relaxed/simple;
	bh=wB5Z8asKFlEWIqWWQJPXzolubaSIl3Ml/1hZiNUVMy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoyE6iE7g2E+kgcW+8UBvVKedygPBWtKgzI8P9Se0Zd2t1ma4kUhkm5NjIT2+rQsDY4eqjsh1EN+oI4VASbhxjtGkEaRLClvhtSAfCTfdZcIvRUtSY2DeKZWygypCYuyORTXp98/YcDCX6e5LnnpdUwNaGsAx+Mo9pbruuFNaLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MgxPtVC+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745409625; x=1776945625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wB5Z8asKFlEWIqWWQJPXzolubaSIl3Ml/1hZiNUVMy8=;
  b=MgxPtVC+PsIwmUJ1rtDVy+7azEkPrvVaORTClbodJ9QYE692GDT1Kn3+
   Paq9qHFbbcDLXStXksheJd3BOOBdYp0QUVZdpTyRocsVCaunXHlgKIS5C
   I50YeLtBK16USxaTvvnbqKwD7yymQOhDhwrHK/hY9qdXGNY5BlOzTfDqk
   InnW9eyAOE7OJBkCbcbsciNl2Y7hkqK5wbSh3OCmbAEoESHcndcQcQAEB
   cabF2FY2rMbAV9rlKheYJ+1A/rdusRKgpfpR2pYsrq4GmIGoLZZKhDkWb
   Hx9iFO51mIc07fOVgofPK3HkdzlX8YJSYb6Z3fjYJyjqVuCHDDQ3UZQ1N
   A==;
X-CSE-ConnectionGUID: mC0PpyfnReSu7mOK3BplVg==
X-CSE-MsgGUID: Z/3tHJfUTaaRgHDlAnBAMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="57192470"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="57192470"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 05:00:25 -0700
X-CSE-ConnectionGUID: KSP7qUiRQwKXovaObvQiRQ==
X-CSE-MsgGUID: aPXobac+QCOe3s8IYN37eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="137157046"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 05:00:21 -0700
Date: Wed, 23 Apr 2025 14:00:00 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH net 2/5] net/mlx5: E-Switch, Initialize MAC Address for
 Default GID
Message-ID: <aAjWNaBKzKxeHbks@mev-dev.igk.intel.com>
References: <20250423083611.324567-1-mbloch@nvidia.com>
 <20250423083611.324567-3-mbloch@nvidia.com>
 <aAjBk5gX27FtnE3f@mev-dev.igk.intel.com>
 <77df78bb-8bcf-42e8-b307-cc8bbe97254c@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77df78bb-8bcf-42e8-b307-cc8bbe97254c@nvidia.com>

On Wed, Apr 23, 2025 at 02:20:56PM +0300, Mark Bloch wrote:
> 
> 
> On 23/04/2025 13:31, Michal Swiatkowski wrote:
> > On Wed, Apr 23, 2025 at 11:36:08AM +0300, Mark Bloch wrote:
> >> From: Maor Gottlieb <maorg@nvidia.com>
> >>
> >> Initialize the source MAC address when creating the default GID entry.
> >> Since this entry is used only for loopback traffic, it only needs to
> >> be a unicast address. A zeroed-out MAC address is sufficient for this
> >> purpose.
> >> Without this fix, random bits would be assigned as the source address.
> >> If these bits formed a multicast address, the firmware would return an
> >> error, preventing the user from switching to switchdev mode:
> >>
> >> Error: mlx5_core: Failed setting eswitch to offloads.
> >> kernel answers: Invalid argument
> >>
> >> Fixes: 80f09dfc237f ("net/mlx5: Eswitch, enable RoCE loopback traffic")
> >> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> >> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> >> ---
> >>  drivers/net/ethernet/mellanox/mlx5/core/rdma.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
> >> index a42f6cd99b74..f585ef5a3424 100644
> >> --- a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
> >> +++ b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
> >> @@ -118,8 +118,8 @@ static void mlx5_rdma_make_default_gid(struct mlx5_core_dev *dev, union ib_gid *
> >>  
> >>  static int mlx5_rdma_add_roce_addr(struct mlx5_core_dev *dev)
> >>  {
> >> +	u8 mac[ETH_ALEN] = {};
> > 
> > Won't it be helpful to add comment that it needs to be unicast and 0 is
> > a valid MAC?
> 
> That's why the commit message has: "it only needs to
> be a unicast address. A zeroed-out MAC address is sufficient for this
> purpose."
> 
> I feel this is good enough.

Make sense, thanks

> 
> > 
> > Anyway,
> > Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> Thanks!
> 
> > 
> > hw_id in mlx5_rdma_make_default_gid() is also used without assigining.
> > Is it fine to have random bits there?
> 
> We pass hw_id to mlx5_query_mac_address() which fills it.
> However, there's a separate issue where mlx5_query_mac_address()
> might fail, this is unlikely, but still possible.
> We'll address that in a follow-up patch.
> 
> Thanks for the review! 
> 
> Mark
> 
> > 
> > Thanks
> > 
> >>  	union ib_gid gid;
> >> -	u8 mac[ETH_ALEN];
> >>  
> >>  	mlx5_rdma_make_default_gid(dev, &gid);
> >>  	return mlx5_core_roce_gid_set(dev, 0,
> >> -- 
> >> 2.34.1
> 

