Return-Path: <linux-rdma+bounces-23122-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GJ7FB2jQVGrAfAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23122-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 13:47:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB2874A805
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 13:47:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23122-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23122-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=nvidia.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17433300E15E
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 11:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99D83EB81B;
	Mon, 13 Jul 2026 11:47:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BD83D25A6;
	Mon, 13 Jul 2026 11:47:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783943268; cv=none; b=NqzGtfsLGww3+x7YAsLUZ7z97AOe5P5dBK0I2A9uVcrR+tjetfz9+sXOclqMmQtQXsYUBGW2nzvsJKEWTBzS0mtMHXHl9TXVSVIu4znBxqKa0tCjCmp+Zz42extdlcUCZmXkOf+xroGSgnbuLzMBH9ga9eE41ncvgWfsElz2BZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783943268; c=relaxed/simple;
	bh=KNTdMzPJoS1a0KZptLeVMG73JxnVvViaOd4eSzzzVS0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ex5I/YLmphAbjXD3MLKGpIvPA4tTOzhq8/AzslVKc7HNdy9XRwZ3diik4RTpbzNEVj4Sj74E933UOeJrnUXLNvW4QdibKZDB394kvjLDzBpUazHorI6HBaaCZiCB0DFrrdIK3W3SJtdoTpdNua7Wp+/yi05K6HyAZrcz6KYnDwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4A41F00A3A;
	Mon, 13 Jul 2026 11:47:46 +0000 (UTC)
From: Leon Romanovsky <leonro@nvidia.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Ira Weiny <iweiny@kernel.org>, 
 Doug Ledford <dledford@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
 Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>, 
 Mike Marciniszyn <mike.marciniszyn@intel.com>, 
 Sadanand Warrier <sadanand.warrier@intel.com>, 
 "Michael J. Ruhl" <michael.j.ruhl@intel.com>, 
 Dean Luick <dean.luick@intel.com>, 
 Sebastian Sanchez <sebastian.sanchez@intel.com>, 
 Jubin John <jubin.john@intel.com>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dennis Dalessandro <dennis.dalessandro@intel.com>, 
 Dawei Feng <dawei.feng@seu.edu.cn>
In-Reply-To: <20260708-clean-init-one-hfi1-v1-0-b9e9641268a5@nvidia.com>
References: <20260708-clean-init-one-hfi1-v1-0-b9e9641268a5@nvidia.com>
Subject: Re: [PATCH rdma-next 00/13] RDMA/hfi1: Make init_one() a sane
 counterpart of remove_one()
Message-Id: <178394326416.1700515.8921906634161250041.b4-ty@nvidia.com>
Date: Mon, 13 Jul 2026 07:47:44 -0400
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
X-Spamd-Result: default: False [0.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:iweiny@kernel.org,m:dledford@redhat.com,m:willy@infradead.org,m:grzegorz.andrejczuk@intel.com,m:mike.marciniszyn@intel.com,m:sadanand.warrier@intel.com,m:michael.j.ruhl@intel.com,m:dean.luick@intel.com,m:sebastian.sanchez@intel.com,m:jubin.john@intel.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dennis.dalessandro@intel.com,m:dawei.feng@seu.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonro@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER(0.00)[leonro@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-23122-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FB2874A805


On Wed, 08 Jul 2026 13:45:38 +0300, Leon Romanovsky wrote:
> The hfi1 PCI probe path, init_one(), has accumulated years of ad-hoc
> error handling that no longer matches how a driver probe is expected to
> look. Rather than unwinding each initialization step as it fails, it
> allocated hfi1_devdata up front, ran every stage, and then funneled two
> unrelated failure values (initfail and ret) into one combined cleanup
> block. That block kept the device half-alive "so diags can be used",
> created the character device only to remove it again, flushed a global
> workqueue the driver never queues onto, and diverged from the teardown
> in remove_one() even though both release the same resources.
> 
> [...]

Applied, thanks!

[01/13] RDMA/rvt: Return NULL after port allocation failure
        https://git.kernel.org/rdma/rdma/c/2982eaf3b9d2d9
[02/13] RDMA/hfi1: Preserve unit 0 on allocation failure
        https://git.kernel.org/rdma/rdma/c/2e3809ad8911f5
[03/13] RDMA/hfi1: Remove redundant PCI device ID validation
        https://git.kernel.org/rdma/rdma/c/af9117d02f5051
[04/13] RDMA/hfi1: Pass PCI device to hfi1_pcie_init()
        https://git.kernel.org/rdma/rdma/c/b9cb5e81f7d90f
[05/13] RDMA/hfi1: Drop device data from hfi1_validate_rcvhdrcnt()
        https://git.kernel.org/rdma/rdma/c/4ebd241071af81
[06/13] RDMA/hfi1: Create workqueues before device initialization
        https://git.kernel.org/rdma/rdma/c/0d5618c1b2fc9d
[07/13] RDMA/hfi1: Free RX data on late probe failure
        https://git.kernel.org/rdma/rdma/c/8e17e101e04a3d
[08/13] RDMA/hfi1: Allocate device data after PCI initialization
        https://git.kernel.org/rdma/rdma/c/9f674ba674a0d1
[09/13] RDMA/hfi1: Remove redundant NULL checks in create_workqueues()
        https://git.kernel.org/rdma/rdma/c/22113f3f55a1f4
[10/13] RDMA/hfi1: Stop flushing the global IB workqueue
        https://git.kernel.org/rdma/rdma/c/d43b1c17f9e1b9
[11/13] RDMA/hfi1: Defer device creation until probe succeeds
        https://git.kernel.org/rdma/rdma/c/9bab31776ae60a
[12/13] RDMA/hfi1: Initialize debugfs after probe completes
        https://git.kernel.org/rdma/rdma/c/bb18740b302f6f
[13/13] RDMA/hfi1: Align probe error unwinding with device removal
        https://git.kernel.org/rdma/rdma/c/e26c48cf23a494

Best regards,
-- 
Leon Romanovsky <leonro@nvidia.com>


