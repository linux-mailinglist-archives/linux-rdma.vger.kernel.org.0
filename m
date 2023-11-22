Return-Path: <linux-rdma+bounces-34-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D258A7F450B
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Nov 2023 12:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB79281511
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Nov 2023 11:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE1855773;
	Wed, 22 Nov 2023 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHZqE5gw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850B54AF98
	for <linux-rdma@vger.kernel.org>; Wed, 22 Nov 2023 11:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88827C433C8;
	Wed, 22 Nov 2023 11:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700653465;
	bh=yPzOG85LLcUX077LYN9w36VPYZdE+gJtlRsNH+G35rE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lHZqE5gwXqXJ4LH8QKyKcc6+AbmtXK0bPtwWLq56hX0S6FyNf/xJfllG514EbBAbt
	 w0ptPH/oCPJBQmXQFXv/ZYymMnf319o55/XXCjcinzehLd1/LwzDN4h9YlzWHIOznG
	 RKv+sau6/tsrLOYtqrlZALKhLW3MvTXKeEr7RfKRmHS8IxfeU2vpMzaDGV6Bn2xLuI
	 P9lxkrcAJ7CPtrRTdSkQIkBTP5T/p3nlREJV7fOPiEmwAN2otOr4Q3tdapNPKn9bJI
	 isedXwi9MViuW9dmE5UPsAGR7hJzUrEGZ9PZitRHWwzFd3kMdyzIyR+V+qoY1z086O
	 AZ/WGQbzk/gWg==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Md Haris Iqbal <haris.iqbal@ionos.com>
Cc: bvanassche@acm.org, jgg@ziepe.ca, jinpu.wang@ionos.com
In-Reply-To: <20231120154146.920486-1-haris.iqbal@ionos.com>
References: <20231120154146.920486-1-haris.iqbal@ionos.com>
Subject: Re: [PATCH v2 for-next 0/9] Misc patches for RTRS
Message-Id: <170065346066.28148.2038477589985381532.b4-ty@kernel.org>
Date: Wed, 22 Nov 2023 13:44:20 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Mon, 20 Nov 2023 16:41:37 +0100, Md Haris Iqbal wrote:
> Please consider to include following changes to the next merge window.
> 
> Changes in V2 for all patches:
> 	Add Fixes: tag
> 
> Jack Wang (4):
>   RDMA/rtrs-srv: Do not unconditionally enable irq
>   RDMA/rtrs-clt: Start hb after path_up
>   RDMA/rtrs-clt: Fix the max_send_wr setting
>   RDMA/rtrs-clt: Remove the warnings for req in_use check
> 
> [...]

Applied, thanks!

[1/9] RDMA/rtrs-srv: Do not unconditionally enable irq
      https://git.kernel.org/rdma/rdma/c/3ee7ecd712048a
[2/9] RDMA/rtrs-clt: Start hb after path_up
      https://git.kernel.org/rdma/rdma/c/3e44a61b5db873
[3/9] RDMA/rtrs-srv: Check return values while processing info request
      https://git.kernel.org/rdma/rdma/c/ed1e52aefa16f1
[4/9] RDMA/rtrs-srv: Free srv_mr iu only when always_invalidate is true
      https://git.kernel.org/rdma/rdma/c/3a71cd6ca0ce33
[5/9] RDMA/rtrs-srv: Destroy path files after making sure no IOs in-flight
      https://git.kernel.org/rdma/rdma/c/c4d32e77fc1006
[6/9] RDMA/rtrs-clt: Fix the max_send_wr setting
      https://git.kernel.org/rdma/rdma/c/6d09f6f7d7584e
[7/9] RDMA/rtrs-clt: Remove the warnings for req in_use check
      https://git.kernel.org/rdma/rdma/c/0c8bb6eb70ca41
[8/9] RDMA/rtrs-clt: use %pe to print errors
      (no commit info)
[9/9] RDMA/rtrs: use %pe to print errors
      (no commit info)

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

