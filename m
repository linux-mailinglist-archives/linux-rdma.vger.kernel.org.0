Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A104F4441EC
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Nov 2021 13:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhKCMxf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Nov 2021 08:53:35 -0400
Received: from mail-dm3nam07on2071.outbound.protection.outlook.com ([40.107.95.71]:21984
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231343AbhKCMxe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 3 Nov 2021 08:53:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrsRAPjNgGxWV4eEXDf93HLh9q/jCjv2sJT/B8TC0mc0cSMgb42Pu9XYqFPYymiaIqct39AN2Z5ycTKCuiP3z6TULOjW0aSqodyrIZ5Y574CgEaF0g4RtFYgKql7j16oqelyDEAt/0LvQbzXr5ncDPMwHrUHVvXO/pG87/Okxpfq26bPbahxWxzs68/++oH55u2dO8kZeVgwZWuy54BNgm10lB1iRZE5BeScAN9O2YpP2skibX9RLJOPXfRVCA6A7CMRH155r98BQtrDO60uPyDtPeBHcED/MH7FFKet/xVZYAyCOSFLrEHdV+3z/mA5N5tHuGU1a43K9L9SdwoVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mj7VKt1L5zcv/W42GAx/0A7AUCkuj0yC94bc4ytZhKs=;
 b=KofEgfjO96xVpTPM8t+uMh7/Rc2/iAHEf7cLZa/mOQBCh6v9vbTa3N5Y94LXZVsz1D4BadJa/D0YL/ZsQNIpECWMJYlw0IQBR/z4oF+49TEgrvAnwp30hlfJgA7QUuz2H4UclY0NoU8eKDCO3VGbZ4/9TDWGiMtNootl/kDkd11Mflr1mJMAeA7P31caFuCVEe/f06le1k5pu5O4dzjLyrDAiRX2tECt2ZBjj97FSyjsKVZKOzEXJp1vVSr7L6QaPrlzeTugp3dfVox5fScwZUTcMis/1Xpzln4Ntc+HQXkrd4e8FeM9dn18BE1jPM37rXkJl+A7YhhKkyH1tXwemA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj7VKt1L5zcv/W42GAx/0A7AUCkuj0yC94bc4ytZhKs=;
 b=gjjd+vpuMObPdzUinJ83aOiADmOhHoqpAe0zP+hSzA5oVBUBw1nIONbLp1QCunhDRhTy4GvMgS5aFdEC1pvA5RZ/KooBHGBecnXDCnZNEtTMlY0JR3QGImhiYo8vhilc5pKZG3BMhfusP+5vo/nVTc03YOObq+Z1F9CtFaxuUO2iYgei1AyvabUr6II/AHHA4DwF5k6Ze0o7xpH64KGpBzMkUxMtm3f3UD9Gg4lpJfLa5XpjZSkrwkAwP/ABExWQZf9k1e/MP0ExRH4YAIMqf4w8ClNROF1s/RvyOdHPoG1rtijA0hjrH9YkoymWEywuX7U0hVaIgSs/IyIfDCaoSg==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15; Wed, 3 Nov 2021 12:50:56 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::8817:6826:b654:6944]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::8817:6826:b654:6944%6]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 12:50:56 +0000
Date:   Wed, 3 Nov 2021 09:50:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next] RDMA/bnxt_re: Remove unsupported
 bnxt_re_modify_ah callback
Message-ID: <20211103125055.GA1298412@nvidia.com>
References: <20211102073054.410838-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102073054.410838-1-kamalheib1@gmail.com>
X-ClientProxiedBy: BL0PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:207:3c::36) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR02CA0023.namprd02.prod.outlook.com (2603:10b6:207:3c::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Wed, 3 Nov 2021 12:50:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1miFjD-005Rmw-7e; Wed, 03 Nov 2021 09:50:55 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dddb7dea-a752-4a93-bb12-08d99ec89400
X-MS-TrafficTypeDiagnostic: DM4PR12MB5374:
X-Microsoft-Antispam-PRVS: <DM4PR12MB53747924D60F714FD254CC97C28C9@DM4PR12MB5374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZdl2b1gyEth4NSO45TT49Gmg0Jj95iTeFjK/qACDKBDTItIOpPg6bLmn4UjzQTt+tRdGgC9X4rnrcPacv2bU8zXImY/FOIHU/rv+bJccjkb0kbxoIM3zAYnrxDzXyQEArt1u2BdhELxsGQTs6mkxfXil2t/3AuPU0cWJPWe43SBva+fVpdX+O80VKCGB781NazoULg6Qkwht/lb6C4K0EGMp9Xiym1N9mHKh6E4l0EeZinubmHDCCBkzfhhuWcjo0AZkxf3KnDEQgump4Bpb0bdfSdoQOznFXRgcCZWE+ffZBeCvQbGBOjGrrXEYy28Htjt5JvA/aBSz+EGmmr38iSfGeaynr/zJvmGzQhljVu9qmCXzg0nv8CwDLpdHI/I/q+nUdFqC290MvMwYWnbSHvOSe1C8q3b1VPx7K9+RdwzOok3twrbSE4vPSWBgspBiQa7QhRH44Oyd5aGkWaevk0eMJzznEftPNdWIZdE7DzKKBTVg6xZImwHsax7hyVhij9D7NzsHbJ+4qkuw0CaXJ8a4XnTp8IwoqVuIrh3VtwSoMFEzOiOImWyLdboPElm54GCW3eUhyTjR2aBEud1M2qXZPBv1iVUiOoLPvfMY0NP/W/So0yyhkIdTysOfbTRtLdmaGImBEKhIEZcKVqWVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(36756003)(2906002)(83380400001)(8676002)(316002)(54906003)(186003)(26005)(1076003)(33656002)(9746002)(9786002)(4326008)(4744005)(5660300002)(38100700002)(2616005)(8936002)(66556008)(66946007)(508600001)(66476007)(426003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XoSzvZhBzRp9sVijnHuZYLUB4wOiZsLMpG8RcYwhqxxbSO/5rdvEwaaMAc5t?=
 =?us-ascii?Q?W5ho+ZA59hofPH6BwfXxP2KS0MbF282DcCEX0f/ZTPngQX1m2wMGCvgEl0ox?=
 =?us-ascii?Q?hdQW9Wf+2Nbqg9FQHrfF95pOnKWS1n1ypG9MDbgqxobmhyoruJK1msvJuSKy?=
 =?us-ascii?Q?s4TLjYQDYtSm5tGHklfJIUZp9822f8w9W/7HwHozbp8dq7jAbJJwpoW8XhxK?=
 =?us-ascii?Q?aTPFdFBnDF07WkPop1v5ib5ZQ7VVCNAGcmBS25B4tZg22alkOjn5ng0DNcW7?=
 =?us-ascii?Q?3iyVYdx8gtnihKsEkO9/SEKFU0T701N7KyxzAozX9zziGcbtk5MXoOH72ccN?=
 =?us-ascii?Q?sywHc+rej2LxS49XVoTgOXfAsMibsXqVm/tPSHLavpGmKJJKzXDcRTFNCWf/?=
 =?us-ascii?Q?tQItCjC5ZGOyD4FChrqWjBMEWYwlMDREm3S0K3jYyebWvYdeZMejRTAUCVCc?=
 =?us-ascii?Q?J1n8MNqdosaVz1eGX83elUY/TODJ8ZwK3ehpZr5hlX4Hdk41O5x30Qs3Pea9?=
 =?us-ascii?Q?VQ6dR5Bt9LLhHvLE6/h5eYKbTlTV3oY/v24k+XMi4uv8pcWepNWwEoq8I2gS?=
 =?us-ascii?Q?4d0PWcQarusFfpkEJ5u1dGY3lJKhod83QH/+BvYyXH6lGbIP7trRkS4+EX3p?=
 =?us-ascii?Q?8MXmbIslj/WYyNSubCCdM/CE3iYGWQhwZKUrQPAsNwFLGItAStgjNZ9LcUNU?=
 =?us-ascii?Q?w6j6+mDJrgNz+sUjWju10rEx20PWuChG7XRDnN/i5wpbHn3ELxZkcdvXqWbx?=
 =?us-ascii?Q?UVVonECCwUh7wZzC+01NSFZCr43yxnda+bmDLnN6OMNvzXoYdF+LfrQWsdkj?=
 =?us-ascii?Q?qFaC078va6T9ZDexJz+/zDS2eyRSnq2y2l7+ogP+pbb6W4+J5yztkB1gk6Kw?=
 =?us-ascii?Q?kruJ6M1B9rk54tfc7VvgYts+nGJRJpxCyMY9LfwsJq7ozZHMhfGYvenemwCx?=
 =?us-ascii?Q?bHEjaW+deChPNcym4n/oXPyxGW6cXTNQi5kXl6py5xeZU8NgTHmGKKJTkx7R?=
 =?us-ascii?Q?ST3T5X8cNc3OHdF++oG4+Mwn/19mJR8WiIcvp2bcTfPS/ZcbhyhOvWnadxY1?=
 =?us-ascii?Q?dTZdz3h/v4IxJ+irKYOhLJiop8qMYgZHOQMhbHrzo3f66wMllYOUAXouCT2r?=
 =?us-ascii?Q?GQzhbVYB6v7e8RLUgRniipsW2C3eSm4M/clHYuwc1E3918BnvTrXmEoAoKpY?=
 =?us-ascii?Q?2k5mGIyYYMxpujWhtEFZtdoBennDwX+hgwo2q1D92+tViUSXeOwrzR0ZD4+u?=
 =?us-ascii?Q?+cksRi2nWo9PRchKoN6K+FALSEf1OBkGwAfrxWSkDe5pC8NpYSpEaeOsB7Gs?=
 =?us-ascii?Q?Se4sIWc6HF8sFK0pLgKjD7q4Ep3GmPoeqGGEuHf/iUUrAcKSDUEX0514akpQ?=
 =?us-ascii?Q?N9PObrOOgGauano8iWUj82wMW9fU6NNeBNXYahjcEhwM94iYL+cKRZbTx/Bn?=
 =?us-ascii?Q?DKKqDe86Gs0+cJ20x2U1Mx+YNGpkLL+oUH0LNE7PYc6QwVZls4IcWqOsSYZ+?=
 =?us-ascii?Q?qXkrXOegpMsvUxRiGI/CkuR0R1i4LsRI5gw1v914XRsDzgBl6itUXtF/zIgW?=
 =?us-ascii?Q?rOqN/5bCMq0A0gfcb8A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dddb7dea-a752-4a93-bb12-08d99ec89400
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 12:50:56.7023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ab/b6ay+/Agj9Kh6cihKZULyiAtOt9zyb+NYc+cav6jsiefjLbE2r3sqI7BbhNU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5374
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 02, 2021 at 09:30:54AM +0200, Kamal Heib wrote:
> There is no need to return always zero for function which is not
> supported, especially since 0 is the wrong return code.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 5 -----
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h | 1 -
>  drivers/infiniband/hw/bnxt_re/main.c     | 1 -
>  3 files changed, 7 deletions(-)

Applied to for-next, thanks

Jason
