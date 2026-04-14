Return-Path: <linux-rdma+bounces-19335-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNNzFL4w3mnxogkAu9opvQ
	(envelope-from <linux-rdma+bounces-19335-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 14:19:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A85273F9EF5
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 14:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1229430451E2
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 12:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8233E6383;
	Tue, 14 Apr 2026 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fENkWsfW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7506390C95
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776169097; cv=none; b=l8ki5wR1lOkO2sEr7Uea3XJUEl3lfNzgQwrLmPYEaPlcMgwzjPiK9Ug5v2c6VkDcMhwh4BfUEHkBTnjdajsQZD8syl/QhHl5XxONlmRUT+balvkuoYZlT2x/xn1dH5w1JK2B3zbInfpRTJeuQ7ar6JQIDoBch58cO8ZFwpvI42M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776169097; c=relaxed/simple;
	bh=TMTPOjpMU0GH+PrZFSP3rKyQVVAjWTS5qyahdWFT3mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNn/VF/4HXRHhegnJyle3JZeNrPCmhLHu1YEFuJa1P+Gm5AzkFHky13VSeuPX8zP1+j1EUXPpIgja1iarz3E9qn4sjNymUAu7fqZ8hNz79Y32Q0JwQJ99KfV0eV7gCMz/ArNWWjJCtWtSexeKRqrq8Vt/xqJlt2b9MBP6uzUWDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fENkWsfW; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506362ac5f7so42985551cf.1
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 05:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776169095; x=1776773895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U936AlL2EkStYn6Vl0fAksDLSIrbwVXz8JpMIKb14Sw=;
        b=fENkWsfWLkxJv/VcLYFbX2Lo5bSQ97ttLjEtMoR0McfWE6vi4Cdw12wg55HPwMIjwt
         yAvcurr4p6PCt5p970r9BA0d82L5xjgCANiEdOUnU+hx8907qmVHRdFM9cIXo+5y91HY
         we3VN6lR9JAT7ru1IhcyvUmqz2rkjDdRsu1dNZdgUxD3Q5F7XKTnBVsxwjNS09Zm5h94
         Q6pNdLrwbe/ZHgks8J/aTEH+D+FqhEv75KhMwh0FNE6r/ESjogF4k/YTKQVXiIO9TZKU
         9eH/ZU2zLJNxOK7kPxi3R5UUQGpycSxURPCxsHVHCdWvzgeEr+PjO8oLvttxgX5qMl8p
         LwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776169095; x=1776773895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U936AlL2EkStYn6Vl0fAksDLSIrbwVXz8JpMIKb14Sw=;
        b=d7/+yKsa8bH9ns3izdNPTrvaHcQiI9RRQiTuBwKfO1nq5JI/JDAP3wHbZO+YwdNZl3
         Niaid0V0KztaKfxHGfXeRrQLo+yRN/8GLI+Vq/kaNNxxDLfSXbHl+9BfLfjebRRFnLPq
         LzAC2k3pT9UP4GWgNIKqw/2l+iWKMHXJAm5u2hQJsgZcmWJlYA+s2wea+ieqBFLMBNLa
         hqqRyUlIuxrDDoqC4OVi85rpU+XB9xlaRC8eJPrrktjFTJi0nuy19y7Eu2BFNp7P86Nc
         /zcRzuLB/AsuMfKLbsAGRrdb+qJZFb6j4+/aEki7tpZI0922TwWM25Zhf1UgOQT8+Tbm
         7hOw==
X-Forwarded-Encrypted: i=1; AFNElJ+3bPtJT6WPOs1fztHobUsaYR6DMxD+MwFYZSgJj6GjHcIH182VGjr/+FrcfMB2DGzGJRwDUiEeMVKS@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb+Hz4eNb0dTYDxrvtI3uiclFQ6c284YFw8X4jTSu/3WjhOgTE
	Bdy+qbQ/w7z6ujvfBljigxOsEZudk6vWwy8pvL4hE6o+4LgurikjWIcpqoozdFDjFnU=
X-Gm-Gg: AeBDietywPzz074j2eO+CnoAXSaDRKeRMzZibaGkDtMbzDW9X/4HVeLQ7BQFOce0nSa
	SxBxbiY7nRBzMm/C4jGIp0K5wfyFJfbgxave8eFqZFMmRMtrQ/m3JIqRXts55l6hx3vRHqgDWNw
	udpp5AHa/2Gwq36ZC9HFtaIrzgTihtrXshD29Y3NbLPNRHJyisiXjTo1ctJUGLNVy4dtQDtnnQn
	zBleKbUSIaP6ncV30GKZfluSmAwt+6v0xV7car5SPac+Q4UIuHa3vi0CtTbF8Mkyn8Qp08+KUk3
	a8GgegleqLSH7H31Eb6VBLo7eDDvkyteQa+KrKOuIlNpnG3UuYtxze8djRef+UTLqQ8kOepkHin
	vc7dUdoXKKm7foUeoAplJXuyt6jhbvb/+SObgS7lmRS+XppGhcr3Y6Tlcg9WoCpR7wuJw7sCyDN
	f85kq6NjqmabANwJEc+tIkxjFgi+++2JkNDoay3IyNvyL/ScRNqBHcGwlBM+3wO4Z2VCvKFGGA0
	B2IpA==
X-Received: by 2002:a05:622a:a992:10b0:50d:7d8a:5d45 with SMTP id d75a77b69052e-50dd5b7c087mr192284391cf.36.1776169094681;
        Tue, 14 Apr 2026 05:18:14 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8aca57b465bsm65499196d6.38.2026.04.14.05.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:18:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCcib-0000000Acat-24la;
	Tue, 14 Apr 2026 09:18:13 -0300
Date: Tue, 14 Apr 2026 09:18:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jiri Pirko <jiri@nvidia.com>,
	syzbot <syzbot+03393ff6c35fd2cc43de@syzkaller.appspotmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [rdma?] WARNING in ib_dealloc_device
Message-ID: <20260414121813.GU3694781@ziepe.ca>
References: <69dc3310.a00a0220.475f0.0018.GAE@google.com>
 <20260413154353.GK21470@unreal>
 <PH7PR12MB66356E0176748BFFF081D9B4B0242@PH7PR12MB6635.namprd12.prod.outlook.com>
 <20260413174228.GQ3694781@ziepe.ca>
 <20260414104701.GB361495@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414104701.GB361495@unreal>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19335-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DMARC_NA(0.00)[ziepe.ca];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,03393ff6c35fd2cc43de];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: A85273F9EF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 01:47:01PM +0300, Leon Romanovsky wrote:
> On Mon, Apr 13, 2026 at 02:42:28PM -0300, Jason Gunthorpe wrote:
> > On Mon, Apr 13, 2026 at 04:12:09PM +0000, Jiri Pirko wrote:
> > >    Will check it tmrw
> > 
> > I fed it to Claude and after 40 mins it is stumped too.. It should not
> > be possible for this to happen.
> 
> Interesting, I used Chris's prompts for this debug and got the following
> suggestions (CONFIG_PREEMPT_RT=y in this .config):
> 
> ------------------------------------------------------------------------
> REMAINING HYPOTHESES
> ------------------------------------------------------------------------
> 
> 1. PREEMPT_RT rwsem behavior (most likely for syzkaller SOFTLOCKUP trigger):
>    Under PREEMPT_RT, down_write/down_read use rt_mutex internally. Priority
>    inheritance and preemption semantics differ from non-RT. There may be a
>    window in the rwsem downgrade path inside enable_device_and_get (which
>    downgrades from WRITE to READ after setting DEVICE_REGISTERED) that allows
>    a concurrent disable_device to observe an inconsistent state.

Is this actually true? What is the point of implementing
downgrade_write like this?

>    Specifically: enable_device_and_get does:
>      down_write(devices_rwsem)
>      xa_set_mark(DEVICE_REGISTERED)
>      downgrade_write(devices_rwsem)  [WRITE -> READ]
>      add_compat_devs()
>      up_read(devices_rwsem)
> 
>    Under PREEMPT_RT, could disable_device acquire WRITE between the xa_set_mark
>    and downgrade_write? If so, it would clear DEVICE_REGISTERED while
>    add_compat_devs is about to run (but hasn't yet seen the mark cleared).

This is half a thought, okay, so even if they race, the entry to
remove_compat_devs() is sill gated by

	/* Pairs with refcount_set in enable_device */
	ib_device_put(device);
	wait_for_completion(&device->unreg_completion);

And we still have the refcount guarding it:

	refcount_set(&device->refcount, 2);
	down_write(&devices_rwsem);
	xa_set_mark(&devices, device->index, DEVICE_REGISTERED);

So we can't race add_compat_devs and remove_compat_devs() like this
unless there is some way for the refcount to have been dropped to zero
also. I don't think there is.

> 2. xa_for_each skipping entries during concurrent xa_erase restructuring:
>    If rdma_dev_exit_net's remove_one_compat_dev erases an entry concurrently
>    with remove_compat_devs iterating, xas_shrink (called inside xa_erase) could
>    restructure the xarray tree. If xa_find_after then traverses a restructured
>    tree and skips a subsequent entry, that entry remains in compat_devs.

This race is also impossible due to the mark and the refcount.

>    This is subtle: xa_erase takes the xarray spinlock (or rt_mutex), but
>    xa_for_each calls xa_find_after under RCU. The RCU read side might see a
>    partially-restructured tree that looks different from the spinlock-visible
>    view. Under PREEMPT_RT, RCU critical sections can be longer.
> 
> 3. rdma_compatdev_set (ib_devices_shared_netns sysctl) race:
>    add_all_compat_devs() is guarded by DEVICE_REGISTERED + devices_rwsem, so
>    the same analysis as T3a applies and the race is eliminated. However, if
>    there is a remove_all_compat_devs() implementation, its interaction with
>    the unregistration flow deserves verification.

Huh? your claude has lost its mind :)

Jason

