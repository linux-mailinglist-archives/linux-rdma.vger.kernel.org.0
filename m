Return-Path: <linux-rdma+bounces-7615-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005B8A2E2BC
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 04:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4591887961
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 03:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5F16F06B;
	Mon, 10 Feb 2025 03:28:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1533835957
	for <linux-rdma@vger.kernel.org>; Mon, 10 Feb 2025 03:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739158089; cv=none; b=Lf9xdw1lzRMBcqsZBPOChdrQgmzwYX/i2iU2KHSZu90yVr1e8oSvKOFm9/vKKunXl4Lh7mbw9lZcqF0IHMF+4OQVoWUzmx2CxIjbafwrqW02ze5Zi+135feeGzVdePU/7vhbpvkMzOVC10ky831iFQAFLCe+0cnAHRLxsLj15/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739158089; c=relaxed/simple;
	bh=68D/2O4zBuWzseOsqiEVzI22nK2g3Zks+RBr2A5v230=;
	h=Message-ID:Date:MIME-Version:From:To:CC:Subject:Content-Type; b=IiD76DgLE5b4ef0X2hK9+XENfFsQI51yXUftJOh5l6M8OXTyUdlmNawE9ZuHe05KgFdxzd7mx5SXEDh8dqkcWAkmQQ3NuZEqagIiu6cnU8KquMTCl+Mtigybm8++p63NzWaMKdZBcVL0eaqdiEkKQ5NwWLR/x8DyVogwxPMeV9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YrqfY41GGz11Pvd;
	Mon, 10 Feb 2025 11:23:33 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id C8F4C1400E3;
	Mon, 10 Feb 2025 11:27:57 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Feb 2025 11:27:57 +0800
Message-ID: <b80b04df-ff75-9308-6d27-a8df9f6abca8@hisilicon.com>
Date: Mon, 10 Feb 2025 11:27:56 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: linux-rdma <linux-rdma@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
CC: "huangjunxian (C)" <huangjunxian6@hisilicon.com>
Subject: Question about ib_drain_sq()
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Hi all! A simple question about ib_drain_sq():

Why are we posting a WRITE wr but not a SEND in ib_drain_sq()?
This doesn't work with UD QPs.

Thanks,
Junxian

