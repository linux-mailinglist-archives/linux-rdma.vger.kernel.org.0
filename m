Return-Path: <linux-rdma+bounces-15577-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C674D240CD
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 12:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A2283022A80
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 11:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BB1352C48;
	Thu, 15 Jan 2026 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n62Hp9GB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A567E61FCE;
	Thu, 15 Jan 2026 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475051; cv=none; b=uxyXriK4VUAVU9zQ/3u2iwHPMjOj/ymSkVuOYOdQ3hifGl6WI0M7SSXYo61WNlGiWmqLbXM/VejZr1+VPI6XpZZ3ImjEf4Z0UWVRaUWC1Rkrc0j/yIMM3VfOKeq6SjgcrO1BI+KZ7zrvJ1TUeQeVNEuoxl/zqpgVS04h8rEhNzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475051; c=relaxed/simple;
	bh=28FbBeBKHE6TAG2VVehhLKSn20yUTJUatU9Ug5UhQBY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Fi3jkdeR8wsTGD5EbU+QNM9k+CSUlhRrMKjdAmOCNulP3hpko6XP6qL/odUjay73yOvFz4Pq68G/ZoiJQO6OO4w606TBu7OVar4GuOwR3k64TtcWjCNASxBLk9eoGQbDsKO9JagvvlG+R7KpotkZgjKEMkqh0yG2BnMQAHVz03g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n62Hp9GB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC837C116D0;
	Thu, 15 Jan 2026 11:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768475051;
	bh=28FbBeBKHE6TAG2VVehhLKSn20yUTJUatU9Ug5UhQBY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=n62Hp9GBn4GXjyiyuSg2zBbQl46po0wA8AbSOaIIENluP49k4aJ285J3TGN5D2CNF
	 1Y3okg8qyRmMZuF/FoOZnkvEofOuAlJABMxmuZV6MRqY1bR/ePiyf6zqUw/ztG7JbQ
	 6Y5+KY/PpPMKTzhSENlcqnujwBrR82eSCcpWSe33IRdU6abALvGhrAPef5ZavGxNj+
	 8r7NQr8Pq/X0867d9msBV5X5FwvwOv3QdPyd7qXFTG5Qtpg0vihEbeIfloUHmjw7sd
	 l1o54M+S/sL+6JBqIgvbeXDOPGcCMTWZGjtOlaY8pkEG7jSNRrhMbQNTdgjEJXW+50
	 q8U8FlFBYNGQw==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, shirazsaleem@microsoft.com, 
 longli@microsoft.com, jgg@ziepe.ca, 
 Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260115093625.177306-1-kotaranov@linux.microsoft.com>
References: <20260115093625.177306-1-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next v2 1/1] RDMA/mana_ib: take CQ type from the
 device type
Message-Id: <176847504831.480236.802246486944727651.b4-ty@kernel.org>
Date: Thu, 15 Jan 2026 06:04:08 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Thu, 15 Jan 2026 01:36:25 -0800, Konstantin Taranov wrote:
> Get CQ type from the used gdma device. The MANA_IB_CREATE_RNIC_CQ
> flag is ignored. It was used in older kernel versions where
> the mana_ib was shared between ethernet and rnic.
> 
> 

Applied, thanks!

[1/1] RDMA/mana_ib: take CQ type from the device type
      https://git.kernel.org/rdma/rdma/c/f972bde7326e9c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


