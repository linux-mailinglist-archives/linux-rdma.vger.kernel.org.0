Return-Path: <linux-rdma+bounces-21861-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 68AUKlsLI2oahAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21861-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:46:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E5A64A4B3
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:46:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QhwjXUXO;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21861-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21861-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32B04301F1B1
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 17:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB16352C2C;
	Fri,  5 Jun 2026 17:38:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4153A390209
	for <linux-rdma@vger.kernel.org>; Fri,  5 Jun 2026 17:38:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780681117; cv=none; b=ebDuwgNVM5bncVL2zhi20AqwDJCHo3cvYjZuX9znheH7gy++WHQH8hIodDd4F6Eg7JcVCso9LEOUfIeRAXMCHvbQxHIJsyztZfqbZJXPr5smSxgwi1uuT4ud6Sv8irqjTHMb+cYDxty/qgmr77eVl3IjyZkS8eKqngkon3043Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780681117; c=relaxed/simple;
	bh=K7CQM4eliJj4wIiUfHWlYLWJDGHIdJ3cNCElgLyQKQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UoEyeSD+coRCVj69F9zpdbvaWYhlw+S1PEkKLjDczcjpGqiiM0jmXf13HO1TAmYyFiWZKJHaGI5psiEWR9V4nco+JxHMuGBf1Zm95z7/lXM4N4Df/k5HlAs7Jof9IIr7msMjUM0f3D/xlwXMlvsaiyShXgAnWiaOJZKv7NLHA8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhwjXUXO; arc=none smtp.client-ip=209.85.167.41
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa7a7c9711so2681211e87.0
        for <linux-rdma@vger.kernel.org>; Fri, 05 Jun 2026 10:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780681112; x=1781285912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01P7q67TBv+LoXRCSByZDo7vD+dZYPFTd1o6tohYeZs=;
        b=QhwjXUXObt3n4VRZgvPjX0m04fq0YZuCzO/bdP+iaDRKKzcY1+5RelfQJqdTEbBo18
         kxLBg26M7nZdhHjudbD2hRdIRDcM4TkCnv2C7HwfI0NTndgqEpmi9HjAt3siWAYdb9f6
         68Bei5Smb30hVitLrA0rbx+DIPNam5cFDai9dHCX4r00ruy9Tn6nigpORyGSqBZi+KKu
         7KLAh3a6fs9BKbadLZw4j/xt7kGY4uBzeAlhgQC7qN1fnWxouJDH9ZqR3/F+NVVAjz7A
         j+HbgwZihOn9bDK0QLEiyqfZ09cinNLLMznHeef4GBq4MTbdckavTdrHS1kFWqMr5ArJ
         cBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780681112; x=1781285912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=01P7q67TBv+LoXRCSByZDo7vD+dZYPFTd1o6tohYeZs=;
        b=QzzXc8AjmYOxi4En+kv8BaQCR8y3OqNJq/jmvOAENhZglhZjw049FBAhf/B7JzsJ8Q
         vN9dVBADyfuAPnT8HqvBwkHLRiEOe6XFJsde/1QNS0goQN9CBee1KnoCNSsxDrXGzLFz
         YSV6V3S2uXgl6ijd797snNLq9X6O28RPjGIRhNO5JVudHwHoNUGWwqGfEa/PeEV0mQ3f
         JpcxCw44ZwQ++N19VpyYI2ij9zkpJgNSI+xXWeS5xNmefPFyBpA0Ht+gUUCGS1vVnb2G
         l62dWtD8stu4K2NIuHlZBIZTkxdr+HZUphRcoOJE2qBlY6TROm0yozGC61rYVi5JFObp
         Hm8Q==
X-Forwarded-Encrypted: i=1; AFNElJ8bIzkUQFayy0aWBUDOb9I+6W5bwWEOkeSQDsEDMGaSIM8oA+Z/Te9mLlIVlHA3xA/Sn5Zu7EnpGNi6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1gPgRoy0I/8bnOfOQJbx+YUHm+c/KGTDRDojxLOhSeeBuzUex
	iEMqHVUWa3GKOXinvqwCujbxRKCJ8t/sWVPlRPWaBAum3rP5Yp2e4kYE
X-Gm-Gg: Acq92OEsmjurWcQmAvPvvi22K7mGt/pYl1SwHE/ZmlQgn46Xidc0ucqGK7uB+GYu5H8
	6uuZD//Fu6BRpSh//YgVLdWYci6++cMupF3vASZT8r6MssKsyqf1KBbQVFHcpYAf6PTKxndYYhB
	sBgH296Nkz/T8KI2FnpsnjZjxlC4JpFZlogjeviQMvsy3nIXaVIrNf0Vn9sT9ndjbePkU5h5Y//
	z1N0UgBA9Jc+AKB7Z4TkLhAAG4Aa0jxq2dj+uMAE9DE4UuzDKpmOM/hvfaDK9qpsmpHvWVa86vg
	O6OjRdP93E2S6uaecgCKA6FS4wmRu1OznVG9oxB5XRb632H8xrJfkfHtDFgD9KGA4MajtcMu36j
	QaC1E00hm6iP8e7yBhn92/ED1oKVWEL34hLhi4zm32KRiip/9kNgynupu/MxwX9OIGRO0SloQko
	Wn2IwhprlotSQ6mffRSgvjxKmwS7gJUazTKqOcIxin5ctoTHsoaE4Kd6jw5KSpiCmxmnmw
X-Received: by 2002:a05:6512:230f:b0:5aa:5edf:3311 with SMTP id 2adb3069b0e04-5aa886aa0bdmr966294e87.12.1780681112036;
        Fri, 05 Jun 2026 10:38:32 -0700 (PDT)
Received: from c0624c666cc5.devsec.astralinux.ru ([93.188.205.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b97ac34sm1973861e87.39.2026.06.05.10.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 10:38:31 -0700 (PDT)
From: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Vladislav Nikolaev <vlad102nikolaev@gmail.com>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Haggai Eran <haggaie@mellanox.com>,
	lvc-project@linuxtesting.org,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Doug Ledford <dledford@redhat.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com
Subject: Re: [lvc-project] [PATCH v2 5.10/5.15] RDMA/rxe: Fix the error "trying to register non-static key in rxe_cleanup_task"
Date: Fri,  5 Jun 2026 20:37:21 +0300
Message-ID: <20260605175333.5.10-5.15-v3-reply-vlad102nikolaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603174551-bf141bed5d94d0d92337aae2-pchelkin@ispras>
References: <20260603121902.274-1-vlad102nikolaev@gmail.com> <20260603174551-bf141bed5d94d0d92337aae2-pchelkin@ispras>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21861-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[vlad102nikolaev@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:pchelkin@ispras.ru,m:vlad102nikolaev@gmail.com,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:haggaie@mellanox.com,m:lvc-project@linuxtesting.org,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:yanjun.zhu@linux.dev,m:linux-kernel@vger.kernel.org,m:jgg@ziepe.ca,m:dledford@redhat.com,m:zyjzyj2000@gmail.com,m:syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linuxfoundation.org,mellanox.com,linuxtesting.org,kernel.org,linux.dev,ziepe.ca,redhat.com,syzkaller.appspotmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vlad102nikolaev@gmail.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,cfcc1a3c85be15a40cba];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47E5A64A4B3

On Wed, 3 Jun 2026 at 18:03:00 +0300, Fedor Pchelkin wrote:
> Moving it a couple of lines around requires some explanation why it's
> okay in 5.10/5.15 kernels.  Note that in upstream it was done by another
> commit 960ebe97e523 ("RDMA/rxe: Remove __rxe_do_task()").
>
> [ yeah, it should be safe to move the call but it'd better be stated
>   explicitly in the backporter's comment ]
>
> Worth saying that checkpatch.pl for the current patch gives:
>
> ERROR: trailing whitespace
> #52: FILE: drivers/infiniband/sw/rxe/rxe_qp.c:771:
> +^I$
>
> You might also want to consider porting 1c7eec4d5f3b ("RDMA/rxe: Fix
> "trying to register non-static key in rxe_qp_do_cleanup" bug") which fixes
> the similar problem for del_timer_sync / timer_delete_sync calls in this
> code.  This all could go as a series now probably.

Thanks for the review.

I have prepared v3 as a 5.10/5.15 series and addressed all three points:

1. extended the backporter's comment to explain why moving
   rxe_cleanup_task(&qp->resp.task) after the RC timer cleanup is safe
   for 5.10/5.15 even though upstream got that order via 960ebe97e523;
2. fixed the trailing whitespace;
3. added the backport of 1c7eec4d5f3b as the second patch in the series.

The updated series is available here:

https://lore.kernel.org/all/20260605171449.1760-1-vlad102nikolaev@gmail.com/

