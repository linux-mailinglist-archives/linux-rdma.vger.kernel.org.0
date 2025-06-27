Return-Path: <linux-rdma+bounces-11708-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAA2AEAD31
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 05:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6AE566F7D
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 03:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20961946BC;
	Fri, 27 Jun 2025 03:11:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1622660DCF
	for <linux-rdma@vger.kernel.org>; Fri, 27 Jun 2025 03:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750993865; cv=none; b=Eagbf9p1LJvN/6o7qVtQ72PwHicL1InDRpS2MZZ+3EEdfgLUGe8e9Vl99FFTCOcp0bcPqO04PL83BbB6FJNODEvWfEbJpDaeqh3QmcflS/KC2kl9S7coqxRL/2n1joX2zHbsSPGwj0Iyhp6RJQ30l1A9fgMWMkQnXG+1CL8isQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750993865; c=relaxed/simple;
	bh=sCt1kmFQFrRYMrSvrxn6+Q214kp6L+54pQydD62V1io=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sianORrK2V9qFV5UH7uociICisxz+beDfutsb6OZrxulsW5ltPEJsyNSnDGcC9HGgPk+hDBXIZBRPX9iYuKpAGmS6vPdWGBFI04mbu0ZNfS6HJo9aifubfhSJPBneIR18xxFowy5O7z7yA6jdzgrc5qzT2X7WY2VmTKRqNKNARY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3df40226ab7so31066775ab.0
        for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 20:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750993863; x=1751598663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYm1DerhX9+i4FSoIxNmNfd2oR0TQz90H/WFeOBLX4Q=;
        b=JBu4Mz3FI5RhLrbBaIk4xu97fKtG7d+eN4haqaTpModJQrAhfFzhx6u7K9QJx47iJu
         GE4FpEk4T+WTB6uEBjgI17a1L3Omb/Jz5tC+Dhm/LwXgEwWhOwcOSiycO+653kq1+oFi
         GrPNHCsB50FWNmntE2HeY5CYb5qqNKvJQtAyIgs2NDosjN5AJjO/BIUGbdq53zmi2MJ9
         lIDGWohmNUz1K3gozsNjEHbEmhMqcB6sj4Gx9v2k8PA0Fw8RdPyPHox6xFcKyJXu6ota
         rb/GkU0W+ejf1yVClXf+iosTwphvhPfD5fUHQjpx+Td3puB9phxnIZX9kL7mwX4N0sQv
         wSZg==
X-Forwarded-Encrypted: i=1; AJvYcCVCGwt+iE2bWgeWhIUoVKDTAKbPuX+iXLv2jOnzqiYLODbiFQdpVGsKkj1Ztlr83dBuX8/kvE1gnZrH@vger.kernel.org
X-Gm-Message-State: AOJu0YyfKWy62pKImeqfSId2ETUO1VLOZN/J+ADnzwp+7BniWsj3fCN1
	mFbzOevaZLTSe/gPC6UN3ZquK7/LCKCS4AXwexQx6HFxGQ/t0ZFLpL+ejm7u+xq45C07fdWwRLE
	SC1+pdibP030AQf4DX5cytCeqxGZI/vz0j+0FktNalTHEPR8+Q3S+RX+XxvQ=
X-Google-Smtp-Source: AGHT+IHh1nFsPM8aTo14FoQAfaLjNnSiaNy26ysfY/Lg1H3kteqN/NUm0ZIOGP409Tnat6G2Zx9ycIpKJn8YGbAkTndU7YRiItYJ
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168f:b0:3d8:2085:a188 with SMTP id
 e9e14a558f8ab-3df4ab4ee37mr24558505ab.1.1750993863234; Thu, 26 Jun 2025
 20:11:03 -0700 (PDT)
Date: Thu, 26 Jun 2025 20:11:03 -0700
In-Reply-To: <850c0f71-ae74-4a06-bf40-fc44c6ceede7@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685e0bc7.050a0220.d71a0.0006.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in rxe_skb_tx_dtor
From: syzbot <syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yanjun.zhu@linux.dev, zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com
Tested-by: syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com

Tested on:

commit:         f648fc0a Revert "RDMA/rxe: Let destroy qp succeed with..
git tree:       https://github.com/zhuyj/linux.git v6.16_fix_rxe_skb_tx_dtor
console output: https://syzkaller.appspot.com/x/log.txt?x=14372f0c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79da270cec5ffd65
dashboard link: https://syzkaller.appspot.com/bug?extid=8425ccfb599521edb153
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

