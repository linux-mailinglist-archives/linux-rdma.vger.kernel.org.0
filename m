Return-Path: <linux-rdma+bounces-17955-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEAQLkExsWm0rwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17955-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 10:09:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9A5260069
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 10:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85B5C333E6D5
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 09:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7FB3C5DD9;
	Wed, 11 Mar 2026 09:02:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from arkamax.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD08B3C73E4;
	Wed, 11 Mar 2026 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.116.240.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219754; cv=none; b=QE3knk74k5TwTM63onJb4b6J0Z3sAtbhGbJEWqeBwDy9C40cBHNwZqdtFWZoQAlPwo34Q9UZ6pFmntV4NamcVjpQTa+Pk99binzkLam1xF6r//NuH1CFbbRct6qM6Ha2pCo9tQ7KcuxW5sKkmKluX8dzcJWKSo+6bKsdVhgYL7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219754; c=relaxed/simple;
	bh=jIs1IR+nAIAo0v4hnk+3f8YoL3lzNXLtYM7TSazbQF4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=oidOrQG0V62He9SdPFh7KtYMGOxqSNPsQ9IYKYhKnzT2+QiOx32+5WVy+YO6nJ+fL5YXb2DeNgrzgZjJxolUMCr/kLwRUe737uY7TuHbOvsRZnOjQlYuLKhh33/RDi64lZ815bcFJoP4HvkiOlFlbW4Dnf8O4G6R22/z4c3dogo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arkamax.eu; spf=pass smtp.mailfrom=arkamax.eu; arc=none smtp.client-ip=128.116.240.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arkamax.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamax.eu
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 7f0d0655 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Mar 2026 10:02:21 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 10:02:21 +0100
Message-Id: <DGZTXRKSHBPC.2B318HF53ZRSN@arkamax.eu>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v7.0-rc1 kernel
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Maurizio Lombardi" <mlombard@arkamax.eu>, "Yi Zhang"
 <yi.zhang@redhat.com>, "Shinichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
X-Mailer: aerc 0.21.0
References: <aZ_-cH8euZLySxdD@shinmob>
 <CAHj4cs8mzSZez+n2qLu5931YAuQ4=RxNt6D6YJCsMEwGrm4UtA@mail.gmail.com>
 <DGZRYXTKC049.1I6QFQSMSD88H@arkamax.eu>
In-Reply-To: <DGZRYXTKC049.1I6QFQSMSD88H@arkamax.eu>
X-Rspamd-Queue-Id: 5D9A5260069
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17955-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[arkamax.eu];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.970];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mlombard@arkamax.eu,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arkamax.eu:mid]
X-Rspamd-Action: no action

On Wed Mar 11, 2026 at 8:29 AM CET, Maurizio Lombardi wrote:
> On Wed Mar 11, 2026 at 1:35 AM CET, Yi Zhang wrote:
>
> If nvmet_rdma_rw_ctx_init() fails, shouldn't it call
> nvmet_req_free_sgls() before returning an error?

Possible fix, not tested:

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 2d6eb89f98af..79ae743bb405 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -892,7 +892,7 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_r=
sp *rsp,

 	ret =3D nvmet_rdma_rw_ctx_init(rsp, addr, key, &sig_attrs);
 	if (unlikely(ret < 0))
-		goto error_out;
+		goto error_free_sgl;
 	rsp->n_rdma +=3D ret;

 	if (invalidate)
@@ -900,6 +900,8 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_r=
sp *rsp,

 	return 0;

+error_free_sgl:
+	nvmet_req_free_sgls(&rsp->req);
 error_out:
 	rsp->req.transfer_len =3D 0;
 	return NVME_SC_INTERNAL;

Maurizio

