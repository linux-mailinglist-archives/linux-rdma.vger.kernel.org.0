Return-Path: <linux-rdma+bounces-8042-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D0CA425EE
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2025 16:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE96167EF3
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2025 15:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1191519B0;
	Mon, 24 Feb 2025 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSCIV7cj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777EB74BE1;
	Mon, 24 Feb 2025 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740409573; cv=none; b=bIiRACBeN0YSE1XQbkT8QChoy0EIXvY3hSYY3e1Vuh6Y75H+P3a+xgWasR9QMsGVLj14xLWVL34VxzSJD5lSgS9RkVher3tkhZIAFEobKOpT+rlKvDwSSHmggFjJG1qnD26cdsQ7Cr36yIuXwOuV9zRiVjJlS2DIDH9RSAJaNX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740409573; c=relaxed/simple;
	bh=aZ8mtV+yUUdjH+pnqsTQ+U1j4atH+9ZFjq+4VLYh7xI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aTXre05OrUjISoTfa/8LIxqjHp/WR+OCgBQYrTpJbpol2dXVg/lDIOnRGW85bKvwx7VRA0iNs6nulkExJS7F976MAKzEpSGWPko9HyiXCa0RjQ93C4vtXyH41ftzFWIb0OtuWC64MSVB6iFl7lUxmpvx4/EmahvGkRNIKlb2QTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSCIV7cj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BF9C4CED6;
	Mon, 24 Feb 2025 15:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740409573;
	bh=aZ8mtV+yUUdjH+pnqsTQ+U1j4atH+9ZFjq+4VLYh7xI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GSCIV7cjhGdO1iqhqCYOMsY5LCa+qa9EHoL7eeaW27ExkL08iMY5Ij5GFrEUic0SQ
	 8L8iSkHIB1sI80Mau57XfxOwbof+m/UYn7zHEn+b2hu7bTGnkG6g5oNmPKuwivYLlA
	 I/DdKunS3Btg9L01PWUXVrljfYEalZyzRjvCAh+JPaVYEmhPisbLOpsuSddsEwnZep
	 UNp2WpsIthqPBzUFkTKnQi/fXbBCsh6eDM6Vd0M3zkj+t5DvQMhyp3Y0JAGmZ3Zbiu
	 AE6tDr3qMhM4wlBwaEBiT5tRj3jjOjAYxV5W21NdvewwmXjnpMp3FNh4svobEDgmGO
	 zYnEHXIkFqOuA==
From: Leon Romanovsky <leon@kernel.org>
To: dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca, 
 linux@treblig.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250223215543.153312-1-linux@treblig.org>
References: <20250223215543.153312-1-linux@treblig.org>
Subject: Re: [PATCH] RDMA/hfi1: Remove unused one_qsfp_write
Message-Id: <174040956963.506540.14094629062693367105.b4-ty@kernel.org>
Date: Mon, 24 Feb 2025 10:06:09 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sun, 23 Feb 2025 21:55:43 +0000, linux@treblig.org wrote:
> The last use of one_qsfp_write() was removed in 2016's
> commit 145dd2b39958 ("IB/hfi1: Always turn on CDRs for low power QSFP
> modules")
> 
> Remove it.
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/hfi1: Remove unused one_qsfp_write
      https://git.kernel.org/rdma/rdma/c/ba7fbaa6a83e5c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


