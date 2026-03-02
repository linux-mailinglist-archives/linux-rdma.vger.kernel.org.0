Return-Path: <linux-rdma+bounces-17371-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMOeD8VqpWkaAQYAu9opvQ
	(envelope-from <linux-rdma+bounces-17371-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 11:47:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3351D6CA3
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 11:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 495D130363F6
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 10:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7B9335067;
	Mon,  2 Mar 2026 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fb08ir6G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30000332ED0;
	Mon,  2 Mar 2026 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772448126; cv=none; b=VxYiM4JppZFk6iTQ+qdmSLFNPZnaEnPg3mQnGLu86GOEpL+JMGKrUOxpJzwfBi0zgZt8GA+Tu95Yk2E3McygvOdRSuzN+2qNiuB+qzZ0b407C4PGdiKJAB3T38Hh+egzOy+aaPhQJqjCDR10euFEFD1G6M6P2YRcA/XKoli3TSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772448126; c=relaxed/simple;
	bh=30tfRf8+mm9aayN6sA/hqq8NEAanSViu/Bkw2w4+CTc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jcM8IYFzux3tpqQxejpJYyHnMRBeUryPK2h2M0mNgooWcOEFwi96T1O0pHJPQtP7qCFsJhzkkvFWluKPd39n4P65O9V1wnGFsdpqTZ55H0o2svF5vdLQfw6v5bXO+qgp1ybSBqsjmpFBL7cv0SZPY69ncad0liUrhwpYg6aJuSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fb08ir6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383F7C19423;
	Mon,  2 Mar 2026 10:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772448125;
	bh=30tfRf8+mm9aayN6sA/hqq8NEAanSViu/Bkw2w4+CTc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=fb08ir6Gtwro8mST3oiJl6O9D/ojgNsB8iPFP41N97+m1+oe797trB7lnDUyuQta5
	 J3jh5vkZJZ2KdgJbj1VWeKt7MieUWPG3i4pgkxMW3c662PJLoho8KPkqLu165CGVWD
	 dgdRkH3NEtRjgjKwinZgJ96Dc+H+SOZ1Zl+FYeIEcQkrsTZHNPYqVAImKPwjRkweIB
	 jx14QxWTwXzk8QEo7HR0AmCCYjiYYIIzMFPxMUsUawDpUxTnTmf5oFLVxd24Rp/+u4
	 jB3LsCaG/87SCH5Uu+MFp9PPzTLlbD4m6xUgQxBvTdPcSmx/7y6nWxr+80ma1Iikdd
	 +8m3ZdTHjQqzw==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Selvin Xavier <selvin.xavier@broadcom.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, 
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Chengchang Tang <tangchengchang@huawei.com>, 
 Junxian Huang <huangjunxian6@hisilicon.com>, 
 Krzysztof Czurylo <krzysztof.czurylo@intel.com>, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>, 
 Yishai Hadas <yishaih@nvidia.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Leon Romanovsky <leon@kernel.org>
In-Reply-To: <20260226-complete-alloc-conversion-v1-1-ebf1df1c2518@nvidia.com>
References: <20260226-complete-alloc-conversion-v1-1-ebf1df1c2518@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA: Complete
 k[z|m|c]alloc-to-k[z|m]alloc_obj conversion
Message-Id: <177244812274.900878.10282293475365020833.b4-ty@kernel.org>
Date: Mon, 02 Mar 2026 05:42:02 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17371-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E3351D6CA3
X-Rspamd-Action: no action


On Thu, 26 Feb 2026 15:07:50 +0200, Leon Romanovsky wrote:
> Commits bf4afc53b77a ("Convert 'alloc_obj' family to use the new default
> GFP_KERNEL argument") and 69050f8d6d07 ("treewide: Replace kmalloc with
> kmalloc_obj for non-scalar types") updated various k[z|m|c]alloc calls to their
> k[z|m]alloc_obj counterparts.
> 
> This commit finalizes that transition within the RDMA subsystem.
> 
> [...]

Applied, thanks!

[1/1] RDMA: Complete k[z|m|c]alloc-to-k[z|m]alloc_obj conversion
      https://git.kernel.org/rdma/rdma/c/94ff7c59cdfde3

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


