Return-Path: <linux-rdma+bounces-13592-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB28B959D3
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 13:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00EE719C28EA
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 11:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C014B3218C9;
	Tue, 23 Sep 2025 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtShq0u8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C2E286D70
	for <linux-rdma@vger.kernel.org>; Tue, 23 Sep 2025 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626452; cv=none; b=MHgoALDgqhSCVU2i0Oi3LUt1S08fTgI6XrttfUy17vekRhfpfV+HxttON0zTtM/ztYscc54Sy36TzVY+aT8e7A+qakX62dMr8A3FT4Y4f1Czlpm4SQ41ssKCGQpjDJIF0/uJNo7Cxbk22zV+m4AyJqIOThLuaPhWqnlSFYu+3h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626452; c=relaxed/simple;
	bh=eJliZ++5VLobZbvP2Qe72C0QCu7EczhThEbLO5tMavE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QnaNvJNsyM/XD9K2Z5amibTpypEZIIYCQg6ASKYvd+yzp3DnTbBXW1rkyqZN27E/zdVUzSZJDZw25ez0LLpKFITerXDMmZBvAhHQQ8qp59VuXOISHSHglIhoUROPRCn1gFsHQ/FcYKoyLkqikaMhUKjPg1+iq4/bXlszoDod6qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GtShq0u8; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso4199752f8f.1
        for <linux-rdma@vger.kernel.org>; Tue, 23 Sep 2025 04:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758626449; x=1759231249; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9zredUSynQCwtloc7g5NGofS4JgiDu7n8B9m9/iOKfE=;
        b=GtShq0u8Ox+G+as6n1sQ/UNEvHSUL4sGvdmQ96ylXy0rGwgmK0D7e09CQQcxSNohmv
         zYfTD24hWO2afThqKXOqWaj104tmEG6HAR3wgKUkIjI65DUfflw9WvZJOtMa5WRh2KnP
         D2z6Mngj3zC4KqbSECmXiQWcZrlDqtJhF8hbnrtbRhc2d+weKtwPNmiMl8UjRwbJn7x2
         4gxPKr63AbVOiQXcuPRaNIVp+D7HCewRHhG9TP+gR72enuioAzLSESrGDU2OnjyYAFfd
         VV3pA2z9ov9Z0F5CkV2jJUfsKkNbe0KuBioMhZm/57LFu13Xnt1Q/Y66e/GGv0upH+I0
         SK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758626449; x=1759231249;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9zredUSynQCwtloc7g5NGofS4JgiDu7n8B9m9/iOKfE=;
        b=Derd/hvHlpE2MYjqLz3G1xIv9lqiOk4WK6191ggEyfAB2/HmwqOCeFZDwXxaRLBIWG
         Ao3v24hp9DjTm2COX+kjZdeV0rWEUkcfXFX3hrAyZ5sqKshg5e5nYqPHwL09NlTHMfoV
         FCi/2/WFIhqfpBdHdqVEt6zKlPNhpi0NEKtcTO7ovdQ5qD5v/iIOXqmlRIyYD4UK/6sx
         rSxxydOU2JfhqCnBHrxx+JKHiH/v0r4dPZLHCEi46kaO6MrAA3HJlpZMCS4y8GDct5q4
         qGuErHnlVuDkj9lLtNKhy58wDdqvs4tzNgAteNTfYMmh2dBQQ6/GY+8eG0Gz55XitCs/
         +SzA==
X-Forwarded-Encrypted: i=1; AJvYcCVxcQxRvESFcSdPT+r0ighWb0WNq7e2gX5sqvHdnw2N7OTvhD/abihiV6CE+QtVq75dXEd0Dri+3R2Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzZJEo7ztm/2yKd2dzvzyIjYr665aY7tgqZE5o7CpZRifjYXaYc
	LLb/rPOfjHhU60HYbb/3UtCd0f+bebuQXKhkhjKZzC6N5JQdC7cuya+UMFzXKSC/6jDA6mjgJEC
	+HDb4
X-Gm-Gg: ASbGncuumpvfv2R7+Nlo7cyvBJb2jskG4UO7AEEWrn816tQYu3p/GYuS51sk+FIILks
	iRx16cxTcsCt+z3DIRqmQxX56fuejR9mJNVGnee/+HQgUbupWo88Rl2QVRSJa1pwFMoALtZ6ytN
	6q3tZH1fbc+U2nTT2WQ9dFcCz93Wd10WRtwII6NaxEH4YhiDtIGWqov4fmD1aA4d4GZTB6i3GmL
	VtRRLbnO2XhKv1qdxeAGJXhjUEl6Sp5ci4jpi3Cug7N5bIyXNpU3ORp6e3HrJLYh/ulboPkB5u1
	Te+c4aIIS8c59PXXiNBssfo+ec8jmBfCx9GYgO/GUiDclsZXdVN2m3OaHR4QUBz7863+cTR5DPO
	nBTZ/Vuj8vVjeFc2CJw0KnOdA5UQI
X-Google-Smtp-Source: AGHT+IFOLWwlUksxJsVUnIS1To44S+BUbgVSaPlPESYIl9UWZxAJU0rpuoUTCO7CBZd1r0VNy84pmw==
X-Received: by 2002:a05:6000:40da:b0:3f2:dc6e:6a83 with SMTP id ffacd0b85a97d-405cb9a5341mr1917861f8f.59.1758626449168;
        Tue, 23 Sep 2025 04:20:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee0fbc7188sm24521715f8f.37.2025.09.23.04.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:20:48 -0700 (PDT)
Date: Tue, 23 Sep 2025 14:20:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Faisal Latif <faisal.latif@intel.com>
Cc: Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] RDMA/irdma: Fix positive vs negative error codes in
 irdma_post_send()
Message-ID: <aNKCjcD6Nab1jWEV@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code accidentally returns positive EINVAL instead of negative
-EINVAL.  Some of the callers treat positive returns as success.
Add the missing '-' char.

Fixes: a24a29c8747f ("RDMA/irdma: Add Atomic Operations support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/infiniband/hw/irdma/verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 24f9503f410f..f9d9157029ac 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3966,7 +3966,7 @@ static int irdma_post_send(struct ib_qp *ibqp,
 		case IB_WR_ATOMIC_CMP_AND_SWP:
 			if (unlikely(!(dev->hw_attrs.uk_attrs.feature_flags &
 				       IRDMA_FEATURE_ATOMIC_OPS))) {
-				err = EINVAL;
+				err = -EINVAL;
 				break;
 			}
 			info.op_type = IRDMA_OP_TYPE_ATOMIC_COMPARE_AND_SWAP;
@@ -3983,7 +3983,7 @@ static int irdma_post_send(struct ib_qp *ibqp,
 		case IB_WR_ATOMIC_FETCH_AND_ADD:
 			if (unlikely(!(dev->hw_attrs.uk_attrs.feature_flags &
 				       IRDMA_FEATURE_ATOMIC_OPS))) {
-				err = EINVAL;
+				err = -EINVAL;
 				break;
 			}
 			info.op_type = IRDMA_OP_TYPE_ATOMIC_FETCH_AND_ADD;
-- 
2.51.0


