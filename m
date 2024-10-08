Return-Path: <linux-rdma+bounces-5293-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3666A994130
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 10:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E321C26122
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 08:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F24E1E0483;
	Tue,  8 Oct 2024 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJW6ev1K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B89280604;
	Tue,  8 Oct 2024 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373769; cv=none; b=hOR/EE0L0s8go0NAOI31dFV0XsOC/X4w4WHzAiRy4XMzUjNUrD3Md48J+SPBiH/ygZzHb6wR7GUurP33L++edF1XfG3tmSHY6jGOnTSt/kg18WWa/Bo+944QJbWzbz/txqhA9LuNKc/c2jKO0aNQjbgV21NdZ22GKP5xUHlaQN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373769; c=relaxed/simple;
	bh=M5NFoGXr3LYRSCnhjsKYAvVqssiIFyHQc92jpriD2tE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g5m8/Yz0e5jMIUSel1jyzsQ7NfznmQwj3y49+cbOdt6xnysjhPlwadytrgA+xMwC/Ny+oeF3udgwKgIjOTtgRiKG0EF7VguHTHCS7KNMKI6rR8+BrSKjrcXxuobV2/AJbCmX74XjKj+QoCUOF/3yFKLAISlHH4CeZD8abI5wAys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJW6ev1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C448C4CEC7;
	Tue,  8 Oct 2024 07:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728373769;
	bh=M5NFoGXr3LYRSCnhjsKYAvVqssiIFyHQc92jpriD2tE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JJW6ev1KAtBlATC7a/oEDYdmJAGDXrAP9fMyKOWYrKKIqHksCLH0WBpj0rkRk9eDj
	 QOcuesJm2zAbBcdboL20eXBu33p1CbRsXysaCsBDkC4iuqK5qDfpHsYDcdGqlE09ya
	 jO7so1e2kpSlmQRgeTWXt6v9zgyQwSMiCYPN71jHXm36MyT+gsmpB+1f9TxGQ/Ulno
	 Vls/XmjGvBoKNycPlo6yncQDauUy/StYJtHIfWyjEqH+bUZY2xsoDysG1NNMq+fc8k
	 Z/ZTg8+E9Aw6iLI4UWxz8plOQaci3Xs2WppZnZUHBd/I5yw38/aZf/RQwFaY8618fo
	 sDbGv4xCQuxkw==
From: Leon Romanovsky <leon@kernel.org>
To: dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca, 
 linux@treblig.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241007235327.128613-1-linux@treblig.org>
References: <20241007235327.128613-1-linux@treblig.org>
Subject: Re: [PATCH] IB/hfi1: make clear_all_interrupts static
Message-Id: <172837376196.325766.7282945361748273328.b4-ty@kernel.org>
Date: Tue, 08 Oct 2024 10:49:21 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 08 Oct 2024 00:53:26 +0100, linux@treblig.org wrote:
> clear_all_interrupts() in hw/hfi1/chip.c is currently global
> but only used in the same file, so make it static.
> 
> There are also 'clear_all_interrupts' functions in i2c-nomadik and
> emif.c but fortunately they're already static.
> 
> (Build and boot tested only, I don't have this hardware)
> 
> [...]

Applied, thanks!

[1/1] IB/hfi1: make clear_all_interrupts static
      https://git.kernel.org/rdma/rdma/c/89e9ae55dc56f3

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


