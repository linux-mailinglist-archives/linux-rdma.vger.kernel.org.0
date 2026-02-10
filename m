Return-Path: <linux-rdma+bounces-16709-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDakD81Si2kMUAAAu9opvQ
	(envelope-from <linux-rdma+bounces-16709-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 16:46:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB99911CB39
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 16:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 393CC3022554
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 15:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B51C2F39AB;
	Tue, 10 Feb 2026 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hOIRsBii"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A7F2FD665
	for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770738166; cv=none; b=CyTkWJcM/jXpwPvbkElHE/f2anam8Gy9yoIJjz5iG9zRB2UYzhGO3X91VNm60YProB+fuMyXa7Uzy/hMeRFDO+zdx4fEy+nV2auVT3CGdTfPR+J91mHxK6BvxJrWgtuBUHBStO+JUuSR22yEPXeLOvtvdFJaoMzrDJRHPM7OZvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770738166; c=relaxed/simple;
	bh=ZauUGzn1UiRuN6aHYyT1u9cdonFD3KJyE8WA87rrhwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjMEXVb3AimHC7AHco7nVpRiDRU3fZIM4qs/a46lWVAC/H+DVZjmO+S1IGQ7hjEB/v/SvihBr8puXgy/bLbeaXpQI9TWO5AuAtygmDW23HZuHjEwM9Tg4GEuXJOos2MpWYeV8CjGGDSu0kDKzz4oGxOZbqWHC4/x1cKU/LHK5dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hOIRsBii; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-896f82e5961so14200436d6.0
        for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 07:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770738164; x=1771342964; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cV0E8TifaZWJ0Lo2zz4Iq5JUpu4OhtJNzrOVZrwh60I=;
        b=hOIRsBiikxvUaVqUT4XYKu1Yl9mgGeg4w/2NZWaq/OfAfoer89dz2D4qqy0j5lpUPG
         hLxEFoz4ASbXHJ/AtVr8Pqmg9m54q8j5YoN2k43j3JjA9q/ZB8z5JfSyyL9ekvLIGR4Q
         HVBpXOLftzYqsjjugmaSppcvmGVLvybaRX8Nwi7KXZU/4HpMmRRy/FXMpTIwwcmCCWjp
         OkSvKVPYAxBHsUKbkswVoHhIBhYzA/VpSbxO6z0dfm/MP2ezQ+rICJa/dQet6TLbleKy
         eBdeEpUSV0A9KoicgSNsdhhu+I+bhEHn03QhdkIlozczvmLK8DHs+DMcSMy9FRyh6MDF
         Evxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770738164; x=1771342964;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cV0E8TifaZWJ0Lo2zz4Iq5JUpu4OhtJNzrOVZrwh60I=;
        b=elatmGDbioYn0aAMQ3sH4ZszWbU/G5Wcw2iOH9pfXjsJyvIf+74zCkBbb0dPl7Z5hW
         A8cdykplXrqHMfoyunka7EviVY3M8n3lB/Cst+xSSNUYIYKrMvqaedzY5ATxx3cqk3cL
         I10aR3eCc1P+3fiEc263xRMnZHaJCbaSWJXW82oBlyD9LUKF9AoO7KX5XM2o7gMIdbcX
         tBBjzeeAq7KYZ+j+9JxRDIn03SnlTcE7DXMHgUuKrC4mzhs+65RgFc6oz+oviC0Gp/YV
         sWo2MR4Mcg0I/SbJDMquuhDFYffcl/9fljT+vSH0wDZSTwaCkLX+2ba2UecRnA3qN1WT
         nrGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVokJE1l9k0b7hyFEmJUrsdFjAkJpbjVcIluA5FPW/vE0l/AsY8yio/GkX7w85rxneC1Gfr437Nc8kV@vger.kernel.org
X-Gm-Message-State: AOJu0Yycjz7lay/gNrtrAYH48x72z/AsEb4c0qt7YeNQFmcNO/WSEdMz
	rRn053Ivw6dWiwnMjyFmqhhXUSehVhCsS7YSI/RTXZHY43Du7LkyDxKfv3y/r7vdxE1mKgxO3Lb
	Lmv6C
X-Gm-Gg: AZuq6aJD7V+F8dl71S5R8CUUoV+l+gTTXRiBaJI7/iu9qavJ3A4Hpmljqv4JSnLJavt
	nZ8CNTEd+xNtECcMmkcCJsWyNybRZkbGvXtIHVhUIdTiosuKR5U3uSxzI8HQaMeLJNgMX4f2gwD
	arqKK8DzEAQ0QUU3pQlZF85BIRGIQ31qZXzqUEtu03aref0CwATvDsCfTG3+kwEZ4ROLbl0xoeL
	w2vxHFLPYQchKY3+ea6l/cq5IBzPG/kHpiRN7mIpkvAND9HgefsgaJfu4pahiXEpkjnPd06tM0P
	o5887PZlgdk+XuMYgUraHS22H1cC5dZXrt1Tm1ZWSkUUmFYuJinpHpl5w55WFCVYWvaFtq0hX2T
	202UqWuUNtNGA8ENJs+QPa4BM/EWZCptk9s7fQFSbadKDdwQZjTQcAAk6mwEtsmzrHMnF+23vCX
	mUieDNZeNf/gvvXIt9xMrCpaVjiBh6Dk3MfeUApymUYF7UeSZZR/aHCl3ZbCvJhj/naPDk5NHp6
	vqhSS4=
X-Received: by 2002:ac8:7d56:0:b0:506:1c3b:c8a3 with SMTP id d75a77b69052e-506398a219fmr215718231cf.27.1770738163898;
        Tue, 10 Feb 2026 07:42:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89547d4fd53sm83621286d6.29.2026.02.10.07.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 07:42:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vppsw-000000043QK-0r6T;
	Tue, 10 Feb 2026 11:42:42 -0400
Date: Tue, 10 Feb 2026 11:42:42 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-rdma@vger.kernel.org,
	leon@kernel.org, msanalla@nvidia.com, maorg@nvidia.com,
	parav@nvidia.com, mbloch@nvidia.com, markzhang@nvidia.com,
	marco.crivellari@suse.com, roman.gushchin@linux.dev,
	"Yanjun.Zhu" <yanjun.zhu@linux.dev>
Subject: Re: [PATCH] RDMA/core: Fix stale RoCE GIDs during netdev events at
 registration
Message-ID: <20260210154242.GB750753@ziepe.ca>
References: <u7t7kha66tqngzyoryly6pltiur4wtz6gm3nui3zeb32dmtctp@54rr6gcsqtap>
 <1dc21045-4030-4d37-9ae6-3dd2c42b8e88@I-love.SAKURA.ne.jp>
 <inp2nyil62tkkvahvjvwvgp63ld5cffgowqhwlbssabhd2gaka@52lfxbmxvbzi>
 <8bdfe8a3-1cdb-43e3-b68e-428f6c5133d5@I-love.SAKURA.ne.jp>
 <j5tnfwmkfqtmmtpkbcdxriu7wlgxydazuvkk4nkfv27nddlq4r@xx4amuxv6y7y>
 <d6aee73d-91cb-4eb3-ad11-6244e973932b@I-love.SAKURA.ne.jp>
 <20260202235133.GP2328995@ziepe.ca>
 <c5ebe396-eccf-450b-8486-e1900258d9c0@I-love.SAKURA.ne.jp>
 <eqplwtvsocnqesb7vysnb6cq2emmghbg5wttkc6oyltsqtw6zi@6iewgx2qnsml>
 <3f1881d9-243d-4869-8396-5cca2e915733@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f1881d9-243d-4869-8396-5cca2e915733@I-love.SAKURA.ne.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16709-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: BB99911CB39
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 07:22:43PM +0900, Tetsuo Handa wrote:

> The root cause is a race between netdev event processing and device
> unregistration; something is preventing the driver from reaching
> ib_cache_cleanup_one() after NETDEV_UNREGISTER became no longer working.
>  
> 
>   CPU 0 (driver)                    CPU 1 (workqueue)
>   ──────────────      ──────────────────────
>   __ib_unregister_device()
>     disable_device()
>       xa_clear_mark(DEVICE_REGISTERED)
>         ← Too early, event will be lost
> 
>                                     NETDEV_UNREGISTER queued
>                                     netdevice_event_work_handler()
>                                       ib_enum_all_roce_netdevs()
>                                         ← Iterates DEVICE_REGISTERED
>                                         ← Device NO LONGER marked, SKIP!
>                                         del_gid()
>                                           ← GID cannot be deleted
>     ib_cache_cleanup_one()
>       gid_table_cleanup_one()
>         gid_table_cleanup_one()
>           del_gid()
>             ← all GIDs will be deleted

This seems like a different thing, why does it matter if an unregister
event is lost like this?

gid_table_cleanup_one() removes all gids regardless of the state of
the netdev? It isn't going to start leaking a netdev reference if you
hit this race?

It isn't going to block unregister from progressing AFAICT.

Jason

