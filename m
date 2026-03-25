Return-Path: <linux-rdma+bounces-18635-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PXtDm/+w2lXvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18635-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:25:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEF9327E31
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43119311C266
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 15:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073253E9F73;
	Wed, 25 Mar 2026 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxsBW043"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670503D1CC0
	for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451192; cv=none; b=nt0ZVq6M9ZZCddpvJsRQ8Xx4eewDKcao07eNd79AQIXHyGt3SNcq2+JV7SLp+GZkvak2gfEiuBzR7to4pROPfJlxXbkDv6QcHjx0ueS4swrVfVrPFxFynnW6DdJ90Fszi2wnNNldZoKJvMMKDfqx3EJZTCp8ZTAF9mDhTOvg2cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451192; c=relaxed/simple;
	bh=hueUun48O4250wdQs94dWOVmghwrQOiUb0g955DTCkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U586udyECuRa//7JDDNwbVtUM046znI6FIH/W1eguUKYdkIj+zjK0VKk9ufrnCUSVylyZrwA7DSKCvQBxLCbHspThc3El8eqQ+bMjoKqLO5hZi6VEtcFzlewviFfBrWNztimMi0hbOFxQIXDP5Tp6PGiuXkFhuzBlhZTcZF4g9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxsBW043; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-126ea4e9694so12777086c88.1
        for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 08:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774451190; x=1775055990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/d4Gn1kS5MGurytQaHUUdFFZv/IQSTbByU+x/UA/BgI=;
        b=bxsBW043Y5w/Dz8Y7N/NIiibrY68N4RdaHozWOv+rAlIeRZyuQqI2cujs3ZfRtTMCc
         RCO+i4urjzpZM9YVvNvg6cbNOBhzrhgQcFqq3CrLCxR3IgjvqUcRIT5b8kIF403L0dcc
         05XD9q5JXZ5kRRBn6vQrz65dzfz9pavFtAAHKGiBYlFkMsZpeRR1dvTUfY/QMEYoYqKx
         F2frc57Z8FHTlkTPdVhlzcwIu0/beNFkPhyYMJFNfqZq0qO2OTI2d9KFYnYFCsWUfCrG
         WO5HKQKePtf+5mhwrbLyOd+0aDHDhmsWogVgXOPCmo65kTvjM+FdYcqFdd8OKuxTUHbX
         wyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774451190; x=1775055990;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/d4Gn1kS5MGurytQaHUUdFFZv/IQSTbByU+x/UA/BgI=;
        b=YeAPXTJIEgdgosytTHPLk/JUak9UZgpW5wtcxs3OkZFEN2Cp1W4M7JGNP2gwKL72rr
         bU29VN2YpRCzfDo+7x3j8+9c1TAK6608F/4Dr1aCw5HWmMmIdRvCvJyvrRmKRbpA5mAS
         xP6D/BVafzPxJ2dr1cZXVrlF/siqJoxoMReI5vRm9pSUIex/3gbM46z6L0jaVuluy3Vo
         KbiCUs/7UzWLyXxmfqBqINzSDfDSrjLebIwMrqlokyHVOaTCPCwXYQ4Cdioy89p+7tZE
         4NsgSuQxw4E7j9uQtBmDBkZjf2zbFLQMjd1mFkC/fEDYyY7RyFvNkke3uSq7H+h0mbBw
         IrnA==
X-Forwarded-Encrypted: i=1; AJvYcCVjJEMY1I+m07pyfjapXZ5SOgGKAFrT/s6MGJFIbSmnafmw7f0J2fnhy/yNRfmNH8SBYyz2Lu4gBnML@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc5LrmS4uS/yRyl7NDZtqliCftfkEIfmFAGh/EBy3S+KNq/z+K
	hYlqtiYeh9g64u5zu1ZD67FMi3tngxktu5QhuRUNX2s/IQgaFMGhxF0=
X-Gm-Gg: ATEYQzyoazv9uWAXPqqYyHqm6l403rLUS069VflxH9FCpyvpv9L6B0Tdsmylj+h29pQ
	lM2PN/YSXBe6uKymwR7rtdspN5I/HCCm7JdLOpMHB4dShyfLf/8NpF7+g/nnutRjLex9UdfsMVk
	QOC49mSrKv6DmdlB8k9tCmRuASReEFpc8kFuTbfw2Oo5U7RkqG830FPNwgev36MiNjarqSNy8+K
	c1MwoW7Wh0RBOjfFEIRsf4to+q7gbLYHjZeAte0sNptzyqEoOFTkxdoB/LTtFfWTpcE8LR5Q/b7
	pWqCDnKEveRM4yd1RpEYhm+DNAbF9R6Gs9LcFTYyAZzgRYR7gcjlGXMCYCayIOBr9nt5ECE7guz
	uVLaqh9uvsvaev1ml+yooTFQIkqXPmQ1eJ9tHpXAbuwwrwiUVT+Pc1rgpPeYJqH9viT4eE5HBD6
	T5+bULHijn3QFSEfHtzk3gYzlp4tFp62nNCC2wyH6g8b0x23hdjumZEqw8Q5nwOxzW1Vo0F1NrZ
	y1M+eNVJj59xJdOUw==
X-Received: by 2002:a05:7022:6984:b0:128:ca6f:adf0 with SMTP id a92af1059eb24-12a96e69cffmr1941893c88.17.1774451190214;
        Wed, 25 Mar 2026 08:06:30 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aa7248731sm29001c88.4.2026.03.25.08.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 08:06:29 -0700 (PDT)
Date: Wed, 25 Mar 2026 08:06:28 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com,
	johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
	dtatulea@nvidia.com, mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com,
	bestswngs@gmail.com, aleksandr.loktionov@intel.com, kees@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: Re: [PATCH net-next v3 03/13] net: introduce ndo_set_rx_mode_async
 and dev_rx_mode_work
Message-ID: <acP59NM6HZhV9oAe@mini-arch>
Mail-Followup-To: Stanislav Fomichev <stfomichev@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com,
	johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
	dtatulea@nvidia.com, mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com,
	bestswngs@gmail.com, aleksandr.loktionov@intel.com, kees@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
	leon@kernel.org
References: <20260320012501.2033548-1-sdf@fomichev.me>
 <20260320012501.2033548-4-sdf@fomichev.me>
 <20260323162003.0d155055@kernel.org>
 <acLUMN1BYkIVyOk8@mini-arch>
 <20260324142114.216fcb01@kernel.org>
 <acMU93XN02PHmAGi@mini-arch>
 <20260324204440.1752423d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260324204440.1752423d@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18635-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[fomichev.me,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6CEF9327E31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/24, Jakub Kicinski wrote:
> On Tue, 24 Mar 2026 15:49:27 -0700 Stanislav Fomichev wrote:
> > > > Not sure why cancel+release, maybe you're thinking about the unregister
> > > > path? This is rtnl_unlock -> netdev_run_todo -> __rtnl_unlock + some
> > > > extras.
> > > > 
> > > > And the flush is here to plumb the addresses to the real devices
> > > > before we return to the callers. Mostly because of the following
> > > > things we have in the tests:
> > > > 
> > > > # TEST: team cleanup mode lacp                                        [FAIL]
> > > > #       macvlan unicast address not found on a slave
> > > > 
> > > > Can you explain a bit more on the suggestion?  
> > > 
> > > Oh, I thought it's here for unregister! Feels like it'd be cleaner to
> > > add the flush in dev_*c_add() and friends? How hard would it be to
> > > identify the callers in atomic context?  
> > 
> > Not sure we can do it in dev_xc_add because it runs under rtnl :-(
> > I currently do flush in netdev_run_todo because that's the place that
> > doesn't hold rtnl. Otherwise flush will get stuck because the work
> > handler grabs it...
> 
> I was thinking of something a'la linkwatch. We can "steal" / "flush"
> the pending work inline. I guess linkwatch is a major source of races
> over the years...
>
> Does the macvlan + team problem still happens with the current
> implementation minus the flush? We are only flushing once so only
> pushing the addresses thru one layer of async callbacks.

Yes, it does happen consistently when I remove the flush. It also
happens with my internal v4, so I need to look again at what's going on.
Not sure whether it's my internal regression or I was just sloppy/lucky
(since you're correct in pointing out that we flush only once).

Before I went down the workqueue route, I had a simple
net_todo_list-like approach: `list_add_tail` on enqueue and
`while(!list_empty) run_work()` on rtnl_unlock. This had a nice properly of
tracking re-submissions (by checking whether the device's list_head is
linked into the list or not) and it was relatively easy to do the
recursive flush. Let me try get back to this approach and see whether
it solves the flush? Not sure what wq buys us at this point.

