Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DC27C6B94
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Oct 2023 12:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbjJLKyG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Oct 2023 06:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbjJLKyG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Oct 2023 06:54:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5C494;
        Thu, 12 Oct 2023 03:54:04 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CAlNnF007306;
        Thu, 12 Oct 2023 10:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=CZTYGOLITZz/5HSutlowApvi7I/NVLgN/RMhkr0VPug=;
 b=YA236edX0Xp7Q3ZSGlukmoukSXzLRk4gBJTsJlHpQo2t1io7WxhISc+IhSmD6axoFNC/
 aTNrxG77z3Ra0nVxF7X8Is/dITfCoaKIgnVIMaQFaHissaarATLAB2pMZi8WBpr+Q8JJ
 an97uIUv5DCY9rr1d9v4nhQ3FLI4RC8k1ffeJsKNZc7/sxQOUIUh4QvEBRAoTrQlSDvD
 KFfOYewU6GdZ2K2ip+p5ZskI7BO6tDTxbnbQeNPyNOqp65bhAPBGftMYAN/3GC6bpgLI
 aUx+1PkOXPd159NzepjwhU5pboLpMLG5to1ZFDG3I/YdVDAIxKt6ck2hcZCxpDP5ay0t Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpfbr05sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 10:53:46 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CAmbll010719;
        Thu, 12 Oct 2023 10:53:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpfbr05rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 10:53:46 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39CAVCL2000640;
        Thu, 12 Oct 2023 10:53:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkk5kxraq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 10:53:44 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39CArdEX20185690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 10:53:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA94820043;
        Thu, 12 Oct 2023 10:53:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 799A220040;
        Thu, 12 Oct 2023 10:53:38 +0000 (GMT)
Received: from [9.171.78.5] (unknown [9.171.78.5])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 12 Oct 2023 10:53:38 +0000 (GMT)
Message-ID: <5e7ec86d690ec5337052742ca75ad2ade23f291e.camel@linux.ibm.com>
Subject: Re: [PATCH net v3] net/mlx5: fix calling mlx5_cmd_init() before DMA
 mask is set
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shay Drory <shayd@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>
Date:   Thu, 12 Oct 2023 12:53:38 +0200
In-Reply-To: <ZSbvxeLKS8zHltdg@x130>
References: <20231011-mlx5_init_fix-v3-1-787ffb9183c6@linux.ibm.com>
         <ZSbnUlJT1u3xUIqY@x130> <ZSbvxeLKS8zHltdg@x130>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kRd3oGJK6y8N7MPlgAvIihFPuil2K1C6
X-Proofpoint-GUID: LC3xu5ymSIwgc6Rq_1QRO0UnRdoy9rGg
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 clxscore=1011 adultscore=0 mlxscore=0
 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 2023-10-11 at 11:56 -0700, Saeed Mahameed wrote:
> On 11 Oct 11:20, Saeed Mahameed wrote:
> > On 11 Oct 09:57, Niklas Schnelle wrote:
> > > Since commit 06cd555f73ca ("net/mlx5: split mlx5_cmd_init() to probe =
and
> > > reload routines") mlx5_cmd_init() is called in mlx5_mdev_init() which=
 is
> > > called in probe_one() before mlx5_pci_init(). This is a problem becau=
se
> > > mlx5_pci_init() is where the DMA and coherent mask is set but
> > > mlx5_cmd_init() already does a dma_alloc_coherent(). Thus a DMA
> > > allocation is done during probe before the correct mask is set. This
> > > causes probe to fail initialization of the cmdif SW structs on s390x
> > > after that is converted to the common dma-iommu code. This is because=
 on
> > > s390x DMA addresses below 4 GiB are reserved on current machines and
> > > unlike the old s390x specific DMA API implementation common code
> > > enforces DMA masks.
> > >=20
> > > Fix this by moving set_dma_caps() out of mlx5_pci_init() and into
> > > probe_one() before mlx5_mdev_init(). To match the overall naming sche=
me
> > > rename it to mlx5_dma_init().
> >=20
> > How about we just call mlx5_pci_init() before mlx5_mdev_init(), instead=
 of
> > breaking it apart ?
>=20
> I just posted this RFC patch [1]:

This patch works to solve the problem as well.

>=20
> I am working in very limited conditions these days, and I don't have stro=
ng
> opinion on which approach to take, Leon, Niklas, please advise.
>=20
> The three possible solutions:
>=20
> 1) mlx5_pci_init() before mlx5_mdev_init(), I don't think enabling pci
> before initializing cmd dma would be a problem.
>=20
> 2) This patch.
>=20
> 3) Shay's patch from the link below:
> [1] https://patchwork.kernel.org/project/netdevbpf/patch/20231011184511.1=
9818-1-saeed@kernel.org/
>=20
> Thanks,
> Saeed.

My first gut feeling was option 1) but I'm just as happy with 2) or 3).
For me option 2 is the least invasive but not by much.

For me the important thing is what Jason also said yesterday. We need
to merge something now to unbreak linux-next on s390x and to make sure
we don't end up with a broken v6.7-rc1. This is already hampering our
CI tests with linux-next. So let's do whatever can be merged the
quickest and then feel free to do any refactoring ideas that this
discussion might have spawned on top of that. My guess for this
criteria would be 2).

Thanks,
Niklas

