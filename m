Return-Path: <linux-rdma+bounces-3026-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 710A4901DCB
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 11:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85B51F25A70
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 09:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9016F312;
	Mon, 10 Jun 2024 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jF6fyNvb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068326F2F1;
	Mon, 10 Jun 2024 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718010387; cv=none; b=MN5ytbH5u77XSawhNmL8/YlW74WAcL32t5NT4KjHOhMEz0D7x+7MPGfSr/Y6QjAOPBtbJ8bqlNuftWSmtXS33xxP/5+OI8Pgh9Q0TrJRYDU7pfMFiFh6LDjadYTV1zXi/lDUcpc5mpZYGY04AdjJkFP6LFtGU8/s2bP4itVXt5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718010387; c=relaxed/simple;
	bh=ZZoMCm57vhKq8Re8WFm6bgqLkhWqYeEW5ceyn8ZeDVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oC/fY+peKbjaykbMOBL+5ChySkJn32mVOQ3eOWVUe757bUyKj2zf8+PREFKPRgTTP80Svjl2cpeEKhk5BxZV6eKjQVFt8o0k31q/11zwKWu3Bf7qgjX6tWdx/qSTV+Crr18EEUOq+W2UDWniboXcyBsYTlNRVVODGJOH8oIMBTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jF6fyNvb; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718010385; x=1749546385;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZZoMCm57vhKq8Re8WFm6bgqLkhWqYeEW5ceyn8ZeDVg=;
  b=jF6fyNvb+UwAM01nwMUqit06TdlNzbhNeRWoFfwEW5yNQHuxzCjgcvGW
   cPzMb2Vi8iJn+fD4FtEM6eDJBjPZiCbbvuy+PmDzJI2HWQPAuTJZv+wHu
   4wzMTMoeJAtrNQUzuZnfLcPTk1l+YSeMh77VvQs8FrIIf21XtjqJj4EV/
   6rWI8H2fz8IaRtdzunpMLdc2jpmc0qatp52VfwqClSKyZ2l55ByafjxLp
   iia7xwDAeXiYQW3rbkA5zwtLFdpLvIBRUkT6zQJj/JCJ99J1GUoYhjRBO
   9tDrUMcpzeSz31wL9SRI2+SPQowQsKV1q/CF41vU/WUhFrUcLv5tq2XXb
   g==;
X-CSE-ConnectionGUID: aiaQE0iiQtGQ4Rkjq8DKkg==
X-CSE-MsgGUID: US8JapjLSzq/I2rESRyBww==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="14536094"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="14536094"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 02:06:24 -0700
X-CSE-ConnectionGUID: AQq912iBQ4WrL1Pp5Oy5ew==
X-CSE-MsgGUID: xUWi0rtKTuKZ3SfsK5CUGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43430323"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.237.140.142]) ([10.237.140.142])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 02:06:21 -0700
Message-ID: <ef9d16e6-186d-4ee3-9888-1c4aba1b4b88@linux.intel.com>
Date: Mon, 10 Jun 2024 11:06:13 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next 5/5] ice: flower: validate
 encapsulation control flags
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
 netdev@vger.kernel.org
Cc: Louis Peens <louis.peens@corigine.com>,
 Davide Caratti <dcaratti@redhat.com>, Leon Romanovsky <leon@kernel.org>,
 linux-net-drivers@amd.com, intel-wired-lan@lists.osuosl.org,
 oss-drivers@corigine.com, i.maximets@ovn.org,
 Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
 Edward Cree <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Martin Habets <habetsm.xilinx@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, linux-rdma@vger.kernel.org
References: <20240609173358.193178-1-ast@fiberby.net>
 <20240609173358.193178-6-ast@fiberby.net>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20240609173358.193178-6-ast@fiberby.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 09.06.2024 19:33, Asbjørn Sloth Tønnesen wrote:
> Encapsulation control flags are currently not used anywhere,
> so all flags are currently unsupported by all drivers.
> 
> This patch adds validation of this assumption, so that
> encapsulation flags may be used in the future.
> 
> In case any encapsulation control flags are masked,
> flow_rule_match_has_enc_control_flags() sets a NL extended
> error message, and we return -EOPNOTSUPP.
> 
> Only compile tested.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>

> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> index 8bd24b33f3a67..e6923f8121a99 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> @@ -1353,6 +1353,7 @@ ice_parse_tunnel_attr(struct net_device *dev, struct flow_rule *rule,
>  		      struct ice_tc_flower_fltr *fltr)
>  {
>  	struct ice_tc_flower_lyr_2_4_hdrs *headers = &fltr->outer_headers;
> +	struct netlink_ext_ack *extack = fltr->extack;
>  	struct flow_match_control enc_control;
>  
>  	fltr->tunnel_type = ice_tc_tun_get_type(dev);
> @@ -1373,6 +1374,9 @@ ice_parse_tunnel_attr(struct net_device *dev, struct flow_rule *rule,
>  
>  	flow_rule_match_enc_control(rule, &enc_control);
>  
> +	if (flow_rule_has_enc_control_flags(enc_control.mask->flags, extack))
> +		return -EOPNOTSUPP;
> +
>  	if (enc_control.key->addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {
>  		struct flow_match_ipv4_addrs match;
>  

