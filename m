Return-Path: <linux-rdma+bounces-14107-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4BEC16078
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 18:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4051885B62
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2036347FD8;
	Tue, 28 Oct 2025 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKZZAXbC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFBC346E4A;
	Tue, 28 Oct 2025 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670661; cv=none; b=EEeQ+PNZCiL4oyq2M/2R2qgTL0N8cXYmXl6PdM89olSRY0wK/vXpcARYrGdDlW5JZnfqotm3xrOxbf5NgsOunbhDDWtT9Jw+wBNU6P3qNjOP0fZHqQm2Y/XwNEodU5gjqkplxIsnWARfNADz6/8YQwiLoiS7/4pgGVEswc69KcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670661; c=relaxed/simple;
	bh=aj4lytZnlp+F0c2g1w8XC6BgNEmmQKZC46OI2bAFwmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afIUcqq6u4TZEiLI+bXjY3w8XvJ/0J/+rN8cv8AGOSA4wmPpqzx60PMLZt9bBCvGxaSRs3ksZKL602lI9b4RDOTqOy0qRyu1DOoEsS8ljiSTofn/aog05KVrbCrf7WGZm84wOgZ9Q8QgLqN1jt5jTph9uWiw1sej2A/7jmG49u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKZZAXbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC24C4CEE7;
	Tue, 28 Oct 2025 16:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761670661;
	bh=aj4lytZnlp+F0c2g1w8XC6BgNEmmQKZC46OI2bAFwmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bKZZAXbCQA4ewEygt5zEzAIUVvysfVH7HckBmmYlFuM0K06eK+sNEY3Yqm08MLSo7
	 R7Z9ADayAgT54bom4OrpRI6H+IErcwqnSm4BrWqJ+i3LMPT5kR9BcmoiTQmNma6k/q
	 mriCP13Oobv/udMmazO5NWpg2ZsLhNPDsbUnN1TP3asySuHq+NdeLq0lmW/16/SlxT
	 ffcjHuQmgNEFXuBFyrqGvCWgdiRGY2DAq8JFcGqzxj7AuAx8mAJxLCyaA63Dmh4bCs
	 hMzX/PpQtBpUcKVuP04rMq8sYG82qfKo6H5c76BMuJ2rAPuXwrf3siDjeTqgazLQoY
	 fjtlxWRGBoVxQ==
Date: Tue, 28 Oct 2025 16:57:35 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net] net/mlx5: Don't zero user_count when destroying FDB
 tables
Message-ID: <aQD1_13OxXT16XPR@horms.kernel.org>
References: <1761510019-938772-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1761510019-938772-1-git-send-email-tariqt@nvidia.com>

On Sun, Oct 26, 2025 at 10:20:19PM +0200, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> esw->user_count tracks how many TC rules are added on an esw via
> mlx5e_configure_flower -> mlx5_esw_get -> atomic64_inc(&esw->user_count)
> 
> esw.user_count was unconditionally set to 0 in
> esw_destroy_legacy_fdb_table and esw_destroy_offloads_fdb_tables.
> 
> These two together can lead to the following sequence of events:
> 1. echo 1 > /sys/class/net/eth2/device/sriov_numvfs
>   - mlx5_core_sriov_configure -...-> esw_create_legacy_table ->
>     atomic64_set(&esw->user_count, 0)
> 2. tc qdisc add dev eth2 ingress && \
>    tc filter replace dev eth2 pref 1 protocol ip chain 0 ingress \
>        handle 1 flower action ct nat zone 64000 pipe
>   - mlx5e_configure_flower -> mlx5_esw_get ->
>     atomic64_inc(&esw->user_count)
> 3. echo 0 > /sys/class/net/eth2/device/sriov_numvfs
>   - mlx5_core_sriov_configure -..-> esw_destroy_legacy_fdb_table
>     -> atomic64_set(&esw->user_count, 0)
> 4. devlink dev eswitch set pci/0000:08:00.0 mode switchdev
>   - mlx5_devlink_eswitch_mode_set -> mlx5_esw_try_lock ->
>     atomic64_read(&esw->user_count) == 0
>   - then proceed to a WARN_ON in:
>   esw_offloads_start -> mlx5_eswitch_enable_locke -> esw_offloads_enable
>   -> mlx5_esw_offloads_rep_load -> mlx5e_vport_rep_load ->
>   mlx5e_netdev_change_profile -> mlx5e_detach_netdev ->
>   mlx5e_cleanup_nic_rx -> mlx5e_tc_nic_cleanup ->
>   mlx5e_mod_hdr_tbl_destroy
> 
> Fix this by not clearing out the user_count when destroying FDB tables,
> so that the check in mlx5_esw_try_lock can prevent the mode change when
> there are TC rules configured, as originally intended.
> 
> Fixes: 2318b8bb94a3 ("net/mlx5: E-switch, Destroy legacy fdb table when needed")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


