Return-Path: <linux-rdma+bounces-11853-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C96DAF670A
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 02:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02374172065
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 00:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D736F149C55;
	Thu,  3 Jul 2025 00:58:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388F113D246
	for <linux-rdma@vger.kernel.org>; Thu,  3 Jul 2025 00:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751504285; cv=none; b=RXv5TMqPIfJVj/x77uO+bGJMLXEyUYPKZkWBlFVfbz0RT0Yt3H2TNTKxWSji9DNloU6RzWAM2kJ8XZV0pkgpOZZjpm5Bd3h77pixplJ6WTTQiJdBTE0sQ8d226DuclF1bkQA3m58/ffOSJ8fqmooZ2mTbVlsezAzzuBQ/3Fa3mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751504285; c=relaxed/simple;
	bh=pmC4OwtOFVDLrG4+eB+G+a+jJFS0npjeg7NUpB3tO6g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HXG9tdUZHH1GB3Dw0LHEJ2PhIvwv9K/MUJPOJipS2GpotwsOu3mq9so8CtLTjeSKSjX5AvczEerX3VidIMpnJMFzdENx9AkZ1PAcXh0dtWB9/9iGb2NYvmPtl8fIeSAOQNQDnBrxrPsJEGUkHz8H7KjwdF8zPxg5M41x/p39bFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-876afa8b530so334600239f.0
        for <linux-rdma@vger.kernel.org>; Wed, 02 Jul 2025 17:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751504283; x=1752109083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNai3SPa+6hePVwwqwqgnsnmvCbGZirLX2U5kQE+UPo=;
        b=Sl33WUK9g2Y981HOGtKUZUiy5BWXpKYC/1oOuv0bpoqfNP5pW0EnISogm23LV/dzG+
         gMRrzS064VGOEy/bkRokz5lZNmnGOJozzy0ihKxRUjeXd3Uk2B7HamlErTwjXtMdP7pg
         rf5OI26/YDhUqV1LUtQFqrOK0+3vKRyBofaTBvU2RcxmLLaOPNWHpZLwrmilh8wOI9O0
         Sk6LClEqwh8c6zV7V4VfdDg/BtfU5DdrgN2zASgqG8eNA+dmlRCxwVFuOPCm715DNF3c
         rjlldyudwKBVBQLqZBOweh1DUwOAX+uGwFitPEKfigx2WTMMfqyjt6QOsL1RXsslPH2B
         BZaA==
X-Forwarded-Encrypted: i=1; AJvYcCV8/Vu3gRS0tWnNXV9X094sdbj80YB9p/a8xlLij9MHK6tUPOlfMSJyMZarFOV+xR6+6VBWozOg2LfH@vger.kernel.org
X-Gm-Message-State: AOJu0YyuTGH6iFjq83N60FgzaAvYflSkpBdqhJNcX07PCrN+wTuONoNh
	UYMlLK0U5WPz7REk1vqol7PYv2d7xnFeen90RbSNnJGf9d7bSHgiOfwjvR0PjRwY0oH7pMoy8Qr
	rIjU0zWxF981VWqzcvu5EfPg9Ym0u2V1AYfwIQnOfcRLZ9vdRvn1KGFCcLI8=
X-Google-Smtp-Source: AGHT+IFp3T5dg78FtMa4+EhGu7+XMgs/urX6IAnqC68df88Oo3ewTuIZMXhvtQ3EMkZfpK7lcpBSgPM5BBRKuhFGod46zxwLyS9Q
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6015:b0:86d:5b7:5a42 with SMTP id
 ca18e2360f4ac-876d1e1590fmr293530839f.4.1751504283388; Wed, 02 Jul 2025
 17:58:03 -0700 (PDT)
Date: Wed, 02 Jul 2025 17:58:03 -0700
In-Reply-To: <ca69d915-5a8f-4396-b35e-319ed7f0b8ad@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6865d59b.a70a0220.5d25f.0781.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in rxe_skb_tx_dtor
From: syzbot <syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com
Tested-by: syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com

Tested on:

commit:         6f8d023e RDMA/rxe: Fix rxe_skb_tx_dtor problem
git tree:       https://github.com/zhuyj/linux.git v6.16_fix_rxe_skb_tx_dtor
console output: https://syzkaller.appspot.com/x/log.txt?x=13973770580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=36b0e72cad5298f8
dashboard link: https://syzkaller.appspot.com/bug?extid=8425ccfb599521edb153
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

