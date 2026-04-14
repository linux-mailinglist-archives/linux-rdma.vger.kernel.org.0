Return-Path: <linux-rdma+bounces-19333-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MtMHJQc3mmFnAkAu9opvQ
	(envelope-from <linux-rdma+bounces-19333-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 12:53:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC173F8F9E
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 12:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F14843045EEF
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 10:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481A33D646A;
	Tue, 14 Apr 2026 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhrLIiP7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915CC396B98;
	Tue, 14 Apr 2026 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776163625; cv=none; b=No6N9K3XZ3zX8NNfzt4Vognzb82vl4sP/vVpMQogxO5Ks+vAatFLycnfFl4875He8Cw6pN9r9/oqh7MnAtkBfuKH1z5jF0auKQdSCBLAmODSSvLVBrpLRx/J0k/yuDvMzjVB2v4EeUilsm7KlFDoJenojMb9jW27YgBTGt1O7S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776163625; c=relaxed/simple;
	bh=n9ct7ScsO07xA8DCNZjaYpaEG49x02N8cAQdoUQFVvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPsHI5uhlnoq7D+ai1IhtOrsVV5aCjNAqV+WjKemp3NF0TNn2K5gJWcHJubnpnThP7RzyV8NW0tGPqH67izDC17wpqKntSmjPRTI/OO02yHq7I60w2Yk263LeuM2y5u2A/wkKwD9aD7e+DEBbVL98jJCWxLDgA2lmQL7fKwxV1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhrLIiP7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D5AC19425;
	Tue, 14 Apr 2026 10:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776163625;
	bh=n9ct7ScsO07xA8DCNZjaYpaEG49x02N8cAQdoUQFVvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RhrLIiP7sSz4GKbsKQPvWBGl3joH+Mk7pakrFmbjX0aKPTQWye1YYpgKTmOnJ38Uw
	 gbIQuVrKcOP7tBWqwGnQGz4bOT4SdeBsuQVlb28Oxg3fGngxVGAMgjpEE65YDJ4S7Q
	 +9sOhYbW/azERbzv8rPNyGuaBqnVmPH2GB4mJm08gFZmN1H8ExyyZJGuK8S9AfN0Wm
	 BZJ0ULLFHEJgrxygSmxe6H3Nd+lHsaNVQfuPlvVq8ResmL6SZmC9ekVTw8ED6UPCuO
	 qwuLOtLM/YEdcyBxLvWt2Okm65yyWAvjLfBcAjZ0yfP71HdBnbzMzNkHNDmP3pXPf3
	 OkIIkRtbpfB/Q==
Date: Tue, 14 Apr 2026 13:47:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jiri Pirko <jiri@nvidia.com>,
	syzbot <syzbot+03393ff6c35fd2cc43de@syzkaller.appspotmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [rdma?] WARNING in ib_dealloc_device
Message-ID: <20260414104701.GB361495@unreal>
References: <69dc3310.a00a0220.475f0.0018.GAE@google.com>
 <20260413154353.GK21470@unreal>
 <PH7PR12MB66356E0176748BFFF081D9B4B0242@PH7PR12MB6635.namprd12.prod.outlook.com>
 <20260413174228.GQ3694781@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413174228.GQ3694781@ziepe.ca>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19333-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,03393ff6c35fd2cc43de];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 8DC173F8F9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 02:42:28PM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 13, 2026 at 04:12:09PM +0000, Jiri Pirko wrote:
> >    Will check it tmrw
> 
> I fed it to Claude and after 40 mins it is stumped too.. It should not
> be possible for this to happen.

Interesting, I used Chris's prompts for this debug and got the following
suggestions (CONFIG_PREEMPT_RT=y in this .config):

------------------------------------------------------------------------
REMAINING HYPOTHESES
------------------------------------------------------------------------

1. PREEMPT_RT rwsem behavior (most likely for syzkaller SOFTLOCKUP trigger):
   Under PREEMPT_RT, down_write/down_read use rt_mutex internally. Priority
   inheritance and preemption semantics differ from non-RT. There may be a
   window in the rwsem downgrade path inside enable_device_and_get (which
   downgrades from WRITE to READ after setting DEVICE_REGISTERED) that allows
   a concurrent disable_device to observe an inconsistent state.

   Specifically: enable_device_and_get does:
     down_write(devices_rwsem)
     xa_set_mark(DEVICE_REGISTERED)
     downgrade_write(devices_rwsem)  [WRITE -> READ]
     add_compat_devs()
     up_read(devices_rwsem)

   Under PREEMPT_RT, could disable_device acquire WRITE between the xa_set_mark
   and downgrade_write? If so, it would clear DEVICE_REGISTERED while
   add_compat_devs is about to run (but hasn't yet seen the mark cleared).

2. xa_for_each skipping entries during concurrent xa_erase restructuring:
   If rdma_dev_exit_net's remove_one_compat_dev erases an entry concurrently
   with remove_compat_devs iterating, xas_shrink (called inside xa_erase) could
   restructure the xarray tree. If xa_find_after then traverses a restructured
   tree and skips a subsequent entry, that entry remains in compat_devs.

   This is subtle: xa_erase takes the xarray spinlock (or rt_mutex), but
   xa_for_each calls xa_find_after under RCU. The RCU read side might see a
   partially-restructured tree that looks different from the spinlock-visible
   view. Under PREEMPT_RT, RCU critical sections can be longer.

3. rdma_compatdev_set (ib_devices_shared_netns sysctl) race:
   add_all_compat_devs() is guarded by DEVICE_REGISTERED + devices_rwsem, so
   the same analysis as T3a applies and the race is eliminated. However, if
   there is a remove_all_compat_devs() implementation, its interaction with
   the unregistration flow deserves verification.

------------------------------------------------------------------------
RECOMMENDED NEXT STEPS
------------------------------------------------------------------------

1. Add WARN_ON with stack trace inside add_one_compat_dev (compat_devs_mutex
   held) that fires if DEVICE_REGISTERED is not set. If this never fires, the
   insertion is always properly gated. If it fires, the unmarked insertion path
   is identified.

2. Add ftrace or kprobe on remove_compat_devs and add_one_compat_dev to
   capture the exact sequence of events. The key question: does any
   add_one_compat_dev call happen AFTER remove_compat_devs for the same device?

3. Check whether the bug exists on non-PREEMPT_RT kernels. If only PREEMPT_RT
   is affected, hypothesis 1 (rwsem downgrade race) or hypothesis 2 (RCU/xarray
   interaction) is more likely.

4. Look at the kernel version of the syzkaller report. Check git log for any
   changes to drivers/infiniband/core/device.c around the report date that may
   have introduced or fixed the issue.

5. Investigate enable_device_and_get's downgrade_write() path -- specifically
   whether a concurrent disable_device can observe DEVICE_REGISTERED set between
   xa_set_mark and the downgrade, then fail to clear it before add_compat_devs runs.

------------------------------------------------------------------------

