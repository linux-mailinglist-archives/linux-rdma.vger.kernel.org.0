Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98B41FBBDC
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 18:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgFPQfv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 12:35:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54012 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbgFPQfu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jun 2020 12:35:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05GGQrx9089581;
        Tue, 16 Jun 2020 16:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ip4b+FZyoDVVIBKT0t/xWD91viY5gnfYLTwg/R5nzJM=;
 b=DsphQnoHJ9q7/x+tiaqJCw6V290Lur0ot6eNIAd9oNquv4RGiNRrEtWqLlgWZ1Gv7c0V
 0FJj6M+EBZ57cOOsjJ0A9DAqh1ZXEhj/2qffevrUjajjm+yL19EHjVK2C7Eg8ypusSv2
 Wq60Bvnd25kRjjOnhG3SvJ/ojwagVodIj18zCLcC3ygAQFP/BlEDNLBZvg6+xKmpCbZC
 f5GO981/GWWNMB//Bo7LOZEAvMOTsRciBr8AGI5S3965W/V4REXtnibz+p+sWqrBWfFv
 h+Flnt/jiqqydGpcTcvBYqP4mD3tiWyxvQo3ZMWz5L4INCVCGsaFK4Syi2C7q6cySaBw rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 31p6e7yvte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Jun 2020 16:35:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05GGT5Aw016512;
        Tue, 16 Jun 2020 16:35:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 31p6s7fmc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jun 2020 16:35:42 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05GGZf1R026320;
        Tue, 16 Jun 2020 16:35:41 GMT
Received: from ib0.gerd.us.oracle.com (/10.211.52.79)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jun 2020 09:35:40 -0700
Subject: Re: [PATCH 2.6.26-4.14] IB/ipoib: Arm "send_cq" to process
 completions in due time
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Doug Ledford <dledford@redhat.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Hal Rosenstock <hal.rosenstock@gmail.com>,
        linux-rdma@vger.kernel.org
References: <322533b0-17de-b6b2-7da4-f99c7dfce3a8@oracle.com>
 <20200612195511.GA6578@ziepe.ca>
 <631c9e79-34e8-cc89-99bc-11fd6bc929e4@oracle.com>
 <20200616120847.GB3542686@kroah.com>
From:   Gerd Rausch <gerd.rausch@oracle.com>
Message-ID: <16760723-e9ac-88b7-0b95-170e43abee2b@oracle.com>
Date:   Tue, 16 Jun 2020 09:35:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200616120847.GB3542686@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9654 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006160117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9654 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 cotscore=-2147483648 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006160117
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

On 16/06/2020 05.08, Greg Kroah-Hartman wrote:
>> I considered backporting commit 8966e28d2e40c ("IB/ipoib: Use NAPI in UD/TX flows")
>> with all the dependencies it may have a considerably higher risk
>> than just arming the TX CQ.
> 
> 90% of the time when we apply a patch that does NOT match the upstream
> tree, it has a bug in it and needs to have another fix or something
> else.
> 
> So please, if at all possible, stick to the upstream tree, so
> backporting the current patches are the best thing to do.
> 

Jason,

With Mellanox writing and fixing the vast majority of the code found
in IB/IPoIB, do you or one of your colleagues want to look into this?

It would be considerably less error-prone if the authors of that code
did that more risky work of backporting.

AFAIK, Mellanox also has the regression tests to ensure that everything
still works after this re-write as it did before.

Thanks,

 Gerd

