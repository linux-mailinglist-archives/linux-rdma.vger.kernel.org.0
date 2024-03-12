Return-Path: <linux-rdma+bounces-1406-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE83687987B
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 16:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833861F23E57
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 15:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB317D082;
	Tue, 12 Mar 2024 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpJU0V1u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A49556B92;
	Tue, 12 Mar 2024 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259184; cv=none; b=ZK5jwcEkP8i8rgkqHxr1zIRbVKQFN0TL8J54B1C0jhZcqX6lCyqhnqHyWacOldmTWJdEss57GPfhIZQqJiYTwD7m4TEN+DIUZ49JKspifTg92KCnLR3qdDXr8GKbdCQyclUFmprZokNWw/MDFYDFf4Kz/LmBCdJmkyAGGfms41I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259184; c=relaxed/simple;
	bh=OkHExvkvwZqf58YXKhcu7PwCzHt174DHv/17dIKsxog=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lIdwBv/z5QsFeBqkBiYLDCt19v9EHWqA7tGwQL2kLIu2FMEerrHv1HH5HgCKRpmfaiEhlfot9yPo814/m8sQF70fU1fMRz3JSq7kmt+xRMEDk6gpz6swSzXNtWDT7sGsrcDmczlXIKmftmaEaGNRa0fqwd84otbdzojDTnE7M2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpJU0V1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CFDC433C7;
	Tue, 12 Mar 2024 15:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710259183;
	bh=OkHExvkvwZqf58YXKhcu7PwCzHt174DHv/17dIKsxog=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kpJU0V1uh9N4RXiw3jiJPPcasUlCPj8FuQnq215NIqekf8ePnlF5lU8d7C1PHGfCt
	 0HzEKB6ZC5sT/Xgel3n6PlnAr6byb7f4MQmWhoy7XWYIotMVgOUEY8dkn1hMu5CWFg
	 TjP7gInH0EhvUbtBj/94apFpfTpO7/LCP72lEUXRsjT0bbnSQxlOaoM5P7V3s0Hu3f
	 EfWm8uGyc1p6b6oOZIUeu6vhcI3GQDoq2IPHf4NjUgwS3inaTCWaf6W+t94+yfPwCq
	 2n0Zfs9dXvOmRqXlSf8SQxK7M2ES+jisE1NQcnPesXNDe/E4zxF7oZhnZi7ZuamZEu
	 OO6SHERLTLhhQ==
Date: Tue, 12 Mar 2024 08:59:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, allison.henderson@oracle.com,
 kuni1840@gmail.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com
Subject: Re: [PATCH v5 net 0/2] tcp/rds: Fix use-after-free around kernel
 TCP reqsk.
Message-ID: <20240312085942.3601d2c6@kernel.org>
In-Reply-To: <171025623204.23106.14167752316235591977.git-patchwork-notify@kernel.org>
References: <20240308200122.64357-1-kuniyu@amazon.com>
	<171025623204.23106.14167752316235591977.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2024 15:10:32 +0000 patchwork-bot+netdevbpf@kernel.org
wrote:
>   - [v5,net,1/2] tcp: Fix NEW_SYN_RECV handling in inet_twsk_purge()
>     https://git.kernel.org/netdev/net/c/a7b7079bc292
>   - [v5,net,2/2] rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
>     https://git.kernel.org/netdev/net/c/a28895fc04fa

I think I need to discard these, otherwise I won't be able to fast
forward after Linus pulls :( I re-apply later.

