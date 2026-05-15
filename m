Return-Path: <linux-rdma+bounces-20772-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HwcDqs8B2ottwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20772-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 17:32:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8415C5522D8
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 17:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B83AF30379AA
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 15:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A24238A726;
	Fri, 15 May 2026 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="IokvsCsD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4BF48BD51
	for <linux-rdma@vger.kernel.org>; Fri, 15 May 2026 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859125; cv=none; b=pfZemPqZ77E7LV8QiJ8S76ETHdNC4JRbOD5tTb8eV/tMga1xTr9YLpXxCBfSf0pwHGj/yrFzB7aUgsTvJ2V6NXvnDRmpqNZPvA68LgdAZjNNRA+i2hyIn5tkj95nWmqAyfgyj0/gS6dXSYUxg4C8OkZBYTdCfyY4pyp8ynycOCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859125; c=relaxed/simple;
	bh=6/FpSN7fzYb0+5JyB4R90kNkPXs0lIBFlRf4VC7fbHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvCWpiOjLeZL3ffN5p8NBXRWCgdKjZPGdYdh3QwERfQXkl7w++F08hKq64X7uAyDf5gpS3SulQ7eOhovc6fLBZ5KEEx/Eh0WYlKgtr6/olE1qIsBPury7BxAE5LT/2SNUgmygAwPZQmEY9phfoXQUhVRYbOGhog9/qbSgsODqy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=IokvsCsD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48e56c1bf5dso54584275e9.3
        for <linux-rdma@vger.kernel.org>; Fri, 15 May 2026 08:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778859119; x=1779463919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U7IC07o5Z0cgXIm3WPEZ1QjRh/ZpTmAHOtzh4ifDlLY=;
        b=IokvsCsD3MYCgWEgko7COWos8pPWm4VeOaR09aTp7GxCyEL8FicHK8gastgo+Rz/VZ
         SL+CjhijQdqcsNiS5x8vKUC+CWw0xz2pQiXR4ZkIPNsajF30pcwzruyEzkPFRbeA0on9
         Q8NIcB8rDzG5wOusey+WZmeo3hoxNi7XLQDUtNWaA/ALA4IwusQaYODalH7z7ZPMMcT8
         VY+1sH3qVnRt1/LBDx+55bIhFBj38rG2/M7v/AeprwyhouG3QSH3V5RMRMve8D08e5ft
         7xKJ4GIhZhwsUq575ha7ZJtgwIvZpMuLE3JEn3nkV4iVbKARUeH4qwY1qN3s0K6IYNCx
         ouOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778859119; x=1779463919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7IC07o5Z0cgXIm3WPEZ1QjRh/ZpTmAHOtzh4ifDlLY=;
        b=Iro/S2vG6ZeRrQY38mqrq4Y0L1LmhPpnX6/rplMG3/Kvmi5c2cCf0t+WEiPvy/Nofq
         M4lysk1V4Z83M1dv2VzFEaNOrh9PbDn4NKsF6uEuGKZaRL1GrpZ48zkGGXHR2EPAVbF2
         zZb56NMkgwqi9i6qVIrtkzTn6eSXsc5HHj+I3aNQ28jSGiwpizypOtXVRvAcAyhz0Y2X
         iIWiBOIZiRs22m6LYJ/qWcCFOfXbtG8cemS1WqiiDquwb+/3Ucm/ty/btkULxoZ2b9et
         QuRbKa3LVWiY9tlGfVFPaGftklAMXi7+YJq/wuIpPukOVRKr2byDv/BKBIdfdO8r+r6L
         4UFw==
X-Gm-Message-State: AOJu0Ywr+7jchgbfqv8n024kdsbaKCl69XsWcmCMQTI1kNDvE07AgDWT
	jyZQtV1FFkUahDrsJeHwT9Grv/Bhjb7t7wMkieXT+lLz6HhCruNzhsdrF8zsd5Aj5AM=
X-Gm-Gg: Acq92OHXMFHtzwdRH7g/Q4gT1mddzKhfUFy4+ytQmBIKFtyv8SLo1Vve4xrH0QnlUh9
	YcL78fOHQA+0pxiUrdnSOKJnlPbQYdR2zwmAULMlcqjHRFgkiP8UM+D5Lf8eqnpdouNOOUecUhV
	7PM4G198iBPu9rvCzh8zusUa8Gs9xE3eX1IeDluTcYkGGzNyHrgnFVrx0qSgBzKA+jOjrMeEIcE
	bYNJq3eBMLLLJF1fJx0fNBV5VgPm+UotDK0jH7YCErcd/IqU/KxyAPVZt2uQaLE0jIGJ+Nx7n3+
	md3haavmDKd+faCVuM9KVQYzer9MsajH484D/lF3l/ZhdpmlWPTbocddjO7zyh6hRNfJN8rJYoz
	14V8ja/v7C6wsMSKMY12GiI/rr5k59gQOo/OZu16SRQUEJUjFnfSVPAYRm95PaSApCtXzjH+0ot
	ZjWqTNepwBHI5GsX2e4zCXrT1cI6Eb6uMaJRo=
X-Received: by 2002:a05:600c:8485:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-48fe5fcdec2mr71008615e9.4.1778859118552;
        Fri, 15 May 2026 08:31:58 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8344asm113671505e9.1.2026.05.15.08.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:31:58 -0700 (PDT)
Date: Fri, 15 May 2026 17:31:54 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com, 
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, mbloch@nvidia.com, 
	yanjun.zhu@linux.dev, marco.crivellari@suse.com, roman.gushchin@linux.dev, 
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v3 03/17] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <agc71yBleAgA2UdG@FV6GYCPJ69>
References: <20260504135731.2345383-1-jiri@resnulli.us>
 <20260504135731.2345383-4-jiri@resnulli.us>
 <aftENVgTr8AZVQnT@ziepe.ca>
 <aftL-2sJb4JfyDIs@FV6GYCPJ69>
 <20260512181236.GA175362@ziepe.ca>
 <agTNeYSOyMTbUbNt@FV6GYCPJ69>
 <20260513233447.GU7702@ziepe.ca>
 <agWOldIWkFI3i1xB@FV6GYCPJ69>
 <20260514121410.GY7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514121410.GY7702@ziepe.ca>
X-Rspamd-Queue-Id: 8415C5522D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20772-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Thu, May 14, 2026 at 02:14:10PM +0200, jgg@ziepe.ca wrote:
>On Thu, May 14, 2026 at 11:02:45AM +0200, Jiri Pirko wrote:
>> >> There's no addr_size because no caller has a user-passed
>> >> length distinct from the driver-required minimum.
>> >> Drivers either have no length in their legacy ucmd (mlx4/mlx5 CQ, mlx5 QP,
>> >> the size is driver-computed from entries*cqe_size etc.) or they
>> >> pass ucmd.buf_size which serves as both (vmw_pvrdma, qedr, mlx5
>> >> SRQ, ...).
>> >
>> >This is what I was wondering about, so how does it work when there is
>> >a ucmd.buf_size and also a minimum size computed from
>> >entries*cqe_size? What does the driver write?
>> >
>> >I think the driver has to pass in both the minimum size computed from
>> >entries*cqe_size and also the uhw exact size? The minimum size is used
>> >if the uhw path isn't used to check the other attribute while the uhw
>> >exact size is used to pin the memory if the uhw path is used - and it
>> >should also be checked against the minimum?
>> 
>> I asked Claude to check every caller: At the moment of conversion
>> none of them would have addr_size != min_size. They split into
>> three groups:
>> 
>>   1) Driver-computed total only (no user-passed length distinct from
>>      min). addr_size == min_size by construction:
>> 
>>        mlx4 CQ/QP/SRQ           entries * cqe_size, qp->buf_size, ...
>>        mlx5 CQ/QP/SRQ           entries * cqe_size, rwq->buf_size, ...
>>        bnxt_re QP/SRQ/CQ-resize max_wqe * wqe_size, entries * sizeof
>>        mana CQ                  cq->cqe * COMP_ENTRY_SIZE
>>        hns_roce MTR             mtr_bufs_size(buf_attr)
>>        qedr SRQ producer pair   sizeof(struct rdma_srq_producers)
>>        all DBR helpers          PAGE_SIZE
>
>OK these make sense
>
>>   2) MR registration / opaque user umem. The user-passed length *is*
>>      the request; there's no separate driver minimum. addr_size ==
>>      min_size by definition:
>> 
>>        reg_user_mr in every driver
>>        mlx5 devx user umem
>
>MR has to use the exact size passed in the top level system call, so
>it probably needs some special helper that does that instead of minimum
> 
>>   3) User-passed length without a driver minimum cross-check today:
>> 
>>        vmw_pvrdma CQ/QP/SRQ     derivable min (entries*sizeof, wqe_*),
>>                                 not computed in the user path
>>        qedr CQ/QP/SRQ           ureq.size, no min computed in wrapper
>>        mana WQ, QP raw_sq,
>>             QP RC queues        ucmd.{wq,sq}_buf_size, queue_size[],
>>                                 no derivable min
>>        ionic CQ, QP sq/rq       req_cq->size, sq->size, rq->size,
>>                                 no derivable min
>
>Yeah, these are exactly the ones I'd expect to have a second
>parameter. Something like ucmd.wq_buf_size should be entirely ignored
>if the user passes a new attribute, not silently used as a minimum
>check. That logic has to be done in the helper
>
>So you imagine another helper for these four drivers with an
>additional parameter?
>
>> Given that, I'd prefer to keep the single size argument for now and
>> spell the contract out in the kdoc:
>> 
>>   @size: minimum required umem length, validated post-pin against any
>>          descriptor produced via @attr_id / @legacy_filler; also used
>>          as the pin length on the VA fallback path. Callers that have
>>          a distinct user-passed length must validate it against their
>>          driver minimum before calling.
>
>> If/when a driver actually needs distinct values, splitting into
>> addr_size + min_size is mechanical.
>
>Ok, maybe mention in the commit message this has trouble for the four
>drivers in group 3

I split the "size" arg into 2 for ib_umem_get(), documented and noted
that in future the new helper working with both arg is going to be
needed for group 3 drivers.


