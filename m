Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1A342B578
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 07:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbhJMFgL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Oct 2021 01:36:11 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:44899 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJMFgK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Oct 2021 01:36:10 -0400
Received: by mail-pj1-f46.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so1349882pjb.3
        for <linux-rdma@vger.kernel.org>; Tue, 12 Oct 2021 22:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NNe7KWnuu6eth2pIuScfcaclyd9e7TELFqq5s+9SLgo=;
        b=s+tl1DKTciifQso3nDkc9coEKHqEPOQp+X3aQFuHJV8hI1bvVdZmUnz+a3hD1B1wab
         xCPXlVY99mnplalIOAvikgLofu/zZuKT7s3ptRStTDSxlR4JCJ9i/FRIqGiM+9fTY9tP
         v6WwSBasw+dwR2cKhmr6eXAHiVwXsIbof3MkmvnmCfdU2UOGb1HhcpD0f63EMhyfL3Ca
         HVSaqevfEaFdKqPJiEXBbicMx0Jsu3f5vkS9gxIzMa6Km8Nq3czSCpr7/unePrYwIidW
         my3ILX0h2rO0JeRtvemKouq2zycOr5+itPs4+7+hEPug42nR9g1tlOrvU10YDS723A64
         kODg==
X-Gm-Message-State: AOAM530OavCrZ8H7j7/WEVs2fM85qru22UZEMGx9qzPc8KWcvyG739ej
        6rt1YjdhM0Mrg/fiebryVUk=
X-Google-Smtp-Source: ABdhPJwbFdUckiY5mSGOpG0HwdcKjc0inPeVFdGuym4bopKi/Vg/qZ5Vha3usChAZMelUJqel14vpw==
X-Received: by 2002:a17:90b:1c8f:: with SMTP id oo15mr10922167pjb.169.1634103247692;
        Tue, 12 Oct 2021 22:34:07 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:3064:c09f:3b30:796? ([2601:647:4000:d7:3064:c09f:3b30:796])
        by smtp.gmail.com with ESMTPSA id v13sm13179852pgt.7.2021.10.12.22.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 22:34:07 -0700 (PDT)
Message-ID: <a9d05dea-860f-fe77-fc41-19208d76d9c1@acm.org>
Date:   Tue, 12 Oct 2021 22:34:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: Kernel warning at drivers/infiniband/core/rw.c:349
Content-Language: en-US
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <996fa723-18ef-d35b-c565-c9cb9dc2d5e1@acm.org>
 <2b07fbf9-36b4-37ea-b203-7d0a2fc6589a@deltatee.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <2b07fbf9-36b4-37ea-b203-7d0a2fc6589a@deltatee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/12/21 17:30, Logan Gunthorpe wrote:
> Best I can see from the code is that someone is passing an sg_cnt of
> zero. Previously that would have returned -ENOMEM, but now it might be
> ignored, in which case it would hit that WARNING and return -EIO.

That is not what is happening. The debug patch shown below learned me 
the following:
* The sg_cnt argument of rdma_rw_ctx_init() is not zero.
* After the rdma_rw_map_sgtable() call, sgt.nents is zero.

The debug patch that I used is as follows:

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 5a3bd41b331c..a6dabea37958 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -326,11 +326,15 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, 
struct ib_qp *qp, u32 port_num,
  	};
  	int ret;

+	WARN_ON_ONCE(!sg_cnt);
+
  	ret = rdma_rw_map_sgtable(dev, &sgt, dir);
  	if (ret)
  		return ret;
  	sg_cnt = sgt.nents;

+	WARN_ON_ONCE(!sg_cnt);
+
  	/*
  	 * Skip to the S/G entry that sg_offset falls into:
  	 */
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c 
b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 3cadf1295417..d9e3d52eb952 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -911,11 +911,16 @@ static int srpt_alloc_rw_ctxs(struct 
srpt_send_ioctx *ioctx,
  		u32 size = be32_to_cpu(db->len);
  		u32 rkey = be32_to_cpu(db->key);

+		WARN_ON_ONCE(!size);
+
  		ret = target_alloc_sgl(&ctx->sg, &ctx->nents, size,
  				 false, i < nbufs - 1);
  		if (ret)
  			goto unwind;

+		WARN_ONCE(ctx->nents <= 0, "%u bytes -> %d entries\n",
+			  size, ctx->nents);
+
  		ret = rdma_rw_ctx_init(&ctx->rw, ch->qp,
                                 ch->sport->port,
  				ctx->sg, ctx->nents, 0, remote_addr,
                                 rkey, dir);
  		if (ret < 0) {
