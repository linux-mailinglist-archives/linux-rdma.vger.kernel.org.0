Return-Path: <linux-rdma+bounces-17108-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPbGGxV2nWmAQAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17108-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 10:57:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 982B518505A
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 10:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ED5D305B971
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 09:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C635A372B58;
	Tue, 24 Feb 2026 09:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lb79iowD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DF3366DD6;
	Tue, 24 Feb 2026 09:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771927026; cv=none; b=TOQyFH18R09yIiwfBghbEcje9O7Pe834mdys3h9nOR95Om8yolR6L4AmbjggFwXbdMKYirYDoN0zgcKDsmf5ad3VP+K/R+k/OzNFnFnC42ZjxASRqHR9nfPs2NMDZqDkZ2gKJSRjznrsSgtreB7QaX3R30w8uopuUKC25ps8clo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771927026; c=relaxed/simple;
	bh=gJ0a/DuWWvFxCE7wNrFcN4fCzQPYX3s8CZ/Ba2W0GVc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a4zUx6WQKN5VqdmA9+wfnU12inr6L02Iv3NqdWDdA5S9rsPO+FXQ9JZKFLQhwWfSOyMabAT8r090P4w/KLrQ3pdV5IrBBqk/eFgKFAFMEgmiBB4U7dAWVdUykUbCXgoZsKMKwgnQSzlpgI81FURnOCKLreQITq8E8wmI2gFc88I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lb79iowD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EB4C116D0;
	Tue, 24 Feb 2026 09:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771927026;
	bh=gJ0a/DuWWvFxCE7wNrFcN4fCzQPYX3s8CZ/Ba2W0GVc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lb79iowDnkkX+nAPiNeFWQuPWlyVcaIqw0/vHRdG+BfHBB/z6jUxoy+AH12fNfg+Q
	 1l0jlOL86dSchPzOO4xMW/DvfJIVbmPraYLQrZNV+Sck/74vASHveypVFpx+5K/Plj
	 vKYyDsxdlpKNkxcrCNNJnydXFf19iJBm5e75c2qH53So5XranlkugNo53psXMLrkuO
	 7KiK4nkDYLVvyB+edt4ynSElXRbQNU563IT29LL62BwjMXy3aXvBlLpTSRlJ/3pQNA
	 utqeGnEDSpwOIr3jjuValriD4vBoa0PpL+Rk01kvfUymD2NmYvbEEODcQTPnyFjA4e
	 +QyDgTNfXN+LQ==
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <zyjzyj2000@gmail.com>, Evan Green <evgreen@meta.com>
Cc: wguay@meta.com, Zhu Yanjun <yanjun.zhu@linux.dev>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org, 
 linux-rdma@vger.kernel.org
In-Reply-To: <20260220185533.252759-1-evgreen@meta.com>
References: <20260220185533.252759-1-evgreen@meta.com>
Subject: Re: [PATCH v2] RDMA/rxe: Generate async error for r_key violations
Message-Id: <177192702321.747658.12819650313052064975.b4-ty@kernel.org>
Date: Tue, 24 Feb 2026 04:57:03 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-47773
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17108-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,meta.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 982B518505A
X-Rspamd-Action: no action


On Fri, 20 Feb 2026 10:55:04 -0800, Evan Green wrote:
> Table 63 of the IBTA spec lists R_Key violations as a class C
> error. 9.9.3.1.3 Responder Class C Fault Behavior indicates an
> affiliated asynchronous error should be generated at the responder
> if the error can be associated to a QP but not a particular RX WQE.
> 
> Relevant portion of the spec:
> C9-222.1.1: For an HCA responder using Reliable Connection service, for
> a Class C responder side error, the error shall be reported to the
> requester by generating the appropriate NAK code as specified in Table 63
> Responder Error Behavior Summary on page 448. If the error can be related
> to a particular QP but cannot be related to a particular WQE on that
> receive queue (e.g. the error occurred while executing an RDMA Write
> Request without immediate data), the error shall be reported to the
> responder’s client as an Affiliated Asynchronous error. See Section
> 10.10.2.3 Asynchronous Errors on page 576 for details. If the error can be
> related to a particular WQE on a given receive queue, the QP shall be
> placed into the error state and the error shall be reported to the
> responder’s client as a Completion error.
> 
> [...]

Applied, thanks!

[1/1] RDMA/rxe: Generate async error for r_key violations
      https://git.kernel.org/rdma/rdma/c/f3f9825837dfdc

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


