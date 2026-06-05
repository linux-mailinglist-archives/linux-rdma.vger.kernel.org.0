Return-Path: <linux-rdma+bounces-21872-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nAoTDromI2r2jQEAu9opvQ
	(envelope-from <linux-rdma+bounces-21872-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 21:42:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0060F64B051
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 21:42:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Af785c+4;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21872-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21872-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79815306FC19
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 19:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B19943E9C3;
	Fri,  5 Jun 2026 19:37:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186DD43E4A6;
	Fri,  5 Jun 2026 19:37:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688275; cv=none; b=Myg5cLzG3wmW9AFXOaz+dWE3jJ7ZZ1J72PW8/L016DBtMlSooQbnH3f/9MFg6I1wxo1i+JcaO+kAex4oqhom/gosm6mkVDN7Cj2SwRp2miDwmhnO9jvrs5svnnJTsSnfUgpyBFjIy+/WvGY29SFUXySYjpApx+W5UNH/oLlhdLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688275; c=relaxed/simple;
	bh=PpME3o5V3q/AO5KvgabF8eylQMra9FJR5/1IMqkJYUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3361zIaoYlH23X7Q/xeBEXnXsmTOJaEZIrVhiaZODxNYfw/eA1k3rQlsYyxC3ogRuZoMpoQcGn7GbVniTTvbQzQG5zwZ++fwG+ENxgXEz/AJVWaAOgqBPXK2Yd0atr7tqfFXFC8b+WYc7VCrhKhVtCr0H4uwrWWHZZ3IAHRnCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Af785c+4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB671F00898;
	Fri,  5 Jun 2026 19:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688274;
	bh=GLotKGV1kavKVuKP/Zy1OFsCxYQdyASFbMsRhbq+uT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Af785c+4p8zDEMy/B7d1LVkI25MmdpILxbpYtqWS07gRa6iwzLvin8T/uK+bhAFqP
	 QMQjcKMg2M2GxVJbfvaOGg5eugyNMKy3B49ku9utqP5/+iJHOiOXEeeW0TkTD4wY4r
	 3U8O7ERHIIppocZd/v/60vYs4IUJCQwLIhx85ZeRYuJYoCslDKnwOSAmbdKA7IXUh+
	 tKvdLWgwY1FIvIk2FRW9Wr+7rRJZFZ4iIVUXnfj8SVMSJrzp/KQ3s3boBAqvw1M2JP
	 yccohWdAlG/yLf9uUVXXjglqkMOllXiA+DAxvO8AW3GrNBS+OuFIGP2ebu1RUNXVdj
	 2XjoxDrjqO2CQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Haggai Eran <haggaie@mellanox.com>,
	Kamal Heib <kamalh@mellanox.com>,
	Amir Vadai <amirv@mellanox.com>,
	Moni Shoua <monis@mellanox.com>,
	Yonatan Cohen <yonatanc@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Zhu Yanjun <yanjunz@nvidia.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Vladislav Nikolaev <vlad102nikolaev@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 6.1] RDMA/rxe: Complete the rxe_cleanup_task backport
Date: Fri,  5 Jun 2026 15:37:27 -0400
Message-ID: <20260605-stable-reply-0020@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603132729.423-1-vlad102nikolaev@gmail.com>
References: <20260603132729.423-1-vlad102nikolaev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21872-lists,linux-rdma=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:zyjzyj2000@gmail.com,m:dledford@redhat.com,m:jgg@ziepe.ca,m:haggaie@mellanox.com,m:kamalh@mellanox.com,m:amirv@mellanox.com,m:monis@mellanox.com,m:yonatanc@mellanox.com,m:leon@kernel.org,m:yanjunz@nvidia.com,m:sashal@kernel.org,m:vlad102nikolaev@gmail.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,linuxtesting.org];
	FREEMAIL_TO(0.00)[vger.kernel.org,linuxfoundation.org,gmail.com,redhat.com,ziepe.ca,mellanox.com,kernel.org,nvidia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0060F64B051

> [PATCH 6.1] RDMA/rxe: Complete the rxe_cleanup_task backport

Queued for 6.1.y, thanks.

-- 
Thanks,
Sasha

