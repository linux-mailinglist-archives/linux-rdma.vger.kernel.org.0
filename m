Return-Path: <linux-rdma+bounces-2754-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4B28D7453
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Jun 2024 10:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3C41C209DE
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Jun 2024 08:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E979224CE;
	Sun,  2 Jun 2024 08:53:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF3413ACC
	for <linux-rdma@vger.kernel.org>; Sun,  2 Jun 2024 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717318389; cv=none; b=esYqVt/9bVfLzF3h35Hw3yG2m8FONrWlV+Gpjr3w91WDRL/0IYOs4Rly93GVHp4BSa7iR/yzv00tZSSYcu5DH6YJskCp0roFXJGw9dOmyddxlEfQ8BYQsIR7OLsBy/eSNaIOCtTI/XQP0e/wfVNVGqthIRl4jTIMoIlm4WVQktM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717318389; c=relaxed/simple;
	bh=5D6hHYB/KxMDY2h3ilZKciUx4vDFuTVv/Sg5RO/5Arg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SytRqelH0LiQmtpfqKktG4Of06Y8QVoxLbe6BBCVp4vKjMEDP/tzB9vLacp63sIBKMgpanmcYBVgaOwoohCPjkdbSeKh85Je0JI/KPAJou36nr/+ho7zVtg7pir7RoU7WNhvqlGCSzsWmM5Fd4zBKeXOTVX7GsvjC9ZADlOMHdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35e4f079a35so43787f8f.3
        for <linux-rdma@vger.kernel.org>; Sun, 02 Jun 2024 01:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717318386; x=1717923186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOIamolSmIsdDNneb1zZPLdnns4+ZKhOIH/+0czP5sQ=;
        b=uYddfccAd3USXC5iQPaWVTT+hCOQgXLRt8Jp1KjYJBGRixQbbwhgFkckJIKEcff+wW
         E7IHujDCiU/HXx1vu3qaW2qkpnRhG6igRed75IKJQPGFBeNK+xQJPbcxh6a+YlvNpyXx
         XUGS3N60UipHxbkeAmDc8rtAvo7VAwA6mGZmr9y6jQZUh+1rkHb51eRXWQhoLAES39dH
         guAu8zli8dkvaiVLU3PBuPnlF/ka/z/Cl30H/HyqOa4rOaybr/N0DNRW5FaatPHdJ+84
         JsTjQG4yCrfMjyt1mLdykVkrFA3gUXDUSEM8l4YvP0Ldh7TXzKY5LBw6r6MlAs3zu8Rb
         Fh8w==
X-Gm-Message-State: AOJu0YzghLTMD5Bt7OVl7BNY/1mAH+YAaTB3x/xUSvLA43cfm502VHrr
	8EupNlQFJx1IS0D3foqdS9oKpnhD58DDwwpLP/StPy6kDUwgpand
X-Google-Smtp-Source: AGHT+IHbz9uMhwf26n1Cr16NAx9q2t8OQyZScigkCl0IpAocC9EBaxPM4nvKbehFDMySz3V1IFlxDQ==
X-Received: by 2002:a05:600c:3ba5:b0:421:2b37:80fd with SMTP id 5b1f17b1804b1-4212e0ae001mr47636405e9.2.1717318385707;
        Sun, 02 Jun 2024 01:53:05 -0700 (PDT)
Received: from [10.100.102.74] (85.65.205.146.dynamic.barak-online.net. [85.65.205.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4213a5b9f88sm10931535e9.16.2024.06.02.01.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 01:53:05 -0700 (PDT)
Message-ID: <ac1ccd5e-598e-4e67-8e32-2f8d499d6ff7@grimberg.me>
Date: Sun, 2 Jun 2024 11:53:04 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] rdma/verbs: fix a possible uaf when draining a srq
 attached qp
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Israel Rukshin <israelr@nvidia.com>, Oren Duer <ooren@nvidia.com>
References: <20240526083125.1454440-1-sagi@grimberg.me>
 <20240602081934.GJ3884@unreal>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240602081934.GJ3884@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 02/06/2024 11:19, Leon Romanovsky wrote:
> On Sun, May 26, 2024 at 11:31:25AM +0300, Sagi Grimberg wrote:
>> ib_drain_qp does not do drain a shared recv queue (because it is
>> shared). However in the absence of any guarantees that the recv
>> completions were consumed, the ulp can reference these completions
>> after draining the qp and freeing its associated resources, which
>> is a uaf [1].
>>
>> We cannot drain a srq like a normal rq, however in ib_drain_qp
>> once the qp moved to error state, we reap the recv_cq once in
>> order to prevent consumption of recv completions after the drain.
>>
>> [1]:
>> --
>> [199856.569999] Unable to handle kernel paging request at virtual address 002248778adfd6d0
>> <....>
>> [199856.721701] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
>> <....>
>> [199856.827281] Call trace:
>> [199856.829847]  nvmet_parse_admin_cmd+0x34/0x178 [nvmet]
>> [199856.835007]  nvmet_req_init+0x2e0/0x378 [nvmet]
>> [199856.839640]  nvmet_rdma_handle_command+0xa4/0x2e8 [nvmet_rdma]
>> [199856.845575]  nvmet_rdma_recv_done+0xcc/0x240 [nvmet_rdma]
>> [199856.851109]  __ib_process_cq+0x84/0xf0 [ib_core]
>> [199856.855858]  ib_cq_poll_work+0x34/0xa0 [ib_core]
>> [199856.860587]  process_one_work+0x1ec/0x4a0
>> [199856.864694]  worker_thread+0x48/0x490
>> [199856.868453]  kthread+0x158/0x160
>> [199856.871779]  ret_from_fork+0x10/0x18
>> --
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>> Note this patch is not yet tested, but sending it for visibility and
>> early feedback. While nothing prevents ib_drain_cq to process a cq
>> directly (even if it has another context) I am not convinced if all
>> the upper layers don't have any assumptions about a single context
>> consuming the cq, even if it is while it is drained. It is also
>> possible to to add ib_reap_cq that fences the cq poll context before
>> reaping the cq, but this may have other side-effects.
> Did you have a chance to test this patch?
> I looked at the code and it seems to be correct change, but I also don't
> know about all ULP assumptions.

Not yet...

One thing that is problematic with this patch though is that there is no
stopping condition to the direct poll. So if the CQ is shared among a 
number of
qps (and srq's), nothing prevents the polling from consume completions 
forever...

So we probably need it to be:
--
diff --git a/drivers/infiniband/core/verbs.c 
b/drivers/infiniband/core/verbs.c
index 580e9019e96a..f411fef35938 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2971,7 +2971,7 @@ void ib_drain_qp(struct ib_qp *qp)
                  * guarantees that the ulp will free resources and only 
then
                  * consume the recv completion.
                  */
-               ib_process_cq_direct(qp->recv_cq, -1);
+               ib_process_cq_direct(qp->recv_cq, qp->recv_cq->cqe);
         }
  }
  EXPORT_SYMBOL(ib_drain_qp);
--

While this can also be an overkill, because a shared CQ can be considerably
larger the the QP size. But at least it is finite.

