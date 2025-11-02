Return-Path: <linux-rdma+bounces-14175-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F30A5C28E7B
	for <lists+linux-rdma@lfdr.de>; Sun, 02 Nov 2025 12:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BE3188B1A2
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Nov 2025 11:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2969721D5BC;
	Sun,  2 Nov 2025 11:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niNuvHHC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD4B34D3A6
	for <linux-rdma@vger.kernel.org>; Sun,  2 Nov 2025 11:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762084418; cv=none; b=nT9lYa6I5dPlId6gb7gxVh/REfxi2/9ht+43cjONz8fo5+eo0pZAeqaRwbYqfSBOkiFFLDbTQbOJhRr6cXa51rc6ptW21VN6AWnYWSf17K6ildZfLoeTCmWqn0jUa55iEbV3odVbJL6pd7yaxfW40azR9vqWPrF998IHhBHfFZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762084418; c=relaxed/simple;
	bh=FEwmYWN+IGIw8AmTU7QO4nEAt9sZE3x2n+64mNQia6U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Rq9H9KQETAU9ihSoMppwoXT1A8iXBIW+KwBEk4JutIZWoOOcX2NU2tNy80uCZPIB2d4Kb4WBe5LcuDYSvXjvmCtK8yJfevHcvp9lUEC3PMa0/ZoizKfvbvE3ypsm0W/tOoDkhRozJDvgYCE3uLwFMQi4KBsL77wNPX6lsqqBj2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niNuvHHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9486C4CEF7;
	Sun,  2 Nov 2025 11:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762084418;
	bh=FEwmYWN+IGIw8AmTU7QO4nEAt9sZE3x2n+64mNQia6U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=niNuvHHCqlj+xOzlolNOlTbAY7Br+QKCK335YUhh04YThkrQyns2FQebg+9dv0Fc9
	 N6/sqTUaqyqhPjRxz4gDaJFBnVB2E3RbFfdGkGxeCeLmGxYzyje4IvNUcqHh9lptSf
	 Lbm1sE1p46p5RRAf4kxZAOI5clMFdqQ/PEkJKy4AppfFcpCJ8CbyXbRlEgO24xYq+6
	 Ol5padgTdawTG33nf36X21Y8ACHXEBwHBqoBm/Uqzd/7Hx1RbFHhqIt2vFvQfIOC+V
	 TBXxzdYBI4YiNrP7skps40G70vQHnNJrW6TPTiU2BZ70tsMqXTmphrOh+q6PR6EtU9
	 1etNv8ql9i8Pg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: linux-rdma@vger.kernel.org, krzysztof.czurylo@intel.com, 
 Jay Bhat <jay.bhat@intel.com>, Jacob Moroni <jmoroni@google.com>
In-Reply-To: <20251031021726.1003-2-tatyana.e.nikolova@intel.com>
References: <20251031021726.1003-2-tatyana.e.nikolova@intel.com>
Subject: Re: [PATCH] RDMA/irdma: Initialize cqp_cmds_info to prevent
 resource leaks
Message-Id: <176208441518.10923.1922539590339901335.b4-ty@kernel.org>
Date: Sun, 02 Nov 2025 06:53:35 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-3ae27


On Thu, 30 Oct 2025 21:17:21 -0500, Tatyana Nikolova wrote:
> Failure to initialize info.create field to false in certain cases
> was resulting in incorrect status code going to rdma-core when dereg_mr
> failed during reset.  To fix this, memset entire cqp_request->info
> in irdma_alloc_and_get_cqp_request() function, so that this is not spread
> all over the code.
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/irdma: Initialize cqp_cmds_info to prevent resource leaks
      https://git.kernel.org/rdma/rdma/c/153243086eef13

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


