Return-Path: <linux-rdma+bounces-3819-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5771092E452
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 12:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86E27B21DF9
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 10:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102251581E1;
	Thu, 11 Jul 2024 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyW38H17"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D0D14F9E5
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2024 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693112; cv=none; b=iOodfxySe2XW//rOXsytWT1QCmf9xnznExTqXZ1ttLJq1J3Em2KQbdb3p8rmPhW8DtzWdcoK1mOs2R1sJlT5tnx2gmsI29hn486H3Mg3ecfPCNHBC7ga3eGt10quslmL4KYV2WgxbMxkGkMhJj8FGf2ViCXY7O1y19T7qbB3pyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693112; c=relaxed/simple;
	bh=9t7So2yTIvGyIuM4HXTyuoXp4O6rEiC2WbkWy7gllmQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I3u8NYu26YzogaWyKVlI/9vJzLyMeymxgGDEhVxcaC3YxSXHNAV0YIANM/XhzUty72WlCqJA6CISs7I6zRqXBW30kI2iqp98n9HVsPv26adT7mvp3XE39WSgr7ayEYTDFdQiO2/s/IU3JuTBhy2YiG+rexm+CNCcpQyX9eQOsW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyW38H17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E06C116B1;
	Thu, 11 Jul 2024 10:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720693111;
	bh=9t7So2yTIvGyIuM4HXTyuoXp4O6rEiC2WbkWy7gllmQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tyW38H17ArHMsDsoUs7ksEdSer50cMCSswfXtBS0IUPyv3VWiRC9xEwOxlh1kZTc2
	 pbV3Rf4/J7ADRN5sWroGp5wu6e4RjIh6qaRcwSV7jsYXvR2PZm9FiviJGrrc98SB16
	 YzMY2hRGauYErXucC/IZxZsawpOuWFTO3nU/SrOXJrLjnrTbwaLhrD1fBMt3sg5G/w
	 /LOO8EFs45OqEhyZEW51jPvyqFOHoPQOq6NKCcSQr66PogRZD1RG1m0fyKlUWFAd5O
	 ClVSbSPhDRmpjjY3POFMvN/URaRxLSvUl/BZInGfGi0aPrdLJDN+1SAE2LEvE/vjTK
	 YJqHvnmBjRuGA==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, David Ahern <dsahern@kernel.org>
Cc: jgg@ziepe.ca
In-Reply-To: <20240710203310.19317-1-dsahern@kernel.org>
References: <20240710203310.19317-1-dsahern@kernel.org>
Subject: Re: [PATCH v2] RDMA: Fix netdev tracker in ib_device_set_netdev
Message-Id: <172069310482.1717335.10447865297194611439.b4-ty@kernel.org>
Date: Thu, 11 Jul 2024 13:18:24 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-13183


On Wed, 10 Jul 2024 13:33:10 -0700, David Ahern wrote:
> If a netdev has already been assigned, ib_device_set_netdev needs to
> release the reference on the older netdev but it is mistakenly being
> called for the new netdev. Fix it and in the process use netdev_put
> to be symmetrical with the netdev_hold.
> 
> 

Applied, thanks!

[1/1] RDMA: Fix netdev tracker in ib_device_set_netdev
      https://git.kernel.org/rdma/rdma/c/bbff20fb3e6a00

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


