Return-Path: <linux-rdma+bounces-5974-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 049639C8367
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 07:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D38284520
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 06:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5C71E9098;
	Thu, 14 Nov 2024 06:57:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDBC139D1B
	for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2024 06:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731567448; cv=none; b=J5sn+yvhBW8OmdUXvIdYzgzfYsa+5pGQVYBw5D+YBQsfsgAjFBPOCvwPA9RulbDvJKHYwmcqaxmyxbkI37sbXD02Ogag1rAcyCziDVRe1v299SKg7MWagleElSb+X1p5FC+3YuCimCaw7MGaiY4+DIVWwgpNKsoz16wZO8pL3uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731567448; c=relaxed/simple;
	bh=jmljp83+knV+riIvIUygoF5ux+8DsnH83ij/BySStCM=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=oxuvngyhk8R0e7YLCGkBN0ben3euPAUcA9dfg0TG681SOAIjafyb/kL/a/vCUDQ5QcGjcNp4H4Fzh1bT7jiVRojsaK47H7E1QkBt6iX9CymgbZgnAYtRCiZhhsKUtW/67TDv+rW1tbm7PJAF3EFzGy9QMuiNvcRtLi8qJVfTNmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XprWg1Vd8z10VgB;
	Thu, 14 Nov 2024 14:55:27 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 65216140154;
	Thu, 14 Nov 2024 14:57:22 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Nov 2024 14:57:21 +0800
Message-ID: <8fe49262-98cf-6b43-4f55-b09a8ae449ca@hisilicon.com>
Date: Thu, 14 Nov 2024 14:57:21 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Content-Language: en-US
To: linux-rdma <linux-rdma@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, <ynachum@amazon.com>
CC: Linuxarm <linuxarm@huawei.com>, "huangjunxian (C)"
	<huangjunxian6@hisilicon.com>, Chengchang Tang <tangchengchang@huawei.com>,
	wenglianfa <wenglianfa@huawei.com>
From: Junxian Huang <huangjunxian6@hisilicon.com>
Subject: Why is the DENABLE_LTTNG compiler option in rdma-core disabled by
 default?
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Hi all!

We've been working on LTTng tracing for hns userspace provider
recently, and we wonder why the DENABLE_LTTNG compiler option
in rdma-core is disabled by default.

If it's due to the concern about performance degradation, we have
tested it on hns and found no significant performance difference
when the tracepoints are disabled.

Or is it because it introduces additional compilation dependency
on LTTng library?

Thanks,
Junxian

