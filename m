Return-Path: <linux-rdma+bounces-7834-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649DBA3BDE7
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 13:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF503B1EED
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 12:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDA81D8A16;
	Wed, 19 Feb 2025 12:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcQ+pOuZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D226A28629B
	for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2025 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739967517; cv=none; b=tDbnRdC5v30Hg3PSpu8T78l46IR43xVIDy8n26logQCpGaBISjYNo3MlK+2dF6ricWTUbzI/gDCi30/dCf8IPhmlsMXNm1EraAjD+5rK7adFnFpkQ8jXotz9xUSPFyeZ5hsDoowwjkY7h6dg0/Yn35LJL9CfslimgjbbOx4J9YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739967517; c=relaxed/simple;
	bh=ekzJkM7+bsYaYbFc5lQ9oTAiYX7qh84Mbs8pszP5ZN8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q+hz3hXG0wXmvq2Eh66CC+dtcYrEuQ+61csrngXL86tPpMF7nhiibn2X8bSGeOFp08srgL3LWX35xRrvct9GAegdndYui/Rj31y9GK3JsTSri+6v7xha2oncAZoPAZrIRCNXiFcv+PjlIj47GUVx2D3Wv/MRNn1z+SBY4yjYAZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcQ+pOuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3758C4CED1;
	Wed, 19 Feb 2025 12:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739967517;
	bh=ekzJkM7+bsYaYbFc5lQ9oTAiYX7qh84Mbs8pszP5ZN8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kcQ+pOuZqCKPMrTZdF7KtIwIHBAOV5GmxBVTdhTghYaIfQ6NlLsFBTb+WxcETk9VS
	 DUZ8wgX+nKoXoCEdzrzetROcPRFM1BKNnacbbYa4NLXUe9SELZMhNaSyDHr2QdaJ5R
	 MjlqeTceO7FSLqyzrBuPtTL38YtOdxUxyOQzIl9wCN/DkzZKz3c1iv/AEOzQsgyey4
	 qa/5j3hXMnS6P8eaZZ1zI7JtT99BkaHwyAgFcvAoLlqIHoNJpjAgfMqRow8Q9/Y3+O
	 T5eznMe3l+89Y2rLUeLZq3gVh9QcPC9TrQaPv/8JR191xuEQAuco7L9r3n65dTqJT4
	 uSEDgIFyREvCA==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 Michael Margolin <mrgolin@amazon.com>
Cc: sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev, 
 Firas Jahjah <firasj@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
In-Reply-To: <20250217141623.12428-1-mrgolin@amazon.com>
References: <20250217141623.12428-1-mrgolin@amazon.com>
Subject: Re: [PATCH for-next v2] RDMA/core: Fix best page size finding when
 it can cross SG entries
Message-Id: <173996751414.370165.3325983349340524956.b4-ty@kernel.org>
Date: Wed, 19 Feb 2025 07:18:34 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 17 Feb 2025 14:16:23 +0000, Michael Margolin wrote:
> A single scatter-gather entry is limited by a 32 bits "length" field
> that is practically 4GB - PAGE_SIZE. This means that even when the
> memory is physically contiguous, we might need more than one entry to
> represent it. Additionally when using dmabuf, the sg_table might be
> originated outside the subsystem and optimized for other needs.
> 
> For instance an SGT of 16GB GPU continuous memory might look like this:
> (a real life example)
> 
> [...]

Applied, thanks!

[1/1] RDMA/core: Fix best page size finding when it can cross SG entries
      https://git.kernel.org/rdma/rdma/c/486055f5e09df9

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


