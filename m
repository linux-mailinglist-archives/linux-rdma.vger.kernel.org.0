Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853422B5D4B
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Nov 2020 11:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgKQKxJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Nov 2020 05:53:09 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44644 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgKQKxI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Nov 2020 05:53:08 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHAhpBN075294;
        Tue, 17 Nov 2020 10:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=IodeTKUioP4hbL7In6IGk5dfNg6p9XSvZPTeUJHk8iQ=;
 b=G03gADzwfGRenrT8dFA0l2VmOREmlXjdG74vu4Fq3k1Hi0GKB4v+Yo0OCpL0/LREIIRK
 yW5VuvjYGg5HK85nif3NorlRM21NA/ti+hFEipEivbFulRQ9Wjbr9kqqmvdI/ujVwFFA
 zqOVSaP1pXfhPWrw8yPRKP2rCFzDjdytH7N+cVQENYZVPyNvdyntzBR6p9AZyq7t8FzR
 RM3bE6iol5VL3Yk2ZRC9z0j7r3c48Rkl+JS+t4SzPsQ+bAA55UgO483aSr2sA7XbQTJb
 tya1bTQBJ+dtoPhiJhK5xlvkltjhuJc0jY1HtbZbt2TVFrsAlu0A5keE+JVo1S85uzT/ ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34t7vn1u99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 10:52:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHAjajW150840;
        Tue, 17 Nov 2020 10:50:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 34uspt77s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 10:50:50 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AHAnRlt160283;
        Tue, 17 Nov 2020 10:50:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 34uspt77r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 10:50:49 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AHAoiFu027667;
        Tue, 17 Nov 2020 10:50:44 GMT
Received: from [10.159.144.149] (/10.159.144.149)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Nov 2020 02:50:43 -0800
Subject: Re: remove dma_virt_ops v2
To:     santosh.shilimkar@oracle.com, Jason Gunthorpe <jgg@ziepe.ca>
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
From:   Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Organization: Oracle Corporation
Message-ID: <6da0d3b0-2db7-4c7e-145a-8f76733e9978@oracle.com>
Date:   Tue, 17 Nov 2020 18:50:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2f644747-4a4f-7e03-d857-c2d7879054dd@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011170079
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/13/20 1:36 AM, santosh.shilimkar@oracle.com wrote:
> + Ka-Cheong
> 
> On 11/12/20 5:23 AM, Jason Gunthorpe wrote:
>> On Thu, Nov 12, 2020 at 10:40:30AM +0100, Christoph Hellwig wrote:
>>> ping?
>>>
>>> On Fri, Nov 06, 2020 at 07:19:31PM +0100, Christoph Hellwig wrote:
>>>> Hi Jason,
>>>>
>>>> this series switches the RDMA core to opencode the special case of
>>>> devices bypassing the DMA mapping in the RDMA ULPs.  The virt ops
>>>> have caused a bit of trouble due to the P2P code node working with
>>>> them due to the fact that we'd do two dma mapping iterations for a
>>>> single I/O, but also are a bit of layering violation and lead to
>>>> more code than necessary.
>>>>
>>>> Tested with nvme-rdma over rxe.
>>>>
>>>> Note that the rds changes are untested, as I could not find any
>>>> simple rds test setup.
>>>>
>>>> Changes since v2:
>>>>   - simplify the INFINIBAND_VIRT_DMA dependencies
>>>>   - add a ib_uses_virt_dma helper
>>>>   - use ib_uses_virt_dma in nvmet-rdma to disable p2p for virt_dma devices
>>>>   - use ib_dma_max_seg_size in umem
>>>>   - stop using dmapool in rds
>>>>
>>>> Changes since v1:
>>>>   - disable software RDMA drivers for highmem configs
>>>>   - update the PCI commit logs
>>
>> Santosh can you please check the RDA parts??
>>
> 
> Hi Ka-Cheong,
> 
> Can you please check Christoph change [1] which clean-up
> dma-pool API to use ib_dma_* and slab allocator ? This was added
> as part of your "net/rds: Use DMA memory pool allocation for rds_header"
> commit.


I applied the patch and ran some basic testing.  And it seems to
work fine.

Thanks.


-- 
K. Poon
ka-cheong.poon@oracle.com


