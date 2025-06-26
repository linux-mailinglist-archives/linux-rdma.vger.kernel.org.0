Return-Path: <linux-rdma+bounces-11679-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AD7AE9D49
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 14:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536E918977F9
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 12:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA2B218EB7;
	Thu, 26 Jun 2025 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcfrZAhW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EF520FABC;
	Thu, 26 Jun 2025 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750940067; cv=none; b=UlQYePpCtagB3LvEeVxX6rFkvPgTJljClcTi2aJzoESf9RoRWGu7PXv/+uivnqE+3Gg+EijB66ie5/nvIffUtFp4hyj1epu2Lp7X6CEOUr5JgNiStrdD6XWuklXJU9/EGlqTzOprDLxj43AyX85428Q3PPAAQSsOuQBj8vXt8tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750940067; c=relaxed/simple;
	bh=cYyYCDjMKo1YFR4zdTqShC1KN41JtZ+W5+ZKJ2+q91M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JYi/PtyaeZzoLalwkmPt/9Y4kkPwaD/e+3B/ZBUx3iRxf7s3uVNTFABDVXmjo/8vSDKp8LjDgJ5KkEhqOHTytmSVobwzPGt6skWA7415EL0S7SlaYwcmZgCxLExSGhoQjWP/Nl3WcRsKtLJ7UranPztcVKhikIHoHJ9oWqQ5E/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcfrZAhW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F2EC4CEEB;
	Thu, 26 Jun 2025 12:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750940066;
	bh=cYyYCDjMKo1YFR4zdTqShC1KN41JtZ+W5+ZKJ2+q91M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RcfrZAhW4RNTimmfr+W3NqCrIUMFTAZBNJoivl4cZs3hiQqCt6+Hi7PNbPpX+ypvL
	 oedNJxKj9Ltc1MMBQWVLUe74FsUNDre6hwFmSejQ1eirw1v1l+vQb9hknDmfuJi+Lq
	 yf352DZk+9IyarvY6N2gcxxpxJ0pbtarV0A4c/ETJaU3bzzMrBczddEaJVTiv63gNG
	 DDUWO2LjfaphBr/0q7DImM1DvKVDDV4EMWWyErP3eBee8AiISsDLzLwlIT3GBcx0qR
	 y5KU/sStgz4YxjtEfBsioAiqUUlKpFSyMIku8wnLLdx14s5n3roKjjUzYzSX7+1YVO
	 WQNu7TBf1e5Sw==
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <zyjzyj2000@gmail.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Daisuke Matsuda <dskmtsd@gmail.com>, 
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <685c1430.050a0220.18b0ef.da83@mx.google.com>
References: <685c1430.050a0220.18b0ef.da83@mx.google.com>
Subject: Re: [PATCH] RDMA/rxe: Fix a couple IS_ERR() vs NULL bugs
Message-Id: <175094006339.824609.2290263451460503052.b4-ty@kernel.org>
Date: Thu, 26 Jun 2025 08:14:23 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 25 Jun 2025 10:22:23 -0500, Dan Carpenter wrote:
> The lookup_mr() function returns NULL on error.  It never returns error
> pointers.
> 
> 

Applied, thanks!

[1/1] RDMA/rxe: Fix a couple IS_ERR() vs NULL bugs
      https://git.kernel.org/rdma/rdma/c/19564a8576ac84

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


