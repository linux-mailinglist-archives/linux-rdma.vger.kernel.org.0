Return-Path: <linux-rdma+bounces-13674-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ADBBA4911
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Sep 2025 18:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C7A16C64A
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Sep 2025 16:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477C22417E6;
	Fri, 26 Sep 2025 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WSURiEWC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF548242D60
	for <linux-rdma@vger.kernel.org>; Fri, 26 Sep 2025 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903089; cv=none; b=pBcqEPTw2WHrCnIGuGIibKUVRs6uW9J2asga+W4NE/KDvJY90U0CLlstEFFkum8xbnf/AJs32U9s82GmG5Rdi4bJpWy2QSs8OtyEjx494boYxZG3KmRlxx/H9YmWabW2XO1J0j65qHLxULoIRmnC1Cas6AsVxaWraMu8cAT01hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903089; c=relaxed/simple;
	bh=97hcWjTcvBFQYDBOqWYzz1/27EeK9RIc1yRkc9gWydE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfGKHYSMZiwIIfatG8Xp4tDv1t5zewq3FiZ0eePalFih1S5fPW2Ri08tmLPYqnKltQgFmJDO9ks/Vf0HuYgIYptjTfCI+FwU5ZzCb30oShmTOTiZUETGKW8RhOypMGcEffQb4WdFJch9UiyDvf95b+6ukD8KslLydl0MZirBojA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WSURiEWC; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f207b88c-da98-4fe2-b91f-ed07354ff019@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758903075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ksNWZUZ1JXt7mgfOOzB2IRthXQFU+7HlxAblhclQBI=;
	b=WSURiEWC4kJwYutU3Y/h/G5r+VAjMJin75vBxNwCEkg2fIMwQK0kxhCKd/tm9QCT9PO96u
	8wYnt6+X3O9Yxj5sJbylYHT3vMVZzNXNU639+YRpk6iNHJcN6nZoLdq9xDZAqPLjTpV0Wh
	Sy3kizkSIHLmwGoxANp7agAOtYePeUo=
Date: Fri, 26 Sep 2025 09:11:11 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: =?UTF-8?B?UmU6IMOlw6XCpDogUmU6IFtQQVRDSCB2MiByZG1hLXJjXSBSRE1BL2Ju?=
 =?UTF-8?Q?xt=5Fre=3A_Fix_a_potential_memory_leak_in_destroy=5Fgsi=5Fsqp?=
To: =?UTF-8?B?5Luj5b2m6b6Z?= <daiyanlong@kylinos.cn>,
 Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: jgg <jgg@ziepe.ca>, leon <leon@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 "selvin.xavier" <selvin.xavier@broadcom.com>, dyl_wlc <dyl_wlc@163.com>
References: <vuezvoi8y7j-vuko1z952k0@nsmail8.2--kylin--1>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <vuezvoi8y7j-vuko1z952k0@nsmail8.2--kylin--1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/25/25 7:39 PM, ä»£å½¦é¾ wrote:
> Hello Kalesh, Selvin, List,
> 
> Gentle ping on this patch.
> I just wanted to follow up and make sure the v2 version was received 
> correctly.
> 
> For easy reference, the patch is available on lore.kernel.org here:
> https://lore.kernel.org/all/20250924061444.11288-1-daiyanlong <https:// 
> lore.kernel.org/all/20250924061444.11288-1-daiyanlong>@kylinos.cn/
> 
> Please let me know if there's anything else needed from my side, or if 
> you've had a chance to review the technical changes.
> Thank you for your time and consideration.
> 
> Best regards,
> YanLong Dai
> 

Hi, YanLong

In regions where Chinese is not supported, the email may appear garbled. 
We recommend replacing any Chinese content in the email with the 
corresponding English to ensure clarity.

Thanks a lot.
Yanjun.Zhu

> 
> 
> 
> *主   题：*Re: [PATCH v2 rdma-rc] RDMA/bnxt_re: Fix a potential memory 
> leak in destroy_gsi_sqp
> *日   期：*2025年09月24日14:33
> *发件人：*代彦龙
> *收件人：*Kalesh Anakkur Purayil,代彦龙
> *抄送人：*jgg,leon,linux-kernel,linux-rdma,selvin.xavier,dyl_wlc
> 
> Hello Selvin, Kalesh, List,
> 
> Thank you so much for your patience and guidance throughout this 
> process. I truly appreciate you taking the time to review my patches and 
> provide detailed feedback - it has been a great learning experience.
> 
> I have incorporated all of your suggestions in this v2 version:
> - Added the "rdma-rc" target tree prefix in the subject line
> - Used proper version numbering (v2)
> - Included the changelog below the '---' line as recommended
> 
> The updated patch is attached. I believe it now follows all the required 
> guidelines. Please let me know if there are any further issues or 
> adjustments needed.
> 
> The patch is also available on lore.kernel.org here:
> https://lore.kernel.org/all/20250924061444.11288-1-daiyanlong <https:// 
> lore.kernel.org/all/20250924061444.11288-1-daiyanlong>@kylinos.cn/
> 
> Best regards,
> YanLong Dai
> 
> ---
> 
> 
> 
> 
> *主   题：*Re: [PATCH] RDMA/bnxt_re: Fix a potential memory leak in 
> destroy_gsi_sqp
> *日   期：*2025年09月24日13:01
> *发件人：*Kalesh Anakkur Purayil
> *收件人：*Kalesh Anakkur Purayil
> *抄送人：*jgg,leon,linux-kernel,linux-rdma,selvin.xavier,dyl_wlc
> 
> Hi YanLong,
> Few generic guidelines.
> 1. You should select a target tree in the subject prefix and specify a 
> revision number. Since this is a bug fix, the target tree should be 
> "rdma-rc".
> 2. When you send an updated version of the patch, please mention version 
> number. Also, mention the changes made in each version. i.e. under --- 
> you can add extra info that will not be included in the actual commit, 
> e.g. changes between each version of patches.
> One comment in line.
> 
> On Mon, Sep 22, 2025 at 7:53 AM YanLong Dai <daiyanlong@kylinos.cn 
> <mailto:daiyanlong@kylinos.cn>> wrote:
> 
>     From: daiyanlong <daiyanlong@kylinos.cn <mailto:daiyanlong@kylinos.cn>>
> 
>     The current error handling path in bnxt_re_destroy_gsi_sqp() could lead
>     to a resource leak. When bnxt_qplib_destroy_qp() fails, the function
>     jumps to the 'fail' label and returns immediately, skipping the call
>     to bnxt_qplib_free_qp_res().
> 
>     Continue the resource teardown even if bnxt_qplib_destroy_qp() fails,
>     which aligns with the driver's general error handling strategy and
>     prevents the potential leak.
> 
>     Fixes: 8dae419f9ec73 ("RDMA/bnxt_re: Refactor queue pair creation code")
>     [Kalesh] Blank line is not needed between Fixes tag and SOB tag
>     Signed-off-by: daiyanlong <daiyanlong@kylinos.cn
>     <mailto:daiyanlong@kylinos.cn>>
>     ---
>       drivers/infiniband/hw/bnxt_re/ib_verbs.c | 7 ++-----
>       1 file changed, 2 insertions(+), 5 deletions(-)
> 
>     diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/
>     infiniband/hw/bnxt_re/ib_verbs.c
>     index 260dc67b8b87..15d3f5d5c0ee 100644
>     --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
>     +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
>     @@ -931,10 +931,9 @@ static int bnxt_re_destroy_gsi_sqp(struct
>     bnxt_re_qp *qp)
> 
>              ibdev_dbg(&rdev->ibdev, "Destroy the shadow QP\n");
>              rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &gsi_sqp-
>      >qplib_qp);
>     -       if (rc) {
>     +       if (rc)
>                      ibdev_err(&rdev->ibdev, "Destroy Shadow QP failed");
>     -               goto fail;
>     -       }
>     +
>              bnxt_qplib_free_qp_res(&rdev->qplib_res, &gsi_sqp->qplib_qp);
> 
>              /* remove from active qp list */
>     @@ -951,8 +950,6 @@ static int bnxt_re_destroy_gsi_sqp(struct
>     bnxt_re_qp *qp)
>              rdev->gsi_ctx.sqp_tbl = NULL;
> 
>              return 0;
>     -fail:
>     -       return rc;
>       }
> 
>       /* Queue Pairs */
>     -- 
>     2.43.0
> 
> 
> -- 
> Regards,
> Kalesh AP
> 
> 
> ---
> 
> 
> ---
> 


