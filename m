Return-Path: <linux-rdma+bounces-18821-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNr1Fo8sy2n8EQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18821-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 04:08:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CBE363460
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 04:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B49C83018F02
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 02:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C31836681B;
	Tue, 31 Mar 2026 02:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLh6tvlv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF55A364930;
	Tue, 31 Mar 2026 02:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774922890; cv=none; b=ciuwcchhZOhevK/TgEgapeaAREnxnVY52aHvh/rt5OXeWu5z0FhB4ynFeYuEuDmDIFyC5PTrBElL4L0qUr8OGkLFYAkTIjX+1kCu+CPj8q4c4ZXgzrWFPe+RT7T7CPc5xE5LxINOzmnFuUCstr9wK0i7dqgPXL/6Ie3B+LG8arw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774922890; c=relaxed/simple;
	bh=jDFlpr+6/4jIivPkrjpKtCcAqx2kOVDbPkhzYMq73PE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USeeg3u1E5Zepxvy/nh44FJl20p5aY3Mhdpq1J2P036ICmqB2Dw2SqxvvPGSDCC/hIqQ4AWHxFBaJEbREFqcMMDKdujsMWYtelYWAnIZYRkB/Pai2DyPuG+HmejHxdIhKCrDnrk4h4mX5SyjvuSWqH2bi1nYXJQW35oqK5ButMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLh6tvlv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDCCC4CEF7;
	Tue, 31 Mar 2026 02:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774922890;
	bh=jDFlpr+6/4jIivPkrjpKtCcAqx2kOVDbPkhzYMq73PE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dLh6tvlvSB/3cWNTAzkpl6luGHm4IglfcTGHxCRNMHEcb0RZaoydhTudMSrsNQg/I
	 cH/XUSf+j4gfYtzVoqjbIlQu5NxG8K6sMddXG0RKhtoP7CvAWSP3CHEVlWz6HhO3Rn
	 9XI96zMK0CCUd/QXviCBmyC//JXcZqtxa6hwdM5puEWQSSjAdfmn7SV8i92Z0ibYci
	 Qf3zsi0p+f3zovxsmKyIWh2Q7oKNKVs8ecko/L6lRs++Agx7+eGdS87q7YP8Uk/M3+
	 LsOUKBxJ2WyRNvRUhILHpacMR98OFsPAcwYcSgSOZcQjy4y7epK9fPpTW/JvWRvoJk
	 y4l0DuKuku9Rg==
From: Jakub Kicinski <kuba@kernel.org>
To: tariqt@nvidia.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	donald.hunter@gmail.com,
	horms@kernel.org,
	jiri@resnulli.us,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	shuah@kernel.org,
	chuck.lever@oracle.com,
	matttbe@kernel.org,
	cjubran@nvidia.com,
	cratiu@nvidia.com,
	dtatulea@nvidia.com,
	jacob.e.keller@intel.com,
	shshitrit@nvidia.com,
	daniel.zahka@gmail.com,
	parav@nvidia.com,
	ajayachandra@nvidia.com,
	kees@kernel.org,
	shayd@nvidia.com,
	danielj@nvidia.com,
	moshe@nvidia.com,
	willemb@google.com,
	dw@davidwei.uk,
	petrm@nvidia.com,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	joe@dama.to,
	razor@blackwall.org,
	vadim.fedorenko@linux.dev,
	mst@redhat.com,
	antonio@openvpn.net,
	allison.henderson@oracle.com,
	minhquangbui99@gmail.com,
	noren@nvidia.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	gal@nvidia.com,
	jiri@nvidia.com
Subject: Re: [PATCH net-next V9 02/14] devlink: Add helpers to lock nested-in instances
Date: Mon, 30 Mar 2026 19:08:06 -0700
Message-ID: <20260331020807.3524811-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326065949.44058-3-tariqt@nvidia.com>
References: <20260326065949.44058-3-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18821-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,davidwei.uk,fomichev.me,iogearbox.net,dama.to,blackwall.org,linux.dev,openvpn.net,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: F0CBE363460
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
devlink: Add helpers to lock nested-in instances

Upcoming code will need to obtain a reference to locked nested-in
devlink instances. Add helpers to lock, obtain an already locked
reference and unlock/unref the nested-in instance.

> diff --git a/net/devlink/core.c b/net/devlink/core.c
> index eeb6a71f5f56e..db11248df7120 100644
> --- a/net/devlink/core.c
> +++ b/net/devlink/core.c

[ ... ]

> +/* Returns the nested in devlink object and validates its lock is held. */
> +struct devlink *devlink_nested_in_get_locked(struct devlink_rel *rel)
> +{
> +	struct devlink *devlink;
> +	unsigned long index;
> +
> +	if (!rel)
> +		return NULL;
> +	index = rel->nested_in.devlink_index;
> +	devlink = xa_find(&devlinks, &index, index, DEVLINK_REGISTERED);
> +	if (devlink)
> +		devl_assert_locked(devlink);

Can this dereference a freed pointer if the lock is not actually held?

xa_find() acquires and releases the RCU read lock internally. When it returns,
the devlink pointer is no longer protected by RCU or a reference count.

If a caller invokes this helper without holding the devlink lock (which is the
exact scenario the assertion is designed to detect), another thread could
concurrently unregister and free the devlink.

If the RCU grace period expires before the assertion executes,
devl_assert_locked() would dereference freed memory. Should the lookup and
assertion be enclosed within an explicit rcu_read_lock() block to safely
assert the lock?

> +	return devlink;
> +}
> +
> +void devlink_nested_in_put_unlock(struct devlink_rel *rel)
> +{
> +	struct devlink *devlink = devlink_nested_in_get_locked(rel);

Could this corrupt the mutex state and cause a refcount underflow?

This helper takes a devlink_rel pointer instead of the devlink pointer
acquired by devlink_nested_in_get_lock(), and performs a secondary global
lookup to find the devlink.

If a caller mistakenly calls this in an error cleanup path where they did not
actually acquire the lock, the global xa_find() will still locate the
registered devlink. This would execute devl_unlock() and devlink_put() on a
devlink the current thread does not own.

Would it be safer for unlock/put helpers to take the exact pointer returned by
the lock/get helper to ensure safe resource cleanup?

> +
> +	if (devlink) {
> +		devl_unlock(devlink);
> +		devlink_put(devlink);
> +	}
> +}
-- 
pw-bot: cr

