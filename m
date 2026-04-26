Return-Path: <linux-rdma+bounces-19568-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FQUIyRA7mnqrgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19568-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 18:41:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E931846A9A1
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 18:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AA4B3010394
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 16:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC4227281E;
	Sun, 26 Apr 2026 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OExLVape"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698972701B8
	for <linux-rdma@vger.kernel.org>; Sun, 26 Apr 2026 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777221646; cv=none; b=PMxKjWlqXoAFsm67JTauCd0LCta1I+etX/epWMUlsk8wO+P4MK/4RJptCYLbqL40wxkMbcpmpyDh0KaKhJILoXFLqP53rbFv8prCps+r5DHIp64dzN2jA5RZmHXZerb6Ks9JUETMxMXbTPo7kGryaXk71WYotSilB0IrsqUrTQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777221646; c=relaxed/simple;
	bh=kfHFgoDfZuhgxbgu5LOq7FE9jwdZtT+adRDX3xF07rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rE5hesW9MjLaGHCncSWCsNe+CfqMoRVmj8zSsK/+pu9uyiE5940AOnjND2yGURp1juq6uBl9GwGbh2oNaUVI/ZCYOTiclIFwALNMpjZcaIlnmsqUqsXL8fy5wPYphLdX1CjchKBmoyI+RKekHoSZF5Aia0hd0TugjdkRGuPWf8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OExLVape; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D62C2BCAF;
	Sun, 26 Apr 2026 16:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777221646;
	bh=kfHFgoDfZuhgxbgu5LOq7FE9jwdZtT+adRDX3xF07rs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OExLVapeVs0NWqnh7GoC28YF57JEe/4a+TG2GJvrSOpN8qP7p4ezAIdxiJKnKlfBb
	 IIdJLkD/+gBjE4hnO2yqHGMKG9SMHM54iFicIbx4gl6j9AYJTK1CsgaaT35CjaXG9C
	 YjGqB6DhKmN5J4SPiePkbxGXkThzSa6iPPuu7z+p45HQiSQg/zuIY50ng/CKbLwuLZ
	 MEWi9CpGAvrmpR3n1IeJkk4lG9jl/ocfPY3rqOPN7v5zk34C20wqROwnvCIV71e+tP
	 CkXq4BcvWmLFUn8RjlQbD5SobgZJE3wwGeraxCmq5+zwYIsIJpGUelpJ+bN9pGXODo
	 Kdv0Mt/Lh9p7g==
Message-ID: <3330d8e3-b93f-4e4b-8d27-68c24ea5d619@kernel.org>
Date: Sun, 26 Apr 2026 10:40:45 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Fix null-ptr-deref in
 kernel_sock_shutdown().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 linux-rdma@vger.kernel.org,
 syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
References: <20260425060436.2316620-1-kuniyu@google.com>
 <20260425060436.2316620-2-kuniyu@google.com>
 <35659770-6046-45c3-8714-c6d5bb140978@kernel.org>
 <CAAVpQUCrUkng8fDQYRT0c37gvUw8HiD7Lkowv_pk9cYrG7YdQQ@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAAVpQUCrUkng8fDQYRT0c37gvUw8HiD7Lkowv_pk9cYrG7YdQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E931846A9A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-19568-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/25/26 2:55 PM, Kuniyuki Iwashima wrote:
> On Sat, Apr 25, 2026 at 8:47 AM David Ahern <dsahern@kernel.org> wrote:
>>
>> On 4/25/26 12:04 AM, Kuniyuki Iwashima wrote:
>>> syzbot reported null-ptr-deref in kernel_sock_shutdown(). [0]
>>>
>>> The problem is ->newlink() and ->dellink() can be called
>>> concurrently with no synchronisation, leading sk leak or
>>> double free, etc.
>>
>> My expectation is that the synchronization is managed by:
>>
>> rdma_nl_rcv_msg()
>>     down_read(&rdma_nl_types[index].sem);
>>
>> as the RTNL equivalent.
> 
> but down_read() is a shared lock and does not work as
> per-netns exclusive locking.

Well, that's a face palm moment for me; skimmed that code a bit too
quickly when reviewing the rxe patches.


