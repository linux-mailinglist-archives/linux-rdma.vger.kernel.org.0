Return-Path: <linux-rdma+bounces-2210-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339A48B9CCD
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 16:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64BC51C22E1D
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 14:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C44116ABCE;
	Thu,  2 May 2024 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5sk7yNa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E108168B0A;
	Thu,  2 May 2024 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661225; cv=none; b=cDwF5QiHEq+g6cmGSkweZMZwe3Y/5KDpIRJmaHFEbW1Z+X1h2bC1Ak1S/56nD6OTtmFpPaRemuIcIqZOnaCN9QGsglMDYaLUfbSoGHApKGxrvBZgxmvO7eq2BLN0w+mNwbJOoqDmdu269o8jXuYF2+PjX1SO9iLWEiYj4uuH4Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661225; c=relaxed/simple;
	bh=s7LdIf3gAy6GtEyM8AH+1cJ5Qw5xyeE8/ifqYJCP/6Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bP8n9v/4dS8n2cNIJBIa+RDM+hoE4Y/A9Spm1e0ON1Dynp98DHY1wbDChfnzgHIU92SWyStxE/iPBTJ9gJs5v6Ox91AWQmlm3b5ZKWhbO9CSBc50BXVHddQ9eTY4LtWo8smW4ZpL3JzOeHdyx37FBeHBNY94qVLwGqStsFu1fAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5sk7yNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FD8C113CC;
	Thu,  2 May 2024 14:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714661224;
	bh=s7LdIf3gAy6GtEyM8AH+1cJ5Qw5xyeE8/ifqYJCP/6Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=n5sk7yNa+nqPYBbADu1mOEHvvzCVrQUhBcaHppjwIXcWrRrwEBxIJgXz8Hg8KQQxk
	 y71FOwwGJwyKBf17ze4UfKp86Jm0EPX4Za4DsTi6u9wJMANSIY8wUB9WbEzs7Aygy9
	 CnI/QJfX24h/IXMvYIlcwvKolqOqM389www0q+Z5yXfv1bJUhZbiFO4wUJ8PdayOVO
	 mHqvCqjZZMdoQtxwOLiEvZaGbOr+XpwY3Ri30XRXYpZVsboVL94hsLiFiWdT/x5Ng1
	 Er9y4LuSX2LDaJOyNVbfIR3UurDIaN6RQO1LAYbTCpMSs7ex+iuU2n378IGX5q/Vje
	 pvMBxhVKtRXcA==
From: Leon Romanovsky <leon@kernel.org>
To: Jules Irenge <jbi.octave@gmail.com>
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 lishifeng@sangfor.com.cn, gustavoars@kernel.org
In-Reply-To: <ZjGDFatHRMI6Eg7M@octinomon.home>
References: <ZjGDFatHRMI6Eg7M@octinomon.home>
Subject: Re: [PATCH] RDMA/ipoib: Remove NULL check before dev_{put, hold}
Message-Id: <171466121936.1638184.643798566433434250.b4-ty@kernel.org>
Date: Thu, 02 May 2024 17:46:59 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Wed, 01 May 2024 00:47:33 +0100, Jules Irenge wrote:
> Coccinelle reports a warning
> 
> WARNING: NULL check before dev_{put, hold} functions is not needed
> 
> The reason is the call netdev_{put, hold} of dev_{put,hold} will check NULL
> There is no need to check before using dev_{put, hold}
> 
> [...]

Applied, thanks!

[1/1] RDMA/ipoib: Remove NULL check before dev_{put, hold}
      https://git.kernel.org/rdma/rdma/c/e4e40a87024c50

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


