Return-Path: <linux-rdma+bounces-2429-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3636B8C35E9
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 12:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAEBF28180B
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 10:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05791C69D;
	Sun, 12 May 2024 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIPQ5+Jw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6CF1C680
	for <linux-rdma@vger.kernel.org>; Sun, 12 May 2024 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715508439; cv=none; b=b5a9JzFhI6qPVCLJ1GmxvWNZxxNqUsSgC1WaE6k5goG0ScvDMcSHnHiAYfAkM8chug0eZWb83jmO4Nxsn8lh0pTahHgiPpRY3/yclECV0tZ+znLwQAIVSa+h+11n2DIIf+GoB5FWQ1kz4/y5MPxYjKNpbmQ9JHLGRdFVj7QU4ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715508439; c=relaxed/simple;
	bh=VZpjBNcs7XUQ3l+8JiScYCIK7AzS3msXfyvB5SMn8z8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XMTVOyLlQsIXdOfxYG1wC1OjRFU+C3ZaqLzDd/FVTtdYT0Suts4eUA8CEMGhM+qqnq0dImKzG13QIM6MK9HcrCEdheevxP4MQUSv5kTSxQ/oItAt5ekfHTVHtjYbrTGJCWMm5vGt13pXOy6atLUJPQM8AVMVI1WAUWcKEDan6X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIPQ5+Jw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D49C116B1;
	Sun, 12 May 2024 10:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715508439;
	bh=VZpjBNcs7XUQ3l+8JiScYCIK7AzS3msXfyvB5SMn8z8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lIPQ5+JwzJkz9adhM3k65Li49m0QSwBuAoFBO4XfLg9epSXhakrgQN2wIy10yv5jn
	 8pMcazioC+Cfqxjie6c74342+Nh9juywDrChgBLPRe7+S30rFTeKKlOpFDxf1hF7VZ
	 O0tec4/XsDrMu+vQxO2bZu1kPL1eYbKxqUTnaFA1tDwjduNiptjKrkcAIrGaYr/geg
	 bTThSdmbrAlaBRKAmR7P7MJ6HL70AEjZD1oGh4B5uidS5l2bkTFIm6f7xLDXWZ2Z/X
	 r1LYTQZRTXNVzWZiD2z5o64MIz7TeLZWBeJq2EDU5ikEW8fsv//CjdUxnYJF1GuXWq
	 m2KMNT1lwpWjw==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
 Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Yi Zhang <yi.zhang@redhat.com>, Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20240510211247.31345-1-yanjun.zhu@linux.dev>
References: <20240510211247.31345-1-yanjun.zhu@linux.dev>
Subject: Re: [PATCH 1/1] RDMA/cma: Fix kmemleak in rdma_core observed
 during blktests nvme/rdma use siw
Message-Id: <171550843522.119943.12765501005520064425.b4-ty@kernel.org>
Date: Sun, 12 May 2024 13:07:15 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Fri, 10 May 2024 23:12:47 +0200, Zhu Yanjun wrote:
> When running blktests nvme/rdma, the following kmemleak issue will appear.
> 
> kmemleak: Kernel memory leak detector initialized (mempool available:36041)
> kmemleak: Automatic memory scanning thread started
> kmemleak: 2 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> kmemleak: 8 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> kmemleak: 17 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> kmemleak: 4 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> 
> [...]

Applied, thanks!

[1/1] RDMA/cma: Fix kmemleak in rdma_core observed during blktests nvme/rdma use siw
      https://git.kernel.org/rdma/rdma/c/9c0731832d3b74

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


