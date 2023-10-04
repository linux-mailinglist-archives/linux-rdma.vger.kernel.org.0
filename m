Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18FC7B7F61
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Oct 2023 14:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242382AbjJDMlQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Oct 2023 08:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242348AbjJDMlP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Oct 2023 08:41:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C78093;
        Wed,  4 Oct 2023 05:41:12 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394Ccfa7024330;
        Wed, 4 Oct 2023 12:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=jO02TTI3icp5GqFKY5HubwwOJO/kC+XyhSo02aR3Ghw=;
 b=JNGqbCvMZqnn26nJz8qP24+O7T77aViOf+JBwsVfgNP8Dq2dT2X4CYJoBUOmu2WXfpgP
 yPgk8x+BJZABdTqZN8aE/e0ZKZDWRNqWm00AW/AvSs0kueFHj7q2jUK9A7AYyLwEdAI/
 WZaOenAsOToKFCHbUaG1A2qPnIF8opV082la71vA+QUIMQ+YrdGaOetsXDLMZZoDCuOW
 mc7IFMirnTGRJ3LLB2U4I8XMIMKXQvReDc2qO7Sw77LRvzqLIw/bjKjYPgyZsvnOj9yY
 gNDqJF2d3PgL8pJk/7gPkRlonf+ibKFFT7X60kvKbQEDSC0xdPpUpvvK54fu9jTJxbyp wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3th81jga3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 12:40:55 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 394Cd8Lp025844;
        Wed, 4 Oct 2023 12:40:54 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3th81jga31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 12:40:54 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 394BQADw006698;
        Wed, 4 Oct 2023 12:40:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tf07k3x6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 12:40:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 394Ceoso58982678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Oct 2023 12:40:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFE4D20063;
        Wed,  4 Oct 2023 12:40:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B8512006E;
        Wed,  4 Oct 2023 12:40:49 +0000 (GMT)
Received: from [9.171.77.142] (unknown [9.171.77.142])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  4 Oct 2023 12:40:49 +0000 (GMT)
Message-ID: <1acfaaf12d1d24aa255a4da80882f8e0e98d2046.camel@linux.ibm.com>
Subject: Re: [PATCH net v2] net/mlx5: fix calling mlx5_cmd_init() before DMA
 mask is set
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Leon Romanovsky <leon@kernel.org>, Joerg Roedel <joro@8bytes.org>
Cc:     Saeed Mahameed <saeedm@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shay Drory <shayd@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 04 Oct 2023 14:40:49 +0200
In-Reply-To: <20230930073633.GC1296942@unreal>
References: <20230929-mlx5_init_fix-v2-1-51ed2094c9d8@linux.ibm.com>
         <20230930073633.GC1296942@unreal>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ytJsdJUWEbLsY5TOFmUdtwCz_osZ52Yj
X-Proofpoint-ORIG-GUID: fLe6_epYdhPrIGVqShq5OY1MPF1KtZTV
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_04,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040091
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, 2023-09-30 at 10:36 +0300, Leon Romanovsky wrote:
> On Fri, Sep 29, 2023 at 02:15:49PM +0200, Niklas Schnelle wrote:
> > Since commit 06cd555f73ca ("net/mlx5: split mlx5_cmd_init() to probe and
> > reload routines") mlx5_cmd_init() is called in mlx5_mdev_init() which is
> > called in probe_one() before mlx5_pci_init(). This is a problem because
> > mlx5_pci_init() is where the DMA and coherent mask is set but
> > mlx5_cmd_init() already does a dma_alloc_coherent(). Thus a DMA
> > allocation is done during probe before the correct mask is set. This
> > causes probe to fail initialization of the cmdif SW structs on s390x
> > after that is converted to the common dma-iommu code. This is because on
> > s390x DMA addresses below 4 GiB are reserved on current machines and
> > unlike the old s390x specific DMA API implementation common code
> > enforces DMA masks.
> >=20
> > Fix this by moving set_dma_caps() out of mlx5_pci_init() and into
> > probe_one() before mlx5_mdev_init(). To match the overall naming scheme
> > rename it to mlx5_dma_init().
> >=20
> > Link: https://lore.kernel.org/linux-iommu/cfc9e9128ed5571d2e36421e34730=
1057662a09e.camel@linux.ibm.com/
> > Fixes: 06cd555f73ca ("net/mlx5: split mlx5_cmd_init() to probe and relo=
ad routines")
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> > Note: I ran into this while testing the linked series for converting
> > s390x to use dma-iommu. The existing s390x specific DMA API
> > implementation doesn't respect DMA masks and is thus not affected
> > despite of course also only supporting DMA addresses above 4 GiB.
> > ---
> > Changes in v2:
> > - Instead of moving the whole mlx5_pci_init() only move the
> >   set_dma_caps() call so as to keep pci_enable_device() after the FW
> >   command interface initialization (Leon)
> > - Link to v1: https://lore.kernel.org/r/20230928-mlx5_init_fix-v1-1-797=
49d45ce60@linux.ibm.com
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/main.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >=20
>=20
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

Thank you for the review. Assuming the mlx5 tree is included in linux-
next I think it would be easiest if this goes via that tree thereby
unbreaking linux-next for s390. Or do you prefer Joerg to take this via
the IOMMU tree or even some other tree?

Thanks,
Niklas
