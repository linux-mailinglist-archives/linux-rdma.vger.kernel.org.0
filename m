Return-Path: <linux-rdma+bounces-17422-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLd3NDzmpmnjZAAAu9opvQ
	(envelope-from <linux-rdma+bounces-17422-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 14:46:36 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A83A81F0A03
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 14:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F74E315A6A3
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 13:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069C33176EB;
	Tue,  3 Mar 2026 13:38:42 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7838A258EE0;
	Tue,  3 Mar 2026 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545121; cv=none; b=nO92k5fGvC6/j5lm/ldmMl4bkYf9lpHyO2acT15iK8SZKOgSf7De1JnLSxmS3zZNrlCD0kE2n5Y0tIPWwXYX8vTA73TH9JivTzkkgh1KbkwsgZ5/TIUJCg/pYUHJTr+LjioZRKM24Idm7e3rVq5tkct3fQcJJ9vqw523cGJ5Y48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545121; c=relaxed/simple;
	bh=cBm/YkP0Iw5Y97QL0z8W0wPSf1YDplNMn5ShJrbL2K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RVNncu/rFtT2mItwbywbOBtoCIwsmFn05z5M6uMZT6UeWVSebwqUY9zeSut3qdv70RHD6bhTrHCEhUdcAdkZ25SDm0OKRIU1z3jqAwEYBXXq92oOmafsDq04DlGSJn+8w/NukTkSAt9grgVVuBp0QH1j5uFbuvfBDvlFX08aJRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 623DcHlZ042663;
	Tue, 3 Mar 2026 22:38:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 623DcHdX042660
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 3 Mar 2026 22:38:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6014ee8b-382a-4fe8-81de-74a67595f585@I-love.SAKURA.ne.jp>
Date: Tue, 3 Mar 2026 22:38:17 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [rdma?] kernel BUG in ib_device_get_by_index
To: Leon Romanovsky <leon@kernel.org>
Cc: syzbot+53cf317e7803e4ef2f33@syzkaller.appspotmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <69a27146.050a0220.3a55be.002e.GAE@google.com>
 <14d97798-6cfa-4c2a-b1ab-391e4b823b1d@I-love.SAKURA.ne.jp>
 <20260302191705.GR12611@unreal>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260302191705.GR12611@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav402.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Queue-Id: A83A81F0A03
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17422-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	FORGED_SENDER_MAILLIST(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.245];
	TAGGED_RCPT(0.00)[linux-rdma,53cf317e7803e4ef2f33];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,I-love.SAKURA.ne.jp:mid]
X-Rspamd-Action: no action

On 2026/03/03 4:17, Leon Romanovsky wrote:
> On Sat, Feb 28, 2026 at 02:07:46PM +0900, Tetsuo Handa wrote:
>> Hmm, this assertion was wrong because ib_device_get_by_index()
>> might be called before enable_device_and_get() is called.
>>
>> #syz invalid
> 
> I think this is a valid syzkaller report. As you correctly noted, the device
> was inserted into the xarray database in assign_name(), but its refcount was
> only set later in enable_device_and_get().

I was wondering why enable_device_and_get() is using not refcount_add()
but refcount_set(), and I tried
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?id=510cd4b7d46753b4bf0f57004aa7b53b91b2b25a
in case commit 9af0feae8016 ("RDMA/core: Fix stale RoCE GIDs during netdev
events at registration") unexpectedly triggered modification of ->refcount
before refcount_set(&device->refcount, 2) is called.

But I concluded from this syzbot report that the reason enable_device_and_get() is
using refcount_set() is that we cannot use refcount_add() because ->refcount == 0.

Therefore, it is safe to call ib_device_try_get() before enable_device_and_get()
calls refcount_set().

> 
> The proper fix can be something like that:
> 
          down_read(&devices_rwsem);
          device = xa_load(&devices, index);
  -       if (device) {
  +       if (device && xa_get_mark(&devices, index, DEVICE_REGISTERED)) {
                  if (!rdma_dev_access_netns(device, net)) {
                          device = NULL;
                          goto out;
                  }
   
                  if (!ib_device_try_get(device))
                          device = NULL;
          }

Why do you want to make this change? Unless it is unsafe to call
rdma_dev_access_netns() when DEVICE_REGISTERED is not set,
refcount_inc_not_zero() from ib_device_try_get() makes the final
result same (i.e. device == NULL).

Since enable_device_and_get() sets ->refcount immediately before
xa_set_mark() is called, adding xa_get_mark() check does not change
effective behavior.

What I rather worry is that refcount_set() is called too early if
there is an ib_device_try_get() user who expects that
device->ops.enable_driver()/add_client_context()/add_compat_devs()
have already completed when ib_device_try_get() succeeded.


