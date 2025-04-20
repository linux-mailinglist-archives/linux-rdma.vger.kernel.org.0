Return-Path: <linux-rdma+bounces-9613-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D36AA9482D
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Apr 2025 17:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75CEA3B43FE
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Apr 2025 15:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE27A1EE039;
	Sun, 20 Apr 2025 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2zwAG6J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB9613B59B
	for <linux-rdma@vger.kernel.org>; Sun, 20 Apr 2025 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745162530; cv=none; b=hZYv7994b3OBk4CiJkCKOsI/XuxgJWC6fFQv31+3ujmkUEfo5SqlhNiOGna2MJJMXhrCOcl2O33T6Qu+gyXkTc4pX20aeBuRUuHU3HLtHdjjJ/jpXas9S2rFJRSo6s1J3usaC3bB8N1/UwBJ2g7HlyJF4eh5HpO9h8Q6P5weaHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745162530; c=relaxed/simple;
	bh=cc10cdP+SAZm/yneUw3AaiN53gQotcAmFlQSygF3VuY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V4DjOCsLOYhDfXp/X84tGqlkkCjkAMqNYrnkP/c7JdE6CrWcIuUXQ5HgfD0eyUOHQKwOutOGCrd9+AV03xy8ariPgzzdT9xbKQnzNxcVMbHdxItH07hHDsom20chRonrIPPP7gEbuZ7ofE8s6Lk0rmetv/cSV+TYqoQdpu3nMXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2zwAG6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDCFC4CEE2;
	Sun, 20 Apr 2025 15:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745162530;
	bh=cc10cdP+SAZm/yneUw3AaiN53gQotcAmFlQSygF3VuY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=i2zwAG6JGa0lzpq/I7HWVkOI9KsSXeRtOzbqWs1SSI/Ml+lHJNF7JG9h+3H4vwhY5
	 krV9KTGcPQ7xln3Spw/7X1G4KPI3atDU4M5++LbSi9XGdKgZMUdS5nxENw7zwOlncV
	 juIaXupkFN7kKWaCqT9N2jJ1irKTeQPXVGq3eq3HgU+5ksBX9yMPcUj62SvsSWEM+3
	 nbEnW7I1QY6VzhnRjLDs9ny6PkIx6EYq8cp6mSRywnT9NNNeg+CBFqVa2uBiXsHmpf
	 ZwonC6ipY1P+5GbyXK7MY7hrczVCCPkU0oipWodkzpE5YHpp2zHmwQnoMZkQsHRstK
	 M6HEhnqng01vw==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 tangchengchang@huawei.com
In-Reply-To: <20250418085647.4067840-1-huangjunxian6@hisilicon.com>
References: <20250418085647.4067840-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-next 0/6] RDMA/hns: Add trace support
Message-Id: <174515167383.720316.10548192191975881376.b4-ty@kernel.org>
Date: Sun, 20 Apr 2025 08:21:13 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 18 Apr 2025 16:56:41 +0800, Junxian Huang wrote:
> Add trace support for hns. Set tracepoints for flushe CQE, WQE,
> AEQE, MT/MTR and CMDQ.
> 
> Patch #5 fixes the dependency issue of hns_roce_hw_v2.h on hnae3.h,
> otherwise there will be a compilation error when hns_roce_hw_v2.h
> is included in hns_roce_trace.h in patch #6.
> 
> [...]

Applied, thanks!

[1/6] RDMA/hns: Add trace for flush CQE
      https://git.kernel.org/rdma/rdma/c/96cb704b04419c
[2/6] RDMA/hns: Add trace for WQE dumping
      https://git.kernel.org/rdma/rdma/c/cc1131a3004ed6
[3/6] RDMA/hns: Add trace for AEQE dumping
      https://git.kernel.org/rdma/rdma/c/39091301472a12
[4/6] RDMA/hns: Add trace for MR/MTR attribute dumping
      https://git.kernel.org/rdma/rdma/c/0f38b1359190fb
[5/6] RDMA/hns: Include hnae3.h in hns_roce_hw_v2.h
      https://git.kernel.org/rdma/rdma/c/07474abfb48070
[6/6] RDMA/hns: Add trace for CMDQ dumping
      https://git.kernel.org/rdma/rdma/c/6ce9c93102b98b

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


