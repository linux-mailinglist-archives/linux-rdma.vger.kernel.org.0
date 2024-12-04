Return-Path: <linux-rdma+bounces-6233-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469C89E3B9F
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 14:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043432862D5
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 13:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7D41EB2F;
	Wed,  4 Dec 2024 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dgYaxFZj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B8EEAF6
	for <linux-rdma@vger.kernel.org>; Wed,  4 Dec 2024 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320061; cv=none; b=Jc3XvSga9PKkw3Nkqp29hAhMsJcjIof2+wLEGKAMUvfBvJGNQK6kxg52FrGJRE0GjyKVrTecCa7+oDaVD7naBDl5ePxvdjMmLSMHHHoRcHtuQJf7+fwu/gFDcYzhI1ANivhTiByq6aLPa8mELl234dyr+F5R7DPp55zQMCGnhT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320061; c=relaxed/simple;
	bh=SboXOZ9mXCjsZVOfuERGZFZkIX96mrZkgW6frAHJHgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rv7sSjdrBMjpfjNBkUHIOq96R0dw2iSNdaB9U1RMINt9dcsVjnl5J0HoFZjLf2wij2YjabJPyPHBfc4tEtyxfW+uWDqCIMp8XyDQnZelXMCxJKckgVcdVHWH+3cdp4+V0S3BzruNSA/py24DQ7xXUWS7Nk0LXKoHaIvJ8DlzPGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dgYaxFZj; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b466b028-018b-4ae2-9b96-994081e4ebf6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733320046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OX+0intpKB5YjI4aa/yS+ZMctcorKNmMPEqW438sPJU=;
	b=dgYaxFZj28Twz/syT1nFAv6y4ppH3aGfx2BZqlLT+US9Cvt7JHy02oZOMCpBWgQzFDB8nf
	SxUDwsZoGOQ8p0hxEjfZyrAYE08FcAJ/24XYvu786QpYnEqdN2eLi/6rRHKuGjTiqC5nIx
	itZwUEp8NqL9qVJ9u/6aYdkwegkgKTw=
Date: Wed, 4 Dec 2024 14:47:23 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next V4 00/11] net/mlx5: ConnectX-8 SW Steering + Rate
 management on traffic classes
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-rdma@vger.kernel.org
References: <20241203202924.228440-1-tariqt@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20241203202924.228440-1-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 03.12.24 21:29, Tariq Toukan wrote:
> Hi,
> 
> This patchset starts with 3 patches that modify the IFC, targeted to
> mlx5-next in order to be taken to rdma-next branch side sooner than in
> the next merge window.
> 
> This patchset consists of two features:
> 1. In patches 4-5, Itamar adds SW Steering support for ConnectX-8.
> 2. Followed by patches by Carolina that add rate management support on
> traffic classes in devlink and mlx5, more details below [1].
> 
> Series generated against:
> commit e8e7be7d212d ("mctp i2c: drop check because i2c_unregister_device() is NULL safe")

 From the link 
https://people.kernel.org/monsieuricon/all-patches-must-include-base-commit-info, 


If we use --base=auto or the commit id (in this patch, the commit id 
should be e8e7be7d212d), then we will notice that the commits will have 
the base-commit: tailer at the very bottom.

This seems somewhat professional compared to the above. ^_^

Best Regards,
Zhu Yanjun

> 
> Regards,
> Tariq
> 
> V4:
> - Renamed the nested attribute for traffic class bandwidth to
>    DEVLINK_ATTR_RATE_TC_BWS.
> - Changed the order of the attributes in `devlink.h`.
> - Refactored the initialization tc-bw array in
>    devlink_nl_rate_tc_bw_set().
> - Added extack messages to provide clear feedback on issues with tc-bw
>    arguments.
> - Updated `rate-tc-bws` to support a multi-attr set, where each
>    attribute includes an index and the corresponding bandwidth for that
>    traffic class.
> - Handled the issue where the user could provide
>    DEVLINK_ATTR_RATE_TC_BWS with duplicate indices.
> - Provided ynl exmaples in devlink patch commit message.
> - Take IFC patches to beginning of the series, targeted for mlx5-next.
> 
> 
> V3:
> - Dropped rate-tc-index, using tc-bw array index instead.
> - Renamed rate-bw to rate-tc-bw.
> - Documneted what the rate-tc-bw represents and added a range check for
>    validation.
> - Intorduced devlink_nl_rate_tc_bw_set() to parse and set the TC
>    bandwidth values.
> - Updated the user API in the commit message of patch 1/6 to ensure
>    bandwidths sum equals 100.
> - Fixed missing filling of rate-parent in devlink_nl_rate_fill().
> 
> V2:
> - Included <linux/dcbnl.h> in devlink.h to resolve missing
>    IEEE_8021QAZ_MAX_TCS definition.
> - Refactored the rate-tc-bw attribute structure to use a separate
>    rate-tc-index.
> - Updated patch 2/6 title.
> 
> 
> [1]
> This patch series extends the devlink-rate API to support traffic class
> (TC) bandwidth management, enabling more granular control over traffic
> shaping and rate limiting across multiple TCs. The API now allows users
> to specify bandwidth proportions for different traffic classes in a
> single command. This is particularly useful for managing Enhanced
> Transmission Selection (ETS) for groups of Virtual Functions (VFs),
> allowing precise bandwidth allocation across traffic classes.
> 
> Additionally the series refines the QoS handling in net/mlx5 to support
> TC arbitration and bandwidth management on vports and rate nodes.
> 
> Extend devlink-rate API to support rate management on TCs:
> - devlink: Extend the devlink rate API to support traffic class
>    bandwidth management
> 
> Introduce a no-op implementation:
> - net/mlx5: Add no-op implementation for setting tc-bw on rate objects
> 
> Add support for enabling and disabling TC QoS on vports and nodes:
> - net/mlx5: Add support for setting tc-bw on nodes
> - net/mlx5: Add traffic class scheduling support for vport QoS
> 
> Support for setting tc-bw on rate objects:
> - net/mlx5: Manage TC arbiter nodes and implement full support for
>    tc-bw
> 
> Carolina Jubran (6):
>    net/mlx5: Add support for new scheduling elements
>    devlink: Extend devlink rate API with traffic classes bandwidth
>      management
>    net/mlx5: Add no-op implementation for setting tc-bw on rate objects
>    net/mlx5: Add support for setting tc-bw on nodes
>    net/mlx5: Add traffic class scheduling support for vport QoS
>    net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw
> 
> Cosmin Ratiu (2):
>    net/mlx5: ifc: Reorganize mlx5_ifc_flow_table_context_bits
>    net/mlx5: qos: Add ifc support for cross-esw scheduling
> 
> Itamar Gozlan (2):
>    net/mlx5: DR, Expand SWS STE callbacks and consolidate common structs
>    net/mlx5: DR, Add support for ConnectX-8 steering
> 
> Yevgeny Kliteynik (1):
>    net/mlx5: Add ConnectX-8 device to ifc
> 
>   Documentation/netlink/specs/devlink.yaml      |  28 +-
>   .../net/ethernet/mellanox/mlx5/core/Makefile  |   1 +
>   .../net/ethernet/mellanox/mlx5/core/devlink.c |   2 +
>   .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 795 +++++++++++++++++-
>   .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   4 +
>   .../net/ethernet/mellanox/mlx5/core/eswitch.h |  13 +-
>   drivers/net/ethernet/mellanox/mlx5/core/rl.c  |   4 +
>   .../mlx5/core/steering/sws/dr_domain.c        |   2 +-
>   .../mellanox/mlx5/core/steering/sws/dr_ste.c  |   6 +-
>   .../mellanox/mlx5/core/steering/sws/dr_ste.h  |  19 +-
>   .../mlx5/core/steering/sws/dr_ste_v0.c        |   6 +-
>   .../mlx5/core/steering/sws/dr_ste_v1.c        | 207 +----
>   .../mlx5/core/steering/sws/dr_ste_v1.h        | 147 +++-
>   .../mlx5/core/steering/sws/dr_ste_v2.c        | 169 +---
>   .../mlx5/core/steering/sws/dr_ste_v2.h        | 168 ++++
>   .../mlx5/core/steering/sws/dr_ste_v3.c        | 221 +++++
>   .../mlx5/core/steering/sws/mlx5_ifc_dr.h      |  40 +
>   .../mellanox/mlx5/core/steering/sws/mlx5dr.h  |   2 +-
>   include/linux/mlx5/mlx5_ifc.h                 |  56 +-
>   include/net/devlink.h                         |   7 +
>   include/uapi/linux/devlink.h                  |   4 +
>   net/devlink/netlink_gen.c                     |  15 +-
>   net/devlink/netlink_gen.h                     |   1 +
>   net/devlink/rate.c                            | 124 +++
>   24 files changed, 1645 insertions(+), 396 deletions(-)
>   create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.h
>   create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c
> 


