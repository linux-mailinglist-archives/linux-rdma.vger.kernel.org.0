Return-Path: <linux-rdma+bounces-6156-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3279DC096
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Nov 2024 09:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C4F4B22030
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Nov 2024 08:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8967D165F0C;
	Fri, 29 Nov 2024 08:37:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4B314B088;
	Fri, 29 Nov 2024 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732869434; cv=none; b=IVvz5pjX6K1pB3UEQodLN8+fUSYnTzj/RrHvKbPCFw8Zgda2q9kqVdy6Y4x2bR2/Y8+0TU0aQBbFFGCstxujSUQ1rVqOh7kE3Yk49n/EsQjrlD6Vvtot7+FY86wY68fXOUu3MfIwtIGhd/qUJ27Wh0eFugD2tRlJKb3QktwdqC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732869434; c=relaxed/simple;
	bh=9tMAvfJO5jKNtlFjYMD67jnJ5EHNyRI5/IF38xGyMGs=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aGbJmIYSPt19S7PIWpXGILPXdsGUKMbaxlCogtEooA/aYo9rszoVy2mgH96QepW2S7Aoim5rE1Womg/LmdMXVU2k0FIOf0wIhxYWMroGOOupSlzvLbYykrhQVB9yBBVwNw0YqckXhZgx0G66ITbww3stb21T6XlTPikm7OU8gMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y063n3Q6Sz4f3k5f;
	Fri, 29 Nov 2024 16:36:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 438771A0568;
	Fri, 29 Nov 2024 16:37:07 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4cxfUlnCQufDA--.43500S3;
	Fri, 29 Nov 2024 16:37:07 +0800 (CST)
Subject: Re: blktests failures with v6.12 kernel
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <6crydkodszx5vq4ieox3jjpwkxtu7mhbohypy24awlo5w7f4k6@to3dcng24rd4>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <aef69ffa-e556-7eeb-4344-351c66266ee4@huaweicloud.com>
Date: Fri, 29 Nov 2024 16:37:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6crydkodszx5vq4ieox3jjpwkxtu7mhbohypy24awlo5w7f4k6@to3dcng24rd4>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXc4cxfUlnCQufDA--.43500S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr1fGw1fuFyfCFy5Jr47urg_yoWDJrXEvw
	17CF93G3yxAry0vFn7KFn29rW7KFZ09w17try8Xrna9as5tFykJFsIvrZI9ryDCw1rZr9I
	v3y5WF48ua1a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHD
	UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/11/26 10:19, Shinichiro Kawasaki Ð´µÀ:
> #5: throtl/001 (CKI project, s390 arch)
> 
>    Recently, CKI project added a configuration to run the blktests thortl group,
>    and failures have been repeatedly observed for s390 architecture [7]. I
>    suspect the failure message below implies that system performance may affect
>    the test result. Further debug is needed.
> 
>    throtl/001 (basic functionality)                             [failed]
>        runtime    ...  6.309s
>        --- tests/throtl/001.out	2024-11-23 20:53:13.446546653 +0000
>        +++ /mnt/tests/s3.amazonaws.com/arr-cki-prod-lookaside/lookaside/kernel-tests-public/kernel-tests-production.zip/storage/blktests/throtl/blktests/results/nodev/throtl/001.out.bad	2024-11-23 20:53:21.332699696 +0000
>        @@ -1,6 +1,6 @@
>         Running throtl/001
>        +2
>         1
>        -1
>        -1
>        +2
>         1

Perhaps can we have a quick try, and check if issuing IO to a null_blk
in this platform, the latency can't be ignored in seconds.

Thanks,
Kuai


