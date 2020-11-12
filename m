Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957C62B0B62
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 18:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgKLRgx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 12:36:53 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40550 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgKLRgx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Nov 2020 12:36:53 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ACHXu2g162325;
        Thu, 12 Nov 2020 17:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=u8xTTEyvJew25Q05G3W90SnBKx46lCOhX7hkliQ7xEw=;
 b=v1pEmVs/yvU/Fn2PZBXV4Fb7dLMejTrmQc7UX1SvzAxdVcrqCkGCf7mvHMEXXYul1ml2
 KzaNwmTD3k6XT4S1yoCPvSCS17li0snVSJE7A151HvQULO3yyWzSM1l7OzeP8YwipMs/
 LCGo/UcPcoZ5tMASrtsqiFCV6BJsbcM7jcTL5j/cyBNSgIDufTXlaRTeB0RXU+v9TZUl
 cKtXkMMehXrsb0srwJzwpq7smJ0tFrSGCtbWPvJCZOnpyRA/3KI8TtxLFdCDLiFwdlyU
 nGjD/tIUGheTKC8rV99uQYDpNebMa8amCC5PODk7ebbfF7X+6WGudMW7ZwhjcWa7TqQy pg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34nkhm6nnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 17:36:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ACHZ0RG166849;
        Thu, 12 Nov 2020 17:36:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 34p5g3d4nr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 17:36:37 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0ACHaa0J172896;
        Thu, 12 Nov 2020 17:36:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34p5g3d4mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 17:36:36 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0ACHaUv0023246;
        Thu, 12 Nov 2020 17:36:31 GMT
Received: from [10.74.105.253] (/10.74.105.253)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Nov 2020 09:36:30 -0800
Subject: Re: remove dma_virt_ops v2
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20201106181941.1878556-1-hch@lst.de>
 <20201112094030.GA19550@lst.de> <20201112132353.GQ244516@ziepe.ca>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <2f644747-4a4f-7e03-d857-c2d7879054dd@oracle.com>
Date:   Thu, 12 Nov 2020 09:36:28 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201112132353.GQ244516@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120104
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

+ Ka-Cheong

On 11/12/20 5:23 AM, Jason Gunthorpe wrote:
> On Thu, Nov 12, 2020 at 10:40:30AM +0100, Christoph Hellwig wrote:
>> ping?
>>
>> On Fri, Nov 06, 2020 at 07:19:31PM +0100, Christoph Hellwig wrote:
>>> Hi Jason,
>>>
>>> this series switches the RDMA core to opencode the special case of
>>> devices bypassing the DMA mapping in the RDMA ULPs.  The virt ops
>>> have caused a bit of trouble due to the P2P code node working with
>>> them due to the fact that we'd do two dma mapping iterations for a
>>> single I/O, but also are a bit of layering violation and lead to
>>> more code than necessary.
>>>
>>> Tested with nvme-rdma over rxe.
>>>
>>> Note that the rds changes are untested, as I could not find any
>>> simple rds test setup.
>>>
>>> Changes since v2:
>>>   - simplify the INFINIBAND_VIRT_DMA dependencies
>>>   - add a ib_uses_virt_dma helper
>>>   - use ib_uses_virt_dma in nvmet-rdma to disable p2p for virt_dma devices
>>>   - use ib_dma_max_seg_size in umem
>>>   - stop using dmapool in rds
>>>
>>> Changes since v1:
>>>   - disable software RDMA drivers for highmem configs
>>>   - update the PCI commit logs
> 
> Santosh can you please check the RDA parts??
> 

Hi Ka-Cheong,

Can you please check Christoph change [1] which clean-up
dma-pool API to use ib_dma_* and slab allocator ? This was added
as part of your "net/rds: Use DMA memory pool allocation for rds_header"
commit.


Regards,
Santosh

[1] https://www.spinics.net/lists/linux-pci/msg101547.html
