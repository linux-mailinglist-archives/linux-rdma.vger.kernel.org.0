Return-Path: <linux-rdma+bounces-11701-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C232AAEA9BF
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 00:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1E31C26512
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 22:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E49C22126E;
	Thu, 26 Jun 2025 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E6i+VmYz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE6D23B634
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 22:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977506; cv=none; b=ddy6ZPSBJy+V0e+t95Vbn97UDODzEd2DSQ7XAujh7cEMsllOdoHUbXHlo9P1yPPcjjGti/SS94fmTfWTVfYT2MGGPZHdXeJyTsqJagrFU1b35Lwr8AI8zDoG2cGMCZ5yGJyTduX2XbMm4LW+nW+6LN/SnsVP/Tqk0X9JT57RlTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977506; c=relaxed/simple;
	bh=ZaPhd5R/35Ok79wR6z6dwIrWWaac9MBdzbGO1yUtDN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LP9CtVFqp12/+GanReJjpJp7Dc43o2NhHsYCaMlFoZGpYajrGCZLE9mHXNPbS0F2Dy1KzfE9pTmI/URQ9HFIgvNfWVDDwYu44Jylr2ztPah1Z4xnmz7Kb3XmBYKKg3zwumAjgSYeSjXne+M02BSDB0b8WdZmVTn+JcvObYUwbBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E6i+VmYz; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f59b4048-a4e3-4d7d-8aa9-5a3ad42db8b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750977492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vRU6L+EDkJ388DaA+4C4JTDMjH6f4x8nZAQ5aHFXNA=;
	b=E6i+VmYz2HbQ+3ufVwD/vCJYGvx+p+PJbnHCSRZP1vPFIET5zTpbxfI+cyspX3Di39obbM
	GKSmAVrfaaBKbwKRZJ6/MiKDVN8PNd1AtVcWLLBqoI3wc6vWDtdkqq6GjYAwjCjtKSThDm
	SktAuoLRATglUlkEs/BhzHstMhI1mn4=
Date: Thu, 26 Jun 2025 15:38:06 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] WARNING in rxe_skb_tx_dtor
To: syzbot <syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com>,
 jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 zyjzyj2000@gmail.com
References: <685dc8bd.a00a0220.2e5631.0382.GAE@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <685dc8bd.a00a0220.2e5631.0382.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

#syz test: https://github.com/zhuyj/linux.git 
linux-6.15-rc4-fix-rxe_skb_tx_dtor

On 6/26/25 3:25 PM, syzbot wrote:
> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:
>
> failed to checkout kernel repo git@github.com:zhuyj/linux.git/linux-6.15-rc4-fix-rxe_skb_tx_dtor: failed to run ["git" "fetch" "--force" "9a778a5fe5e4b8c26d97f27ad3305a963b60aef0" "linux-6.15-rc4-fix-rxe_skb_tx_dtor"]: exit status 128
> Host key verification failed.
> fatal: Could not read from remote repository.
>
> Please make sure you have the correct access rights
> and the repository exists.
>
>
>
> Tested on:
>
> commit:         [unknown
> git tree:       git@github.com:zhuyj/linux.git linux-6.15-rc4-fix-rxe_skb_tx_dtor
> kernel config:  https://syzkaller.appspot.com/x/.config?x=79da270cec5ffd65
> dashboard link: https://syzkaller.appspot.com/bug?extid=8425ccfb599521edb153
> compiler:
>
> Note: no patches were applied.

