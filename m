Return-Path: <linux-rdma+bounces-20805-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PJopFGsgCWoxKQQAu9opvQ
	(envelope-from <linux-rdma+bounces-20805-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 03:56:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8E955EFB4
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 03:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6FB3301230B
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 01:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C0930DECC;
	Sun, 17 May 2026 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="TqY2do2I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB84B304BDC;
	Sun, 17 May 2026 01:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778983014; cv=none; b=DOrP0qxfQmRRtlZ3rDRA6CSwYTcMapikSdmYNHF02EfGTUE9TnnrOboScjnMSZHbgbyI/iRxWj0E4UpRPW2Nm/XPDTxmLH1JLraXpYlAVSmbxAicg7B6AoIZ/fqv6/5jN8URbCYAa7i5RQkdjDMJVsJ2mQTt8O71RNqH5ecUGQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778983014; c=relaxed/simple;
	bh=j8yNFT2pyN7PKfJdjajCHX6YnqbqBbNDXvF4eqeAi3A=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ufc/1ePizKNe+btHE4vh1GP3EqconibBeoynet8y3/S0ISKCG/IyaRm0jKVRqGHa5HRfmoVhxNdR9iy8vR2JiUjt7X8jHZIOX+ettWkeEeRGzBiVfp0hMcI7Hc/PYKNsn7oUmXm8+G95pc21NZjoMFa3JgFBAGVqOZ1MRHd62bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=TqY2do2I; arc=none smtp.client-ip=43.163.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1778983003; bh=YFUv/t52FNmbmkXfu9wUH2d6HOxb5kR2KvDRi78Vweo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TqY2do2IlHpDm3LUWQyQerd3S2gJt94GWYB8+XobXoDSguoJtKfnjcbuaWWDpkcnB
	 C142kSGPcvTbG6QQkNzi0S+HLjKL2rl7vCaS8FPBrzSXgl+6fapbySVrXpGTO4FdSD
	 CErTGbSP4LwYwQNc+UKwTy/4nRCHSz1cBDBvudkE=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id E26A5044; Sun, 17 May 2026 09:56:38 +0800
X-QQ-mid: xmsmtpt1778982998tdmecxlu7
Message-ID: <tencent_CB6ED10C8727C8C6EA12DFC65609BA2EFB06@qq.com>
X-QQ-XMAILINFO: MKUhwZFKNyqxUTdyqgCzpCFMgQ6/Vr/TahxpUcfr/sRJHdqFTT6X7RzpkFbsWI
	 tgKOUr9q9hmpaEerrEAXX7+AXj0tKpO1pU2axb08GioSsbcxHiYBXusQ+nOJ6cLUKSOfGm3vdGq6
	 5cb+T99xOo6gK+F93LbXK4jppBUyWrcGbwrhhzL8yVT+9HIVEcr+yPa9G6XhRo7xf/fF1njmE3sG
	 ekSs9lAudvXRZGUOZrU8FkTPnJiDo7chkDVTj5bYkCdC+i6PwAnh3VqGLWCus++iOcZbcongIujE
	 4HTm0zX6Un/x8bfqIxwpi5ngiAlaWVhipDAxrrpIG4cRcGzR3yKaD12DPUE0cGmurIVVPO5zwyke
	 1AVT/j29AnyiJrBe7Vh6vurc5THJkf7YFjaKLNIkvDtlQyXpg65lgVc+WLriIiZGP9ezgDsozi9Y
	 yIZd/iztAmeg5f2SL/4tGVFu0yLWnij9eNwKBeT5CqHTUpQQPERcJP4e/ZY2i/hDfe47JYSOXe8M
	 b9X49slafJdGnfcrB9dQz1S2IKbHVvEzBmJc58COfS7MXyUfYea7BUAC/NBmSIeQLfK3mNu1GGCg
	 lS5qBRrZZeurD8D/qf2FJa0ycHIHNw8oS1PiR1PCglE0w+GOtmPVbLqECGctM3JYjJUC+MPhRzj6
	 qw57qj52lGYNYZ2JedTA8TRgFRTDUb0OMaoBFf1nlaicOPoamL5pd3a8XBBAig97og1UD27yimOi
	 SxxZu8KSBVYMWNR1P0g8V/hyqwuT4+MehpmOGdLi9hpP3clH38xl5U1oZz2+flMdJ/saEyDYXq4K
	 aB1XgNmrSWU8wjwcIIZYX0Iy3Qba2bRNndQ3L3jQf5SEhSaQ5g/LBz5x7Y6eGyfdUMwPwJl5GKJj
	 snSOWCytnO2pBOLgq3ZAiH+IcXJV6rO4cIz+ElZE6FlwDp72ojCIH67Uioarj9r6cekzA20QpPhB
	 g2rLw5ciyhKF4FS88JTfKNuM8G22jtL7jq8iYpw6yndhfp7ZxQwu/sJknhVguit/gutOJfudKriZ
	 T8STQJJtvO1zIbkrdb
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Edward Adam Davis <eadavis@qq.com>
To: yanjun.zhu@linux.dev
Cc: akpm@linux-foundation.org,
	arjan@linux.intel.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	eadavis@qq.com,
	edumazet@google.com,
	hdanton@sina.com,
	horms@kernel.org,
	jgg@ziepe.ca,
	kuba@kernel.org,
	kuni1840@gmail.com,
	kuniyu@google.com,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	zyjzyj2000@gmail.com
Subject: Re: [PATCH RDMA v2] RDMA/rxe: add mutual exclusion in rxe_net_del()
Date: Sun, 17 May 2026 09:56:39 +0800
X-OQ-MSGID: <20260517015638.467499-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <13bc2e56-ea61-4cde-896f-c10636b29e9d@linux.dev>
References: <13bc2e56-ea61-4cde-896f-c10636b29e9d@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5B8E955EFB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20805-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.intel.com,davemloft.net,kernel.org,qq.com,google.com,sina.com,ziepe.ca,gmail.com,vger.kernel.org,redhat.com,syzkaller.appspotmail.com,googlegroups.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eadavis@qq.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat, 16 May 2026 16:40:22 -0700, Zhu Yanjun wrote:
> diff --git a/drivers/infiniband/sw/rxe/rxe.c 
> b/drivers/infiniband/sw/rxe/rxe.c
> index b0714f9abe3d..84266dc416c4 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -251,7 +251,9 @@ static int rxe_newlink(const char *ibdev_name, 
> struct net_device *ndev)
> 
>   static int rxe_dellink(struct ib_device *dev)
>   {
> +       rtnl_lock();
>          rxe_net_del(dev);
> +       rtnl_unlock();
> 
>          return 0;
>   }
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c 
> b/drivers/infiniband/sw/rxe/rxe_net.c
> index 50a2cb5405e2..ac53ea73996d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -649,6 +649,8 @@ void rxe_net_del(struct ib_device *dev)
>          struct sock *sk;
>          struct net *net;
> 
> +       ASSERT_RTNL();
> +
>          ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
>          if (!ndev)
>                  return;
Since the solution is the same, and requires no new locks, I favor your
approach.

BR,
Edward


