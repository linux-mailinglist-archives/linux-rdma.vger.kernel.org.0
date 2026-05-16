Return-Path: <linux-rdma+bounces-20795-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ13AG0ECGqRVAMAu9opvQ
	(envelope-from <linux-rdma+bounces-20795-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 07:45:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 538DE55A563
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 07:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5499A301B70C
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 05:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA8231A81C;
	Sat, 16 May 2026 05:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="srMP9lw8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6079731A072
	for <linux-rdma@vger.kernel.org>; Sat, 16 May 2026 05:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778910298; cv=none; b=glMt4A1jC2svwS5VIfOWsAwDnc2R6AaSuOuz7b5OzxLKpk9Oo2RDY+KU5uvkr47/0YGuoEjNUYWkX9924mh9+3Z6qHwcR56k5F1iy5DM1WSJAMRM+jXKHBdWb9vtOjzfYNnBUGB6kSOVDDGuROHTmJznwlQyy/xfT8aV+u4lxBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778910298; c=relaxed/simple;
	bh=RZmU1Jyhfdw1NcV7uReRM2eze91pMMA/MXL/i3uLkfk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=A4Hv2z1QYLNB6IUUUQq2q2w5AA/uSYltYDluwYOmNMSDkGcKHrrUHMCcla0kmxwX+Cj8sgNYEAhTrc+0PSaAISLO7o/ZHBs8Uq+CvBVvt9qd5L33GtlC2DjiUcyT4qzj6mN+mnSoWLaM0yOSXkw98ZTcYNoRvE8y0tI8Z+DiZDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=srMP9lw8; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <529b2910-24cd-45e0-9e98-0eb3085a6bc1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778910284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aAn21pk8QB3pm3LQMI4aJQftIqPiMxwAx6/+gGLWT34=;
	b=srMP9lw8Wx3UL63HPox+b+0p+E3+p1KjGAHvE5V0ubtSkZe0ZYPZ0CxxTTWNxg7B8Frnq7
	b/LKo90yuq3e1U2u2O5yoItV2up2dr/syXRn3OYsZBzOe2fOvtpyxNvrll4nx3pkkIp38s
	QZRhX3ZqpOZzSSRHGHOfqvUlz2hJsj8=
Date: Fri, 15 May 2026 22:44:38 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma] general protection fault in kernel_sock_shutdown
 (4)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: syzbot <syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, arjan@linux.intel.com, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, hdanton@sina.com, horms@kernel.org,
 jgg@ziepe.ca, kuba@kernel.org, kuni1840@gmail.com, kuniyu@google.com,
 leon@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
 zyjzyj2000@gmail.com, "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
References: <69fc0c7c.a00a0220.387fc1.0006.GAE@google.com>
 <871ea091-9328-48f2-a33b-fbf3d23f6742@linux.dev>
In-Reply-To: <871ea091-9328-48f2-a33b-fbf3d23f6742@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 538DE55A563
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20795-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[syzkaller.appspotmail.com,linux-foundation.org,linux.intel.com,davemloft.net,kernel.org,google.com,sina.com,ziepe.ca,gmail.com,vger.kernel.org,redhat.com,googlegroups.com,linux.dev];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

#syz test: https://github.com/zhuyj/linux 
null-ptr-deref_kernel_sock_shutdown

