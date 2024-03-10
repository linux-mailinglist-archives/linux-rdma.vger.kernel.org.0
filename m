Return-Path: <linux-rdma+bounces-1369-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5952687782D
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 20:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBDCD1F21248
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 19:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1D739FD3;
	Sun, 10 Mar 2024 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USuG65Iv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8823065B;
	Sun, 10 Mar 2024 19:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710098354; cv=none; b=mFW9OZ2uvJ0hjVzRbvLQpx567KTu6+fhZQ+DWJLtU9Qgk3D2Rg3wcl7TML5D3DI742+hyxOFcpSK+AMNlXpjhczmuD5UXMBGZlTix5brfimP7jXAQIxtF5T6o9XyYi98UasQJmMVBg1jUw665YQZwKZPvGrY28zJjgBI0xIV+7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710098354; c=relaxed/simple;
	bh=vEioFK4BXE/VD41IBgnIDDIJDOJxCchRrXThDUfkbzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nvg+cn8VRo7KQriS6I+iidSrxCJ17W6kZEr03TqOs3zqtVVk2+JBtmbJfNYyspkZ5tkoBIDWG15GjdkPoz1jhCmW8kDz/H1bipg84xZaUVziraLtb/cO9ZoL9VbKhkgMMk0HIa9VaK4fb50tDx6cc34kAKJnPX2ODE4By1rE8Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USuG65Iv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B5AC433F1;
	Sun, 10 Mar 2024 19:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710098354;
	bh=vEioFK4BXE/VD41IBgnIDDIJDOJxCchRrXThDUfkbzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=USuG65IvMp3kWPIq9Oxq2ufhBtzrZLxAbUz6Jlt82E5PgCnYqm89oM4q/4btXtXlc
	 umoq1KPIMDwTdiiUqzmr4QZr3Sf/U4yYP5GSRpmtQPv8aB7pUTdr3xvIa0SQ05kxt6
	 8drSNT2bwjiyYjluKkqPMDKFhsk2Bqs6YsG6wnrMiRi+oFAuNJZfFP9jI0ogWLBHx3
	 /EjcLdEnknaVR6FspJGx+olpom5OpjQokzGV+OAXppywsNIW6MOuNzBR/EccRqV5Cy
	 aQXZ9+DbeOFdHogObUJkxijd6sZ0VxNxcyB1D1GwUMxE3H6mqJIRzdWajD4QXD2MlV
	 wRLb4KuaQLNRA==
Date: Sun, 10 Mar 2024 21:19:10 +0200
From: Leon Romanovsky <leon@kernel.org>
To: linke li <lilinke99@qq.com>
Cc: bmt@zurich.ibm.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/siw: Reuse value read using READ_ONCE instead of
 re-reading it
Message-ID: <20240310191910.GG12921@unreal>
References: <20240310113306.GF12921@unreal>
 <tencent_49503CC554528271302D9D214218898E4206@qq.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_49503CC554528271302D9D214218898E4206@qq.com>

On Sun, Mar 10, 2024 at 08:15:25PM +0800, linke li wrote:
> I want to emphasize that if the value of orqe->flags has changed by the
> time of the second read, the value read will not satisfy the if condition,
> causing inconsistency. Given that there is already a READ_ONCE.

If value can change between subsequent reads, then you need to use locks
to make sure that it doesn't happen. Using READ_ONCE() doesn't solve the
concurrency issue, but makes sure that compiler doesn't reorder reads
and writes.

Thanks

