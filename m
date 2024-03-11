Return-Path: <linux-rdma+bounces-1373-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013E78779EB
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 03:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 613D62819C1
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 02:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2226B10FA;
	Mon, 11 Mar 2024 02:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="PodtUbCG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AD9EDB;
	Mon, 11 Mar 2024 02:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710125967; cv=none; b=kad1P0xxllEOg++XcfZHAvvza3xZoGkEvqS5Ydc4l2n55DvOdTnNS3uwBOnpZe9YhgK3K+Q4+KYM/PGkD7fojP+UufsQtkWh+InURqS2RAdnmL6WsbQWH4toiHTyaTnF3yAM0WOh3bwH8RFkZe6aXGscpgGnzUJL8iVGD2Cfe9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710125967; c=relaxed/simple;
	bh=6KYN/7Meuvn7SKEogOlE2iizJKneaDT4Yk54uaEwvqw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qWuRvZqgGUqXG4A3XUC9nKeNyL8nhaCzSQOGARyBfONY52zPwAKzy7d/fKy1xKicADqhnaGcSE561qWA8NPubDPC9a3pqxQF1UHpTxqVhgWd/w4dPnKgtSl2pgWIPvWaYWVrvVji83V9eouy8MK9Kz9aGI5x06H5tWVgz5u7CiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=PodtUbCG; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710125956; bh=6KYN/7Meuvn7SKEogOlE2iizJKneaDT4Yk54uaEwvqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PodtUbCGDGbQ0hM9MlPlY+jmvHLA4LWY8EY+vFB9MeJnnC59YTF5PWdGJD7jmQA9/
	 AfJ/dVtl9AZ17xuEnTBM0+Lp0MgrZjXeIu9gtXlH4OhRgQUnh2kMDuZ40TQWPDkQfC
	 OkOrU11nt4KYmVopfWbdOlZDgPMvemaLMj3tqAUI=
Received: from localhost.localdomain ([58.213.8.34])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id E751C65F; Mon, 11 Mar 2024 10:57:53 +0800
X-QQ-mid: xmsmtpt1710125873th3oyzrzu
Message-ID: <tencent_C20218AE8489E90806F1522C24B11BAFD30A@qq.com>
X-QQ-XMAILINFO: NiAdzfE16ND4I+Bv9GCsESziTVK1TO0p2HRGnO8IMFriFQMZDrdrlHrQ9czJ4g
	 v5IJONm+EnIjF3Gq1g36sJF/K6BiCQ2XG7KfUB3YMV5/sNTBfU6FMbmGwVjJDy5raIxK4J6PpBjZ
	 7xG1qOHvesKsKxemVUZvZdxg1+9myswntJ73bHkfyV2pug2BbF0z40D1FRw8sNF+XKDVmudRa21b
	 s05XHgGHBlCCD2XVNchcwC05gs3R9PQHH0tDjvA9MMkDqJHS/PW+MOV0xGvN48uteggWQ1Xl0yGa
	 Mo2nxcXW1+wicWBvBXna+281T/NoN2Q40fiAeJy6rzAHo2dpbBTQ4xv1vyutfVOGYVF2e0MTDoVg
	 YfiM2o63ZNm4IAY5buHYpuRcPgZjPjGc1fgmXdQM4wfCYZUQ0tOhWa+QPrP1yTv3Wfuc8Y6srhDn
	 PVq+8iy0Tvr2J/Nb8S8QcfOiWJ2FDWysEX4d00jS4nd+8wBFvqx9hTymExpcYorEd+fVfHJC/eMH
	 ni8rbCczFinxW8FQENJjGH8T57YVZNe5u1QqLqMCsQY3KLH9KcXxxoU6ppumrDPCV/2WBe9WcAXD
	 6o2QDuCxVci1/8W0l4NOUu8Wp7FZK+l9WQUSpgmDlYZxremJc3FTSB+xKNUWgbMFvo79KVjM959L
	 FWLFEISSKZoza4baX+72XKCVPnVXz/bpFWRZ1sjzrBWyjgBfAsc+UZMZnuZJjnIGUjhRZ04lLWke
	 OLP1Gel693YRY2jfcCC1jcVlFXPKcaHibuz6oMCUsKts6VkuEVCW0eqUbfyZnzf0dj3Sk8z2KFe6
	 YKlNmzmry/HZtEwJtgrno55Fwu2sV6bCaBlUw9UBaF3Fzq42/rjcHuOtK6FDPP3azXAy8Fz6ZxKu
	 6JN5MCL/b9bsqa44hDSGJjQJ5nlaypEAy2yTOVnf5fq4A3Ehn2ZRQIWYrdOuWA/ofZ/msjsna9rk
	 oqDxiAIMJ/pOPT/gQX3FMZ85MmYUL+eWllB8520fiq6zZyB7eShTbSlWDDgjwFlv0OJ/8VQFha+w
	 XaWjRlCWlNnbiPil5mzl+IP5hYzed1XxRnDbY+Eh4h5zE0HEyY
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: linke li <lilinke99@qq.com>
To: gregsword0@gmail.com
Cc: bmt@zurich.ibm.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	lilinke99@qq.com,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	yanjun.zhu@linux.dev
Subject: Re: [PATCH] RDMA/siw: Reuse value read using READ_ONCE instead of re-reading it
Date: Mon, 11 Mar 2024 10:57:50 +0800
X-OQ-MSGID: <20240311025750.72981-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CAEz=LctG46xSHVxRg0VwnfCpv+uyOHdb0jqQ+WJNc7zSnMA2Ng@mail.gmail.com>
References: <CAEz=LctG46xSHVxRg0VwnfCpv+uyOHdb0jqQ+WJNc7zSnMA2Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This is not a smp problem. Compared with the original source, your
> commit introduces a time slot.

I don't know what do you mean by a time slot. In the binary level, they
have the same code.


