Return-Path: <linux-rdma+bounces-4925-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 388F5976CE0
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2024 17:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA7E1F22B07
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2024 15:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147EB44C6F;
	Thu, 12 Sep 2024 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="RDNLEiv+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEEF126BE7;
	Thu, 12 Sep 2024 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153218; cv=none; b=A9OgcQItaTDVHwn9ca793fd9ZklIG0W5+MSZL3EFhcyCb30RgJq6omtikhpAzJdW7pCScR118dd+RkmgnHJWU1EhRg/TqXvLZFQZROGHpFIjooFL5YHPmh2jjBN9hdCK6Gyo+zFj640spMq7WmbG14jPrWTLwXfwi99Z8NU4SRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153218; c=relaxed/simple;
	bh=fW7teF1C/1QRsNNUPa9PE9H+/4O8IegctWrPqgbbCs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PdbgL+mP9i3BFpHPhOJmGWeHoXfogwFkzMykeoHuw3QFFJWjLcbkkg5RhPC5thArD4uE8Rn7yJFmfIOHa58nAg8aDhi+3STvwK3HXgJ1jBq33DGkX+aDXbsweNqNNPE+xEL7UeTIx3j+uHrADvxDROHV9MHAg25vj7Scb5lQFXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=RDNLEiv+; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id BED6217DA520F;
	Thu, 12 Sep 2024 18:00:02 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Nq2mOjM1MrdR; Thu, 12 Sep 2024 18:00:02 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 9553A17C6566B;
	Thu, 12 Sep 2024 18:00:02 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 9553A17C6566B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1726153202;
	bh=L9jLmraveBJOuDRNOBLVEP7QSoFlsZUt1cD94L2R3Bo=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=RDNLEiv+z0jkeM6pFKSVBqSutPE/94Kz7VfAt00EpMoAs2lfkmJIv5dO5ZoeFLG46
	 IsdyxDXSRvyUqG3vy6MiZgL8FBrD4+lpuQqU917fkVKrOYYDCw6DZmN8KoJRG/QdQX
	 obc7pgIYOh4hswfgBIerNX3wbp0U+VlTFFKBOyLAkbyP65uHiQ/Ij4r9mRsKFiORnJ
	 HJnAkQjKnThNNpusA2dUAlR367R4XhteC/GiJU0nlEa1aRRAMNapIYrkGOtOzbssx9
	 b1JTwfQU2/DuPL/OFskm1uSCJ1/sip4C0M5yRn/Yy3JElntcXHxT+HSPCQNfITEZnN
	 cel+WF8v23quA==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RQlQhYhN2ipt; Thu, 12 Sep 2024 18:00:02 +0300 (MSK)
Received: from localhost.localdomain (unknown [89.169.48.235])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id BABEF17C309BF;
	Thu, 12 Sep 2024 18:00:01 +0300 (MSK)
From: Mikhail Lobanov <m.lobanov@rosalinux.ru>
To: Potnuri Bharat Teja <bharat@chelsio.com>
Cc: Mikhail Lobanov <m.lobanov@rosalinux.ru>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Roland Dreier <rolandd@cisco.com>,
	Steve Wise <larrystevenwise@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] RDMA/cxgb4: Added NULL check for lookup_atid
Date: Thu, 12 Sep 2024 10:58:39 -0400
Message-ID: <20240912145844.77516-1-m.lobanov@rosalinux.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The lookup_atid() function can return NULL if the ATID is
invalid or does not exist in the identifier table, which
could lead to dereferencing a null pointer without a
check in the `act_establish()` and `act_open_rpl()` functions.
Add a NULL check to prevent null pointer dereferencing.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: cfdda9d76436 ("RDMA/cxgb4: Add driver for Chelsio T4 RNIC")
Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
---
 drivers/infiniband/hw/cxgb4/cm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxg=
b4/cm.c
index 040ba2224f9f..311cc5bd160c 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -1223,6 +1223,11 @@ static int act_establish(struct c4iw_dev *dev, str=
uct sk_buff *skb)
=20
 	ep =3D lookup_atid(t, atid);
=20
+	if (!ep) {
+		pr_err("Failed to lookup atid %u\n", atid);
+		return -EINVAL;
+	}
+
 	pr_debug("ep %p tid %u snd_isn %u rcv_isn %u\n", ep, tid,
 		 be32_to_cpu(req->snd_isn), be32_to_cpu(req->rcv_isn));
=20
@@ -2279,6 +2284,12 @@ static int act_open_rpl(struct c4iw_dev *dev, stru=
ct sk_buff *skb)
 	int ret =3D 0;
=20
 	ep =3D lookup_atid(t, atid);
+
+	if (!ep) {
+		pr_err("Failed to lookup atid %u\n", atid);
+		return -EINVAL;
+	}
+
 	la =3D (struct sockaddr_in *)&ep->com.local_addr;
 	ra =3D (struct sockaddr_in *)&ep->com.remote_addr;
 	la6 =3D (struct sockaddr_in6 *)&ep->com.local_addr;
--=20
2.43.0


