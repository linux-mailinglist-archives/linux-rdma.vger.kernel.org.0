Return-Path: <linux-rdma+bounces-5355-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1789998067
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 10:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62567283396
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 08:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F941BD00C;
	Thu, 10 Oct 2024 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="BF6Aup8a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from va-1-17.ptr.blmpb.com (va-1-17.ptr.blmpb.com [209.127.230.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296931BBBC3
	for <linux-rdma@vger.kernel.org>; Thu, 10 Oct 2024 08:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548672; cv=none; b=T4Cmg/b3VHCZZllS1Ijs1lpPnHSuAmOiTVZwEbZkNNp0Z+aGhsXDQtRQpUPYswsa56NKRPUWf5ub+ngilnJcn9NAeLFesp9rlcneYFFVLYwQflncew0VW9uyq4vvagn2xYuE/yywiy9/jkyRe1Bwz/tesBpATtf5Bf75er/sSJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548672; c=relaxed/simple;
	bh=6IW/15MoGA+Dy3EAKdlMmjCBs1Cqi/vn6T/QE9RjH7U=;
	h=From:Mime-Version:To:Cc:Date:Message-Id:Content-Type:Subject; b=tnb05L3Cbmb/Y8f3THskNwKosHU87cL6+3TABy52EqXkZivmHLHvF4fy0Dc0wLZpIU95cVXPFtYrj+1FAW9VTH/XbfbAQXgSo/4RBY/rXdwds5lP6uTaVwMkPtY8EuW/2sf3nc7ym7R3SRx1n71iZx/L4AftSsc15NHLg1DkLvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=BF6Aup8a; arc=none smtp.client-ip=209.127.230.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1728547852; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=pJqwshmbeqxYOYLX7p7vxMa2mvIqrwIpf/6/+Im4f14=;
 b=BF6Aup8aBXoyF9Oq/0tWJ4erispI6UgGD1HgBg3mhkOLvTMkMJxkxu7GCqNSDasn9T/0ZG
 je2Nkayrp2SqxUGKXCj3GSNi+a77JDJn8MyXOWXqOc8fs0jwXIfMYIYBBQZ+niHeo+hMke
 U0J/3yebujCR8yt3DoBB1RV1YEFbBOIlIZu+l1Lj5qxI1R+KBkwz0nPLcISn3M+WBLRuje
 4aP0YJlEtk8VBm+bIhJ+aFoVhPoIfYwMn5XXJWGFcZbAAvmI8UuNjrGdFElzgZzluI4zW2
 Dvx4Z5Hf7rvW2NSj/7U00zK0SS+3HDpCbO5WIyjBHpn1kwmMqy4rkpJfFzh2ew==
From: "Tian Xin" <tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Tian Xin <tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
To: <leonro@nvidia.com>, <jgg@nvidia.com>
Cc: <linux-rdma@vger.kernel.org>, "Tian Xin" <tianx@yunsilicon.com>
Date: Thu, 10 Oct 2024 16:10:43 +0800
Message-Id: <20241010081049.1448826-1-tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+267078c0b+68afd4+vger.kernel.org+tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 0/6] Add Yunsilicon User Space RoCE Driver
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Thu, 10 Oct 2024 16:10:50 +0800

This series of patches adds the user-space RoCE driver for the Yunsilicon MS/MC series smart NICs.
Please review and apply.

Thanks,
Tian Xin

Tian Xin (6):
  libxscale: Introduce xscale user space RDMA provider
  libxscale: Add support for pd and mr
  libxscale: Add support for cq related verbs
  libxscale: Add support for qp management
  libxscale: Add support for posting verbs
  libxscale: Add xscale needed kernel headers

 CMakeLists.txt                            |    1 +
 MAINTAINERS                               |    9 +
 kernel-headers/CMakeLists.txt             |    2 +
 kernel-headers/rdma/ib_user_ioctl_verbs.h |    1 +
 kernel-headers/rdma/xsc-abi.h             |   74 ++
 libibverbs/verbs.h                        |    1 +
 providers/xscale/CMakeLists.txt           |    8 +
 providers/xscale/buf.c                    |   42 +
 providers/xscale/cq.c                     |  568 ++++++++++++
 providers/xscale/qp.c                     |  632 +++++++++++++
 providers/xscale/verbs.c                  | 1019 +++++++++++++++++++++
 providers/xscale/xsc-abi.h                |   31 +
 providers/xscale/xsc_hsi.c                |   96 ++
 providers/xscale/xsc_hsi.h                |  178 ++++
 providers/xscale/xscale.c                 |  303 ++++++
 providers/xscale/xscale.h                 |  365 ++++++++
 16 files changed, 3330 insertions(+)
 create mode 100644 kernel-headers/rdma/xsc-abi.h
 create mode 100644 providers/xscale/CMakeLists.txt
 create mode 100644 providers/xscale/buf.c
 create mode 100644 providers/xscale/cq.c
 create mode 100644 providers/xscale/qp.c
 create mode 100644 providers/xscale/verbs.c
 create mode 100644 providers/xscale/xsc-abi.h
 create mode 100644 providers/xscale/xsc_hsi.c
 create mode 100644 providers/xscale/xsc_hsi.h
 create mode 100644 providers/xscale/xscale.c
 create mode 100644 providers/xscale/xscale.h

-- 
2.25.1

