Return-Path: <linux-rdma+bounces-6721-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B14A9FBBEB
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 11:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464FF16911E
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 09:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CC91B87FE;
	Tue, 24 Dec 2024 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUT8WjDH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1001B6CE5;
	Tue, 24 Dec 2024 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735034337; cv=none; b=uYeP+YTplR1Cqv4LK5SGHm2Dd69OvFS8sT9MO7dOqqaCjDjmL5NIY/ZekYeWia846I+NR9ZMzt2r8aLBLuxi3UQwopkReQZO4YvIZ7JAUwrcDlTxkLItWUcTQyY1ncOQJ/bwjQ2Xdfk8bDXSeM7RfQK1F0rqNA5g5xFz2quVOl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735034337; c=relaxed/simple;
	bh=Q6Z7iAbJN6ZoCsrEnn2xvvWrWe7wsaLHoAQYQH+vMe8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QaFfj7CPbMz5YgFEoNPim2djb0ag4MmdNHKavTT4NzXJ0metDhy7/rDWNbR23Wg2QBP5EhKUkcNBqUONPqKjp+sp8nYfNU8U6FZCem396Tm5XAx7UUn9Xbl0Cr7oq3LlxBYaAjt+nkBlbaaXMrUmtGGv1snIsgu/HLxbvZ4M7H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUT8WjDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B60AC4CED0;
	Tue, 24 Dec 2024 09:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735034337;
	bh=Q6Z7iAbJN6ZoCsrEnn2xvvWrWe7wsaLHoAQYQH+vMe8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LUT8WjDH5yD32zMs0dyYAA5keGMZVs5RI+P4pD8oyU1xIICxoa3e1v80gwGLDibMh
	 ImPCu5PgAyz/yPoMGJMxC3wuyubntMKNqA7bO8xT0kflX6bPYw0m/CXjVlAaiPucTT
	 nzMCKyGruZatQtjc4kgvFxxmSaVqBEOedvbl9gWXIHQNiYfsfdO0BRR2qUS8vYw+Rb
	 9e5NCKdWLt6y0jc6ZkI6L3871w9uMnbxS8R45NlVpPrtgFOPDMdD8MHbhn6lMZicil
	 0LACSrCeFIo6SqhyLaHjjidavVqYr4F1ByQvOsCSjTorLfiYna4RiKwj8CiArIfLYp
	 8LAi5d/tIGUIA==
From: Leon Romanovsky <leon@kernel.org>
To: mustafa.ismail@intel.com, tatyana.e.nikolova@intel.com, jgg@ziepe.ca, 
 linux-rdma@vger.kernel.org, linux@treblig.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20241223001613.307138-1-linux@treblig.org>
References: <20241223001613.307138-1-linux@treblig.org>
Subject: Re: [PATCH] RDMA/irdma: Remove unused irdma_cqp_*_fpm_val_cmd
 functions
Message-Id: <173503433348.413712.8629586162547024611.b4-ty@kernel.org>
Date: Tue, 24 Dec 2024 04:58:53 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 23 Dec 2024 00:16:13 +0000, linux@treblig.org wrote:
> irdma_cqp_commit_fpm_val_cmd() and irdma_cqp_query_fpm_val_cmd()
> were added in 2021 by
> commit 915cc7ac0f8e ("RDMA/irdma: Add miscellaneous utility definitions")
> but haven't been used.
> 
> Remove them.
> 
> [...]

Applied, thanks!

[1/1] RDMA/irdma: Remove unused irdma_cqp_*_fpm_val_cmd functions
      https://git.kernel.org/rdma/rdma/c/695df3e833c04a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


