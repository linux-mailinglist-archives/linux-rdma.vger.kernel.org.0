Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD5664A09D
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Dec 2022 14:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbiLLN1m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Dec 2022 08:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiLLN1f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Dec 2022 08:27:35 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0810713E30
        for <linux-rdma@vger.kernel.org>; Mon, 12 Dec 2022 05:27:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goMU/l1RO10qi1bH3hQvansvv8LfNoo1fgFyxgxFYItPVNLVx00L1ll+AJbSJsI5hRkT3Kw1zCrIZC/M++FPh8RQz69ornxEZgwu9HTNUvnXGwd1+Z/MXauWLx7U46q9Go2AmNyUBT6T8YwejDupL0HGylUsFiW8pSGUAXwmZDSb0/pYEIr9+jZAYjxv/UBW2SEqFMXh4lQyq4p/7uoXFtsfaK0NWKq7vinp9KPKVPW+6OFj3bOc2rGJAfcQg06+f5weo9XXqmk6N4xS0oCMd1PT7rlb83aVmRhNtI4UfZuSbLzv+Aj5QcYcoi7+iZJAFHGr9uSA4n967zOuO4kEUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6rrWiRGyXzN4yWJKitNUUqpDldBKJ6X0n/E+8ThBvc=;
 b=YyqbwqYN0rppagBS2+NqhOBCo4FAnEjAisSOeMfR308l1XurX4sRf29etAPVaLTwl/Ic84qStQSGY7RlX85u37ejLoblKXGsb3NNQ0vV/CLh+mKEGpXO3sqYfAQs3TEP7Y2+21H0MvM8UUkWPiMz4DLFTt30PGVPvlm/NYq2L7ftNerjP7cu4MvrfMDmm5e2jZqM2EK7uEiozqbLlJTVA1EL+GP3cDdU7/9gdQCEYaopQpluQHVv+f11NASBCrKCMwhKR5glJEQdSJB4sWLkGi1bl5hM1Yqf3GpfZD988E+4Ah5trW8tFyHAtX4ms0kMJIkfMg9pDgjbFU8dvizVBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6rrWiRGyXzN4yWJKitNUUqpDldBKJ6X0n/E+8ThBvc=;
 b=sPV9T2EdboFKx8YMNG+Zm2L75et2PlbNRCmK2vBfQYveSF02WbW6lvXvyEmqqYd1bnogVDYYOPAkvT07vWQsEjMYQ33B8pMAPRqY6f9tl6ckgayQIXV25nI8lKgmi5eIeHYCRejfjmkk4ARs2D8OCb9bgYsuzf7vKYrI3rWhnbAiS9aMfXl5qYQ2/tRENl6JsZRKl3mfnW5fEGpYsOcXYfJlzGevsUVNYBUZNh3EhDqxhEdah5FXxWPbJqg/jJJho7jcJdAEh8yuszEq1d9fd7hyRZsucQp1aG8HEHy1jLjY0VKsR+YqF49r4CSab9/lmsR4i/N5WwQPf5KZz2msxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV2PR12MB5894.namprd12.prod.outlook.com (2603:10b6:408:174::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 13:27:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 13:27:26 +0000
Date:   Mon, 12 Dec 2022 09:27:25 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Wei Chen <harperchen1110@gmail.com>
Subject: Re: [PATCH rdma-next] RDMA/core: Fix resolve_prepare_src error
 cleanup
Message-ID: <Y5csPTRDNOIwf49T@nvidia.com>
References: <ec81a9d50462d9b9303966176b17b85f7dfbb96a.1670749660.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec81a9d50462d9b9303966176b17b85f7dfbb96a.1670749660.git.leonro@nvidia.com>
X-ClientProxiedBy: BLAPR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:208:335::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV2PR12MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7ee37d-7f2d-4594-003b-08dadc449c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/PA0AVZX89lIPBKcemJT4NT0uvY4edpI42VryL9X5AryZVdRM1gWn4WhCHQkNqVZKcmwc1/R0ZMBN18/uVQFvV5+Yj1d75hlvP9Lu7UWc6vBjv6i23lHK4Snx9eLo65anVsLEtk17JBjXMAlFuZxUazukdVT7bTVbvHwaUniM4WzjaZgTHnPyJPqhg6Un4cd1ZG7jJ91YVKgklmDUscYFKOVaVmMe59rA1LZ/nEIbYVUQSp7ndm/eOqUM0b7SmAnyfY91C218TSmdkjugwfWHkQM7KyPP4OOpGRSw5dcaNVMHgsbpm+hu6air5TDylQs3KpXfJT8wudBqZVWLb7Wgx9iHE4wyNzJ4tzSaLn2rPC80JGb7T0gj3GnRnxv2PjRwh42YOsaB4peDAcGufw20rgcxcFvQkpr2LwbiGyRH3fv/JablQz4NlezlGmbj9rjw49CwwlTCkEYJzl+Iu+r+FhUoCc65Gb7f79t4bpLDT6xkzFKjSfTz2zZCDi9lYlIGoJZKHXf0mR1hCHHrifu5LsuqtPS+vWuxxqy8jS2CzpRg+5eozCaQC9iyv2p2SHpgBqbjsMSZl75B7GWeYcQNmglrXIYCm57/lpjZ3cJ4oW2L5wwplKQNH0lKJ0kMChrBHmZn8FABLAxESpwmbysQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199015)(8676002)(66556008)(36756003)(66476007)(5660300002)(66946007)(38100700002)(4326008)(86362001)(54906003)(6916009)(8936002)(41300700001)(316002)(6506007)(2906002)(478600001)(6512007)(26005)(6486002)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V99W3m68zryViyPi9TaV1/oZGCvfBNUfHJ+xUf/kjw27jdxX9WS+I9SauyJ+?=
 =?us-ascii?Q?BFPrwZek8I+uCv9CDlGUnJuY17WToOo3ADs/H0ghAzZHSes+7wXoMEjBp1VP?=
 =?us-ascii?Q?8OmSMU7XqaFKiiLEEXeHFhYcE4wvI++UFE9FTd8YUEbXXplHxDwuQ08rdW9D?=
 =?us-ascii?Q?yoqlwb7VjWoeOXOdEKngEqBDQ4iAUrPoF9h0NrYF9J4x2R244ZZ1bbx3NQZu?=
 =?us-ascii?Q?x+hpQVafBJG38LkJUrm9681Wh8doJIATwmk4A4bzEjG+dxfpUOFWYEetEmMY?=
 =?us-ascii?Q?vJEPJGiqbLap3OIuKKk6hVtAdq7iOlsg7hT/UM9j4tXzpgaFuMJdJj1uTQPa?=
 =?us-ascii?Q?xL6OSBKKMiUBxn2pJGB2rvYdWMR9KamslwKZHOOtoqLM6psTeklhYKFcVqfZ?=
 =?us-ascii?Q?cXBg5/uorgbVXS7M4JV1Gj0aGrIc6W6pSBEY/aWC6FtKykNXty8m+gstzOyt?=
 =?us-ascii?Q?PfCdLyVY7r9/VcaI6IHi1v0CXM2VcChbLEfzgW4FRliBC4PSBpagkq3Zv9Jm?=
 =?us-ascii?Q?cCuPkActWNsijiL4kMWyWA6ITfTNiOcH5tFutmdt+6pTosBFKbOJ/zl1V+3+?=
 =?us-ascii?Q?m6BtymmBj+sf4ZySGJVIiFWtQgo8vnenzRFydRd+gaGepeXYxnKKHGQ0JRGm?=
 =?us-ascii?Q?a5KY3JLc+eOS/ymzL4rR9/DxZGvQ9ejW3pa0s6OQVnAf9Tb/y9FhznZNxEWD?=
 =?us-ascii?Q?xzUY+mCo5taRIqFqw/oTcQZvNZ7Y5Ww0Ua3oIIcptRBVnAfCGbID11OvPIx1?=
 =?us-ascii?Q?mssdEaA5Ypi90dQaQ1BANyA8AANOGoULUh0CglPojMy4upJDCvn9um6PAYmC?=
 =?us-ascii?Q?OF/XyUvMRgwf3WvsZhJbHuXggQ5n79QLM7Jslk+gKduHK2UknclLc0rg1qU0?=
 =?us-ascii?Q?gzzjLPrJx9tm1sNPbiIOnNvfKDD4QQot02kQG2E3j5TD7F+yyJDyvaAqfFme?=
 =?us-ascii?Q?6Pn1QHDwrJl54VDfNqxobOIgwu39UaSNwDT6dR+pTIZ21VXOVxCVz9PC3CX7?=
 =?us-ascii?Q?D7OzUAe0ZKY9z+ajvZ15eRVh8gjO0VuWFlJEj4mBjMNIeRIFyzewmL0SZIxH?=
 =?us-ascii?Q?AE6SI4S8HkV7nen3GSfGKEmgS2+ESGvs6oApAbO3mOsdpSlX8FrOdlnYPpyK?=
 =?us-ascii?Q?Th2MOg+0XkJFza4GK+Ktbhhw8SRGe79tUACiRrGvf8Jf5lN7AXAa75ek5OcM?=
 =?us-ascii?Q?1jEMCEHGEdulAFLT/ecYbzHtdCQJYeIcFoSAsuUPDdHtl+2xAra14znRubqz?=
 =?us-ascii?Q?rDw+UrMpNoRsHts2anl36iwa+ZQ+rqBgnradxa/CF+yEvtN66++QjAU9DwbP?=
 =?us-ascii?Q?OJr5ebrIxcDWrOElprG0w6YEx5xjPBz3gf1sleQxDjlDFLEmtY1L9868LjEy?=
 =?us-ascii?Q?bZ0/JbnPvLzkYEC1WtlrF/eYE16Gihq03E3m8kA624Dz+rHYI1HqaPrKxJ03?=
 =?us-ascii?Q?HezLNmxvYIN5rDbHphR7BBdegV+R1DmS+FBYymcAfFMGv1pLl9O7F1G4xKc0?=
 =?us-ascii?Q?hG9a0fn+DjlvipVGbkRKNxZTfh8H4bHU+qFrzTjbZaK6PyZSvNy2K1wlzn8B?=
 =?us-ascii?Q?PYDq31XxYGzS+MgezwA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7ee37d-7f2d-4594-003b-08dadc449c0c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 13:27:26.1046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2+uNqCRx9Bb+pzo91aQuY/l7EJCpk57LlIVuQhosSzlT808yUb2vcWp124yibti
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5894
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Dec 11, 2022 at 11:08:30AM +0200, Leon Romanovsky wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> resolve_prepare_src() changes the destination address of the id,
> regardless of success, and on failure zeroes it out.
> 
> Instead on function failure keep the original destination address
> of the id.
> 
> Since the id could have been already added to the cm id tree and
> zeroing its destination address, could result in a key mismatch or
> multiple ids having the same key(zero) in the tree which could lead to:

Oh, this can't be right

The destination address is variable and it is changed by resolve even
in good cases.

So this part of the rb search is nonsense:

		result = compare_netdev_and_ip(
			node_id_priv->id.route.addr.dev_addr.bound_dev_if,
			cma_dst_addr(node_id_priv), this);

The only way to fix it is to freeze the dst_addr before inserting
things into the rb tree.

ie completely block resolve_prepare_src()

Most probably this suggests that the id is being inserted into the
rbtree at the wrong time, before the dst_add becomes unchangable.

Jason
