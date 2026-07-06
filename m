Return-Path: <linux-rdma+bounces-22803-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E2t1KuvcS2qDbgEAu9opvQ
	(envelope-from <linux-rdma+bounces-22803-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 18:50:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0749713833
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 18:50:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=JbhizcJQ;
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22803-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22803-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F06A37105FA
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2026 14:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55F73DC852;
	Mon,  6 Jul 2026 14:34:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CE03BB11C;
	Mon,  6 Jul 2026 14:34:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348471; cv=none; b=SRiDEf8A3a2V0VKUA6Gccno3OvkvnjBiWFG7gCZb6cVT5yHA0zX6+8XuEfa7347FGavOGkrXS7ZujIefj3e51Z5fUgHvJ9aI3QPfREpU4ADJ4l/syYIKNM9p15hINqEnPKJfVaQ8c/ehTTymUxH+yfB3v4TByQGYnA+P/EmpB+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348471; c=relaxed/simple;
	bh=PARIJmV8ijOMxuRwVMoi0CgMANuXn+H2UM8NorXvEso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WVJWrT136PgKCOMrxB7bg5aHkSKampRK/BL7rKwPscLucXt7HY/oHghLqfdwdRgjKyJJ70w1UF9t9xSruDQvxiRd2rOMTX2Jx2HBD8l6PuqHvtNk4o2hjr5T3zAVBPoNAclTvtt42Fkh+i8C14Rty2j+0nDzqG3W+X8hObdW640=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=JbhizcJQ; arc=none smtp.client-ip=101.71.155.101
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4517f1877;
	Mon, 6 Jul 2026 22:34:24 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: leon@kernel.org
Cc: dawei.feng@seu.edu.cn,
	dennis.dalessandro@cornelisnetworks.com,
	jgg@ziepe.ca,
	jianhao.xu@seu.edu.cn,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	stable@vger.kernel.org,
	zilin@seu.edu.cn
Subject: Re: [PATCH] RDMA/hfi1: fix init_one() probe failure cleanup
Date: Mon,  6 Jul 2026 22:34:24 +0800
Message-Id: <20260706143424.145935-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260705122328.GD15188@unreal>
References: <20260705122328.GD15188@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f37da096503a2kunmf117e0f79c98
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSE0dVkhNSBoZHR1PSkwfSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=JbhizcJQQ97IxUpZV+CUmB/5P73UVPHxI64tMSlPosi05xU7jUOKAn85wHQCno3QybPLlBn9NtVdLyefhX2n+cYc43BXqU9wj9n8g9FoEHJOhV8qeE4i7VApGp3Pg/C2DMKfrWrOHrgvYyJ9WdIHWKTNmtrJXjt3L6o3Fqadnfs=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=D5TNjTRX++MimZT9LBgkaPSFb0EnNbvfHgwpNW8oZHU=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22803-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:dawei.feng@seu.edu.cn,m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:jianhao.xu@seu.edu.cn,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:stable@vger.kernel.org,m:zilin@seu.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dawei.feng@seu.edu.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawei.feng@seu.edu.cn,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,seu.edu.cn:from_mime,seu.edu.cn:dkim,seu.edu.cn:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0749713833

On Sun, 5 Jul 2026 15:23:28 +0300, Leon Romanovsky wrote:
>Just move hfi1_validate_rcvhdrcnt() to be before hfi1_alloc_devdata()
>and remove error prints.

Hi, Leon,

I agree that this approach is suitable for the hfi1_validate_rcvhdrcnt()
failure path. However, it is not generally applicable to the other failure
paths. The later failures still occur after hfi1_alloc_devdata(), so they
still need proper cleanup handling to avoid leaking the allocated devdata.
Therefore, I think the current approach may be more appropriate for this
fix.

By the way, I also noticed that the error handling can be optimized by
returning ret directly from cleanup labels, avoiding chained gotos. Would
you like me to make this change in the next version? The change would look
like this:

+postinit_bail:
+	hfi1_free_rx(dd);
+	postinit_cleanup(dd);
+	return ret;
+
 clean_bail:
 	hfi1_pcie_cleanup(pdev);
+	return ret;
+
+free_dd:
+	hfi1_free_devdata(dd);
+	return ret;
 bail:
 	return ret;
}

Best regards,
Dawei

