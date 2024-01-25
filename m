Return-Path: <linux-rdma+bounces-737-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9CF83BDE4
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 10:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20081C20BC5
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 09:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE031CAB9;
	Thu, 25 Jan 2024 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbDurS79"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AC61BF28;
	Thu, 25 Jan 2024 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176235; cv=none; b=eoufa21bDvaR7FpPKqLQ2JGp0lQgaic+HczeouyFO4uPTlRO3zPv5chlHj/6EIolpVDpeG63jPtP6dKae/p32KR0gnCuZRn9/Bnt4rd54/IlyAFllRpy+O6Xq+vNTXs4FWM446Lv37hwAzDyba90rhlTS10M3TiEIb04s0wITtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176235; c=relaxed/simple;
	bh=0cKFzwkYuju6lVduu1LAS4cytxV8NyvAZXTwwH7hCAU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RcjIQdCCVkxfhXiNWtSwJRCEtHYmT92lD4/pDI9GiK/xLiP79bqQwb7M85SLHCgZQU1maMpY6kqsUuLhVaxk9tFcdmAqD0wwF35T0zg8S4fxiEshkEZxLin8lqVkf7Db7eL/aTBYfjLDHCCitmaLOqvwxc8sgMi/tUtxD5BB0iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbDurS79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A1EC433B1;
	Thu, 25 Jan 2024 09:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706176235;
	bh=0cKFzwkYuju6lVduu1LAS4cytxV8NyvAZXTwwH7hCAU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GbDurS79ZGS9TIE+GdlyDt/zx5tBZdZR++xDdq3C4pz4PEvkrrR1z8X4JTpAHybrr
	 3Ol528AE/TjqHIMd2XJ6t/eBEnZymLkzN7Cr8iaY3LqdgwoEdF6NGEvMBLYtgEm/rS
	 x6ojhpi9+qAwyUNDErSEMIaAMbO3ANRGUrbu3n844eA9wdQXKBqGBnL/89/FXY0YyQ
	 URzAIWefN3ByxNU3tvq2Q6hTmJtIpjCgLBFmzKecXrOcGExtAJ1cLfeMG02LPEfu+L
	 4y4dtWYGBlgmObjv9lvUTd6rPr9gzoVdFC2+qagIwnzDwVmUUShStWaMiBHtYWhRDW
	 HiWD62gkBr+HA==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
 rpearsonhpe@gmail.com, Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
In-Reply-To: <20240109083253.3629967-1-lizhijian@fujitsu.com>
References: <20240109083253.3629967-1-lizhijian@fujitsu.com>
Subject:
 Re: [PATCH for-next v4 1/2] RDMA/rxe: Improve newline in printing messages
Message-Id: <170617623076.630799.12906262670480610174.b4-ty@kernel.org>
Date: Thu, 25 Jan 2024 11:50:30 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Tue, 09 Jan 2024 16:32:52 +0800, Li Zhijian wrote:
> Previously rxe_{dbg,info,err}() macros are appended built-in newline,
> but some users will add redundant newline sometimes. So remove the
> built-in newline for these macros.
> 
> In terms of rxe_{dbg,info,err}_xxx() macros, because they don't have
> built-in newline, append newline when using them.
> 
> [...]

Applied, thanks!

[1/2] RDMA/rxe: Improve newline in printing messages
      https://git.kernel.org/rdma/rdma/c/6482718086bf69
[2/2] RDMA/rxe: Remove rxe_info from rxe_set_mtu
      https://git.kernel.org/rdma/rdma/c/190a7affeece58

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

