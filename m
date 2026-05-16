Return-Path: <linux-rdma+bounces-20797-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA9SGHEWCGorYwMAu9opvQ
	(envelope-from <linux-rdma+bounces-20797-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 09:02:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CC355A8B6
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 09:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9D2D3006D7D
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 07:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C95F30568D;
	Sat, 16 May 2026 07:02:03 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CEB632
	for <linux-rdma@vger.kernel.org>; Sat, 16 May 2026 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778914923; cv=none; b=lNfLzDdyvlWGmK8Bac0JiFjzhIN3t7X7hxJBIv45CGmzv5luTnLVY7A1aaIwM4NLNnzOAG2gzdwmAosGDN3Q4Zemp10AuUbVvwPS0V7FX4mZFW+fW9Por5D88JM5FcFj+YtsqC/+xcQxBc4cyy8yuI6CjW0BLC99Q1EyqFdPvN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778914923; c=relaxed/simple;
	bh=Ho6piJ/gm3gK9gM2XT0JsD8hlZ2ZA+Gfocwk5xOK9Qc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HroHg3eC0YIRsXPu0Hn5JcWWbdUBKRW1aGSqLXSN5w1tp+j6abVcJZBGdyCHOaTf4r0T2zJSM7wSo+bkAB1n7GH4roVAiCuiUSQubhWENcuE0/PKiBUVDwTrG2SNOs6fj6QS58BvCRZNC691RcsjrHeqTTBiFmjwEnLd5ubeJK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e54519e2e0so1777586a34.0
        for <linux-rdma@vger.kernel.org>; Sat, 16 May 2026 00:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778914921; x=1779519721;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGYAY586adhJBQi99xwORuBeXunQTFFsqPhqsTYWim8=;
        b=b6QCvDb2Ij0ZwnSgg56bSuiB9CuyLqHT0EetEf8/KACXf55DRaWn2HiSKU8ZHLi9eF
         MP3VKsx2yZoePRSzdP/xNc6Y293pHiY5VAmvdgfYG/mha2YxbW1gZJ080snYRFF11+To
         XBef7Ta5T+dpLk1xwzNdJxhf+hI8NHWEdj6xWW1tG8fq0yqn05un9JOYylHWmzjmqakr
         5Gzp67t9efyqV/cPVRyqbd2oznRJuakrTfXHiRKURO4TBCJBnzcgRjuaPp+ComugwucU
         W9hhZrfhR4ECHdDXRQcJhR2uuZzozUf/WP0V6DwJcYW3puf9GsNazfHHKKTltKNdYkr+
         BWXA==
X-Forwarded-Encrypted: i=1; AFNElJ+lhfD4xc737LTHELHaq3l8vN3fYc8d8zG1SN+HdLxf4LmXK8u59CAmpmlKm/nIT9Ql60S+C5NCuGAZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxdCgAc2Ji2sHXJ660cVGuE0z8FA8YBVK9Wv/yJ374FFz4B40QU
	XhDw8rZ/+YaJk0KFwn8pCs61MTzJ3uBaUc2fO0T79RGiRtVJr+05c1d/Mk1j4zqVA2QAAl3IEYM
	sqzcIPFXJgajH3TT5OxSMoIyXcBLr6Rq3LnKZkUwTuwS34yzHMv76ppvekPA=
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:190a:b0:696:6f1f:3ee6 with SMTP id
 006d021491bc7-69c9bfe8963mr4626966eaf.53.1778914921213; Sat, 16 May 2026
 00:02:01 -0700 (PDT)
Date: Sat, 16 May 2026 00:02:01 -0700
In-Reply-To: <529b2910-24cd-45e0-9e98-0eb3085a6bc1@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a081669.050a0220.f80e4.0002.GAE@google.com>
Subject: Re: [syzbot] [rdma] general protection fault in kernel_sock_shutdown (4)
From: syzbot <syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, arjan@linux.intel.com, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, hdanton@sina.com, horms@kernel.org, 
	jgg@ziepe.ca, kuba@kernel.org, kuni1840@gmail.com, kuniyu@google.com, 
	leon@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	yanjun.zhu@linux.dev, zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 65CC355A8B6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=eeba87c808be946b];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20797-lists,linux-rdma=lfdr.de,d8f76778263ab65c2b21];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,linux.intel.com,davemloft.net,kernel.org,google.com,sina.com,ziepe.ca,gmail.com,vger.kernel.org,redhat.com,googlegroups.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
lost connection to test machine



Tested on:

commit:         bb9ed28b RDMA/rxe: Fix null-ptr-deref in kernel_sock_s..
git tree:       https://github.com/zhuyj/linux null-ptr-deref_kernel_sock_shutdown
console output: https://syzkaller.appspot.com/x/log.txt?x=16617cc8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eeba87c808be946b
dashboard link: https://syzkaller.appspot.com/bug?extid=d8f76778263ab65c2b21
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Note: no patches were applied.

