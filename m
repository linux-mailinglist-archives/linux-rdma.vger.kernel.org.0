Return-Path: <linux-rdma+bounces-6044-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29EB9D3F25
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2024 16:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 305FBB315FE
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2024 15:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3971C3302;
	Wed, 20 Nov 2024 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="R3zP1Au8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B162191;
	Wed, 20 Nov 2024 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732115123; cv=none; b=Q5gU2As7vurktd21ZHdCasdTsS9weB43Dn8xn0fSWCye88PILAQZYpRp2sAFkYqay20wZIwriXfzk9TDVOlzK+Iq8bdNmpz4jAsTUuDBBAI89I2HUa7+aDv0A5GRwePU+f/BBI+/7a7j3ARYur+HT2NJ+EkNepINZuoa0cluPHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732115123; c=relaxed/simple;
	bh=cJrE4ToYIP5CIareHQOhSJiVf7PCn0QVg3yRcgbv7S4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HKMDKE8NU4KbN6ZUrETe/P9T2NpGgYp3uR8xyZibJLHpqujeu2gFto99/XA4T+Sc+OoUzH6vjhzlEhnvn7Hy0efX+/CBYfbelliqHNIUYteSsXMJpf+6ABXDwlu1/9n6n2fcAyt7grn7Vu+dVwPfkYB2pSI3QyyPdvwYPfplZXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=R3zP1Au8; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=An+oO
	/WpoPVJKTAJOX8K0HE0T6gSg+KJ3jkNA6cU1ug=; b=R3zP1Au86glVFbMeSEVJt
	7CmIM4sJjjcgg5H39FFw00dKziAHxKQ6ArZDchk+uRjaNwbB2gWa0vHhWxkccaEJ
	4I/r3IUk7hGD3W28hbswSXgS61DhaNUgHRZK7KEbZTOKxMTJ1IGGlJPdYxEL8NS+
	rv5uAMSik/ByzxMEmOiqGc=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3fxSa+j1n+KAZCA--.15273S2;
	Wed, 20 Nov 2024 23:04:59 +0800 (CST)
From: tuqiang <tuqiang0606@163.com>
To: gregkh@linuxfoundation.org
Cc: dledford@redhat.com,
	jgg@ziepe.ca,
	jiang.kun2@zte.com.cn,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	stable@vger.kernel.org,
	tu.qiang35@zte.com.cn,
	xu.xin16@zte.com.cn
Subject: Re: [PATCH STABLE 5.10] RDMA/restrack: Release MR/QP restrack when delete
Date: Wed, 20 Nov 2024 15:04:58 +0000
Message-Id: <20241120150458.3372235-1-tuqiang0606@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2024111642-backside-reach-7ec3@gregkh>
References: <2024111642-backside-reach-7ec3@gregkh>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3fxSa+j1n+KAZCA--.15273S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw18XFy8ZryfGF4xGryDWrg_yoW5Jry3pr
	1DGrWfAw4UGryrAw4UJr15XF1Sy3yFya1UWrn293W5ZF1UKr1DJr1jkwn8Arn8GrWxAr47
	tr1vgrZxK345tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRrb15UUUUU=
X-CM-SenderInfo: 5wxtxtdqjqliqw6rljoofrz/xtbBaRidIGc96Rzk0gAAsV

>
>On Sat, Nov 16, 2024 at 05:57:48PM +0800, jiang.kun2@zte.com.cn wrote:
>> From: tuqiang <tu.qiang35@zte.com.cn>
>> 
>> The MR/QP restrack also needs to be released when delete it, otherwise it
>> cause memory leak as the task struct won't be released.
>> 
>> This problem has been fixed by the commit <dac153f2802d>
>> ("RDMA/restrack: Release MR restrack when delete"), but still exists in the
>> linux-5.10.y branch.
>
>Why don't we just take the correct fix?  Why is this needed instead?

1. Reply: Why don't we just take the correct fix?
=========================================
Due to inconsistent code context, it is not possible to directly cherry-pick the 
changes to the linux-5.10 branch.
The commit 514aee660df4 (RDMA: Globally allocate and release QP memory) resolved 
the resource release issue for QP, but the MR issue remains unresolved.


2. Reply: Why is this needed instead?
==================================
When a user applies for resources by executing MR/QP-related commands, they will
reference the task_struct object. However, when consuming the object, rdma_restrack_del 
does not have the corresponding release mechanism.

Stack:
0xffffffffb70df1d0 : get_task_struct+0x0/0x50 [kernel]
0xffffffffc5b3a42c : rdma_restrack_attach_task.isra.6+0x2c/0x50 [ib_core]
0xffffffffc748fd54 : ib_uverbs_reg_mr+0x194/0x260 [ib_uverbs]
0xffffffffc749a049 : ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0xb9/0x110 [ib_uverbs]
0xffffffffc7496a1f : ib_uverbs_run_method+0x6ff/0x7b0 [ib_uverbs]
0xffffffffc7496c65 : ib_uverbs_cmd_verbs+0x195/0x360 [ib_uverbs]
0xffffffffc7496ec3 : ib_uverbs_ioctl+0x93/0xe0 [ib_uverbs]
0xffffffffb736bbe9 : __x64_sys_ioctl+0x89/0xc0 [kernel]
0xffffffffb7a62a10 : do_syscall_64+0x30/0x40 [kernel]

0xffffffffb70df1d0 : get_task_struct+0x0/0x50 [kernel]
0xffffffffc5b3a42c : rdma_restrack_attach_task.isra.6+0x2c/0x50 [ib_core]
0xffffffffc749bfea : ib_uverbs_handler_UVERBS_METHOD_QP_CREATE+0xaba/0xb40 [ib_uverbs]
0xffffffffc7496a1f : ib_uverbs_run_method+0x6ff/0x7b0 [ib_uverbs]
0xffffffffc7496c65 : ib_uverbs_cmd_verbs+0x195/0x360 [ib_uverbs]
0xffffffffc7496ec3 : ib_uverbs_ioctl+0x93/0xe0 [ib_uverbs]
0xffffffffb736bbe9 : __x64_sys_ioctl+0x89/0xc0 [kernel]
0xffffffffb7a62a10 : do_syscall_64+0x30/0x40 [kernel]

>
>thanks,
>
>greg k-h


