Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB89F616983
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Nov 2022 17:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiKBQoy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Nov 2022 12:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiKBQog (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Nov 2022 12:44:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D04CE8
        for <linux-rdma@vger.kernel.org>; Wed,  2 Nov 2022 09:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667407228; x=1698943228;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cG0vwECcOmNIiD91Y6GZaEGdO5GRCXegHEk1+0v9m3k=;
  b=iZBpUm/4JkF1Uzij3W66GOItF7PvSrexNHaRYWLuV6v0R0DRZDJEpVv4
   PKg4K/KVGoTjObv1BdN/SfgQBtbv6UlL/ps4pyUdUrINGYfRx6pPeTTkb
   /4cnngb2jTDrE2toOwm7LROjnNgoLSjypYmfectbcDlhJ4iDYZN8jme5O
   fBrar/rHvIyGnuu3EpuV72SZWV4Ok2NIKbrzd4WyBqHz9x4a//PYXY4OR
   O7IXXZnM06o6/yYGJb7VrxYAFpX7/xheZk3h58cDYoFcrKRygbJlAQLBy
   ji9B+fVDxZe3p0J7crFwjkFwe7bLFQyeUOIxWSkNdBSwhjS9cF/4+nwC0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="289849054"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="289849054"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 09:40:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="723623634"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="723623634"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Nov 2022 09:40:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 09:40:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 2 Nov 2022 09:40:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 2 Nov 2022 09:40:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEmAp/Ev8Q+iaWZewwpSHpS1Tr3zJknLLVhna8RQkKWz3j6IgzQoF1LU/3OiHNlimp6n9wyHXmKnHobLDAxMHXeii14ZtRUzTj5CRUI4O/DI2MmuKxcOhNFASLBqakpI4Bxuogy0HqeUwTVIT1BZeRZXQnQY6cH98mIihScT886EjoKgeACbq42zxEkR8BmqwsweAFMMG+XojJBMVeNF3INylkJQD/VyHSKxGYdjwvbkcZMzW5zpjkJvb0Vd+f4TPTtujgJtnxcF9FqjfzREvea3nFZBIDwkwwzjGMfsvglE7Wa1Ng28QVFz9PHvWsIvTg0wQaIxA/FgRFSpeR1egw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxxHK4Srpk3h6PRmk7QIbWeQMNSNm+IsaPSlUBIsLRY=;
 b=fL3qOgWNyZYL5awhdKfP5MeX41DzgRv4i2oB7WW528xOUaiv4eCphzsetN/0KBBlTv+WzawLalpUm+7K3qdd+7QyUH0uK47WvVOubLHXjPYwOk1WgmuIzZNtKtA1MFMTZFfbQtFBsIlzYBSH3oo24EbZDQFz7KK3dnJ2ALDXB6Qngby5XhWgCIM3d4v91Zpo8Vydtap9Z1CFWm73udbisv6Y7GPRstL9voP9+WYnhu0sjjshIMrFKwu6GWWsClkwvUFZQnzPqY7pc/K5q9dUt5JV38+u1dN8GhI0RJkeOun4BzFmKYVBcdQTz+zojHrdNjzNILnxz1vLNJyzxlDYwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4692.namprd11.prod.outlook.com (2603:10b6:5:2aa::11)
 by SJ1PR11MB6177.namprd11.prod.outlook.com (2603:10b6:a03:45c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Wed, 2 Nov
 2022 16:40:20 +0000
Received: from DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::b179:9aef:6bca:5668]) by DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::b179:9aef:6bca:5668%3]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 16:40:20 +0000
From:   "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
 rules
Thread-Topic: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
 rules
Thread-Index: AQHXmDZjOykQbRhbB0OylwgVwYR9l6uBQpMAgA+prJCAAATrgIAcjKoAgAA+ygCAJXODQIAASCMAglozZJA=
Date:   Wed, 2 Nov 2022 16:40:20 +0000
Message-ID: <DM6PR11MB4692B502C54F459A2EF9E79CCB399@DM6PR11MB4692.namprd11.prod.outlook.com>
References: <20210823154816.2027-1-tatyana.e.nikolova@intel.com>
 <20210823161116.GO1721383@nvidia.com>
 <DM6PR11MB46922D3AE92E34B4E1D3AC9FCBCE9@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20210902154003.GW1721383@nvidia.com>
 <DM6PR11MB4692517FBBC9AFD046990DCDCBA09@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20210920232330.GH327412@nvidia.com>
 <DM6PR11MB4692B56B4C7D1E790B50888DCBB89@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20211014233644.GA2744544@nvidia.com>
In-Reply-To: <20211014233644.GA2744544@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4692:EE_|SJ1PR11MB6177:EE_
x-ms-office365-filtering-correlation-id: d57ee5bd-b141-43e3-6587-08dabcf0ee3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5wAxylkt3Fku3XoZh2p05jsV7FPX0vsEf5njTct9fpUWb76yLux3ioqDePCiuZfK0k7UEKFVmzpK2+gR9qxDNvHVzlNg5TWQ8neUmtEOiMGviX2fo+ZFrhsawlstd8ezDhNR7nd+KvJRydOoOcZx43rVR0wT35AL3YSzmeALzkOc4FRtUbEYQHYwJ2lVLY7Vu/rxa/oyDP+zKgU2kc0grvld9FsEJy9FIU8TVZlmyK4DB/nmk8sjA/6IebkTXsoS6tfsy9CMWo0llHwKr6e/8VSnZJ9tDtHu/TsTHgwue6JGNmxqUHWkehDjibdpkfhrH8ot+M8qspuXANLlSX+HOGxY3lZD+F12MifiBh60RJpCNAnVx0SfpQW1TT1N92Q96TNIpQN+AZROsXRuMJuzGc+izFtKcqUAo0QPJ9QODiVliZYIO+Zyit7Gu/I5Nlc4mG9cxWF4hJT1eMrgzUB8xCDy+Pd7PBqbklOePIuopw5q4rpF0Wori+7y7SEfeX/GY3tkyN8V8UnyBhF3HJoCoZ5ks1g9BWxHuWDJy5gazIaZzIcgB/IjrIJeCKplMDfDyEz+stdimeAwjsb5iu0+9Gr51mBBd16izSb624K84rlCqXHJz9WO13+okhCGmBO7/mTnALchV23GKha2VqLDD5b6Zg7C/s9cpN4sNuMVKsuEieHeAIeDg+nPL52JnLy+DtSwnyvBBLInKR//m7LzkHfY9M/q3B8YH1VQQR95fKhNmMbYjZqJperFpPHP3VrBBGr2Vn7gCXsOtDaohSL3GkheiN03m44qjwHDkQaGwCg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4692.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(38100700002)(2906002)(122000001)(82960400001)(478600001)(71200400001)(8676002)(66446008)(55016003)(66476007)(8936002)(4326008)(66946007)(76116006)(66556008)(64756008)(186003)(86362001)(38070700005)(7696005)(6506007)(41300700001)(54906003)(6916009)(316002)(966005)(26005)(5660300002)(33656002)(9686003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ry/SIupPQHqE85BJEXWHtl9k9OWCzl6Cd23VM2IcuJW+0843i2zcy6Dp8uMB?=
 =?us-ascii?Q?buIsyX/G56Rfz8vbapfkxN1VgSWudzgcpkgd7+3cfLSs2hvKS2iz7CYRninm?=
 =?us-ascii?Q?7uYvRPzF5HbUNbg7ittkpLu9QWi6UwUxhiI5eqcWax/Ysl9oOGsG8/CqHPZk?=
 =?us-ascii?Q?iu9WbM9JUHPicLeEUAfAVRS85KsRjj7ghZW3OvAZteAXidy2NPz+Y6hLC/1j?=
 =?us-ascii?Q?i2kicor2lVaFzV6GkS2z0FNVOBtzwf2kMVPbFhQj+ZOkW8OT6PgH0rBT1sbX?=
 =?us-ascii?Q?kS1j67kd9eAr9m9AtggasSi1KvGjoB5KfCNe9idhvqkq9ayioiOVxVyz5WKm?=
 =?us-ascii?Q?++bZkJuPWWK3FsJY26u7Fhej1xvP0VX6ADI/lP6GkzO9sXCIq218/zKW+JPJ?=
 =?us-ascii?Q?Q4Ipjy4DWsKIxRC4oitEEAlfrnwddkC5ONet/CJPgkrl5aQlxT2BY1QIwVzg?=
 =?us-ascii?Q?99Av+FHZDm4a3hmq6JTqr0gSGlaimYIzWGVQtNeKHW5/qfEp4rw84uwnn3G+?=
 =?us-ascii?Q?xrNRVvlbd7nalz2yl5JqPKYp/M28vrsqD36+XD7239kLP0LSHPiEKUdwVPC8?=
 =?us-ascii?Q?pV0ENijiBJ9tgQ/glwnGgQw5p0tOml0R30ldIqHoFfgtdPFeg+MSwN7a6AGV?=
 =?us-ascii?Q?4uLfRcWVDpg6FKPbr7GTCAUceuA+mD5RC58V3BLxPtWRahLCLi21HQgMZIgS?=
 =?us-ascii?Q?UjnNvyz6OpVo5TYIZyxmsKey4IdVagvvZHVKBMli39oeJa3Us1bY6giU5hhY?=
 =?us-ascii?Q?sZURF3qf9dB9VDjMOn+K/Ab/PUAoEfe5F8VLWeuaMyTVxo5OEY23Ncn/riHd?=
 =?us-ascii?Q?XYfqIJ9S7v6J7emE5MuB8CcXrJIKU0SDpcWA2uuEfno4eWWp7QvQPoQvQg5P?=
 =?us-ascii?Q?x/PMHAPV8ESJfpvLgNRoiwZ3UtkztT5+FanLfvGlb9GG9wdZpsp9l7lleVY/?=
 =?us-ascii?Q?RYTXsI6M34qp+E1s6KzggFrZkT1gvsouYBo2vkHmooo8LobsqqxPV/SDta9b?=
 =?us-ascii?Q?4apm5Y8A5I9bImgXlW2kkL/NZhtnOwbtj12Rlj2cZL8T0j6/PknqsJK39Clu?=
 =?us-ascii?Q?fJ/mTTgokrWQi0sRe6tSGCCE79/sFoWguqIV8JMq7a9sYTIhx2uwjI/YhSBW?=
 =?us-ascii?Q?bYS6qkXymgv/tDSa1u9g0ZeLjPgZq0lj6LXR+/V6/QEafYd6KanvqFYiJOwK?=
 =?us-ascii?Q?BVD77f56Tk3wbuRd34LV8VJipGjhiGhuYDWVai4j+WKxLKDSup7nesqOv4ES?=
 =?us-ascii?Q?9F2GCL83mqT+cQ/EJ/PbGlpqXTvMMSYD8tGySZtlhRHPu3NCKY90JE7O+MH/?=
 =?us-ascii?Q?5DdSU4lUGp7Bjxi/SkaGJPKg28FRfr4baLEr+g1o96mUfhTFvU6EiKQcC4Wa?=
 =?us-ascii?Q?n8TMVng2jTySi3doPgJmx+cCro0aIAaCVpDNHVB9stKXCJ4D1dYJ3Jtyree9?=
 =?us-ascii?Q?u7wlSKfdYC5BB+++2PE3B+4bFc5YkXNHeCnPqDl8qTagO93BxbDsQ0pALwsU?=
 =?us-ascii?Q?PugNLmlyDvx4Z8a2niMpdSq2AacuWc5NHz6UrKZ5ZmCLVeVH3khrC2XOEqsz?=
 =?us-ascii?Q?e8ahNePhHw5Q1+9e80TNsRx9QaDTdRdEN965xAjfcYhjypgx3vdZD/mNml7v?=
 =?us-ascii?Q?eA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4692.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d57ee5bd-b141-43e3-6587-08dabcf0ee3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 16:40:20.0699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PcwF8pXzVZz/RwU0uVGFEaWlENRo7ABsu3Jx/6AxTYvg3kBcD4qAJIXYB4f9pDuhPCoI2KgrBbxW63zGrj7VtMSgZ1gk3Ig0RCWP5XbfLkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6177
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

I know it has been a while since we discussed this. Based on your feedback,=
 we are proposing another solution for the irdma kernel-boot rules. Could y=
ou please review it?

> > udevadm info --attribute-walk /sys/class/infiniband/rocep47s0f0
> >
> >   looking at device
> '/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/infiniband/rocep47s0f0':
>=20
> This looks like the problem. For any of this to work the infiniband=20
> device needs to be parented to the aux device, not the PCI device.
>=20
> mlx5 did not due this for backwards compat reasons, but this is a new=20
> driver so it could do it properly.
>=20
> Then you can use SUBSYSTEMS and so forth as I first suggested.

Here is a patch for irdma driver to set aux_dev as the ibdev parent:

diff --git a/drivers/infiniband/hw/irdma/i40iw_if.c b/drivers/infiniband/hw=
/irdma/i40iw_if.c
index 4053ead32416..e08fbfe148ea 100644
--- a/drivers/infiniband/hw/irdma/i40iw_if.c
+++ b/drivers/infiniband/hw/irdma/i40iw_if.c
@@ -90,6 +90,7 @@ static void i40iw_fill_device_info(struct irdma_device *i=
wdev, struct i40e_info
        iwdev->rcv_wnd =3D IRDMA_CM_DEFAULT_RCV_WND_SCALED;
        iwdev->rcv_wscale =3D IRDMA_CM_DEFAULT_RCV_WND_SCALE;
        iwdev->netdev =3D cdev_info->netdev;
+       iwdev->aux_dev =3D cdev_info->aux_dev;
        iwdev->vsi_num =3D 0;
 }
=20
diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/ird=
ma/main.c
index 514453777e07..835a087a3329 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -279,6 +279,7 @@ static int irdma_probe(struct auxiliary_device *aux_dev=
, const struct auxiliary_
        }
=20
        irdma_fill_device_info(iwdev, pf, vsi);
+       iwdev->aux_dev =3D aux_dev;
        rf =3D iwdev->rf;
=20
        err =3D irdma_ctrl_init_hw(rf);
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/ird=
ma/main.h
index 65e966ad3453..f2f86b882cef 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -329,6 +329,7 @@ struct irdma_device {
        struct ib_device ibdev;
        struct irdma_pci_f *rf;
        struct net_device *netdev;
+       struct auxiliary_device *aux_dev;
        struct workqueue_struct *cleanup_wq;
        struct irdma_sc_vsi vsi;
        struct irdma_cm_core cm_core;
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/ir=
dma/verbs.c
index a22afbb25bc5..f1304b6b58b3 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -4549,7 +4549,6 @@ static int irdma_init_iw_device(struct irdma_device *=
iwdev)
  */
 static int irdma_init_rdma_device(struct irdma_device *iwdev)  {
-       struct pci_dev *pcidev =3D iwdev->rf->pcidev;
        int ret;
=20
        if (iwdev->roce_mode) {
@@ -4561,7 +4560,7 @@ static int irdma_init_rdma_device(struct irdma_device=
 *iwdev)
        }
        iwdev->ibdev.phys_port_cnt =3D 1;
        iwdev->ibdev.num_comp_vectors =3D iwdev->rf->ceqs_count;
-       iwdev->ibdev.dev.parent =3D &pcidev->dev;
+       iwdev->ibdev.dev.parent =3D &iwdev->aux_dev->dev;
        ib_set_device_ops(&iwdev->ibdev, &irdma_dev_ops);
=20
        return 0;

Here is the udev output after this change:
   =20
    looking at device
    '/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0/infiniband/ro=
cep47s0f0':
        KERNEL=3D=3D"rocep47s0f0"
        SUBSYSTEM=3D=3D"infiniband"
        DRIVER=3D=3D""
        ATTR{fw_ver}=3D=3D"1.48"
        ATTR{node_desc}=3D=3D""
        ATTR{node_guid}=3D=3D"6a05:caff:fec1:c790"
        ATTR{node_type}=3D=3D"1: CA"
        ATTR{sys_image_guid}=3D=3D"6a05:caff:fec1:c790"
   =20
      looking at parent device
    '/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0':
        KERNELS=3D=3D"ice.roce.0"
        SUBSYSTEMS=3D=3D"auxiliary"
        DRIVERS=3D=3D"irdma"
   =20
      looking at parent device
    '/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0':
        KERNELS=3D=3D"0000:2f:00.0"
        SUBSYSTEMS=3D=3D"pci"
        DRIVERS=3D=3D"ice"=20

Having the aux_dev as a parent of the irdma ibdev allows for udev rules to =
set ID_RDMA_IWARP or ID_RDMA_ROCE environment vars based on the auxiliary d=
evice name with the following patch:

diff --git a/kernel-boot/rdma-description.rules b/kernel-boot/rdma-descript=
ion.rules
index 48a7ced..0b844bd 100644
--- a/kernel-boot/rdma-description.rules
+++ b/kernel-boot/rdma-description.rules
@@ -29,6 +29,8 @@ DRIVERS=3D=3D"i40e", ENV{ID_RDMA_IWARP}=3D"1"
 DRIVERS=3D=3D"be2net", ENV{ID_RDMA_ROCE}=3D"1"
 DRIVERS=3D=3D"bnxt_en", ENV{ID_RDMA_ROCE}=3D"1"
 DRIVERS=3D=3D"hns", ENV{ID_RDMA_ROCE}=3D"1"
+DRIVERS=3D=3D"irdma", KERNELS=3D=3D"*iw*", ENV{ID_RDMA_IWARP}=3D"1"
+DRIVERS=3D=3D"irdma", KERNELS=3D=3D"*roce*", ENV{ID_RDMA_ROCE}=3D"1"
 DRIVERS=3D=3D"mlx4_core", ENV{ID_RDMA_ROCE}=3D"1"
 DRIVERS=3D=3D"mlx5_core", ENV{ID_RDMA_ROCE}=3D"1"
 DRIVERS=3D=3D"qede", ENV{ID_RDMA_ROCE}=3D"1"

In addition to this patch, changes to rdma-core rdma_rename logic are neces=
sary to handle ib devices with aux_dev parent and rename them by_onboard or=
 by_pci the same way as it did before introducing the aux_dev parent.
Please review rdma-core PR at https://github.com/linux-rdma/rdma-core/pull/=
1248

Thank you,
Tatyana
