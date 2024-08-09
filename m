Return-Path: <linux-rdma+bounces-4272-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6B494D0EE
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 15:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0C0283E8D
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 13:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705BA19539F;
	Fri,  9 Aug 2024 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="YY8En4Hz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C402D194C71
	for <linux-rdma@vger.kernel.org>; Fri,  9 Aug 2024 13:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209358; cv=none; b=bVkHqDRqnI52uNg3OAyxJKmmA5sc3DQkJCP6bI0+Gzo/8zgAL6I4aPLjFhX18zdDm98CG+FusOFM7Y5uVo90/sjb3FbGY+G49clb1Ov3tVzVz0i28sVab5FS/OiKXW5dcjLfPxihsPoOWsNbs/7PnAlIIkTu5FZKoP91dObvbaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209358; c=relaxed/simple;
	bh=jyu7QxttRGoctTTiOn0/IfuJ25F/bJGlWUtffX3Za8U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i74x3WTO4F5pqKCIuiKn8wcxjUGmF43f9zPVX0m0eEyKkAmQ9stpn8cvz6sVRxpqKDRM2hXSsf/JHb00jn8BuFMLrfm+KOFUq5UgxIIXxI7Sn6SiLUfq4HUpWpQ4gZJ+gY0fZsbb9vieNnTRasO8eyh5gEZNNiGev1fIaOGXD+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=YY8En4Hz; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3687fd09251so1075355f8f.0
        for <linux-rdma@vger.kernel.org>; Fri, 09 Aug 2024 06:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1723209354; x=1723814154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3dJ7qtnD19uVlJPhPdMNCqs7jTdBCd7yeTc+miv65vA=;
        b=YY8En4HzDpotIZKxTs4kyjk8RQLDW4MRpoC8Gn/3oiLGZrfTXyYd9oirOIPtnUogcd
         oByqs4uDcikIAUJbU/xQcOOQeEjzlzyFJSjmn0F7UQWCGUEDxiIFfQnNn14zb4HRLFBf
         yz/FBcD4INuIMlQK1rIJk2ea14jlRNVUBz44/ocGf2avu2BZNBv/2O9eeTLG6UpB6Gac
         fJ3LaDN0nMzsija3vEwDAM/apWUcZrXrzqpFkLDa21rP9/Bf7VfjuJlnyrdo3imJFaud
         k1nlXbyn07zLbWRJsCUY9Wc9IgV5Gyj7uBtb0o7rBgldMDQVXX7TaM3BIlVZK7l3g7RL
         u7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723209354; x=1723814154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3dJ7qtnD19uVlJPhPdMNCqs7jTdBCd7yeTc+miv65vA=;
        b=XRCOijUdyOp/Vw3qpe7wIfU+yzsuuzWOLjgMARJ2l6yn4ddPczhk2yZt4GnnNoRd/8
         ptfvt2zb+xPu+MGiRD20P2+32+wYkr9sv8jLUGNQ9Xa23IVu3JjYcUxhLD/GaTCSbf6p
         2WDhTy2pxkVONeZVkkIzENwnVIXHmpFOznZ58/wI7hmjlQWRQqOeVl37VRws3UgAwQH8
         g436dmKQp+h/pb8gnXU7coFpponcMTA18yM3FPhlzyQITQJXGdLBL17VMh40RHgV++Ni
         kMvcfWZndApgazBDCCBZhoSzahxln0OmJfvhxzUSXJeHwbnqBufVbd34twlLbdvyBAST
         DK4Q==
X-Gm-Message-State: AOJu0YxtKJWVXFfE27I1+PjPYKUhbKEKY6bKW0S3/+7XNJjRuS1+eRBm
	4PqOdROhLK96CZ7Wi66UwQfgwoyOlYaWAXrkCNQD4fzFcGMS39EpoqwgRd/IJQdaEzPqdqdxv6q
	F8ys=
X-Google-Smtp-Source: AGHT+IEV4VEEvMlP3IuRX7t33ffsuNfz7gl+cDCVQKkpmhyfDIxJ6r0z5crtASGEc5zJJbvfZffBgw==
X-Received: by 2002:adf:eac7:0:b0:367:4e05:bb7b with SMTP id ffacd0b85a97d-36d612f11e9mr1482366f8f.53.1723209353931;
        Fri, 09 Aug 2024 06:15:53 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c77f078sm78280625e9.37.2024.08.09.06.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:15:53 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com
Subject: [PATCH for-next 00/13] Misc patches for RTRS
Date: Fri,  9 Aug 2024 15:15:25 +0200
Message-Id: <20240809131538.944907-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jason, hi Leon,

Please consider to include following changes to the next merge window.

Grzegorz Prajsner (1):
  RDMA/rtrs: register ib event handler

Jack Wang (8):
  RDMA/rtrs-srv: Fix use-after-free during session establishment
  RDMA/rtrs-clt: Fix need_inv setting in error case
  RDMA/rtrs-clt: Rate limit errors in IO path
  RDMA/rtrs: Reset hb_missed_cnt after receiving other traffic from peer
  RDMA/rtrs-clt: Reuse need_inval from mr
  RDMA/rtrs-clt: Print request type for errors
  RDMA/rtrs-clt: Do local invalidate after write io completion
  RDMA/rtrs-clt: Remove an extra space

Md Haris Iqbal (4):
  RDMA/rtrs-srv: Make rtrs_srv_open fail if its a second call
  RDMA/rtrs: For HB error add additional clt/srv specific logging
  RDMA/rtrs-clt: Reset cid to con_num - 1 to stay in bounds
  RDMA/rtrs-srv: Avoid null pointer deref during path establishment

 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 92 ++++++++++++++++----------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |  3 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h |  2 +
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 80 ++++++++++++++++++++--
 drivers/infiniband/ulp/rtrs/rtrs-srv.h |  3 +
 drivers/infiniband/ulp/rtrs/rtrs.c     |  2 +-
 6 files changed, 138 insertions(+), 44 deletions(-)

-- 
2.25.1


