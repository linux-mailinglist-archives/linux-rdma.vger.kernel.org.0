Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DB04D7934
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Mar 2022 02:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiCNCAA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Mar 2022 22:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiCNB77 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Mar 2022 21:59:59 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC82020E
        for <linux-rdma@vger.kernel.org>; Sun, 13 Mar 2022 18:58:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V72SL4k_1647223126;
Received: from 30.43.106.15(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V72SL4k_1647223126)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 14 Mar 2022 09:58:47 +0800
Message-ID: <e2cc05cb-0ea9-6c36-40dd-84ee846f9dad@linux.alibaba.com>
Date:   Mon, 14 Mar 2022 09:58:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH for-next v3 08/12] RDMA/erdma: Add verbs implementation
Content-Language: en-US
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        Cheng Xu <chengyou.xc@alibaba-inc.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>
Cc:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>,
        "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
References: <BYAPR15MB26319BECD6F5455FAEDE9A6B990B9@BYAPR15MB2631.namprd15.prod.outlook.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <BYAPR15MB26319BECD6F5455FAEDE9A6B990B9@BYAPR15MB2631.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 3/10/22 11:21 PM, Bernard Metzler wrote:
> 
<...>
>> +
>> +int erdma_query_port(struct ib_device *ibdev, u32 port,
>> +		     struct ib_port_attr *attr)
>> +{
>> +	struct erdma_dev *dev = to_edev(ibdev);
>> +	int ret = 0;
> 
> not needed. just return 0.
> 

Will fix it.

>> +
>> +	memset(attr, 0, sizeof(*attr));
>> +
>> +	attr->state = dev->state;
>> +	if (dev->netdev) {
>> +		ret = ib_get_eth_speed(ibdev, port, &attr->active_speed,
>> +				       &attr->active_width);
>> +		attr->max_mtu = ib_mtu_int_to_enum(dev->netdev->mtu);
>> +		attr->active_mtu = ib_mtu_int_to_enum(dev->netdev->mtu);
>> +	}
>> +
>> +	attr->gid_tbl_len = 1;
>> +	attr->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_DEVICE_MGMT_SUP;
>> +	attr->max_msg_sz = -1;
>> +	if (dev->state == IB_PORT_ACTIVE)
>> +		attr->phys_state = IB_PORT_PHYS_STATE_LINK_UP;
>> +	else
>> +		attr->phys_state = IB_PORT_PHYS_STATE_DISABLED;
>> +
>> +	return ret;
>> +}
>> +
>> +int erdma_get_port_immutable(struct ib_device *ibdev, u32 port,
>> +			     struct ib_port_immutable *port_immutable)
>> +{
>> +	port_immutable->gid_tbl_len = 1;
>> +	port_immutable->core_cap_flags = RDMA_CORE_PORT_IWARP;
>> +
>> +	return 0;
>> +}
>> +
>> +int erdma_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
>> +{
>> +	struct erdma_pd *pd = to_epd(ibpd);
>> +	struct erdma_dev *dev = to_edev(ibpd->device);
>> +	int pdn;
>> +
>> +	pdn = erdma_alloc_idx(&dev->res_cb[ERDMA_RES_TYPE_PD]);
>> +	if (pdn < 0)
>> +		return pdn;
>> +
>> +	pd->pdn = pdn;
>> +
>> +	return 0;
>> +}
>> +
>> +int erdma_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
>> +{
>> +	struct erdma_pd *pd = to_epd(ibpd);
>> +	struct erdma_dev *dev = to_edev(ibpd->device);
>> +
>> +	erdma_free_idx(&dev->res_cb[ERDMA_RES_TYPE_PD], pd->pdn);
>> +
>> +	return 0;
>> +}
>> +
>> +static int erdma_qp_validate_cap(struct erdma_dev *dev,
>> +				 struct ib_qp_init_attr *attrs)
>> +{
>> +	if ((attrs->cap.max_send_wr > dev->attrs.max_send_wr) ||
>> +	    (attrs->cap.max_recv_wr > dev->attrs.max_recv_wr) ||
>> +	    (attrs->cap.max_send_sge > dev->attrs.max_send_sge) ||
>> +	    (attrs->cap.max_recv_sge > dev->attrs.max_recv_sge) ||
>> +	    (attrs->cap.max_inline_data > ERDMA_MAX_INLINE) ||
>> +	    !attrs->cap.max_send_wr || !attrs->cap.max_recv_wr) {
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int erdma_qp_validate_attr(struct erdma_dev *dev,
>> +				  struct ib_qp_init_attr *attrs)
>> +{
>> +	if (attrs->qp_type != IB_QPT_RC)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (attrs->srq)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (!attrs->send_cq || !attrs->recv_cq)
>> +		return -EOPNOTSUPP;
>> +
>> +	return 0;
>> +}
>> +
>> +static void free_kernel_qp(struct erdma_qp *qp)
>> +{
>> +	struct erdma_dev *dev = qp->dev;
>> +
>> +	vfree(qp->kern_qp.swr_tbl);
>> +	vfree(qp->kern_qp.rwr_tbl);
>> +
>> +	if (qp->kern_qp.sq_buf)
>> +		dma_free_coherent(
>> +			&dev->pdev->dev,
>> +			WARPPED_BUFSIZE(qp->attrs.sq_size << SQEBB_SHIFT),
>> +			qp->kern_qp.sq_buf, qp->kern_qp.sq_buf_dma_addr);
>> +
>> +	if (qp->kern_qp.rq_buf)
>> +		dma_free_coherent(
>> +			&dev->pdev->dev,
>> +			WARPPED_BUFSIZE(qp->attrs.rq_size << RQE_SHIFT),
>> +			qp->kern_qp.rq_buf, qp->kern_qp.rq_buf_dma_addr);
>> +}
>> +
>> +static int init_kernel_qp(struct erdma_dev *dev, struct erdma_qp *qp,
>> +			  struct ib_qp_init_attr *attrs)
>> +{
>> +	struct erdma_kqp *kqp = &qp->kern_qp;
>> +	int ret = -ENOMEM;
> 
> not needed. jut return -ENOMEM at the one possible
> place.
> 

Sure, will fix it.

Thanks,
Cheng Xu

>> +	int size;
>> +
>> +	if (attrs->sq_sig_type == IB_SIGNAL_ALL_WR)
>> +		kqp->sig_all = 1;
>> +
>> +	kqp->sq_pi = 0;
>> +	kqp->sq_ci = 0;
>> +	kqp->rq_pi = 0;
>> +	kqp->rq_ci = 0;
>> +	kqp->hw_sq_db =
>> +		dev->func_bar + (ERDMA_SDB_SHARED_PAGE_INDEX << PAGE_SHIFT);
>> +	kqp->hw_rq_db = dev->func_bar + ERDMA_BAR_RQDB_SPACE_OFFSET;
>> +
>> +	kqp->swr_tbl = vmalloc(qp->attrs.sq_size * sizeof(u64));
>> +	kqp->rwr_tbl = vmalloc(qp->attrs.rq_size * sizeof(u64));
>> +
>> +	size = (qp->attrs.sq_size << SQEBB_SHIFT) + ERDMA_EXTRA_BUFFER_SIZE;
>> +	kqp->sq_buf = dma_alloc_coherent(&dev->pdev->dev, size,
>> +					 &kqp->sq_buf_dma_addr, GFP_KERNEL);
>> +	if (!kqp->sq_buf)
>> +		goto err_out;
>> +
>> +	size = (qp->attrs.rq_size << RQE_SHIFT) + ERDMA_EXTRA_BUFFER_SIZE;
>> +	kqp->rq_buf = dma_alloc_coherent(&dev->pdev->dev, size,
>> +					 &kqp->rq_buf_dma_addr, GFP_KERNEL);
>> +	if (!kqp->rq_buf)
>> +		goto err_out;
>> +
>> +	kqp->sq_db_info = kqp->sq_buf + (qp->attrs.sq_size << SQEBB_SHIFT);
>> +	kqp->rq_db_info = kqp->rq_buf + (qp->attrs.rq_size << RQE_SHIFT);
>> +
>> +	return 0;
>> +
>> +err_out:
>> +	free_kernel_qp(qp);
>> +	return ret;
>> +}
>> +

<...>
