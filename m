Return-Path: <linux-rdma+bounces-11700-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98468AEA997
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 00:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A89A3A99A7
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 22:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E854A267701;
	Thu, 26 Jun 2025 22:25:03 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A541DE3DC
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 22:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750976703; cv=none; b=CPqMHUvgW7k2rHRzEsh+Ju6WKJ+nRfRVa/RpmXUX9gMx09r/b5LMLQmK5edf9w7eJcCi6K4bys2iP9kZdeQqPrJC9eNunBRpidCc1gf3A8/NDju1cjsiVu5atrVQr1uaO3BkIEdfSYKCMTovZ+EC4VtEu3uwwAW22lg8d2SOfEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750976703; c=relaxed/simple;
	bh=M8pvDEBgu6GiSU5hFeDKveH5vyAoaYOZb4acdCfV660=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BUdarnXNGmfF9w1chkRn7QnOKAeqQmRqCbaqsNDTJ9RbQ/eh8cCCemiQZkFxBHNyaU0gapvyOcJJVOkOR7+XQ6uRkD6IPHJ7XJc6ewcsrwHJ0RQXf7nLL7rfCZOoE5gAekEWyaT/Mn3pynZ8MHGb2fbTsx9/iLQTHyQWpMz0IgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8754cf2d6e2so152413639f.3
        for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 15:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750976701; x=1751581501;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRLthsUnwHe+6RNJTHv6KCafdpsAqYFXxp/PW3uWVqQ=;
        b=UYtB0QitrZSN872qQl9QcEfi3Ohr0XWYfjCuRBW9khuruou/NMuiABgX85CMCOSSZR
         Cj8MSkKWJt3X5u3Q2xy6li62Qffj+1TBUEEzta259oiZxHNCtJwdErFOQQ0xSbrpTEvA
         nkhi8YtFx13zVX9MsCmogsN0kR5I5SKEP0Ck9bxOgsuXJVDYjfGLTpVkvD/XgjOCczB7
         X/dyhbriisJPmFUOwxcPQPBs21HDUwS2EPfYlMYTQACTUVesFvefkJK4zgXfSLL7ZFYN
         JzQQ2BSZA9XJxVZ5MTq9KfOAkgOQCZKgBzECadqhaiMR942T6LJWjfL1nobYAdAGxq0F
         PqgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1QmvlMKienCWkMf6njaEkLQVxtlKv7YxoXaT8ClP6m9ueDHhgwLtw7yPXJ+9LqoDtAkCxCijHKGKa@vger.kernel.org
X-Gm-Message-State: AOJu0YxSHnNriq3InOi3dZv0ZtA/bDwabKQ1QJJd301Dmt/pn/bMumoh
	3fKBQbIAgwboRlzs1uFNJQbzBINZASvr0aS2/WKmpreGvOuOkEAykuJy9AfxOxXNadAaS6m5XD4
	07qdtAzJGSuyMdR/WislqBaefK+4IVq+EfNSBJNIRbJKXQazrwlAklUfFT4g=
X-Google-Smtp-Source: AGHT+IGlYuU+xY7dA42mkckoNClegdwpq1yODBJxpGpJiCBxGEkurlK5sw6853r5gBAG4E8/Bje3POGtoVnqgfmFceH8bycOyUCt
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b45:b0:3df:3620:4035 with SMTP id
 e9e14a558f8ab-3df4abae904mr15203975ab.10.1750976701502; Thu, 26 Jun 2025
 15:25:01 -0700 (PDT)
Date: Thu, 26 Jun 2025 15:25:01 -0700
In-Reply-To: <c6528a69-f229-470c-aa60-012049d7287f@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685dc8bd.a00a0220.2e5631.0382.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in rxe_skb_tx_dtor
From: syzbot <syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yanjun.zhu@linux.dev, zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git@github.com:zhuyj/linux.git/linux-6.15-rc4-fix-rxe_skb_tx_dtor: failed to run ["git" "fetch" "--force" "9a778a5fe5e4b8c26d97f27ad3305a963b60aef0" "linux-6.15-rc4-fix-rxe_skb_tx_dtor"]: exit status 128
Host key verification failed.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.



Tested on:

commit:         [unknown 
git tree:       git@github.com:zhuyj/linux.git linux-6.15-rc4-fix-rxe_skb_tx_dtor
kernel config:  https://syzkaller.appspot.com/x/.config?x=79da270cec5ffd65
dashboard link: https://syzkaller.appspot.com/bug?extid=8425ccfb599521edb153
compiler:       

Note: no patches were applied.

