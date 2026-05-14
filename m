Return-Path: <linux-rdma+bounces-20703-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBQHCfnuBWpWdgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20703-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 17:49:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA34654440C
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 17:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8AD530534D7
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 15:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB2B2C3268;
	Thu, 14 May 2026 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Gge5iAVQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94573090D7;
	Thu, 14 May 2026 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778773715; cv=none; b=D7rcJL6xgjJPWu2fmZHZ+4HEZMqNtt5EKLFRnXPQUcU+UCT0SbEa9Wh4V3ckmMGfOUpS4mVu+t0j56gbeiolDiJOS0xGpNOEpnRkHPpN8QDzvQ4ogITrdgYV/ghLxLY947wHmI1+xV59JMxt/RRxxmc3477wjsRQCwvd2zXO+hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778773715; c=relaxed/simple;
	bh=23Y3629JSdEQ48nstGuML13Om1OZG3R1qIfmIRU3RrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqXfO15OByUTGlXZi/QNf2xwhKizB5wojQUjkvt0urHDgnRxuE+sPhkEqy5CiibpL4G4XlHnOxIjOAjdOr+3xVSN1CWx8byfc7hL8DQ7VNvDdqkMHcoMqeoOqyQxGpKM+Vd6Zd79+FxEl9dSRF1OKoG9vx9EZB7CkTEzLGfIoWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Gge5iAVQ; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=PeqDcMV0a947KRRCLlzeVviDR+jdI93Fkb47jTMUgeA=;
	b=Gge5iAVQvCEnCeDXs9jkwTc+4hzg742EX8wSnOS97Uz+7CkrRzxpEwmnxZ+pS6
	Z3DzSbciJREdSadYhSXTht+Lz9onidmYvQT5hK449mCERhlHIct77UmOSyuMXFQ8
	31OlXAkiqrfs3L3UsH9dr4jcLh/amjer/uYvWqK9OPJLo=
Received: from [IPV6:2601:647:6300:a030:d09:4215:2d93:9875] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3PxY47gVq6khdBQ--.36545S2;
	Thu, 14 May 2026 23:46:06 +0800 (CST)
Message-ID: <da3e46ad-a713-4d02-8ca2-fa402e236597@163.com>
Date: Thu, 14 May 2026 08:46:00 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/nldev: add mutual exclusion in nldev_dellink()
To: David Ahern <dsahern@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Edward Adam Davis <eadavis@qq.com>, akpm@linux-foundation.org,
 arjan@linux.intel.com, davem@davemloft.net, edumazet@google.com,
 hdanton@sina.com, horms@kernel.org, kuba@kernel.org, kuniyu@google.com,
 leon@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com,
 syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, zyjzyj2000@gmail.com
References: <20260513234655.GW7702@ziepe.ca>
 <tencent_3CCD70788A6EAC2D356D4C9674E8D2EEEA0A@qq.com>
 <20260514115048.GX7702@ziepe.ca>
 <139794f1-80b8-49d9-829a-0629379def51@kernel.org>
 <20260514141409.GA7702@ziepe.ca>
 <200b3923-d794-4779-8f90-a8b858861d4c@kernel.org>
From: Zhu Yanjun <mounter625@163.com>
In-Reply-To: <200b3923-d794-4779-8f90-a8b858861d4c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3PxY47gVq6khdBQ--.36545S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr18uryxZw45Cr4rJr1rCrg_yoW3Awc_ur
	4Dur92kr10qF4xZa1xJF1xZrsYgr4UWr1UAws5Xr13J34DAwsIqrsakryrZw48ZF47KFy7
	GF1Syw1Yq3W2kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1TKZtUUUUU==
X-CM-SenderInfo: hprx03thuwjki6rwjhhfrp/xtbCzR+m3moF7j81LAAA3N
X-Rspamd-Queue-Id: BA34654440C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20703-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[163.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mounter625@163.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[qq.com,linux-foundation.org,linux.intel.com,davemloft.net,google.com,sina.com,kernel.org,vger.kernel.org,redhat.com,syzkaller.appspotmail.com,googlegroups.com,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


在 2026/5/14 7:26, David Ahern 写道:
> On 5/14/26 8:14 AM, Jason Gunthorpe wrote:
>> Edward, please come with a fixup on top of this since it was already
>> applied
>>
> Zhu Yanjun: As author of the patch that introduced the bug and
> maintainer of the rxe code, why have you not addressed this problem? It
> has been well known for many weeks now and multiple people have
I am aware of the issue and have been following the discussion and 
proposed fixes.

I did not want to rush a change without fully understanding the 
implications on RXE

behavior and existing users. I am currently reviewing the proposed 
approaches and

working on a proper fix.

I appreciate everyone who helped investigate and test the issue.

Zhu Yanjun


> attempted fixes. Seems like you need to step up and take care of it.
>


