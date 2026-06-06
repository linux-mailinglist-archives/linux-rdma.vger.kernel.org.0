Return-Path: <linux-rdma+bounces-21910-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nSxAAJySJGqP8wEAu9opvQ
	(envelope-from <linux-rdma+bounces-21910-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 23:35:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD4E64E6A4
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 23:35:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21910-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21910-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=stambelongroup.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9EC583006D5A
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Jun 2026 21:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128AA3C062F;
	Sat,  6 Jun 2026 21:26:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.stambelongroup.com (mail.stambelongroup.com [107.174.218.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC09B3BC68A
	for <linux-rdma@vger.kernel.org>; Sat,  6 Jun 2026 21:26:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780781202; cv=none; b=Ft/xSgde2/r4a7rDqx6qEPVUvGG0cjiWleetyz4cFcin1y0BW4GupwaYME3hhUFfGkEnimsUzXVtBBrKlKC1d+Lb5M6jhBEEuYAchoIQth7vLM53YR9C8d7VZW9anhaXWSM87WLq8EQWhHB+yCG4FkZLG4MSNSR3NXmxRUfpQ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780781202; c=relaxed/simple;
	bh=ZuJ3PDPfFHIGrz+BnC6ldsjnzgVdycP9Rob0jeFaVPA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VoBm0Q+nVO15sI6OtIfKZc7PMdxTppGT2OmTVvlP0hf6uOhYvmn4NbRvYnmhnj/BNwFQAJzI9wq1/9STpPV1XZ2FpiLJPKuLsj3qlmHgm3aB6HJ1dKmNGFUvzbwM3S8++JCq09Va/lSMvw9PT/1wVYNZUGOhcY4lSoj/5veHhLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=stambelongroup.com; spf=pass smtp.mailfrom=stambelongroup.com; arc=none smtp.client-ip=107.174.218.112
Received: from 107-172-247-111-host.colocrossing.com (unknown [107.172.247.111])
	by mail.stambelongroup.com (Postfix) with ESMTPSA id 58FC1191F63
	for <linux-rdma@vger.kernel.org>; Sat,  6 Jun 2026 21:17:32 +0000 (UTC)
Reply-To: ebrahimbinmohamed@zohomail.com
From: Ebrahim Bin Mohamed <info@stambelongroup.com>
To: linux-rdma@vger.kernel.org
Subject: Zoom Meeting Invitation
Date: 6 Jun 2026 17:17:32 -0400
Message-ID: <20260606171731.F4BD0F824B7BC851@stambelongroup.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: add header
X-Spamd-Result: default: False [9.34 / 15.00];
	MSBL_EBL(7.50)[ebrahimbinmohamed@zohomail.com:replyto];
	DMARC_POLICY_REJECT(2.00)[stambelongroup.com : SPF not aligned (relaxed), No valid DKIM,reject];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21910-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER(0.00)[info@stambelongroup.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[info@stambelongroup.com,linux-rdma@vger.kernel.org];
	HAS_REPLYTO(0.00)[ebrahimbinmohamed@zohomail.com];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DD4E64E6A4
X-Spam: Yes

Hi,
We provide flexible funding solutions .
Let us know so that we can schedule a zoom meeting .

Regards,
Ebrahim Bin Mohamed

