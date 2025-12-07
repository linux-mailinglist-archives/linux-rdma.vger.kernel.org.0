Return-Path: <linux-rdma+bounces-14905-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FAECAB164
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Dec 2025 05:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D54F308D5A0
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Dec 2025 04:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C20B25D53C;
	Sun,  7 Dec 2025 04:29:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4B519CCF5
	for <linux-rdma@vger.kernel.org>; Sun,  7 Dec 2025 04:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765081745; cv=none; b=E7z2vZwotcvxtb0UxlESYzOUzlbstq8ahgyViqTDBTMnG2mxnX5iCVCwAs28Css1kXCLHG49sms8m/73P2DUboAACkn6lqxB8uxDZtcP/Wl8KDtvd/Gfd7IrElsuIMs8m6tix9ou+YUgdc3ex6V/QPz4TttraXHB1Lf/Vgafgcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765081745; c=relaxed/simple;
	bh=eFje0BYZc36c7GlxVwvHcOD5WpJMi+Oo3iQMgT02PVs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gDCWySc6KTVhF0i5Wm5qk5iSXuWqhHKk+PXHqSGllEfT3LQRdnMyiwEFx3Ol0oXB5k4GnhrGtDtMSc3YauHtCE7f1v0y0bQcuTHcFku05XHAfsqzl5qbRJQMfKkbwZkpZqj2CGlfsIn7dEl+a24TF/QsVL4pXr83Z4dKNwi+HYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-657486eb435so4012405eaf.1
        for <linux-rdma@vger.kernel.org>; Sat, 06 Dec 2025 20:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765081743; x=1765686543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JUNWBhctNH94PHBLcTezwPnZsKvlmgikXPpcfVicFU4=;
        b=JbohwjKEvoWzePqJqD1POTmzfnlhyEI6PIR+HLls1gFHeNi5nTe9s7KC9+6UXcGN8E
         FTQeO5vLPyHt+jKWW0snG/ck8ZN2pg55y7HHURq/i9DUhiGoRnD6awZf/rd18m6sj/aj
         OhG4QXYj7gi7dqljF2+pIO+n+0hQWxWC9VhaYhskCWQPaL6Yt4AjE9XE6r6hu11qFKEI
         wcVsUn/ZQYaZuE5Y4l89vpw8o9RwkPNO4/WjM3XJr+kNMPy+OzofeO2TDz/kg18Boclb
         fxJj5QSDLUjAq5B3jw36NMTuTaoB1SPI7wbqG5TndTkw8CPwvvYxfYv1JMb7zPHA0zhV
         BIlw==
X-Forwarded-Encrypted: i=1; AJvYcCX3NT1/UJCtkFCLgKatGiYFdgpwI8c3bKWbnldr7H9RUCaTMJ7Z+tKVVC307895yaYubZ0IAZnNGfwK@vger.kernel.org
X-Gm-Message-State: AOJu0YxMHXQtvIq6A4RD4WDJrtgcdrb4CJDvQanSNX8GwxtGUtVGNNLA
	WmXHNvf8lFc8Q111gY4NQ30c3OPN4ApEHjgkJ0i+Pk8g7jfpDs5bCk9u6TnEtl13pwbTYhj2Axz
	0SLSBuyP+LUhSVR/e5XEi7WPGR96IBKey41zUAC6g6wmrYON2bK/M/IN1eFc=
X-Google-Smtp-Source: AGHT+IHSeHYCjH1WF30LC4vlZ9tiWk2MUfW3UKXh1nskP+uvymmYU7oe3qVXmpZw1STQmVgtt4N2m3Kw9QoZWaaBCcXocytzU+OS
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:80b:b0:659:9a49:8f33 with SMTP id
 006d021491bc7-6599a973dc8mr1988629eaf.68.1765081742693; Sat, 06 Dec 2025
 20:29:02 -0800 (PST)
Date: Sat, 06 Dec 2025 20:29:02 -0800
In-Reply-To: <000000000000fabef5061f429db7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6935028e.a70a0220.38f243.0041.GAE@google.com>
Subject: Re: [syzbot] [smc?] general protection fault in smc_diag_dump_proto
From: syzbot <syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, aha310510@gmail.com, alibuda@linux.alibaba.com, 
	davem@davemloft.net, dust.li@linux.alibaba.com, edumazet@google.com, 
	gbayer@linux.ibm.com, guwen@linux.alibaba.com, horms@kernel.org, 
	jaka@linux.ibm.com, julianr@linux.ibm.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, lizhi.xu@windriver.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sidraya@linux.ibm.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com, wintera@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit d324a2ca3f8efd57f5839aa2690554a5cbb3586f
Author: Alexandra Winter <wintera@linux.ibm.com>
Date:   Thu Sep 18 11:04:50 2025 +0000

    dibs: Register smc as dibs_client

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16d64eb4580000
start commit:   dbb9a7ef3478 net: fjes: use ethtool string helpers
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9d1c42858837b59
dashboard link: https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178f0d5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10906b40580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: dibs: Register smc as dibs_client

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

