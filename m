Return-Path: <linux-rdma+bounces-20936-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNZMK1WLC2p1IwUAu9opvQ
	(envelope-from <linux-rdma+bounces-20936-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 23:57:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B74F5742B0
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 23:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B38F303C635
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 21:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DD3395D9F;
	Mon, 18 May 2026 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAbY6Qew"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2764A39A052
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 21:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779141045; cv=none; b=sKg2l96AavfQG+hWicruuJwRPWSdEjPwgZhY33NbH2I59i+yFxqCq3bhzRLFJ4afo542jlqpgTtPsodrJs28SFdll7AaYmRju/v4U/5StDBqbVopJQz1Kn17ozcTXUwvVKDX2Z+KXQFQ8QwHavhS7bsjYyVfjGIkgvROUpn6ZV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779141045; c=relaxed/simple;
	bh=+pBOmoj5FOJNVMEpMCb6U6lNmeMs+GP7qqKNFKaUHIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dElo/xwzcn5R1VGVJv6Ma2VTBuSBZgIWJTQPa/GuDLtopvGkaEwjjPJQhcIg1Meh1NphZ0/I3G6epZsLrQMVWF8G2wqPEM1m1/noYkB+XNTeI4V0e1o+zxhdBdTNhej66+YlFLPEpRLpvN5SeYVG5XlkRaLFurNNLRP02Rz800o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAbY6Qew; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so23030915e9.0
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 14:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779141042; x=1779745842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X9Dw97fNhGkcMIs4SSmdFF89InQOGfCrJMn2K6JRl0c=;
        b=HAbY6QewjC0jaSAXLzbUyqabxN0mWf0pYGoUPcbvoAk8bhsyCwr2w/yHI/jvrT0w3P
         L6yeJpRFjWYi+LqyVLNafE4KhDeb4Z7WeTCnrJsfToTrBD0XMjBvKkg0UsY0qxyatQZg
         kjbYuLvQ/2x2bObBKbHT+DgZrlo9TI1j9zbVWX6FpTyGlJzWqeE5OpCzTjns9CpaRbY4
         kVzoK17ELj6vaMYkZl5Qtfjz5RH3VoQKVdlMfJbYHvtRzDpjvztvT0ZOPMM8R2X4CDu7
         K+qxVDRG3ho051poA1Cqm3Z6H9ZsutdjcyGVKpUOGPXxVBGSGbBQsHONtG6weyidKn1/
         yWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779141042; x=1779745842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9Dw97fNhGkcMIs4SSmdFF89InQOGfCrJMn2K6JRl0c=;
        b=CIWyWwKpuBvbBUCumjNVbX+N1dVJshnc5a+rFJAdhBtAEvT5T0qkhINM1HJK3MlmbK
         bN4HyDWB/F9Q/QBTWkQvgajgxPfk0Wi16dlyyMuW7E/DVeh8g7tq2yYJRQQQ7hY3vaQQ
         qR43N6wEOvaoHBO85BnZqo7hPJmMGlAoaYRS/JqtABYusO+pNSiUunjXpg6r1SDqGGih
         meb42pjunKdvSwsIqNuV+RfVadZzTcCFYvYha13yqyc/2FsS6uYJI9IgTEe/HhWm78i9
         o1NyLaO6ANB1Qj4W/+ZuSwtEqwGn/e0vEJbny9tv4ackj77krlP/EDVSdLdMP8juXsLp
         03kw==
X-Forwarded-Encrypted: i=1; AFNElJ+qwEwj+/tVKgMtlIKpr3xm25kz1Dh4IGoKQ1RdtG6Hl/saBnIuZQkt5IaMI76jDS1AX5oGMeo6+GKu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0DOkYBm4ylVubdhXjfQfwRgea6yFw7Evc4ZZz2USPmIFAlMWs
	Qqg4+DnSTPrN1dYVZEG4tTh/5VZbX0NxP28F7MlBrekOI4JGp9dEJaQ=
X-Gm-Gg: Acq92OGc4DRFTz3i4J6nJi7LltjwWfC/UX3jyVo1TK7XacO9ap+69aXc4xRk2d4CTUc
	CuI3uwmwoUZmjTvJVZW4R3HpKJ3+kFyz0WDh/lQ03dlizVKooUSmX6KszD1oEPe1ulAKK4/qvNu
	PBfRopds+ACwG4RnrCFcAU8ubzGjwzHloY9MGDFRMdIWT/nCYQj86hGh8KIGQJw3KLFi1tq2ys6
	lssGWKVlNZugVBrem9/u0Tjeuoozc7NoTPgkJ03qW01lDqq3d6nzFFlXChpWGPGpagX8Nh1NKMG
	hL6Fb+JpkkT4iZC0FluiHz0O4/1BnthhRxZs5QKqOIGwIBWG527oE6YsCd58XQ3dNLAv/mmjCKe
	g7ME0oWTEUbH/1DGcT0H3fDiGTrQLeZbmmXMF7IVUoXQIrKO6kZFJQudT6fFm0gMoULdO63LF73
	bBTxOmSRPVB9aa+dk2
X-Received: by 2002:a05:600c:927:b0:48f:fe2a:1089 with SMTP id 5b1f17b1804b1-48ffe2a10f9mr95892995e9.5.1779141042164;
        Mon, 18 May 2026 14:50:42 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe1a41sm43774008f8f.31.2026.05.18.14.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 14:50:41 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH 0/2] RDMA/rxe: fix shared memory TOCTOU in receive path
Date: Mon, 18 May 2026 21:50:38 +0000
Message-ID: <20260518215040.1598586-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-20936-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,talencesecurity.com:mid]
X-Rspamd-Queue-Id: 0B74F5742B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RXE queue buffers are mapped read-write into userspace. The receive
path reads WQE fields from these shared buffers, which lets a
concurrent userspace thread modify them between validation and use.

Patch 1 fixes a heap overflow in the SRQ path where num_sge is
validated but then re-read for the memcpy size calculation.

Patch 2 addresses the non-SRQ path by copying the WQE to a
kernel-local buffer before processing, preventing TOCTOU on
fields used in check_length and copy_data.

Tristan Madani (2):
  RDMA/rxe: fix TOCTOU heap overflow in get_srq_wqe
  RDMA/rxe: copy WQE to local buffer in non-SRQ receive path

 drivers/infiniband/sw/rxe/rxe_resp.c | 33 ++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 5 deletions(-)

-- 
2.47.3

