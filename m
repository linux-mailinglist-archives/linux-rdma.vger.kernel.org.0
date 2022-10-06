Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B09D5F621E
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Oct 2022 09:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiJFHxy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Oct 2022 03:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiJFHxu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Oct 2022 03:53:50 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9648FD6C
        for <linux-rdma@vger.kernel.org>; Thu,  6 Oct 2022 00:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1665042828; i=@fujitsu.com;
        bh=tmaACe9IDa3Sf0hWzUtINR6+PjU7AO0J1ctWtDWtc64=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=SUaATdL3O4qr4FHOJOsnbxuIZL0YsFhI4TKflHCvzV9QkptXYOlElGQrCGOBkBSjz
         dC4GysQN4gD0HdZjxjHZ3j4bIjOpBJ6wApC8scgU2DVLVybZN0KsJwudAtXyTr2RL0
         5VxD2Mown82B7SL6md3/Aeo/4KLQYWdAUQbHCdt3CDmCUxcjGd4m/HDUOiBZ11XZoV
         9kvX5yZwoRhrNUj3dwr2mpO9ZUccnKmlOEbZOmiMo4+kqVEBlhvPu7Nsi+zvrWgEqs
         n46TzhHN574QTeXXNYfta9Wc/9BKyfc6jMnswm4gJZY7ZKAT0vB0FTmCzSXtSP4mKT
         NwO6j9/YN0nnA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleJIrShJLcpLzFFi42Kxs+HYrNvdaZd
  ssH2RusWVf3sYLab8Wsps8exQL4vFl6nTmC3OH+tnd2D12DnrLrvHplWdbB69ze/YPD5vkgtg
  iWLNzEvKr0hgzTgzaQZzwWLBiiOHelgbGGfxdTFycggJbGSUWHTKpIuRC8hewiTxp/sdK0RiK
  6PElN05IDavgJ3E9S+b2UBsFgEVideLmtkg4oISJ2c+YQGxRQWSJK5uuAvWKywQKHFt1gwwWw
  So/sSJM+wgC5gFvjFKTL8/nR1iWwujxO81DWCT2AQcJebN2ghmcwpoSfzaupAJxGYWsJBY/OY
  gO4QtL7H97RxmEFtCQFGibck/dgi7QmLWrDYmCFtN4uq5TcwTGIVmITlwFpJRs5CMWsDIvIrR
  OqkoMz2jJDcxM0fX0MBA19DQVNfYVNfQwkQvsUo3US+1VLc8tbhE10gvsbxYL7W4WK+4Mjc5J
  0UvL7VkEyMwelKKlXfsYGxb9VPvEKMkB5OSKO+ZPLtkIb6k/JTKjMTijPii0pzU4kOMMhwcSh
  K8ja1AOcGi1PTUirTMHGAkw6QlOHiURHhXg7TyFhck5hZnpkOkTjEqSonzPmkHSgiAJDJK8+D
  aYMnjEqOslDAvIwMDgxBPQWpRbmYJqvwrRnEORiVh3laQKTyZeSVw018BLWYCWtzxxgpkcUki
  Qkqqgany7OlS+eT+xMkvf895umr6R869P/NdWKxlFnE9DX2zwWjdBIXf5mWh1/VFd8ocjj7G0
  yxorjtDZMUHDTF+tfOTkqKXr3U8rfrwpLpv5oKNbIv2bHLy3nhGobRT5tzK11qbzDMFcxRS6s
  V3CJiJ+D1mOhdz7YhLzfQzncZ8nJZLn8y7v5snzqDJRurmqQdFDfHBZ72W5kgePZhmoRj66F7
  6vZ8hrKf3lCgscZ/Sfj+hQ+tRsuHKxouLArTaru9xTJ7N7PN54R6dZ4n5gtcq9gsvWfS6b57N
  pKcXpz16638/N13J2vGv4sG/T/kef71y7coMQ98JJX1P/v58wXlcNGL9m+0FaXvTP6z5rrQk1
  XCSEktxRqKhFnNRcSIAZ5VwtJkDAAA=
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-12.tower-571.messagelabs.com!1665042827!119669!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5299 invoked from network); 6 Oct 2022 07:53:47 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-12.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 6 Oct 2022 07:53:47 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 5294D155;
        Thu,  6 Oct 2022 08:53:47 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 44B85154;
        Thu,  6 Oct 2022 08:53:47 +0100 (BST)
Received: from [10.167.215.54] (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 6 Oct 2022 08:53:44 +0100
Message-ID: <6a04efb6-84e5-c7b7-25f1-843fa8122875@fujitsu.com>
Date:   Thu, 6 Oct 2022 15:53:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH v5 1/2] RDMA/rxe: Support RDMA Atomic Write
 operation
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
References: <20220708040228.6703-1-yangx.jy@fujitsu.com>
 <20220708040228.6703-2-yangx.jy@fujitsu.com> <Yy4xrlC2lt156nsV@nvidia.com>
From:   =?UTF-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
In-Reply-To: <Yy4xrlC2lt156nsV@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/9/24 6:22, Jason Gunthorpe wrote:
> On Fri, Jul 08, 2022 at 04:02:36AM +0000, yangx.jy@fujitsu.com wrote:
>> +static enum resp_states atomic_write_reply(struct rxe_qp *qp,
>> +					   struct rxe_pkt_info *pkt)
>> +{
>> +	u64 src, *dst;
>> +	struct resp_res *res = qp->resp.res;
>> +	struct rxe_mr *mr = qp->resp.mr;
>> +	int payload = payload_size(pkt);
>> +
>> +	if (!res) {
>> +		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_WRITE_MASK);
>> +		qp->resp.res = res;
>> +	}
>> +
>> +	if (!res->replay) {
>> +#ifdef CONFIG_64BIT
>> +		memcpy(&src, payload_addr(pkt), payload);
>> +
>> +		dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
>> +		/* check vaddr is 8 bytes aligned. */
>> +		if (!dst || (uintptr_t)dst & 7)
>> +			return RESPST_ERR_MISALIGNED_ATOMIC;
>> +
>> +		/* Do atomic write after all prior operations have completed */
>> +		smp_store_release(dst, src);
> 
> Someone needs to fix iova_to_vaddr to do the missing kmap, we can't
> just assume you can cast a u64 pfn to a vaddr like this.

Hi Jason,

Sorry, it is still not clear to me after looking into the related code 
again.

IMO, SoftRoCE depends on INFINIBAND_VIRT_DMA Kconfig which only allows 
!HIGHMEM so that SoftRoCE can call page_address() to gain a kernel 
virtual address for a page allocated on low memory zone. If a page is 
allocated on high memory zone, we need to gain a kernel virtual address 
by kmap()/kmap_atomic(). Did I miss something? I wonder why it is 
necessary to call kmap()?

Reference:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b1e678bf290db5a76f1b6a9f7c381310e03440d6

Best Regards,
Xiao Yang

> 
>> +		/* decrease resp.resid to zero */
>> +		qp->resp.resid -= sizeof(payload);
>> +
>> +		qp->resp.msn++;
>> +
>> +		/* next expected psn, read handles this separately */
>> +		qp->resp.psn = (pkt->psn + 1) & BTH_PSN_MASK;
>> +		qp->resp.ack_psn = qp->resp.psn;
>> +
>> +		qp->resp.opcode = pkt->opcode;
>> +		qp->resp.status = IB_WC_SUCCESS;
>> +
>> +		return RESPST_ACKNOWLEDGE;
>> +#else
>> +		pr_err("32-bit arch doesn't support 8-byte atomic write\n");
>> +		return RESPST_ERR_UNSUPPORTED_OPCODE;
> 
> No print on receiving a remote packet
> 
> Jason
