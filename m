Return-Path: <linux-rdma+bounces-7016-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDCDA11315
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 22:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D643A5E3C
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 21:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BEE21146A;
	Tue, 14 Jan 2025 21:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TfXkNlFC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F3B145B26;
	Tue, 14 Jan 2025 21:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736890351; cv=none; b=rThqcuPka+J1eevAUSH/HZAmWXNOsTuhoplETGvfy1ISW2zGylM506j+lcPIqPR5ttOsNnJyhRHk0dSj8Y2dbaNqD4o23n9tR1puEYWySVfsQXU0FhpFyhgVp9jnKPcvaE3i1pMrpIG8zEG+5HRkW6rZRKzJeZLgHRvR05H+wFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736890351; c=relaxed/simple;
	bh=tSryNcx7qli/zcjcPttG6aIKk7I0bw4LvL8Tvqp1wlA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a0SsXu5W/0pdcwoB6aVvAsEs6rEfBD9zAlclALspvqM8hXjgmGBhYYnpLlb3K+6FdkwW2yHurgbhzCKFpBAI67ALHU5VqiVFPtpUFvgZ8IfpmTcKrzMy0ulnBdKtThc3sNKgBn2zy3ljlgOpcMqMgfSXgmJqTir4GIanvdX0rz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=TfXkNlFC; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1736890347;
	bh=tSryNcx7qli/zcjcPttG6aIKk7I0bw4LvL8Tvqp1wlA=;
	h=From:Subject:Date:To:Cc:From;
	b=TfXkNlFCerD2wFe2IKrdRfIyglfG/YhgqFi5b36dviqF3Jp5Td9KT9fiG5rlKpFwL
	 yPdfhP0wNn6n37vAF2edG++18HdPLlvd7Ga2QGHpcHKc/L86B63xQl7TFS0l4Rxw33
	 ZwzVvOcjWMMEN9I24aUEIMBULYLVG1d68tlpcC5E=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/2] RDMA: Constify 'struct bin_attribute'
Date: Tue, 14 Jan 2025 22:32:12 +0100
Message-Id: <20250114-sysfs-const-bin_attr-infiniband-v1-0-397aaa94d453@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANzXhmcC/x3NywrCQAxG4VcpWRvo1Avqq4jIXBL9N6lMhqKUv
 ruDy29zzkouFeJ0HVaqssAxW0fYDZRf0Z7CKN00jdNxDOHA/nV1zrN54wR7xNYqwxSGFK2wZjk
 V2Ws6pwv1yruK4vM/3O7b9gNAMCEHcQAAAA==
X-Change-ID: 20250114-sysfs-const-bin_attr-infiniband-fce6de3fb8b9
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736890346; l=734;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=tSryNcx7qli/zcjcPttG6aIKk7I0bw4LvL8Tvqp1wlA=;
 b=EEDQjBaodKZLbEH0J+cLUyH8af+yCzVYgj86az9ch3BENHhzic4D0KWV1VvFiMubZHWbL5sa6
 K6R3ok0QK81CE12B58iS4FXbXgz0Ep0566H+xus4SYbtf6GEFZwkizX
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      RDMA/hfi1: Constify 'struct bin_attribute'
      RDMA/qib: Constify 'struct bin_attribute'

 drivers/infiniband/hw/hfi1/sysfs.c    | 14 +++++++-------
 drivers/infiniband/hw/qib/qib_sysfs.c | 16 ++++++++--------
 2 files changed, 15 insertions(+), 15 deletions(-)
---
base-commit: 7f5b6a8ec18e3add4c74682f60b90c31bdf849f2
change-id: 20250114-sysfs-const-bin_attr-infiniband-fce6de3fb8b9

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


