Return-Path: <linux-rdma+bounces-6421-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3516F9EC787
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 09:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39B9188C5F3
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 08:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8215B1D86E6;
	Wed, 11 Dec 2024 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UPIi4xKp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9178489
	for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906643; cv=none; b=r8+Fru1cPX6xeFkJUD5ePYO3/umzN1EOlMwnZ8YnjpUaQJgq44s6iggITig0csJilVXlV8JlI3rVGOOpc5NksF3dkl0u+54i5FQk2dDx3eBUCNzKjWGLKsZocY0Y3v25w2bEpbgKxAobqOJRYhTjkro0VmIYw+PPQoV7+NxGJuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906643; c=relaxed/simple;
	bh=9bc56+QWjsuiU0VAKiygWMcFOW8hCo6OcmbZn56qRhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A3Yuk3kZjARKwLduadwbD/2DynM7uzHxaS8ZmjMGrmKAGWcExFrbRuiZmbpgynwAPU13IWQtJaIhmEmj/iXOL8qQyixhDP0UUsVj87c2chAF31K4iivcmk6v06Fja4GEEKjVY6qHFeGeZTpIQmzf01pe1eGJfjw2h/LIY/jPv3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UPIi4xKp; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fc93152edcso367315a12.0
        for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 00:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733906641; x=1734511441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cYjuGLOWC+wkjU/L9Iu1pnR9w/FkUwo1t58nVflSajk=;
        b=UPIi4xKpASGBLUQlSQflhCkKKtCXSH+bpCMcpvIAPnoh/xIbB4Na5bZEuHSS0SMoGf
         YyZtL4DZ7Lj8z4MVZ49kOYOD+tOKolXpFJ3QG311mx9cGKWxw/HOkvN0zDUGPh49HOCM
         vAWG7Vz7TaVw8QQzWGI3DPI8v//UZj1WD3Bew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733906641; x=1734511441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYjuGLOWC+wkjU/L9Iu1pnR9w/FkUwo1t58nVflSajk=;
        b=h6uMDiYSt0VLvbBYoJwYs2PL2414ixyU3Oh7Eszh32xd+9VQ3gFz3QWEtHr8OcATv8
         mMq358NngdV0wNhwU8FRgRoOBJRNtGT/AGbOMgyq5QLCIX+WKzfFwKEy2JX61bK7rHM1
         SkTkmO8RPjMSnQ1879L686X4nIcti7encv3a7g5t7b00eqidbNUtqxw/O6EM+nOBuPwQ
         o0C976xaCmz6usmmKWOqhbU8gs9Ewh/StSpoggTI33itiwDFtj1P0CLfstx7vBfVNjdt
         1Nx+fZMyafAB8WC8NQaMfiY5gJVztLpOjkMoQH8KBkU8qLQqyj7UtMQuUmGVNOypMDkv
         929w==
X-Gm-Message-State: AOJu0Yz4jFZagMtiS7MUN0puPhYsQfWI9c8ybr/cDYNRBrkkmqn+A+Ma
	KMnpwgOzciQmhTZguwaqGjG6KG94Lq5lRYd35xozr/VRHMaqe3polLXkfRiw0pixRlgr/DYtPg4
	4Ig==
X-Gm-Gg: ASbGnctP4ygubu+tUJkQ/ZH6N0/y1blY0F0Pdijpz0pmjnb+wX1G0pQihvQS3oDdcOK
	nNjoo+3h4V8rWCK2NPW1JZXi42ySRcvIPu3xOVgMp+X54Hyi2InpoTpJ+aBTChDVVA5/A2TDg+H
	d6kUesestF3cdLXfvhNcsMGILowwMUSHmpOrR7MH2ED4uIEZmxZBPoeW2v6DwZQiEWM+cEYZUeZ
	rKokTTIK/rzpIrgBuNxVoFfSkYfBrGGuPfbWEd+SQuGPomTrjgQfFWMDXrTi5A0qOHaIvETYrjq
	9kuIqqadUfklRm0jCFrMJ0rGuF1w48DZonjpgou3LMZys8+zkoinuRI+
X-Google-Smtp-Source: AGHT+IFep7g2cR8+7lLW02kpbTLvmP5fas/Vl4PD+aTk1ocdNa4itJbF6H9/78FOvTa6mecVBJvI7g==
X-Received: by 2002:a05:6a20:9f96:b0:1e1:aef4:9cd9 with SMTP id adf61e73a8af0-1e1c27284demr3425887637.23.1733906640891;
        Wed, 11 Dec 2024 00:44:00 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7273b69ce95sm3653678b3a.66.2024.12.11.00.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:44:00 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH for-rc 0/5] bnxt_re Bug fixes
Date: Wed, 11 Dec 2024 14:09:26 +0530
Message-ID: <20241211083931.968831-1-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains some bug fixes for bnxt_re.
Please review and apply.

Regards,
Kalesh

Damodharam Ammepalli (1):
  RDMA/bnxt_re: Fix setting mandatory attributes for modify_qp

Hongguang Gao (1):
  RDMA/bnxt_re: Fix to export port num to ib_query_qp

Kalesh AP (2):
  RDMA/bnxt_re: Fix the check for 9060 condition
  RDMA/bnxt_re: Fix reporting hw_ver in query_device

Saravanan Vajravel (1):
  RDMA/bnxt_re: Add check for path mtu in modify_qp

 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 29 +++++++++++++----------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |  4 ++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 24 ++++++++++++++-----
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  1 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  5 ++++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h  |  1 +
 6 files changed, 45 insertions(+), 19 deletions(-)

-- 
2.43.5


