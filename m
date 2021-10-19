Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C18433630
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Oct 2021 14:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhJSMp2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Oct 2021 08:45:28 -0400
Received: from out20-13.mail.aliyun.com ([115.124.20.13]:51163 "EHLO
        out20-13.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhJSMp1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Oct 2021 08:45:27 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04606774|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.014655-0.000226005-0.985119;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.LeQNB3l_1634647393;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.LeQNB3l_1634647393)
          by smtp.aliyun-inc.com(10.147.40.26);
          Tue, 19 Oct 2021 20:43:13 +0800
Date:   Tue, 19 Oct 2021 20:43:16 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] infiniband: change some kmalloc to kvmalloc to support CONFIG_PROVE_LOCKING=y
Cc:     linux-rdma@vger.kernel.org, selvin.xavier@broadcom.com,
        eddie.wai@broadcom.com
In-Reply-To: <20211019113722.GG3686969@ziepe.ca>
References: <20211019002656.17745-1-wangyugui@e16-tech.com> <20211019113722.GG3686969@ziepe.ca>
Message-Id: <20211019204315.A760.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

> On Tue, Oct 19, 2021 at 08:26:56AM +0800, wangyugui wrote:
> > When CONFIG_PROVE_LOCKING=y, one kmalloc of infiniband hit the max alloc size limitation.
> > 
> > WARNING: CPU: 36 PID: 8 at mm/page_alloc.c:5350 __alloc_pages+0x27e/0x3e0
> >  Call Trace:
> >   kmalloc_order+0x2a/0xb0
> >   kmalloc_order_trace+0x19/0xf0
> >   __kmalloc+0x231/0x270
> >   ib_setup_port_attrs+0xd8/0x870 [ib_core]
> >   ib_register_device+0x419/0x4e0 [ib_core]
> >   bnxt_re_task+0x208/0x2d0 [bnxt_re]
> > 
> > change this kmalloc to kvmalloc to support CONFIG_PROVE_LOCKING=y
> > 
> > Signed-off-by: wangyugui <wangyugui@e16-tech.com>
> > ---
> >  drivers/infiniband/core/sysfs.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Huh? what causes ib_port to get larger than MAX_ORDER?
> 
> The only array is attrs_list and I don't see something that scales
> with

The array size is not fixed. so it maybe a little big in some case.

struct ib_port {
	struct kobject kobj;
	struct ib_device *ibdev;
	struct gid_attr_group *gid_attr_group;
	struct hw_stats_port_data *hw_stats_data;

	struct attribute_group groups[3];
	const struct attribute_group *groups_list[5];
	u32 port_num;
	struct port_table_attribute attrs_list[];
};

=>
struct port_table_attribute {
	struct ib_port_attribute attr;

=>
struct ib_port_attribute {
	struct attribute attr;

=>
struct attribute {
	const char		*name;
	umode_t			mode;
#ifdef CONFIG_DEBUG_LOCK_ALLOC
	bool			ignore_lockdep:1;
	struct lock_class_key	*key;
	struct lock_class_key	skey;
#endif
};

When CONFIG_PROVE_LOCKING=y, we need CONFIG_DEBUG_LOCK_ALLOC=y too.

This problem happen when CONFIG_PROVE_LOCKING=y(CONFIG_DEBUG_LOCK_ALLOC=y),
but not happen when CONFIG_PROVE_LOCKING=n(CONFIG_DEBUG_LOCK_ALLOC=n).

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/10/19



