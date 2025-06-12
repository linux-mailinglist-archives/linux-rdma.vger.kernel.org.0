Return-Path: <linux-rdma+bounces-11246-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88668AD6AC5
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 10:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D8A16E7E5
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 08:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84416225397;
	Thu, 12 Jun 2025 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoW5WGVF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435D822E3FC
	for <linux-rdma@vger.kernel.org>; Thu, 12 Jun 2025 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749716908; cv=none; b=b5sZ2K91ot55+f+KtDEBMo/2Ix27BouNhmSDn9oI/eMpfb4ZuJALfKUzl72OHM7jukxsV/2UJfhoYY/CImTlPeFluyUcRelcMk2508kYmyDzusXmpXyYsWg+QwcE4Swyb0BhZYuG1KMk3zuAAgfK6tmmn1Cg4s+Kye38xe1EHHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749716908; c=relaxed/simple;
	bh=lyvI+ilKUMoee71NzJ6JFt+m7Ac/9Iomf1v3VlgK+lw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DNCk0XE0palQgcrcsEPcprHCFaKM4V4tVLmUL9FRdyc+RhJiyo1trpUg74uSfZ0Uis/P9WWmveJtMA6HtxSpl+eLw2l/fOoWieW4dtTjMW9yQaRXdwNAAK9Cnx26/iidff7HEPtsBDu60htDr9MhhwxoRjHG8hObtrGG8dVkYvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoW5WGVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62991C4CEEA;
	Thu, 12 Jun 2025 08:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749716907;
	bh=lyvI+ilKUMoee71NzJ6JFt+m7Ac/9Iomf1v3VlgK+lw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=KoW5WGVFNeacz5HJr5gtITXQEYyZ9AISRqvAz+MYJIjmZsMqc8/MbCBHtgokKLbB9
	 dTqt947ioB0Qh13gRRNwzd3bHgQBnuRqv+/cUUwNgdBq5cfxJtnmpOKf9505QqwDFA
	 i3cLi9HtFYz/iSpICrQDKjCj4wS0GB2s47grJgDwvsHIrfOBA50lWNMgz0wqvWYhat
	 8TL0H4OGJtQkdnXkfewKToUVwGLU1CvxooYlDJfjiLlXnEQbP/wdEYpywhA14Wznjv
	 JMoxuX1BnBSYbYFx/EZjWtH20Dbfw5AVI9InmSgf80n5xZDei+zbEkNRMo+qFZG5v1
	 ZCQFM5UmswF2Q==
From: Leon Romanovsky <leon@kernel.org>
To: sagi@grimberg.me, mgurtovoy@nvidia.com, jgg@ziepe.ca, 
 linux-rdma@vger.kernel.org, Li Jun <lijun01@kylinos.cn>
In-Reply-To: <20250604102049.130039-1-lijun01@kylinos.cn>
References: <20250604102049.130039-1-lijun01@kylinos.cn>
Subject: Re: [PATCH v2] IB/iser: remove unnecessary local variable
Message-Id: <174971690420.3782784.3890597176865549846.b4-ty@kernel.org>
Date: Thu, 12 Jun 2025 04:28:24 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 04 Jun 2025 18:20:49 +0800, Li Jun wrote:
> The 'error' variable is no longer needed,as iscsi_iser_mtask_xmit can
> return the result of iser_send_control(conn,task) directly.
> 
> 

Applied, thanks!

[1/1] IB/iser: remove unnecessary local variable
      https://git.kernel.org/rdma/rdma/c/682641135d44e8

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


