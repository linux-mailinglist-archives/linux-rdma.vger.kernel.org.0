Return-Path: <linux-rdma+bounces-11447-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F56AE02DF
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 12:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50494A0FA8
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 10:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3805A224891;
	Thu, 19 Jun 2025 10:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J11pst41"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF2A21D3E4;
	Thu, 19 Jun 2025 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750329727; cv=none; b=dj+QY6oIaAaQK4iXFDG0M+AN1UYgaK16ClKX11UOwq1EXR3AayN3mP84RfWrbeyLizIQkMa700XH2eh0DNnveJ4r7px34Jsebpasc27KScacPC/6AFHpX+V2+pRHJXHmJlycsknN0U7Q/RvdHXBp4zpbyLOIOFCEyc57TsJtxcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750329727; c=relaxed/simple;
	bh=HsmJreAtSgFEkF9X/4Gl1O8AWkga+Jva55lo97p0/v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlRBNZkxpJ15/s3/ho9d4+m7sKDac4DxHo6ARb8zPUj9+FuOh6KHJPXkz4J5ixHWkXTRlwgYpLlL84t28NbFarcEyh23ZoWWVPcmkBhaLxCQdLngYIhOLy1dZ9tHajvBAsp2KQvWSn0h+uUv3hG3yXVLhSg15rwgXPmdPoMuNSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J11pst41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72294C4CEEF;
	Thu, 19 Jun 2025 10:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750329726;
	bh=HsmJreAtSgFEkF9X/4Gl1O8AWkga+Jva55lo97p0/v0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J11pst41RkMVh7LudhxVNSQyxyKyhsfAgZRVm+8+hIe1qki5VmNqtil25IffwWctK
	 Tzfrq/LCQ5uebPEeEtyPtpZBnRp3l2q5QYahjXs5KDhWPgwxtHHbQC5XIyIc5Q3pTL
	 ONmSGQ79s4bFC91e6qa7pOaFcdup+hDsMlbx4Fjk3qL9SJM6aYZSON7QbxXVmmIqmH
	 nnydefDjSjkIngMykDBA2WNJxOi1yToehAsP7VZN+46PMnWLeYgWZWkSD/OPyRIXIU
	 eHtBxe+QlJbynVNb9Xz1M8k9WEjCRFVebzd6u5HSk0bsDBaQf32n8UN8spxvMsJaNV
	 vosLQvuoQGrRQ==
Date: Thu, 19 Jun 2025 11:42:01 +0100
From: Simon Horman <horms@kernel.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/smc: remove unused function
 smc_lo_supports_v2
Message-ID: <20250619104201.GI1699@horms.kernel.org>
References: <20250619030854.1536676-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619030854.1536676-1-wangliang74@huawei.com>

On Thu, Jun 19, 2025 at 11:08:54AM +0800, Wang Liang wrote:
> The smcd_ops->supports_v2 is only called in smcd_register_dev(), which
> calls function smcd_supports_v2 for ism. For loopback-ism, function
> smc_lo_supports_v2 is unused, remove it.
> 
> Signed-off-by: Wang Liang <wangliang74@huawei.com>

Thanks, I agree with this analysis.

Reviewed-by: Simon Horman <horms@kernel.org>

