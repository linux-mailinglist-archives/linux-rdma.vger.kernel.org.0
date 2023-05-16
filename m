Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0812670567B
	for <lists+linux-rdma@lfdr.de>; Tue, 16 May 2023 21:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjEPTA6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 May 2023 15:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjEPTA4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 May 2023 15:00:56 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D664CC
        for <linux-rdma@vger.kernel.org>; Tue, 16 May 2023 12:00:54 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6ab611e57c2so11944a34.1
        for <linux-rdma@vger.kernel.org>; Tue, 16 May 2023 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684263653; x=1686855653;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nWJhVl3khauE3bf6zGChEFUrOGa4qM3eEgNvfwLbha0=;
        b=Al6blhQcnpO3cMWVgi7fyj4aBskGXIBqjbocYdifVo4vMJHtq7g1NPYWwB/qjN2Vaf
         SOJ/FtLjW2V61fSMtutQ0ppk9bdxc0V+xi3AHxsMraiYKSlPMbs82QQFhYhzpR2EGt5n
         6EYpohhg053F+lGehBblCq4ePE69/WqsV9hSNz4E2WUUyTJFNIQGRrF7xrGgo9KidUpx
         zeepe/hQBd1EE8AMYvS6VIH/Vunm3co2xa7ztYTQzWNzyjMJKnMx8DrUAmGqOJBOQHkd
         9y7OdvnXzEqpk2INtogFFjLOAHkGw4wJsxkCwYgIWiFIyX4miDdVlDvArsPCgyrZJTF7
         +HUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684263653; x=1686855653;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWJhVl3khauE3bf6zGChEFUrOGa4qM3eEgNvfwLbha0=;
        b=KzyOsi8zHvgZYQK9G67WCGz8wW1H5Dd+62YGqTRvVmTFxEaAx/te6kNlBEKqvuAff2
         2YJs+tAFh3q+ZwcBGNSQbmq7mx41pEgbpmKmyL6ZLcLEN4/U+d020mNi4K5z3mqw+GNG
         hN+B7px6wH/LP+ftPpw1SrKkJ23Hn7gfg/oK0JwUooYm8s5Rnag0yaR/IQaUdbRxfN/9
         VHrMwh6sKaYcKfRQlEh+1m8gVpqe3aLmQFn69eINBOoMU51xqWhZQoLFw22Wv+QO/87b
         XYynXlPaSa9WN8VRpNKPhnHj4nM5kPG7eByt9gUzjk2UeE4G7vSYY67rCRmjWDjtG/5r
         gH5g==
X-Gm-Message-State: AC+VfDy4Htb+UmpryahUzE2nCslJcNlwLB5al48ddhc93SnJ0Utdw8Iz
        QsDBUzQiwAYhBP1x1O/eeBc=
X-Google-Smtp-Source: ACHHUZ4dPWDCp931yIlKBm/7hfpKid2aHgto69VOHc9DCUkt0ux0eNrwTga96T56y9z612rqy9BZ4w==
X-Received: by 2002:a05:6830:135a:b0:6aa:d278:24e1 with SMTP id r26-20020a056830135a00b006aad27824e1mr13589364otq.6.1684263653132;
        Tue, 16 May 2023 12:00:53 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:6756:74e8:3efd:d9c5? (2603-8081-140c-1a00-6756-74e8-3efd-d9c5.res6.spectrum.com. [2603:8081:140c:1a00:6756:74e8:3efd:d9c5])
        by smtp.gmail.com with ESMTPSA id r11-20020a4ad4cb000000b0054f6b747841sm9428119oos.7.2023.05.16.12.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 12:00:52 -0700 (PDT)
Message-ID: <d5e18fac-0e5e-41a7-ee1c-74aa7d6705e9@gmail.com>
Date:   Tue, 16 May 2023 14:00:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] RDMA/rxe: Convert spin_{lock_bh,unlock_bh} to
 spin_{lock_irqsave,unlock_irqrestore}
Content-Language: en-US
To:     Guoqing Jiang <guoqing.jiang@linux.dev>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
References: <20230510035056.881196-1-guoqing.jiang@linux.dev>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20230510035056.881196-1-guoqing.jiang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/9/23 22:50, Guoqing Jiang wrote:
> We need to call spin_lock_irqsave/spin_unlock_irqrestore for state_lock
> in rxe, otherwsie the callchain
> 
> ib_post_send_mad
> 	-> spin_lock_irqsave
> 	-> ib_post_send -> rxe_post_send
> 				-> spin_lock_bh
> 				-> spin_unlock_bh
> 	-> spin_unlock_irqrestore
> 
> caused below traces during run block nvmeof-mp/001 test.
> 
> [11634.410320] ------------[ cut here ]------------
> [11634.410325] WARNING: CPU: 0 PID: 94794 at kernel/softirq.c:376 __local_bh_enable_ip+0xc2/0x140
> [ ... ]
> [11634.410405] CPU: 0 PID: 94794 Comm: kworker/u4:1 Tainted: G            E      6.4.0-rc1 #9
> [11634.410407] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
> [11634.410409] Workqueue: rdma_cm cma_work_handler [rdma_cm]
> [11634.410418] RIP: 0010:__local_bh_enable_ip+0xc2/0x140
> [11634.410420] Code: 48 85 c0 74 72 5b 41 5c 5d 31 c0 89 c2 89 c1 89 c6 89 c7 41 89 c0 e9 bd 0e 11 01 65 8b 05 f2 65 72 48 85 c0 0f 85 76 ff ff ff <0f> 0b e9 6f ff ff ff e8 d2 39 1c 00 eb 80 4c 89 e7 e8 68 ad 0a 00
> [11634.410421] RSP: 0018:ffffb7cf818539f0 EFLAGS: 00010046
> [11634.410423] RAX: 0000000000000000 RBX: 0000000000000201 RCX: 0000000000000000
> [11634.410425] RDX: 0000000000000000 RSI: 0000000000000201 RDI: ffffffffc0f25f79
> [11634.410426] RBP: ffffb7cf81853a00 R08: 0000000000000000 R09: 0000000000000000
> [11634.410427] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffc0f25f79
> [11634.410428] R13: ffff8db1f0fa6000 R14: ffff8db2c63ff000 R15: 00000000000000e8
> [11634.410431] FS:  0000000000000000(0000) GS:ffff8db33bc00000(0000) knlGS:0000000000000000
> [11634.410432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [11634.410434] CR2: 0000559758db0f20 CR3: 0000000105124000 CR4: 00000000003506f0
> [11634.410436] Call Trace:
> [11634.410437]  <TASK>
> [11634.410439]  _raw_spin_unlock_bh+0x31/0x40
> [11634.410444]  rxe_post_send+0x59/0x8b0 [rdma_rxe]
> [11634.410453]  ib_send_mad+0x26b/0x470 [ib_core]
> [11634.410473]  ib_post_send_mad+0x150/0xb40 [ib_core]
> [11634.410487]  ? cm_form_tid+0x5b/0x90 [ib_cm]
> [11634.410498]  ib_send_cm_req+0x7c8/0xb70 [ib_cm]
> [11634.410510]  rdma_connect_locked+0x433/0x940 [rdma_cm]
> [11634.410521]  nvme_rdma_cm_handler+0x5d7/0x9c0 [nvme_rdma]
> [11634.410529]  cma_cm_event_handler+0x4f/0x170 [rdma_cm]
> [11634.410535]  cma_work_handler+0x6a/0xe0 [rdma_cm]
> [11634.410541]  process_one_work+0x2a9/0x580
> [11634.410549]  worker_thread+0x52/0x3f0
> [11634.410552]  ? __pfx_worker_thread+0x10/0x10
> [11634.410554]  kthread+0x109/0x140
> [11634.410556]  ? __pfx_kthread+0x10/0x10
> [11634.410559]  ret_from_fork+0x2c/0x50
> [11634.410566]  </TASK>
> [11634.410567] irq event stamp: 1024229
> [11634.410568] hardirqs last  enabled at (1024227): [<ffffffffb8a092c2>] _raw_read_unlock_irqrestore+0x72/0xa0
> [11634.410571] hardirqs last disabled at (1024228): [<ffffffffb8a085ca>] _raw_spin_lock_irqsave+0x7a/0x80
> [11634.410573] softirqs last  enabled at (1023578): [<ffffffffb78f9b38>] __irq_exit_rcu+0xe8/0x160
> [11634.410574] softirqs last disabled at (1024229): [<ffffffffc0f25f53>] rxe_post_send+0x33/0x8b0 [rdma_rxe]
> [11634.410580] ---[ end trace 0000000000000000 ]---
> [11634.410956] ------------[ cut here ]------------
> [11634.410961] raw_local_irq_restore() called with IRQs enabled
> [11634.410966] WARNING: CPU: 0 PID: 94794 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x37/0x60
> [ ... ]
> [11634.411058] CPU: 0 PID: 94794 Comm: kworker/u4:1 Tainted: G        W   E      6.4.0-rc1 #9
> [11634.411060] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
> [11634.411061] Workqueue: rdma_cm cma_work_handler [rdma_cm]
> [11634.411068] RIP: 0010:warn_bogus_irq_restore+0x37/0x60
> [11634.411070] Code: fb 01 77 36 83 e3 01 74 0e 48 8b 5d f8 c9 31 f6 89 f7 e9 ac ea 01 00 48 c7 c7 e0 52 33 b9 c6 05 bb 1c 69 01 01 e8 39 24 f0 fe <0f> 0b 48 8b 5d f8 c9 31 f6 89 f7 e9 89 ea 01 00 0f b6 f3 48 c7 c7
> [11634.411072] RSP: 0018:ffffb7cf81853a58 EFLAGS: 00010246
> [11634.411074] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [11634.411075] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [11634.411076] RBP: ffffb7cf81853a60 R08: 0000000000000000 R09: 0000000000000000
> [11634.411077] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8db2cfb1a9e8
> [11634.411079] R13: ffff8db2cfb1a9d8 R14: ffff8db2c63ff000 R15: 0000000000000000
> [11634.411081] FS:  0000000000000000(0000) GS:ffff8db33bc00000(0000) knlGS:0000000000000000
> [11634.411083] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [11634.411084] CR2: 0000559758db0f20 CR3: 0000000105124000 CR4: 00000000003506f0
> [11634.411086] Call Trace:
> [11634.411087]  <TASK>
> [11634.411089]  _raw_spin_unlock_irqrestore+0x91/0xa0
> [11634.411093]  ib_send_mad+0x1e3/0x470 [ib_core]
> [11634.411109]  ib_post_send_mad+0x150/0xb40 [ib_core]
> [11634.411121]  ? cm_form_tid+0x5b/0x90 [ib_cm]
> [11634.411131]  ib_send_cm_req+0x7c8/0xb70 [ib_cm]
> [11634.411143]  rdma_connect_locked+0x433/0x940 [rdma_cm]
> [11634.411154]  nvme_rdma_cm_handler+0x5d7/0x9c0 [nvme_rdma]
> [11634.411162]  cma_cm_event_handler+0x4f/0x170 [rdma_cm]
> [11634.411168]  cma_work_handler+0x6a/0xe0 [rdma_cm]
> [11634.411174]  process_one_work+0x2a9/0x580
> [11634.411180]  worker_thread+0x52/0x3f0
> [11634.411184]  ? __pfx_worker_thread+0x10/0x10
> [11634.411186]  kthread+0x109/0x140
> [11634.411188]  ? __pfx_kthread+0x10/0x10
> [11634.411191]  ret_from_fork+0x2c/0x50
> [11634.411198]  </TASK>
> [11634.411199] irq event stamp: 1025173
> [11634.411200] hardirqs last  enabled at (1025179): [<ffffffffb79b6140>] __up_console_sem+0x90/0xa0
> [11634.411204] hardirqs last disabled at (1025184): [<ffffffffb79b6125>] __up_console_sem+0x75/0xa0
> [11634.411206] softirqs last  enabled at (1024326): [<ffffffffb78f9d95>] do_softirq.part.0+0xe5/0x130
> [11634.411208] softirqs last disabled at (1024239): [<ffffffffb78f9d95>] do_softirq.part.0+0xe5/0x130
> [11634.411209] ---[ end trace 0000000000000000 ]---
> 
> Fixes: f605f26ea196 ("RDMA/rxe: Protect QP state with qp->state_lock")
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_comp.c  | 26 +++++++++++--------
>  drivers/infiniband/sw/rxe/rxe_net.c   |  7 +++---
>  drivers/infiniband/sw/rxe/rxe_qp.c    | 36 +++++++++++++++++----------
>  drivers/infiniband/sw/rxe/rxe_recv.c  |  9 ++++---
>  drivers/infiniband/sw/rxe/rxe_req.c   | 30 ++++++++++++----------
>  drivers/infiniband/sw/rxe/rxe_resp.c  | 14 ++++++-----
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 25 ++++++++++---------
>  7 files changed, 86 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
> index db18ace74d2b..f46c5a5fd0ae 100644
> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
> @@ -115,15 +115,16 @@ static enum ib_wc_opcode wr_to_wc_opcode(enum ib_wr_opcode opcode)
>  void retransmit_timer(struct timer_list *t)
>  {
>  	struct rxe_qp *qp = from_timer(qp, t, retrans_timer);
> +	unsigned long flags;
>  
>  	rxe_dbg_qp(qp, "retransmit timer fired\n");
>  
> -	spin_lock_bh(&qp->state_lock);
> +	spin_lock_irqsave(&qp->state_lock, flags);
>  	if (qp->valid) {
>  		qp->comp.timeout = 1;
>  		rxe_sched_task(&qp->comp.task);
>  	}
> -	spin_unlock_bh(&qp->state_lock);
> +	spin_unlock_irqrestore(&qp->state_lock, flags);
>  }
>  
>  void rxe_comp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
> @@ -481,11 +482,13 @@ static void do_complete(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
>  
>  static void comp_check_sq_drain_done(struct rxe_qp *qp)
>  {
> -	spin_lock_bh(&qp->state_lock);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&qp->state_lock, flags);
>  	if (unlikely(qp_state(qp) == IB_QPS_SQD)) {
>  		if (qp->attr.sq_draining && qp->comp.psn == qp->req.psn) {
>  			qp->attr.sq_draining = 0;
> -			spin_unlock_bh(&qp->state_lock);
> +			spin_unlock_irqrestore(&qp->state_lock, flags);
>  
>  			if (qp->ibqp.event_handler) {
>  				struct ib_event ev;
> @@ -499,7 +502,7 @@ static void comp_check_sq_drain_done(struct rxe_qp *qp)
>  			return;
>  		}
>  	}
> -	spin_unlock_bh(&qp->state_lock);
> +	spin_unlock_irqrestore(&qp->state_lock, flags);
>  }
>  
>  static inline enum comp_state complete_ack(struct rxe_qp *qp,
> @@ -625,13 +628,15 @@ static void free_pkt(struct rxe_pkt_info *pkt)
>   */
>  static void reset_retry_timer(struct rxe_qp *qp)
>  {
> +	unsigned long flags;
> +
>  	if (qp_type(qp) == IB_QPT_RC && qp->qp_timeout_jiffies) {
> -		spin_lock_bh(&qp->state_lock);
> +		spin_lock_irqsave(&qp->state_lock, flags);
>  		if (qp_state(qp) >= IB_QPS_RTS &&
>  		    psn_compare(qp->req.psn, qp->comp.psn) > 0)
>  			mod_timer(&qp->retrans_timer,
>  				  jiffies + qp->qp_timeout_jiffies);
> -		spin_unlock_bh(&qp->state_lock);
> +		spin_unlock_irqrestore(&qp->state_lock, flags);
>  	}
>  }
>  
> @@ -643,18 +648,19 @@ int rxe_completer(struct rxe_qp *qp)
>  	struct rxe_pkt_info *pkt = NULL;
>  	enum comp_state state;
>  	int ret;
> +	unsigned long flags;
>  
> -	spin_lock_bh(&qp->state_lock);
> +	spin_lock_irqsave(&qp->state_lock, flags);
>  	if (!qp->valid || qp_state(qp) == IB_QPS_ERR ||
>  			  qp_state(qp) == IB_QPS_RESET) {
>  		bool notify = qp->valid && (qp_state(qp) == IB_QPS_ERR);
>  
>  		drain_resp_pkts(qp);
>  		flush_send_queue(qp, notify);
> -		spin_unlock_bh(&qp->state_lock);
> +		spin_unlock_irqrestore(&qp->state_lock, flags);
>  		goto exit;
>  	}
> -	spin_unlock_bh(&qp->state_lock);
> +	spin_unlock_irqrestore(&qp->state_lock, flags);
>  
>  	if (qp->comp.timeout) {
>  		qp->comp.timeout_retry = 1;
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 2bc7361152ea..a38fab19bed1 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -412,15 +412,16 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
>  	int err;
>  	int is_request = pkt->mask & RXE_REQ_MASK;
>  	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
> +	unsigned long flags;
>  
> -	spin_lock_bh(&qp->state_lock);
> +	spin_lock_irqsave(&qp->state_lock, flags);
>  	if ((is_request && (qp_state(qp) < IB_QPS_RTS)) ||
>  	    (!is_request && (qp_state(qp) < IB_QPS_RTR))) {
> -		spin_unlock_bh(&qp->state_lock);
> +		spin_unlock_irqrestore(&qp->state_lock, flags);
>  		rxe_dbg_qp(qp, "Packet dropped. QP is not in ready state\n");
>  		goto drop;
>  	}
> -	spin_unlock_bh(&qp->state_lock);
> +	spin_unlock_irqrestore(&qp->state_lock, flags);
>  
>  	rxe_icrc_generate(skb, pkt);
>  
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index c5451a4488ca..1b9d8e89d915 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -300,6 +300,7 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
>  	struct rxe_cq *rcq = to_rcq(init->recv_cq);
>  	struct rxe_cq *scq = to_rcq(init->send_cq);
>  	struct rxe_srq *srq = init->srq ? to_rsrq(init->srq) : NULL;
> +	unsigned long flags;
>  
>  	rxe_get(pd);
>  	rxe_get(rcq);
> @@ -325,10 +326,10 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
>  	if (err)
>  		goto err2;
>  
> -	spin_lock_bh(&qp->state_lock);
> +	spin_lock_irqsave(&qp->state_lock, flags);
>  	qp->attr.qp_state = IB_QPS_RESET;
>  	qp->valid = 1;
> -	spin_unlock_bh(&qp->state_lock);
> +	spin_unlock_irqrestore(&qp->state_lock, flags);
>  
>  	return 0;
>  
> @@ -492,24 +493,28 @@ static void rxe_qp_reset(struct rxe_qp *qp)
>  /* move the qp to the error state */
>  void rxe_qp_error(struct rxe_qp *qp)
>  {
> -	spin_lock_bh(&qp->state_lock);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&qp->state_lock, flags);
>  	qp->attr.qp_state = IB_QPS_ERR;
>  
>  	/* drain work and packet queues */
>  	rxe_sched_task(&qp->resp.task);
>  	rxe_sched_task(&qp->comp.task);
>  	rxe_sched_task(&qp->req.task);
> -	spin_unlock_bh(&qp->state_lock);
> +	spin_unlock_irqrestore(&qp->state_lock, flags);
>  }
>  
>  static void rxe_qp_sqd(struct rxe_qp *qp, struct ib_qp_attr *attr,
>  		       int mask)
>  {
> -	spin_lock_bh(&qp->state_lock);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&qp->state_lock, flags);
>  	qp->attr.sq_draining = 1;
>  	rxe_sched_task(&qp->comp.task);
>  	rxe_sched_task(&qp->req.task);
> -	spin_unlock_bh(&qp->state_lock);
> +	spin_unlock_irqrestore(&qp->state_lock, flags);
>  }
>  
>  /* caller should hold qp->state_lock */
> @@ -555,14 +560,16 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
>  		qp->attr.cur_qp_state = attr->qp_state;
>  
>  	if (mask & IB_QP_STATE) {
> -		spin_lock_bh(&qp->state_lock);
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&qp->state_lock, flags);
>  		err = __qp_chk_state(qp, attr, mask);
>  		if (!err) {
>  			qp->attr.qp_state = attr->qp_state;
>  			rxe_dbg_qp(qp, "state -> %s\n",
>  					qps2str[attr->qp_state]);
>  		}
> -		spin_unlock_bh(&qp->state_lock);
> +		spin_unlock_irqrestore(&qp->state_lock, flags);
>  
>  		if (err)
>  			return err;
> @@ -688,6 +695,8 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
>  /* called by the query qp verb */
>  int rxe_qp_to_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask)
>  {
> +	unsigned long flags;
> +
>  	*attr = qp->attr;
>  
>  	attr->rq_psn				= qp->resp.psn;
> @@ -708,12 +717,12 @@ int rxe_qp_to_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask)
>  	/* Applications that get this state typically spin on it.
>  	 * Yield the processor
>  	 */
> -	spin_lock_bh(&qp->state_lock);
> +	spin_lock_irqsave(&qp->state_lock, flags);
>  	if (qp->attr.sq_draining) {
> -		spin_unlock_bh(&qp->state_lock);
> +		spin_unlock_irqrestore(&qp->state_lock, flags);
>  		cond_resched();
>  	}
> -	spin_unlock_bh(&qp->state_lock);
> +	spin_unlock_irqrestore(&qp->state_lock, flags);
>  
>  	return 0;
>  }
> @@ -736,10 +745,11 @@ int rxe_qp_chk_destroy(struct rxe_qp *qp)
>  static void rxe_qp_do_cleanup(struct work_struct *work)
>  {
>  	struct rxe_qp *qp = container_of(work, typeof(*qp), cleanup_work.work);
> +	unsigned long flags;
>  
> -	spin_lock_bh(&qp->state_lock);
> +	spin_lock_irqsave(&qp->state_lock, flags);
>  	qp->valid = 0;
> -	spin_unlock_bh(&qp->state_lock);
> +	spin_unlock_irqrestore(&qp->state_lock, flags);
>  	qp->qp_timeout_jiffies = 0;
>  
>  	if (qp_type(qp) == IB_QPT_RC) {
> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
> index 2f953cc74256..5861e4244049 100644
> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> @@ -14,6 +14,7 @@ static int check_type_state(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
>  			    struct rxe_qp *qp)
>  {
>  	unsigned int pkt_type;
> +	unsigned long flags;
>  
>  	if (unlikely(!qp->valid))
>  		return -EINVAL;
> @@ -38,19 +39,19 @@ static int check_type_state(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
>  		return -EINVAL;
>  	}
>  
> -	spin_lock_bh(&qp->state_lock);
> +	spin_lock_irqsave(&qp->state_lock, flags);
>  	if (pkt->mask & RXE_REQ_MASK) {
>  		if (unlikely(qp_state(qp) < IB_QPS_RTR)) {
> -			spin_unlock_bh(&qp->state_lock);
> +			spin_unlock_irqrestore(&qp->state_lock, flags);
>  			return -EINVAL;
>  		}
>  	} else {
>  		if (unlikely(qp_state(qp) < IB_QPS_RTS)) {
> -			spin_unlock_bh(&qp->state_lock);
> +			spin_unlock_irqrestore(&qp->state_lock, flags);
>  			return -EINVAL;
>  		}
>  	}
> -	spin_unlock_bh(&qp->state_lock);
> +	spin_unlock_irqrestore(&qp->state_lock, flags);
>  
>  	return 0;
>  }
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index 65134a9aefe7..5fe7cbae3031 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -99,17 +99,18 @@ static void req_retry(struct rxe_qp *qp)
>  void rnr_nak_timer(struct timer_list *t)
>  {
>  	struct rxe_qp *qp = from_timer(qp, t, rnr_nak_timer);
> +	unsigned long flags;
>  
>  	rxe_dbg_qp(qp, "nak timer fired\n");
>  
> -	spin_lock_bh(&qp->state_lock);
> +	spin_lock_irqsave(&qp->state_lock, flags);
>  	if (qp->valid) {
>  		/* request a send queue retry */
>  		qp->req.need_retry = 1;
>  		qp->req.wait_for_rnr_timer = 0;
>  		rxe_sched_task(&qp->req.task);
>  	}
> -	spin_unlock_bh(&qp->state_lock);
> +	spin_unlock_irqrestore(&qp->state_lock, flags);
>  }
>  
>  static void req_check_sq_drain_done(struct rxe_qp *qp)
> @@ -118,8 +119,9 @@ static void req_check_sq_drain_done(struct rxe_qp *qp)
>  	unsigned int index;
>  	unsigned int cons;
>  	struct rxe_send_wqe *wqe;
> +	unsigned long flags;
>  
> -	spin_lock_bh(&qp->state_lock);
> +	spin_lock_irqsave(&qp->state_lock, flags);
>  	if (qp_state(qp) == IB_QPS_SQD) {
>  		q = qp->sq.queue;
>  		index = qp->req.wqe_index;
> @@ -140,7 +142,7 @@ static void req_check_sq_drain_done(struct rxe_qp *qp)
>  				break;
>  
>  			qp->attr.sq_draining = 0;
> -			spin_unlock_bh(&qp->state_lock);
> +			spin_unlock_irqrestore(&qp->state_lock, flags);
>  
>  			if (qp->ibqp.event_handler) {
>  				struct ib_event ev;
> @@ -154,7 +156,7 @@ static void req_check_sq_drain_done(struct rxe_qp *qp)
>  			return;
>  		} while (0);
>  	}
> -	spin_unlock_bh(&qp->state_lock);
> +	spin_unlock_irqrestore(&qp->state_lock, flags);
>  }
>  
>  static struct rxe_send_wqe *__req_next_wqe(struct rxe_qp *qp)
> @@ -173,6 +175,7 @@ static struct rxe_send_wqe *__req_next_wqe(struct rxe_qp *qp)
>  static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
>  {
>  	struct rxe_send_wqe *wqe;
> +	unsigned long flags;
>  
>  	req_check_sq_drain_done(qp);
>  
> @@ -180,13 +183,13 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
>  	if (wqe == NULL)
>  		return NULL;
>  
> -	spin_lock_bh(&qp->state_lock);
> +	spin_lock_irqsave(&qp->state_lock, flags);
>  	if (unlikely((qp_state(qp) == IB_QPS_SQD) &&
>  		     (wqe->state != wqe_state_processing))) {
> -		spin_unlock_bh(&qp->state_lock);
> +		spin_unlock_irqrestore(&qp->state_lock, flags);
>  		return NULL;
>  	}
> -	spin_unlock_bh(&qp->state_lock);
> +	spin_unlock_irqrestore(&qp->state_lock, flags);
>  
>  	wqe->mask = wr_opcode_mask(wqe->wr.opcode, qp);
>  	return wqe;
> @@ -676,16 +679,17 @@ int rxe_requester(struct rxe_qp *qp)
>  	struct rxe_queue *q = qp->sq.queue;
>  	struct rxe_ah *ah;
>  	struct rxe_av *av;
> +	unsigned long flags;
>  
> -	spin_lock_bh(&qp->state_lock);
> +	spin_lock_irqsave(&qp->state_lock, flags);
>  	if (unlikely(!qp->valid)) {
> -		spin_unlock_bh(&qp->state_lock);
> +		spin_unlock_irqrestore(&qp->state_lock, flags);
>  		goto exit;
>  	}
>  
>  	if (unlikely(qp_state(qp) == IB_QPS_ERR)) {
>  		wqe = __req_next_wqe(qp);
> -		spin_unlock_bh(&qp->state_lock);
> +		spin_unlock_irqrestore(&qp->state_lock, flags);
>  		if (wqe)
>  			goto err;
>  		else
> @@ -700,10 +704,10 @@ int rxe_requester(struct rxe_qp *qp)
>  		qp->req.wait_psn = 0;
>  		qp->req.need_retry = 0;
>  		qp->req.wait_for_rnr_timer = 0;
> -		spin_unlock_bh(&qp->state_lock);
> +		spin_unlock_irqrestore(&qp->state_lock, flags);
>  		goto exit;
>  	}
> -	spin_unlock_bh(&qp->state_lock);
> +	spin_unlock_irqrestore(&qp->state_lock, flags);
>  
>  	/* we come here if the retransmit timer has fired
>  	 * or if the rnr timer has fired. If the retransmit
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 68f6cd188d8e..1da044f6b7d4 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -1047,6 +1047,7 @@ static enum resp_states do_complete(struct rxe_qp *qp,
>  	struct ib_uverbs_wc *uwc = &cqe.uibwc;
>  	struct rxe_recv_wqe *wqe = qp->resp.wqe;
>  	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
> +	unsigned long flags;
>  
>  	if (!wqe)
>  		goto finish;
> @@ -1137,12 +1138,12 @@ static enum resp_states do_complete(struct rxe_qp *qp,
>  		return RESPST_ERR_CQ_OVERFLOW;
>  
>  finish:
> -	spin_lock_bh(&qp->state_lock);
> +	spin_lock_irqsave(&qp->state_lock, flags);
>  	if (unlikely(qp_state(qp) == IB_QPS_ERR)) {
> -		spin_unlock_bh(&qp->state_lock);
> +		spin_unlock_irqrestore(&qp->state_lock, flags);
>  		return RESPST_CHK_RESOURCE;
>  	}
> -	spin_unlock_bh(&qp->state_lock);
> +	spin_unlock_irqrestore(&qp->state_lock, flags);
>  
>  	if (unlikely(!pkt))
>  		return RESPST_DONE;
> @@ -1468,18 +1469,19 @@ int rxe_responder(struct rxe_qp *qp)
>  	enum resp_states state;
>  	struct rxe_pkt_info *pkt = NULL;
>  	int ret;
> +	unsigned long flags;
>  
> -	spin_lock_bh(&qp->state_lock);
> +	spin_lock_irqsave(&qp->state_lock, flags);
>  	if (!qp->valid || qp_state(qp) == IB_QPS_ERR ||
>  			  qp_state(qp) == IB_QPS_RESET) {
>  		bool notify = qp->valid && (qp_state(qp) == IB_QPS_ERR);
>  
>  		drain_req_pkts(qp);
>  		flush_recv_queue(qp, notify);
> -		spin_unlock_bh(&qp->state_lock);
> +		spin_unlock_irqrestore(&qp->state_lock, flags);
>  		goto exit;
>  	}
> -	spin_unlock_bh(&qp->state_lock);
> +	spin_unlock_irqrestore(&qp->state_lock, flags);
>  
>  	qp->resp.aeth_syndrome = AETH_ACK_UNLIMITED;
>  
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index dea605b7f683..4d8f6b8051ff 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -904,10 +904,10 @@ static int rxe_post_send_kernel(struct rxe_qp *qp,
>  	if (!err)
>  		rxe_sched_task(&qp->req.task);
>  
> -	spin_lock_bh(&qp->state_lock);
> +	spin_lock_irqsave(&qp->state_lock, flags);
>  	if (qp_state(qp) == IB_QPS_ERR)
>  		rxe_sched_task(&qp->comp.task);
> -	spin_unlock_bh(&qp->state_lock);
> +	spin_unlock_irqrestore(&qp->state_lock, flags);
>  
>  	return err;
>  }
> @@ -917,22 +917,23 @@ static int rxe_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
>  {
>  	struct rxe_qp *qp = to_rqp(ibqp);
>  	int err;
> +	unsigned long flags;
>  
> -	spin_lock_bh(&qp->state_lock);
> +	spin_lock_irqsave(&qp->state_lock, flags);
>  	/* caller has already called destroy_qp */
>  	if (WARN_ON_ONCE(!qp->valid)) {
> -		spin_unlock_bh(&qp->state_lock);
> +		spin_unlock_irqrestore(&qp->state_lock, flags);
>  		rxe_err_qp(qp, "qp has been destroyed");
>  		return -EINVAL;
>  	}
>  
>  	if (unlikely(qp_state(qp) < IB_QPS_RTS)) {
> -		spin_unlock_bh(&qp->state_lock);
> +		spin_unlock_irqrestore(&qp->state_lock, flags);
>  		*bad_wr = wr;
>  		rxe_err_qp(qp, "qp not ready to send");
>  		return -EINVAL;
>  	}
> -	spin_unlock_bh(&qp->state_lock);
> +	spin_unlock_irqrestore(&qp->state_lock, flags);
>  
>  	if (qp->is_user) {
>  		/* Utilize process context to do protocol processing */
> @@ -1008,22 +1009,22 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
>  	struct rxe_rq *rq = &qp->rq;
>  	unsigned long flags;
>  
> -	spin_lock_bh(&qp->state_lock);
> +	spin_lock_irqsave(&qp->state_lock, flags);
>  	/* caller has already called destroy_qp */
>  	if (WARN_ON_ONCE(!qp->valid)) {
> -		spin_unlock_bh(&qp->state_lock);
> +		spin_unlock_irqrestore(&qp->state_lock, flags);
>  		rxe_err_qp(qp, "qp has been destroyed");
>  		return -EINVAL;
>  	}
>  
>  	/* see C10-97.2.1 */
>  	if (unlikely((qp_state(qp) < IB_QPS_INIT))) {
> -		spin_unlock_bh(&qp->state_lock);
> +		spin_unlock_irqrestore(&qp->state_lock, flags);
>  		*bad_wr = wr;
>  		rxe_dbg_qp(qp, "qp not ready to post recv");
>  		return -EINVAL;
>  	}
> -	spin_unlock_bh(&qp->state_lock);
> +	spin_unlock_irqrestore(&qp->state_lock, flags);
>  
>  	if (unlikely(qp->srq)) {
>  		*bad_wr = wr;
> @@ -1044,10 +1045,10 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
>  
>  	spin_unlock_irqrestore(&rq->producer_lock, flags);
>  
> -	spin_lock_bh(&qp->state_lock);
> +	spin_lock_irqsave(&qp->state_lock, flags);
>  	if (qp_state(qp) == IB_QPS_ERR)
>  		rxe_sched_task(&qp->resp.task);
> -	spin_unlock_bh(&qp->state_lock);
> +	spin_unlock_irqrestore(&qp->state_lock, flags);
>  
>  	return err;
>  }

Looks good.

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
