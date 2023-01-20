Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D274675BC9
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jan 2023 18:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjATRmq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Jan 2023 12:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjATRmp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Jan 2023 12:42:45 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B956FD07
        for <linux-rdma@vger.kernel.org>; Fri, 20 Jan 2023 09:42:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9vian7nCoJ9hA/Z3221T3bNLnkAa4ijauPswsVw8Klrokx1nt6tFY9gYQUvQz1MFUv6gGVxODB1TmdXm66Vqndql2we+FKeuZVPrjmYx/2Of7Wqnw5Zc/aNOLy3Lb4H7WDoDm32u3NWl8JcXWrXiFXbLM23/HR3uMAwWMtTtRgrNuxFFqEXkc+ebgR1H6i6cW25UfP4I+kTF9LErWy7bCbHKniPJCpVgDyem5rmXIr02UwcBEc4ZIOM0GENumw0ASk2PxMGuiSKf94nAg9O+ocBBu25vdoF8DD28K1ezgKDqG8y+N9Ru5cKNV/Q5NygizWVSNCYkyvif8Ej9lgQrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2dGSepiyuzE2H5fiXFGQWjMwzzvoYsKJRsvGHkOo8Y=;
 b=aIHuEk92JRX64ZJgC39+2QjknxAPWifI4Y5HZKh0TQrV5Qip/8EB1LCalS0Qh+oHgvh4mB1jqn2aAb5dQqo0S5bw6pZF0kmKnyN3RR/twllLMRLBqOByfFaOwbtxrRaNNJw5edYauAwdXvOYhFq3OE6EcwoQK5jpNngsANCUOckvMWAoEPP84jpdW1CLgbyikjo9EdcCANCjJXxNgQNTfj5e09+tIDbBv5ORGztx6ldybbDrgcEGipw//dc1PGP41bd8I6pmXMBUwy3UoCKGOztEmePaAAZNR2F3zkt6hvv9tWBFKUcHzfMTD4YjdgOHAyECXAqgK+S5nYzdMc3jqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2dGSepiyuzE2H5fiXFGQWjMwzzvoYsKJRsvGHkOo8Y=;
 b=WI3z3iRSy/c16eZx6YSMGeOCaNbDWYwqtbuFyQEk5W2iQXNXvPlFn/sT3OuPC77mcJOatN5TTp6Hkarlb2TlALdSsagUxu1vtkzplu0oLqOCY3Q/lEPaNHRK/0iBvcJl7KKXlQfVm5WB+R/rFI93PU02rCJJ5E32yeNalTix7QRyzKqNm2xqE5TAVEH8xsLTFIPzkg/7bF/azGNfZkGY0zkITWzs1jazX7EERQTQDBfuZ814DFzP3FW7ZUo798wMSCZBr3uSN9DACzJv2PdD0jsLKWLG4+BU6VXW9cdAerV2xlLZy2CQIYUP1kmA7ZoGvLcZHOK8b9YLGDPzd29POg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 17:42:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Fri, 20 Jan 2023
 17:42:33 +0000
Date:   Fri, 20 Jan 2023 13:42:32 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/7] FIXME and other fixes
Message-ID: <Y8rSiD5s+ZFV666t@nvidia.com>
References: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
 <Y718/h2uSTYq5PTa@nvidia.com>
 <3cf880fa-3374-541f-1996-d30d635db594@cornelisnetworks.com>
 <bce1ab36-66e4-465c-e051-94e397d108ba@cornelisnetworks.com>
 <Y8Pnn8NokWNsKQO/@unreal>
 <472565cb-e99d-95a6-4d20-6a34f77c8cf1@cornelisnetworks.com>
 <Y8T5602bNhscGixb@unreal>
 <a1efafe0-1c8e-60ae-cc77-b3592ea5b989@cornelisnetworks.com>
 <Y8rK16KNpj0lzQ2a@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8rK16KNpj0lzQ2a@unreal>
X-ClientProxiedBy: BL1PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:208:256::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c475d6a-de09-4364-262c-08dafb0db5d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ssCEG24bDtNJj9nD6zyGbrd+MJwhFQlSAhs5Tulu71mJQ/BrnLUmhDpYF10umtEPqLZ+/55OUmIrx1g7OM/BNplBsxFDyUNPgBkh/ts9GxUaz6Bb6Jcbt0y/ScpcCflLi3A0H4Y7FfekzTI+SaR7J7dTE/ul5eCfpwjUmlBvk90snwMHT90B0WlgPD427ZYbCpJ0K3KI5ahFbAZau7/pIf+ujP3CiHjcA0Yr49nyF9n0Jttp5b47+nd1daryTqJupGjKh843yeyX6zbpBqitRAowz5hI2BlXtvc4TjDxZu1PXB5Is3anakHw7OJjuzYFaQB1X/MEtLur9sJ/3v0xtgTNbiL5arj73ckm1Xps9I698C1UZwIQXHRwuOIk4LU27/NcH8S/dTTq4T/mGCOmZ2iB2X++5ML+oWWjqQ+Be8AbrCjaVpMeTHweAjfe1olX8UuHT5kzajnybjbmlAIsJfnZZB+KSyQQHhq9AJjG2+sNnLK/pV92pvgwNMyarkuikqTBnb+xpB+zyqKECazeEa10HHz0T+GCMV7eUYyyQ+AuogpH0xYOWvBiqtPXLxM3nNQbb2zivg9Vu6MWXeeGp8ijXTFVpw9ZK/9Xpf2tYETcsOFw6VPjfIA39AgiKo7FcJglPd0MO027DGFldkEabgooQe0aQ0Ekp2uCS23JfWQGspXmFEzkxiDA/s0lbzt/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199015)(38100700002)(26005)(4744005)(2906002)(66899015)(86362001)(478600001)(186003)(6512007)(66946007)(6486002)(66556008)(66476007)(316002)(6916009)(5660300002)(4326008)(8676002)(8936002)(41300700001)(54906003)(6506007)(36756003)(2616005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QTXPtM+72KmWBh3r3uYd5a7yXMMhTY1Tj/ayUXdweGo1UzKEr/C9ePLZwsL7?=
 =?us-ascii?Q?Eyej7rscMnL+LobMCG1iGckJjKcLjOWt/XXXh+Zvqdcvkgx+Cc9UJy0y2e4y?=
 =?us-ascii?Q?i/cVbHvIsUUjgIaa/ZqZ8xv5qK7mGc2BsUe6XcWwkeramPrSvAOyDaFjnldT?=
 =?us-ascii?Q?QIxL8FsF/8lb35QZ8JoLM7kAe9dbdSnoCCw+8O0FRg4/gaiFAhCVrKk126XK?=
 =?us-ascii?Q?5K9unZXRJpLj1SjlcPv0rZokqX28CG7JAKaGNDK9DCn0mhwfpdULBtyZGlHH?=
 =?us-ascii?Q?suWWhLZjiflvsZZa2QFrWHjBeSzOiug53MzNqm7BMUp9t3O8hGlGaymNAJ7X?=
 =?us-ascii?Q?ykZIX33OXk2m7loh4kqoGSKhO50q2YPSYwHwQbVQczgMdyPYtEy26hfu1nuW?=
 =?us-ascii?Q?IYEehtauVwl1WplH8seyLziBSBi3+SFc+IWNbd6sfCS/8ja8X1XLOJAYZuk+?=
 =?us-ascii?Q?FnUO6YwjYHkXr6P8UVIR/j20htKFxbb/K3CYSjvdr40hSOWZPAx5G4SpM92C?=
 =?us-ascii?Q?sJE7u9KXLKsMonfb09g/IClYN8kE62ReqdYSubOtrkUwWI4arIj/I0YlWXjB?=
 =?us-ascii?Q?ZnbZXSdmLb+QbI+U4KjFkwiFj0XsVRpzTVxzvVFeKN60Gofwd7iB90WFtXVz?=
 =?us-ascii?Q?r5P8R/+qnHi+K5Zqf61ZN6OvbTMA9Dv3S20a9U3Duu4Sf6iaTa4VMCiVg2sU?=
 =?us-ascii?Q?L6o9XYm5+08znFtA6nUVCopn+jOi2Bhh25MSB2o+A40QQDhAHxUL0IK6Xfgy?=
 =?us-ascii?Q?b+GoXkZ6PLlQ9k5cVTNqBf4VKdUUmhALGe6fLdLyqXFODHzOe+q+Ifzqqe+g?=
 =?us-ascii?Q?RCJkD3pMLTDMSCR9yJil6GJaFRk0JfV2+BkakAkvoH4CyC7TsmCqWnOAAtsa?=
 =?us-ascii?Q?Sk8nuRp723Kj1Q4zkkh/lBR6FSiiewQVxPASyv7o1S+Nv6ggZOzZ5YtLlu4L?=
 =?us-ascii?Q?I75oUhqLujZhIbrfmifyyUbfIWZqi7zgKkh1euFEFTLZQPlh7JaAhz0xpKG2?=
 =?us-ascii?Q?0Pv0OX8VTiDxVH7jb8DS99OkOMIaY0RGekZeq2BG7qaxKoclj/Zh578Uq6lj?=
 =?us-ascii?Q?U8gACEs9UxgudUpiR+1mN3izL6I4duhdayqSQ83kE88/el3ssZ/rKyS/Dv6C?=
 =?us-ascii?Q?HkPuAPGylCyyV6hVVQck//P4I3vLNYFtp6iIsQGk5csq7ld/4otRxmGG9LWB?=
 =?us-ascii?Q?lrEZbgacbgUB6jQMiboExP15Jhqhpck1Jx6R0SPxcLiPuFTqBG0xTaUw6oM6?=
 =?us-ascii?Q?oPc1SNCa3e5pYTkycmasJ1k9S+Cm+2FWzvG7qHIwELFpDo6TQlNc29P0o+90?=
 =?us-ascii?Q?1RHmMU0vqqrrjoCBmAdVX9AIF4zv3AIQGDYQuvzLOgvxShlrbvQXponesXr7?=
 =?us-ascii?Q?O6TxUCKveWcW/ST/4VAgr2VKKWfQXbqkMXPa24S1hV4c+NC5B7vhpU3c2lJD?=
 =?us-ascii?Q?3VwoR+1bvZfkRd5IviPn1uQfwokMqw7O1qUdKlf3rNIm46NqYbcOGyBlCeXz?=
 =?us-ascii?Q?wGlqIlLPpzsysOrH7nF+FM3HU+vawqoPrjbcIjJnifVhBKRW/Wo5jxa798c7?=
 =?us-ascii?Q?wzNgsDXDJA6uPtbyj3fDaLTuKh07XMY3DTQsnc9i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c475d6a-de09-4364-262c-08dafb0db5d0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 17:42:33.1216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVVmHxkuuTnVql5nGF6JfTAYcl0FvKpd9NBL1E3zqoNsHpl9AwJ6CmqJP1iPxwRC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 20, 2023 at 07:09:43PM +0200, Leon Romanovsky wrote:

> Backmerge will cause to the situation where features are brought to -rc.
> The cherry-pick will be:
> 1. Revert [PATCH for-next 2/7] IB/hfi1: Assign npages earlier] from -next
> 2. Apply [PATCH for-next 2/7] IB/hfi1: Assign npages earlier] to -rc

You don't need to revert, we just need to merge a RC release to -next
and deal with the conflict, if any.

Jason
