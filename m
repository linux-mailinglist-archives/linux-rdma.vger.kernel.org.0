Return-Path: <linux-rdma+bounces-20849-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB1LMMLTCWpYrgQAu9opvQ
	(envelope-from <linux-rdma+bounces-20849-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 16:42:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4350F561B7F
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 16:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A27530125D5
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 14:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14BF30C372;
	Sun, 17 May 2026 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlsV01Kh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FD629D291;
	Sun, 17 May 2026 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779028919; cv=none; b=Rf+XRWEOpMc74ciwdze4JAQL4pBbljzkF3iqk23uXdmtbjVthGmTKBVpGILjzBlTW+2KEaYgJxQHRuOWyuC0rNrF61wAEBPI8QGpKdhF1BBD9vCvYpwIFIb6mPogR0xNZk3DgL9IdF59FaLi0pNtSHHnlWsKzCDTDgI2dVi/iJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779028919; c=relaxed/simple;
	bh=lxEUNBF/X9GrJJBtOgHah+kcKIy3p3KF7c81h6AZTL4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BgtTKhb5S/cdxmHS6SiTUdZ0ZPAXSQVZPrj4ndgruxhReNuJOqL7R+fLDCwhfOu6fu1wSVc/wHUhgPr7dGbhyVpHiAUwsyKIwqpDo5JqpMkBxgzOlM/bWxZGXfEdF0A9dYboLTa7m9VjoRXwSO/ACSF0ycTZwD8a2y+mPTEBNXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlsV01Kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725DDC2BCB0;
	Sun, 17 May 2026 14:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779028918;
	bh=lxEUNBF/X9GrJJBtOgHah+kcKIy3p3KF7c81h6AZTL4=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=jlsV01KhCSr1vn9DhaBTq9YC7t2q1CQB7zrTdHhgvOD0LgS58eu30e0srvKZ1Xj65
	 pav0lCEtSG0BbvLLDt8duKmYbfGvZXSizKvuP4qxRG1LLApE9C19SbZAhOLY75oUp2
	 Ragq8naFwqup6TzfxpIgTFuXDZ7azDkp14hiT9gMuHd0drL7sV8UwKmDO6Z0+K4Ire
	 4C6J759mqpSNBe4vTKjbzRe+8x/frxsD8ZQ34E/zIHd8BVq2j/moJiNib34ln2iKlN
	 MqAtASFTNq/bXPQ2Tg+75eP5euT+Cvd8/3czxwj5pc/VUNz/R0139zuhpzXhx1YVYy
	 9dhmYHSJSl0Og==
From: Leon Romanovsky <leon@kernel.org>
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
 Jack Wang <jinpu.wang@ionos.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Vaishali Thakkar <vaishali.thakkar@ionos.com>, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Guangshuo Li <lgs201920130244@gmail.com>
In-Reply-To: <20260514113834.865530-1-lgs201920130244@gmail.com>
References: <20260514113834.865530-1-lgs201920130244@gmail.com>
Subject: Re: [PATCH v3] RDMA/rtrs: Fix use-after-free in path file creation
 cleanup
Message-Id: <177902891596.2528570.17247717045372366174.b4-ty@kernel.org>
Date: Sun, 17 May 2026 10:41:55 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Queue-Id: 4350F561B7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20849-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ionos.com,ziepe.ca,vger.kernel.org,gmail.com];
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
X-Rspamd-Action: no action


On Thu, 14 May 2026 19:38:34 +0800, Guangshuo Li wrote:
> In the error path of rtrs_srv_create_path_files(), the sysfs root folders
> may already have been created and srv_path->kobj may already have been
> initialized. If a later step fails, the cleanup currently calls
> kobject_put(&srv_path->kobj) before
> rtrs_srv_destroy_once_sysfs_root_folders(srv_path).
> 
> kobject_put() may drop the last reference to srv_path->kobj and invoke the
> release callback, rtrs_srv_release(), which frees srv_path. The following
> call to rtrs_srv_destroy_once_sysfs_root_folders(srv_path) then
> dereferences srv_path internally to access srv_path->srv, resulting in a
> use-after-free.
> 
> [...]

Applied, thanks!

[1/1] RDMA/rtrs: Fix use-after-free in path file creation cleanup
      https://git.kernel.org/rdma/rdma/c/df07e2abe7e8a1

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


