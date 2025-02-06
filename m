Return-Path: <linux-rdma+bounces-7480-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8BAA2A398
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2025 09:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278F7188997A
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2025 08:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE7E226541;
	Thu,  6 Feb 2025 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RneaqjdJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB931226539;
	Thu,  6 Feb 2025 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831890; cv=none; b=PCP/aPG10ZLbROUuaBZop+obR/9Q+hvbx+2JoMkz5B7/AzlopUJt3HuU6u3DVdl092thNWl7wXVnk4qInMQnHh9uF2Pn7UaLruwu1a0UaT4QnWwWDQ5wFx7MzE0yCid1g/56N1qCfR8KO8m8NPdTmfawX9vrWl/paPfBA/eRRQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831890; c=relaxed/simple;
	bh=iVHm9zQUOoRVdsuD789C7y5A49BuMQoE++HPOOn1fA0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J8RLfwI9ABn6b5qRpPUAje78BJ9ArMAbnBBvL02ICQmpc3lDr8Eoju+THO3jy+Qgq89+vnPYKa4gJYfX9Uv+O8jeL0Uax0i7PsE7wxH8V0sy8YaQakjSvL85Gs36FPl869MZVivV1Aj82P4rkAxMP/3tCWsTvj4b0ysngKpr4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RneaqjdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990F7C4CEDD;
	Thu,  6 Feb 2025 08:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738831890;
	bh=iVHm9zQUOoRVdsuD789C7y5A49BuMQoE++HPOOn1fA0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RneaqjdJAmQ+9y2y+tm3RlMMTw8i3BgApUux8jPY4iXTX+KqHFvOTCpV+fZ0u5wMA
	 r+hBgKa7Mn9UX8OcmusC5zn3TucAeR6GuOjgqMlM9jiCQD+oTqC3IT1Fk3wi/Z9uAp
	 7GXo6386fXFxNhu2j50XaDL7LiJ4OkR2dq9N7/4RIyuTr9qoQNKI7HZrJ5TWnQox0T
	 fGjZpa7RBZcKbHcr/xQeo3kSmABlAy0gXwCBG+tnHJOJdZt7gGCoV8yI4Haioj0R4D
	 S3e5uZhaeHbQTt/7ZSum6+l/DH4YklQa6uwaTqWQa0ybmLmMbCI5yeC2FcFez/BCc9
	 NPyqkp8dwmNHg==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, shirazsaleem@microsoft.com, 
 sharmaajay@microsoft.com, longli@microsoft.com, jgg@ziepe.ca, 
 Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1738751713-16169-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1738751713-16169-1-git-send-email-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next 0/2] RDMA/mana_ib: enable error cqes
Message-Id: <173883188698.837830.8549990389574218852.b4-ty@kernel.org>
Date: Thu, 06 Feb 2025 03:51:26 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 05 Feb 2025 02:35:11 -0800, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> This patchset enables the mana_ib driver to query capabilities and
> enable creation of error cqes.
> 
> Konstantin Taranov (1):
>   RDMA/mana_ib: request error CQEs when supported
> 
> [...]

Applied, thanks!

[1/2] RDMA/mana_ib: Query feature_flags bitmask from FW
      https://git.kernel.org/rdma/rdma/c/bad4480934c822
[2/2] RDMA/mana_ib: request error CQEs when supported
      https://git.kernel.org/rdma/rdma/c/cd3c5ddf823016

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


