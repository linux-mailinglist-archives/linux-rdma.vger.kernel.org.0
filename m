Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1621247BBB5
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Dec 2021 09:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbhLUIUl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Dec 2021 03:20:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64122 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232095AbhLUIUl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Dec 2021 03:20:41 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BL60FqL022017;
        Tue, 21 Dec 2021 08:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=RenRZssf2KCytKv07QRtYPlaluR9QVt9zQP/NsyBgRQ=;
 b=SIMEBiGUizarG2o4Hm1LMNz3dXq15gsC97MFv5hz67lw+4/FjI/OcsALW+kWmukWGnfl
 9t0yZdCZ/Dl5gkHQgdrzUl844j85yBTrHD4AWb6YD22vPJ04ZzKUg5iRMOMmtwLZ+2ki
 klKBnCDWSCpjUgBtZ3Z2t2VlIVHDs8PvqC2JKNw7J0HHz3wIQqC5UdONZ08wimmq38UT
 tx3AYuaXj+f4ipSmyJHBFqRvJKhvo2Hwmru2++yqF1TH9t3a4WHtL1d51hOdUenl+z34
 P3nsY4M6oRG583oBVrwBUyOSRxLYh31RVIJ2hq5vFeb962sfnbs9asrV6Z237jGH3H3/ 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d1skeyg5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 08:20:31 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BL80LWp004709;
        Tue, 21 Dec 2021 08:20:31 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d1skeyg5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 08:20:31 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BL8DtVv013890;
        Tue, 21 Dec 2021 08:20:29 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3d179abcg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 08:20:29 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BL8KRWX46465476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 08:20:27 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11A87A406B;
        Tue, 21 Dec 2021 08:20:27 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B373AA4040;
        Tue, 21 Dec 2021 08:20:26 +0000 (GMT)
Received: from [9.145.22.105] (unknown [9.145.22.105])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Dec 2021 08:20:26 +0000 (GMT)
Message-ID: <8b764027-4f25-e27d-15f9-7466343cf845@linux.ibm.com>
Date:   Tue, 21 Dec 2021 09:20:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: RDMA/mlx5: Regression since v5.15-rc5: Kernel panic when called
 ib_dereg_mr
Content-Language: en-US
To:     Tony Lu <tonylu@linux.alibaba.com>, Alaa Hleihel <alaa@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org
References: <9974ea8c-f1cb-aeb4-cf1b-19d37536894a@linux.alibaba.com>
From:   Karsten Graul <kgraul@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <9974ea8c-f1cb-aeb4-cf1b-19d37536894a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: usRa3B-qsvIiu25JMjx7XVX-YiC-EglF
X-Proofpoint-GUID: aGLHj78_sEiMICPbhkc6mqJOAKLcN2oI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_02,2021-12-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 clxscore=1011 mlxscore=0 malwarescore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=729
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210034
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 21/12/2021 09:04, Tony Lu wrote:
> Hello,
> 
> During developing and testing of SMC (net/smc), We found a problem,
> when SMC released linkgroup or link, it called ib_dereg_mr to release
> resources, then it panicked in mlx5_ib_dereg_mr. After investigation,
> we found this panic was introduce by this commit:
> 
>     f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow")

+1, this panic in our environment:

[  380.055202] smc: SMC-R lg 00000200 link removed: id 00000201, peerid 00000101, ibdev mlx5_0, ibport 1
[  380.055230] smc: SMC-R lg 00000100 state changed: SINGLE, pnetid NET10           
[  380.055605] Unable to handle kernel pointer dereference in virtual kernel address space
[  380.055607] Failing address: 7563745f64657000 TEID: 7563745f64657803
[  380.055609] Fault in home space mode while using kernel ASCE.
[  380.055613] AS:0000000124abc007 R3:0000000000000024 
[  380.055650] Oops: 0038 ilc:3 [#1] SMP 
[  380.055655] Modules linked in: dummy smc_diag smc tcp_diag ...
[  380.055698] CPU: 2 PID: 21939 Comm: kworker/2:22 Not tainted 5.16.0-20211220.rc5.git0.c4a510cd6ab8.300.fc35.s390x #1
[  380.055700] Hardware name: IBM 8561 T01 701 (z/VM 7.2.0)
[  380.055702] Workqueue: events smc_link_down_work [smc]
[  380.055717] Krnl PSW : 0704e00180000000 000000012311abbc (dma_unmap_sg_attrs+0x1c/0x68)
[  380.055729]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
[  380.055732] Krnl GPRS: 0000000000000018 000000012311aba0 7563745f64657461 000000010232f003
[  380.055735]            0000000002330003 0000000000000000 0000000000000000 0000000000000000
[  380.055738]            0000000000000000 000000008fe64000 0000000084cd6000 000000008fe64000
[  380.055740]            0000000035244200 00000000b669c248 000003800a077a68 000003800a077a10
[  380.055748] Krnl Code: 000000012311abac: b90400ef		lgr	%r14,%r15
                          000000012311abb0: e3f0ffa8ff71	lay	%r15,-88(%r15)
                         #000000012311abb6: e3e0f0980024	stg	%r14,152(%r15)
                         >000000012311abbc: e3b021300002	ltg	%r11,304(%r2)
                          000000012311abc2: a7840013		brc	8,000000012311abe8
                          000000012311abc6: ec52001d027f	clij	%r5,2,2,000000012311ac00
                          000000012311abcc: e310b0580002	ltg	%r1,88(%r11)
                          000000012311abd2: a7840005		brc	8,000000012311abdc
[  380.055775] Call Trace:
[  380.055777]  [<000000012311abbc>] dma_unmap_sg_attrs+0x1c/0x68 
[  380.055780]  [<000003ff80560bd2>] __ib_umem_release+0xc2/0xd8 [ib_uverbs] 
[  380.055797]  [<000003ff805610a6>] ib_umem_release+0x4e/0xe0 [ib_uverbs] 
[  380.055806]  [<000003ff804fe7ca>] mlx5_ib_dereg_mr.localalias+0x212/0x480 [mlx5_ib] 
[  380.055830]  [<000003ff803a0ddc>] ib_dereg_mr_user+0x5c/0xe0 [ib_core] 
[  380.055878]  [<000003ff806c249c>] smcr_buf_unmap_link+0x64/0xe0 [smc] 
[  380.055887]  [<000003ff806c2cb2>] smcr_link_clear.part.0+0x72/0x230 [smc] 
[  380.055896]  [<000003ff806c6364>] smcr_link_down+0xc4/0x1b8 [smc] 
[  380.055902]  [<000003ff806c64be>] smc_link_down_work+0x66/0x88 [smc] 
[  380.055909]  [<00000001230a2b02>] process_one_work+0x1fa/0x470 
[  380.055913]  [<00000001230a32a4>] worker_thread+0x64/0x498 
[  380.055915]  [<00000001230aaf5c>] kthread+0x17c/0x188 
[  380.055919]  [<00000001230333c4>] __ret_from_fork+0x3c/0x58 
[  380.055922]  [<0000000123bc46ba>] ret_from_fork+0xa/0x40 
[  380.055927] Last Breaking-Event-Address:
[  380.055929]  [<000003ff8054e2a8>] 0x3ff8054e2a8
[  380.055940] Kernel panic - not syncing: Fatal exception: panic_on_oops
