Return-Path: <linux-rdma+bounces-22446-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pnomD520O2pxbggAu9opvQ
	(envelope-from <linux-rdma+bounces-22446-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 12:42:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0856BD71F
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 12:42:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=TplEoqGE;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22446-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22446-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19D58300698C
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 10:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446B1224AF1;
	Wed, 24 Jun 2026 10:42:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-m21468.qiye.163.com (mail-m21468.qiye.163.com [117.135.214.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B420D1DFDA1
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2026 10:42:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782297749; cv=none; b=mYTyGF6HioVmOb53xLgQMi7goy/vDhpNsZHwVvfd0FVwppjbomkatVGIt3LbSEqc9BfCX6XzB56D/cf5K84VH/fME7xHYHnM38OA3vTfQWEcFEmGr6BpIWC20i3xzulnBclNvmmMIHT5CDwXsEEDckWqqjPHab9mUFot0+8I/+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782297749; c=relaxed/simple;
	bh=H9514nGSNhwuiyLq8W8xnFS2/Eoa3n5BOZ7QZEhq378=;
	h=Content-Type:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:From:Date; b=YFiZp6VWENkkZDqDbakTJQNrnkxNdUjz3bPLnTeql0d/muCLMUR+VixRvxJg4DymUVbRVklIrRI9r5glUlzm03yDu9iwhPcrCdmJw7N4F7pQuZHZJFFSfyyV+5N95zYao6an4WZRpkdDPzzEcI/j8hQhywB/s4KaKoHuSVFC3l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=TplEoqGE; arc=none smtp.client-ip=117.135.214.68
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AIgAEgCHKvkppDB9sUCsTarf.3.1782297429281.Hmail.220255722@seu.edu.cn>
To: XIAO WU  <xiaowu.417@qq.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, 
	"David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, 
	Mahanta Jambigi <mjambigi@linux.ibm.com>, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	Simon Horman <horms@kernel.org>, 
	Karsten Graul <kgraul@linux.ibm.com>, 
	linux-rdma <linux-rdma@vger.kernel.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	"jianhao.xu" <jianhao.xu@seu.edu.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBuZXQgdjJdIG5ldC9zbWM6IGF2b2lkIHJlY3Vyc2l2ZSBza19jYWxsYmFja19sb2NrIGluIGxpc3RlbiBkYXRhX3JlYWR5?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com Sirius_WEB_WIN_1.64.1
In-Reply-To: <tencent_BD4B709F8D16281265EDBC0DC9EFC8758808@qq.com>
References: <20260617152855.1039151-1-runyu.xiao@seu.edu.cn> <20260619054815.176764-1-runyu.xiao@seu.edu.cn> <tencent_BD4B709F8D16281265EDBC0DC9EFC8758808@qq.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 220255722@seu.edu.cn( [223.112.146.162] ) by ajax-webmail ( [127.0.0.1] ) ; Wed, 24 Jun 2026 18:37:09 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Wed, 24 Jun 2026 18:37:09 +0800 (GMT+08:00)
X-HM-Tid: 0a9ef8c1fe0e02f2kunmf02bd3cd3a74
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMTUS6Y2fHkyPT6dc03QDwVaZPGiA09TnwhbhTj
	hLfuFZO94YXwX6xgvkjGVFFRKj5DZd03xfWxKJ5+5n10A36+gYygBUjfIFA2NppH9Q3clqMzZtZS
	/wBzHlz2GYWAOTQREDhQH2k3gw2BUVE1M9Rj0=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTkoaVk8aTk9PSxlOTUtNTFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVU
	pLSEpOT0xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=TplEoqGEnaAu3cY527AA6eQQ+g/Y9YRGy16bvFcwh4XF2JUUVS9ZXO841jY/F7e5cJLjiZBeUoN4pV7fTMLUkXAFlfniqM2VtzvK2UeyQe1X+aRtklPw40tqQnkdpZG+Q7Lx4Hs+lJMBzN66lTAa7m7U2pnAw3nQhia2HHu5P1A=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=H9514nGSNhwuiyLq8W8xnFS2/Eoa3n5BOZ7QZEhq378=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUBJ_EXCESS_BASE64(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xiaowu.417@qq.com,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:kgraul@linux.ibm.com,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[qq.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	HAS_X_PRIO_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22446-lists,linux-rdma=lfdr.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,seu.edu.cn:dkim,seu.edu.cn:mid,seu.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C0856BD71F

SGkgWGlhbywKCiZndDsgdGhlIGVycm9yIHBhdGggaW4gc21jX2xpc3RlbigpIGRvZXMgbm90IHJl
c3RvcmUgaWNza19hZl9vcHMgd2hlbgomZ3Q7IGtlcm5lbF9saXN0ZW4oKSBmYWlscwoKVGhhbmtz
LCB0aGlzIGxvb2tzIGxpa2UgYSByZWFsIGVycm9yLXBhdGggYnVnLiBJIHdpbGwgcHJlcGFyZSBp
dCBhcyBhCnNlcGFyYXRlIGZpeCBmb3Igc21jX2xpc3RlbigpIHJhdGhlciB0aGFuIGZvbGRpbmcg
aXQgaW50byB0aGlzCnNrX2NhbGxiYWNrX2xvY2sgcGF0Y2guCgpSdW55dQoK

