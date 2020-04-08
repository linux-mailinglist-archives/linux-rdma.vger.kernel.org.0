Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF011A1C70
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Apr 2020 09:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgDHHSA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Apr 2020 03:18:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725932AbgDHHSA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Apr 2020 03:18:00 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03873ubo146245
        for <linux-rdma@vger.kernel.org>; Wed, 8 Apr 2020 03:17:59 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30920raqhc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 08 Apr 2020 03:17:59 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Wed, 8 Apr 2020 08:17:29 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Apr 2020 08:17:27 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0387GnBP49480130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Apr 2020 07:16:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 484CFA405D;
        Wed,  8 Apr 2020 07:17:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24FB3A4057;
        Wed,  8 Apr 2020 07:17:54 +0000 (GMT)
Received: from oc5311105230.ibm.com (unknown [9.145.4.110])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Apr 2020 07:17:54 +0000 (GMT)
Subject: Re: [PATCH] RDMA: Remove a few extra calls to ib_get_client_data()
To:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Karsten Graul <kgraul@linux.ibm.com>
References: <0-v1-fae83f600b4a+68-less_get_client_data%jgg@mellanox.com>
From:   Ursula Braun <ubraun@linux.ibm.com>
Date:   Wed, 8 Apr 2020 09:17:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <0-v1-fae83f600b4a+68-less_get_client_data%jgg@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20040807-0020-0000-0000-000003C3CE86
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040807-0021-0000-0000-0000221C90B2
Message-Id: <91b0c86a-10d2-0427-eda9-39c1bf820ff5@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_10:2020-04-07,2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004080052
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 4/8/20 1:20 AM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> These four places already have easy access to the client data, just use
> that instead.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/core/sa_query.c    | 15 ++++++---------
>  drivers/infiniband/core/user_mad.c    |  3 +--
>  drivers/infiniband/ulp/srpt/ib_srpt.c |  7 ++-----
>  net/smc/smc_ib.c                      |  3 +--
>  4 files changed, 10 insertions(+), 18 deletions(-)
> 

For the net/smc part:
Acked-by: Ursula Braun <ubraun@linux.ibm.com>

