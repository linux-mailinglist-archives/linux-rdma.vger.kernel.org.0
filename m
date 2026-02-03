Return-Path: <linux-rdma+bounces-16432-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCXVGIa5gWm7JAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16432-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 10:01:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A9FD6862
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 10:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72776300BE0C
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 09:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1860B2DB7AE;
	Tue,  3 Feb 2026 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="G24xNmkv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2AC30C614
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109259; cv=none; b=bQuZUBKKSWOnA8HySR66CIGtMm9RDF2l0Z3Imij1TgywyOcne/d5sK+vhA6JQPAbJMYvnRT4dGIZ095YswaDxdOJxHILxMvxLkm/vPaox+hd2W49cLQb6Oj/drpVHRJvWSAI7w4BMp5Nswbn1FkNwa3Gkq4grQaSxCQvSM2+Nuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109259; c=relaxed/simple;
	bh=0mub+m88Wg+1zSHWUi9Z9P6VHHhlvh4f/Wf7W+hqNWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cc79O42DII7ZTSf7F/zaSMUuDZFwBNVS7H6YLPDXkIOjPFK3HDFB6pDErRQtYLORNVJbziAE/lMqTNL6+cwtxOGWgWFa4xmMUoOEVaawXyzwejaFHBgKxkggMjDMK+2TfXgpP5vr8H/Fqj9y9Eg/yaxbJaN7SbeAeFgQVkb7fXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=G24xNmkv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4806bf39419so2940325e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 01:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770109256; x=1770714056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0mub+m88Wg+1zSHWUi9Z9P6VHHhlvh4f/Wf7W+hqNWg=;
        b=G24xNmkvHLhNQmqRne0ktZYcRXcAiZzHlvsTo9SnkxDOUOHNdb1X+RgjTLXtuQh64x
         52daTPoHHgokvcwhFtV3qQUFCK0elsmMEUS1KLSOFbPrMEva/yplFBZre3N/Qd9GFZ+5
         t+vtkyVllCTU8g4t7SkMDNkI0JraghDZ2EJz33b6HbkETpBg7XFWaIiYpNLrrhOr//aM
         Ii2Wd/aEvoVbPVEXjik4h5Kr0JG/yNORudGO2ZhVDr87JxOOqtiTQe1C3KTxuXp/Cflu
         B6nk1lpKkGHvVhNYvj9HIk7kpIHDj0TjFOwSRS5CUrLYNs1avZRlv/bJCyFaD/UZP8Vp
         S2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770109256; x=1770714056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mub+m88Wg+1zSHWUi9Z9P6VHHhlvh4f/Wf7W+hqNWg=;
        b=UA/Yj2zPmKDUzhxJzsjHhP/svrxNJ2PTGHvdTV34bqmM7DH3yVsISwG2XDK2Ga9P9N
         02ZgD5gLDBc9fU61/a1Yfh9pIx3Ti3GHye6CYHyIWMBszn3xZKK3shie4g2/0xn120Dq
         GVoNUC14i/SSOfLNDtyBcV2Hz9AI75fmK7TZitNKp7vg34NY8mWyw2HrRja8LzMkgFSm
         OAHrlX1TLRMQu44IRB97fCMbU318QWwrtm35kVLYkcQvjrStMkAHzu5sDMIn76PoXvJY
         1lvUTWSlKPFPNJLBTZULA5c2y9S67VJiuC+tQsDSt42XrzeanWRj1xJ73GaBhrMGWGzw
         arOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv4onfUQKY9+x4RrJyN0aHa4/UBHRQh2hinLTb/FCPieLuzpAdxoE1QodsRaydt/j0vQR6pozaPKmN@vger.kernel.org
X-Gm-Message-State: AOJu0YzGIIHq2RVjK8JcQyK+SU1d+GVF0TMvwg5LAirjRebSQtLnFRJL
	uABikwEEN+pt9Q4Ya+LFKlEvuUVCHA+OJh49WPUy1fiO2T7n7kJ5pZtLfSVxAgKHODQ=
X-Gm-Gg: AZuq6aLolTG41WItub0ntoVaNXGAo++ibFgyA7rov8ZkKjGY6GCunksToyXYpbT1dbw
	rJvxnSlTxbYNrtdcLE95hGJ0HE3m/DtN6tWjymkgqGs4KhMRPIn3y2MG3slw1Ps9aiO5aMUPtug
	v34DqXe8hXO+F5Sqejc7dqmnSb/nUeWD5HkpIfCywddqSRlwfiU2rDYQrTGELr5dixF1bAafJUD
	RVCKU7GwhktA8ryzXEZf00XFR90PtfodurNXRydmBy3GcR0tWHJ65nSB/lTqHiAsmDSnSapav/T
	Prmv3RKQ6qF7rESdYJjZuiIz1R7lCPu5Q25qHXro7GBRJ6N7boa4G/mLVhNE7SBbK6/Kx74XIky
	3r7QYLXSas5cb0eSp3dpGTVrTZzq19pfztyrEgUcwC4sCc7iSTsE+DrxDG4IS5j6INgHu5DaWFV
	aaaFYwbnUcMZ8FMAYa/s7M/LNAAZPBOQ==
X-Received: by 2002:a05:600c:33a6:b0:47d:52ef:c572 with SMTP id 5b1f17b1804b1-483051314dbmr19408305e9.1.1770109256079;
        Tue, 03 Feb 2026 01:00:56 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483051626c1sm45547045e9.13.2026.02.03.01.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 01:00:55 -0800 (PST)
Date: Tue, 3 Feb 2026 10:00:54 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v10 1/6] RDMA/uverbs: Support QP creation with
 user allocated memory
Message-ID: <bi2d2urxye5qznufyo3safmwrk3inkcbam4yxigiacze5bo2js@6cgsln44phc5>
References: <20260203050049.171026-1-sriharsha.basavapatna@broadcom.com>
 <20260203050049.171026-2-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203050049.171026-2-sriharsha.basavapatna@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16432-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	RSPAMD_URIBL_FAIL(0.00)[resnulli-us.20230601.gappssmtp.com:query timed out,resnulli.us:query timed out];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[jiri.resnulli.us:query timed out,sriharsha.basavapatna.broadcom.com:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:email,resnulli.us:email]
X-Rspamd-Queue-Id: 05A9FD6862
X-Rspamd-Action: no action

Tue, Feb 03, 2026 at 06:00:44AM +0100, sriharsha.basavapatna@broadcom.com wrote:
>Some applications may need to allocate their own memory for queues,
>instead of using memory allocated by the library. This patch supports
>creation of QPs with such user allocated memory. This support already
>exists for CQs. Along similar lines, add new uverb attributes to
>specify umem buffers (VA/length or FD/offset combinations), for SQ
>and RQ. The handler pins these buffers and passes them to the driver
>through a new 'create_qp_umem' device op.
>
>Co-developed-by: Jiri Pirko <jiri@resnulli.us>
>Signed-off-by: Jiri Pirko <jiri@resnulli.us>

NACK
Definitelly didn't signed this off. Sigh :/

There are many flaws with this draft your AI tool didn't catch.

Anyway, could you check out:
https://lore.kernel.org/linux-rdma/20260203085003.71184-11-jiri@resnulli.us/

Tested and debugged version of this draft is there. Btw, I wrote clearly
I will send it, I don't understand what's the rush....


