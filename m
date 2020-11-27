Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE14F2C679F
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Nov 2020 15:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbgK0OOf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Nov 2020 09:14:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34718 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbgK0OOf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Nov 2020 09:14:35 -0500
Date:   Fri, 27 Nov 2020 15:14:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606486473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5zXHvW8CMzTmWdmXJQC95Cd9yQiJWSLyUc2t4HJNzaM=;
        b=qeU1eHcihZRNJGqBH5LRESjxTczwDqPPKe47MxxSHg0gF7vgbeeeYobFdp/opNFoUm7fu+
        OUvhMaA5wxEw+42j2ZKQHQXulgtcmEyD3BaQqSII7CpfIZRyHaTAwjD2Xee32Ge18V4gqU
        bDOo65Ii56snzF8ZIqMOsqWzpHaW+ET9X1wV7GW55Uiib9+0S3doUtysYv2AGaZ9TFoQy4
        B5cXoHTVpS1tK0RcsIDr4/h4ou8D58Y//GSJpBNT4WXCOYZJD+k71uYB4Bcuj1WpXskfcf
        mtH3CFw/K1DsNdWeEiBJZWnafkjCXQb3T00+py8BnEtVUvayBRpvtU6v4DVoTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606486473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5zXHvW8CMzTmWdmXJQC95Cd9yQiJWSLyUc2t4HJNzaM=;
        b=Sz5+tagY5ci2wfIa28xXQ/v+XQEL8VTj7lbGkAhCD9d6R4q5oLNAKbdic8GVrsmawz9f4+
        NhUTYzXsv9j+SXCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@nvidia.com>,
        linux-rdma@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH] IB/iser: Remove in_interrupt() usage.
Message-ID: <20201127141432.z5hqxosugi6uu6i7@linutronix.de>
References: <20201126202720.2304559-1-bigeasy@linutronix.de>
 <20201126205357.GU5487@ziepe.ca>
 <20201127123455.scnqc7xvuwwofdp2@linutronix.de>
 <20201127130314.GE552508@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201127130314.GE552508@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-11-27 09:03:14 [-0400], Jason Gunthorpe wrote:
> I was able to get the internal bug report that caused the
> 7414dde0a6c3a commit.
> 
> The issue here is that the state_mutex is protecting 
> 
> This:
> 
> 	if (unlikely(iser_conn->state != ISER_CONN_UP)) {
> 
> Which indicates that this:
> 
>         dma_addr = ib_dma_map_single(device->ib_device, (void *)tx_desc,
> 
> Won't crash because iser_con->ib_con is invalid. The notes say that
> the iSCSI stack is in some state where data traffic won't flow but
> management traffic is still possible. I suppose this is some fast path
> so it was "optimized" to eliminate the lock for data traffic.
> 
> A call chain of interest for the lock at least is:
> 
> Nov  3 12:24:37 rsws10 BUG: unable to handle kernel 
> Nov  3 12:24:37 NULL pointer dereference
> Nov  3 12:24:37 rsws10 Pid: 5245, comm: scsi_eh_5 Tainted: GF          O 3.8.13-16.2.1.el6uek.x86_64 #1 IBM System x3550 M3 -[7944KEG]-/90Y4784
> [..]
> Nov  3 12:24:37 rsws10  [<ffffffffa069d628>] iscsi_iser_task_init+0x28/0x70 [ib_iser]
> Nov  3 12:24:37 rsws10  [<ffffffffa0610029>] iscsi_prep_mgmt_task+0x129/0x150 [libiscsi]
> Nov  3 12:24:37 rsws10  [<ffffffffa061354c>] __iscsi_conn_send_pdu+0x23c/0x310 [libiscsi]
> Nov  3 12:24:37 rsws10  [<ffffffffa0614277>] iscsi_exec_task_mgmt_fn+0x37/0x290 [libiscsi]
> Nov  3 12:24:37 rsws10  [<ffffffffa061497b>] iscsi_eh_device_reset+0x1bb/0x2d0 [libiscsi]

preemptible until here and this function has:

|	mutex_lock(&session->eh_mutex);
|	spin_lock_bh(&session->frwd_lock);

I don't see the lock dropped between here and iscsi_iser_task_init().

> Nov  3 12:24:37 rsws10  [<ffffffff813c3119>] scsi_eh_bus_device_reset+0xb9/0x1e0

> Nov  3 12:24:37 rsws10  [<ffffffff810829a0>] ? kthread_freezable_should_stop+0x70/0x70
> 
> So, I think the usual 'pass in atomic context flag' is really needed
> here

Sure, I would do that but as noted above, it the `frwd_lock' is acquired
so you can't acquire the mutex here.

> Jason

Sebastian
