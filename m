Return-Path: <linux-rdma+bounces-8772-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA2FA67068
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 10:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE37717C2F0
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 09:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AFB204C2A;
	Tue, 18 Mar 2025 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDcA9lva"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F76A288DB
	for <linux-rdma@vger.kernel.org>; Tue, 18 Mar 2025 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291731; cv=none; b=K5dxJ5adqiRYL2GdAzlOmz2l7RNUMBGEEygtwtz6q+o6DMc/7RO067RTl1rW1ysuF7Wnw/q9KPPTw9n6Cn+03qKYSI3iEkKcdgtebWdyVD2UIV+EH7RTv+4yV5XPd3YCPOuF5zT/rzC8j22SJClqOFghaVWBfoII7iA8WHpKExI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291731; c=relaxed/simple;
	bh=sdmcaPvM69T/whUOvHnyyjA6izY79DJE+3kXbUnk0l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dU5y4sA5Ah0Kc1PrQ5sTT/FsutOSCbqt+XdEfdgiDUmMZVml35DbEgcwk/rK09Y1gnodg2RY8kM8DoE0/dXec1JoqIhHCNMdnRZLieTnknjUaZywJfxTWee+/tIx8IpIaZdWhqbp95BcRubz0r/FjSvZaneuj6u0KAo2/5S6an0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDcA9lva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F43FC4CEDD;
	Tue, 18 Mar 2025 09:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742291730;
	bh=sdmcaPvM69T/whUOvHnyyjA6izY79DJE+3kXbUnk0l8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KDcA9lvaq5evAqF+zAvbafzh118xe1K5xGUc4cLWYaez7yWFKDdvSAe3D2sgpSInP
	 JAVhy5/+BJe+0SA7RrpSMlxq7PSxHpK5I0IwIDPDkWeUaxvK+b9p5Km+kAw7wrWirT
	 nB17glDRcn6e3aVY6vJDcN2G2khqmUVptPzoDPl0owZIKUHafFm8vwyYkeSX5fuHfj
	 rxvUleuaXklLX+EfQQBv1dpoc4AcUIrRSVRihcJqdw7FbPu+N4VDVywVUqh1PSnjPS
	 +w40Sty9/FMr6ym8nNgxNgTSs5HJtyYSfZ20Pg7g/QAwJAzFmjmBuHNmRiV7Qss4kb
	 gjBc9jsmimZzQ==
Date: Tue, 18 Mar 2025 11:55:25 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	tangchengchang@huawei.com, jonathan.cameron@huawei.com
Subject: Re: [PATCH for-next 0/4] RDMA/hns: Introduce delay-destruction
 mechanism
Message-ID: <20250318095525.GZ1322339@unreal>
References: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
 <6e8c05f4-c925-8466-9453-214555e8772d@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e8c05f4-c925-8466-9453-214555e8772d@hisilicon.com>

On Tue, Mar 18, 2025 at 11:23:57AM +0800, Junxian Huang wrote:
> Hi Leon and Jason. After discussions and analysis with our FW team,
> we've agreed that FW can stop HW to prevent HW UAF in most FW reset
> cases.
> 
> But there's still one case where FW cannot intervene when FW reset
> is triggered by watchdog due to FW crash, because it is completely
> passive for FW. So we still need these patches to prevent this
> unlikely but still possible HW UAF case. Is this series okay to be
> applied?

I'm sorry, but no.

Thanks

