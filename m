Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89852F5CB8
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jan 2021 09:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbhANI73 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jan 2021 03:59:29 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:44775 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726806AbhANI73 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jan 2021 03:59:29 -0500
X-IronPort-AV: E=Sophos;i="5.79,346,1602518400"; 
   d="scan'208";a="103475119"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Jan 2021 16:58:37 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id BAA094CE602D;
        Thu, 14 Jan 2021 16:58:33 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 14 Jan 2021 16:58:31 +0800
Message-ID: <600007B6.1070606@cn.fujitsu.com>
Date:   Thu, 14 Jan 2021 16:58:30 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Yishai Hadas <yishaih@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <leon@kernel.org>
Subject: Re: [PATCH 1/2] RDMA/uverbs: Don't set rcq if qp_type is IB_QPT_XRC_INI
References: <20201216071755.149449-1-yangx.jy@cn.fujitsu.com> <20210112200925.GA20208@nvidia.com>
In-Reply-To: <20210112200925.GA20208@nvidia.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: BAA094CE602D.AAA61
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/1/13 4:09, Jason Gunthorpe wrote:
> On Wed, Dec 16, 2020 at 03:17:54PM +0800, Xiao Yang wrote:
>> INI QP doesn't require receive CQ.
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>>   drivers/infiniband/core/uverbs_cmd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
>> index 418d133a8fb0..d8bc8ea3ad1e 100644
>> +++ b/drivers/infiniband/core/uverbs_cmd.c
>> @@ -1345,7 +1345,7 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
>>   		if (has_sq)
>>   			scq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ,
>>   						cmd->send_cq_handle, attrs);
>> -		if (!ind_tbl)
>> +		if (!ind_tbl&&  cmd->qp_type != IB_QPT_XRC_INI)
>>   			rcq = rcq ?: scq;
> Hmm, this does make it consistent with the UVERBS_METHOD_QP_CREATE
> flow which does set attr.recv_cq to NULL if the user didn't specify one.
>
> However this has been like this since the beginning - what are you
> doing that this detail matters?
Hi Jason,

Thanks for your comment.
1) I didn't get any issue for now.
2) I think it is not meaningful to set rcq for XRC INITIATOR QP, current 
code has ignores rcq as below:
-------------------------------------------------
static int create_qp(struct uverbs_attr_bundle *attrs,
                     struct ib_uverbs_ex_create_qp *cmd)
...
                 if (cmd->qp_type == IB_QPT_XRC_INI) {
                         cmd->max_recv_wr = 0;
                         cmd->max_recv_sge = 0;
...
-------------------------------------------------

By the way, I have a question:
Why do we need two kinds of uverbs API?(a: read & write, b: ioctl)

Best Regards,
Xiao Yang
> Jason
>
>
> .
>



