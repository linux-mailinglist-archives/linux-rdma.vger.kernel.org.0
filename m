Return-Path: <linux-rdma+bounces-23067-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fqBWHXNUU2qAZwMAu9opvQ
	(envelope-from <linux-rdma+bounces-23067-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 10:46:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB94744307
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 10:46:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QUV+uqrx;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23067-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23067-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16C46300FC78
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 08:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAB939656D;
	Sun, 12 Jul 2026 08:46:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CDA36AB57;
	Sun, 12 Jul 2026 08:46:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783845999; cv=none; b=eB9kGpkzsN03u5rYaeFeAusAwZcriS2hOVxXATYABaxBVq6IH/9DNEn5hRvrIoMMFQo636kRF7AT8e138egs7Kg8XSdza0KT81kjvMzJ14DTTHFDk4I/vgWvx1RvutwCnxryosdRs31JIhxEka86Ok93BXFht34CQnC5Y2ebweI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783845999; c=relaxed/simple;
	bh=s/D5ODUCcEVFL7Mv0J9bDQXbSLS8gri2bhQa0Sii7OQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EsjkLRXFdn8TcX4PSfERP5QHwu7pEGnEIJbIKnoiKAEyPswWEuPfedpphbtrjqSSCFCEHAIYv5/7tXz2NBCCyZ37qw72E3MbeTxFZUdytwH8WSfIJ064tc/ODyFUhN0GMTR8KPJyCoqCrNGo6JAwvVj8FkgNigI8AXgrCDFeV9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUV+uqrx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5571F000E9;
	Sun, 12 Jul 2026 08:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783845997;
	bh=Skc1WU+sxzEwPxc4ZKXCXZ76mJvgp8T0D9xNMu6R2Q8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QUV+uqrxLx4KakZkC00niXBxE4pXe6KUfkG0m9GDlQYlckDPk4zRwcD+fr65MtUi2
	 ArQ8+EQiM1OCoAjDV0heYV7WVB+UP3ZQzomyQerOAI6XksGFJjHzJV4htWsxdIkz63
	 UauWBteMB9y6032pXziMrfiD2jjenlbGvbEWyqyQjkWNPMVPGifOHce3Hkmy9k3CDy
	 7uRz9Qyx9/JNMRypa8Al8T6dbSdiDinwpkunZq1WHFdEXljVE+lF1NHgG+/1tbdyxe
	 tuXaUtw6pekdc55BQpFYlYTJaaq/OSmpu4HwPoCbuFetr6liQDSFWJ326meUb2T+/n
	 p77Ewe91uGHiA==
From: Leon Romanovsky <leon@kernel.org>
To: xuhaoyue1@hisilicon.com, Alexander.Chesnokov@kaspersky.com
Cc: David Laight <david.laight.linux@gmail.com>, 
 lvc-project@linuxtesting.org, Oleg.Kazakov@kaspersky.com, 
 Pavel.Zhigulin@kaspersky.com, Wenpeng Liang <liangwenpeng@huawei.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Xi Wang <wangxi11@huawei.com>, 
 Weihang Li <liweihang@huawei.com>, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260709050327.3547237-1-Alexander.Chesnokov@kaspersky.com>
References: <20260709050327.3547237-1-Alexander.Chesnokov@kaspersky.com>
Subject: Re: [PATCH v3] RDMA/hns: Compute HEM index in 64-bit in
 hns_roce_v2_set_hem()
Message-Id: <178384599488.1550388.5775639238568762415.b4-ty@kernel.org>
Date: Sun, 12 Jul 2026 04:46:34 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-23067-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xuhaoyue1@hisilicon.com,m:Alexander.Chesnokov@kaspersky.com,m:david.laight.linux@gmail.com,m:lvc-project@linuxtesting.org,m:Oleg.Kazakov@kaspersky.com,m:Pavel.Zhigulin@kaspersky.com,m:liangwenpeng@huawei.com,m:jgg@ziepe.ca,m:wangxi11@huawei.com,m:liweihang@huawei.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linuxtesting.org,kaspersky.com,huawei.com,ziepe.ca,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AFB94744307


On Thu, 09 Jul 2026 08:03:27 +0300, Alexander.Chesnokov@kaspersky.com wrote:
> In hns_roce_v2_set_hem() the HEM address indices are computed from
> i, j and k (the base-chunk_ba_num decomposition of the 32-bit
> table_idx) in 32-bit arithmetic and then assigned to u64 fields.
> The recombined value always equals table_idx and cannot exceed
> U32_MAX, so this is not a reachable overflow and has no user-visible
> impact. Declare i, j and k as u64 so the calculation is done in
> 64-bit and the pattern no longer trips static analyzers.
> 
> [...]

Applied, thanks!

[1/1] RDMA/hns: Compute HEM index in 64-bit in hns_roce_v2_set_hem()
      https://git.kernel.org/rdma/rdma/c/923e1cb4e525bb

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


