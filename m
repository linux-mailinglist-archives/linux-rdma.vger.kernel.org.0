Return-Path: <linux-rdma+bounces-12703-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73C3B247FD
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 13:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604C917E934
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 11:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F042F6570;
	Wed, 13 Aug 2025 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLaKQQx3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52F52F28F4;
	Wed, 13 Aug 2025 11:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083185; cv=none; b=ikHKGaSk0qq65oSsiwAxKB5Jid0bgpgvW8ZqZ2qyamFfm3qqHZy2IW09wlACHhxvmotsr52caTWqldUT9oauej6+I/+k+XN+OIb/uPKyd9GTCXBCZMBYZsKs3pHHxXreewpN3Sxk5sU/QbuEjvWYkaqCuDgWwjyLxl9n3tNWvIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083185; c=relaxed/simple;
	bh=LfFCw1GiHhrzBmptuNDQ/aeYnRAaPGPtUOjHtJF8ibM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EAJOi+rIjOjOzfxg3bBARTqlEfNIjj4zx0ibqtHM7VjzQhewGKErosLGs/+smJbPYW91pDRsSTD2bnY4O7CekBad4EM/0ZkOWd2NA1oiElscn2hpN3QmZ+v3Jl4qSTHNeZoAsycwBsGYS5/suFr0//TMiA4Cg8HOpVJoMrOAOwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLaKQQx3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3F3C4CEF5;
	Wed, 13 Aug 2025 11:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755083184;
	bh=LfFCw1GiHhrzBmptuNDQ/aeYnRAaPGPtUOjHtJF8ibM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QLaKQQx3R7a01dppD8GG5CDjmb+66U3AM7Fxc0bTrTL4EP8pU5aodTT2YqjNbD344
	 r+hKCg9mtQNn3xHzOhy0BdBeooneU01ygfts5kpAl7G5bunsjVFGA1/X9Z+eRibe0s
	 QqKd3NISKaeGqvBL9Reht22+gUfL+hmBwpoZLqORuE587QtlcW3vtT0eZYRYifC/8K
	 2lfVNiBD7IfJMMEYyGlKrCelw2D17e8uKyLB5EZoV9m9FWlo5SiDy2+USsG35xDrmt
	 3KqlzFMJkMBYce5s/cxv8zFrh+ZMbt5Xb/mh+ADrHCl6kQ9cCk1g6DcVNldhdJZr7g
	 pOeS2DKQ/8XOA==
From: Leon Romanovsky <leon@kernel.org>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Fushuai Wang <wangfushuai@baidu.com>
Cc: dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca
In-Reply-To: <20250811062534.1041-1-wangfushuai@baidu.com>
References: <20250811062534.1041-1-wangfushuai@baidu.com>
Subject: Re: [PATCH] IB/hfi1: Use for_each_online_cpu() instead of
 for_each_cpu()
Message-Id: <175508318090.201024.471831304009902438.b4-ty@kernel.org>
Date: Wed, 13 Aug 2025 07:06:20 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 11 Aug 2025 14:25:34 +0800, Fushuai Wang wrote:
> Replace the opencoded for_each_cpu(cpu, cpu_online_mask) loop with the
> more readable and equivalent for_each_online_cpu(cpu) macro.
> 
> 

Applied, thanks!

[1/1] IB/hfi1: Use for_each_online_cpu() instead of for_each_cpu()
      https://git.kernel.org/rdma/rdma/c/211dc59b7bb5ea

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


