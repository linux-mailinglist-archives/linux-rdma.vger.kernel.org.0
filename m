Return-Path: <linux-rdma+bounces-13182-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D79A6B4A4FC
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 10:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D361B4E2FDB
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 08:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1307C246BA9;
	Tue,  9 Sep 2025 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgUK35j6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27EC181CFA;
	Tue,  9 Sep 2025 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405949; cv=none; b=n/oTXHM2qO2KGatvMolJA5fUSJeXUDtwzUc+HPMZFjZO1wKn3fmb9H++e8syWbCJUN2jSSQZ9sRcUQUsNof3Wt1YEdHSa/PcSDw6TLnZZKUDCRon4gRx2R49SWkqkKVZgmlBq7Wt0vU5/Cdz2xAAqwiPiJ4fyHnV1LZFrN4bNLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405949; c=relaxed/simple;
	bh=MWMb3JDCgr53rJ4YRfT6QcfgMhS0Ernt4XGPRIWZVYQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lCxXYEc7oFiT6TfzR153a5MCvOTeCZ9C3j83g+dx5R4Y9uKqcSbPEpMYKHJHP0bE4xVSr/xQfjxRlMbH/eERBy7ciu7iyVd4BAGfL7fmm8TDzdQPggjQHQWcLmHDad/w+CXexLo27ZI+hwIo9Tts4mVpn2nPMHPcAUZafuIz5wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgUK35j6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9647DC4CEFA;
	Tue,  9 Sep 2025 08:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757405949;
	bh=MWMb3JDCgr53rJ4YRfT6QcfgMhS0Ernt4XGPRIWZVYQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NgUK35j6GvvgetxNdYkGon9/NteJq1+nV9dtsySWfiCnG5Q9KAulOCocEmXH8AjOS
	 zPTjyhmUsUMv/GawuUmPN35GNR4J1UnzhXY/HI5X2OxjKMgl38V4bnCllgISXLUd9a
	 pS46v8+M8Jqw1r2NIYtz9nyPR7Gs/9TkYRKQ5wjKUH28LFkhiY6kExKBrkO6Mpyiz9
	 4PhZBhqUlglH9lFkQ4IXMaUvD27caQjat2ceF/eq7THPBAJg/APWDYUhscsmAKQQQy
	 mHgD0M1PFv+Y1JnxHvCawXNYISZwcBWUC2Z0o/+1MakRdnqb7tQAd+M4I+1WS7WlmJ
	 jjepBx9ZDH7rw==
From: Leon Romanovsky <leon@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>, 
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, 
 Yael Chemla <ychemla@nvidia.com>
In-Reply-To: <1756884600-520195-1-git-send-email-tariqt@nvidia.com>
References: <1756884600-520195-1-git-send-email-tariqt@nvidia.com>
Subject: Re: [PATCH mlx5-next] net/mlx5: Add RS FEC histogram
 infrastructure
Message-Id: <175740594613.474749.6222291255125007761.b4-ty@kernel.org>
Date: Tue, 09 Sep 2025 04:19:06 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 03 Sep 2025 10:30:00 +0300, Tariq Toukan wrote:
> Define the Ports Phy Histogram Configuration Register (PPHCR) to expose
> RS-FEC histogram bin ranges, and expose a new counter group in the Ports
> Performance Counters Register (PPCNT) to report the corresponding
> histogram values.
> 
> 

Applied, thanks!

[1/1] net/mlx5: Add RS FEC histogram infrastructure
      https://git.kernel.org/rdma/rdma/c/ff97bc38be343e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


