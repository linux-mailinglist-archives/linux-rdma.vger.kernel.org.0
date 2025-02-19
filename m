Return-Path: <linux-rdma+bounces-7851-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D08A3BF80
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 14:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C2F189273B
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 13:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7231DF756;
	Wed, 19 Feb 2025 13:07:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F131CAA6F
	for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2025 13:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970471; cv=none; b=Lrn2TC03e0OYpIPHmjVyQDo0j9m9RuwdY6BvmqQh8bt8dZp/bY6NBtFP7RlghwVBusn1vUuwUSTrURTSqk8J2VwWepsPFYsoVcOZV2sb6ROMxWV95dfhNnVh4epDFqnMLJnyw6v61mZaNzVGgs+KO8UloCr1gzu9eY3r7D0JeAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970471; c=relaxed/simple;
	bh=D1AuTs6xxkXvtO97sdEEvrflT9L93YnzaUMwaUeW4Ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g4pUkW2SSTNYB1BoOdGOjZREY6ERngmiAceiWaLcMR+SvYPoaCwaWwfUueCtUWlaz29c3k0BzvNHIraWK5Jw3N5cs3f7GHBTSGcLEzT48Gpv0oJWAMS/eCXnp58GhuCKFbP/oKVUbzZSmy8BdWVx0q+fybNaQxsPzAlwgjrqcNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Yyc6s6qzDzHr8r;
	Wed, 19 Feb 2025 21:04:37 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id A3B2A1402E1;
	Wed, 19 Feb 2025 21:07:38 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Feb 2025 21:07:37 +0800
Message-ID: <bb0a621e-78e1-c030-f8f6-e175978acf0f@hisilicon.com>
Date: Wed, 19 Feb 2025 21:07:36 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH for-next 0/4] RDMA/hns: Introduce delay-destruction
 mechanism
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<tangchengchang@huawei.com>
References: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
 <20250219121454.GE53094@unreal>
Content-Language: en-US
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20250219121454.GE53094@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2025/2/19 20:14, Leon Romanovsky wrote:
> On Mon, Feb 17, 2025 at 03:01:19PM +0800, Junxian Huang wrote:
>> When mailboxes for resource(QP/CQ/SRQ) destruction fail, it's unable
>> to notify HW about the destruction. In this case, driver will still
>> free the resources, while HW may still access them, thus leading to
>> a UAF.
> 
>> This series introduces delay-destruction mechanism to fix such HW UAF,
>> including thw HW CTX and doorbells.
> 
> And why can't you fix FW instead?
> 

The key is the failure of mailbox, and there are some cases that would
lead to it, which we don't really consider as FW bugs.

For example, when some random fatal error like RAS error occurs in FW,
our FW will be reset. Driver's mailbox will fail during the FW reset.

Another case is the mailbox timeout when FW is under heavy load, as it is
shared by multi-functions.

Thanks,
Junxian

> Thanks

