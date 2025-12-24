Return-Path: <linux-rdma+bounces-15206-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 882E8CDB640
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Dec 2025 06:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C0E6301896A
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Dec 2025 05:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AAF230BDF;
	Wed, 24 Dec 2025 05:31:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C476414D29B
	for <linux-rdma@vger.kernel.org>; Wed, 24 Dec 2025 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766554278; cv=none; b=fKuQnk9AjfS+koM+4v0p4FfgTQ/RXyxe/FpGFMx2WmG+OzHVnRxvLrQKnQ+jJDXpZVkdjaCkyxeWPPcDs73zEsWcOBC7yYocnv0lBhCqpsCSrDMU4JdudLHrb94aWK5LMr4wqijzmWZBFQxUvGwjC8zfSgHpXHnYmQCM6ZmBVtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766554278; c=relaxed/simple;
	bh=37sIYS8u/s/9lpeuCt13oTG12xvQtVsaQ9ib495Dg1g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WqTgVdUdm9bWPTCxg4GOesnNHzVg2c/wxRVKf4bB/d3LSBUOc9ZqvGWUBlVkrNY+vGXEYzQGlq2ErRA1W4dk+8utZOrJWsWzn5fXcDvmU0zhKxx29WNPIsCBq8jrb4FRCkWLG6NVmmKG8ngjjeq00pxj6Ocv/naCO+emeDpcHrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6574d564a9eso9559508eaf.2
        for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 21:31:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766554275; x=1767159075;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+0Vv9PyV1hbVw8Ewwa8peIsKxvgAdv61OLdUWn+GYPE=;
        b=eDMiBPr9VT01NJttw097zcsgix9JkQok2Qx237Md5IRhz+uv5iMkIFgwi3ypjrj8sW
         FBEJIwAU12HpFfVk9ysZF6EzMAE7LwIilj+IX7GLEjjg1FNXHPoiK432SCsPYYoKh+LI
         e+TL0R0UL6QeI4Ofi6KO5WGwmEqvWhov9V7drMmLD4vEFqhNnHRYPMxtFJjOYarBnBFp
         UgRXHBa7lDyoUM5m7pSJYL1ig/bIk+m4W8ie2IvsPONNwiBLYYrhvURtViikBhdQJW72
         nwzhw0/zT27Lzc5ucFOR0fPljluAgVgB73fN7wLg0yPOdO1Dyf5ISBwkSyNBIsXpgebS
         VuMw==
X-Forwarded-Encrypted: i=1; AJvYcCVUCflIGmbTqNpbbw++QlV0h0KFDakMHJ6gDRtlN+xBZwh3P+5baJuMi4nTa1teX+vfLB9H9Jjph5NW@vger.kernel.org
X-Gm-Message-State: AOJu0YzaPHcBXA7UJzq77JgZK2/9GiOEy7sD+tOpEitbTAhNKCrjLfxh
	BLcNAvLmb1rFisNS+zr+jjYfxWqi/y4tOYqFouNpBLbcwUHE6+xKRrwjcsOpu2I3efILAvAZkMd
	cIm6f9iFnu5ivyPJYkEJe8/B4eApywwLQl8KMmoDrNTiWeB8AVgf59Jz0g2U=
X-Google-Smtp-Source: AGHT+IHOzqzdA1UYO5GpfV5CjxUfmXGO4D1BNXRuFUGTJLA9LIKeFxBSKDNOdQUa02CYBwk+2zUCpiikydlV/Pkpc71+VN4k07Y4
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:178:b0:65c:fd25:f43c with SMTP id
 006d021491bc7-65d0eaf075emr5637851eaf.69.1766554275713; Tue, 23 Dec 2025
 21:31:15 -0800 (PST)
Date: Tue, 23 Dec 2025 21:31:15 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694b7aa3.050a0220.35954c.0015.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Dec 2025)
From: syzbot <syzbot+listce2b6075813e37320f4c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 66 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1226    No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<2> 653     Yes   WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 140     No    INFO: task hung in rdma_dev_exit_net (6)
                  https://syzkaller.appspot.com/bug?extid=3658758f38a2f0f062e7
<4> 118     No    INFO: task hung in add_one_compat_dev (3)
                  https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
<5> 5       Yes   KASAN: slab-use-after-free Read in ucma_create_uevent
                  https://syzkaller.appspot.com/bug?extid=a6ffe86390c8a6afc818

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

