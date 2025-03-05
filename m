Return-Path: <linux-rdma+bounces-8379-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C154A50C12
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 20:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D913B0796
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 19:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E230E2441A1;
	Wed,  5 Mar 2025 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s88nvYIk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB64C249E5
	for <linux-rdma@vger.kernel.org>; Wed,  5 Mar 2025 19:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204677; cv=none; b=Cars3cBtvPgZiOTXwUZlClte7PvWuAQAwgPUjuOYz1nbBrSjcvM17zrcTQGVshyVBtJniX6p122Xy4rK/zO4sIw8ysh2e6Loc2yLCVNlIQpQKHkNM5xPTWQn6e1uPUPGfVW+YJ6ktmMVQrRpnp1o3X9y89/vyHG+q8y0kU6GO2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204677; c=relaxed/simple;
	bh=8etd4NBgtw+KJtrMEtwMGhIvko7YbQFx/ByI+R7IIvY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WnWV+I4/W4U3uS7WNy269QMqtqjL9sSrlufd3uxhuctfSeksiU90qc/PFvRQ2du2OrH+YRVZB1Vt2bjgt5dsqh+w1ABEJQintY/ChA4pQZdfK0azhn0TW2+wFH3wCY1ftdlnxgHo/tTtSFVzFw64s4qpvmxeVnOP/eNA7H1UD4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s88nvYIk; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-390df942558so5661296f8f.2
        for <linux-rdma@vger.kernel.org>; Wed, 05 Mar 2025 11:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741204674; x=1741809474; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CkyU3AflKcmo4EyRaV+Q4JwcVlazh8u8cbqig+w6Hww=;
        b=s88nvYIkR7BkTjJUsyVPrYp+Rqn9Ly+tmZKSDmG6zBgBP0B9rP7udT6GEdZK0VNa2Q
         qjLnkn2rbhnbE7mx9KzAY4qFtfOCZRpPYwR6kKaOCUnf8ndN74lFqm6xL0aMlaOZ8Wc0
         7/JN5AZUC9RgP2S+i1zcWuJBxrEOxyBEvNPdK9kjDlOc8Da+YBEc7ew4tNG/Uxju4cHB
         4GVY7qBSa9ybGD81hDIgMiurfW2Pq0zgF360QyusdENq9K7PWV7SLKGzQ31YVoKn0XcN
         Ep3TNORqfm/Pq6MbD8Mk3q5hXeynYAzO5pQbkgzR8z2zjJsJgN0JeRA+0Zyo1ERRo3HH
         wU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741204674; x=1741809474;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CkyU3AflKcmo4EyRaV+Q4JwcVlazh8u8cbqig+w6Hww=;
        b=SYvCPHMH8Ctu1NowoSqgilStAFFDn2xfTFiPwawuVjyGoFNK2vZj66vc1y8JzWHpwr
         rBn7eX6i/eJIf1JbVJdGBhXf0ZLYnGhuHuNFGKkPZYB8RzeUlRJBU7seWNTW5m6FAgl5
         dowB7t0H3XwN8iy8N/gC36UVUMLNxNXPNsuvnTRl0Kq5UO9VBUOJwcvjj/UqqEUEG7aI
         zC2lFuQrQfGmAGUmECcfRFfkWqoz9fGRw9Jpwk2fIV6UNE+KosNV7qs2r88cXILhRq75
         2GopAgYnzaMEBsLUE9uh1E6sqJqjS94X4y0UJCwBRjYYsnEmB7NSbZPiQs320QgSbVbw
         C2cA==
X-Gm-Message-State: AOJu0Yxyvai0R/nKxlGpnGlXqjsxP+89vxfWPOi+4uy6IEYFtRhC5aH+
	CFmlWOSoWQ9UxCeNgpwiN1qDkZ15m4jiccoOFNgWKqG+nmfEcd/VCyn5sqwuTBhwboWsVe/P1aY
	A
X-Gm-Gg: ASbGncucqUrXlMRhRQ//Kn7EcAESlLpsacU2li3yAWk5yz1VABS1aGR1vHEJY8A/zCr
	ISfLyJK2mHXIrvecEaJ1rHqS7Fdoc8tMSGeq1tj8ByhFOxDVeAc49vQfio8Xho96eEj3ANb4JVc
	BLnBZtozPB3POOxHyQiBE+d5FKEIb6XkkIjFzM4xiSSUtfVGt0a0JTrT3oX5/FpWT/0/U4l3rkY
	RsamgOsdfaNUCiJGXgYo/BlYZdDD3ffxyInC8dsO0lzdvf3f5E9VaSGPpeM5ffN3oj+xZKddgDu
	Nv6dBjJ/8pBZK/HYHMGyaf0sCVoedC/UQ3aR2RgSasSh5rjYGA==
X-Google-Smtp-Source: AGHT+IEQM2Aj31muradhITrsAXYRACK9yPwqSb+utb5JYxF/P7ubJOsCVU9sLH0YWkDaygifDurBkw==
X-Received: by 2002:a05:6000:1843:b0:391:12a5:3c95 with SMTP id ffacd0b85a97d-3911f73858fmr3217463f8f.22.1741204673951;
        Wed, 05 Mar 2025 11:57:53 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bd4352fa3sm26843325e9.30.2025.03.05.11.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:57:53 -0800 (PST)
Date: Wed, 5 Mar 2025 22:57:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/mana_ib: implement uapi for creation of rnic cq
Message-ID: <26f9cf15-2446-4a73-bc34-5d07dfcfa751@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Konstantin Taranov,

Commit 44b607ad4cdf ("RDMA/mana_ib: implement uapi for creation of
rnic cq") from Apr 26, 2024 (linux-next), leads to the following
Smatch static checker warning:

	drivers/infiniband/hw/mana/cq.c:48 mana_ib_create_cq()
	warn: potential user controlled sizeof overflow 'cq->cqe * 64' 's32min-s32max * 64'

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
    18         struct gdma_context *gc;
    19         bool is_rnic_cq;
    20         u32 doorbell;
    21         u32 buf_size;
    22         int err;
    23 
    24         mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
    25         gc = mdev_to_gc(mdev);
    26 
    27         cq->comp_vector = attr->comp_vector % ibdev->num_comp_vectors;
    28         cq->cq_handle = INVALID_MANA_HANDLE;
    29 
    30         if (udata) {
    31                 if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
    32                         return -EINVAL;
    33 
    34                 err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
                                                 ^^^^
ucmd.flags is set by the user here.

    35                 if (err) {
    36                         ibdev_dbg(ibdev, "Failed to copy from udata for create cq, %d\n", err);
    37                         return err;
    38                 }
    39 
    40                 is_rnic_cq = !!(ucmd.flags & MANA_IB_CREATE_RNIC_CQ);
    41 
    42                 if (!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) {
                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
attr->cqe used to be bounds checked every time, but now the user can
skip setting the flag for bounds checking.

    43                         ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
    44                         return -EINVAL;
    45                 }
    46 
    47                 cq->cqe = attr->cqe;
--> 48                 err = mana_ib_create_queue(mdev, ucmd.buf_addr, cq->cqe * COMP_ENTRY_SIZE,
                                                                       ^^^^^^^^^^^^^^^^^^^^^^^^^

This can lead to integer wrapping.

The call tree is:

ib_uverbs_create_cq() <- copies cmd.cqe from the user
  -> create_cq() calls (struct ib_device_ops)->create_cq()
     -> mana_ib_create_cq()

I'm not sure if this integer overflow has any negative effects.  I think
it's probably fine?


    49                                            &cq->queue);
    50                 if (err) {
    51                         ibdev_dbg(ibdev, "Failed to create queue for create cq, %d\n", err);
    52                         return err;
    53                 }
    54 
    55                 mana_ucontext = rdma_udata_to_drv_context(udata, struct mana_ib_ucontext,
    56                                                           ibucontext);
    57                 doorbell = mana_ucontext->doorbell;
    58         } else {
    59                 is_rnic_cq = true;
    60                 buf_size = MANA_PAGE_ALIGN(roundup_pow_of_two(attr->cqe * COMP_ENTRY_SIZE));
    61                 cq->cqe = buf_size / COMP_ENTRY_SIZE;
    62                 err = mana_ib_create_kernel_queue(mdev, buf_size, GDMA_CQ, &cq->queue);
    63                 if (err) {
    64                         ibdev_dbg(ibdev, "Failed to create kernel queue for create cq, %d\n", err);
    65                         return err;
    66                 }
    67                 doorbell = gc->mana_ib.doorbell;
    68         }
    69 
    70         if (is_rnic_cq) {
    71                 err = mana_ib_gd_create_cq(mdev, cq, doorbell);
    72                 if (err) {
    73                         ibdev_dbg(ibdev, "Failed to create RNIC cq, %d\n", err);
    74                         goto err_destroy_queue;
    75                 }
    76 
    77                 err = mana_ib_install_cq_cb(mdev, cq);
    78                 if (err) {
    79                         ibdev_dbg(ibdev, "Failed to install cq callback, %d\n", err);
    80                         goto err_destroy_rnic_cq;
    81                 }
    82         }
    83 
    84         if (udata) {
    85                 resp.cqid = cq->queue.id;
    86                 err = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
    87                 if (err) {
    88                         ibdev_dbg(&mdev->ib_dev, "Failed to copy to udata, %d\n", err);
    89                         goto err_remove_cq_cb;
    90                 }
    91         }
    92 
    93         spin_lock_init(&cq->cq_lock);
    94         INIT_LIST_HEAD(&cq->list_send_qp);
    95         INIT_LIST_HEAD(&cq->list_recv_qp);
    96 
    97         return 0;
    98 
    99 err_remove_cq_cb:
    100         mana_ib_remove_cq_cb(mdev, cq);
    101 err_destroy_rnic_cq:
    102         mana_ib_gd_destroy_cq(mdev, cq);
    103 err_destroy_queue:
    104         mana_ib_destroy_queue(mdev, &cq->queue);
    105 
    106         return err;
    107 }

regards,
dan carpenter

