Return-Path: <linux-rdma+bounces-670-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4303B835A78
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 06:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759B51C222A0
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 05:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39533EADB;
	Mon, 22 Jan 2024 05:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EkYZB46N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A501CA7F;
	Mon, 22 Jan 2024 05:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705902524; cv=none; b=Pwh42xzdwoGxRrTc4SabPZ/8ez0Bf9EJ7Aj1fhI6bvxS3KIOvHt1w0SZhU4++RcMhIrCDor0NrY+CBdRsGwSm8sxI6g9PNRsdkIoTI/tv9cReWbetAAYJYDLkmZwJ2iDv3dS0LOFxHqCfmTnsY1GFNZzuxQHWYpwAts0+e9kZ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705902524; c=relaxed/simple;
	bh=fvcqDANsNrlVg8LHXfdCILc7Q6Zm8CII+gZE4TRCJ1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVjc8J4kP3kmyorFCezFKLrOYXzOcr+3ai/+fGpCG0xaFtLDQjKV7A8MZTlxk76rf/v60oiXtbAAJAq6oqiYPMzdmSWAzxKU5awQfvZxgxtHgwPXZ6N/A7Ys04q5I7JC0a7dGtRk6ITN/PrMWUh5FHlqES8BmYfRC0gAYcVR7hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EkYZB46N; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=qTB9lkUu0aOVisiKuKEe2EDq/PJZ2wo5dJ7HSEFZVXM=; b=EkYZB46N02S1j23tS+kXa0o+qz
	SOGen273Lr1irYsN5If2peuKaIKjSk7cDNkpmSKJ+38isemVUJ0/RMOZ5B1cbVi8G4YC+702/krmb
	k2Q31MTvaLRkSWpdj4s4oWdx/adOATimCIFljjsQrGo+0lCK4v0v51EsnAfvnzSoDU7fhTc2kdJpf
	fu+/WqZUtkhcYsm08rzmXNJmqYVvn4iiZgVFpOpWubVTPKoFqro90KJcp+hAJUAsCgorC+aanX5zj
	U+EuxaNA8592b3Mxa3IPcLCT1+d0yvNNoOD5srt2UM2Bx3uqDA1QYY/0st99QQpH/woUekI/Ha5bg
	MH9PQOyw==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rRnAk-00Adcx-1H;
	Mon, 22 Jan 2024 05:48:38 +0000
Message-ID: <c4cd5048-1838-4464-ba79-26cc595e380f@infradead.org>
Date: Sun, 21 Jan 2024 21:48:36 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux Kernel Bug] UBSAN: array-index-out-of-bounds in
 rds_cmsg_recv
Content-Language: en-US
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Chenyuan Yang <chenyuan0y@gmail.com>,
 santosh.shilimkar@oracle.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, "syzkaller@googlegroups.com"
 <syzkaller@googlegroups.com>, Zijie Zhao <zzjas98@gmail.com>
References: <CALGdzuoVdq-wtQ4Az9iottBqC5cv9ZhcE5q8N7LfYFvkRsOVcw@mail.gmail.com>
 <27319d3d-61dd-41e3-be6c-ccc08b9b3688@linux.dev>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <27319d3d-61dd-41e3-be6c-ccc08b9b3688@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,


On 1/21/24 00:34, Zhu Yanjun wrote:
> 在 2024/1/19 22:29, Chenyuan Yang 写道:
>> Dear Linux Kernel Developers for Network RDS,
>>
>> We encountered "UBSAN: array-index-out-of-bounds in rds_cmsg_recv"
>> when testing the RDS with our generated specifications. The C
>> reproduce program and logs for this crash are attached.
>>
>> This crash happens when RDS receives messages by using
>> `rds_cmsg_recv`, which reads the `j+1` index of the array
>> `inc->i_rx_lat_trace`
>> (https://elixir.bootlin.com/linux/v6.7/source/net/rds/recv.c#L585).
>> The length of `inc->i_rx_lat_trace` array is 4 (defined by
>> `RDS_RX_MAX_TRACES`,
>> https://elixir.bootlin.com/linux/v6.7/source/net/rds/rds.h#L289) while
>> `j` is the value stored in another array `rs->rs_rx_trace`
>> (https://elixir.bootlin.com/linux/v6.7/source/net/rds/recv.c#L583),
>> which is sent from others and could be arbitrary value.
> 
> I recommend to use the latest rds to make tests. The rds in linux kernel upstream is too old. The rds in oracle linux is newer.

Why is the upstream kernel lagging behind?  Is the RDS maintainer going
to submit patches to update mainline?

Thanks.

> Zhu Yanjun
> 
>>
>> This crash might be exploited to read the value out-of-bound from the
>> array by setting arbitrary values for the array `rs->rs_rx_trace`.
>>
>> If you have any questions or require more information, please feel
>> free to contact us.
>>
>> Best,
>> Chenyuan
> 
> 

-- 
#Randy

