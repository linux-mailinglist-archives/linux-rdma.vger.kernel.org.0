Return-Path: <linux-rdma+bounces-10391-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24035ABAE3E
	for <lists+linux-rdma@lfdr.de>; Sun, 18 May 2025 08:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FB287A4F1A
	for <lists+linux-rdma@lfdr.de>; Sun, 18 May 2025 06:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459811FF1C7;
	Sun, 18 May 2025 06:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aG0++5kB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044031FDE19
	for <linux-rdma@vger.kernel.org>; Sun, 18 May 2025 06:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747550567; cv=none; b=MlkAUwEeBaGyj2GwSK0cP70OCla2LI0My3lcGZLusCC0jpxBcPa2u8Kq54Oi6ghqBNxKyATZ/4XHbxwy78LrzUSAyFsI1+rU23smSlSStd7UgFa0YT96wGnV2E4toObKw5h2r28ho8US0oZnXzSiPOXZRTLaxO6Ts1ROuB5HIVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747550567; c=relaxed/simple;
	bh=ezJL7GLVyvwrh6XqZKLUL1k3ZwdgZ8lVGWbU8kDm1FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLT7b9/FvoeefTmROeUNSIGCUTR2I11u3IRUCXYBpSKEvQK4v20sE0/C3g7pRbBTZfNYnpr0VScC6r7XmNbPTQPzv5HVbFE1rRy6Wm0Jq/Bu5sbHvqjZQ0R6YFYFFXbaY2bHwtZByHJCz8Lu/4Zav5tleVCAe4SFIthzkYcZgh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aG0++5kB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B38C4CEE7;
	Sun, 18 May 2025 06:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747550566;
	bh=ezJL7GLVyvwrh6XqZKLUL1k3ZwdgZ8lVGWbU8kDm1FU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aG0++5kBwmnGoBa2TQbF2xTXchDzoCaqq86ISaxRS7XSZsSL9DEP77BQwVcqrnvwS
	 x3XZaJ7SMmbrBE7xw9lmkYNBSx5IMI0Da9StI0G+fBrBPm4TKwBgFmdQNwxvgYc93j
	 qw4TbftNNRvDV2OqXYYwQueSVEkyQEHCsbZxMnlcPWXBX68nHEPD7OjWzS7jqHk98A
	 P6X0kU1BXMMSIaHBqTKoh8HhJaaCqE0Bk3SA4//nOyP7CAePZYA0C7059+I9yXlq7w
	 FSLJ3tQ8Aa2KuZRseqa3xyn7Z+gszi6PasQP595xLZiyJ+PupoXwOt8JLFY9SBpzhi
	 VMYb/l3SVOtiw==
Date: Sun, 18 May 2025 09:42:41 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Michael Margolin <mrgolin@amazon.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	Daniel Kranzdorf <dkkranzd@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Add CQ with external memory support
Message-ID: <20250518064241.GC7435@unreal>
References: <20250515145040.6862-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515145040.6862-1-mrgolin@amazon.com>

On Thu, May 15, 2025 at 02:50:40PM +0000, Michael Margolin wrote:
> Add an option to create CQ using external memory instead of allocating
> in the driver. The memory can be passed from userspace by dmabuf fd and
> an offset.

EFA is unique here. This patch is missing description of why it is
needed, and why existing solutions if any exist, can't be used.

Thanks

