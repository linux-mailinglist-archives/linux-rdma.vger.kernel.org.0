Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CA55A73B3
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 04:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiHaCAw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Aug 2022 22:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHaCAw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Aug 2022 22:00:52 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC314D817;
        Tue, 30 Aug 2022 19:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1661911248; i=@fujitsu.com;
        bh=Gl3aA44E2kcOR/hcpUwZc4GOVg1SY3WM0u9Pk2Dx4D0=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=zJjsqwSsleOMtQjoKpHs7xs+T2/c7Pm/Tdfx8JEeCxP5qDdn+yMjaJe4g3u1HE6bX
         KxdnP6mmn58YQFkbQdZWd3RD2kmuUlNvSs/LffBo23EEojlbgOa7DLN14i+3qp0YM4
         YVVpZPAn6ONy29eY9DBlk8Ja7NoexZ4JIxEPhfuhwD5U9ZoDULwLsiySQLQ0ZoWkCW
         mt6uADdLtyQXBb2AZhiYu1PAul70u6e4rPC7WdmtmTxbpGOQYgvsiVtmYyptVJF4c9
         FhUKulSpuEMBWB8HFRbGBD0wsawNGQ766vgCeT1GxhbQEj5fFGAAPTv4uxXyv6YpZt
         L4/aSYSkOsu/Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRWlGSWpSXmKPExsViZ8MxSffCAb5
  kgyVtXBbTPvxktrjybw+jxZRfS5ktLu+aw2bx7FAviwOrx+Ur3h6bVnWyefQ2v2Pz+LxJLoAl
  ijUzLym/IoE1Y8W9r+wF98Qr5v+ax9zA+FK4i5GLQ0hgC6PEyr2/GCGcFUwSt6e+Y4dwtjNKb
  Nqym7mLkZODV8BOonHpXjCbRUBV4vCEFywQcUGJkzOfgNmiAhESDx9NArOFBXwk7jx/xg5iMw
  uIS9x6Mp8JZKiIwDJGid1nrjFCJGolGk9/ACsSErCUWPz+OdgCNgENiXstN8FqOAWsJNafuME
  GUW8hsfjNQaih8hLNW2eD1UsIKEoc6fwLtJgDyK6UuPE4FSKsJnH13CbmCYzCs5CcOgvJSbOQ
  TJ2FZOoCRpZVjDZJRZnpGSW5iZk5uoYGBrqGhqZA2lDX2EAvsUo3US+1VDcvv6gkQ9dQL7G8W
  C+1uFivuDI3OSdFLy+1ZBMjMNpSilPldjAe2PdL7xCjJAeTkijvr5V8yUJ8SfkplRmJxRnxRa
  U5qcWHGGU4OJQkeC/vBcoJFqWmp1akZeYAIx8mLcHBoyTCG7gQKM1bXJCYW5yZDpE6xWjMseH
  Bgb3MHFNn/9vPLMSSl5+XKiXO+3U/UKkASGlGaR7cIFhCusQoKyXMy8jAwCDEU5BalJtZgir/
  ilGcg1FJmHfJHqApPJl5JXD7XgGdwgR0ysMl3CCnlCQipKQamLxe95eEcfdlmD7d5lCwtk06a
  GKFlYv4qUmzUu4ErphiXb3thcGl+p9p4acevEw6rfLorWZ8X115A7NLIfO2+8U1ujer2jiulS
  /Zvnnl4f7An9LJSw6YT/Hx3Sy9j3/Lp08T9x3d8SGC+d6J5Ib13rJlq3UzQ/X/Jz6+uVX30J3
  IMKX82ZdWx7Gf+v9X4duNeaHe0ssc1X0ez9n2XYPj5wHmE2uu3ZlqmTNl/qyeL+ts/ghwvZyQ
  XnNh6dKbgUd+li2uLmSTOSVvna47oWNf0e6SdVE/Lde/W+f6tGP7eu5XIl/rPledVvvxU+z/4
  Vupa1Uaw0qbXv2e8unV0jzOl03RaY5njU7F8mXfywzqmPdciaU4I9FQi7moOBEAlkwnWcMDAA
  A=
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-13.tower-728.messagelabs.com!1661911247!30716!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24841 invoked from network); 31 Aug 2022 02:00:48 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-13.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 31 Aug 2022 02:00:48 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 83DA71000DC;
        Wed, 31 Aug 2022 03:00:47 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 77AB9100078;
        Wed, 31 Aug 2022 03:00:47 +0100 (BST)
Received: from [10.167.226.45] (10.167.226.45) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 31 Aug 2022 03:00:43 +0100
Message-ID: <a66af10e-dea5-a9ec-5eeb-641b1d7ebeec@fujitsu.com>
Date:   Wed, 31 Aug 2022 09:59:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/srp: Set scmnd->result only when scmnd is not NULL
Content-Language: en-US
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220831014730.17566-1-yangx.jy@fujitsu.com>
From:   Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <20220831014730.17566-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 31/08/2022 09:47, yangx.jy@fujitsu.com wrote:
> This change fixes the following kernel NULL pointer dereference
> which is reproduced by blktests srp/007 occasionally.
>
> BUG: kernel NULL pointer dereference, address: 0000000000000170
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0002) - not-present page
> PGD 0 P4D 0
> Oops: 0002 [#1] PREEMPT SMP NOPTI
> CPU: 0 PID: 9 Comm: kworker/0:1H Kdump: loaded Not tainted 6.0.0-rc1+ #37
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-29-g6a62e0cb0dfe-prebuilt.qemu.org 04/01/2014
> Workqueue:  0x0 (kblockd)
> RIP: 0010:srp_recv_done+0x176/0x500 [ib_srp]
> Code: 00 4d 85 ff 0f 84 52 02 00 00 48 c7 82 80 02 00 00 00 00 00 00 4c 89 df 4c 89 14 24 e8 53 d3 4a f6 4c 8b 14 24 41 0f b6 42 13 <41> 89 87 70 01 00 00 41 0f b6 52 12 f6 c2 02 74 44 41 8b 42 1c b9
> RSP: 0018:ffffaef7c0003e28 EFLAGS: 00000282
> RAX: 0000000000000000 RBX: ffff9bc9486dea60 RCX: 0000000000000000
> RDX: 0000000000000102 RSI: ffffffffb76bbd0e RDI: 00000000ffffffff
> RBP: ffff9bc980099a00 R08: 0000000000000001 R09: 0000000000000001
> R10: ffff9bca53ef0000 R11: ffff9bc980099a10 R12: ffff9bc956e14000
> R13: ffff9bc9836b9cb0 R14: ffff9bc9557b4480 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff9bc97ec00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000170 CR3: 0000000007e04000 CR4: 00000000000006f0
> Call Trace:
>   <IRQ>
>   __ib_process_cq+0xb7/0x280 [ib_core]
>   ib_poll_handler+0x2b/0x130 [ib_core]
>   irq_poll_softirq+0x93/0x150
>   __do_softirq+0xee/0x4b8
>   irq_exit_rcu+0xf7/0x130
>   sysvec_apic_timer_interrupt+0x8e/0xc0
>   </IRQ>
>
> Fixes: aef9ec39c47f ("IB: Add SCSI RDMA Protocol (SRP) initiator")
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>   drivers/infiniband/ulp/srp/ib_srp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> index 7720ea270ed8..528cdd0daba4 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -1961,6 +1961,7 @@ static void srp_process_rsp(struct srp_rdma_ch *ch, struct srp_rsp *rsp)
>   		if (scmnd) {
>   			req = scsi_cmd_priv(scmnd);
>   			scmnd = srp_claim_req(ch, req, NULL, scmnd);
> +			scmnd->result = rsp->status;
>   		} else {
>   			shost_printk(KERN_ERR, target->scsi_host,
>   				     "Null scmnd for RSP w/tag %#016llx received on ch %td / QP %#x\n",
> @@ -1972,7 +1973,6 @@ static void srp_process_rsp(struct srp_rdma_ch *ch, struct srp_rsp *rsp)
>   
>   			return;
>   		}
> -		scmnd->result = rsp->status;

What i can see is that we have other places to de-reference scmnd and

scmnd = srp_claim_req(ch, req, NULL, scmnd) is possible to return a NULL to scmnd



Thanks
Zhijian

>   
>   		if (rsp->flags & SRP_RSP_FLAG_SNSVALID) {
>   			memcpy(scmnd->sense_buffer, rsp->data +
                                              ^^^^



