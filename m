Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5D925AB44
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 14:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgIBMkt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 08:40:49 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:34790 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBMkc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Sep 2020 08:40:32 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4f92bc0000>; Wed, 02 Sep 2020 20:40:28 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Wed, 02 Sep 2020 05:40:28 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Wed, 02 Sep 2020 05:40:28 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 12:40:23 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Sep 2020 12:40:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lp2nbJijdCbGkJC8DBVURC8G0L/BN84DPnXVx6bwXt2x31pQ/IfyXNkPg2lWb0pQPO40WMdYoKGiF7Uecuehw1glVn3Lhfs173rWCw1K0nCh9SdVkOcmY/AP8QUkj7FYBxRy+zB02iGrPoovb5e4bCg8px2t8QjyyccDNmsJR59dXU72eSNkLLNCGX/fkYeI5NgE13wsrEWnYvUvdaGt2vgsLBHlP6YbtV77rHhfCPOriPUMql/2lq+lZoMAMpViYtUfhQ+zyw1gIfhIqTDX4R8hf0C5UI/48m/a8DdFbXKzJ6X8x4BQUvAysSNC8zRqWONpWT+O364RsLHsVTsDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWEajrVOgbbfxMbWmJljipiCROQ6YIt6zMYpcRvqxBY=;
 b=PFSVc5wm2qWWW7TUcqUVVLVn2EXEHK3DCaPnZOwilaYhECjfzz5c6SSPXeHOCWrjKo6SA3o+TPy6Z7pFeaBfjxSE7mhvqHnTeGWxNe5TW+6cZGHpj2qjYFENFBfgyO4mkq6uUOf8CjLa7BDunBk+MKS2+xUiozXwPQ1va7AYKm8LAJS+QSQKOR2IbeP8Oo9OTs8c3QLSNINdnEMucYgGZlFZbtjcPGCHW1IzQCS7A2XiMca3xqYRNrpDLu9i3mDg8lyam74IcDSlLYw9KrfDVgWjQKgk56tigZqMlCcvg0CXLlmaDJbC8T44rZmhIAP8FLlpUi79hKx+YU/7t1SnLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1658.namprd12.prod.outlook.com (2603:10b6:4:5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Wed, 2 Sep 2020 12:40:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 12:40:19 +0000
Date:   Wed, 2 Sep 2020 09:40:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
CC:     kernel test robot <lkp@intel.com>, <kbuild-all@lists.01.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        "OFED mailing list" <linux-rdma@vger.kernel.org>
Subject: Re: [rdma:for-next 16/50] drivers/infiniband/hw/mlx4/cm.c:496:48:
 sparse: sparse: incorrect type in initializer (different address spaces)
Message-ID: <20200902124017.GS1152540@nvidia.com>
References: <202009021436.HsjhN4O1%lkp@intel.com>
 <20200902115228.GP1152540@nvidia.com>
 <CC1EC6BF-BAF0-42C2-9DF2-6E233B702119@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CC1EC6BF-BAF0-42C2-9DF2-6E233B702119@oracle.com>
X-ClientProxiedBy: MN2PR01CA0037.prod.exchangelabs.com (2603:10b6:208:23f::6)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR01CA0037.prod.exchangelabs.com (2603:10b6:208:23f::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Wed, 2 Sep 2020 12:40:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDS3l-005dRi-U6; Wed, 02 Sep 2020 09:40:17 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78c5bc0c-91c0-4fab-2e3b-08d84f3d59ed
X-MS-TrafficTypeDiagnostic: DM5PR12MB1658:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1658954B838DD655071E940FC22F0@DM5PR12MB1658.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6OQgO4T9gAtSdpYTIHRoTKMFxWNiIRwXs1GPgjuTPppYCyR/EwJI/o6a1LJBtKlH9AjGjp359RH9Zg0JT0SZen0JpQbwnuuWQJB+oLlGxX/fufPDaTV1iMJqg4RfSWAC5z591RqiKIAfwgxB1UFPtL814fNV/aCg4cmZG85XAm9sJGyMj7X0KjdmOQ4XwTImge/EbQhg90qtAtLzwDdTERiuKBG9frVGvjya3bS2AbVCp4xg8aVCJcRFw584sVClPjv9bessw99EXBKWZ9xiWAgQ3D7x+/Bm0tpq5HGA/pHd2uGrJXMRdxYCfPJyGq3U5rOOxkIsSI2U19ouvWX0blPgyQTHoyp1D1yfRMMwcIbEIXELHyYJRxPxaqvxykf/1GUMKWjkJ+zWLPikciV8nQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(9786002)(66946007)(6916009)(426003)(66556008)(66476007)(316002)(2616005)(53546011)(1076003)(4326008)(966005)(54906003)(86362001)(26005)(8676002)(66574015)(2906002)(9746002)(8936002)(36756003)(478600001)(33656002)(186003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: nkPJQ0fhMt6mRcwcqSMYcl8ylH+v135tk4vNmwgdDQyrnf1tZ0NgeqfI2XbzMJ5PbO05CnHSusHFtFxqA7ZhU5RRlVJkd2mv6OYLBOh7NJgNV9vd0wfTnP4Q7Wemgv5nEe5OokKVbHRE1O+ONY6NWgifgm5FxYDeZvSxC4jvFIxWhEb7j0r4s86YLDIGHeudSPN3f6P3S6ovyNNLPRvt6sTeqLQls6MXDV6g2UOvE1h1TwrP0mP9Y3OR6xBEWV3RQFakYjr+ULWJFqZVOS+3pG1qV9orkAebi/r6X8GmNM1sjjDkS5Jd6g7ecQniYjLE1PJW80W6kd9f9cbiJwbwNFMjKzCsFbVkpxalFVVNGIocDvQWuFpCXzRU/XoXcNw/khCIDiJ8xYsxknKxCVw171vORcbwl7Y6s24oQnO1bOWB22LlsDXIJTpisYSH3knUvxdVdEbwtX0JdZhgoxUunoo4i+AFD+rPOmejfEjZpOv0ZSFHFPnxrRTzOIDPiz328W7iXZYrzEJtopjXozzEXTDPZWf7GNCT81Ol8EnEsn3ZzlYybOn1oO7mHNq1D6T7CdBnUVQ1JG83WLOVjJaOO3O/VP+N0PPa0nZVJZO2AFTeW/T9XEGVUsrwMQNIdWPSnCFpE2igDczzKHRQAMKulQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c5bc0c-91c0-4fab-2e3b-08d84f3d59ed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 12:40:19.5059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MMzVrPwnaxJCx1110Ea1LTg/AsS1ATCtW9IYfS8aTS8tX5scJefNY7Kcoog3LRA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1658
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599050428; bh=ihwWARqgg/9Low3KrTRsp1kk9B0VVoQhQFIG86WT/2Y=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=Py/PWXZgaw1WVWAUM0EF+xI8BmusCzLSutFnjhN7/xrS7MiOqVd4694AwerGBmhbs
         iMY+z4m1aWGr/EFNVGAhIgXqvwbFpiPP/NfTPC3n3IMOG4AMpdnkwpbEyU01nBznFj
         tVBCL1hM00p6zWZNeTRrxC8115NBjb0N9kaorQN+UkYdCoQnOUsYSqY+NeGer8m6Rn
         HZw+cjGEfi1PGPF7c/7suk+PWhd/OgS+h4LiZiKrwqmSiZ//ib+EO5dC8WLtM90guz
         Ubfwb7Wa8HeBA47nyzhgOK/KBgPhyPSb5kSjlpnFKPDfByJMaY0HDh33DFQd7cz6aO
         itMbcNx00kjIw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 02, 2020 at 02:18:27PM +0200, H=C3=A5kon Bugge wrote:
>=20
>=20
> > On 2 Sep 2020, at 13:52, Jason Gunthorpe <jgg@nvidia.com> wrote:
> >=20
> > On Wed, Sep 02, 2020 at 02:01:41PM +0800, kernel test robot wrote:
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git =
for-next
> >> head:   524d8ffd07f0ca10b24011487339f836ed859b32
> >> commit: 227a0e142e375909959a74b7782403e14331f6f3 [16/50] IB/mlx4: Add =
support for REJ due to timeout
> >> config: i386-randconfig-s001-20200902 (attached as .config)
> >> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> >> reproduce:
> >>        # apt-get install sparse
> >>        # sparse version: v0.6.2-191-g10164920-dirty
> >>        git checkout 227a0e142e375909959a74b7782403e14331f6f3
> >>        # save the attached .config to linux build tree
> >>        make W=3D1 C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' =
ARCH=3Di386=20
> >>=20
> >> If you fix the issue, kindly add following tag as appropriate
> >> Reported-by: kernel test robot <lkp@intel.com>
> >=20
> > Gah!
> >=20
> > H=C3=A5kon, radix trees are not allowed please change this to xarray!
>=20
> I believe this is lack of __rcu in the variable definition. I started wit=
h
>=20
> 	void **slot;=20
>=20
> but sparse didn't like it, so I changed it to:
>=20
> 	__rcu void **slot;
>=20
> sparse liked that, but then it didn't like:
>=20
> 	struct rej_tmout_entry *item =3D *slot;
>=20
> Shall I change that to:
>=20
> 	struct rej_tmout_entry *item =3D rcu_dereference_protected(*slot, true);
>=20
> ?
>=20
>=20
> Not sure why I need to meld in this rcu stuff when everything is protecte=
d by a mutex anyway.
>=20
> Please advice,

Change to xarray.

Jason
