Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD592B6E26
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Nov 2020 20:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgKQTLD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Nov 2020 14:11:03 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:46734 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgKQTLD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Nov 2020 14:11:03 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHJAJ4t181401;
        Tue, 17 Nov 2020 19:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=SAUprEBsvlCQjFy54O1Y1idjlN/31+XevpP98p8fqMY=;
 b=w3gB8wAfcz/F94CTrwRG8znvibTdOVM0LVMqT83ZxODjtyeBYq91dhzwNAU94UDuJPd9
 bmjd/gIKnXBWSMQnj4BA5gH4MLALozd/U1gu97QxC0A38PFsBf+9SkxMlKm1CDNWXA/d
 ZJE+vOZkOc/kXqeBnLhMwRjPGmyQBw7PAUyYhWm8bWKXGjlnTgsJjX6s8BsoYApV/3ET
 dx8akrYCQxNhCc7ZJ9aZS+20vLKSxorRop8wFu5jXJbtMy72BDfxkS+t6kR5H/wAhidR
 EiEFtZ9i2XRWy7N+k1QWt1usTX4O6Z27OHhS/XDJzEx/TnINJS/4cHN4UQ/6zm6m2llM MA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34t4ravf45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 19:10:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHJ1USB045244;
        Tue, 17 Nov 2020 19:10:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 34ts0rakgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 19:10:46 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AHJAjUX078579;
        Tue, 17 Nov 2020 19:10:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34ts0rakg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 19:10:45 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AHJAdcr017336;
        Tue, 17 Nov 2020 19:10:39 GMT
Received: from [10.98.138.20] (/10.98.138.20)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Nov 2020 11:10:39 -0800
Subject: Re: remove dma_virt_ops v2
To:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
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
 <2f644747-4a4f-7e03-d857-c2d7879054dd@oracle.com>
 <6da0d3b0-2db7-4c7e-145a-8f76733e9978@oracle.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <f748d99e-aa4d-5f8d-debd-da2a3cd007e7@oracle.com>
Date:   Tue, 17 Nov 2020 11:10:37 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <6da0d3b0-2db7-4c7e-145a-8f76733e9978@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170138
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/17/20 2:50 AM, Ka-Cheong Poon wrote:
> On 11/13/20 1:36 AM, santosh.shilimkar@oracle.com wrote:
>> + Ka-Cheong
>>
>> On 11/12/20 5:23 AM, Jason Gunthorpe wrote:
>>> On Thu, Nov 12, 2020 at 10:40:30AM +0100, Christoph Hellwig wrote:
>>>> ping?
>>>>
>>>> On Fri, Nov 06, 2020 at 07:19:31PM +0100, Christoph Hellwig wrote:
>>>>> Hi Jason,
>>>>>
>>>>> this series switches the RDMA core to opencode the special case of
>>>>> devices bypassing the DMA mapping in the RDMA ULPs.  The virt ops
>>>>> have caused a bit of trouble due to the P2P code node working with
>>>>> them due to the fact that we'd do two dma mapping iterations for a
>>>>> single I/O, but also are a bit of layering violation and lead to
>>>>> more code than necessary.
>>>>>
>>>>> Tested with nvme-rdma over rxe.
>>>>>
>>>>> Note that the rds changes are untested, as I could not find any
>>>>> simple rds test setup.
>>>>>
>>>>> Changes since v2:
>>>>>   - simplify the INFINIBAND_VIRT_DMA dependencies
>>>>>   - add a ib_uses_virt_dma helper
>>>>>   - use ib_uses_virt_dma in nvmet-rdma to disable p2p for virt_dma 
>>>>> devices
>>>>>   - use ib_dma_max_seg_size in umem
>>>>>   - stop using dmapool in rds
>>>>>
>>>>> Changes since v1:
>>>>>   - disable software RDMA drivers for highmem configs
>>>>>   - update the PCI commit logs
>>>
>>> Santosh can you please check the RDA parts??
>>>
>>
>> Hi Ka-Cheong,
>>
>> Can you please check Christoph change [1] which clean-up
>> dma-pool API to use ib_dma_* and slab allocator ? This was added
>> as part of your "net/rds: Use DMA memory pool allocation for rds_header"
>> commit.
> 
> 
> I applied the patch and ran some basic testing.  And it seems to
> work fine.
> 
Thanks Ka-Cheong.

Jason, Feel free to add ack for the RDS part.

Regards,
Santosh


