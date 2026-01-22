Return-Path: <linux-rdma+bounces-15891-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC0+AdNGcmnpfAAAu9opvQ
	(envelope-from <linux-rdma+bounces-15891-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 16:48:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3CF69332
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 16:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 194FE788C81
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 14:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D035350A17;
	Thu, 22 Jan 2026 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="AQow2DaY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9AB2C0296
	for <linux-rdma@vger.kernel.org>; Thu, 22 Jan 2026 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769092154; cv=none; b=Zx6aUQKCYhlgWoqIaRLt0ll5b2e3iCne8Sa80UJUHXEkcJl4Czve0NE/eH+JLH2kq8OlaVr98DfkApA7TJPp55WN0VfKvXc8vpoh7Bc6Rcm0zd4DoRCGoViX8ftRUkm0euFy2imoA43/28TNFvuObCfy0hRaYmNCkhe3uy04EHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769092154; c=relaxed/simple;
	bh=cHbKZu6q5NJS1criCFxgQVSctSWPabNKO0496HazpZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e/gmUVqoAjtOWD5ltQOjvyzal2BLcSIyRkejXN4XOBxwRBh8rudJA48zVqqOr9cIvEkP9boRFgYoY5UjibJ8hSXet3/md2PRIOBeDxKYlEW0d6om5xXxGr9YvulvZ8piiqbCqeVF/xZHd76Nz6CFlkHLw2Q1zGKYMrJA1gldZjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=AQow2DaY; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=tz1DO
	d5OlEAnv4mqMzMEJ0cun5z1o52OTer0wAGl+/w=; b=AQow2DaYNIP2AdyDsqdEA
	COJOj09687Ise3mgRpz7Q6mFxiRTAWQZgBQwHqM+FQM8sBkhHam8ABCYH0YT1CJw
	BzMIvVFmptT1VnKi8HIe+JhnF9TRBGa3v7XjB2cAnM8JypgIriDPDlR0R9Hsm97R
	DvV5wTP1THkQtXQ31ypS6I=
Received: from dell-PowerEdge-R760.. (unknown [101.6.30.120])
	by web4 (Coremail) with SMTP id ywQGZQAXeHIrNHJphh77AA--.36066S2;
	Thu, 22 Jan 2026 22:28:59 +0800 (CST)
From: Yi Liu <liuy22@mails.tsinghua.edu.cn>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	security@kernel.org,
	Yi Liu <liuy22@mails.tsinghua.edu.cn>
Subject: [PATCH 0/1] RDMA/uverbs: Fix missing wqe_size validation in ib_uverbs_post_send
Date: Thu, 22 Jan 2026 22:28:59 +0800
Message-Id: <20260122142900.2356276-1-liuy22@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQAXeHIrNHJphh77AA--.36066S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF4rWFyDZrW3Gr15XF4kXrb_yoWkJrb_u3
	WDtrsrCry5uFnrA3WUKF4xZFZIgr4xWFyYvFy0qa43J3s0vrsrWw129rWkXr18Gay7Wrn5
	Jr4vy39xKwnIkjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28E
	F7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_GrWk
	Jr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5c
	I20VAGYxC7MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW5XwCF04k20xvY0x0EwIxG
	rwCF04k20xvE74AGY7Cv6cx26r4rKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
	6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0J
	jI0PhUUUUU=
X-CM-SenderInfo: polx5j2s6ptxtovo32xlqjx3vdohv3gofq/1tbiAgYPAmlx-+5bbgAAs1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[mails.tsinghua.edu.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-15891-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[mails.tsinghua.edu.cn,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[liuy22@mails.tsinghua.edu.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mails.tsinghua.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B3CF69332
X-Rspamd-Action: no action

Hi,

I discovered a missing input validation issue in ib_uverbs_post_send().

The function uses cmd.wqe_size from userspace without validation before
passing it to kmalloc() and accessing the buffer as struct ib_uverbs_send_wr.

Security Impact:
- If wqe_size is too small: out-of-bounds read from kernel heap memory,
  potentially leaking sensitive kernel information.
- If wqe_size is too large: triggers WARNING in the memory allocator.

This patch addresses the first issue (wqe_size too small) by adding a
lower bound check, consistent with ib_uverbs_unmarshall_recv(). The
upper bound check is not included in this patch and may need further
discussion on what a reasonable limit should be.

Given the potential for kernel heap information disclosure, I believe
the first issue may warrant a CVE assignment. I would appreciate it if
the security team could evaluate this.

Thanks,
Yi Liu

Yi Liu (1):
  RDMA/uverbs: Validate wqe_size before using it in ib_uverbs_post_send

 drivers/infiniband/core/uverbs_cmd.c | 3 +++
 1 file changed, 3 insertions(+)

--
2.34.1


