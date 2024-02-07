Return-Path: <linux-rdma+bounces-939-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A542E84C2B0
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 03:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87461C24D0E
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 02:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72578DF78;
	Wed,  7 Feb 2024 02:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9+bkopP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA5F125C1;
	Wed,  7 Feb 2024 02:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274091; cv=none; b=ia3dSlrFeqgDCEwxZ1R8Py6D8nk/C6bfsqPtFPOc4DC0aVSvRJj9BsC28T/CdVxIuE6/8tE95Kx4j8f99TaDJgM3wMjHY2+mhAbpOiY9W7PQ+QLxNBctdxZOmrEZ3fl2iXOZ9CydBZjIdftO2RiPpkgN68Tv+hSKc7zYkXrtEQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274091; c=relaxed/simple;
	bh=l9Cx7GFhHopBXLBZMG3XW2aycI48hJGl20X5dWgr2nI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mgCU1Ib4UQDzvh3AYjST/Bg/qbQH0jviRS9lrSDTN74Stvoi6bQbnOiuTOQHm2kZmi6S7Fcgp9PoYdr+tY8jc/knRy/UhGUNkWrgrhlJPBBLmw+4sZ2FG3wM4DlgN0CwHI+QjXLHxZ0p0hEiL8+HtKO2DG6QWSuuqH0HTLC8Zgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9+bkopP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5218CC433C7;
	Wed,  7 Feb 2024 02:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707274090;
	bh=l9Cx7GFhHopBXLBZMG3XW2aycI48hJGl20X5dWgr2nI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F9+bkopPNBVv6deJ2R44MUvWx0DJxslxL9MYbbb/QgFvOK0KxsMkYAjjFK4WVMiCD
	 H07WSklCOcJhJWcQ0UIjq4FTPq5R6DxZbVjCFwU4gw7nFzDAco0ix5Wp4g+hFzDccl
	 gdoRSWcAo7PqDhs7MoNc197YnHYuG/bj2Ziw5iN3qxmXO6QOUNN0rLp0SNdo9FoLCe
	 JVuHbnJByiERJzKeG+KOale9Uk+4butwxRNHBHwM4KZqG235E/+NxUBtHkUnLnGuoq
	 ly27vzSwQ82HCPMWr/9y42PoEf9HGtAcWWgTop3QIVNc/yNSnGkdnijLBEIKfT28ix
	 0oSrvKICHoPTA==
Date: Tue, 6 Feb 2024 18:48:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: allison.henderson@oracle.com
Cc: netdev@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-rdma@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, santosh.shilimkar@oracle.com
Subject: Re: [PATCH v2 1/1] net:rds: Fix possible deadlock in
 rds_message_put
Message-ID: <20240206184809.1a245236@kernel.org>
In-Reply-To: <20240131175417.19715-1-allison.henderson@oracle.com>
References: <20240131175417.19715-1-allison.henderson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 10:54:17 -0700 allison.henderson@oracle.com wrote:
> Fixes: possible deadlock in rds_message_put

This is not a correct Fixes tag. Please look at git history

