Return-Path: <linux-rdma+bounces-21687-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gxbeIp1NIGrL0gAAu9opvQ
	(envelope-from <linux-rdma+bounces-21687-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 17:51:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8195B6396D8
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 17:51:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ispras.ru header.s=default header.b=leHXl3MO;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21687-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21687-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ispras.ru;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C879830AE3B8
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 15:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F0C396D2E;
	Wed,  3 Jun 2026 15:03:13 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868E43A875E;
	Wed,  3 Jun 2026 15:03:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498992; cv=none; b=ejK2LZOfUGtdYyV1Qmd/4x8MHF1dkCh+LcVHhfAaMFfDr23oOaSCXKnN3+sJAvtQ0pb0TznbDaQZFR7zZTaMI/YGK8YalxgmdEQBPAsceaWwljtjQusq9Swja6obzH9HK5mXFuwMO/wcRw2RuHad041YZxALEBzXPDotWkMP9Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498992; c=relaxed/simple;
	bh=fVStYaPDFPkaF/zE2ALMb76pTMOs+EcNbjFty3BTAmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEOw03npKiPBWNBhUvaKSCyAYHMJWuY/cNSWisXEdd1PPp0TaoYi7GnBqJD5cMKj+pO4mpvAxryoyAaf2X3QsNrJyW9f5mDP3wED6gBmz2mh89QLTI2GdznMtJrwIUsmCgIoZ0fi3g82uBroh9Lh0TkKF6azu1sk5PUW7fzDh+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=leHXl3MO; arc=none smtp.client-ip=83.149.199.84
Received: from localhost (unknown [10.10.165.2])
	by mail.ispras.ru (Postfix) with ESMTPSA id 851D045F7992;
	Wed,  3 Jun 2026 15:03:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 851D045F7992
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1780498980;
	bh=QchPKXbbQw3rf90KpShXn9iijaSWPXuapINO6GIxiqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=leHXl3MOb3uUUUoy5H79bC1XYrP/PqNU/WACFpwRiwOtwdW7M87ykElOGofbg9TQp
	 EzfY+nwHOa75wCIbrlLVwJ80bqlHNU9X/Z/bQKLMblSZxI4KmQvex+NulcFsZTFy/L
	 kwEfUFZEFASV0Fdekha8swt5TvHQ0OHfndsczo5A=
Date: Wed, 3 Jun 2026 18:03:00 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
Cc: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Haggai Eran <haggaie@mellanox.com>, lvc-project@linuxtesting.org, 
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
	Doug Ledford <dledford@redhat.com>, Zhu Yanjun <zyjzyj2000@gmail.com>, 
	syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com
Subject: Re: [lvc-project] [PATCH v2 5.10/5.15] RDMA/rxe: Fix the error
 "trying to register non-static key in rxe_cleanup_task"
Message-ID: <20260603174551-bf141bed5d94d0d92337aae2-pchelkin@ispras>
References: <20260603121902.274-1-vlad102nikolaev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260603121902.274-1-vlad102nikolaev@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:vlad102nikolaev@gmail.com,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:haggaie@mellanox.com,m:lvc-project@linuxtesting.org,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:yanjun.zhu@linux.dev,m:linux-kernel@vger.kernel.org,m:jgg@ziepe.ca,m:dledford@redhat.com,m:zyjzyj2000@gmail.com,m:syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[pchelkin@ispras.ru,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21687-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,linux-rdma@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,mellanox.com,linuxtesting.org,kernel.org,linux.dev,ziepe.ca,redhat.com,gmail.com,syzkaller.appspotmail.com];
	TAGGED_RCPT(0.00)[linux-rdma,cfcc1a3c85be15a40cba];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DKIM_TRACE(0.00)[ispras.ru:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ispras:mid,linux.dev:email,checkpatch.pl:url,syzkaller.appspot.com:url,appspotmail.com:email,ispras.ru:from_mime,ispras.ru:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8195B6396D8

On Wed, 03. Jun 15:18, Vladislav Nikolaev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> commit b2b1ddc457458fecd1c6f385baa9fbda5f0c63ad upstream.
> 
> In the function rxe_create_qp(), rxe_qp_from_init() is called to
> initialize qp, internally things like rxe_init_task are not setup until
> rxe_qp_init_req().
> 
> If an error occurred before this point then the unwind will call
> rxe_cleanup() and eventually to rxe_qp_do_cleanup()/rxe_cleanup_task()
> which will oops when trying to access the uninitialized spinlock.
> 
> If rxe_init_task is not executed, rxe_cleanup_task will not be called.
> 
> Reported-by: syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=fd85757b74b3eb59f904138486f755f71e090df8
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Fixes: 2d4b21e0a291 ("IB/rxe: Prevent from completer to operate on non valid QP")
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Link: https://lore.kernel.org/r/20230413101115.1366068-1-yanjun.zhu@intel.com
> Signed-off-by: Leon Romanovsky <leon@kernel.org>
> [ Vladislav: match upstream cleanup order and add the missing
> resp.task.func check. ]
> Signed-off-by: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
> ---

Thanks for the update.

> v2: Move rxe_cleanup_task(&qp->resp.task) after RC timer cleanup.
> Add missing qp->resp.task.func check before cleaning up the responder task.

I did actually suggest only adding a corresponding check for the
rxe_cleanup_task(&qp->resp.task) call which the upstream commit performs.
Moving it a couple of lines around requires some explanation why it's
okay in 5.10/5.15 kernels.  Note that in upstream it was done by another
commit 960ebe97e523 ("RDMA/rxe: Remove __rxe_do_task()").

[ yeah, it should be safe to move the call but it'd better be stated
  explicitly in the backporter's comment ]

Worth saying that checkpatch.pl for the current patch gives:

ERROR: trailing whitespace
#52: FILE: drivers/infiniband/sw/rxe/rxe_qp.c:771:
+^I$

You might also want to consider porting 1c7eec4d5f3b ("RDMA/rxe: Fix
"trying to register non-static key in rxe_qp_do_cleanup" bug") which fixes
the similar problem for del_timer_sync / timer_delete_sync calls in this
code.  This all could go as a series now probably.


