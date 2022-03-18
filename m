Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE06A4DD7E8
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 11:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiCRK3S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Mar 2022 06:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiCRK3R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Mar 2022 06:29:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FA52BE2
        for <linux-rdma@vger.kernel.org>; Fri, 18 Mar 2022 03:27:55 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KKgCh5FsmzfZ0d;
        Fri, 18 Mar 2022 18:26:24 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 18:27:54 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 18:27:54 +0800
Subject: Re: [PATCH for-next v4 03/12] RDMA/erdma: Add the hardware related
 definitions
To:     Cheng Xu <chengyou@linux.alibaba.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>
References: <20220314064739.81647-1-chengyou@linux.alibaba.com>
 <20220314064739.81647-4-chengyou@linux.alibaba.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <KaiShen@linux.alibaba.com>, <tonylu@linux.alibaba.com>,
        <BMT@zurich.ibm.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <657d3bf4-e09c-a36a-6a0d-4c27c4720773@huawei.com>
Date:   Fri, 18 Mar 2022 18:27:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220314064739.81647-4-chengyou@linux.alibaba.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> +
> +struct erdma_cmdq_dereg_mr_req {
> +	u64 hdr;
> +	u32 cfg0;
> +};

A single cfg may not need numbering.

cfg0->cfg

> +
> +/* modify qp cfg0 */

Ditto.

cfg0->cfg

> +#define ERDMA_CMD_MODIFY_QP_STATE_MASK GENMASK(31, 24)
> +#define ERDMA_CMD_MODIFY_QP_CC_MASK GENMASK(23, 20)
> +#define ERDMA_CMD_MODIFY_QP_QPN_MASK GENMASK(19, 0)
> +
> +struct erdma_cmdq_modify_qp_req {
> +	u64 hdr;
> +	u32 cfg0;
> +	u32 cookie;
> +	u32 dip;
> +	u32 sip;
> +	u16 sport;
> +	u16 dport;
> +	u32 send_nxt;
> +	u32 recv_nxt;
> +};

Ditto.

cfg0->cfg

> +
> +/* create qp cfg0 */
> +#define ERDMA_CMD_CREATE_QP_SQ_DEPTH_MASK GENMASK(31, 20)
> +#define ERDMA_CMD_CREATE_QP_QPN_MASK GENMASK(19, 0)
> +
> +/* create qp cfg1 */
> +#define ERDMA_CMD_CREATE_QP_RQ_DEPTH_MASK GENMASK(31, 20)
> +#define ERDMA_CMD_CREATE_QP_PD_MASK GENMASK(19, 0)
> +

> +
> +/* Receive Queue Element */
> +struct erdma_rqe {
> +	__le16 qe_idx;
> +	__le16 rsvd;
> +	__le32 qpn;
> +	__le32 rsvd2;
> +	__le32 rsvd3;
> +	__le64 to;
> +	__le32 length;
> +	__le32 stag;
> +};

Can these "rsvd" be numbered sequentially?

rsvd->rsvd0
rsvd2->rsvd1
rsvd3->rsvd2

> +
> +struct erdma_readreq_sqe {
> +	__le64 hdr;
> +	__le32 invalid_stag;
> +	__le32 length;
> +	__le32 sink_stag;
> +	__le32 sink_to_low;
> +	__le32 sink_to_high;
> +	__le32 rsvd0;
> +};

A single rsvd may not need numbering.

rsvd0->rsvd


> +struct erdma_aeqe {
> +	__le32 hdr;
> +	__le32 event_data0;
> +	__le32 event_data1;
> +	__le32 rsvd2;
> +};

Ditto.

rsvd2->rsvd

Thanks,
Wenpeng
