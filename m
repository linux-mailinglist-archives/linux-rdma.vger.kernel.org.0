Return-Path: <linux-rdma+bounces-2287-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C508BC846
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 09:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94CC91F215B8
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 07:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B194713FD9B;
	Mon,  6 May 2024 07:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nZznPeyz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8348E7D3F6
	for <linux-rdma@vger.kernel.org>; Mon,  6 May 2024 07:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714980312; cv=none; b=KJuSd71datOuOIBiKhS1k/1f8Cy85ima4327GlcjclbcrtZuKvYbTFOMdGnsFNgqelMeGqUzoS1wxLU6PqoRYmQ+xC62xt0bIazdmUKjuzhkymeXgVbdkQoCPlnQNXKZFGvz2i/jcQblz0JDD5D32GpPfLf1w0AI03VBxCMHSMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714980312; c=relaxed/simple;
	bh=OVDIWxUDRvlUhkLXJmVPIg7Ss7MCI8rmRJKjNBcIAYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2k/PEmHNZF7+NE5h2oU0KI9cQb87Hk18efP+KOIP87NyXMF/UTHZLUTwhjQidmGz3ScP3RhyFP/9U8wxY+vs1D3pR0oMOPxQCNAV54tALuCm45uFWPBqVuVUmvAaw0NRq+bNoClZIQJACaYKhllRLiAtcKhju064MX4kJx5wPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nZznPeyz; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1615fe92-d4ff-4ef2-9bd0-199aa9e3a426@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714980307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNICsQwAZLEIq4FagMWJtT9l3ne94Q3HOggFLnvinbw=;
	b=nZznPeyzXvBnkwuymZAd7H5uP6FsRpvl2JfkIEHhVLGTRXN2z1loonY6p/619WY28zpwEl
	Bogs2+q+8zcc500vR6DNiQHdd+mPtphq8OjqAyhbN7IEoPG5hcFcOxw9uMk2A927K9UGj9
	Kf4xW9Sd1i3DF1NmDYSRbBRBNofkxMI=
Date: Mon, 6 May 2024 09:25:01 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC RESEND 16/16] nvme-pci: use blk_rq_dma_map() for NVMe SGL
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 Bart Van Assche <bvanassche@acm.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Amir Goldstein <amir73il@gmail.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 Dan Williams <dan.j.williams@intel.com>, "jack@suse.com" <jack@suse.com>
References: <cover.1709635535.git.leon@kernel.org>
 <016fc02cbfa9be3c156a6f74df38def1e09c08f1.1709635535.git.leon@kernel.org>
 <c9f9e29e-c2e1-4f99-b359-db0babd41dec@linux.dev>
 <20240505132314.GC68202@unreal>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240505132314.GC68202@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 05.05.24 15:23, Leon Romanovsky wrote:
> On Fri, May 03, 2024 at 04:41:21PM +0200, Zhu Yanjun wrote:
>> On 05.03.24 12:18, Leon Romanovsky wrote:
>>> From: Chaitanya Kulkarni <kch@nvidia.com>
> <...>
>
>>> This is an RFC to demonstrate the newly added DMA APIs can be used to
>>> map/unmap bvecs without the use of sg list, hence I've modified the pci
>>> code to only handle SGLs for now. Once we have some agreement on the
>>> structure of new DMA API I'll add support for PRPs along with all the
>>> optimization that I've removed from the code for this RFC for NVMe SGLs
>>> and PRPs.
>>>
> <...>
>
>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>> index e6267a6aa380..140939228409 100644
>>> --- a/drivers/nvme/host/pci.c
>>> +++ b/drivers/nvme/host/pci.c
>>> @@ -236,7 +236,9 @@ struct nvme_iod {
>>>    	unsigned int dma_len;	/* length of single DMA segment mapping */
>>>    	dma_addr_t first_dma;
>>>    	dma_addr_t meta_dma;
>>> -	struct sg_table sgt;
>>> +	struct dma_iova_attrs iova;
>>> +	dma_addr_t dma_link_address[128];
>> Why the length of this array is 128? Can we increase this length of the
>> array?
> It is combination of two things:
>   * Good enough value for this nvme RFC to pass simple test, which Chaitanya did.
>   * Output of various NVME_CTRL_* defines

Thanks a lot. I enlarged this number to 512. It seems that it can work. 
Hope this will increase the performance.

Best Regards,

Zhu Yanjun

>
> Thanks

-- 
Best Regards,
Yanjun.Zhu


