Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536343F555F
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Aug 2021 03:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhHXBIN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 21:08:13 -0400
Received: from mx20.baidu.com ([111.202.115.85]:38058 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233585AbhHXBIN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Aug 2021 21:08:13 -0400
Received: from BJHW-Mail-Ex13.internal.baidu.com (unknown [10.127.64.36])
        by Forcepoint Email with ESMTPS id 0D789C2F76B8BD4F2E3D;
        Tue, 24 Aug 2021 09:07:28 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex13.internal.baidu.com (10.127.64.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 24 Aug 2021 09:07:27 +0800
Received: from localhost (172.31.63.8) by BJHW-MAIL-EX27.internal.baidu.com
 (10.127.64.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 24
 Aug 2021 09:07:27 +0800
Date:   Tue, 24 Aug 2021 09:07:27 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        <mike.marciniszyn@cornelisnetworks.com>, <dledford@redhat.com>,
        <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/hfi1: Convert to SPDX identifier
Message-ID: <20210824010727.GA1106@LAPTOP-UKSR4ENP.internal.baidu.com>
References: <20210823042622.109-1-caihuoqing@baidu.com>
 <a9122be9-82c5-30d3-e1b3-b9a1a07536d0@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a9122be9-82c5-30d3-e1b3-b9a1a07536d0@cornelisnetworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex12.internal.baidu.com (172.31.51.52) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex13_2021-08-24 09:07:28:103
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 23 Aug 21 14:31:15, Dennis Dalessandro wrote:
> 
> 
> On 8/23/21 12:26 AM, Cai Huoqing wrote:
> > use SPDX-License-Identifier instead of a verbose license text
> > 
> > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> > ---
> >  drivers/infiniband/hw/hfi1/affinity.c       | 45 +------------------
> >  drivers/infiniband/hw/hfi1/affinity.h       | 45 +------------------
> >  drivers/infiniband/hw/hfi1/aspm.h           | 45 +------------------
> >  drivers/infiniband/hw/hfi1/chip.c           | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/chip.h           | 48 ++------------------
> >  drivers/infiniband/hw/hfi1/chip_registers.h | 50 ++-------------------
> >  drivers/infiniband/hw/hfi1/common.h         | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/debugfs.c        | 45 +------------------
> >  drivers/infiniband/hw/hfi1/debugfs.h        | 49 ++------------------
> >  drivers/infiniband/hw/hfi1/device.c         | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/device.h         | 49 ++------------------
> >  drivers/infiniband/hw/hfi1/driver.c         | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/efivar.c         | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/efivar.h         | 45 +------------------
> >  drivers/infiniband/hw/hfi1/eprom.c          | 45 +------------------
> >  drivers/infiniband/hw/hfi1/eprom.h          | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/exp_rcv.c        | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/exp_rcv.h        | 48 ++------------------
> >  drivers/infiniband/hw/hfi1/fault.c          | 45 +------------------
> >  drivers/infiniband/hw/hfi1/fault.h          | 50 +++------------------
> >  drivers/infiniband/hw/hfi1/file_ops.c       | 45 +------------------
> >  drivers/infiniband/hw/hfi1/firmware.c       | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/hfi.h            | 49 ++------------------
> >  drivers/infiniband/hw/hfi1/init.c           | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/intr.c           | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/iowait.h         | 49 ++------------------
> >  drivers/infiniband/hw/hfi1/mad.c            | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/mad.h            | 45 +------------------
> >  drivers/infiniband/hw/hfi1/mmu_rb.c         | 45 +------------------
> >  drivers/infiniband/hw/hfi1/mmu_rb.h         | 45 +------------------
> >  drivers/infiniband/hw/hfi1/msix.c           | 43 ------------------
> >  drivers/infiniband/hw/hfi1/msix.h           | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/opa_compat.h     | 48 ++------------------
> >  drivers/infiniband/hw/hfi1/pcie.c           | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/pio.c            | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/pio.h            | 48 ++------------------
> >  drivers/infiniband/hw/hfi1/pio_copy.c       | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/platform.c       | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/platform.h       | 45 +------------------
> >  drivers/infiniband/hw/hfi1/qp.c             | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/qp.h             | 48 ++------------------
> >  drivers/infiniband/hw/hfi1/qsfp.c           | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/qsfp.h           | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/rc.c             | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/ruc.c            | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/sdma.c           | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/sdma.h           | 49 ++------------------
> >  drivers/infiniband/hw/hfi1/sdma_txreq.h     | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/sysfs.c          | 45 +------------------
> >  drivers/infiniband/hw/hfi1/trace.c          | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/trace.h          | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/trace_ctxts.h    | 45 +------------------
> >  drivers/infiniband/hw/hfi1/trace_dbg.h      | 45 +------------------
> >  drivers/infiniband/hw/hfi1/trace_ibhdrs.h   | 45 +------------------
> >  drivers/infiniband/hw/hfi1/trace_misc.h     | 45 +------------------
> >  drivers/infiniband/hw/hfi1/trace_mmu.h      | 45 +------------------
> >  drivers/infiniband/hw/hfi1/trace_rc.h       | 45 +------------------
> >  drivers/infiniband/hw/hfi1/trace_rx.h       | 45 +------------------
> >  drivers/infiniband/hw/hfi1/trace_tx.h       | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/uc.c             | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/ud.c             | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/user_exp_rcv.c   | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/user_exp_rcv.h   | 49 ++------------------
> >  drivers/infiniband/hw/hfi1/user_pages.c     | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/user_sdma.c      | 45 +------------------
> >  drivers/infiniband/hw/hfi1/user_sdma.h      | 49 ++------------------
> >  drivers/infiniband/hw/hfi1/verbs.c          | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/verbs.h          | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/verbs_txreq.c    | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/verbs_txreq.h    | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/vnic.h           | 48 ++------------------
> >  drivers/infiniband/hw/hfi1/vnic_main.c      | 44 +-----------------
> >  drivers/infiniband/hw/hfi1/vnic_sdma.c      | 44 +-----------------
> >  73 files changed, 133 insertions(+), 3170 deletions(-)
> 
> Never really seen the need for this large code churn. Is it really necessary?
> Maybe it would be better to just touch this up the next time we actaully have to
> patch a particular file.
> 
> -Denny

thanks for your feedback, I just try to change them in only one patch
it is a good refator, replace 40+ lines with one line :)
