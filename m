Return-Path: <linux-rdma+bounces-21873-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wwhmGOYmI2r9jQEAu9opvQ
	(envelope-from <linux-rdma+bounces-21873-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 21:43:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA07164B062
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 21:43:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ctaS8MkM;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21873-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21873-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC30630888AB
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 19:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A898441020;
	Fri,  5 Jun 2026 19:37:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC1E4418FF;
	Fri,  5 Jun 2026 19:37:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688277; cv=none; b=XWqOpiOWuMbiKnPwvldPco5PVMm7KSkZEGbtvGNnJ8Qz/YJ+8dIlBzpbAVBv8UZ2+IZK6EhHot6oElrVo46JZLuYG/7uQXO7ra2eLCHVVC0o4waG2xaqpjL4oX+kuu1vczGf/3OBheyRSV8saUrSGdjQ7xyHRTih5reBx/QspII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688277; c=relaxed/simple;
	bh=eBW079d2xQiXO+JShVeZcVB0hgdx4zjyQSCR20yGVoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRWGzppxj/pohzi0gf+A6ZImkHc83EjdPrMUgrak9QQ7q2T6xLFcPvIXB81GZK7LgRlmlCTa1ECI8jzowcsEpT3fWeGpOmD/zXA5lZwxCm3dNXtWj1QC8UX+UR9vHmRqX21w26eUQa8Jxoesn4Bozt0QHnQ7HauHX2pIU+kpMcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctaS8MkM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CAD1F00893;
	Fri,  5 Jun 2026 19:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688276;
	bh=/a7G7f25H4cU1CNJKSOc5D3i5C8CEpdGKn/zi7RTUoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ctaS8MkMgpfBt0k5G6nPd/VnKQB7A3lEId/1+XWMoV0i7qFcBNRIoSNroKdKKteTp
	 g5bl0Bs5Zilk5Dce7yiYDKLyObqW4C7KbMZsJuKF/V+z7BExoUiIHil/9pH6o3oZEO
	 TIbR8e96yyI7QYDs0gA5a3Hx/WdbJqoCtMALJKDaO4Deoz4/kR+19Im+yBKF0QwgCc
	 BLbuGNwkzm/YbtK9ONk6SOF/0Q7j1ONdWTcyLA/dVP7ktSumwPdQzAwWThthA1ZjqG
	 QnbODrqiW0sLHiC+yS82/PbAcMDcVjktt+nwSWpHqcMmUGDlSlB+/IpVx73woHtirj
	 6MA41hakqiBdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Vladislav Nikolaev <vlad102nikolaev@gmail.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Haggai Eran <haggaie@mellanox.com>,
	Kamal Heib <kamalh@mellanox.com>,
	Amir Vadai <amirv@mellanox.com>,
	Moni Shoua <monis@mellanox.com>,
	Yonatan Cohen <yonatanc@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Yanjun <yanjunz@nvidia.com>,
	lvc-project@linuxtesting.org,
	syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 5.10/5.15] RDMA/rxe: Fix the error "trying to register non-static key in rxe_cleanup_task"
Date: Fri,  5 Jun 2026 15:37:28 -0400
Message-ID: <20260605-stable-reply-0021@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603121902.274-1-vlad102nikolaev@gmail.com>
References: <20260603121902.274-1-vlad102nikolaev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21873-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:vlad102nikolaev@gmail.com,m:zyjzyj2000@gmail.com,m:dledford@redhat.com,m:jgg@ziepe.ca,m:haggaie@mellanox.com,m:kamalh@mellanox.com,m:amirv@mellanox.com,m:monis@mellanox.com,m:yonatanc@mellanox.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yanjunz@nvidia.com,m:lvc-project@linuxtesting.org,m:syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com,m:yanjun.zhu@linux.dev,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,redhat.com,ziepe.ca,mellanox.com,vger.kernel.org,nvidia.com,linuxtesting.org,syzkaller.appspotmail.com,linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,cfcc1a3c85be15a40cba];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA07164B062

> [PATCH v2 5.10/5.15] RDMA/rxe: Fix the error "trying to register non-static key in rxe_cleanup_task"

I'm dropping this for now; it isn't right for either branch as submitted:

 - 5.15.y: the bug doesn't exist there -- the task locks are already
   spin_lock_init()'d on the QP-create error path.
 - 5.10.y: mis-targeted -- it patches rxe_qp_do_cleanup(), but the 5.10
   error-unwind path doesn't call rxe_cleanup_task() there.

-- 
Thanks,
Sasha

