Return-Path: <linux-rdma+bounces-21848-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7swyIg0EI2rOgQEAu9opvQ
	(envelope-from <linux-rdma+bounces-21848-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:14:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 880A164A0B0
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:14:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ArWgcvT9;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21848-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21848-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 73ED2302F6C9
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 17:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108952BE03C;
	Fri,  5 Jun 2026 17:04:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151C93451BA
	for <linux-rdma@vger.kernel.org>; Fri,  5 Jun 2026 17:04:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679048; cv=none; b=Go0KfQZeYb3IDc7R/0qTlDTy044Z5s/IDhWb2hyDE6fOcAztKcUHfOdWL79ETxdsZDiJxsoZGg3A0DS2n6mzzFbMyWaCXHBjB7+H+BpYVm09GEoaISKAqk1PjirgPCSkQp9e00aJrYOb0QmmVeJLkj5EWzd+w1sXntzIbbYGmko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679048; c=relaxed/simple;
	bh=YtZE1xyk23OmFsw35vKQUZbSJ+FESk2hBRqIFSzm6Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKFvvnZlM4H+Zg8CGD2ugAwOLZwYxD+zUE4KE7D2/COWRZEuSupsf0IGanhJsp0A7TvzmuD6c5f8fXISdkR9vo3A8IhjvpbM2bcXCD7zU4V4vXzaSXJE1TCFUuplmhKWSG9yxRmceMn0k1jSLuwXA48lIkbz2pXwrusw3x5zNMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArWgcvT9; arc=none smtp.client-ip=209.85.167.48
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aa68d9dc18so2160739e87.2
        for <linux-rdma@vger.kernel.org>; Fri, 05 Jun 2026 10:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780679045; x=1781283845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+9Ork6uYNXL+eeO+phzb3xUI2OLrfdgYyvNm4Wy1uWc=;
        b=ArWgcvT9KiY9SmhPeAmoxZZwK0uT2Qjkp3pcAoy6Rr5EVe1YDlkH+zVsukaxJhyvZJ
         TZaukM+Z0ZmIT+mCl67mCVbMQLTmDwh+9kdZq8eqF3Afh6Eedd4tfk3/mHfF6RovH1p2
         0gLJqz/mYtl9tL73XJFDNSOycwUO/vYq2arcFk4Z6HTabZpaMU+dP6pz0wTB+yJllTqB
         ysFsRGNtuSIgLvi40pcksrGurAUNRgNyb62/2koQVCl9lVAdYjf16TcuiRRyd8cKUkKe
         qdtemW6qcISbDAtsfvSPgN0xcSY5tPWOL/47fn+k664aNqJ/Hgsyb0N/iMMPGo9lMntq
         zeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780679045; x=1781283845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9Ork6uYNXL+eeO+phzb3xUI2OLrfdgYyvNm4Wy1uWc=;
        b=BRt0sCYZmQwOgQDwNYCWNOsbWgTNoYOz7kK64uhPI25M7nw3xWur0D4SIjV+gH7pjw
         lnqh62QZVfFY4PzilU+eAlz55UZ/jPnkCXYCujcnM6eaO9J7xrzuoKlFT2NxPgXqlJW0
         /+IFQhZD7sYcLVyHodqV5bum5y3VU+00euzOCwEmnaKjqSq2hWdJPvvr9spu3L8GO4X6
         3OyC4Y4gBjLT4OMHVgTkpm29zB4iYeNKh7vHYR0LOjj/iJVJI0hQuQPeSz/MPZna4Oo8
         TKrawYuujexXkSXI5j8iGXwtjAOwkOWhIcaB3gIECeORBJ53sqE2BtP41jYmdkE5kEau
         cf+A==
X-Forwarded-Encrypted: i=1; AFNElJ9D7QnhHX14GDRA9Gn7iVoMu1jmobOGabu8nRuegeki9BYNBCUuNxCLQkHB8VvOQcTaEgBDDj8LM+k0@vger.kernel.org
X-Gm-Message-State: AOJu0YzTekw8UCGRxzE3gEJpRh1ufOXPVPEifQIUghmt7ar9Nb5tRyMm
	axaifPxsZXzWF9ew1+8n2waOlHivt9ZeJmM7YSnw6EMfSWn8ygsjVxVc
X-Gm-Gg: Acq92OF3/w/maXtysSoPTPv+VzN0Mc6roT0bcfVLVvKe6sZrUvPLByW0q40tYBgXWM8
	zkuSY/OCS+fFEyi4u81rV4sGt0k9CE46fVXCi+1nZq9bLEo5qNHV3WLIvVeZohkDNJMwcLA3q1w
	YyAG6/8fICfBC72mWb7g7+Fuu9w/guEVCA/wdmKrgm8weX0Egj19zZKYgi4RpGOxejCLh+i5i/K
	VJgj2OoKIoT+Q8DSCuINARTe0jhTElMtI9HRfuRasO667Yb45r7P1BVt387BvveUOYPe7YXNVQl
	dodEtpdjnoX6zjZ5ZXhTY+jPlxRH5lMqtjtgROMF14VWJfaZi+CmUdSXqJdDIatS9C785lylbGR
	wirrW+7C4xdVi3a4YeS14EMkk2BDwE8aiIVGgERg7DNMvEIPYIAesqBVaERVc8ZohuLjDUpn5Sg
	c+y7s56mTUPHdluT8+V8bCP/sjtLjqhsMEI0vZPoFIgj/ujafoHBpWUQo7uoiEHMZLzCuN
X-Received: by 2002:a05:6512:1056:b0:5a8:8eda:bed5 with SMTP id 2adb3069b0e04-5aa87bc934dmr1434238e87.32.1780679045157;
        Fri, 05 Jun 2026 10:04:05 -0700 (PDT)
Received: from c0624c666cc5.devsec.astralinux.ru ([93.188.205.42])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac07b66asm26931161fa.11.2026.06.05.10.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 10:04:04 -0700 (PDT)
From: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vladislav Nikolaev <vlad102nikolaev@gmail.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Haggai Eran <haggaie@mellanox.com>,
	Kamal Heib <kamalh@mellanox.com>,
	Amir Vadai <amirv@mellanox.com>,
	Moni Shoua <monis@mellanox.com>,
	Yonatan Cohen <yonatanc@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Yanjun <yanjunz@nvidia.com>,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 0/3] RDMA/rxe: correct cleanup-task backport and timer cleanup
Date: Fri,  5 Jun 2026 20:03:26 +0300
Message-ID: <20260605170349.1524-1-vlad102nikolaev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,ziepe.ca,mellanox.com,kernel.org,vger.kernel.org,nvidia.com,linuxtesting.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-21848-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:vlad102nikolaev@gmail.com,m:zyjzyj2000@gmail.com,m:dledford@redhat.com,m:jgg@ziepe.ca,m:haggaie@mellanox.com,m:kamalh@mellanox.com,m:amirv@mellanox.com,m:monis@mellanox.com,m:yonatanc@mellanox.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yanjunz@nvidia.com,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[vlad102nikolaev@gmail.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vlad102nikolaev@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 880A164A0B0

The linux-6.1.y tree contains commit 3236221bb8e4 ("RDMA/rxe: Fix the
error "trying to register non-static key in rxe_cleanup_task""), which is
an incomplete backport of upstream commit b2b1ddc45745 ("RDMA/rxe: Fix
the error "trying to register non-static key in rxe_cleanup_task"").

The stable backport added guards for req.task and comp.task, but missed
the resp.task guard and also left rxe_cleanup_task(&qp->resp.task) above
the RC timer cleanup.  The upstream fix checks all three tasks and keeps
resp.task cleanup after the timer cleanup.

This series first reverts the incomplete stable backport, then applies the
correct backport, and finally backports commit 1c7eec4d5f3b ("RDMA/rxe:
Fix "trying to register non-static key in rxe_qp_do_cleanup" bug") to
avoid deleting uninitialized RC timers during QP cleanup.  The last patch
keeps del_timer_sync(), because linux-6.1.y has not renamed it to
timer_delete_sync() yet.

Vladislav Nikolaev (1):
  Revert "RDMA/rxe: Fix the error "trying to register non-static key in
    rxe_cleanup_task""

Zhu Yanjun (2):
  RDMA/rxe: Fix the error "trying to register non-static key in
    rxe_cleanup_task"
  RDMA/rxe: Fix "trying to register non-static key in rxe_qp_do_cleanup"
    bug

 drivers/infiniband/sw/rxe/rxe_qp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.43.0

