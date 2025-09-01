Return-Path: <linux-rdma+bounces-13022-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE992B3EE51
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Sep 2025 21:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683E11B20FC8
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Sep 2025 19:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A3E2DF121;
	Mon,  1 Sep 2025 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqNbYips"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D3432F763;
	Mon,  1 Sep 2025 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756753826; cv=none; b=cZ0KzULsqlwwx+gEV3/+Cn7snrmFbGdkXF4mbg5eY9ERc+3B1hSFKoKXBF2lTXoyct+VevaPDbzKul6B6kPN3a00ln0tJ//OjiXaEDB/4Wuy+g5J3uyCf4Gl1zQfuwWDMxNu6ghOn6jDz6JaFqomn1I+CAouVCWlmr6GLpQTgQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756753826; c=relaxed/simple;
	bh=COrOi3bBkI3gkuh2mO1J3x+3wZuSk193LOMMXhSmpcI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UM+WszWt79MWDL8HPwGj55yTIyPTxC/OEWo6PwzdyUxYxjWKbD1A3btxigTab7mPGfG1nneFjMkNIBMugQI0nlQVhgpJkZNwcSgsmHKGba96jSARzv6TP+/Y7IenF/ws3EMU/h3IaXJ/rDHK+D7GUhWaLySAosxXuHeBXLwc/Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqNbYips; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B460DC4CEF0;
	Mon,  1 Sep 2025 19:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756753826;
	bh=COrOi3bBkI3gkuh2mO1J3x+3wZuSk193LOMMXhSmpcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KqNbYipsdzhIQTxTx0DLHwLOS36b25/1tbp/m47kATOmq/7RXyfM48lBV1f6JMJf/
	 lZctWgrZtpxJumF3AuuoRFOhHjjp6ZclJUcWDbVh6NEibtgkWRTk3HvE5Ahr+wiUD6
	 YptkQ3ManiliLpDMzvfFV0ZkSTjilY4t47tUtasgrnJYulfi9xtruNsQ2y7pgw5e1X
	 oViBfafm8So4DbC5o9ZHCVhsHpazIdhvzDTswVVEvq9uQ+Lt0EtSnjVQs5hi8IPTSU
	 6D8Mrb86RNKBcjOSv8I3FS54NlGgyjqe5SeBjBu7qHtGDNitRDBI4jU4F8Jh3kPpdy
	 7Lh0KEyciCrrQ==
Date: Mon, 1 Sep 2025 12:10:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Siva Reddy Kallam <siva.kallam@broadcom.com>
Cc: leonro@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, vikas.gupta@broadcom.com,
 selvin.xavier@broadcom.com, anand.subramanian@broadcom.com
Subject: Re: [PATCH 1/8] bng_en: Add RoCE aux device support
Message-ID: <20250901121024.5553a4b3@kernel.org>
In-Reply-To: <20250829123042.44459-2-siva.kallam@broadcom.com>
References: <20250829123042.44459-1-siva.kallam@broadcom.com>
	<20250829123042.44459-2-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Aug 2025 12:30:35 +0000 Siva Reddy Kallam wrote:
> Add an auxiliary (aux) device to support RoCE. The base driver is
> responsible for creating the auxiliary device and allocating the
> required resources to it, which will be owned by the bnge RoCE
> driver in future patches.

Acked-by: Jakub Kicinski <kuba@kernel.org>

Tho, I think it's a bit weird to push the RDMA driver before your base
driver is capable of establishing a connection.

