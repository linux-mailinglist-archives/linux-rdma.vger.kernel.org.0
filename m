Return-Path: <linux-rdma+bounces-13535-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B6CB8DB6A
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 14:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522FE189D7ED
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 12:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCD72D0C99;
	Sun, 21 Sep 2025 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvRe7MT/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC601E5219;
	Sun, 21 Sep 2025 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758459464; cv=none; b=tYwFvDUfjR7Q5eRlCfcnJ6V6lW7iutlNRHnXWTaTAar+7Uc5D5PenVJq2owvTBjZsfziHBPChURpYvppfi14W5P6iXQvSPvqKU5jd8leSe2akhnUJwdOgnktaLWWrs3PiYDGurNGllo3Int9NFMSV9FGbCPZ+CWqTVfPJjUgSwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758459464; c=relaxed/simple;
	bh=ss7BvAc2+W5+Xt0aCLOzSxmlCvkmo4zsiArA0aE+mWE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c1HKNObxRKOckBzL8hinjDuxXsG+nk1XxsFBNXEjtLl1krNe9OYJVBnVNVNEZQcN2wb5j8m9s6hHJQI8UVFcnrMpT9wn0BIFaxw2wdiF2tiyK0sz3Qp47T76wBEyFwRAC4BDVywOazrVl9+A3vtoYS5W0CKVDkCpKUO7CjE07wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvRe7MT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E160C4CEE7;
	Sun, 21 Sep 2025 12:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758459464;
	bh=ss7BvAc2+W5+Xt0aCLOzSxmlCvkmo4zsiArA0aE+mWE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KvRe7MT/+wbLsla3y08DFcgCZOmcnQ835+UfG4alPjMnuit2PdltZowKwqsJy7dLJ
	 d0HG8adubv3S69BizUklB4oqOQt1d2j+/Pj/7kMU6by7qmfsh5yeAdkiF7ueGxhwfG
	 /fWVuokkk7grgOiELRF0MW0+ZYfQjkKsEZPaqTwOjc9HJIjKHPxCFhpzypLXAMxT2/
	 G6Q/Dtj94oR3jnG0z+IkijyyY4NEOs1P/Aet+SZuRTt9jty2V8og+e0+WaJrL4kPIW
	 mU5Z4HHqKSWQ4OlJ6XIXyYYwj83kS6+ZJxW4UHyvhY7c6y20iWJcIewIIFAbQ7JswZ
	 E2+ETntdTCneQ==
From: Leon Romanovsky <leon@kernel.org>
To: selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com, 
 jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
 Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250921081854.1059094-1-alok.a.tiwari@oracle.com>
References: <20250921081854.1059094-1-alok.a.tiwari@oracle.com>
Subject: Re: [PATCH net-next] RDMA/bnxt_re: Fix incorrect errno used in
 function comments
Message-Id: <175845946086.2105473.2551807344596160025.b4-ty@kernel.org>
Date: Sun, 21 Sep 2025 08:57:40 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sun, 21 Sep 2025 01:18:48 -0700, Alok Tiwari wrote:
> The function comments in qplib_rcfw.c mention -ETIMEOUT as a
> possible return value. However, the correct errno is -ETIMEDOUT.
> 
> Update the comments to reflect the proper return value to avoid
> confusion for developers and users referring to the code.
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/bnxt_re: Fix incorrect errno used in function comments
      https://git.kernel.org/rdma/rdma/c/9b9e32f75aa3d2

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


