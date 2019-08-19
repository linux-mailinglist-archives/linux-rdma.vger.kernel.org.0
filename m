Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA40394AA6
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 18:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfHSQnI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 12:43:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36413 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfHSQnH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 12:43:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id f19so818616plr.3
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 09:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A/9omrvh+Ex/umaxnloamqD/tzZhUbzk4JnE5RKfymw=;
        b=qkRhmIsdhEiJdQxxPNavKgCH1jYjlGv/78jdqgLizJFmbyuxNwrlOy/nhT87PefPlG
         WFoY/Cqtl0EkB7mjjiTfP2E/5bS6nlie7rGPm3AtA66sc1uCrXKCWk0QML+wfh8J05qs
         oHUXFwbshPl4ZCmbq5CX3ziaT/+obgaj4qfSKYejMeou/nsgdu+hL2hStORwNXJlpBsB
         PJfTPk7VduULO4+w7XDvJWgzUNfG0MCRBw2c/f4VpmDgyJJsJMN2DR3WstDCyhHsONxc
         lFVJ7goh8PRZXur+Qwe/4bMZjdF4oR5wCiLlQhyyUqgS57wtmFrDGKCaS57u29xbGXw6
         sXyQ==
X-Gm-Message-State: APjAAAWkYTANhm0bDXsKJPTdGXWKFr4qYSSLX9AVKKzS6Qx4JbqTPHeA
        cuK+ieDPPwG6Le8NHJTpGcgX9ftU
X-Google-Smtp-Source: APXvYqxnCe2FJeYxDebn5L+C/ayoxUe8X6bk1WpZPZro/6yMrCh/QdqmaisbQIalPCyaJjGZR86FCg==
X-Received: by 2002:a17:902:ac88:: with SMTP id h8mr21756998plr.77.1566232986716;
        Mon, 19 Aug 2019 09:43:06 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id e26sm18562142pfd.14.2019.08.19.09.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 09:43:06 -0700 (PDT)
Subject: Re: Question for srpt in kernel-4.14
To:     oulijun <oulijun@huawei.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        dledford@redhat.com, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
References: <16008407-2ffd-0bbb-717e-7e874a3a5ee0@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <bac894cf-a0d7-88aa-88ee-1422041dc90f@acm.org>
Date:   Mon, 19 Aug 2019 09:43:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <16008407-2ffd-0bbb-717e-7e874a3a5ee0@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/19/19 11:54 PM, oulijun wrote:
> Hi, Bart Van Assche & Doug Ledford
>    I am targeting a problem about RoCE and SCSI over RDMA from srpt in kernel-4.14. When insmod srpt.ko and insmod hns-roce-hw-v2.ko, it will
> report a warning in srpt_add_one:
>    ib_srpt srpt_add_one(hns_0) failed.
> 
>    I am tracking the error from ib_cm_listen in srpt_add_one.I found it returned an error when doing server_id validation
> the error code as follows:
>    static int __ib_cm_listen(struct ib_cm_id *cm_id, __be64 service_id,
> 			  __be64 service_mask)
> {
> 	struct cm_id_private *cm_id_priv, *cur_cm_id_priv;
> 	int ret = 0;
> 
> 	service_mask = service_mask ? service_mask : ~cpu_to_be64(0);
> 	service_id &= service_mask;
> 	if ((service_id & IB_SERVICE_ID_AGN_MASK) == IB_CM_ASSIGN_SERVICE_ID &&
> 	    (service_id != IB_CM_ASSIGN_SERVICE_ID))
> 		return -EINVAL;
>   	......
>   }
> 
> static void srpt_add_one(struct ib_device *device)
> {
> 	struct srpt_device *sdev;
> 	struct srpt_port *sport;
> 	int i;
> 
> 	pr_debug("device = %p\n", device);
> 
> 	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
> 	if (!sdev)
> 		goto err;
> 
> 	sdev->device = device;
> 	mutex_init(&sdev->sdev_mutex);
> 
> 	sdev->pd = ib_alloc_pd(device, 0);
> 	if (IS_ERR(sdev->pd))
> 		goto free_dev;
> 
> 	sdev->lkey = sdev->pd->local_dma_lkey;
> 
> 	sdev->srq_size = min(srpt_srq_size, sdev->device->attrs.max_srq_wr);
> 
> 	srpt_use_srq(sdev, sdev->port[0].port_attrib.use_srq);
> 
> 	if (!srpt_service_guid)
> 		srpt_service_guid = be64_to_cpu(device->node_guid);
> 
> 	sdev->cm_id = ib_create_cm_id(device, srpt_cm_handler, sdev);
> 	if (IS_ERR(sdev->cm_id))
> 		goto err_ring;
> 
> 	/* print out target login information */
> 	pr_debug("Target login info: id_ext=%016llx,ioc_guid=%016llx,"
> 		 "pkey=ffff,service_id=%016llx\n", srpt_service_guid,
> 		 srpt_service_guid, srpt_service_guid);
> 
> 	/*
> 	 * We do not have a consistent service_id (ie. also id_ext of target_id)
> 	 * to identify this target. We currently use the guid of the first HCA
> 	 * in the system as service_id; therefore, the target_id will change
> 	 * if this HCA is gone bad and replaced by different HCA
> 	 */
> 	if (ib_cm_listen(sdev->cm_id, cpu_to_be64(srpt_service_guid), 0))
> 		goto err_cm;
> 
> 	......
> }
> 
> However, I check the srpt_service_guid is obtained by device->node_guid. I think that the compute algorithm is ok for device->node_guid.
> In addition, I analyzed a patch in kernel-4.17(IB/srpt: Add RDMA/CM support). As a result, I can understand that the previous srpt is not supported by RDMA/CM?
> So, all RoCE will failed when use kernel-4.14 version to run srpt.ko?

Before commit 63cf1a902c9d ("IB/srpt: Add RDMA/CM support"; v4.17) 
ib_cm_listen() was called with srpt_service_guid as argument for all 
RDMA adapters. Since that commit ib_cm_listen() is only called for ports 
that have IB as link layer. In other words, I think the failure that you 
reported only occurs with kernel before 4.17 and not with kernel v4.17 
or any later kernel.

Bart.
