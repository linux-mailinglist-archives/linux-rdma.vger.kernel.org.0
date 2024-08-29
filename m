Return-Path: <linux-rdma+bounces-4630-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3B296417E
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 12:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BBA2832E1
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 10:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A1D190497;
	Thu, 29 Aug 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMaiiNQB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C1B18E054;
	Thu, 29 Aug 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926744; cv=none; b=qo8cXSpHUvxwrhZijDsZCbizrOI3fdOM3dXDs3xorOUjyW4FzY3nzEiK9S62hpOqxAtk5nu0eeCKyri0luMXzjFfUQCYvze2bqM2Clkg9OEjBl8Zdff/Gvn3vjDbTGrjgvwtdBmI/CVptmS0RBqJUQgzcvn2IE4hST3KasuyELM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926744; c=relaxed/simple;
	bh=8DXjijzihEJwOPH4EIhRSVH7VG3ypMorm/szPlzyyQc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qtc7DFkv72Qo34MW8+UKwRcitq6xCDs7zHAbL8+xTMJuG+DxC9lL5yeCwF4h3QtUJ11EFarv39S6maUjPbhe+v2rIenwytlW1w4cu/IBnO1H7YWSJJMNgrE9H3NW7zK/7XNXP0aDO8WV8uHLJviU6tVXtnXAm0kmk6aght/1OOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMaiiNQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E519C4CEC1;
	Thu, 29 Aug 2024 10:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724926744;
	bh=8DXjijzihEJwOPH4EIhRSVH7VG3ypMorm/szPlzyyQc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oMaiiNQBY3ZnCP6n7HG0Jj3Db3Mb5aeas3MFWG9Y0HStCSG81+hBhlC+/8zrTc84I
	 c+8DEoD9Ta6LLPLQPpoqULhplZ+4nZb/ZalGeWZpDp5t/iYdze3pBjDXEsCuGo4izq
	 uZsSBtslKkDgEG78alArN0Ara4dsN1s7jQanfFjdufUYdjwQJ4Fgd7+sW4+sMBqOCG
	 OD5LbujgjBDg7m1ViCUjaPrR59KzkTWppky+zKV3BnB2HmI8BWSmhF7inYoC3+9fak
	 KPH9etqgdHX3ELhNnU8B/HI6PczW/uBcz3k2NGA4yGz7ziwlQoC7zm8RVP84ZktSd1
	 9Fq6BBIWdlvtQ==
From: Leon Romanovsky <leon@kernel.org>
To: dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca, 
 Shen Lichuan <shenlichuan@vivo.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 opensource.kernel@vivo.com
In-Reply-To: <20240828082720.33231-1-shenlichuan@vivo.com>
References: <20240828082720.33231-1-shenlichuan@vivo.com>
Subject: Re: [PATCH v1] RDMA/sw/rdmavt/mr: Convert to use ERR_CAST()
Message-Id: <172492674035.35050.7005076935196268603.b4-ty@kernel.org>
Date: Thu, 29 Aug 2024 13:19:00 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 28 Aug 2024 16:27:20 +0800, Shen Lichuan wrote:
> As opposed to open-code, using the ERR_CAST macro clearly indicates that
> this is a pointer to an error value and a type conversion was performed.
> 
> 

Applied, thanks!

[1/1] RDMA/sw/rdmavt/mr: Convert to use ERR_CAST()
      https://git.kernel.org/rdma/rdma/c/8f1f60b21b9603

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


