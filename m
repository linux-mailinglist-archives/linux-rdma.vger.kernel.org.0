Return-Path: <linux-rdma+bounces-10437-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A389ABD914
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 15:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6CC3A6928
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 13:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F59022F177;
	Tue, 20 May 2025 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzKdsfOC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0347022E41D;
	Tue, 20 May 2025 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747746915; cv=none; b=E5+6FV09oKFiF5aAVXWJMhCHh3AaBAKGxCqnZKvky27HF6EoabQHcCREXN1dHiqL31Z595XnzVLUVEh9UnU2Qr9J+X3XH2OVmtoVT0kMqww9s+n5erVht4ocTyaaK6tjJtJINFJ8KWkO1gQWyw0Y85FGBYI/5qxJSenvGv0NKM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747746915; c=relaxed/simple;
	bh=9tj76eu3sKrF8PVmXoXkqtJ9c6WRvLo3PI0Ap5SxH08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsxW+ayWWnpHKRxeIadFDnPPVk6oTEWfk8q1zn97fW0du6AWW1Jck4VGVQHBq/b6YXlr6MkaloJs01sR/Z0mCLR26SKlQovLnbo7zkzmYOAmRarIVTHuNhfUhmXKlWFvzMJUY1HJ50IwADkUctIRQK/IDm6DUlokbcAAXEfyPDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzKdsfOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03600C4CEE9;
	Tue, 20 May 2025 13:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747746914;
	bh=9tj76eu3sKrF8PVmXoXkqtJ9c6WRvLo3PI0Ap5SxH08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hzKdsfOC7xVkJ6zwsMcExFPc25JypJphrY1RWcicJlVNezG4cvu6YEJVZ0ybcVHMh
	 bPZuxUh9IK7WT5zdMgzZTidjXF02n5MDaQVWKVgbovarWJSqHl/iTz3Mp1icYlvQ8z
	 jUlPSsZJOqZNw/Ca3bUaG8cDlxHyPvqoraUyp889vHxNCC4a8zdze9DD7yfcRdqs/Y
	 8aRRxiAXyfDqc6vA/2KOihPglbw7QQlXnBF2H1FKl8SuKkzJIViXP0BacUEo0nNm6s
	 TZPjLrFUygXv+ka+2hspO8vLRC3GujDFShcl6JZiFlajBd1DoZzBEc/S2mEPA/MUc7
	 YwE/Fx5hrOYYw==
Date: Tue, 20 May 2025 16:15:10 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>, mustafa.ismail@intel.com,
	tatyana.e.nikolova@intel.com
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/irdma: puda: Clear entries after allocation to
 ensure clean state
Message-ID: <20250520131510.GG7435@unreal>
References: <20250518144942.714-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518144942.714-1-vulab@iscas.ac.cn>

On Sun, May 18, 2025 at 10:49:42PM +0800, Wentao Liang wrote:
> The irdma_puda_send() calls the irdma_puda_get_next_send_wqe() to get
> entries, but does not clear the entries after the function call. A proper
> implementation can be found in irdma_uk_send().
> 
> Add the irdma_clr_wqes() after irdma_puda_get_next_send_wqe(). Add the
> headfile of the irdma_clr_wqes().
> 
> Fixes: a3a06db504d3 ("RDMA/irdma: Add privileged UDA queue implementation")
> Cc: stable@vger.kernel.org # v5.14
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> v2: Fix code error and remove improper description.
> 
>  drivers/infiniband/hw/irdma/puda.c | 3 +++
>  1 file changed, 3 insertions(+)

I need Ack from irdma maintainers.

Thanks

