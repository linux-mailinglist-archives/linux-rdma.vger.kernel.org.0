Return-Path: <linux-rdma+bounces-6841-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0D1A026E9
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 14:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913681885EB9
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 13:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920241DE4E1;
	Mon,  6 Jan 2025 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxagEfAj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469564120B;
	Mon,  6 Jan 2025 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736170883; cv=none; b=kBaXZ7wGtjXGpkIsvP+Fg+BvygFAheP3aAAWxrT+YLNn77xnmz+/hLvIFsxOilZvVyAOgF1rfZq1o2rcSmbK8iE/u1uznv6SVLM9KpcEP6Ny1t2WMnb8OfARHMKqH7KfCEdC878hOh9pFVtaUcL9txG9Wn0vl/yykBA4HrBm5uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736170883; c=relaxed/simple;
	bh=oIcathUnPDdXbhIgrKUGShtjk25afmM3HINBctjFHFc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hR7IWx3SL+1Z7Riy2qZs4WlQQDkvudrw+i5wvpfRYw7kDtcq7fH39Tl7gCXp4D1JrPBuODhuh1YRU2QU60FF86B7AktRRKZj/jZ2V1M//1KknzqZnlGIRuXqICO9Ghd9xhzlGcRfpZtVZkks6zc5+JW++L2i8ghkCy6cOKTMUxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxagEfAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C2BC4CEE4;
	Mon,  6 Jan 2025 13:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736170882;
	bh=oIcathUnPDdXbhIgrKUGShtjk25afmM3HINBctjFHFc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gxagEfAj3+wCpHQmLgMSQnaLsMA9Yjx55LDGevDzdCfmc0vmyiJNsitXS2GnVjRa/
	 pB9pnd4yXS9aWkIYJ059yHKVhuHPNk37GFLGJ6hOAFmfALLs/dIKT8xUdszE9wm7Jh
	 GxPaKJfWhyLxN0T0CLFWlQgFgWu0qU6SeKnsC0XXOxjbyGTLFMXR8RbQAhwjg00IoS
	 sYkycKlk6G8lCW0LWb6gJhsiseFb0tZOzw0qBscJMZP3rbe2wGoR8DSRBWeddkbGD6
	 Os/bQBAinschogbzbv/f31YMKFbozVWxUFo/lZ7V7d1nOgiPkbdKn3W6qegbBz5kAa
	 iI2cEpkWQfbUQ==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 linux-kernel@vger.kernel.org, tangchengchang@huawei.com
In-Reply-To: <20250106111211.3945051-1-huangjunxian6@hisilicon.com>
References: <20250106111211.3945051-1-huangjunxian6@hisilicon.com>
Subject: Re: RDMA/hns: Clean up the legacy CONFIG_INFINIBAND_HNS
Message-Id: <173617087916.510618.9492355677064880671.b4-ty@kernel.org>
Date: Mon, 06 Jan 2025 08:41:19 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 06 Jan 2025 19:12:11 +0800, Junxian Huang wrote:
> hns driver used to support hip06 and hip08 devices with
> CONFIG_INFINIBAND_HNS_HIP06 and CONFIG_INFINIBAND_HNS_HIP08
> respectively, which both depended on CONFIG_INFINIBAND_HNS.
> 
> But we no longer provide support for hip06 and only support
> hip08 and higher since the commit in fixes line, so there is
> no need to have CONFIG_INFINIBAND_HNS any more. Remove it and
> only keep CONFIG_INFINIBAND_HNS_HIP08.
> 
> [...]

Applied, thanks!

[1/1] RDMA/hns: Clean up the legacy CONFIG_INFINIBAND_HNS
      https://git.kernel.org/rdma/rdma/c/8977b561216c7e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


