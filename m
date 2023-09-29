Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780B37B2F67
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Sep 2023 11:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjI2JlO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Sep 2023 05:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjI2JlO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Sep 2023 05:41:14 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5EC195;
        Fri, 29 Sep 2023 02:41:11 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38T9c38j002754;
        Fri, 29 Sep 2023 09:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=oCxKnzYlsMfJhJv/zyyguXO3VITu+6l3qEKVULc67VA=;
 b=oTzvBUpvrK4PkywioTtx7FMhIdMV9JsdUHjg4dJBIifeUNUqzf+Xf3/TZ1l2pIaJTxF0
 kUuJ1DQ9K1TZMeg/OBJywXQ26XL+fMttGAH7BL1pAgzfoJUVfYkY6TLVDnvdxtqvNBm9
 0lalLqL8GvJj8WfWZfqjTGG/JfcMx6vtRNJJd/qcdzDSv7h99eSNUCNJdavpYiMrV+0f
 6Ki4NcjN1QrOzIb+lN11Zw6EPOUYaAA2GLhECWIHdNccp4D/2XBcAFxN6Tz+unrSGFIw
 ywgul8mojrq4R2FP0c9idCQR5Kag9H0YVFD259HnzNkWwqNrxw3W1Rp0+7OawT2LwAKb Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdsj0utjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 09:40:55 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38T9e6SM009125;
        Fri, 29 Sep 2023 09:40:54 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdsj0utjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 09:40:54 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38T7ou6x008445;
        Fri, 29 Sep 2023 09:40:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3taabtc2fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 09:40:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38T9epLq22217354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 09:40:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01AAB20043;
        Fri, 29 Sep 2023 09:40:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB59120040;
        Fri, 29 Sep 2023 09:40:49 +0000 (GMT)
Received: from [9.171.23.245] (unknown [9.171.23.245])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 29 Sep 2023 09:40:49 +0000 (GMT)
Message-ID: <a1f8b9f8c2f9aecde8ac17831b66f72319bf425a.camel@linux.ibm.com>
Subject: Re: [PATCH net] net/mlx5: fix calling mlx5_cmd_init() before DMA
 mask is set
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Saeed Mahameed <saeedm@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
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
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 29 Sep 2023 11:40:49 +0200
In-Reply-To: <20230928175959.GU1642130@unreal>
References: <20230928-mlx5_init_fix-v1-1-79749d45ce60@linux.ibm.com>
         <20230928175959.GU1642130@unreal>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jVPm3fTA5BLVaW5kvaXAbfHAllDxxUqN
X-Proofpoint-GUID: jz-Ys17IFmg_mzo9mfMRuepow1WQsKvf
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_07,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 2023-09-28 at 20:59 +0300, Leon Romanovsky wrote:
> On Thu, Sep 28, 2023 at 03:55:47PM +0200, Niklas Schnelle wrote:
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
> > enforces DMA masks. Fix this by switching the order of the
> > mlx5_mdev_init() and mlx5_pci_init() in probe_one().
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
> > That said ConnectX VFs are the primary users of native PCI on s390x and
> > we'd really like to get the DMA API conversion into v6.7 so this has
> > high priority for us.
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/main.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/main.c
> > index 15561965d2af..06744dedd928 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> > @@ -1908,10 +1908,6 @@ static int probe_one(struct pci_dev *pdev, const=
 struct pci_device_id *id)
> >  		goto adev_init_err;
> >  	}
> >=20=20
> > -	err =3D mlx5_mdev_init(dev, prof_sel);
> > -	if (err)
> > -		goto mdev_init_err;
> > -
> >  	err =3D mlx5_pci_init(dev, pdev, id);
> >  	if (err) {
> >  		mlx5_core_err(dev, "mlx5_pci_init failed with error code %d\n",
> > @@ -1919,6 +1915,10 @@ static int probe_one(struct pci_dev *pdev, const=
 struct pci_device_id *id)
> >  		goto pci_init_err;
> >  	}
> >=20=20
> > +	err =3D mlx5_mdev_init(dev, prof_sel);
> > +	if (err)
> > +		goto mdev_init_err;
> > +
>=20
> I had something different in mind as I'm worry that call to pci_enable_de=
vice()
> in mlx5_pci_init() before we finished FW command interface initialization=
 is a bit
> premature.
>=20
> What about the following patch?
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net=
/ethernet/mellanox/mlx5/core/main.c
> index 15561965d2af..31f1d701116a 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> @@ -905,12 +905,6 @@ static int mlx5_pci_init(struct mlx5_core_dev *dev, =
struct pci_dev *pdev,
>=20=20
>         pci_set_master(pdev);
>=20=20
> -       err =3D set_dma_caps(pdev);
> -       if (err) {
> -               mlx5_core_err(dev, "Failed setting DMA capabilities mask,=
 aborting\n");
> -               goto err_clr_master;
> -       }
> -
>         if (pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_CO=
MP32) &&
>             pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_CO=
MP64) &&
>             pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_CO=
MP128))
> @@ -1908,9 +1902,15 @@ static int probe_one(struct pci_dev *pdev, const s=
truct pci_device_id *id)
>                 goto adev_init_err;
>         }
>=20=20
> +       err =3D set_dma_caps(pdev);
> +       if (err) {
> +               mlx5_core_err(dev, "Failed setting DMA capabilities mask,=
 aborting\n");
> +               goto dma_cap_err;
> +       }
> +
>         err =3D mlx5_mdev_init(dev, prof_sel);
>         if (err)
> -               goto mdev_init_err;
> +               goto dma_cap_err;
>=20=20
>         err =3D mlx5_pci_init(dev, pdev, id);
>         if (err) {
> @@ -1942,7 +1942,7 @@ static int probe_one(struct pci_dev *pdev, const st=
ruct pci_device_id *id)
>         mlx5_pci_close(dev);
>  pci_init_err:
>         mlx5_mdev_uninit(dev);
> -mdev_init_err:
> +dma_cap_err:
>         mlx5_adev_idx_free(dev->priv.adev_idx);
>  adev_init_err:
>         mlx5_devlink_free(devlink);
>=20
> Thanks

The above works too. Maybe for consistency within probe_one() it would
then make sense to also rename set_dma_caps() to mlx5_dma_init()?

Thanks,
Niklas
