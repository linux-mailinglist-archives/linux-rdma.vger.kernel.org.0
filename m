Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF58257C3F
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Aug 2020 17:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgHaP0E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Aug 2020 11:26:04 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12354 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgHaP0D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Aug 2020 11:26:03 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4d165d0004>; Mon, 31 Aug 2020 08:25:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 31 Aug 2020 08:26:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 31 Aug 2020 08:26:03 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 15:26:01 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 31 Aug 2020 15:26:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dg84TS+zLNk9AqoR/Qkq9o27X6quvmpvn1d+Ji0zkg77yAAmovcXqWxUQ20pEOcSQ1oDrWKPk2z6bIEvR9Cb4w9lUyXdFxRsPjNIdAXnurGmscQ6KFc+VtyiqeO31d/bQQKDHXnceoPBDTE0191kPfMK53etDvIC2JyLxvyk29MlZp9xCDjd56MdX6v3axYW/H3FlVS1MmvRlaN04Q1WfQlK7sjd46CvqBIGPgc6GuWneJuFNAWCZ9GrA6eMrHu7eV1ttMpa2Ggw5ULpFY/U06g1mYeFFKR1wv/7a6fbTZ8mrDakAA23nkNXnknxSYtaAqSFxEgcm+HVfUHq49Qelg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QTfyAdHVFZOwi5USckcpTTr6dnr62LRnySRJuH7hjI=;
 b=jCrwszVb0K8r1kaLhfOVwsOL5QbYgGR6EEcOBmQZuPQ2jwswLMaarRZ3iN5pEptG1cR5TEBw/eUDBf/KG9CNOTpKSZJxzmnpnIsU1Ja4IZac2LKERyANHWWTMK+2Qb0G8cKbIt+EQd51UAN+etxmvb0++xTJgu6BbUxRT+AV+phK38MSPwSRyGedziSxPuy4tmiJfCYI9dcQkxyXbu/rhkJvXCE4G/yClHMwlsVeWc4x0o6U108iQT4DNAMSPlbyA7UhmfR2spmDcwEpawXturh1lHQJ+fTcImgG6rRspc8Bf3QwWMeu2ZdaJH5PZ3F/rk6bdH26XacBsOSJd3UNDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2940.namprd12.prod.outlook.com (2603:10b6:5:15f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 31 Aug
 2020 15:26:00 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 15:26:00 +0000
Date:   Mon, 31 Aug 2020 12:25:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Get udp sport num dynamically instead
 of using a fixed value
Message-ID: <20200831152557.GA628533@nvidia.com>
References: <1598002289-8611-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1598002289-8611-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: MN2PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR07CA0019.namprd07.prod.outlook.com (2603:10b6:208:1a0::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 15:25:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kClgz-002dWT-Ve; Mon, 31 Aug 2020 12:25:57 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 346181f8-f69b-404f-3e35-08d84dc229c3
X-MS-TrafficTypeDiagnostic: DM6PR12MB2940:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2940D144FE993DC49E01A117C2510@DM6PR12MB2940.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1q5DlHasi1zF3ZIwGXoTqKEidNnrsuxDfNEDlsYgpj7YCD6UGnDLcArX8G9XCIckMee4q5Pwm8ladj+nQLmklG4GNutz0BGYSmNXBfGE974wl1cUNTdQwmkkaCi0LWW8Dl1QHszruTfWBGxayY7ztj/0HQPUODBRlwDFzQUXHgoiVyRowDVnFbzsZFZyfxsRNAxZX5XIuvFO1PyjXakCMHS/yRzUv3c2PTm4D0OQKd3FwwbDMWzuuA6UR20FsM8laY9038Xa6FBl0xpJfoBXvvBfaXtV3f+z0nywPULu2Y39WyErfiaMXUyQB+lUq2JkMrdHCWSwZqy04f8oZOVIckslYTgFxM5AcpmfwEvcw6ckBEZU6RJ+/udCjZ+6JOR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(26005)(2906002)(5660300002)(36756003)(86362001)(478600001)(6916009)(8676002)(1076003)(33656002)(4326008)(2616005)(426003)(316002)(8936002)(66556008)(66476007)(66946007)(83380400001)(186003)(9746002)(9786002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: VK2rVNdCaFv4WBOzUJML6XMVQcm2ZidxLsEkAktcP3LYWVdcjxKjt11jBtUk1LtRk4brsusw36ONXRPhSCWYhD/ftlqKE34/KkHwGRZO+06RqN6RGNtb3fxT0y/j7fX0celCbBJl4f1Vk0hqxehfWlMSzMgv2xo45T3QfFgk5GDQxG3ot5fI2QJlm8rrCpp9hDQZjPlnz5Ht9Q3e+9ZV5cShG6tXAPDUNEdK7cYGF470GrBFEv49wbiIOZKZo9v12c8/vGkUesBUnMDUY76hfkyApQALjWry0BB8V0D8VJ4qw/18gqRLgauvXbeQmYVEnTMkkkH8ASIXEVlxkwzin4pIaZWPCWGt1emtlSZtEmTCSGrNIWyDGOcgjKb/0JUwUJQwdL4Y5LvijQqqJ+xWKwv+8WljMf4zZgZ1Bi7gPWL2GqKhrbqpdQouA9JBPjO0nQC3kacDCR7VTOd5J1FnOkgyOnX0sYmCicoyYO0SZqAW/N8wWthARMlkKaaxZyIkEFD+JB86ovYwqLpowYUWYAw1YWNtCo9BD3AhOFfupG7xXZikhQ79jtg1DDO4rW5asqSUOjAOtUMuUhO9tPJ+AHDDphrtD67cv1kcd+Ko6csTthFoxfPsPfJdg0lWWQoD744QuYLxjheWPSOAsQYgwQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 346181f8-f69b-404f-3e35-08d84dc229c3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 15:26:00.2565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QdwjUxu3O3J5HQ1EbSsh0SJinG7IjJNLuLN2vt6zUxnxTVOvhXGH+Q7DTIhIoGi1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2940
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598887517; bh=F8tWLrHx2ephpffXJw7FG2qLY80GDm0bi4BjOZp53bY=;
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
        b=cby2zDOIvGhIVoCETVGcwWrqrry6nFH7ViA5cQbAa1tbhXG3Nenbn/csO9S5edJ1g
         wkeKghJjHvwLNDKv+WIMCoOvrb37XL8ipoHcCsXVs3Ix4Fanqn57CMzDwk2pVBy459
         PM4o6gczMGwte98Aeit9zlU65v7CpM82/pNvSf2A2vUDEhYJWW+1K7uKmJrUr/ki1C
         mdfmoRJFvXfqGi/0NSZ58rYf+jXhv1gellFiOX4jJDbcV5CXA4t3hPbksZYQWjWWd3
         74xgBCX4YTaJtbx0B7g4TlsI+8qGtfayeTsRwBtTvHrLM2jsWi6cYq557WjvvkWtvf
         rqf0420hjlETg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 21, 2020 at 05:31:29PM +0800, Weihang Li wrote:
> The UDP source port number in RoCE v2 is used to create entropy for netwo=
rk
> routers (ECMP), load balancers and 802.3ad link aggregation switching tha=
t
> are not aware of RoCE IB headers. Considering that the IB core has achiev=
ed
> a new interface to get a hashed value of it=EF=BC=8Cthe fixed value of it=
 in QPC
> and UD WQE in hns driver could be fixed and the port number is to be set
> dynamically now.
>=20
> For QPC of RC, the value could be hashed from flow_lable if the user pass
> it in or from remote qpn and local qpn. For WQE of UD, it is set accordin=
g
> to fl or as a random value.
>=20
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_ah.c     | 18 ++++++++++++++++++
>  drivers/infiniband/hw/hns/hns_roce_device.h | 23 ++++++++++++-----------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 13 +++++++++++--
>  include/rdma/ib_verbs.h                     |  1 +
>  4 files changed, 42 insertions(+), 13 deletions(-)

Applied to for-next, thanks

Jason
