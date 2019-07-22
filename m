Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC7E87081C
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 20:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfGVSHQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 14:07:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38271 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfGVSHQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 14:07:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so17754773pfn.5
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jul 2019 11:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RmKXpzSGzlv2f/5wd55UXo3Dlpyrvwn8M7HGQt3Gerw=;
        b=kyb+mYFdq0hS5a8O9M1VBc0v0o9hNbXDdEF4BFaO0h7eSqTBR0+N/6c2vXSiKacc6s
         8q6YBw4e6Swrb2fPgfRbFGu0gq9BDV2F6ujJr5kg2FWPhzEDS5cB0YMIgWFVPguInqRd
         eyB4cjAMLjWeIAyaGPaRqZyNH3ZpxiBJh3qYc5C4GmI7j5tWzY/2Y/a359g9tglEphfv
         ZtmLQM746Q8ubrtJgmBfmvqW5loFMQgDCU//rQl0F8PQWV3G3pImYzVgJB13v5t/XWMw
         skdHwcMUfFgFR/t8/mDVZNMG6fGKp+AFj0IpbwkwJI527eHyEl3IRHFBfvnA/PdAgOox
         qvpA==
X-Gm-Message-State: APjAAAXlUrdmJP/gWSbt/W38JT2UvYHygAR7mSn31K9gc17ui8Zxgord
        +mHnFH962NlL34LjFGvj/tTJfUpG
X-Google-Smtp-Source: APXvYqw07UbDq3DlpOaeGMjDaf69rcL7t23pw20aCo97hE9vfFJtBV/AiTOg2RngAbZgeYXnWVxbYg==
X-Received: by 2002:a63:b64:: with SMTP id a36mr62875211pgl.215.1563818834795;
        Mon, 22 Jul 2019 11:07:14 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b136sm45658972pfb.73.2019.07.22.11.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 11:07:13 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IOOAkFF1ZXN0aW9uIGZvciBzcnB0IGluIGtlcm5lbC00LjE044CR?=
To:     oulijun <oulijun@huawei.com>, dledford@redhat.com,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
References: <16008407-2ffd-0bbb-717e-7e874a3a5ee0@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d4b60eb6-9e61-987e-d7ba-e3806faceedd@acm.org>
Date:   Mon, 22 Jul 2019 11:07:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <16008407-2ffd-0bbb-717e-7e874a3a5ee0@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/19/19 11:54 PM, oulijun wrote:
> I am targeting a problem about RoCE and SCSI over RDMA from srpt in kernel-4.14. When insmod srpt.ko and insmod hns-roce-hw-v2.ko, it will
> report a warning in srpt_add_one:
>    ib_srpt srpt_add_one(hns_0) failed.

How about the following patch?

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 1a039f16d315..e2a4a14763b8 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -3109,7 +3109,8 @@ static void srpt_add_one(struct ib_device *device)
  	srpt_use_srq(sdev, sdev->port[0].port_attrib.use_srq);

  	if (!srpt_service_guid)
-		srpt_service_guid = be64_to_cpu(device->node_guid);
+		srpt_service_guid = be64_to_cpu(device->node_guid) &
+			~IB_SERVICE_ID_AGN_MASK;

  	if (rdma_port_get_link_layer(device, 1) == IB_LINK_LAYER_INFINIBAND)
  		sdev->cm_id = ib_create_cm_id(device, srpt_cm_handler, sdev);

> In addition, I analyzed a patch in kernel-4.17(IB/srpt: Add RDMA/CM support). As a result, I can understand that the previous srpt is not supported by RDMA/CM?
> So, all RoCE will failed when use kernel-4.14 version to run srpt.ko?

That's correct. The upstream SRP drivers only support RoCE in kernel versions
v4.17 and later.

Thanks,

Bart.
