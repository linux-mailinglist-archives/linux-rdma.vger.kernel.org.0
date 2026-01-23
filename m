Return-Path: <linux-rdma+bounces-15906-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDYBOo7ScmnKpgAAu9opvQ
	(envelope-from <linux-rdma+bounces-15906-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 02:44:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C370B6F43F
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 02:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADA003055F65
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 01:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA15137C0F6;
	Fri, 23 Jan 2026 01:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="kFp288tO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBACF313E2F
	for <linux-rdma@vger.kernel.org>; Fri, 23 Jan 2026 01:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132577; cv=none; b=aA/KnwWGN+p/IW5YDFBU+5Zms2OsPSzqCEGIrDZXfeRenTkKNOGroOeH51lBHKiqrlzghHztoFf/TGeQ5lulB8W4BP+K6pLF9i7SCrHwZh5TTd84AsbCV8/FF1nhhowFpDHYU3QSAxu67qR4qV+aKn8MHBrf4IHj3Fd+PpE+y/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132577; c=relaxed/simple;
	bh=K4MImgCN/1e1Ppnfh8INxxknQgDWRRhx4aBdj7VZ328=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gh07ZHNrr1jV+Gj+kOsfk2RZmIe/3tukC0ejGMQVOHV2Exck2arfW0T73eJoEuFnZl/h/M9bXoF6cEEIzcCXLnQHdmzsV3YLxO0jQ59Gl6THFIZhuRXjx7ivixrDhJdXvfG/q4UDheMeBKVYvYDhhRzyp0teHwkFJQ+941ZdhpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=kFp288tO; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=YWARE
	y918tT5p8yK9Rb3G4e0Bs5tP5ju35EhoUndHzI=; b=kFp288tOcHJEfCLUFLYlE
	/9+rK450ZJnpEQC1qh1HsfCwNJ4juUvcP9KVpuAGlTGeLcU/PjPjpnwo3dYvQsbo
	GqpFiNi5rVV9PTiYFL8HE6gtEBEpPyFHcDGjmXqX9u8R98K0Pp7IEF4Im0yxwI21
	+lOnTLWVo6VLOMQ13CKDxM=
Received: from dell-PowerEdge-R760.. (unknown [101.6.30.120])
	by web5 (Coremail) with SMTP id zAQGZQCHwKv90XJpoSPPAA--.47541S2;
	Fri, 23 Jan 2026 09:42:21 +0800 (CST)
From: Yi Liu <liuy22@mails.tsinghua.edu.cn>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	security@kernel.org,
	Yi Liu <liuy22@mails.tsinghua.edu.cn>
Subject: [PATCH v2 0/1] RDMA/uverbs: Fix missing wqe_size validation in ib_uverbs_post_send
Date: Fri, 23 Jan 2026 09:42:18 +0800
Message-Id: <20260123014219.3175025-1-liuy22@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQCHwKv90XJpoSPPAA--.47541S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF4rWFyDZrW3Gr15XF4kXrb_yoWfCFc_Wa
	s7trsrGry5uF9Fya1DKF4xZFZIgr429FyFqFyIga47J34DZF4kWw129FWkWr18CayxWrn5
	Cr4qy393GrnakjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1U
	M28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262
	IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx2
	6r4rKr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4
	CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_KwCF04k20xvY0x0E
	wIxGrwCF04k20xvE74AGY7Cv6cx26r4rKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
	9x0JjsIDcUUUUU=
X-CM-SenderInfo: polx5j2s6ptxtovo32xlqjx3vdohv3gofq/1tbiAQIPAmlx-ltZzAAJsv
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mails.tsinghua.edu.cn,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mails.tsinghua.edu.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15906-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[liuy22@mails.tsinghua.edu.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mails.tsinghua.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mails.tsinghua.edu.cn:mid,mails.tsinghua.edu.cn:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C370B6F43F
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

v2: Add Cc: stable tag

Yi Liu (1):
  RDMA/uverbs: Validate wqe_size before using it in ib_uverbs_post_send

 drivers/infiniband/core/uverbs_cmd.c | 3 +++
 1 file changed, 3 insertions(+)

--
2.34.1


