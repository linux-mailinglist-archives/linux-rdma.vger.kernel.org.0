Return-Path: <linux-rdma+bounces-8497-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D38A57CD1
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Mar 2025 19:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2CD188CBC4
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Mar 2025 18:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91DC1E521C;
	Sat,  8 Mar 2025 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtsZBsZ/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEA48BFF;
	Sat,  8 Mar 2025 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741458870; cv=none; b=LTRVn5NGX/pWXCgY9+5qisp1do/4+riccyckfVD2OjTww7iPZtQvD2feeILfYcOxQdeho4wjOjJlOjxLOqZKIvSdRsvYgoJLALSMxspZzvYzyVFouDHOZm3cV6PUaBW5CMIhAyud7YqXiSg+d2Wrm/Tqr7H2WmfdePwAOw9Ak+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741458870; c=relaxed/simple;
	bh=N+wnqnn7niKRWMTF/fWmJbhbbB5Fyb5/7cVhoNMuJDM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UYRSil3kX5yoNr7Iz2aRJftJ1+l9hW9jf5SU2bU7W93D1dWUBjpuYhL3rQo3f5s2aG7KU29M600nmktU4kMgKF4bbPZvDhKX8fpIQUduijudBPjT8ubL3VA+ZXLO/4TYZHvDXzAmUVCjn1H5Tkcp7JEh1ODZfPYFoMJCIu0LSyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtsZBsZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784EDC4CEE0;
	Sat,  8 Mar 2025 18:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741458869;
	bh=N+wnqnn7niKRWMTF/fWmJbhbbB5Fyb5/7cVhoNMuJDM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OtsZBsZ//obqWnNHVqKCp2XgN76oAoSAg7t+k4S1JWhj8vboPvF0sTkK9el1OeBKK
	 V0vkCFuIl4w+ip2HRgoSlL2cxGXlV7FVn65C6eepRWmuhULN9lbQV3xvJCl67nj3mz
	 dczSm3ZxRdJeqANPllX6+AtSEFLVs8BOFoSdzB78HvJXOvh6nnI1/Rkjaz0ZZ8cJtM
	 Q5kSm4rOPKd1IGXfH3G1EkkEqcL66Pi6kO5xkXs6Yqy7s7Rnrg8xrWp4yoh/MQ/pI0
	 2ndhJ0UEqbW5xiaCyxPOp/AjdWdgLSBYYnhz06CgZo4BGcrOhtdufu3MY0c3kdiTkp
	 Ar7jOft6gbFFA==
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@microsoft.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Long Li <longli@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Shiraz Saleem <shirazsaleem@microsoft.com>, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <58439ac0-1ee5-4f96-a595-7ab83b59139b@stanley.mountain>
References: <58439ac0-1ee5-4f96-a595-7ab83b59139b@stanley.mountain>
Subject: Re: [PATCH next] RDMA/mana_ib: Use safer allocation function()
Message-Id: <174145886664.308372.5469459244434611708.b4-ty@kernel.org>
Date: Sat, 08 Mar 2025 13:34:26 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 06 Mar 2025 22:49:06 +0300, Dan Carpenter wrote:
> My static checker says this multiplication can overflow.  I'm not an
> expert in this code but the call tree would be:
> 
> ib_uverbs_handler_UVERBS_METHOD_QP_CREATE() <- reads cap from the user
> -> ib_create_qp_user()
>    -> create_qp()
>       -> mana_ib_create_qp()
>          -> mana_ib_create_ud_qp()
>             -> create_shadow_queue()
> 
> [...]

Applied, thanks!

[1/1] RDMA/mana_ib: Use safer allocation function()
      https://git.kernel.org/rdma/rdma/c/1d5c69514e7428

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


