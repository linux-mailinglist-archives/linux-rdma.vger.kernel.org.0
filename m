Return-Path: <linux-rdma+bounces-6644-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 758509F7964
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 11:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641A61895B22
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 10:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5B822257A;
	Thu, 19 Dec 2024 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8Qba20Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDCA221DA0
	for <linux-rdma@vger.kernel.org>; Thu, 19 Dec 2024 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734603560; cv=none; b=muQUGUHjOSQgL0lsnjW9u5OQqNTttnusWnBux9F1EtopoO5n2gnUikMEye9/qD7vk3Dx3ii6KfoWfohVVNy/S3kaVxZ31O5ndQjSyuDU1CCShUZrTmDzxcxYOp2H3OskY7tBJ2plU8sYi5z4nPcj8aej6WcZV4hb4zyZBQC2UIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734603560; c=relaxed/simple;
	bh=Ov+55pRdA4RWZ7fwi123oDJHo2mUt+5vo/YuOBGDOaM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qXyFppHNPmhXywqeiyq6myscMY719TQMI5AQx3Hdoaop9Iz/hkYt0AtJgRWOR211mysjcZQliLMcgxAyS49OJ1bPHhjLKXtXMlv36o0yRXXwQWDzgyJEqIyUkSlVvx9ZeYE7e9mxWqJnK27KIDKqU9If4l/PHhcZEfk8o/jlQT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8Qba20Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDEFC4CECE;
	Thu, 19 Dec 2024 10:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734603559;
	bh=Ov+55pRdA4RWZ7fwi123oDJHo2mUt+5vo/YuOBGDOaM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Q8Qba20YnLnxVLi5G40KpyUQo2ORcTOBqwXRDkrW1H3ialGbivNZmhDqtouG8VuqK
	 QIYAC2jHL4dKiuo/6zjlMf7/Is+6dT7NfSf49DgaBIcVY9AeqmJdiw5v/rSC/RTTLg
	 vBAvC4feAaFJq5PMUnp3MUgbSNdr4+lueFuljR0qyP+TnYWlrBhW8yxeXnWOBhxXkx
	 Hdfwm89kuE2BBMcPZTqyHouDwjmFVX3jOuhL8c9Ukvv84s+F9hHfq+8deN9dZZDb7I
	 x3Mce+kAozwvZXGBagsd4+JFArGggy7RV/I+G+ZkDOUD2MUKy4U7FUiu4Z+/wMQ9HS
	 IBVAAr4PL6rTQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-rdma@vger.kernel.org, 
 Maher Sanalla <msanalla@nvidia.com>, Qianqiang Liu <qianqiang.liu@163.com>
In-Reply-To: <13eb25961923f5de9eb9ecbbc94e26113d6049ef.1733815944.git.leonro@nvidia.com>
References: <13eb25961923f5de9eb9ecbbc94e26113d6049ef.1733815944.git.leonro@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/nldev: Set error code in
 rdma_nl_notify_event
Message-Id: <173460355580.346747.12984399937456142208.b4-ty@kernel.org>
Date: Thu, 19 Dec 2024 05:19:15 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 10 Dec 2024 09:33:10 +0200, Leon Romanovsky wrote:
> In case of error set the error code before the goto.
> 
> 

Applied, thanks!

[1/1] RDMA/nldev: Set error code in rdma_nl_notify_event
      https://git.kernel.org/rdma/rdma/c/13a6691910cc23

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


