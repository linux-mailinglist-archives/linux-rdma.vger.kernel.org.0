Return-Path: <linux-rdma+bounces-15964-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 364vGPbMdWnvIgEAu9opvQ
	(envelope-from <linux-rdma+bounces-15964-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 08:57:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BD37FFEF
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 08:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83D423009532
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 07:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DE92D781B;
	Sun, 25 Jan 2026 07:57:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7931F30A9
	for <linux-rdma@vger.kernel.org>; Sun, 25 Jan 2026 07:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769327854; cv=none; b=qB3Yvj2Wta5O6zxlKHmnnvalCrqrxJCm8VBSUaB0IiLQ5oxDgycmegeiv8NdMisr/89tEN7wDCqU+YrYjrzA6Om3M4XyxCi5vRctnJT0QaDZnkFYsyvOVwW1zPpXYI+PeOKGVG268Z+pR1xzbk22pq1Aqf07+9kpmRrFqNaNVMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769327854; c=relaxed/simple;
	bh=k5vWMqzDsejjcv63QTy2Zq8VK6z9A7Tv0d1Uq91drc8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AyV1WN1hS+syipUDC+WVIjRdb/3ZuRN6eXOIjevO+bJpwv7/2MHQOWGIFboDfzsel8rKFexgKvafMqFWHx2K9zymXdeB7Za3JnAJPDvOe3+ASSw0AzYJpftmCHKTCTWjXxCiliRs+Gj1/6DnJAwoJQElET0os/1nrJUESrs76ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-404201da527so23808651fac.0
        for <linux-rdma@vger.kernel.org>; Sat, 24 Jan 2026 23:57:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769327852; x=1769932652;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rtJhLfUnzi6J3jnmqK0NuAqM/UxTwwDAVkIHbHg0Xr0=;
        b=uXqGRXuhYC2l+dChd5RUY8jLjEfgw8J+U99DW6Exi8tRuloEp1zVN4Din8kI7Ea4Uj
         QDGHkhmFbfA6ljNHit3URcesRRI1k0Ahw9ILlBnfVgIOPr2xpF+kRD6sOMne6h2UNUdB
         afSnyqCl+xtocvq65HfIKRmUXyHBFgsIXHdplc3YTnenRyD8Gl6LrB6zC9CyzfscF6B2
         pgypM0eR9O/oA7EMeOQ9elx73YXZUFT8q7rEsUJ0Euds2p9nP7UtcG3n/o23OguSR74i
         E5OGkuQbtVp66Fmv9To+9yulgcodVYoxTNTyoWCqOkIPOfZ4VunylwboW3/JQ1kjLS2v
         WL5A==
X-Forwarded-Encrypted: i=1; AJvYcCVKKumDcWGKIhh/iiJCsbt02X7f4RwqlGprCt/kQPzTt6ov6yoOMvDAc+GQQT5lgy17WUa4C30PJX97@vger.kernel.org
X-Gm-Message-State: AOJu0YwL+pT4qIHq2QWDjCDZZEiMTKJbRauVfVMdC7YLhZESFhRuYoU7
	1b6S+biRPj39QpNzVP4Af847KRSj8blUkV+N4KfuN4T3n4ILj5vIaiPUn1bccS2YTkzKP5avmT8
	0L1diKwL53asqvVxsLFeip61yHbYV+TqVQN414unl4I4NZfh4h4i6bSpUx4A=
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2918:b0:65b:5553:8e9b with SMTP id
 006d021491bc7-662e0a11b41mr480256eaf.12.1769327852214; Sat, 24 Jan 2026
 23:57:32 -0800 (PST)
Date: Sat, 24 Jan 2026 23:57:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6975ccec.a00a0220.33ccc7.0020.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Jan 2026)
From: syzbot <syzbot+list12251f693120a5961a7f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-15964-lists,linux-rdma=lfdr.de,list12251f693120a5961a7f];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,syzkaller.appspot.com:url,goo.gl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 98BD37FFEF
X-Rspamd-Action: no action

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 68 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 721     Yes   WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<2> 166     No    INFO: task hung in rdma_dev_exit_net (6)
                  https://syzkaller.appspot.com/bug?extid=3658758f38a2f0f062e7
<3> 150     No    INFO: task hung in add_one_compat_dev (3)
                  https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

