Return-Path: <linux-rdma+bounces-9076-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F81AA77BB3
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 15:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1925188C15C
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 13:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFA020371B;
	Tue,  1 Apr 2025 13:07:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF603203707;
	Tue,  1 Apr 2025 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743512868; cv=none; b=XuC6oTf/nwgsAa/Gxn3W+o5L2XzYP700WukmsJfz9N3pvda+6LgyPV5WciDP61ydvK9OVA11ARMp//OAlPcLIDv7lgGRGGbFP+OI1DKi798cD87FnNPnrhRDh5BoHqAKUvP3PajBfxqSjcmSjBH01eoIjTBs85MmqaoTMHvZnvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743512868; c=relaxed/simple;
	bh=eK2aHIv6qYmDyYHmosfypG6BcXouODK6BYLbZUYfzyI=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=RcuzAVmrv7n2VQ7c4D+59tAHYFp+aMmjEBSO8Y6PuWuXehHvYY3ktFgZNjv40oSIm+NiSCORXxCGxxOeCzE1T2LFTMiXiAmaL6r5sQr31cN2DitluV9bDOx66PSx0gwSiiERKGAHSX2bg60aLK5hG3MxHwPdrSOUYlMQSIJlmO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZRpFH1Vdqz4x5rh;
	Tue,  1 Apr 2025 21:07:31 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 531D7QDt050668;
	Tue, 1 Apr 2025 21:07:26 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 1 Apr 2025 21:07:30 +0800 (CST)
Date: Tue, 1 Apr 2025 21:07:30 +0800 (CST)
X-Zmail-TransId: 2afc67ebe512fffffffffcb-10ecb
X-Mailer: Zmail v1.0
Message-ID: <20250401210730615ULucEmQClX13Q7svZwHsD@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <jgg@ziepe.ca>
Cc: <leon@kernel.org>, <li.haoran7@zte.com.cn>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
        <brauner@kernel.org>, <agoldberger@nvidia.com>, <cmeiohas@nvidia.com>,
        <msanalla@nvidia.com>, <dan.carpenter@linaro.org>,
        <mrgolin@amazon.com>, <phaddad@nvidia.com>, <ynachum@amazon.com>,
        <mgurtovoy@nvidia.com>, <yang.yang29@zte.com.cn>,
        <xu.xin16@zte.com.cn>, <ye.xingchen@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIDAvM13CoENvbnZlcnQgdG8gdXNlIEVSUl9DQVNUKCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 531D7QDt050668
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67EBE513.002/4ZRpFH1Vdqz4x5rh

From: Li Haoran <li.haoran7@zte.com.cn>

As opposed to open-code, using the ERR_CAST macro clearly indicates that
this is a pointer to an error value and a type conversion was performed.

Li Haoran (3):
  RDMA/core: Convert to use ERR_CAST()
  RDMA/uverbs: Convert to use ERR_CAST()
  RDMA/core: Convert to use ERR_CAST()

 drivers/infiniband/core/mad_rmpp.c   | 2 +-
 drivers/infiniband/core/uverbs_cmd.c | 2 +-
 drivers/infiniband/core/verbs.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.25.1

