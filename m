Return-Path: <linux-rdma+bounces-14041-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC139C08960
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Oct 2025 05:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC191C232C9
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Oct 2025 03:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F49253939;
	Sat, 25 Oct 2025 03:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTyjxOHW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2181D63F0;
	Sat, 25 Oct 2025 03:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761362519; cv=none; b=jkzZ9u6j21zL0dhTWJBz7OthE/LE++H7S1PS/nCLijeaXzD6pMrwla/GxrCVk3RBlFIv8kG410eX91mHOU/K63BSD/qR8jDTindeLJGOcJhjrtpBH1bqxlLXiVYpt/bLfhkP4z8MPWhYxRTrCpikvEzAUIDqVg4WLxrXyCRhOZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761362519; c=relaxed/simple;
	bh=5ld7Qi81JwAcgeuIPKTOQCsSMi3GItVu2Z4FKHri/98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEkzUdSC63K3N0KUpaGjyGRB3AocP7s+2B2zLqd23MM5dhOIWtWWyW0203rPP/Cq1w4AqUPuCXQUvQl7ZTsmnHgQ7N5yr1a8HMxezXcftqMUW0vUebCUbvTtBeNI01r9kidK3X9x8E0Yq3AAbW/9pMqx2B6bot5kHXQsDMAnGGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTyjxOHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8AAC4CEF1;
	Sat, 25 Oct 2025 03:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761362518;
	bh=5ld7Qi81JwAcgeuIPKTOQCsSMi3GItVu2Z4FKHri/98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sTyjxOHWJ7fYJh/qOMcIhYGkGGzsjcVHO0uZ0j9ml0ZzUAXiYBVxn/P/YyuqBryxj
	 0iJFRByNp7G1AYxOJqNyJRXrSfKRA6klpJ7A4lBDs0V6PzwrLaECHYZTR5e7BOgGxn
	 sH1R/vFPTmomvgoeCfG6SPzqhTBnKjf1HVvbkcSPUQXxV9sYQYKDDmN+1sRS4lNK5A
	 k67ro/pBfbHHZsMQ9Y2L9P54PFtqSPgGPWcV5BAMq1PF+MtDlj9R0j9LFoWba7HyN5
	 6DncbMSGQP2XMBy6CJA0vYeeDpleAscv7xgk7mkcb2lW7TvYBbvuyy+L4DF6LLqIlw
	 aqwlivvlRbHRQ==
Date: Fri, 24 Oct 2025 20:21:57 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH mlx5-next] {rdma,net}/mlx5: Query vports mac address from
 device
Message-ID: <aPxCVRvMlpOQPbhL@x130>
References: <20251016014055.2040934-1-saeed@kernel.org>
 <20251021164759.2c6a5dc9@kernel.org>
 <aPg9hQjpXeR-mJG2@x130>
 <20251022171033.43ae5dc8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251022171033.43ae5dc8@kernel.org>

On 22 Oct 17:10, Jakub Kicinski wrote:
>On Tue, 21 Oct 2025 19:12:21 -0700 Saeed Mahameed wrote:
>> On 21 Oct 16:47, Jakub Kicinski wrote:
>> >On Wed, 15 Oct 2025 18:40:55 -0700 Saeed Mahameed wrote:
>> >> Before this patch during either switchdev or legacy mode enablement we
>> >> cleared the mac address of vports between changes. This change allows us
>> >> to preserve the vports mac address between eswitch mode changes.
>> >
>> >Not knowing what exactly a vport is I can't tell whether this preserves
>> >MAC addrs of reprs, the uplink, something else?
>>
>> vport == vf or sf, so VF/SF permanent mac address. It can be set either by
>> iproute vf interface or devlink function interface. For no obvious reason
>> we reset it to 0 on switchdev legacy mode changes.. this patch is fixing
>> that.
>>
>> Of course vport holds more information than just the mac address, e.g GUID,
>> mtu, promisc mode, mulitcast mode, and other stuff.
>
>SG! Would be good to incorporate that into the commit msg if possible.

Makes sense, Done.

Applied to mlx5-next ! thanks for the review.


