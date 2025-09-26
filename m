Return-Path: <linux-rdma+bounces-13672-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A855BA3AF8
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Sep 2025 14:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481DE1C002F3
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Sep 2025 12:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D542F7AB7;
	Fri, 26 Sep 2025 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLoQJGl1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360962F6593;
	Fri, 26 Sep 2025 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891006; cv=none; b=HZCUWW129ZF/ExghEMd9Vpd4jUtj4bkSpc85f8ag4WCONsLjj5ktqRnCT3xFaGi5rmwTH3DZUtCo+DcQ+WVXnFhSbJMVvI2H2cYMWNUT494qlOAWUuxY7uCFxFz3djkMXrSIVWSZlwN1JgkBtPoNBclUyNl0RzW4FdLM3EAfzUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891006; c=relaxed/simple;
	bh=023QJFGZmApyCBXIrm0J5kNm+LMuusbuLoFq4ytIvfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaduaESsoA3GEVwKtUqleDQuEUKBbBNBXaHozZMuxHvUdEqG6u1P1J44MUYKAPVJstz1I8ogw6YN/rE3OPWWHZW9n4pKggDeCsUdrLTO190Y1FprRharu1As6Qb423WJaaid3ec82XLbKL66bjtxAw7c3xSTiEwkxrDjZXdFgC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLoQJGl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FBFC113CF;
	Fri, 26 Sep 2025 12:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758891005;
	bh=023QJFGZmApyCBXIrm0J5kNm+LMuusbuLoFq4ytIvfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GLoQJGl1cRrhWUs8qJO1wGZZwpBwYPcAKoQ/PmgIERSKgIk5UvotPcmUCwS7mhyg+
	 rMtCLpNbueAqWVqerO2EkgfLtIQBo9KJkMQbRIy/b/181hVNECb5Dmvy/SR/FYwlcn
	 wTWkpEVZOvfzCmU4fhBaezd3laOI50/muQGii50+4icMQdypZkMOXtKn+Ng3XxLQfq
	 VvgdUWg37vomdeVgNXp81zcmMmBcNiHUk4958xXxDYtCuNa93DisazI+lySdFQBjnd
	 BaU3WjarkDJ4nCvN9RpmiWmeuE+IROwUQ/rrtxNmBTIe394CiXOmwtV524HdbNPWq6
	 uG05D4QYsHlsg==
Date: Fri, 26 Sep 2025 13:49:59 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Akiva Goldberger <agoldberger@nvidia.com>
Subject: Re: [PATCH net-next] net/mlx5: Expose uar access and odp page fault
 counters
Message-ID: <aNaL90oj8vyq9-A9@horms.kernel.org>
References: <1758797130-829564-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758797130-829564-1-git-send-email-tariqt@nvidia.com>

On Thu, Sep 25, 2025 at 01:45:30PM +0300, Tariq Toukan wrote:
> From: Akiva Goldberger <agoldberger@nvidia.com>
> 
> Add three counters to vnic health reporter:
> bar_uar_access, odp_local_triggered_page_fault, and
> odp_remote_triggered_page_fault.
> 
> - bar_uar_access
>     number of WRITE or READ access operations to the UAR on the PCIe
>     BAR.
> - odp_local_triggered_page_fault
>     number of locally-triggered page-faults due to ODP.
> - odp_remote_triggered_page_fault
>     number of remotly-triggered page-faults due to ODP.
> 
> Example access:
>     $ devlink health diagnose pci/0000:08:00.0 reporter vnic
> 	vNIC env counters:
> 	total_error_queues: 0 send_queue_priority_update_flow: 0
> 	comp_eq_overrun: 0 async_eq_overrun: 0 cq_overrun: 0
> 	invalid_command: 0 quota_exceeded_command: 0
> 	nic_receive_steering_discard: 0 icm_consumption: 1032
> 	bar_uar_access: 1279 odp_local_triggered_page_fault: 20
> 	odp_remote_triggered_page_fault: 34
> 
> Signed-off-by: Akiva Goldberger <agoldberger@nvidia.com>
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

