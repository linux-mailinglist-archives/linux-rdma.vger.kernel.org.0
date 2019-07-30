Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23B177A9DA
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 15:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfG3NjZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 09:39:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51022 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbfG3NjZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jul 2019 09:39:25 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 26ABF144215BD9A59540;
        Tue, 30 Jul 2019 21:39:22 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Tue, 30 Jul 2019
 21:39:15 +0800
Subject: Re: [PATCH for-next 02/13] RDMA/hns: Optimize hns_roce_modify_qp
 function
To:     Gal Pressman <galpress@amazon.com>, <dledford@redhat.com>,
        <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1564477010-29804-1-git-send-email-oulijun@huawei.com>
 <1564477010-29804-3-git-send-email-oulijun@huawei.com>
 <0976a9fe-79a0-3d07-6d27-7ea120a6ba93@amazon.com>
From:   oulijun <oulijun@huawei.com>
Message-ID: <07c8393b-76d7-c4c9-2f4e-59c8106667b8@huawei.com>
Date:   Tue, 30 Jul 2019 21:39:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <0976a9fe-79a0-3d07-6d27-7ea120a6ba93@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2019/7/30 19:19, Gal Pressman 写道:
> On 30/07/2019 11:56, Lijun Ou wrote:
>> Here mainly packages some code into some new functions in order to
>> reduce code compelexity.
>>
>> Signed-off-by: Lijun Ou <oulijun@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_qp.c | 118 +++++++++++++++++++-------------
>>  1 file changed, 72 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
>> index 35ef7e2..8b2d10f 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
>> @@ -1070,6 +1070,76 @@ int to_hr_qp_type(int qp_type)
>>  	return transport_type;
>>  }
>>  
>> +static int check_mtu_validate(struct hns_roce_dev *hr_dev,
>> +                             struct hns_roce_qp *hr_qp,
>> +                             struct ib_qp_attr *attr, int attr_mask)
>> +{
>> +       struct device *dev = hr_dev->dev;
>> +       enum ib_mtu active_mtu;
>> +       int p;
>> +
>> +       p = attr_mask & IB_QP_PORT ? (attr->port_num - 1) : hr_qp->port;
>> +           active_mtu = iboe_get_mtu(hr_dev->iboe.netdevs[p]->mtu);
>> +
>> +       if ((hr_dev->caps.max_mtu >= IB_MTU_2048 &&
>> +            attr->path_mtu > hr_dev->caps.max_mtu) ||
>> +            attr->path_mtu < IB_MTU_256 || attr->path_mtu > active_mtu) {
>> +               dev_err(dev, "attr path_mtu(%d)invalid while modify qp",
>> +                       attr->path_mtu);
>> +               return -EINVAL;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int hns_roce_check_qp_attr(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>> +                                 int attr_mask)
>> +{
>> +       struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
>> +       struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
>> +       struct device *dev = hr_dev->dev;
>> +       int ret = 0;
>> +       int p;
>> +
>> +       if ((attr_mask & IB_QP_PORT) &&
>> +           (attr->port_num == 0 || attr->port_num > hr_dev->caps.num_ports)) {
>> +               dev_err(dev, "attr port_num invalid.attr->port_num=%d\n",
>> +                       attr->port_num);
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (attr_mask & IB_QP_PKEY_INDEX) {
>> +               p = attr_mask & IB_QP_PORT ? (attr->port_num - 1) : hr_qp->port;
>> +               if (attr->pkey_index >= hr_dev->caps.pkey_table_len[p]) {
>> +                       dev_err(dev, "attr pkey_index invalid.attr->pkey_index=%d\n",
>> +                               attr->pkey_index);
>> +                       return -EINVAL;
>> +               }
>> +       }
>> +
>> +       if (attr_mask & IB_QP_PATH_MTU) {
>> +               ret = check_mtu_validate(hr_dev, hr_qp, attr, attr_mask);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC &&
>> +           attr->max_rd_atomic > hr_dev->caps.max_qp_init_rdma) {
>> +               dev_err(dev, "attr max_rd_atomic invalid.attr->max_rd_atomic=%d\n",
>> +                       attr->max_rd_atomic);
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC &&
>> +           attr->max_dest_rd_atomic > hr_dev->caps.max_qp_dest_rdma) {
>> +               dev_err(dev, "attr max_dest_rd_atomic invalid.attr->max_dest_rd_atomic=%d\n",
>> +                       attr->max_dest_rd_atomic);
>> +               return -EINVAL;
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>>  int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>>  		       int attr_mask, struct ib_udata *udata)
>>  {
>> @@ -1078,8 +1148,6 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>>  	enum ib_qp_state cur_state, new_state;
>>  	struct device *dev = hr_dev->dev;
>>  	int ret = -EINVAL;
>> -	int p;
>> -	enum ib_mtu active_mtu;
>>  
>>  	mutex_lock(&hr_qp->mutex);
>>  
>> @@ -1107,51 +1175,9 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>>  		goto out;
>>  	}
>>  
>> -	if ((attr_mask & IB_QP_PORT) &&
>> -	    (attr->port_num == 0 || attr->port_num > hr_dev->caps.num_ports)) {
>> -		dev_err(dev, "attr port_num invalid.attr->port_num=%d\n",
>> -			attr->port_num);
>> -		goto out;
>> -	}
>> -
>> -	if (attr_mask & IB_QP_PKEY_INDEX) {
>> -		p = attr_mask & IB_QP_PORT ? (attr->port_num - 1) : hr_qp->port;
>> -		if (attr->pkey_index >= hr_dev->caps.pkey_table_len[p]) {
>> -			dev_err(dev, "attr pkey_index invalid.attr->pkey_index=%d\n",
>> -				attr->pkey_index);
>> -			goto out;
>> -		}
>> -	}
>> -
>> -	if (attr_mask & IB_QP_PATH_MTU) {
>> -		p = attr_mask & IB_QP_PORT ? (attr->port_num - 1) : hr_qp->port;
>> -		active_mtu = iboe_get_mtu(hr_dev->iboe.netdevs[p]->mtu);
>> -
>> -		if ((hr_dev->caps.max_mtu == IB_MTU_4096 &&
>> -		    attr->path_mtu > IB_MTU_4096) ||
>> -		    (hr_dev->caps.max_mtu == IB_MTU_2048 &&
>> -		    attr->path_mtu > IB_MTU_2048) ||
>> -		    attr->path_mtu < IB_MTU_256 ||
>> -		    attr->path_mtu > active_mtu) {
>> -			dev_err(dev, "attr path_mtu(%d)invalid while modify qp",
>> -				attr->path_mtu);
>> -			goto out;
>> -		}
>> -	}
>> -
>> -	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC &&
>> -	    attr->max_rd_atomic > hr_dev->caps.max_qp_init_rdma) {
>> -		dev_err(dev, "attr max_rd_atomic invalid.attr->max_rd_atomic=%d\n",
>> -			attr->max_rd_atomic);
>> -		goto out;
>> -	}
>> -
>> -	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC &&
>> -	    attr->max_dest_rd_atomic > hr_dev->caps.max_qp_dest_rdma) {
>> -		dev_err(dev, "attr max_dest_rd_atomic invalid.attr->max_dest_rd_atomic=%d\n",
>> -			attr->max_dest_rd_atomic);
>> +	ret = hns_roce_check_qp_attr(ibqp, attr, attr_mask);
>> +	if (ret)
>>  		goto out;
>> -	}
>>  
>>  	if (cur_state == new_state && cur_state == IB_QPS_RESET) {
>>  		if (hr_dev->caps.min_wqes) {
>>
> This patch is formatted with spaces instead of tabs.
>
> .
Thanks. This is may careless when generated from local branch. the checkpatch seem to not checked.
I will fix it.



