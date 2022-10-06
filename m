Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3402D5F6B82
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Oct 2022 18:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJFQXJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Oct 2022 12:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJFQXI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Oct 2022 12:23:08 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E8CBE2EB
        for <linux-rdma@vger.kernel.org>; Thu,  6 Oct 2022 09:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmNgR+zo1lUZwWggGPm1PQ1GN2lx5pMd+VcaAdIPrrplCbHQ9qbK4q2C9Ml8Emm3Io+l5fB1xxL2XjsNBJHqoRA48ZT/iDMrGGKvJ7SxuoIAWM64vTUdnHM1Md/Y7fG1wbzwmlwDewwmLliKCmy6F+kKDrl8Wn2DMqYoTLPeGEpYsG1DdcPO/EYduHH23H4nE+fIUS+XfhShBKWlILJO3E0cc7l/i2aSwvSxIPTOzAwi85j6dqE6nSOaw5bV4MxRzi3L/+nM38vu56KcTGqmeDjKOKaswGNZp3CoLZsYxukx/Wry4Lo3Vix0kEfHQ3qPfR2ijjeAmL7T9Mq+2ejtRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vWcl/p90B2jgGX/HFEWSJD7ildD+WWoxmxLigDAdkY=;
 b=DIK6PhRH2Ajq66Pr/39uloqLzdlCDZIYGXPg0UI31cXxPw4fyvxBHbG4c9Xi8eHh90qKMWYYj55w6CIdjCYz/N7PwjD/b76C/eP/hJgNTcWMsVsxUiP2iHxP9SkiRg1PrnsIoyO1zh4Eksx1dpLGzXdgj069mavy7Qzc+zkdMksjKi4uXPMLCzmW1dzM7xnMS7oGnxVSKvTsskqSw60XJ2Em58f3OVsK/6qj6MIhOYlN9qH67YNcmQcKBjLJdB30riOORUHnD7BwcERM0r7DPe4pPvoEPhfCKZ1OSKgOCUKzvO9r+b5L46A6m49aeHNRT9vzx8N6Tj/DbTaBJxFnZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vWcl/p90B2jgGX/HFEWSJD7ildD+WWoxmxLigDAdkY=;
 b=DRDvGY8a3xeOzN9/13puq0UjNrvELZUvQOxGr2xIzFhjoEi02vWcNemPhpjLzqGlg0h8vIVF4LLJb8DcdL0U71UrF2lEImKK5MKPfUZH7hiXgmpmyVpQI6J2SOr7aMjBjUzQNcdRJHV85RGdnnb2PiI/x0cuVQFkQNekj4Ovklb0Rg15FkBiy8hwNThFboAHc6GVCli4xfO4fMrW2UdQGpBMAXrhlr/CB1TzTi74W176tYgrNpUG3ZyJC4XBI29yH9OUe9QIeZqOPy1aYWmdoiHWimk4TvJ0O5OO/dCKw8M6kx7euUdoJ2K9jHuGsG6Hfam0Fm4pL0NOXzTtyRJb8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4578.namprd12.prod.outlook.com (2603:10b6:5:2a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 16:23:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%5]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 16:23:06 +0000
Date:   Thu, 6 Oct 2022 13:23:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        Leon Romanovsky <leo@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] rdma: not display the rdma link in other net namespace
Message-ID: <Yz8A6az2rIjEDEGk@nvidia.com>
References: <20220926024033.284341-1-yanjun.zhu@linux.dev>
 <YzLRvzAH9MqqtSGk@unreal>
 <4e5d49fe-38a3-4891-3755-3decf8ffebda@linux.dev>
 <YzPkAGs60Kk4QCck@unreal>
 <fb230416-d336-cca2-24c3-5b804c50a10e@linux.dev>
 <Yz7PsMhkWMH0HXjt@unreal>
 <99a4b7ea-64df-7de4-2d7a-52e797644e71@linux.dev>
 <Yz8Ak/Pxz13fP4zE@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz8Ak/Pxz13fP4zE@unreal>
X-ClientProxiedBy: BL0PR0102CA0043.prod.exchangelabs.com
 (2603:10b6:208:25::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4578:EE_
X-MS-Office365-Filtering-Correlation-Id: 050b0832-935e-4564-9aec-08daa7b70c96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4tiyz8Ix1EQzD9lQcrO2IWkXg7z2pEChWN0H7EunkefWQR7JACUN9OsmPxD+jngh5BIRd3xPUf/sCRKyJR0JS9JWDjlofHf85HvVhYE6rEDEeplsD66+MNgttdfJKNjQWWZ20K76KR3dFL4sLfj6sSUJeLNtepT+m1KhVq9c7IfrEcInuKiflCfhwH+CTXNJWCy617wfhbMjVwptkUi/dELEHosCRxGb/6RztWYqjIOhvx1ziFmtZq9rsGDEvyhQfPE3sf+WOTL7Inec8qerTwa3PahkWB1Ie4MZ2Njwjr0n93YACpXt8fBvlEPFHJQCuohHSDaDeMY9K0I+mFcKti4mx+r3g2PHXtqmRjQ3jEn4S5ysKSFPAFuxz6bF43TryZaa6jGNbhegAStgIkfWsPm2JYeboj6H0OhyWh2TjxES9wrFHUQQONyArY40eCATLFWsdD152Wcxck1rn9PO2YWhxpSBQmx/6jQBtT2E6+Y7vIL7Ta9c0vlPOVCS2hyXDxfdoa9CDq2paf3ZTufP5FPsjZJ5OmiZqdm4U3X9gL9DHUA9l8NRfnUoXLWxRrl4JyLUxXXRfdSIxBmXhG1Foh9YOeXRdtqcu/eKGU3LmlE/0xXoZK7ZzArR/kmvYdOGaILp5p0Xn9r4LwUX6INLfqV6YFmPFZvTnDVxfrNwus2VjfotuEw/9T82oOnctu9M4Pgre1/p2Be7PMpjPWbKXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199015)(478600001)(4326008)(5660300002)(6486002)(66476007)(66556008)(66946007)(86362001)(6512007)(41300700001)(26005)(4744005)(186003)(2616005)(8936002)(83380400001)(38100700002)(2906002)(6506007)(8676002)(6916009)(36756003)(54906003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?08oXG/wAsSm6lXMG5PVVbP/YTX7hSrHFath5bao7ApnzM9sbEWsdEYXwp1nL?=
 =?us-ascii?Q?CL4MsMUDps7T32BO+a/cLO328cMvVotjK4Ic1LmnucC5E4RKZN6gavQu8yS4?=
 =?us-ascii?Q?0+rxW3nbQO3Ohhh+nraRd6OATDXJCBm2wJJSDKfaAUu0qSNKleOwToWgzDRV?=
 =?us-ascii?Q?0arWQVdbPmvc2cO/okiFl3ZSdgb0SamNLJIuwu72ofrN/pdYOaTzAWhx0YFf?=
 =?us-ascii?Q?M73INiP1tT/ThPo4PkKgNAP9FSR5Clro55NsFr4dD2qHTJN52u2eexAtqzwh?=
 =?us-ascii?Q?g46kHIichqH7wvCDPh7jt2fZSHwiu43yRGnr6+zT+g4i9ht9ix7SmtsLa2Qg?=
 =?us-ascii?Q?zEd5nGttopah2LAFa5SG02PKW9v/YMAPcA0P+gKKHxCpeqVWvWKJaXViZSBe?=
 =?us-ascii?Q?g+ZEUMFbYJRX95gaiEm0EhQKEMzDa1qZT/QzV1kZT3Wvu1SYUZlWweJ12f05?=
 =?us-ascii?Q?KFxW6ZbcQntNFAsDdGf4JL14dj9WZ2+/uO36a8z6JFft+xlbOs2ZCI8lBXqr?=
 =?us-ascii?Q?9j3ElyoUaQub38hpdcnyoTZak8rsn9YuPw48oc/p4gMxizE+EDHAWPeVFVzc?=
 =?us-ascii?Q?yo8mRtlSD85C2hTwLDapGnIIzpm8SYmw728E3BXNzfTsknL8WXtohn8QtpHq?=
 =?us-ascii?Q?7VVFoFHC0cBXI/Fm7GDRUI4hGsSCS4AF+jJuV2Ain18qMbD7bPvvGz7d72ql?=
 =?us-ascii?Q?Nk+vjqetC3sPXx2vxeWTkb7CTYmTnUgqMVIFev09jCSBh5YU/FhtS9KecVYI?=
 =?us-ascii?Q?oWwAw4eWOeUSJajL8rqSvhLWw4gAxY23f9K2bwKVbsghZrYG72raQMz5vLSc?=
 =?us-ascii?Q?HkcDlJKjcJJwZyox4RfiBeMkL/mTwKyrSCO2ZZ43KERUwHpLaK10e7kvSBF4?=
 =?us-ascii?Q?d0CXrGwhQyVY+eeODhAvqdGPKCjJiweBtBRjb/r+5yX6F038I7zn5mD1gC1s?=
 =?us-ascii?Q?wJ445vKE8Y5nQeRxPCbKWZS21YBfxXypqNquwkhCU/ClQZrff9D5hTI0g9K1?=
 =?us-ascii?Q?O4EzJqe1iYZ8uiMQ6CPHc3Mq9Dk+lJgneSynlXFsupaOxpQCcY52cdfKv54m?=
 =?us-ascii?Q?PzWz3LVWmd6LWEu46r/uWH1jBSuw148U5UOUU9JTB9i8JZNTOtuFyhG/CtBT?=
 =?us-ascii?Q?ZoFk3+egWUm9NPbW+woVr9jcyt0SOdkd8ZJjzI8ZG2GpBVAI91dcRkbRGDId?=
 =?us-ascii?Q?N4DWkgHtf8plErzI23bTdowXHzqFS8R2fykAcXmYvqlTv1Dh6jhv9YjAcJFK?=
 =?us-ascii?Q?ku7Mkgun/qUrRwCAc8cUWAbcJ4t910WF7YaxN+xQwPldpFOINuQIZaR0hvR5?=
 =?us-ascii?Q?l/WvghId1g1ZE5IAFVOe/74vIcNr3h7Y131zluKJF7X8Qmg0ykY9apleAct7?=
 =?us-ascii?Q?wY3kneDToCR08zmuyMUP+Z0wQu3TMg1w8WqMqsOEOQBc/kSnELIi5npGK5z0?=
 =?us-ascii?Q?nIGsaJYmEcDpc8jXio16D+7z0qTyLJY3qVxDdGJWXRIYzSKUxjCbYqfUqQ6I?=
 =?us-ascii?Q?7uekf93cbC9R787gYXtipy0l9Tbhlwf21O62Md0EFaN2RUZ3i+68260WPZvi?=
 =?us-ascii?Q?Ueqswp6Jb7yT0SuIZfA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 050b0832-935e-4564-9aec-08daa7b70c96
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 16:23:05.9178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpebQ6lqisrfnkXfpjoUiiCXHyesenjIgAYPr5P95nNksD19n8ILJEVBd4nE9lWo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4578
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 06, 2022 at 07:21:39PM +0300, Leon Romanovsky wrote:

> > And in exclusive mode, a rdma link that can not be accessed in net namespace
> > A still
> > 
> > appears in net namespace A when running "rdma link show" in net namespace A.
> > 
> > The above is different from others in net namespace.
> > 
> > For example, in net namespace, if net device NIC0 is moved to net namespace
> > B from net namespace A,
> > 
> > this NIC0 will not appear in net namespace A when running "ip link" command
> > in net namespace A.
> > 
> > Is it a problem?
> 
> rdmatool presents IB devices. It has no logic that decides if that
> device is usable/operable or not.

It should really not report an IB device that is not in the net
namespace..

I'm surprised this hasn't been noticed because it will break verbs.

Jason
