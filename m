Return-Path: <linux-rdma+bounces-9471-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BAFA8AF8E
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 07:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F20C3A60A9
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 05:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8379F22A4D1;
	Wed, 16 Apr 2025 05:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e3x7n6RH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B255282F5
	for <linux-rdma@vger.kernel.org>; Wed, 16 Apr 2025 05:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744780472; cv=none; b=WYR+2XdF6w8ezgyYDMxO1oyzHDvc9+nqxoi0sd9BSYVZn1yc/NOOCvxrT+KlN7YLBI4THg9zNp6kH1fObxrkeaUD2vMa//akbbz0ib3BBiCgrcCEw6X7iWbI36pxgnim5J+e/D6z4jYc3XA/ZY+LenxD/uNQYOxuyqlVlleTc10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744780472; c=relaxed/simple;
	bh=rxiZYnh05J0xzKOUQn5Rmv/60OZJ7+K/O9tzv5ipSsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OI4UrmaKCSwQbyfVCXduJwpz8WAzmrc6+5jFIqEMUL1xOejBiC1Ugu/Vq1VzrMkzB5n0xAz7ohfQAReu/Pz+DIj48JlLJYb3tejmeCaHt3FYHM8rGkv2yLfAluvr9UFmqsBnyrs3ORsTuJXvC3cU/TNYCEkMTROB1ynYt4Y55Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e3x7n6RH; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f5eaa6c4-3676-4da3-ae47-759b9a0f357d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744780461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3To97feyk05r1fbY4Pq9UyEeYoKzyV/5iJQLRIXjAk=;
	b=e3x7n6RH6PfR9cTODQPVEc/l6iELyWefsDOLUerJv9h+O3mmGvMZmM2wFH5UFO/Hsed243
	EbDGwtiSxA6m3FpUTFs4+0KHnqvadsl6bbhW1pYJ7YDwsqkCEG1ooMoUPeTJqusKRkfBSw
	cXvg4xO83DbuCGddmwQ7LTDBr+p6PLA=
Date: Wed, 16 Apr 2025 07:14:18 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bug report] blktests nvme/061 hang with rdma transport and siw
 driver
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Bernard Metzler <BMT@zurich.ibm.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Daniel Wagner <wagi@kernel.org>
References: <r5676e754sv35aq7cdsqrlnvyhiq5zktteaurl7vmfih35efko@z6lay7uypy3c>
 <BN8PR15MB2513CD2A5725F5A035AE905699B22@BN8PR15MB2513.namprd15.prod.outlook.com>
 <3cf845ac-fd87-4808-bb53-c4495b03e68e@linux.dev>
 <mrdhqtchtzw5f7ypno6d5g4fwh7heoyx5nyjvfak46cneprdrm@o4q2olnuq4gg>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <mrdhqtchtzw5f7ypno6d5g4fwh7heoyx5nyjvfak46cneprdrm@o4q2olnuq4gg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/4/16 4:50, Shinichiro Kawasaki 写道:
> On Apr 15, 2025 / 17:00, Zhu Yanjun wrote:
>> On 15.04.25 15:09, Bernard Metzler wrote:
>>
>>> [  106.826346] rdma_rxe: loaded
>>> [  106.832164] loop: module loaded
>>> [  107.066868] run blktests nvme/061 at 2025-04-15 15:03:04
>>> [  107.081270] infiniband eno1_rxe: set active
>>> [  107.081274] infiniband eno1_rxe: added eno1
>>> [  107.089683] infiniband enp4s0f4d1_rxe: set active
>>> [  107.089687] infiniband enp4s0f4d1_rxe: added enp4s0f4d1
>>> [  107.264770] loop0: detected capacity change from 0 to 2097152
>>> [  107.267376] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>>> [  107.271276] nvmet_rdma: enabling port 0 (10.0.0.2:4420)
>>> [  107.312957] BUG: kernel NULL pointer dereference, address: 0000000000000028
>>> [  107.312973] #PF: supervisor read access in kernel mode
>>> [  107.312979] #PF: error_code(0x0000) - not-present page
>>> [  107.312986] PGD 0 P4D 0
>>> [  107.312992] Oops: Oops: 0000 [#1] SMP PTI
>>> [  107.312999] CPU: 1 UID: 0 PID: 123 Comm: kworker/u32:4 Not tainted 6.15.0-rc2 #1 PREEMPT(undef)
>>> [  107.313008] Hardware name: LENOVO 10A6S05601/SHARKBAY, BIOS FBKTD8AUS 09/17/2019
>>> [  107.313016] Workqueue: rxe_wq do_work [rdma_rxe]
>>> [  107.313030] RIP: 0010:rxe_mr_copy+0x58/0x230 [rdma_rxe]
>>
>> Hi, Bernard
>>
>> An interesting test. Can you find the line number of
>> (rxe_mr_copy+0x58/0x230) with crash tool?
>>
>> Thus we can find what variable is becoming NULL pointer.
> 
> I observe the failure too, but I also observe the recent patch [1] avoids it.
> With the patch applied to the kernel v6.15-rc2, I no longer observe the failure
> repeating the test case 100 times using rxe driver.
> 
> [1] https://lore.kernel.org/linux-rdma/20250402032657.1762800-1-lizhijian@fujitsu.com/

Hi, Shinichiro

Your confirmation is important for us.
Thanks a lot. I am very glad that the above commit can fix the 
aforementioned problem.

Best Regards,
Zhu Yanjun



