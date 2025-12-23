Return-Path: <linux-rdma+bounces-15179-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B744CD86B3
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 09:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4A21301F5EC
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 08:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7C1305943;
	Tue, 23 Dec 2025 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dAMUbkl3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166A521ADCB;
	Tue, 23 Dec 2025 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766476841; cv=none; b=CfgkclQ1PKoYOhnpLu7zyZR2MRgiVCA+yE09qD54JsWTxuXNPdgto/xfmg/ehGC78k77nyxvpHevDbksDOHGc2DinTBwkAeKBw8B9N2ZM4P/PAhfIVrNKPKfhIEI4ggg5+VW4Vl2hY74/0o3FmxNk3ZVUagUuamW8sGx34rIboI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766476841; c=relaxed/simple;
	bh=1D5pNj/TkMBhi5V3Ck3ECaJCkWlEDv2CKJGPHJjgyrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UD5DlH71ZiMXQ59b1vEQ0c9LZtu5/mbwSEd74qKD6OLE6Z0i0zEmGpdh0og3BfWV6Ms562w8ZdgMY6GLkdwLlgMAT0mjGCM6IQuowxfU5i3fvRaptGw866lQdVjCu1nukMM1aUq0zmEn5ILphM3MLgYG/oA/l2W/DLXqv5Ps/e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dAMUbkl3; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766476833; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=IKcBNqtAnVdReDXaI7KKxldVsvfTjEsR07PqZbBV0cE=;
	b=dAMUbkl3e64kVnUKil2FvVKzYHXmI2Hq06TdoorMUB+Af6RMpqDykbwpapBG1iYG9abufs3BEM/Jh0WmyjJbokMxg7HfF+A1YtfMrO6CMyJnJjrCfNMTnH+jcIKnbMTYrcjDRBgCuIkqz0CfqqgvkeWj7UNnsiZSX7SZAQYYAZQ=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WvX26rM_1766476831 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 16:00:32 +0800
Date: Tue, 23 Dec 2025 16:00:31 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Wang Liang <wangliang74@huawei.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	Aswin Karuvally <aswin@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-rdma@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net/smc: Initialize smc hashtables before
 registering users
Message-ID: <aUpMH7_lHm1pFXcZ@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20251217114819.2725882-1-wintera@linux.ibm.com>
 <aULLcudhF10_sZO6@linux.alibaba.com>
 <64405058-23a9-49df-aed0-891fa0a19fbb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64405058-23a9-49df-aed0-891fa0a19fbb@linux.ibm.com>

On 2025-12-22 10:50:37, Alexandra Winter wrote:
>
>
>On 17.12.25 16:25, Dust Li wrote:
>> On 2025-12-17 12:48:19, Alexandra Winter wrote:
>>> During initialisation of the SMC module initialize smc_v4/6_hashinfo before
>>> calling smc_nl_init(), proto_register() or sock_register(), to avoid a race
>>> that can cause use of an uninitialised pointer in case an smc protocol is
>>> called before the module is done initialising.
>>>
>>> syzbot report:
>>> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>>> Call Trace:
>>> <TASK>
>>> smc_diag_dump+0x59/0xa0 net/smc/smc_diag.c:236
>>> netlink_dump+0x647/0xd80 net/netlink/af_netlink.c:2325
>>> __netlink_dump_start+0x59f/0x780 net/netlink/af_netlink.c:2440
>>> netlink_dump_start include/linux/netlink.h:339 [inline]
>>> smc_diag_handler_dump+0x1ab/0x250 net/smc/smc_diag.c:251
>>> sock_diag_rcv_msg+0x3dc/0x5f0
>>> netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
>>> netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>>> netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
>>> netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
>> 
>> I don't think this is related to smc_nl_init().
>> 
>> Here the calltrace is smc_diag_dump(), which was registered in
>> sock_diag_register(&smc_diag_handler).
>> 
>> But smc_nl_init() is registering the general netlink in SMC,
>> which is unrelated to smc_diag_dump().
>
>
>I had assumed some dependency between the smc netlink diag socket and smc_nl_init()
>and wrongly assumed that the smc_diag_init() and smc_init() could race.
>I now understand that modprobe will ensure smc_diag_init() is called before smc_init(),
>so you are right: this patch is indeed NOT a fix for this sysbot report [1]
>
>
>> I think the root cause should be related to the initializing between
>> smc_diag.ko and smc_v4/6_hashinfo.ht.
>
>Given modprobe initializes the modules sequentially, I do not see how these could race.
>
>I guess this syszbot report was fixed by
>f584239a9ed2 ("net/smc: fix general protection fault in __smc_diag_dump")
>as reported in [2] .
>
>I'm not sure about the correct procedure, if nobody recommends a better action, I'll send a
>
>#syz dup: general protection fault in __smc_diag_dump
>to
>syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com
>(this one: general protection fault in smc_diag_dump_proto [1])
>
>
>I still think initializing the hashtables before smc_nl_init()
>makes sense. I'll resend this patch without mentioning syzbot.

Agree.

Best regards,
Dust

