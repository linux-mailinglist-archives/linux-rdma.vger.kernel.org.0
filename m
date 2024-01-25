Return-Path: <linux-rdma+bounces-736-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FB983BDDE
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 10:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC0828410B
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 09:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6DC1BF2F;
	Thu, 25 Jan 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzIg7GSw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD941BF28;
	Thu, 25 Jan 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176230; cv=none; b=UpZU7Mc5U2dmxBuzvTepz9xgO2UQXwl86d+RC3QOA4EPwrAHeoFubXglK3O541UQlplHYvOP6lw1yM3sHN1PWALMqi9Q7GgVSWxwqo3K2CsFaF+uZ4WDcaurOjh9l12JN+reIvh5Dx5gLQN0FZUA/GcfLZ4l5gzZP6bH7XmPZ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176230; c=relaxed/simple;
	bh=0UQgTPa/bjW1ojgiMUyzsxNCafDWf9OuJBQL+cEL7UU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HFU9c8X4XfXdKV8SXtrZmivrJhhaQrg8SA9HI43OT5v1nHoJc8vuqjMkaC+XIEr6IHR0SnX6EK2qzDyvVNVu43+nPNjq8K/V8maUZRKdf5KAUawywbfQwGUwR6dGF+/HB4SaqMv2W+PQxRxUHBMFor89LhSJfav3pl46djBgQYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzIg7GSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EC6C433C7;
	Thu, 25 Jan 2024 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706176230;
	bh=0UQgTPa/bjW1ojgiMUyzsxNCafDWf9OuJBQL+cEL7UU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rzIg7GSwna4yM0ItUkDTekX80Ln0z+MuYD+C70FyWFZpn+0QvwVuAHLXykCs+WkCW
	 fvsDplRnnq4nLs4DytgKmurzOXDowMsBqGOjKEr/n/nF4LTUREaCjIeDCaJ787O9tc
	 AyINR7ElXIY6vjWdeDN0qA4cuVDpcZldL3cEH81qXmdBrZmbWhk7yHKVzLYtInOARb
	 rS2WDnMr8+HMcxbXhCpDO8w5YwBH58OtTiHVGteCGzObmop0qWPe5AU6ZRDQWopM/X
	 BB+UrAglFmUtKg33KfF9O8KCJWm+2jdsFXQ+uzOoInlnBEmGwUUBS85pNpr7p2lP17
	 IB5d3SoxcuJOg==
From: Leon Romanovsky <leon@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>
In-Reply-To: <20240111042754.17530-1-rdunlap@infradead.org>
References: <20240111042754.17530-1-rdunlap@infradead.org>
Subject: Re: [PATCH] IB/hfi1: fix spellos and kernel-doc
Message-Id: <170617622554.630799.5283223816578815327.b4-ty@kernel.org>
Date: Thu, 25 Jan 2024 11:50:25 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Wed, 10 Jan 2024 20:27:54 -0800, Randy Dunlap wrote:
> Fix spelling mistakes as reported by codespell.
> Fix kernel-doc warnings.
> 
> 

Applied, thanks!

[1/1] IB/hfi1: fix spellos and kernel-doc
      https://git.kernel.org/rdma/rdma/c/4c09f7405e461f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

