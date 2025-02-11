Return-Path: <linux-rdma+bounces-7652-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E527A304F1
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2025 08:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6343A5177
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2025 07:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EDF1EE03B;
	Tue, 11 Feb 2025 07:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3Ohyi+g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F36C1D54C2;
	Tue, 11 Feb 2025 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260560; cv=none; b=Tq2pYpr4ayWsNAKL5++sEXSwi+yicc01RRMuOUh6oFgkNYFNjdKec/D7afV5v2ZkQFnoH+2jeEqYvAPhwcMBC5+kJYswdZtW/UuXyeYsL/ku915X1ifrhqwyX5Z4dnluC2neIw3DngjJWbwcxiCgG1R1EuND5HNo1K3G8+pPWMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260560; c=relaxed/simple;
	bh=FELs+YTJY5wG1fT/XXOisUg9dVRRC8S4Idi6jI4jsP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abFGcaewlxAdTu3vsOrxXdRQVNCGTR6ZN4HL9j5+sXuxRHeZN0J5V4JHHJvOJHrsoPLpk7XtWzgvnt+ftAiuhvIHwOQsPegIv+qFhbbtYjrfY9fLqepxecWR0PYA8MU7wVzFKerfZHsO9ylT/IHKSgevq5ohl8Op3Y5tdjSpCus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3Ohyi+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A839C4CEDD;
	Tue, 11 Feb 2025 07:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739260559;
	bh=FELs+YTJY5wG1fT/XXOisUg9dVRRC8S4Idi6jI4jsP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t3Ohyi+gbS9BSClkhjavMy30VcCoo4YwwtZXQ9CPju2TActO/eM8iFP9kooICHeTA
	 LAo/p/bohI/WTXYKIX/ry85w4tOnhw6Zgi+Yg02uzpr1Vt4X+92FjjDduMquF1sPSO
	 fyh9R0f8DC3tQx74N3ITFaaeHZeXow8IHRKkJ7Au/5UgKlDvR2IFsbiib0C7zJhvP6
	 BkQVexRj23EzHICjCcA4SsDpAMvS9fhzECBuNbypW7VpYE3oC18/J7pSNxnS9/JC2m
	 a0OezbLMWAJfIb7gIPk/ng2WKOCntFyqD/r+XKnBeRE8DG6YqKJLersMh7d1lgQlIk
	 CUE6+f2ULccjQ==
Date: Tue, 11 Feb 2025 09:55:53 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	"Nelson, Shannon" <shannon.nelson@amd.com>,
	Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for fwctl_bnxt
Message-ID: <20250211075553.GF17863@unreal>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <10-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <20250206164449.52b2dfef@kernel.org>
 <CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
 <20250207073648.1f0bad47@kernel.org>
 <Z6ZsOMLq7tt3ijX_@x130>
 <20250207135111.6e4e10b9@kernel.org>
 <20250208011647.GH3660748@nvidia.com>
 <20250210170423.62a2f746@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210170423.62a2f746@kernel.org>

On Mon, Feb 10, 2025 at 05:04:23PM -0800, Jakub Kicinski wrote:
> On Fri, 7 Feb 2025 21:16:47 -0400 Jason Gunthorpe wrote:
> > On Fri, Feb 07, 2025 at 01:51:11PM -0800, Jakub Kicinski wrote:
> > 
> > > But if you agree the netdev doesn't need it seems like a fairly
> > > straightforward way to unblock your progress.  
> > 
> > I'm trying to understand what you are suggesting here.
> > 
> > We have many scenarios where mlx5_core spawns all kinds of different
> > devices, including recovery cases where there is no networking at all
> > and only fwctl. So we can't just discard the aux dev or mlx5_core
> > triggered setup without breaking scenarios.
> > 
> > However, you seem to be suggesting that netdev-only configurations (ie
> > netdev loaded but no rdma loaded) should disable fwctl. Is that the
> > case? All else would remain the same. It is very ugly but I could see
> > a technical path to do it, and would consider it if that brings peace.
> 
> Yes, when RDMA driver is not loaded there should be no access to fwctl.

There are users mentioned in cover letter, which need FWCTL without RDMA.
https://lore.kernel.org/all/0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com/

I want to suggest something different. What about to move all XXX_core
logic (mlx5_core, bnxt_core, e.t.c.) from netdev to some other dedicated
place?

There is no technical need to have PCI/FW logic inside networking stack.

Thanks

