Return-Path: <linux-rdma+bounces-703-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627868385A9
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jan 2024 03:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1C7296EE7
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jan 2024 02:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2399A1FB2;
	Tue, 23 Jan 2024 02:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cY+V7QWz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C075C2570
	for <linux-rdma@vger.kernel.org>; Tue, 23 Jan 2024 02:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705977816; cv=none; b=M1HWb6LKSgGdLl34taMWgP1vA+iHdTAKetN3dLFSvjEjsJJLch2xNLDgYzb7MEcA0rC2wxPanVaLtDGe5UL9J3z/Rf+SdJygZ1bXkuL+cRxWxEFj6i/t7m/lTXihjK8y9KLiWYAPPe/gmSvN9YpdPuxvmbceJFB9K2aKPnnKQ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705977816; c=relaxed/simple;
	bh=qHQMXCDMoeS1fcAzqFrjL4BWxCiMNnGWJAzuMIw00PY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zxarh4KYXosqGFDUV7FOXmRh7rcvG9Y5yFiYMxqKbmUr34yOnU8msMbX3VFLCXOWKDgrTKwsXoj5GZi2x743V9rn+o0w+NMcEzNwLKmhleDs5fMPUoToVUOm0sLQke4Vr52g4zs8SsbXiU6MpGVd6VLlWxo8NxolV2j2sZWoTs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cY+V7QWz; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <05415e8a-2878-04a7-efeb-4119b95b8fd2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705977813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dviFFm07x702BUQO/RociFDrj/VRTP1KJuHfu2UR0Tw=;
	b=cY+V7QWz81igNCwycJyTbsc2hw4uVBj6EnzEMX/HLmm9PD/RsnEGsfX4bakmjowHHVhNkp
	lJQ4NPse4lLjTZM5GcJ15o4wFQogd2KWZL49qLL2qmQoTadPiOcG0+WzJ/03CNH5nlwVB7
	rsm1mGKAhtKPFnNbI0OQwewknpPy/IM=
Date: Tue, 23 Jan 2024 10:43:26 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/siw: Trim size of page array to max size needed
To: Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca, leon@kernel.org, ionut_n2001@yahoo.com
References: <20240119130532.57146-1-bmt@zurich.ibm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <20240119130532.57146-1-bmt@zurich.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Bernard,

On 1/19/24 21:05, Bernard Metzler wrote:
> siw tries sending all parts of an iWarp wire frame in one socket
> send operation. If user data can be send without copy, user data
> pages for one wire frame are referenced in an fixed size page array.
> The size of this array can be made 2 elements smaller, since it
> does not reference iWarp header and trailer crc. Trimming
> the page array reduces the affected siw_tx_hdt() functions frame
> size, staying below 1024 bytes. This avoids the following
> compile-time warning:
>
>   drivers/infiniband/sw/siw/siw_qp_tx.c: In function 'siw_tx_hdt':
>   drivers/infiniband/sw/siw/siw_qp_tx.c:677:1: warning: the frame
>   size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]

I saw similar warning in my ubuntu 22.04 VM which has below gcc.

root@buk:/home/gjiang/linux-mirror# make M=drivers/infiniband/sw/siw/ 
-j16 W=1
   CC [M]  drivers/infiniband/sw/siw/siw_qp_tx.o
drivers/infiniband/sw/siw/siw_qp_tx.c: In function ‘siw_tx_hdt’:
drivers/infiniband/sw/siw/siw_qp_tx.c:665:1: warning: the frame size of 
1440 bytes is larger than 1024 bytes [-Wframe-larger-than=]
   665 | }
       | ^

# gcc --version
gcc (Ubuntu 12.3.0-1ubuntu1~22.04) 12.3.0

And it still appears after apply this patch on top of 6.8-rc1.

root@buk:/home/gjiang/linux-mirror# git am 
./20240119_bmt_rdma_siw_trim_size_of_page_array_to_max_size_needed.mbx
Applying: RDMA/siw: Trim size of page array to max size needed
root@buk:/home/gjiang/linux-mirror# make M=drivers/infiniband/sw/siw/ 
-j16 W=1
   CC [M]  drivers/infiniband/sw/siw/siw_qp_tx.o
drivers/infiniband/sw/siw/siw_qp_tx.c: In function ‘siw_tx_hdt’:
drivers/infiniband/sw/siw/siw_qp_tx.c:668:1: warning: the frame size of 
1408 bytes is larger than 1024 bytes [-Wframe-larger-than=]
   668 | }
       | ^

However with gcc-13.1, I can't see the warning with or without the patch.

Thanks,
Guoqing

