Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7269D2778D8
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Sep 2020 20:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgIXS76 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Sep 2020 14:59:58 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:24234 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgIXS76 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Sep 2020 14:59:58 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6cecab0000>; Fri, 25 Sep 2020 02:59:55 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 24 Sep
 2020 18:59:54 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 24 Sep 2020 18:59:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVHbb8vLQ8u+QQV1CEkBBVd/YVVeMkvbd68aT0jsacPVUtF/Vol42iNVqWyHk0jsUhLnLGwEmX6QqlKByFOK3Vlg84847L/8QakLxneKbLfkKab6l8JkCkvhMs+sEdVHu8DAeLOpFqZvqXo6wdYY/E60Y1zF85Zp/KtoZL5IH2/YVbpHEr5+otPwCZbURrYEiPZJRDQ8l1G5HHK2HkLN37zqWNwtgm//JJKUszHcpNeu7jPIewjBMwY0j2bVOGJMJrILfnJBTyrmIfg/5sVPRHraOBqRFcjZx6u24mIgCURmnUaGFuK+R5e4mRY5q4OvOtfPYESbJy9rH/ZdsmeW/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrOg3q38rv3rcvF7QnLxrD2QkRu9b1UiOnRHFtrHM6g=;
 b=UBm3PUEKK2M1mw67D6d4ADEIN4KwLFdELlIO3gM5Zz2FADdmUlvFE3HnscmUaEj217Gv8UYCYNfRJoh70htj2MHLrUmPbt9MHQezGB167p6ux+6Z2HFn3m5xKD/b0cgwrd3Ik9lBD9KRAswVW6sYoY+UpVNw8ifi8qL3JHnKMkLyrQ0TpOXQetpakbAa4LAMOQBgKrrSc0IlAvwA51qyURMoXCYreL6kjyCd+dw3+k20ZfcPuFXCrbwX1IsjpSqhRNJc05iUZELsBWwXRJoRMXTV3zb8tCcQeN99KOVG/Myc2c4C4ruJD3cTE79kzB+WlxZR80aeQctj9CDNUBJOLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2489.namprd12.prod.outlook.com (2603:10b6:3:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 18:59:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 18:59:51 +0000
Date:   Thu, 24 Sep 2020 15:59:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v3 for-next 1/8] RDMA/hns: Refactor process about opcode
 in post_send()
Message-ID: <20200924185949.GA116461@nvidia.com>
References: <1600509802-44382-1-git-send-email-liweihang@huawei.com>
 <1600509802-44382-2-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1600509802-44382-2-git-send-email-liweihang@huawei.com>
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: BL0PR02CA0072.namprd02.prod.outlook.com
 (2603:10b6:207:3d::49) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0072.namprd02.prod.outlook.com (2603:10b6:207:3d::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 18:59:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kLWT7-000Vfe-MK; Thu, 24 Sep 2020 15:59:49 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f3eec4c-f106-4b80-58e5-08d860bc03d2
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2489:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2489A56B9E2D63825EBA718AC2390@DM5PR1201MB2489.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95YSfw212Dk+wgIlhdlTRoH6oquM418J1820djP2cbxDVFBAcMgtZxMc/5mfTpP1iwtHvG0YyuNohiw4+LbeAx/5PJ9UXCrqATNdSxIZeOnEdCI8ANYatAF5tlyi4srzTTo+796GSVPZcg//4qTpJt4/Z8hjKKtPlRNaVSnjmcBlXPijw1FkdhWVYs9anvIdqVpnV2kx14cP7PVTTD5j3EQMv8ba3MpWO3tRcWANPahbM4iSRb2bjE86fRd34VD+b48YIRApId0nNUxwkgC5ESoSHgQOArmpp52pmip07IeNxjUSgWkj1fkmVgL0CXOx+folVMR89l0go8FPmeilGLp3YJ/rle3YpEtqbtL9gedtCPxUIVAxj+wX2OJsiCGo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(9746002)(1076003)(33656002)(66556008)(426003)(26005)(478600001)(36756003)(66476007)(186003)(2616005)(2906002)(6916009)(66946007)(8936002)(83380400001)(4326008)(8676002)(9786002)(86362001)(316002)(5660300002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: iTFE44eveUVbZi+HGbcmlER6LSZfch5VeQhr2bAGYzcpbUoBSk3ISv2b/h/5hNdavkpj1NHTXdwV8CapfpV0/clioVsg+SrHaNTsa8KawFk47se/jOgmnMR12bHTVvcZfIMQ+rEm27H4G9XB/FD9fEFNb6zBznpJLfGlNTZKDz65S4IkujeMi92iTHJ5BU8TiUuRX7UQmZOfkdSqHqso5lOznVfnWOr0EFM7pDcwZqInf88aZvNFM2TEhV+AZiRms5Tri4C8kc1Tne3tG5XMsI6qccP9kGLAH9viDSoyKSomAqU+Z6ncdMB8o2K2wCOmG7UbLaKniopBeGay9p1uafqNsFyv5UaIm1SUnZCdDSl9DkcCFejKnvdLlox6tbMaS/p2dvfcGDM4EO+ZwdsnLnrH5rRCWUTDxaCywJj0rr2vGU++57OnyuSkgs0S1WrqLfiLocR+DkVccC0HWd3+zN1mUeyHoID8ikRJ+m3HBjkGpn4p4RccDYJs8y+fZeQCYRQYmyywz8D0NfV3LfUrGRCcVDzE86p2aYQzK+/R06vxRWOuO2UwPX5xorLUQPt95rwMSHjMZLFIZVUmZJ9JDXlYQ1Sbymx2NdWW8AFr+qwRNfJpSUfhFJS/lR1zX3+LtF9tdZ1bn6b+fyinIPQOkA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3eec4c-f106-4b80-58e5-08d860bc03d2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 18:59:51.2037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqOkRrZA63Bn/713YFgFty8PDc8TznhyJs4jVVb3rkO+k1ArYyN9v2unHFuCxR0S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2489
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600973995; bh=O72tVkQYv3CHIFyFszFC1q9zk7iM+4yQpfCp6nThAh8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:
         Content-Transfer-Encoding:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
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
        b=EVWaFpCk6hTX/+XG3Q7aiQOYgwt5WI0rskoW5ODpkskN6GjnYWhJRouYSTU0vnRs4
         f88nM3VJlatgMZkb0zEIGod4z9sBoAOcEEXXdX+QPM40BxCcEgwqjD1jAtgDIbtDmW
         bFc0vapxKjCRsEAl+ieXk7UPOpxwJa5/yV/zz1L2s/U2QqbkiUh30cYioc3nJGpfOI
         3JjX3HUQVvLP7lW28j5H+O0+PsuvZ3clWW2+ZaxqYz0Ce/0T/Wd3bNyJM1WDmsWkwx
         V6N4yZe6TdGaLuhUq7ach65WEf3sODGjkmxP3jf3VvrR3yRmkQ2BXyDr4XtcusipWp
         V/TYhf7RUsG0g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Sep 19, 2020 at 06:03:15PM +0800, Weihang Li wrote:
> According to the IB specifications, the verbs should return an immediate
> error when the users set an unsupported opcode. Furthermore, refactor cod=
es
> about opcode in process of post_send to make the difference between opcod=
es
> clearer.
>=20
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 133 +++++++++++++++++------=
------
>  1 file changed, 78 insertions(+), 55 deletions(-)

This gives compile warnings:

drivers/infiniband/hw/hns/hns_roce_hw_v2.c: In function =E2=80=98set_ud_wqe=
=E2=80=99:
drivers/infiniband/hw/hns/hns_roce_hw_v2.c:330:20: warning: unused variable=
 =E2=80=98ibdev=E2=80=99 [-Wunused-variable]
  330 |  struct ib_device *ibdev =3D &hr_dev->ib_dev;
      |                    ^~~~~
drivers/infiniband/hw/hns/hns_roce_hw_v2.c: In function =E2=80=98set_rc_wqe=
=E2=80=99:
drivers/infiniband/hw/hns/hns_roce_hw_v2.c:468:20: warning: unused variable=
 =E2=80=98ibdev=E2=80=99 [-Wunused-variable]
  468 |  struct ib_device *ibdev =3D &to_hr_dev(qp->ibqp.device)->ib_dev;
      |                    ^~~~~

I deleted the unused variables

Jason
