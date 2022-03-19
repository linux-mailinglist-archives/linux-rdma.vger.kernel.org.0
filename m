Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BA14DE6E1
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Mar 2022 08:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242444AbiCSHyo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Mar 2022 03:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236778AbiCSHyn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Mar 2022 03:54:43 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0E71D251A
        for <linux-rdma@vger.kernel.org>; Sat, 19 Mar 2022 00:53:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V7aAfQ-_1647676398;
Received: from 30.236.17.167(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V7aAfQ-_1647676398)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 19 Mar 2022 15:53:19 +0800
Message-ID: <7330e0e7-477f-fac5-43aa-8ec32cd41890@linux.alibaba.com>
Date:   Sat, 19 Mar 2022 15:53:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH for-next v4 03/12] RDMA/erdma: Add the hardware related
 definitions
Content-Language: en-US
To:     Wenpeng Liang <liangwenpeng@huawei.com>, jgg@ziepe.ca,
        dledford@redhat.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
References: <20220314064739.81647-1-chengyou@linux.alibaba.com>
 <20220314064739.81647-4-chengyou@linux.alibaba.com>
 <657d3bf4-e09c-a36a-6a0d-4c27c4720773@huawei.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <657d3bf4-e09c-a36a-6a0d-4c27c4720773@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 3/18/22 6:27 PM, Wenpeng Liang wrote:
>> +
>> +struct erdma_cmdq_dereg_mr_req {
>> +	u64 hdr;
>> +	u32 cfg0;
>> +};
> 
> A single cfg may not need numbering.
> 
> cfg0->cfg
> 
>> +
>> +/* modify qp cfg0 */
> 
> Ditto.
> 
> cfg0->cfg
> 

Fine will fix.

>> +#define ERDMA_CMD_MODIFY_QP_STATE_MASK GENMASK(31, 24)
>> +#define ERDMA_CMD_MODIFY_QP_CC_MASK GENMASK(23, 20)
>> +#define ERDMA_CMD_MODIFY_QP_QPN_MASK GENMASK(19, 0)
>> +
>> +struct erdma_cmdq_modify_qp_req {
>> +	u64 hdr;
>> +	u32 cfg0;
>> +	u32 cookie;
>> +	u32 dip;
>> +	u32 sip;
>> +	u16 sport;
>> +	u16 dport;
>> +	u32 send_nxt;
>> +	u32 recv_nxt;
>> +};
> 
> Ditto.
> 
> cfg0->cfg
Will fix.

> 
>> +
>> +/* create qp cfg0 */
>> +#define ERDMA_CMD_CREATE_QP_SQ_DEPTH_MASK GENMASK(31, 20)
>> +#define ERDMA_CMD_CREATE_QP_QPN_MASK GENMASK(19, 0)
>> +
>> +/* create qp cfg1 */
>> +#define ERDMA_CMD_CREATE_QP_RQ_DEPTH_MASK GENMASK(31, 20)
>> +#define ERDMA_CMD_CREATE_QP_PD_MASK GENMASK(19, 0)
>> +
> 
>> +
>> +/* Receive Queue Element */
>> +struct erdma_rqe {
>> +	__le16 qe_idx;
>> +	__le16 rsvd;
>> +	__le32 qpn;
>> +	__le32 rsvd2;
>> +	__le32 rsvd3;
>> +	__le64 to;
>> +	__le32 length;
>> +	__le32 stag;
>> +};
> 
> Can these "rsvd" be numbered sequentially?
> 
> rsvd->rsvd0
> rsvd2->rsvd1
> rsvd3->rsvd2
> 

OK, I will pay more attention about this.

Thanks.

>> +
>> +struct erdma_readreq_sqe {
>> +	__le64 hdr;
>> +	__le32 invalid_stag;
>> +	__le32 length;
>> +	__le32 sink_stag;
>> +	__le32 sink_to_low;
>> +	__le32 sink_to_high;
>> +	__le32 rsvd0;
>> +};
> 
> A single rsvd may not need numbering.
> 
> rsvd0->rsvd
> 

Also will fix.
> 
>> +struct erdma_aeqe {
>> +	__le32 hdr;
>> +	__le32 event_data0;
>> +	__le32 event_data1;
>> +	__le32 rsvd2;
>> +};
> 
> Ditto.
> 
> rsvd2->rsvd

will fix.

Thanks,
Cheng Xu

> 
> Thanks,
> Wenpeng
