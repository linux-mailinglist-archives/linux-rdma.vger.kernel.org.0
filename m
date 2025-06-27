Return-Path: <linux-rdma+bounces-11707-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F459AEACFE
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 04:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D194A6A18
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 02:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A3318BBB9;
	Fri, 27 Jun 2025 02:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MkewNYvj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74BE26281
	for <linux-rdma@vger.kernel.org>; Fri, 27 Jun 2025 02:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750992623; cv=none; b=MFfdO80VW6+wyPMckTBmgcr3/4r50ZAAsrYYEM7duBxhusHxKgE+hR04/c+l3sUrrZCoqhOJKyiMqRY333gqbkR+cqkYXOaLwVpnSR0Pn28Y2YMeNUOqjUI32hlNBNbFZntZlmQMSHIxWSUqMSKhtVC8DIjyetGNZ2es/dj7vhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750992623; c=relaxed/simple;
	bh=p1HW6zv8mlHJrlMRWQzDXxmWMCYCO0Q4SFXTfOBRo0k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=RXHK9AwSmHWdmkE0ZQtICuW0TodM0EcUl/KB/6Brw0pRFO15HqGM9V28t5JGpwoNbsSL0jOF+wLPB++2sFCtFqbBKxpuggP5alp/Dcr3nnT4KNp4REzivdNSoxXo4xjL/+TGfGWhnbdOTc8RTgWa9pBaW9AkwOIZrA4UYN2cbj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MkewNYvj; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <850c0f71-ae74-4a06-bf40-fc44c6ceede7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750992605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KX8z8Y7YX8y7KbEgdhFOB6RdeuuZTaBG2L/6FgdDGsc=;
	b=MkewNYvj+gjKySw0n6q59iY+d590vYvOLdKEUZ69gnJ7QHolf8+3aSTCBCmOVQFTj39Lda
	kwCPdPqA+DXFu6jhNXLAKQKdboNCbOCRNLiqS2Rp837OkgM/qzYaqS4o4GoWbjgDOFihlV
	k++czY+e4kUxTR1ILVQQ/jVzyoLHZrM=
Date: Thu, 26 Jun 2025 19:49:46 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] WARNING in rxe_skb_tx_dtor
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: syzbot <syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com>,
 jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 zyjzyj2000@gmail.com
References: <685dc8bd.a00a0220.2e5631.0382.GAE@google.com>
 <f59b4048-a4e3-4d7d-8aa9-5a3ad42db8b7@linux.dev>
In-Reply-To: <f59b4048-a4e3-4d7d-8aa9-5a3ad42db8b7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

#syz test: https://github.com/zhuyj/linux.git v6.16_fix_rxe_skb_tx_dtor

在 2025/6/26 15:38, Yanjun.Zhu 写道:
> #syz test: https://github.com/zhuyj/linux.git 
> linux-6.15-rc4-fix-rxe_skb_tx_dtor
>
> On 6/26/25 3:25 PM, syzbot wrote:
>> Hello,
>>
>> syzbot tried to test the proposed patch but the build/boot failed:
>>
>> failed to checkout kernel repo 
>> git@github.com:zhuyj/linux.git/linux-6.15-rc4-fix-rxe_skb_tx_dtor: 
>> failed to run ["git" "fetch" "--force" 
>> "9a778a5fe5e4b8c26d97f27ad3305a963b60aef0" 
>> "linux-6.15-rc4-fix-rxe_skb_tx_dtor"]: exit status 128
>> Host key verification failed.
>> fatal: Could not read from remote repository.
>>
>> Please make sure you have the correct access rights
>> and the repository exists.
>>
>>
>>
>> Tested on:
>>
>> commit:         [unknown
>> git tree:       git@github.com:zhuyj/linux.git 
>> linux-6.15-rc4-fix-rxe_skb_tx_dtor
>> kernel config: 
>> https://syzkaller.appspot.com/x/.config?x=79da270cec5ffd65
>> dashboard link: 
>> https://syzkaller.appspot.com/bug?extid=8425ccfb599521edb153
>> compiler:
>>
>> Note: no patches were applied.

-- 
Best Regards,
Yanjun.Zhu


