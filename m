Return-Path: <linux-rdma+bounces-1398-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 073B8878F54
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 08:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0AA1F21B50
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 07:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65E169973;
	Tue, 12 Mar 2024 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6AIzRjj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E26B657;
	Tue, 12 Mar 2024 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710230255; cv=none; b=Ji2lNjrOuLj2rb4OY5/Sy3hzgrfPzH58ajT5Bv3b+YG/eNrN6ct1kOJTELwm0lZM8umnYCTgUMbqMCjgsi7ySq9DNKbamPGt+NaeFKax5DcSgaz3RkU2oEc+HVsOw6KC+CoPf2KIBycSJfcnL0rCG3+dELUoNSORzhbUYEuKFLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710230255; c=relaxed/simple;
	bh=VG3pR068UJKv/7BHxkzXJWO/gG7U9/48TQUtXnKKh4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=da0hAO2gBvwI2GBZPRIBbYWGXWhwa4ixUeNbZHKOSpFrVQwXEh1PTDgTW/HbPGYVJmCnR2GGG1N3pgJuMlRW+R/3xJiXm3oLjiTlPb7OW3zkwIkFRiCecPQo33aSjqgzzlL0PRSQL8q34KKwCHQnXGvJ2l7hTkCZJqiLKVNU6ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6AIzRjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48329C433C7;
	Tue, 12 Mar 2024 07:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710230254;
	bh=VG3pR068UJKv/7BHxkzXJWO/gG7U9/48TQUtXnKKh4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O6AIzRjjYU9p2QdasGPWZZG7sFgY57p92Rp4xQhMxfvo9XvYQfFW+qrvMvQr/U0Qy
	 OymTnmlEuAlvYqzBltq+aC8sFvuCuTfwhKna2ljxQq90sqzx7pULbG+qdsf0vnOuCf
	 WGitSaCK/f/h+pTFXCvrLqd2XW9FuktDaX8f37JlXeQTMSWsnXX7MaztYH6VUUF40F
	 27ljsJAT72yNi2cAufQkMYKUm5FFOc45i6N9duf0WwydrTiky6r3MeHB8eMXlA9bMU
	 ZuzeJBtpYxZUkN5pyOI41GlDJTqDtyNcbAYjegkwWL63rQQxz5I7RTlfl6YNB0TzTN
	 7Kw5ICwHKgnLQ==
Date: Tue, 12 Mar 2024 09:57:30 +0200
From: Leon Romanovsky <leon@kernel.org>
To: linke li <lilinke99@qq.com>
Cc: bmt@zurich.ibm.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/siw: Reuse value read using READ_ONCE instead of
 re-reading it
Message-ID: <20240312075730.GN12921@unreal>
References: <BYAPR15MB32080B7AA8255352C1F691A199242@BYAPR15MB3208.namprd15.prod.outlook.com>
 <tencent_0343C5B0419D94A0498AF8A447630B5A5807@qq.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0343C5B0419D94A0498AF8A447630B5A5807@qq.com>

On Tue, Mar 12, 2024 at 09:30:53AM +0800, linke li wrote:
> Thank you for your reasonal reply. That makes sense. But you may still
> consider to make it better, like this patch, to read the flag only one 
> time. It will avoid some potential risks. However, it depends on 
> maintainer's choice.

Maintainer doesn't see any potential risks and value is read only once anyway.

Thanks

> 
> Linke
> Thanks
> 
> 

