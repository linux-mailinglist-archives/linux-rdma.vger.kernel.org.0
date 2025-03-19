Return-Path: <linux-rdma+bounces-8814-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54065A6870D
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 09:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712023B747E
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 08:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92292512ED;
	Wed, 19 Mar 2025 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+Rz19Xd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967DE1DF992;
	Wed, 19 Mar 2025 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373576; cv=none; b=TvqaOL0q7YavsgO2HPGQBl5aPgx9tVReTAygqfxRkeS2oQq3wvPm6BldNeeOcrPDIDzCQLe6ZkcB4A+UsbxJP385MHf/gfTs+tcanyW9ijdh3BHTEkpqtY8qunMBLKAn4uHbejKnigmM4uDRk+o8n/UkAFuaBFN9WpsuvsorZZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373576; c=relaxed/simple;
	bh=fOtkb7sOhsStoY1BvimgrlSVLz8Xirx45QLBQcQCV1o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=APK0B9v+tCwxr3QQWxTUShaePO3WJFBSeSPnhEdryu3NuWZ9rhgN8CIQjK7k0erZ0Ngj86yjpLbpD0x0snDMJFMLp+9WJgo/1dAKWyZjItclo2hE3L0+9PfkZpAZNcfomwnlt1QCDl1B+HU7dEVZJRAeF8hjUtjhYAEWZH42Q3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+Rz19Xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF8BC4CEE9;
	Wed, 19 Mar 2025 08:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742373576;
	bh=fOtkb7sOhsStoY1BvimgrlSVLz8Xirx45QLBQcQCV1o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=i+Rz19Xd8SQiCUF+0YB0N1JcKOEBy2Mm212KokxSptw3ZtBNuKxRuVYJyUgO650dj
	 DOwogDKnlXN3ZCN6QIqHtV1cDRUpMhKwThRlbPOM6pA1DvM9asJxHgpBm3D+Ow6lmZ
	 huVzNP65YbftedBKbG95Sk4Zv5+ZQS7+kZTZWqpf6gY6ZqlawKJHm0CgSlDVFeMHsZ
	 uNWAptZIs468owsjBySIsYD+sqi2TMdtgJ41O2hIo64H8UIjEC5M1YaamnepvZqSv6
	 zV/HWRAZIrqhTltnY3TpHigRR+XCD3E2KdEdRGHKeVW0nFoTr3+f5BtNEVUqcWC4wf
	 7sYy61CroeFDQ==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, shirazsaleem@microsoft.com, 
 longli@microsoft.com, jgg@ziepe.ca, 
 Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1742312744-14370-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1742312744-14370-1-git-send-email-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next v2 1/1] RDMA/mana_ib: Fix integer overflow
 during queue creation
Message-Id: <174237357269.150299.5248478136169422391.b4-ty@kernel.org>
Date: Wed, 19 Mar 2025 04:39:32 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 18 Mar 2025 08:45:44 -0700, Konstantin Taranov wrote:
> Check queue size during CQ creation for users to prevent
> overflow of u32.
> 
> 

Applied, thanks!

[1/1] RDMA/mana_ib: Fix integer overflow during queue creation
      https://git.kernel.org/rdma/rdma/c/0c55174524227a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


