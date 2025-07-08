Return-Path: <linux-rdma+bounces-11953-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF9AAFC261
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 08:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8A2C16D3AF
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 06:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E06821D3D4;
	Tue,  8 Jul 2025 06:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QDFYVXO+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866AA21CC4B
	for <linux-rdma@vger.kernel.org>; Tue,  8 Jul 2025 06:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751954604; cv=none; b=mCcfJEnJMezpWcGonrxjlrFOJrMZrosWtxxR+Wva59xgZIZfLKTP5hnFwEHe2aqO/5MhQ7WuluTzgo+H1hyH8ibQqWMd8sqpOPnSzG5V179+qGNITN8Em66iknMLlTzcXrksfmUZo6mMkSRp1JFwJwUCR+g8S1182sqKoQnlJ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751954604; c=relaxed/simple;
	bh=LfcZ+8wP1jokocS/fUy59tlx8ufLh4JrvQp9dkZuzRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WR7YuPjGjY/5g0z8sLkZQkOPYCM24jZkXa5rpOYlhAZNt/SZ1BFhiJ2rDhR4qyD4hjcWx2m67tGcF4j0iLSEWNs31b6z49wbYlxo5RwJO0V6dm2UWX/EbeXAxlfB9Q3mdsipYzskPeB7Av3f06zx/plZUw+twcvNJMKJr/2Wd40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QDFYVXO+; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <079b29ad-593f-4fc4-b693-db3eeec9fc23@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751954598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AalPXakRJCDeZglx2S2FcHzypZrzadr6daMZYcP7tmY=;
	b=QDFYVXO+bdUzEBYHUmCde//IKqtryoUBO82CguAauHCvgTbKjLiT3tbuhEMD+HB0V8lYdn
	NCzMY/7bayWIDRkCOg4P6M9JH27ikSMUPIn1AeYyQEo6hnSfgrIYcVQlMHf2mvGL0qzBqn
	da4tDLZdZau+Ui5D5xP+WAsBLVVLnOE=
Date: Tue, 8 Jul 2025 09:03:12 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 7/8] IB: Extend UVERBS_METHOD_REG_MR to get DMAH
To: Junxian Huang <huangjunxian6@hisilicon.com>,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Bernard Metzler <bmt@zurich.ibm.com>,
 Bryan Tan <bryan-bt.tan@broadcom.com>,
 Chengchang Tang <tangchengchang@huawei.com>,
 Cheng Xu <chengyou@linux.alibaba.com>, Christian Benvenuti
 <benve@cisco.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Edward Srouji <edwards@nvidia.com>, Kai Shen <kaishen@linux.alibaba.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Konstantin Taranov <kotaranov@microsoft.com>, linux-rdma@vger.kernel.org,
 Long Li <longli@microsoft.com>, Michael Margolin <mrgolin@amazon.com>,
 Michal Kalderon <mkalderon@marvell.com>,
 Mustafa Ismail <mustafa.ismail@intel.com>,
 Nelson Escobar <neescoba@cisco.com>, Potnuri Bharat Teja
 <bharat@chelsio.com>, Selvin Xavier <selvin.xavier@broadcom.com>,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
 Vishnu Dasa <vishnu.dasa@broadcom.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
References: <cover.1751907231.git.leon@kernel.org>
 <dede37bca92e66fcb2744ea68b629649d1b57517.1751907231.git.leon@kernel.org>
 <4e151293-76f5-b44d-5045-d699e16a316d@hisilicon.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
In-Reply-To: <4e151293-76f5-b44d-5045-d699e16a316d@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/07/2025 5:27, Junxian Huang wrote:
> Could you change hns part as below? We have an error counter in the err_out label.

Same for EFA.

> 
> Thanks
> Junxian
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
> index ebef93559225..e6ad6de97f10 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
> @@ -237,6 +237,11 @@ struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
>         struct hns_roce_mr *mr;
>         int ret;
> 
> +       if (dmah) {
> +               ret = -EOPNOTSUPP;
> +               goto err_out;
> +       }
> +
>         mr = kzalloc(sizeof(*mr), GFP_KERNEL);
>         if (!mr) {
>                 ret = -ENOMEM;
> 
>>  	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
>>  	if (!mr) {
>>  		ret = -ENOMEM;
> 

