Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173BE26DE92
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Sep 2020 16:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgIQOWD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Sep 2020 10:22:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13242 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727392AbgIQOMH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Sep 2020 10:12:07 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DD669CF5D799BBBDFFC7;
        Thu, 17 Sep 2020 22:11:59 +0800 (CST)
Received: from [10.67.103.119] (10.67.103.119) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 22:11:57 +0800
Subject: Re: [bug report] RDMA/hns: Avoid unncessary initialization
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <linux-rdma@vger.kernel.org>
References: <20200916143940.GA766708@mwanda>
From:   oulijun <oulijun@huawei.com>
Message-ID: <3dbe4539-2c7a-1ef2-3923-0f18567d4265@huawei.com>
Date:   Thu, 17 Sep 2020 22:11:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20200916143940.GA766708@mwanda>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.119]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks. I will fix it.

ÔÚ 2020/9/16 22:39, Dan Carpenter Ð´µÀ:
> Hello Lijun Ou,
>
> The patch a2f3d4479fe9: "RDMA/hns: Avoid unncessary initialization"
> from Sep 8, 2020, leads to the following static checker warning:
>
> 	drivers/infiniband/hw/hns/hns_roce_hw_v1.c:282 hns_roce_v1_post_send()
> 	error: uninitialized symbol 'ps_opcode'.
>
> drivers/infiniband/hw/hns/hns_roce_hw_v1.c
>     256                          switch (wr->opcode) {
>     257                          case IB_WR_RDMA_READ:
>     258                                  ps_opcode = HNS_ROCE_WQE_OPCODE_RDMA_READ;
>     259                                  set_raddr_seg(wqe,  rdma_wr(wr)->remote_addr,
>     260                                                 rdma_wr(wr)->rkey);
>     261                                  break;
>     262                          case IB_WR_RDMA_WRITE:
>     263                          case IB_WR_RDMA_WRITE_WITH_IMM:
>     264                                  ps_opcode = HNS_ROCE_WQE_OPCODE_RDMA_WRITE;
>     265                                  set_raddr_seg(wqe,  rdma_wr(wr)->remote_addr,
>     266                                                rdma_wr(wr)->rkey);
>     267                                  break;
>     268                          case IB_WR_SEND:
>     269                          case IB_WR_SEND_WITH_INV:
>     270                          case IB_WR_SEND_WITH_IMM:
>     271                                  ps_opcode = HNS_ROCE_WQE_OPCODE_SEND;
>     272                                  break;
>     273                          case IB_WR_LOCAL_INV:
>                                  ^^^^^^^^^^^^^^^^^^^^
> "ps_opcode" is not initialized for this case statement.
>
>     274                                  break;
>     275                          case IB_WR_ATOMIC_CMP_AND_SWP:
>     276                          case IB_WR_ATOMIC_FETCH_AND_ADD:
>     277                          case IB_WR_LSO:
>     278                          default:
>     279                                  ps_opcode = HNS_ROCE_WQE_OPCODE_MASK;
>     280                                  break;
>     281                          }
>     282                          ctrl->flag |= cpu_to_le32(ps_opcode);
>                                                            ^^^^^^^^^
> Uninitialized.
>
>     283                          wqe += sizeof(struct hns_roce_wqe_raddr_seg);
>     284
>     285                          dseg = wqe;
>
> regards,
> dan carpenter
> .
>

