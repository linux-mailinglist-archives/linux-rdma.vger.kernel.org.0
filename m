Return-Path: <linux-rdma+bounces-5997-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1EF9CDB19
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 10:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C231F21B1A
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 09:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33F018B470;
	Fri, 15 Nov 2024 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QserbGK9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3724B188A3A
	for <linux-rdma@vger.kernel.org>; Fri, 15 Nov 2024 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731661712; cv=none; b=P2Fe+Xh10+b7uK98u/bzN9Nx932OUgnDhlaZI1K0CH69CoC3f36SwBhA+Tff1ksfQSbWmTOd78YMiVPELd2i8lNHhGFEr/NSF3hFRUjmYS7iGw6T3AuR7yyhuo5GcjGek0RSpmg9sO+mIw4qGFdNXXpyGxaqTiJ51ib1XUat/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731661712; c=relaxed/simple;
	bh=DkgyiJf9kRHxdetk1iU77KMdTgoAfvAWwq9JB6ig0JY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=d6tERfeNfJbj80tXoEv99RniNESR0q2IsEnnvKClJUNMj30HGcLqQpPhOAUu8vOIaGbNqEqa7QEWh/IEzVEfickvW6dopMLZiuwY9xbaouMdMI8w1C1dAckvryQk/tGn0q7Koe/Sl278rTqxk71hzHtxv+ri2/OCjHadDm6yl9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QserbGK9; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea8de14848so252493a12.2
        for <linux-rdma@vger.kernel.org>; Fri, 15 Nov 2024 01:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731661710; x=1732266510; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yea6ky/Mz9UcUJFagYeVQSpJvlPyxck8DEWI6XQITw0=;
        b=QserbGK9GrvaLYD7YYB2Yt5pHz6wqcm9xeDE2dpRm4HQ4dH1fn2OjQtbRMw8FwFq9H
         jEpgKqTM165tfxS9UNtDJgiaxcI6lVCYDs5ycbY3phPqItPuNvnk8ZvKuZ6iyS9xWw9g
         GA1fwN0Rt9tQy/pD07w2X3B79++P4zcVrEmEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731661710; x=1732266510;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yea6ky/Mz9UcUJFagYeVQSpJvlPyxck8DEWI6XQITw0=;
        b=VUbWV17jYKYbqXAOPbM/78/qPZfKlMe5tx27t5ajUZwLt0sFYDJMvvoiPHH7fy4MpU
         bJFGolhG8XvsCIqzUioigx4DcOULvU58DnA/pBEtXJ4eqt7QycSDnen/e8k48tSoRGQB
         PE86kpcEzrYPvi+D9BqjYPq0yZk4YPspnpSvKPRIbG+7DM4JrgF4ET2mkRBI8UJyiQiT
         Vmy1cQSAFAu2eHdjTtnV5/c57HRG7/z7dNFTga7sQ7494frFsoIU+3bNO5g0Aao+Ii5O
         uMFL53kN6aP+lq7hwIM7dn/GmdfpUWykrdikMhOzFXdG6fe0kRoHFq/3moKshr9BWDiU
         hyvA==
X-Gm-Message-State: AOJu0Yxyc1w5h/7WDWUsOtgLtELdhBy55VcZPloDO5tPK4bTifO5++60
	FeRnQJfb04bcdojZWPqdxKUZHa23tUBaLhOzbASvwWDW24RUHCp84aM+Z+UTAQ==
X-Google-Smtp-Source: AGHT+IFPFeiuyNei/SMy5RbR5DUb4k50Jg4Uiz7Dej2kjv0Av7QCH6i3wST/2XvNrjCzaqvE7Ri7Bw==
X-Received: by 2002:a05:6a20:c996:b0:1db:92e5:d2a7 with SMTP id adf61e73a8af0-1dc90b2c6cfmr2185327637.15.1731661710480;
        Fri, 15 Nov 2024 01:08:30 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7247711de6fsm927926b3a.61.2024.11.15.01.08.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2024 01:08:29 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next 0/3] RDMA/bnxt_re: Driver update for 6.13
Date: Fri, 15 Nov 2024 00:47:41 -0800
Message-Id: <1731660464-27838-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Couple of minor updates and a bug fix for bnxt_re driver.
Please review and apply.

Thanks,
Selvin Xavier

Chandramohan Akula (1):
  RDMA/bnxt_re: Support different traffic class

Kalesh AP (2):
  RDMA/bnxt_re: Use the default mode of congestion control
  RDMA/bnxt_re: Correct the sequence of device suspend

 drivers/infiniband/hw/bnxt_re/ib_verbs.c |  2 +-
 drivers/infiniband/hw/bnxt_re/main.c     | 33 +++++++-------------------------
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 12 +++++++++++-
 3 files changed, 19 insertions(+), 28 deletions(-)

-- 
2.5.5


