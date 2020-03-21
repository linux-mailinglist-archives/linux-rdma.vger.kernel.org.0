Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E52918DDD6
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Mar 2020 05:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbgCUECn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 21 Mar 2020 00:02:43 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:39001 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgCUECn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 21 Mar 2020 00:02:43 -0400
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 02L4290v019591;
        Fri, 20 Mar 2020 21:02:10 -0700
Date:   Sat, 21 Mar 2020 09:32:09 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: broken CRCs at NVMeF target with SIW & NVMe/TCP transports
Message-ID: <20200321040207.GA11659@chelsio.com>
References: <20200316162008.GA7001@chelsio.com>
 <20200317124533.GB12316@lst.de>
 <OFB2589549.AD31F8B8-ON0025852E.005A969A-0025852E.005A96A3@notes.na.collabserv.com>
 <70b13212-faa6-d634-8beb-55ba39891d7f@grimberg.me>
 <20200317191743.GA22065@chelsio.com>
 <38f79fb7-841a-9faa-e1f8-2de4b9f21118@grimberg.me>
 <20200317203152.GA14946@chelsio.com>
 <3f42f881-0309-b86a-4b70-af23c58960fc@grimberg.me>
 <20200320143544.GA5539@chelsio.com>
 <87bfe03d-baad-1166-14a1-6eba1739fde4@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bfe03d-baad-1166-14a1-6eba1739fde4@grimberg.me>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Friday, March 03/20/20, 2020 at 13:49:25 -0700, Sagi Grimberg wrote:
> 
> >>I assume this happens with iSCSI as well? There is nothing special
> >>we are doing with respect to digest.
> >
> >I don't see this issue with iscsi-tcp.
> >
> >May be blk-mq is causing this issue? I assume iscsi-tcp does not have
> >blk_mq support yet upstream to verify with blk_mq enabled.
> >I tried on Ubuntu 19.10(which is based on Linux kernel 5.3), note that
> >RHEL does not support DataDigest.
> >
> >The reason that I'm seeing this issue only with NVMe(tcp/softiwarp) &
> >iSER(softiwarp) is becuase of NVMeF&ISER using blk-mq?
> >
> >Anyhow, I see the content of the page is being updated by upper layers
> >while the tranport driver is computing CRC on that page content and
> >this needs a fix.
> 
> Krishna, do you happen to run with nvme multipath enabled?

Yes Sagi, issue occurs with nvme multipath enabled also..

dmesg at initiator:
[ +10.671996] EXT4-fs (nvme0n1): mounting ext3 file system using the
ext4 subsystem
[  +0.004643] EXT4-fs (nvme0n1): mounted filesystem with ordered data
mode. Opts: (null)
[ +15.955424] block nvme0n1: no usable path - requeuing I/O
[  +0.000142] block nvme0n1: no usable path - requeuing I/O
[  +0.000135] block nvme0n1: no usable path - requeuing I/O
[  +0.000119] block nvme0n1: no usable path - requeuing I/O
[  +0.000108] block nvme0n1: no usable path - requeuing I/O
[  +0.000111] block nvme0n1: no usable path - requeuing I/O
[  +0.000118] block nvme0n1: no usable path - requeuing I/O
[  +0.000158] block nvme0n1: no usable path - requeuing I/O
[  +0.000130] block nvme0n1: no usable path - requeuing I/O
[  +0.000138] block nvme0n1: no usable path - requeuing I/O
[  +0.011754] nvme nvme0: Reconnecting in 10 seconds...
[ +10.261223] nvme_ns_head_make_request: 5 callbacks suppressed
[  +0.000002] block nvme0n1: no usable path - requeuing I/O
[  +0.000240] block nvme0n1: no usable path - requeuing I/O
[  +0.000107] block nvme0n1: no usable path - requeuing I/O
[  +0.000107] block nvme0n1: no usable path - requeuing I/O
[  +0.000107] block nvme0n1: no usable path - requeuing I/O
[  +0.000108] block nvme0n1: no usable path - requeuing I/O
[  +0.000132] block nvme0n1: no usable path - requeuing I/O
[  +0.000010] nvme nvme0: creating 12 I/O queues.
[  +0.000110] block nvme0n1: no usable path - requeuing I/O
[  +0.000232] block nvme0n1: no usable path - requeuing I/O
[  +0.000122] block nvme0n1: no usable path - requeuing I/O
[  +0.008407] nvme nvme0: Successfully reconnected (1 attempt)

dmesg at target:
[Mar21 09:24] nvmet_tcp: queue 3: cmd 38 pdu (6) data digest error: recv
0x21e59730 expected 0x2b88fed0
[  +0.000029] nvmet: ctrl 1 fatal error occurred!
[ +10.280101] nvmet: creating controller 1 for subsystem nvme-ram0 for
NQN nqn.2014-08.org.nvmexpress.chelsio.

