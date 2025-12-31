Return-Path: <linux-rdma+bounces-15250-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80475CEBCD9
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Dec 2025 11:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 632AD302C233
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Dec 2025 10:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE68313E2A;
	Wed, 31 Dec 2025 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pznOJnFF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE59A26F46E
	for <linux-rdma@vger.kernel.org>; Wed, 31 Dec 2025 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767177652; cv=none; b=WkXUK/nyT1Saog3ehUaT6lYcjDEyS68TIKI5POz2Wr4wGqNHikzMlJ/21Q3RwXALg42eDS+Ku99PyCMiFbS+qFeA+IQrjcE7SZ+a1OZGHiiJ5sQlu3ltR4zsefsv2ioH89y0T8AG2lf//9OP/Z/YFjT2A3Js3UaGrYxMob1cGKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767177652; c=relaxed/simple;
	bh=+Mp4GOxgsncSh37r5a7xd4OdYW1SuaEgbLoiYehr/oQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ckWUdwwgcGNrt73WIiMYXzeyUl2zE8rwLXcTjZ7HufjbMnPZC/Ks7xDY8hQL3XOCJNKkMlFw9nO+OH78U+GN9LKacmK8deOnEbcBvDU/pU7j7cWyoi0JhfTQwolipBiuK4QEjDC1B8PB9XW2abQAZrreS9JNFMKJp5HM56zr6ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pznOJnFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E260BC113D0;
	Wed, 31 Dec 2025 10:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767177652;
	bh=+Mp4GOxgsncSh37r5a7xd4OdYW1SuaEgbLoiYehr/oQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pznOJnFFOzHRzrMzbaDFTiwRFfkMkSczYpIekhqSXOt5e59Kj02OwG500lgfddSac
	 +5IfbtuedBoa6BZYnX83Z2+qKvzBaE1Qm8Ps90ufL5ocBPRKyp1/ooDR08FygozSe9
	 RDeLDWNj697IO5Li8PO4TEcjCs6shpT4OLYc61YftaR440ChtRaNCOUak3wyhyKmLK
	 6EL6gRt4a70VbG8sxx1Pcdu20QJRqWHJJGgMCYO8ff9tcGi5BLXFYYS3UHAuKE1qDu
	 ys1des+LI0OJOe1uqDwEcSTheiG3xqQrzZIfxhrFwscKtYP8m4PaSqID6w91No7Z/s
	 uPsKg1e8OTXsg==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 tangchengchang@huawei.com
In-Reply-To: <20251230154911.3397584-1-huangjunxian6@hisilicon.com>
References: <20251230154911.3397584-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH v2 for-next] RDMA/hns: Introduce limit_bank mode with
 better performance
Message-Id: <176717764929.834343.15178274563049899290.b4-ty@kernel.org>
Date: Wed, 31 Dec 2025 05:40:49 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Tue, 30 Dec 2025 23:49:11 +0800, Junxian Huang wrote:
> In limit_bank mode, QPs/CQs are restricted to using half of the banks.
> HW concentrates resources on these banks, thereby improving performance
> compared to the default mode.
> 
> Switch between limit_bank mode and default mode by setting the cap
> flag in FW. Since the number of QPs and CQs will be halved, this mode
> is suitable for scenarios where fewer QPs and CQs are required.
> 
> [...]

Applied, thanks!

[1/1] RDMA/hns: Introduce limit_bank mode with better performance
      https://git.kernel.org/rdma/rdma/c/8818ffb04bfa16

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


