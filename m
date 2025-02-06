Return-Path: <linux-rdma+bounces-7482-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E680A2A3CF
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2025 10:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE771886061
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2025 09:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7785F22579D;
	Thu,  6 Feb 2025 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRAUXk68"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31383212FA0;
	Thu,  6 Feb 2025 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738832622; cv=none; b=rBT90ABcqUaGomWrM8L9S5pjklvTF54nMNsO16iUsMgEOkgaHHsCXBbE5QfIAjqJNVeRAPZs4Nvd3J7anwcxUj8LJbt9EpRzsM3Q3Xz8Dt2MLHOnflIcJPasLWC2xUTcARrHyM5NhQOZpLaLE1Ad6jRB9tIMgX+bymEkrPSB/Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738832622; c=relaxed/simple;
	bh=8LUlCBZzyMdljfZO7W8qgTg9bXkne6zR97lBlNzFevU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qNUo3ie+Xb8t4UeJi4xE6SW1lX04sU6VfNTLFqunkmP22VTLFhMYDnUmcbLdLUoaEqUoONOR8gSvi5X9MrnlMGE7arAVZH3kdS9w/FnIHjWeoWFiBPCzBrAd7+B1y27LU6K7IfxZyPbVJDkm23j4d0kF1jnmpRA3nb0sN8T8ryE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRAUXk68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213CFC4CEDD;
	Thu,  6 Feb 2025 09:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738832621;
	bh=8LUlCBZzyMdljfZO7W8qgTg9bXkne6zR97lBlNzFevU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fRAUXk68JX6QJXihAK0cWaX9FJt3r/v146UFTq8BgjqgE6zCp96d3nJ66fCiMZL4B
	 nlIok+FL/ucWSFQFQ0Q4kUZ9LxTo8DcxbggJog44YItPLF24vigZN5pbbQud+Ey+Bf
	 slP9Hnoj9KlioFjdze94DSt5olpPBO0qvaE+2TS8IiBGohG0g3mVCGI6gua6DkfpmI
	 B9QNbMhxv27KMlstUeboZ7pSgIeWMp3rj/g6choTcOFstVFf1CVOrA6vcdjuIN9c7/
	 Cc51NE/yLvqcMRYs9Cm1Ud83hfkcxxniXkKRNWAt6NabnrtBVbCI//BTgqDlkcaA5N
	 lU1OMdcaxLmKg==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, shirazsaleem@microsoft.com, 
 sharmaajay@microsoft.com, longli@microsoft.com, jgg@ziepe.ca, 
 Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1738751405-15041-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1738751405-15041-1-git-send-email-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Allocate PAGE aligned
 doorbell index
Message-Id: <173883261827.838331.325025029606053891.b4-ty@kernel.org>
Date: Thu, 06 Feb 2025 04:03:38 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 05 Feb 2025 02:30:05 -0800, Konstantin Taranov wrote:
> Allocate a PAGE aligned doorbell index to ensure each process gets a
> separate PAGE sized doorbell area space remapped to it in mana_ib_mmap
> 
> 

Applied, thanks!

[1/1] RDMA/mana_ib: Allocate PAGE aligned doorbell index
      https://git.kernel.org/rdma/rdma/c/29b7bb98234cc2

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


