Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72F71FAD0E
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 11:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgFPJth (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 05:49:37 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:25499 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgFPJth (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jun 2020 05:49:37 -0400
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 05G9n5l8023783;
        Tue, 16 Jun 2020 02:49:06 -0700
Date:   Tue, 16 Jun 2020 15:19:05 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>
Subject: Re: iSERT completions hung due to unavailable iscsit tag
Message-ID: <20200616094904.GA21817@chelsio.com>
References: <20200601134637.GA17657@chelsio.com>
 <d316fdb7-4676-0bb9-c208-b06e43d46534@grimberg.me>
 <20200604151341.GA20246@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604151341.GA20246@chelsio.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Hi Sagi/Max Gurtovoy,

Please suggest what else to look into for debugging this issue further.

Sagi, by any chance were you able to repoduce this on your VM(with SIW)
by reducing "tag_num" in iscsit?

I think, this issue will hit with any provider driver if we somehow let
the recv_done() handler reach the below "schedule()", while performing
IO.

------
static int iscsit_wait_for_tag(struct se_session *se_sess, int state,
int *cpup)
{
	int tag = -1;
	DEFINE_SBQ_WAIT(wait);
	struct sbq_wait_state *ws;
	struct sbitmap_queue *sbq;

	if (state == TASK_RUNNING)
		return tag;

	sbq = &se_sess->sess_tag_pool;
	ws = &sbq->ws[0];
	for (;;) {
		sbitmap_prepare_to_wait(sbq, ws, &wait, state);
		if (signal_pending_state(state, current))
			break;
		tag = sbitmap_queue_get(sbq, cpup);
		if (tag >= 0)
			break;
			
			
			
		schedule();		<======
		
		
		
	}

	sbitmap_finish_wait(sbq, ws, &wait);
	return tag;
}

Thanks,
Krishna.

