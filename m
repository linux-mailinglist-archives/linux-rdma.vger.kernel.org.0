Return-Path: <linux-rdma+bounces-18992-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPdPKydf0mm6XAcAu9opvQ
	(envelope-from <linux-rdma+bounces-18992-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 15:09:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 158CD39E841
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 15:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65F4F3008D03
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Apr 2026 13:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE34322533;
	Sun,  5 Apr 2026 13:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIBE9yM6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599DE20DD51
	for <linux-rdma@vger.kernel.org>; Sun,  5 Apr 2026 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775394592; cv=none; b=jWCitJD3NIo9j858SD+Zik/oMRMLjUI7zGcvR/dPGCA/xUOCYir32iqmLGkXiYRxg33bEZ3HVuIrxtp5BUYXtpgBtKzEy5elDow7Xsy8OaIX6E+jkUMUYYVt/2gzMj7uKalJnPHgsa7V7nzkjKzqRK5CuFVqvtuj3Wnpvh/pUig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775394592; c=relaxed/simple;
	bh=uFe0BS9nIwlNQLOaXhof9AdRSoCSOGLtYXd5e8z7Tl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTyVCcE524EDHflsS7l8xjP5qLhwNlji9oWT0zNcQk4PqiUFXTdSzUYEjyHeM4wtkaA4xc0VufK3QHjEEdH1bz/vsRJsHY6W0h7ZyFljvnUFaz5tvcguoV6YallYjkRqHHmSXjksjV8XzJNtS8Smf86YDPnDATkzZEjqhQfpNLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIBE9yM6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4887eca00c4so21418105e9.2
        for <linux-rdma@vger.kernel.org>; Sun, 05 Apr 2026 06:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775394589; x=1775999389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABbgCzppaW1tFyIqmtlKlRa6pt5yFPCBT+4g9lle4Tk=;
        b=KIBE9yM6qjYZaXX8169GX5tWlFIsYRPyuw/Doqc86w50nusPoH4yddPvja0gP/qV7R
         iLhiCCgw2w/drQqMKHX3R9hilUeLD3YWPbjsc/UvhC6u9ZFR2BanHd/jBMRSQld2M1BK
         cQNKkZX5Ml8ibQowtzPb88XUNTH3U1X2g2yynXfC1iI16osC2XqtxEmbg3dFFbal929w
         dx8grY1nFA98SGTucMBVKXAk0117a4Yfd/OOc8AvisM5c29bG85M/Y+V7y0Ze3JD0ezQ
         8pMqxxA7OK8xuWT50BKYGZM4KSY7EBMD6iykrj2sFrtStDBsN36lCOWavHQacqGnX5m+
         tHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775394589; x=1775999389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ABbgCzppaW1tFyIqmtlKlRa6pt5yFPCBT+4g9lle4Tk=;
        b=PHuRNl4DsgGncTH3pi39elrXN6embu9eyYD1UgMpGA6cjDtjKt7Y13FPQgLWcB13kr
         4lc3oJUKNUfBh9pcbRXMIdfnC1xq0XqMeTfDR+i6bZPrivKzIazFc/mriCB7tl60GE0t
         iLPcXkeD31pxcrcfZlc7YSF3FaCYjHDmDdVHnfGXq5rBN7PxXRmaWi9awm9pj6nRoPBz
         rPRuFVgOwkxAre+SdvtY3rQPi3MfiIWWpUwy6ZWP/CjwhEIDcwVlC6qWifS91pKJHjMQ
         WT4FqX/5HBDAC0JIWIwi5EtwhWhybhXHuOK56QLCs/mn8xlqZ5gVHbN7jl4fwFjJKsiu
         gLYw==
X-Gm-Message-State: AOJu0YxWk/UzFopnnQT6jOCnwfsTZ0HxcCLO8ezPVjLpAWmRliYVbZTr
	6PNmButWYhF1GwzFETt24DNEf00OzeSoA5Yt2FXNJEWMOJySPZvLXQj+4YHiCctk
X-Gm-Gg: AeBDievi9OzJuSSpFEZFay+Ktr0QyDl/A1mP88mumqKQwUgEPHlUgZWAf/ri9XM7zTg
	ry1PB/+BeFsmyHc42cLzD7uag6DYDMQO4vpqa7a4PUOwPzy+pJR6uqMzO0nQqS4SFEv6djjrSvv
	CLQTcZQWtec7uAQS+2Vt0QwcpNwiiDH+JWDO8R7y6trGE4yTbc8V7ShaPi3n6d+d/glloX4Gp0q
	aBicaf4/0EfiWZqmL6yhplCkK0NgdYy9t9ik7tVByrxTTJ3ZufEBjuKLCnOgh+LVaE+VBWle37C
	beIphK1cLcAApZy2JqkIh8WsEo8gibuTt3rov3F1scmtrNnoqphW5tEiHj+dwQihS2KiLzVw7Qm
	hvAOvS/ChD2sPHt3oGyOMymbKoSssFrb+w6eDywauGWX5VEe2DXGgu00+TE84BxxfGOFQO3/cwB
	ROAwbJXiBdYyCIa6WSAvimrk0y/CfpLinGqaRCJUrgNHyQP4WIRxn7Mt3rbfGZWADugncn0XOoG
	Z3+8s/A76qICRtyZxxtWRseodPVtp1+qhhQpA1/qeAyhx/5etGLqlIJcDU=
X-Received: by 2002:a05:600c:630a:b0:488:8840:e5ae with SMTP id 5b1f17b1804b1-488997eed8bmr143593855e9.24.1775394589145;
        Sun, 05 Apr 2026 06:09:49 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4889f6843dfsm180115695e9.12.2026.04.05.06.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 06:09:48 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: linux-rdma@vger.kernel.org
Cc: prathameshdeshpande7@gmail.com,
	dledford@redhat.com,
	haggaie@mellanox.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] Fix loopback leaks and return paths
Date: Sun,  5 Apr 2026 14:09:21 +0100
Message-ID: <20260405130924.18901-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404230759.15131-1-prathameshdeshpande7@gmail.com>
References: <20260404230759.15131-1-prathameshdeshpande7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-18992-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,mellanox.com,ziepe.ca,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 158CD39E841
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes a return-value bug in the transport domain allocation 
path and refactors the loopback enablement logic to resolve reference 
count leaks and premature hardware deactivation.

In v7, the patchset is split into two parts:
1. A direct fix for the return-value bug and mutex initialization.
2. A refactor of the loopback state machine to ensure symmetric counter 
   updates and correct hardware toggling at zero-count transitions.

The split allows for cleaner bisection and separates the immediate 
bug fixes from the lifecycle improvements identified during review.

Prathamesh Deshpande (2):
  IB/mlx5: Fix success return path and mutex initialization
  IB/mlx5: Fix loopback refcounting leaks and premature disable

 drivers/infiniband/hw/mlx5/main.c | 45 ++++++++++++++++---------------
 1 file changed, 23 insertions(+), 22 deletions(-)

-- 
2.43.0


