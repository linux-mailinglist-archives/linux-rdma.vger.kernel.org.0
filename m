Return-Path: <linux-rdma+bounces-2271-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3768BC07A
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 15:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A88281D68
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 13:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06101B7FD;
	Sun,  5 May 2024 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayQbzRJL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CACE1BC31;
	Sun,  5 May 2024 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714914720; cv=none; b=pV8QOWMkahGi0edF8xjaPvNvVKfUzFRlwmSpyjm99OfwGbAAUAMay9cjF3o1wqPAFY+5PT+x6X6Ux9CNE192jhEfKNZiA5t6ce9Pno0itC2NzASnZV5+fo2XRqaG54KeqJLHlnjHnQ9ntn/YMpj6LhPW4VbtkCSv7HOmDfpzyno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714914720; c=relaxed/simple;
	bh=339kHs5cw0S4Jw9bzqy0KdYyelCRe83EhIFkTfjj06E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HBnZImAvBYsYgGltVq2Dyn8JwkgXkO2zNiUGiGzIzkjgfx0e2ZRLajVk5h1FEOBMWYoQ6a7y2fvyDH8GRfdIDPnvIwdb3yJG0J9b1zwOt7cyAIdaD1xtC4hke0zvLFHAKSk2Rm6hL9yUJK01qLx7+fHyVOHkSXVTxMASSeUCZEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayQbzRJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F26EC113CC;
	Sun,  5 May 2024 13:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714914720;
	bh=339kHs5cw0S4Jw9bzqy0KdYyelCRe83EhIFkTfjj06E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ayQbzRJLppFZ6X7ysAjTs7NeK89fOKRh5ECkUUlpuvdnoY2EQPTjBJ144AuUV/Uzu
	 6ddwaFLeH7Vtg6sph5bg67lFLY4c8Fqq+JZof4OQEm71vrqObHNXFdqtjQCG8KXMWw
	 Rj0LjKvjw8NPmdZ0vwJYMRZ1pWbnhJLlj5UJr2QNYYmEz0Wmy+nzLqrJNRsCU2dEbI
	 npJthztemfRODI5iowYvgLftTGY9oGGsxiIYrtIltmLmd5rjO8QswojZ4t9fbpZJIh
	 kCNwNh/qWL8g1MDyGbQ5Ih8IjdMGohDodHfdspE7/28Oa7sQ5KIRTW7tnB/9gmp7HX
	 ge43qEkeqhtSQ==
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, 
 Dean Luick <dean.luick@cornelisnetworks.com>
In-Reply-To: <20240503133640.15899-1-ilpo.jarvinen@linux.intel.com>
References: <20240503133640.15899-1-ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v2 1/1] RDMA/hfi1: Use RMW accessors for changing
 LNKCTL2
Message-Id: <171491471637.194239.11215634092351988199.b4-ty@kernel.org>
Date: Sun, 05 May 2024 16:11:56 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev


On Fri, 03 May 2024 16:36:40 +0300, Ilpo Järvinen wrote:
> Convert open coded RMW accesses for LNKCTL2 to use
> pcie_capability_clear_and_set_word() which makes its easier to
> understand what the code tries to do.
> 
> In addition, this futureproofs the code. LNKCTL2 is not really owned by
> any driver because it is a collection of control bits that PCI core
> might need to touch. RMW accessors already have support for proper
> locking for a selected set of registers to avoid losing concurrent
> updates (LNKCTL2 is not yet among the registers that need protection
> but likely will be in the future).
> 
> [...]

Applied, thanks!

[1/1] RDMA/hfi1: Use RMW accessors for changing LNKCTL2
      https://git.kernel.org/rdma/rdma/c/8f3b7103b41314

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


