Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E96B7A6BD
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 13:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfG3LT0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 07:19:26 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:13094 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbfG3LT0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Jul 2019 07:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564485565; x=1596021565;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=zMf/Cloak4ww5LA6XhfAIqswVW3u05UvwTK1ZCU4y1Q=;
  b=kIhZdwJvQnZv49VWsDCMjqkIiMauhII0httHSbLn73x+WXdqg98gj0FU
   jBg0IFLu/r0bE1MokeJnqG9MTRLFnVg1UgUjR0obSQdFWegZs8nSIBzYy
   SSqzUiaoy3UG3fcd/9vKOr7XMRblHEp067LSm0Z2HRUBLvK9dGAXEt3+H
   c=;
X-IronPort-AV: E=Sophos;i="5.64,326,1559520000"; 
   d="scan'208";a="407238919"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 30 Jul 2019 11:19:23 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id 2E0A0A27A2;
        Tue, 30 Jul 2019 11:19:23 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Jul 2019 11:19:22 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.211) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Jul 2019 11:19:18 +0000
Subject: Re: [PATCH for-next 02/13] RDMA/hns: Optimize hns_roce_modify_qp
 function
To:     Lijun Ou <oulijun@huawei.com>, <dledford@redhat.com>,
        <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1564477010-29804-1-git-send-email-oulijun@huawei.com>
 <1564477010-29804-3-git-send-email-oulijun@huawei.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <0976a9fe-79a0-3d07-6d27-7ea120a6ba93@amazon.com>
Date:   Tue, 30 Jul 2019 14:19:14 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564477010-29804-3-git-send-email-oulijun@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.211]
X-ClientProxiedBy: EX13D10UWB003.ant.amazon.com (10.43.161.106) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 30/07/2019 11:56, Lijun Ou wrote:
> Here mainly packages some code into some new functions in order to
> reduce code compelexity.
> 
> Signed-off-by: Lijun Ou <oulijun@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_qp.c | 118 +++++++++++++++++++-------------
>  1 file changed, 72 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> index 35ef7e2..8b2d10f 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> @@ -1070,6 +1070,76 @@ int to_hr_qp_type(int qp_type)
>  	return transport_type;
>  }
>  
> +static int check_mtu_validate(struct hns_roce_dev *hr_dev,
> +                             struct hns_roce_qp *hr_qp,
> +                             struct ib_qp_attr *attr, int attr_mask)
> +{
> +       struct device *dev = hr_dev->dev;
> +       enum ib_mtu active_mtu;
> +       int p;
> +
> +       p = attr_mask & IB_QP_PORT ? (attr->port_num - 1) : hr_qp->port;
> +           active_mtu = iboe_get_mtu(hr_dev->iboe.netdevs[p]->mtu);
> +
> +       if ((hr_dev->caps.max_mtu >= IB_MTU_2048 &&
> +            attr->path_mtu > hr_dev->caps.max_mtu) ||
> +            attr->path_mtu < IB_MTU_256 || attr->path_mtu > active_mtu) {
> +               dev_err(dev, "attr path_mtu(%d)invalid while modify qp",
> +                       attr->path_mtu);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int hns_roce_check_qp_attr(struct ib_qp *ibqp, struct ib_qp_attr *attr,
> +                                 int attr_mask)
> +{
> +       struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
> +       struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
> +       struct device *dev = hr_dev->dev;
> +       int ret = 0;
> +       int p;
> +
> +       if ((attr_mask & IB_QP_PORT) &&
> +           (attr->port_num == 0 || attr->port_num > hr_dev->caps.num_ports)) {
> +               dev_err(dev, "attr port_num invalid.attr->port_num=%d\n",
> +                       attr->port_num);
> +               return -EINVAL;
> +       }
> +
> +       if (attr_mask & IB_QP_PKEY_INDEX) {
> +               p = attr_mask & IB_QP_PORT ? (attr->port_num - 1) : hr_qp->port;
> +               if (attr->pkey_index >= hr_dev->caps.pkey_table_len[p]) {
> +                       dev_err(dev, "attr pkey_index invalid.attr->pkey_index=%d\n",
> +                               attr->pkey_index);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       if (attr_mask & IB_QP_PATH_MTU) {
> +               ret = check_mtu_validate(hr_dev, hr_qp, attr, attr_mask);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC &&
> +           attr->max_rd_atomic > hr_dev->caps.max_qp_init_rdma) {
> +               dev_err(dev, "attr max_rd_atomic invalid.attr->max_rd_atomic=%d\n",
> +                       attr->max_rd_atomic);
> +               return -EINVAL;
> +       }
> +
> +       if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC &&
> +           attr->max_dest_rd_atomic > hr_dev->caps.max_qp_dest_rdma) {
> +               dev_err(dev, "attr max_dest_rd_atomic invalid.attr->max_dest_rd_atomic=%d\n",
> +                       attr->max_dest_rd_atomic);
> +               return -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
>  int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>  		       int attr_mask, struct ib_udata *udata)
>  {
> @@ -1078,8 +1148,6 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>  	enum ib_qp_state cur_state, new_state;
>  	struct device *dev = hr_dev->dev;
>  	int ret = -EINVAL;
> -	int p;
> -	enum ib_mtu active_mtu;
>  
>  	mutex_lock(&hr_qp->mutex);
>  
> @@ -1107,51 +1175,9 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>  		goto out;
>  	}
>  
> -	if ((attr_mask & IB_QP_PORT) &&
> -	    (attr->port_num == 0 || attr->port_num > hr_dev->caps.num_ports)) {
> -		dev_err(dev, "attr port_num invalid.attr->port_num=%d\n",
> -			attr->port_num);
> -		goto out;
> -	}
> -
> -	if (attr_mask & IB_QP_PKEY_INDEX) {
> -		p = attr_mask & IB_QP_PORT ? (attr->port_num - 1) : hr_qp->port;
> -		if (attr->pkey_index >= hr_dev->caps.pkey_table_len[p]) {
> -			dev_err(dev, "attr pkey_index invalid.attr->pkey_index=%d\n",
> -				attr->pkey_index);
> -			goto out;
> -		}
> -	}
> -
> -	if (attr_mask & IB_QP_PATH_MTU) {
> -		p = attr_mask & IB_QP_PORT ? (attr->port_num - 1) : hr_qp->port;
> -		active_mtu = iboe_get_mtu(hr_dev->iboe.netdevs[p]->mtu);
> -
> -		if ((hr_dev->caps.max_mtu == IB_MTU_4096 &&
> -		    attr->path_mtu > IB_MTU_4096) ||
> -		    (hr_dev->caps.max_mtu == IB_MTU_2048 &&
> -		    attr->path_mtu > IB_MTU_2048) ||
> -		    attr->path_mtu < IB_MTU_256 ||
> -		    attr->path_mtu > active_mtu) {
> -			dev_err(dev, "attr path_mtu(%d)invalid while modify qp",
> -				attr->path_mtu);
> -			goto out;
> -		}
> -	}
> -
> -	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC &&
> -	    attr->max_rd_atomic > hr_dev->caps.max_qp_init_rdma) {
> -		dev_err(dev, "attr max_rd_atomic invalid.attr->max_rd_atomic=%d\n",
> -			attr->max_rd_atomic);
> -		goto out;
> -	}
> -
> -	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC &&
> -	    attr->max_dest_rd_atomic > hr_dev->caps.max_qp_dest_rdma) {
> -		dev_err(dev, "attr max_dest_rd_atomic invalid.attr->max_dest_rd_atomic=%d\n",
> -			attr->max_dest_rd_atomic);
> +	ret = hns_roce_check_qp_attr(ibqp, attr, attr_mask);
> +	if (ret)
>  		goto out;
> -	}
>  
>  	if (cur_state == new_state && cur_state == IB_QPS_RESET) {
>  		if (hr_dev->caps.min_wqes) {
> 

This patch is formatted with spaces instead of tabs.
