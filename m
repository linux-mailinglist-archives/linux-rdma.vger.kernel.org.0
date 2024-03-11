Return-Path: <linux-rdma+bounces-1372-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB318779DA
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 03:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43591C208F2
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 02:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17ECE7E8;
	Mon, 11 Mar 2024 02:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kmIFnJcN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BC93D62;
	Mon, 11 Mar 2024 02:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710124519; cv=none; b=f7dywNLf2ahrtQ9Zd07XmGOYt3IMz6lqBFFLhcrZxmRbRE3h386ffrtuSHfN5CnKkFXmVhTEsV/CSOJFGw1qVx6+1x9T8J/fQa4jYpkvaRo8T/0hXRwtR351ljsszFaN8JSv4AmIjHxBCeFI8OIJS+75dH3FtDcJJ/kDkLrLfBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710124519; c=relaxed/simple;
	bh=WhmjuGV1kq2WCEIDtuCaWUDhxbU/+ZMX+LPouv4Jpx0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=L89hs5MoeMju+LRWzfT86ju7B8Ogp83j21FZheAe1VmC+nJQ2J2D4JR/GzSriFuOmSIu118taK/W4IRNnFyUQXvb/WNiPa+F6BQE17adUf/x43Hl2hXHvNMMJevD/+JNnPsOlTsd8YgiqCvepVVrugZTgcXS3M8Dygdbn6kFuEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kmIFnJcN; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710124500; bh=C+MiEF4qC6FAaylAML0xdTY2YhM7+veLwzKbbzTLXok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kmIFnJcNDNfWAj2bmooSKy0uGNvlwfJ3NDxvHOlFQGUiSdV68TvplEgqoqUnVgrw3
	 zHSrLBS4L1Vgt+9aeMb3va51KsCYeuS40sawoo2c53Kj1hnZLnFnl9IGWj2wCs6Uut
	 JI/Yk7NjdX/gfvHofLH4v1PqQSANFmHAVoVJsvPo=
Received: from localhost.localdomain ([58.213.8.34])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 8B995E48; Mon, 11 Mar 2024 10:34:57 +0800
X-QQ-mid: xmsmtpt1710124497t5plveddw
Message-ID: <tencent_03614198A34E56D038455012AA31022D9C06@qq.com>
X-QQ-XMAILINFO: Mm/8i8/T4yneLFjWWrRIGkqbOZu0z8AIxOyq+RGDR2OmIiGfEHfbT3yggaBppe
	 x+5Owg6mNNjoEAAbIRdkBqJmqPPOxnSWCkL/x8/JNqrlqyr/Er8NPHOPK2Odgdf3Wfl9trvb45r1
	 ZGgig1CzHGTZfkcGQjSWqtyY2RhcBFCl6VKvTw4d4J/pHCgi6J2TcThOgZC0sBpFmImg9qMnKdQk
	 ZkzOGkc9dOXrK6MuUyouiFAyyWm7Y/u1jLFogBqT1wD61ak2kJdUGphZWVM8TAElO25Jd6/2AWO5
	 252H1Ps7ELnyxV/rIJTh4zeJaFtKg3fQdFY/md//rE7EErZ634ACM1PVhb7mYkqHy/c9URVhydQr
	 4BqDq32dWXFz4w7mIA76jUA/BwZZR2eItyGigLDf3PIZhwZ/BwReudQ8sIFfVAKvIn4TIs/ntp9X
	 D//eMiXXxqUwaaUHTVR36y7xImPkBSn8WXagPj2/anSS1Klud7FUESIAem3UfM/XLnXCHZjmu3y2
	 NQy/RdUHppO4D9GqL7ML1pdfu/ODveaAjc0lHjHtjQz+BrT38XG3s9mL+SIxEZZYhJOHUMAh91eT
	 GKL0fwkdfktYZAleB9eg8GBosG8hf6YpEdmj3O/5dEXX8r9Vw2LxNsevcSCpAcXCXlCfD9LyjGvE
	 clQCLafmM6Ddts/jB8oteHDFz++v2ljoZobAXBUUSlRKf2O7IzMPZ+zGeumlRplpB22Qh0Csj+J1
	 yeKW+edaCYbPkC4u3jO1hKO6XWAl4/h+Lb6vylBUh2o2yEgvFhPN+NuFxAHNXs/qKW6uBOodBAW6
	 VOeXQA6q2AlCIlHOaJ2zYcL+mBxR58ADNrjaRYUs+04VKscHopX9VJVdHLZl6B/dDRADFJGrL3dp
	 Kv+RAiEO/ceg8ZE15tQJCauMW3etZXV1IR98g6UneFwyUQtRMmEvUPBCF54FsRVzaI0gZRGdMMso
	 KMtOJxzM+3nTgqmbH9u0ZGduadSmvG04a6j9bVZYN48MSpqQDV04O6GlOxwCTp
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: linke li <lilinke99@qq.com>
To: leon@kernel.org
Cc: bmt@zurich.ibm.com,
	jgg@ziepe.ca,
	lilinke99@qq.com,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/siw: Reuse value read using READ_ONCE instead of re-reading it
Date: Mon, 11 Mar 2024 10:34:55 +0800
X-OQ-MSGID: <20240311023455.72601-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240310191910.GG12921@unreal>
References: <20240310191910.GG12921@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> If value can change between subsequent reads, then you need to use locks
> to make sure that it doesn't happen. Using READ_ONCE() doesn't solve the
> concurrency issue, but makes sure that compiler doesn't reorder reads
> and writes.

This code do not need to prevent other thread from writing on the flags.

This topic got quite a bit of discussion [1], quote from it:

    (READ_ONCE and WRITE_ONCE)
    That's often useful - lots of code doesn't really care if you get the
    old or the new value, but the code *does* care that it gets *one*
    value, and not some random mix of "I tested one value for validity,
    then it got reloaded due to register pressure, and I actually used
    another value".

    And not some "I read one value, and it was a mix of two other values".
 
From the original code, the first read seems to do the same things. So
READ_ONCE is probably ok here. 

I just want to make sure the flags stored to wqe->sqe.flags is consistent
with the read used in the if condition.

[1]https://lore.kernel.org/lkml/CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com/


