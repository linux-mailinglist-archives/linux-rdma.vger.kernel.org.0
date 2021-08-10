Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAE63E598E
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Aug 2021 13:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbhHJMAB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Aug 2021 08:00:01 -0400
Received: from mail-bn8nam12on2044.outbound.protection.outlook.com ([40.107.237.44]:20850
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240286AbhHJL77 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Aug 2021 07:59:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEzLtfmA0b7hhmkz8QgXAyYZbXC1CUlgYkSWopVFigkfp7GhblvJj4Kt1fJXLqOKZY4hkm+NDO6UhbxgqZZZlXpl09UGm8Lotq2rhm7A9nWMzsGToMlM67jaoPxU6pm9HTcxipi2GHDZE6kmUcQ9X9rfklZ91TOPqOHZlBVg66bbGF3zB2SJxTmBP1SAKiEhxxHuMWzanvYt2i9L2rN1d0fXVUjTG4kgmrYKKCuWW+c5Jf2pj7SPUQ3ahUBIQTyfsaeJxcgrapiGjsb0QJZ2As2uzhPC6xVQHXUiGdq0ohYgW+z0VHJ2HPhIl9o9cobWgTlssVhA+5WgSWARf7qN9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbB0itPBnG/EwPv98hDTM+lt6+3KWWNyhIIIn5kWIEc=;
 b=fvVLcSxtqJBDGk3fTsqqEmekTLLUILC+vJcdVQivoK0rfR2FUfldl1IeuX9t2hdH64L6BMcqOpVH6G3+scDz8X5Bi/bBfxtZjih7GUURHHPa0+/GJZhJQZKEq05g4w+eRioMd9n5n1EpCuqrXDdqYza8Sw29vhL/KayiTOxUevXJHeqrCG4Nv36V+MI5lxX03cQzpXTVDJon7j7BibmmbhlBLeD48vfvUlItpvR81Sk8bsXpBYRr/qbfA3eyU5a1gf7fNwSPtAZCO52CRYre7PNhC2cdUCZpvk52eHnZcwD4fWUi3JRwMWOGoeZs9BcQPiMr5G91qPOtz72DSdg8DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbB0itPBnG/EwPv98hDTM+lt6+3KWWNyhIIIn5kWIEc=;
 b=rDs1DpApMhH0rJpdQzLKGk1an1tDLi8gQI4SIw3bDpzBr/BwQ66V76FqJ/HkXc1KTkfWIIOHvbiWLHPNqNN8sVS41dWT2UDlWiPz04SBdUyjc6cswCkXs1nErFJtmH+bIJVNg7TijBaYlVuXCMu+wao84i7Z6wDSVri/tza210IBIABlQ4bk8pVzUkDQYozjOdiGeFn0yb3bzzftZKUql+pLcN37LsaHCAUbv5NCQUnRVD10XnHUcqG/ouMltJpDvukUJWjXHaxd96yi2o8ogWZAZ62AjTXS8AJqXjpnJVXwYZvpPS8fbWoJTBMnaME1c4M+Uu3Q0GMcCmC0we6qTQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Tue, 10 Aug
 2021 11:59:36 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%7]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 11:59:36 +0000
Date:   Tue, 10 Aug 2021 08:59:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core] irdma: Restore full memory barrier for
 doorbell optimization
Message-ID: <20210810115933.GB5158@nvidia.com>
References: <20210805161134.1234-1-tatyana.e.nikolova@intel.com>
 <20210806012853.GP1721383@nvidia.com>
 <DM6PR11MB4692155E49A76F8789881338CBF69@DM6PR11MB4692.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4692155E49A76F8789881338CBF69@DM6PR11MB4692.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT1PR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::33) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (24.114.97.43) by YT1PR01CA0094.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend Transport; Tue, 10 Aug 2021 11:59:36 +0000
Received: from jgg by jggl with local (Exim 4.94)       (envelope-from <jgg@nvidia.com>)        id 1mDQPt-0001bk-Fc; Tue, 10 Aug 2021 08:59:33 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f2eef36-0836-4c7a-4ad7-08d95bf652e1
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5505AB8E34A0B3BBF857D1F1C2F79@BL0PR12MB5505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j9B8Pn3wRE1zDJcf+Ov4pC9/jOtJIe5NgbsDXcFuVzFP3+WZU7RUL0SMYphJlaBJvhhQi82aBCfB4vE76Pz82SJ2pvZ9IcMVbZ75sgcVHGRxoZfrcEJng77NBw36qKuSAtZSVZNLkxeAs0ufb4dORb8Gh9O2JRR3Vsky2rPM64PjU/Mc5xQcwg8MyfOK1trv0IlrxDtQsQscQXHUFT7Uvvnz7Fe4cZkE4RrERQy1MH5v8N/qEkgPAcbQ4R7EGneGa3Cp0Bit1VKO2T3Po+cnMYq97YBpinqEB1YzvrAiHpOav25qcZoRw3ONtUt1lbK0hC0ndObbYTlGqC2SjSdt6b6A5/F1qNTRaMHmQ0YZSoIWBhmEBYI+ZuADaE5d7JrUqAcHD++v0l9dpY5PhQq5bKvkoLrp4cw4w8KM1ZeWtjL6XdJp6p2Ykzi/lgkl/noxX1RWZvwqh+y0zuOFJvk78WWW2+HDiHNvXnoYkQz8Syqlg5hN0VzoB3m9vbkzQ2qQgzdHZI29E8nAwcpz6DmcogH38grOgES88zMf/xjC8P51sE5vhYvICWP00agn/MmV7uXDoGjmhKGBiMqE3rxzg38tx2/233jAv14Flyqbx8ciPGN/KrglbigZeccVfirC/jiXAwOg4e757D9HDahl3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(1076003)(2906002)(66476007)(38100700002)(66556008)(66946007)(4326008)(478600001)(26005)(9786002)(5660300002)(54906003)(83380400001)(316002)(8936002)(186003)(9746002)(558084003)(86362001)(36756003)(6916009)(8676002)(33656002)(2616005)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fcNnBw9xhRtiwjSx3PfmyS2uADilqrtNg2uyp4zk2EXZXhCkWMBFQg3T9ynI?=
 =?us-ascii?Q?zEjJJGGoTovxK8BJdA33kzfz5DClxsCgBMpYFN4Iq/Ctd+qF8JFzCLtVx9Me?=
 =?us-ascii?Q?KtqdGXIRzA4o8m3nuMIEKikOiUzMCvdolYtoMSRs/Geis7akF41EGezI0/oE?=
 =?us-ascii?Q?eNLeNOYrtMnmK0V9DVahhnYoIpk681h8FdMAxqPDc0BZ81KwM7G2Ye3e4PEz?=
 =?us-ascii?Q?P+0YL9TXIM6ZMuGDPqCMy8DFRgO4fOZAOednmiMFFi7VlHVfcqIinrP4BRJO?=
 =?us-ascii?Q?zqaczbn51qC/lYj7QnE94ViTrzKldaYWaRs+rAYC1LhNoZgr6CTsceSJsYHt?=
 =?us-ascii?Q?3nsPLyp5h3g8sVJVyv85P9Gd23ja3LqQJWWPYV8hU+jGIL4cAXMzuh++7VyL?=
 =?us-ascii?Q?sILU0xw+Zo7KYNau9Iq23oY2pUxm5/nT7AqbS1/8hyCADgAWkpWC30G2V6Ng?=
 =?us-ascii?Q?aVEtf909yLq62viTTggDsTKL3QZMwbxpbvfw8vTPbw0NexBw7xj72VPgQ+C7?=
 =?us-ascii?Q?4iv7600AnI15ROjuEAznl83YmkgYWuKO0n8s7WjQfzEfwnrAo1PNXYubFMeo?=
 =?us-ascii?Q?MpN2D69WKWifkMtBEmqtgAE1MPHT6q6rH9M0cPNjBL06Z6l1+XreaTdjH4NH?=
 =?us-ascii?Q?n6YsfTZwLsWGv50A+rOE+pfEr1LYMQmTF+xDs3xyGd4F37v8rweRaa3DSR2F?=
 =?us-ascii?Q?xs+HcCTz1x4bwM+myjcXYMHpCfhJKj+Vn/YMKhJXfnJ3P6O2Nr6lHuJbaLHv?=
 =?us-ascii?Q?WS5r8hODpI8tvBZQsBfcvHY/AQ6gtpWp4hQ7Mkk7lEHtOchBtpd+suS4xnqV?=
 =?us-ascii?Q?Q6OP2Um9pDg3UgESRh4ilf07YCkNcGCq/29MnTYMybaOhJSXtBSiz4rHmFXF?=
 =?us-ascii?Q?4TjB5GfoYwFyfX/MO85KDdDQR7lxl3kroplZ4o2eWfpML/LaJjZ5n7NX0/vE?=
 =?us-ascii?Q?4k4tb15RsDJfzZnJkvipxjueEVDrUyVgWTcGcfsLu+7KkiAVDcesACYcAvwb?=
 =?us-ascii?Q?SZQiqHWX/vJyLd/r3SXEQbB5x8ICUJ5uqPT60b+aNGibJhBD2QfcZ0SKTPUL?=
 =?us-ascii?Q?bDzp3Z1KzwOLzQIzpMFjy3H6mNxT/LMPe6d7Ry/QyXacP6Xljs3S3JvhReyz?=
 =?us-ascii?Q?9mv6q6UPgFG+TfjEhw0FPWanOVgT3/4SiYEhXOO/LiTqhhoArvjr/nEcVqCV?=
 =?us-ascii?Q?Xmqf2ZPg32u5wpcGwrJZMLKMedNLg/1b47Sa/aVIWBLOtRwbbpaVNZhv7G8s?=
 =?us-ascii?Q?7s4oWIrUNnVjikFN0Ku33PNO8riKY4byzdgFTOvq07PXAQZ+7t9dazkQ0aMJ?=
 =?us-ascii?Q?/tvQOB0gM/74ISy4bz+StnpD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2eef36-0836-4c7a-4ad7-08d95bf652e1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 11:59:36.1728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUCUGQX3s7pC9p4tZfk4kpvfxb9M/cHzcWPxn73ibw+zY065fidsA3MVyAioEPVa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5505
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 09, 2021 at 08:07:32PM +0000, Nikolova, Tatyana E wrote:
> 1.	Software writing the valid bit in the WQE.
> 2.	Software reading shadow memory (hw_tail) value.

You are missing an ordered atomic on this read it looks like

Jason
