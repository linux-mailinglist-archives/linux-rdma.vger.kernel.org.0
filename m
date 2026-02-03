Return-Path: <linux-rdma+bounces-16458-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPUbAyYIgmmCOQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16458-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 15:37:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4755EDAACC
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 15:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86AD730D0757
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 14:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654483A9614;
	Tue,  3 Feb 2026 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="TAeceMUi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679373A9002
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129000; cv=none; b=kupQLWzK83P9SbHi8f+VV+4FpKa97tgIX9VTnx7BMxN1y1iA2xHOJGthjZZWX7NBeBwhyRBXmndjtc1zqp3HwN0hgLe6T4Rl8B5UsvhuvxfXMKlIZ7iEwSMDRKY9zZ62fIgU9zt3IaV7yXb4ohIXFxJ5QTPhqfv2GEjNf7EOyZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129000; c=relaxed/simple;
	bh=DBOApv0AbtzzgfgSsQab7yPqYM06LyyzUvAcIPcC9SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/sC87OFMsKab77PjyM67o0/9GW7B05KxxCvugR+RHlLUlydrUzZ8+ps5eQl1fv0j92NEXCfi73oxTe3Gt4dyi+9k2XDczNWeF18XDWg2GzJqYA1Ki2Fy17SpW/yK2r7Lx1f4YMMm1F+TLX2nTBb1DPYGm0dejHs/sqb7NXAXuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=TAeceMUi; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-480706554beso61817155e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 06:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770128993; x=1770733793; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/keY/200HLHGA4ao8gMe1E6fXPrYtQGJ2TaQjTXSyu8=;
        b=TAeceMUirmCmk+BCQO43e6Zqe9lmjq+zcH53qmthWsVSDIufdF57BHuQiWc/klKxO9
         n9GPa2Kvpy3vTshaQo9PGN/g7BhAWbl00ms2wQdhKE8aVcfmFnZuQzdottdQ0U9s6g+s
         B9i9P33Iwc3aGkHfrOSixBSdzhcClDQjnrq587TMXEf3PvijGgZLR+1Wlh0r2tPMdHAr
         EsDCGxo3jlDd8PlqtJg5z03hU2ptfxmRbQgpQCQjY2OWnhhkFYTRGGoW8kpwVGms0cGQ
         AG2be1sueipqIyyBA+zVa4doC7hX9tTasWbWtI8+IHU3u12hlqdpcVcG0AsZvyITkiN4
         77FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770128993; x=1770733793;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/keY/200HLHGA4ao8gMe1E6fXPrYtQGJ2TaQjTXSyu8=;
        b=Ggm/ygxkLfRUDQKMseN2+/kUHhF5Mi6/oSyrO+2hl/g3b6TMX/yGRJ58jyRHdONliM
         +IE1npl9lHkj1UJdeEH7L0JDM2w/YbddX4MmjnzwwhmCBcPZv95DlRL5Txt8m94Bq6nc
         Aqrgi0sxtKIkmXy8e25cIQNPqJN4CCEKugeeHgxE111MjnUghwfMngGw0FVTmAt9gAj3
         xcxabmpWDja2ohG3FcABwz6EiQaj/idWi4+/MhF8C5Y0w3SYTI1jMT6eKnexfRj4hl+g
         U/pypYD1FCM2xHRAtCj1L29FX1UrtrZ5RlaXtj4ohueKIo8dGnuekVbatu+S20mwE2pB
         oFJw==
X-Forwarded-Encrypted: i=1; AJvYcCULAsH8lW/XXmQoyieTAUJmc+qy7Jn3Jpqf+CDpDdiD5aHN312u/ynBz7UAiBVVZVHQZkoaEmvI5/Nw@vger.kernel.org
X-Gm-Message-State: AOJu0YyU90CnXisZJ/BiGGrcl/bzBI4uELHByr8rGK/6zf+Zsxv/+Sv9
	Mc1zli15h3gZCQoHn3C7SuzVSxQf85tvATjgjJ29/DwfOnsmFhlQHaa0g0wLyLNnb9c=
X-Gm-Gg: AZuq6aK11/MOUZGmqUkD1zDXR50YT5tQlD9hhHybgpTwebaORV/Gu+DAKNJVtY1E78p
	J/lTiWV49BpDV4f/tAyY5AQuQKJryscYyHeSnV9Y88VYkK2mMnhgv/FhRqV0NUcsBvhsdtaZcfI
	Pq5kHgd7FVRf3pqTRVFEpEQ6Bg2PqXaA5d3XsYyEjxaZjdI2mKIyJAf+Ni+rBwCxriweWJWdAuQ
	09wptcewaS7lHlh0DBszDfc6uNWq5n2V7qsjkRBwJP225BAFPKi8K3qxN19J1qZ8GA2rNzGP6R/
	tvlcqwfBqqYRhEyFlww8CF3YPZnPVp+KtldB95XvmLnwWMgoJLr8t+g4Fah0Ve0OauOvqyuZ8Jp
	Rf7wP8vZCXAzjTkVS3TkyYGB0LTpwCtq8nS/0AlAWJRKhISbNnzlVli0YbBUBiEIrBXiP502Zlq
	XoE6xFVqp5XPq01LgeUBBHvIs=
X-Received: by 2002:a05:600c:6814:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-482db4abde0mr208248095e9.31.1770128993452;
        Tue, 03 Feb 2026 06:29:53 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48304929bcdsm27981735e9.10.2026.02.03.06.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 06:29:53 -0800 (PST)
Date: Tue, 3 Feb 2026 15:29:49 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, 
	jgg@ziepe.ca, mrgolin@amazon.com, gal.pressman@linux.dev, sleybo@amazon.com, 
	parav@nvidia.com, mbloch@nvidia.com, yanjun.zhu@linux.dev, wangliang74@huawei.com, 
	marco.crivellari@suse.com, roman.gushchin@linux.dev, phaddad@nvidia.com, 
	lirongqing@baidu.com, ynachum@amazon.com, huangjunxian6@hisilicon.com, 
	kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, michaelgur@nvidia.com, shayd@nvidia.com, 
	edwards@nvidia.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next 01/10] RDMA/umem: Add reference counting to
 ib_umem
Message-ID: <ies3tefav42xtqnxbsxrzfiwlvxgrymnpufkzrd3pppxz7a4b6@ib3fouxvl24p>
References: <20260203085003.71184-1-jiri@resnulli.us>
 <20260203085003.71184-2-jiri@resnulli.us>
 <20260203100327.GS34749@unreal>
 <vw3hrr5fsamtsgydvydoewd4fnglas5xzickgfpjgp5y44gxkm@dmmvo36blqtb>
 <20260203122618.GT34749@unreal>
 <uixv7cu4qe5vqkl3dlsd4smbxvflo3syoseuwtf4v7xhwgziul@gqlnz4geufth>
 <20260203130335.GU34749@unreal>
 <56arliffs27lqgriymsnysnh672joz7ihndkeffqee32vvwxby@w6qhwezufrrc>
 <CAHHeUGV3W+LbGEnGB_Fbehy1PB2P2y1MkAnu6OTUKTeZC0yxJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHHeUGV3W+LbGEnGB_Fbehy1PB2P2y1MkAnu6OTUKTeZC0yxJQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16458-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,resnulli.us:email]
X-Rspamd-Queue-Id: 4755EDAACC
X-Rspamd-Action: no action

Tue, Feb 03, 2026 at 02:49:33PM +0100, sriharsha.basavapatna@broadcom.com wrote:
>On Tue, Feb 3, 2026 at 6:50 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Tue, Feb 03, 2026 at 02:03:35PM +0100, leon@kernel.org wrote:
>> >On Tue, Feb 03, 2026 at 01:46:21PM +0100, Jiri Pirko wrote:
>> >> Tue, Feb 03, 2026 at 01:26:18PM +0100, leon@kernel.org wrote:
>> >> >On Tue, Feb 03, 2026 at 11:11:39AM +0100, Jiri Pirko wrote:
>> >> >> Tue, Feb 03, 2026 at 11:03:27AM +0100, leon@kernel.org wrote:
>> >> >> >On Tue, Feb 03, 2026 at 09:49:53AM +0100, Jiri Pirko wrote:
>> >> >> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> >> >>
>> >> >> >> Introduce reference counting for ib_umem objects to simplify memory
>> >> >> >> lifecycle management when umem buffers are shared between the core
>> >> >> >> layer and device drivers.
>> >> >
>> >> >The lifecycle should be confined either to the core or to the driver,
>> >> >but it should not mix responsibilities across both.
>> >>
>> >> Okay, I can re-phrase. The point is, the last holding reference actually
>> >> does the release.
>> >>
>> >>
>> >> >
>> >> >> >>
>> >> >> >> When the core RDMA layer allocates an ib_umem and passes it to a driver
>> >> >> >> (e.g., for CQ or QP creation with external buffers), both layers need
>> >> >> >> to manage the umem lifecycle. Without reference counting, this requires
>> >> >> >> complex conditional release logic to avoid double-frees on error paths
>> >> >> >> and leaks on success paths.
>> >> >> >
>> >> >> >This sentence doesn't align with the proposed change.
>> >> >>
>> >> >> Hmm, I'm not sure why you think it does not align. It exactly describes
>> >> >> the code I had it originally without this path in place :)
>> >> >
>> >> >There is no complex conditional release logic which this reference
>> >> >counting solves. That counting allows delayed, semi-random release,
>> >> >nothing more.
>> >>
>> >> Again. Without the refcount, you have to make sure the umem is consumed
>> >> by the op. Actually, check the existing create_cq_umem. On the error
>> >> path, the umem is released by the caller. On success path the ownership
>> >> is transferred to the calle.
>> >
>> >We need to fix it. Exactly right now, I'm working to make sure that umem
>> >is managed by ib_core and drivers don't call to ib_umem_get() at all.
>>
>> Should I wait and rebase?
>>
>>
>> >
>> >> Consider various error paths in the calle
>> >> some of which are shared with destroy_cq op, some umems are not actually
>> >> used etc, it's a nightmare. I had the code written down like this
>> >> originally, that's why I actually know.
>> >>
>> >> Perhaps I'm missing your point. Is is just about the patch descriptio or
>> >> about the code itself?
>> >
>> >Description and the code. UMEM needs to be created by ib_core and
>> >ib_core should destroy them.
>
>I'm seeing a kernel crash when perftest is stopped, I'm still
>debugging it, but I'm wondering if it is related to this change. I see
>this inline comment in the uverbs handler:
>
>        /* Driver took a reference, release ours */
>        ib_umem_release(rq_dbr_umem);
>        ib_umem_release(sq_dbr_umem);
>        ib_umem_release(rq_umem);
>        ib_umem_release(sq_umem);
>
>What does it mean by "Driver took a reference"? If the driver returns
>success from create_qp_umem(), the umem it is still using gets
>released above? Is there something that the driver should call to hold
>a reference? It is not obvious from the create_qp_umem() dev op.

Yes, see "RDMA/uverbs: Use umem refcounting for CQ creation with external
buffer"

[...]

>

