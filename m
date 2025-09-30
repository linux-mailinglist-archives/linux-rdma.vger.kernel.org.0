Return-Path: <linux-rdma+bounces-13733-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0FFBAC2FE
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 11:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E9B18876A3
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 09:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFB02EA170;
	Tue, 30 Sep 2025 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NPZhoLln"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7877D17BEBF
	for <linux-rdma@vger.kernel.org>; Tue, 30 Sep 2025 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759223501; cv=none; b=BRKfF8OPzxwtsxG17eXm78RZgPo8jUXonfoj9wA6LiV1DbnrLowgf5guoJbkFHKwqKen97n2VDtmskzw+86f/qqNTP8edRRHS2Qf7tg2sFsm4NKpq9bfi/yqNi69FpTWEvxgwGGPidgPFNuvcQKZ2/MqgPYsgi8n/ZDMPV/s2iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759223501; c=relaxed/simple;
	bh=BIA2Wzs8D0BPItJVSySxQ2IvGC+C2AkFqxPahkbxsC0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SA4ZSUCzqT8HjAXEdhppyjs/RbFv6GpN3x16wj18qMQ9JnQDNA2/6IR7NmACDfeQ2hiiNFmJSPISodQWQ80yZa+s+Zx+8g2ocsAWwuR9Viz0MMzUKg1twCHWk0evFUqceZ51pputvV83hE+gQ+GBs2iROf6ZlVw0H9ButS7nhrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NPZhoLln; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3f44000626bso3458872f8f.3
        for <linux-rdma@vger.kernel.org>; Tue, 30 Sep 2025 02:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759223498; x=1759828298; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=epg45yIRMamMwoe1jinxUUjLDB/yCqHAZagVa7IdC4I=;
        b=NPZhoLln34Bod4nKkZD1G5rcBoc+L0ypYqDgYISc4W2gTojtmXXRx/vb2vnZUK2nWb
         l6fF9ZMuUWaV/K8PRaziNsF1z50mzdEy4Cw42xWYA1v+9b40W7s50QwsmNZn/OkTWkaz
         A9D7CzS6kERhVxhbEAmKbGnAD/Jo3iyXGfyErDrjKa3PKkokemJiK6QG4LYgIce+5YCf
         qrDCae9eQK0NRJTEgXGvIzlgw+lqh42tgswe/nX3y4yirCbzmqn6bTebarhlI6l3NVRV
         ww/URb5CJYGiO38HnuqL+QGabbak9u5XAV00XtepDBBCOgoVLS8h9FJIZ82LFGvvIx5T
         yB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759223498; x=1759828298;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=epg45yIRMamMwoe1jinxUUjLDB/yCqHAZagVa7IdC4I=;
        b=RjFbu6HL2KPdGSxQuZ2Yapy2D+d1NbSvv5KXnPAypsiTyeMF81Srhz2xJlqQcrfR2a
         /gd0RpGG+vPAwAMpsUfIfh281ZyUcs6vhlVGWmTbtW9RT2qj3NBW+QEaf3KCxQj7LiPu
         OW0SsU0u1CiR9T2kEBRoc63aWhwbfDbGZIpe5uI38ubYB/zmxO+G+N1AflUXdLPDa60g
         J18Ut00eLMrKspHKFgpJtMOaWVnvdcAvduZykLYTB3xtRhxAUpP0z9RJrN0JezCVotup
         6cmnZK60lh3ghnGa2PvyQQ0YfYNN9aKlbSS8dhQ+y8KBHRdkdqunPq/M2SZ1hLDXmEyL
         E+NA==
X-Gm-Message-State: AOJu0Yy6sLoMPx0DM/74Y8br/1Bfgit9iwkvVJHa2uHr2L5qGEzM8PKL
	a10Jbch1U/SkVxWXnhaIuIwaDdT6mb8hUf8z6MfIFMew9C9frgabL98a0Jvy6f1wDE8=
X-Gm-Gg: ASbGncsxxNFIoWmpXCm6acgdbw35MBDRF+xr/G0/Yy0IL2flUk1kqrxwE+osGwkv5ZL
	mAAMYTFQ1rjaLqoAnX7L6jPEM8ffl9NqsNzlxqcN1uhoPWMshqoNXl4xzqa0y1LC5COWwHEjkOQ
	EXc1s6o+VFLeEFYU6S0GCKUFfM1PXdVtrtYfcxdtkmziuak4KFaMbW6RXrJHgcTchzPp6NkB6nr
	oqnTm5QXwpq5Bx6E3zeJUgS/EKH/dBChQ9XUxNkQ644T2BeNK1EJDIK5Q3oIQHFnJF8Vga9DfNd
	rZ7jZc4wwpoXWU3s3QA7jmvsedg5Icys7QNxgfNV1JSy9RUq3feaDc6od18Fi67aMfxsj7bkw4f
	wBCnZ7ZF5jZjqBLX+pLvHc0L9Wyzbl0Ke5mest7huKqRHGqiLHOvU
X-Google-Smtp-Source: AGHT+IFHEkrrj5kAL9Ge+5osgMZNSM4k78aJb5SpwOgdCrLA+iEW86qj+pv8W4s8X0VJbGcTetsUGw==
X-Received: by 2002:a05:6000:25ca:b0:3eb:4e88:55e with SMTP id ffacd0b85a97d-40e47ee0960mr14985551f8f.41.1759223497673;
        Tue, 30 Sep 2025 02:11:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e42eee0b6sm149900635e9.10.2025.09.30.02.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 02:11:37 -0700 (PDT)
Date: Tue, 30 Sep 2025 12:11:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/mana_ib: create kernel-level CQs
Message-ID: <aNuexWJZvrpUsOki@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Konstantin Taranov,

Commit bec127e45d9f ("RDMA/mana_ib: create kernel-level CQs") from
Jan 20, 2025 (linux-next), leads to the following Smatch static
checker warning:

	drivers/infiniband/hw/mana/cq.c:59 mana_ib_create_cq()
	warn: potential user controlled sizeof overflow 'attr->cqe * 64' '0-u32max(user) * 64'

drivers/infiniband/hw/mana/cq.c
    8 int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
    9                       struct uverbs_attr_bundle *attrs)
    10 {
    11         struct ib_udata *udata = &attrs->driver_udata;
    12         struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
    13         struct mana_ib_create_cq_resp resp = {};
    14         struct mana_ib_ucontext *mana_ucontext;
    15         struct ib_device *ibdev = ibcq->device;
    16         struct mana_ib_create_cq ucmd = {};
    17         struct mana_ib_dev *mdev;
    18         bool is_rnic_cq;
    19         u32 doorbell;
    20         u32 buf_size;
    21         int err;
    22 
    23         mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
    24 
    25         cq->comp_vector = attr->comp_vector % ibdev->num_comp_vectors;
    26         cq->cq_handle = INVALID_MANA_HANDLE;
    27 
    28         if (udata) {
    29                 if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
    30                         return -EINVAL;
    31 
    32                 err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
    33                 if (err) {
    34                         ibdev_dbg(ibdev, "Failed to copy from udata for create cq, %d\n", err);
    35                         return err;
    36                 }
    37 
    38                 is_rnic_cq = !!(ucmd.flags & MANA_IB_CREATE_RNIC_CQ);
    39 
    40                 if ((!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) ||
    41                     attr->cqe > U32_MAX / COMP_ENTRY_SIZE) {
    42                         ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
    43                         return -EINVAL;
    44                 }
    45 
    46                 cq->cqe = attr->cqe;
    47                 err = mana_ib_create_queue(mdev, ucmd.buf_addr, cq->cqe * COMP_ENTRY_SIZE,
    48                                            &cq->queue);
    49                 if (err) {
    50                         ibdev_dbg(ibdev, "Failed to create queue for create cq, %d\n", err);
    51                         return err;
    52                 }
    53 
    54                 mana_ucontext = rdma_udata_to_drv_context(udata, struct mana_ib_ucontext,
    55                                                           ibucontext);
    56                 doorbell = mana_ucontext->doorbell;
    57         } else {
    58                 is_rnic_cq = true;
--> 59                 buf_size = MANA_PAGE_ALIGN(roundup_pow_of_two(attr->cqe * COMP_ENTRY_SIZE));

The static checker says that attr->cqe comes from the user and
this math can integer overflow.

The call tree is:

add_target_store()  <-  This gets the target->queue_size from the user
                        via srp_parse_options().  It has some bounds checking
                        but the result could be still be negative because of
                        integer overflows in the srp_parse_options() funtion
                        itself.  Plus INT_MAX can overflow as well later.
                        To be honest, ideally we would want to silence the
                        integer overflow in srp_parse_options() instead of
                        following it all the way through the call tree.

-> srp_create_ch_ib:
   -> ib_alloc_cq:
      -> __ib_alloc_cq() calls: ret = dev->ops.create_cq(cq, &cq_attr, NULL);
         -> mana_ib_create_cq()

    60                 cq->cqe = buf_size / COMP_ENTRY_SIZE;
    61                 err = mana_ib_create_kernel_queue(mdev, buf_size, GDMA_CQ, &cq->queue);
    62                 if (err) {
    63                         ibdev_dbg(ibdev, "Failed to create kernel queue for create cq, %d\n", err);
    64                         return err;
    65                 }
    66                 doorbell = mdev->gdma_dev->doorbell;
    67         }
    68 
    69         if (is_rnic_cq) {

regards,
dan carpenter

