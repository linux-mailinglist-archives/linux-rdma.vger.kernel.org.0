Return-Path: <linux-rdma+bounces-4863-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2061C9738E7
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 15:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69871F26A84
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 13:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C20192B71;
	Tue, 10 Sep 2024 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRtn155N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC9C14F12C;
	Tue, 10 Sep 2024 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725975786; cv=none; b=gOiVoPkAj9t8HlKUc8AjG1AzpCYSiG33JzmjwNfSY2pq55mrukgjKUgLdecNe7U7EfKhyvjsBE0XCxKHmDF3fYG1zPZ83T6ZozSI/znbAwuSFj3JotNAT1OzbGDoRYQmWguUShTbi83JPC+K6sWnG6rlNuy/OhNCepCPexfMBBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725975786; c=relaxed/simple;
	bh=sLvKYp0maJKtycfHxVbOh34MyuEQjAQdvCfWx79t04k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C7NFQuLzIG8brtU47WH6IlQeL02xd5VCvNjDZQg67aM54ffeMmGS6CWtLkRVdOHVtUeVvPyK0FyVp9kA8uN8ag1Epvuy2Z8copFzgs7Lxs6sUYqjpn2WL7jIpY59Xy5AahUrJVfNGqIvWoJre/KpRPsMlmltdmEiqyNRP7FMSbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRtn155N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87348C4CECD;
	Tue, 10 Sep 2024 13:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725975786;
	bh=sLvKYp0maJKtycfHxVbOh34MyuEQjAQdvCfWx79t04k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mRtn155NAfZ7mqCDt1pU4gY1SZKPNqZ/9q/cOOQ4TvkJzWw5uximVVxJgzHx0SQmS
	 3sIk4syu50P+HE5YSqkd0tRBAy2Ux8DawUTeOiV++sk5PQU+AK2/9DGfI4YiUBShyP
	 yzmqXdZqKXd0UWW9lh+4zi7lY5k9lyanEhPHR/xwo1/3AtdqHeuwZFWESjXbhrzg0k
	 OhfoVFlo/AFfIIDFOjt0qfUqdHxKfjCojtrzPK8c4JkVMpLxbnlIQiR4PYR2+djFpi
	 BpTcVNN/TEaLxUO3ejjB2nJPJs6uYF4TZBeItWmPMu8nbTRnU0ylemBCMY6kEleLRd
	 x3PmnFdmqWb0g==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240909065331.3950268-1-huangjunxian6@hisilicon.com>
References: <20240909065331.3950268-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-next] RDMA/hns: Fix restricted __le16 degrades to
 integer issue
Message-Id: <172597578216.3395353.13932740353713510907.b4-ty@kernel.org>
Date: Tue, 10 Sep 2024 16:43:02 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 09 Sep 2024 14:53:31 +0800, Junxian Huang wrote:
> Fix sparse warnings: restricted __le16 degrades to integer.
> 
> 

Applied, thanks!

[1/1] RDMA/hns: Fix restricted __le16 degrades to integer issue
      https://git.kernel.org/rdma/rdma/c/f4ccc0a2a0c597

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


