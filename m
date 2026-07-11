Return-Path: <linux-rdma+bounces-23038-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cEVIJbCvUWpsHQMAu9opvQ
	(envelope-from <linux-rdma+bounces-23038-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 04:51:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BA87400A7
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 04:51:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iUABoD6e;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23038-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23038-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6CCA3022943
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 02:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A346C27D786;
	Sat, 11 Jul 2026 02:51:20 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4E6136358;
	Sat, 11 Jul 2026 02:51:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783738280; cv=none; b=SuHsV2I6Byy8J6ZM9vphAayr4jPCrHdngShcQnJKWZ9Jr6YHLSnBAqUv7JueMl/qAYNBPj0BBXdw2yoay10w4KVouiCyCspOM07F5Zh6sin7cNP19y/WJtGiRar8C3i9vZKN5DrgOx8UjZWqKlLjvKcK1plCDQRafKyp/R7lQ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783738280; c=relaxed/simple;
	bh=bd18IFWQpM0ebcomxZuB4L4ko5eV8jmQgUxrqLup2K4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BH2JnW2KtQHG/AY0SNx5rNBCrq1XdOamQRJh6t4enN9JVxdZM0mRelA4dfYEQkQUO+4fAgV0hD+ZU8HrzQczfS1ekdav9lE0ji+wHjh9pVjkAO3DJXtthU/fXKiu+L/XO63zmfcqBzh2fxYrRIN2aggT9rLnK7Fid+TrJZ7WkPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUABoD6e; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34FC1F000E9;
	Sat, 11 Jul 2026 02:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783738279;
	bh=nXlCt7TQl+2YOnusGTjqwb0r34TzcUVXdjnfZeLEByU=;
	h=From:To:Cc:Subject:Date;
	b=iUABoD6e0AQcDY/66yiUjr8s5ujJyayiyTZjoxOX+z5wqMkxrnqEKEtpy918KEAfp
	 W2NdhtJNLPNyVPPA8UQ1RkESkD8tA8J4Qab9lSA5at+WQbEcnobQT3VF3p4Yx75z8t
	 47XjxlQX0KtUgSA1ZGssz8aZV0QEFDqoji6SA9SACv1rdVRZlFoZSZLP3LpIiktrwl
	 BmLaY1RvVo2Is572dcBoOqSp+ad1iyxcAien1Z4w4TUcDougKPPbE0n4kbuLB6eJoH
	 uDlj4MDM8kyUf/5jpcKNtN5lX02n62JpHLDjq0latWc1IeKO1pD4sjAHq1n4ZfdJFz
	 +fkjXyvMWJM4Q==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org
Cc: achender@kernel.org
Subject: [PATCH net 0/3] net/rds: Bug fix ports
Date: Fri, 10 Jul 2026 19:51:15 -0700
Message-Id: <20260711025118.2449428-1-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23038-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:achender@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13BA87400A7

Hi all,

This is a small set of net/rds bug fixes ported from uek to upstream
rds.  I've been working on extending the rds selftest case, but need to
stabilize a few more bugs and the first few fall into net with Fixes
tags. I decided to leverage fable for this set and I thought the ports we
clean and well explained.

[PATCH net 1/3] net/rds: don't use unpin_user_pages_dirty_lock() from atomic context
   Port: commit 4d4a5551a1d2 ("net/rds: Avoid unpin_user_pages_dirty_lock() in tasklets")
   https://github.com/oracle/linux-uek/commit/4d4a5551a1d2

[PATCH net 2/3] net/rds: hold the socket while an rds_mr references it
   Port: commit c4d69e511f3b ("rds: Add proper refcnt when an RDS MR references an RDS Socket")
   https://github.com/oracle/linux-uek/commit/94549e4732d8

[PATCH net-next 3/7] net/rds: fix rds_message leak in the rds_send_xmit() drop path
  Port: commit 94549e4732d8 ("net/rds: fix rds_message memleak in rds_send_xmit")
  https://github.com/oracle/linux-uek/commit/94549e4732d8

These were carved out of a larger porting effort, but I'll follow up with a few more
targeted for net-net after these land in net.

Question and comments appreciated! 

Thanks,
Allison

Gerd Rausch (1):
  net/rds: don't use unpin_user_pages_dirty_lock() from atomic context

Håkon Bugge (1):
  net/rds: hold the socket while an rds_mr references it

Sharath Srinivasan (1):
  net/rds: fix rds_message leak in the rds_send_xmit() drop path

 net/rds/rdma.c | 25 +++++++++++++++++++++----
 net/rds/send.c | 12 ++++++++++--
 2 files changed, 31 insertions(+), 6 deletions(-)

-- 
2.25.1


