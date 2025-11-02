Return-Path: <linux-rdma+bounces-14177-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAE1C28E84
	for <lists+linux-rdma@lfdr.de>; Sun, 02 Nov 2025 12:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A1F188B784
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Nov 2025 11:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5104822AE5D;
	Sun,  2 Nov 2025 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJNqSgPC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C6434D3A6
	for <linux-rdma@vger.kernel.org>; Sun,  2 Nov 2025 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762084425; cv=none; b=fvz5oz0LvEFnA4uBXXJTRQuiLAt5GD/VuUYeCZ2XkfVgbYvzuyePdAp6mR9ZyfEqQuAOk9epWOm/6We2hvFalT+LvoZtjxJ3mabWPUJo0dVkrvWJxH1mqIgcEwQJBJoMEol22V80Gi+9fEhn1grtkw6RiYx7iCq+8zZQfvS19mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762084425; c=relaxed/simple;
	bh=KGwroTnU+oZsDcR1W7I1sCttaejfan0jAbxSEFrcgAA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uFX0yKJS56Xhzh7KBuO8sqb+FCfenvpSa5sgz4xHcEUxM0FciTJYUbUDnk0ZeNpoZaYUerYjxVjHcPPBWhR0jvZoaP+bzvZv5YcCfGPKo19VdRPo1zALucRg773AhqJ4E+sPdb9yb7e8zK9INvhhm7VqpuQMRDL8zhZ8okhYraw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJNqSgPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAA4C4CEF7;
	Sun,  2 Nov 2025 11:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762084424;
	bh=KGwroTnU+oZsDcR1W7I1sCttaejfan0jAbxSEFrcgAA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tJNqSgPCnTyHMQ8jifcI3rPz7iJAr5eBGgI2dMSM3AV9tODXD6KYNH7YcPBeb4T3b
	 bOpftYU4bN5ZoslPdo1RQdjQZQM2u8VzIcRxp6ydmuRv6nZCXwFCwM26LZ9MHFo38y
	 W4VZPt5nH1dggdin9BcWPk+MAO9+uXaS9Mjje1lQHXZIhjsajaaAC1vrwaGmZvUmRo
	 CV8oCMBcacCtV7vh/muxFcloBWlTXaV006mxyZxAQhNPvgvdjOEeYL/uemAjD3u+5k
	 3CawohWO6qDkmfXt7Ni9m8A/5lYmM+hlPXGt7NmWlQnxchVTCG1u8XYOqSif2pybEt
	 pL3X4zw9krVmQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: linux-rdma@vger.kernel.org, krzysztof.czurylo@intel.com, 
 Jay Bhat <jay.bhat@intel.com>
In-Reply-To: <20251031021726.1003-4-tatyana.e.nikolova@intel.com>
References: <20251031021726.1003-4-tatyana.e.nikolova@intel.com>
Subject: Re: [PATCH] RDMA/irdma: CQ size and shadow update changes for GEN3
Message-Id: <176208442203.10923.9688420792318531171.b4-ty@kernel.org>
Date: Sun, 02 Nov 2025 06:53:42 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-3ae27


On Thu, 30 Oct 2025 21:17:23 -0500, Tatyana Nikolova wrote:
> CQ shadow area should not be updated at the end of a page (once every
> 64th CQ entry), except when CQ has no more CQEs. SW must also increase
> the requested CQ size by 1 and make sure the CQ is not exactly one page
> in size. This is to address a quirk in the hardware.
> 
> 

Applied, thanks!

[1/1] RDMA/irdma: CQ size and shadow update changes for GEN3
      https://git.kernel.org/rdma/rdma/c/0a192745551cd2

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


