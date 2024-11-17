Return-Path: <linux-rdma+bounces-6016-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C95279D02AA
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Nov 2024 10:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74CD41F20419
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Nov 2024 09:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA777DA9C;
	Sun, 17 Nov 2024 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qpd+UhmY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16774DDA8;
	Sun, 17 Nov 2024 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731837149; cv=none; b=MXgLiMj0VJwt4GzQjaxtkDEH7FJ2uI3HynZgaUdIcr5jlt2C5RHBMVmHB/fvnDxOTBpcYv39yGNbFdal4FfrcmiMa/FU0obiJfRnyns2XVZTGCgbGtcf/m1Mw4qwCGupGHwdlflGK/w35tulwmANQoB+RVrYDXYdib1FUC2/iYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731837149; c=relaxed/simple;
	bh=XTLg0eWuydxY6lLMuzmi6jAlPTpd0Y1RIfkxybv4Gbk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qbzJ2TaESg9EcOc/fNd7PkQP53r+mWcpInhazujS8bHviKuMgp7mQiUk8t1isoapkX5lcBQ6OK8X1+28FUE+jiVsefaiUVNeibAkPWHzm3f2IpnM47GWSDh4Hha3g0oq2URVtId/yH50g4T7XBzBD6vAFuRmui3MoysbzBIbVz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qpd+UhmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760FBC4CECD;
	Sun, 17 Nov 2024 09:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731837148;
	bh=XTLg0eWuydxY6lLMuzmi6jAlPTpd0Y1RIfkxybv4Gbk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Qpd+UhmYjOgjIelWXTzVMHCy/l7Wr3BfUBKVOFRr6oLO4K/r+yq5GSITnXIPS1dSj
	 SsN0jSOZrFIlv6a7k5lJ60accB2MWrdVTqfaAYNjEm0xiYTLpLmaH6cTfJnNlhEgv5
	 3+vMnouWQ3KUWbx6Lavox4SlR27CsUkvJHT24mau8ddpudDVDJFMphbUNUtc9oJcIE
	 Q9cJvDjEkh0RF5hHRySvHAMvg/7IJXKGgWKeZWGtdStVMyc0LH8Q8QUMgNdKQVGpwB
	 K6yxfvEkw0vBFam0CATCJnu21v2DySlOMCE/afvP2HX/rN+5Ow4ybM0ZI1q175nmzp
	 981YKxXOg9hTg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Or Har-Toov <ohartoov@nvidia.com>, Sean Hefty <shefty@nvidia.com>, 
 Vlad Dumitrescu <vdumitrescu@nvidia.com>
In-Reply-To: <cover.1731495873.git.leon@kernel.org>
References: <cover.1731495873.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next 0/3] Batch of IBCM improvements
Message-Id: <173183714552.223531.10917862917495682531.b4-ty@kernel.org>
Date: Sun, 17 Nov 2024 04:52:25 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 13 Nov 2024 13:12:53 +0200, Leon Romanovsky wrote:
> This patchset from Sean fixes old standing issues with IB/cm.
> 
> Thanks
> 
> Sean Hefty (3):
>   IB/cm: Explicitly mark if a response MAD is a retransmission
>   IB/cm: Do not hold reference on cm_id unless needed
>   IB/cm: Rework sending DREQ when destroying a cm_id
> 
> [...]

Applied, thanks!

[1/3] IB/cm: Explicitly mark if a response MAD is a retransmission
      https://git.kernel.org/rdma/rdma/c/0492458750c9fb
[2/3] IB/cm: Do not hold reference on cm_id unless needed
      https://git.kernel.org/rdma/rdma/c/1e5159219076dd
[3/3] IB/cm: Rework sending DREQ when destroying a cm_id
      https://git.kernel.org/rdma/rdma/c/fc0856c3a32576

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


