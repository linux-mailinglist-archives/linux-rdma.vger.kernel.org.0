Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12184C1BC6
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Feb 2022 20:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244308AbiBWTPY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 14:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244322AbiBWTPR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 14:15:17 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2047.outbound.protection.outlook.com [40.107.100.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3677A427E4
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 11:14:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7dR2JP8fIuMeg/5MjqLIjmI9qXWO49DB1iPeyFiJdfjCRLUwjunuH2jAR4wxlDt1MqC/MV4syq/cS0UPtNmpHGt79XwmUmzGrbQFyKfUCPCCAGkMkz9DFUe5oxiDDWO/ghKxSpxkq0yN4AVHxKG/w+bjfQJBQCtCyM/R07KJWYd8ECFGBjGRhyRx6mlrdd2RkFFZ9R55BMjG1uH8lnCD8UnqknY1J9EhFriKsPwy+3ooJeJU+CDSbjbNDCuoN8nlRQJNatFo74L0Ia5z7OcYOoZagMNjfMQCmcXyyOFvtoDmyWtP69Ezs6gnnY2Z4izgR+zqsokhzP6KE26q1ie4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VEYyUcT1K9E4DbmFqNCBhwz+xhHyk4LDySbBKjTqDY=;
 b=BfxN+DiDoFQ7erQDFtnDiHiAIyzUxrz4+W2dYd3kyQ+Kg4j5cKxEj7U1SlxpHqq+lpEHJ32cbe1jEzWv8E/EUMyjfjgNLFzDEg6MFhCty5yzPdhERC0ZNSKUHOTJGQfsm5a6GpLzlFB2zCHdzobZCGbuX+wJpPXcwxCvJIim9uXMtsiV7jTTdXbR8PmSPlS0nlmN2ix4UvByzGDtjDfgc4Pimjwnc0LMQEoux6i0c5nQqchegTcbB33MdD/taIDzd5siW60Ck9raEU2QN7DJ1iIIMKimS8kAFUBn/X31xQl6WePb5aBAQK5gJ92QWJ3ZWUCEsX+LqR0jaZNHZAkOtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VEYyUcT1K9E4DbmFqNCBhwz+xhHyk4LDySbBKjTqDY=;
 b=B5ADMhWdS+xWJOuJlqooMigyP6tTvAj1PCP4HleTuSE5FnX1Z3aDtnTXxNsr7wVPMlIAmIoTB5B3Yjm+5sH1AbAv07gOoTns9uunMv8fgekhFfs9tV35LJWHFf98vgkVcmYGlriaOxRTE4w9MlVwQYs4IMBRlOlhaxRt7Zn0aDTUKCESZ3fb/kMb0GBnDTQJZEbv8qFCW2+4iLDTZ6Z9/M3zD2HN4XA1oUviyb+k3vuX0bEwMfh9+O7P4tyTATYzrjSRQ5Bz12KPhTlfqLP5nwtJYZjxGGnCZGRP6a7r2ymWYtWoNUCII3wJkrGcJXvPHfZIp8pzE7w28ZkGBx1mYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB5183.namprd12.prod.outlook.com (2603:10b6:5:396::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 19:14:41 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 19:14:41 +0000
Date:   Wed, 23 Feb 2022 15:14:40 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH v2 0/2] Fix a deadlock in the ib_srp driver
Message-ID: <20220223191440.GA408623@nvidia.com>
References: <20220215210511.28303-1-bvanassche@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215210511.28303-1-bvanassche@acm.org>
X-ClientProxiedBy: MN2PR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:208:23b::23) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64ede6ba-87dc-419d-9eb8-08d9f700be10
X-MS-TrafficTypeDiagnostic: DM4PR12MB5183:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5183FEB4865CD79750CD57A6C23C9@DM4PR12MB5183.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iILcrT1K9r3F/LEGMW5r7COvmxko+9g06tOahEPTT0xuddko57ZwkxcL6BvgWYzUCFjhSlQAO6C2HYYs+yhNDVkmMF69MfzOqOR9gf1cWNw858RO4pQJche46AXILQ2m5ErNEGjFUKEYO+amuvVTDA3hJ3O0OzWpKel1oZHis15avFwJG46e2tSJjk3BwxCSCTZk/nralrMVVD2rHZ06KCdsXMyLZFHvncx33HHZ2fueXjmdHruTJFVWy53j/iig8HqDmaj4SeuzceY4eVALQrN30G+kjipih8YDoIc1mOCvfS/slLzmH3wepiL/Y9CvtusIghQ17HSj6JImDE8hRcRD/GfksxZNuDNk4QvndkIgUipOahMZ/Fzoy2NK4Fz3pfz9UVwoo7y4cRQo9LHRQN5rPSvBSTjwLYtlbSt75Pd2N/6J0d0d6sHk+gxULOQDfKeDDWIKm0h0jhLb1fcRnh0ywKKhTwAc0n/lgfroCuhduIyUtfiJraEI5fq5H9bDqP7zpW1vlcXxWTBlyKMbqzXxRdRoaQ5U2eElo0tAKdjFYFTITLQZE4YnUSLy4X4QauOV592YlTQj3xfdNsafyzWerDS+K3TQUWhvFZFNI0XLjfHEKT9kZesZWUzlvG4OYeq8B9N9N0QatlcIsoyGeN9LFbbM0I/lU/9Y0X2GXq6uS639ffecr9YwTskzkjFWnBxssln9j+OZhBW0qryn0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(316002)(66556008)(36756003)(8936002)(6506007)(66946007)(6512007)(508600001)(86362001)(5660300002)(54906003)(6486002)(6916009)(4326008)(8676002)(558084003)(26005)(1076003)(2906002)(83380400001)(38100700002)(33656002)(2616005)(186003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x0WWvSAr+tEgw6DhCrJxbs29LvLkVxPggDxPNZMyWhe6JUdvCoGyPkTB0uxD?=
 =?us-ascii?Q?RXUJ648vGGQl8J2OfWZmWG3533pKNlZjHBptNud60NrSbSWpxgl79N0k30iN?=
 =?us-ascii?Q?8l1jZvOwIBnwI3IVjFF/siHPndraLPQGNLqTBpD6oY6OcZEvRL29CLXLg8rG?=
 =?us-ascii?Q?AhpBfBX8tOxSJ3i1sHUU7ccKsU0N/aw0Xp8gNRgrKnAAdVaLhUd1PzDtFSpj?=
 =?us-ascii?Q?8VBM4N+mMOohULFjckVRrBGoZitrNtgq5WOAW4/W/eDDMIzmBRvVSUnd7/q5?=
 =?us-ascii?Q?ussnVM70u5zST+pC9sLusaP6kOj7zI8YsiRf0h2oqz53CIbDR6oPDQQ1iHvG?=
 =?us-ascii?Q?+i28wHxTYUys7+eLgCNUZNkPC7K0W8gUVJt6cDqTGniUHh8lT5TP177jVfX9?=
 =?us-ascii?Q?H+aHgo1vsYpgETVog6UAQJPXeRcb9I4NfGJao8QKBDszxDFXcaw3QPIHziN/?=
 =?us-ascii?Q?isbkBRE2QD5b7Zhko4eTzcQDj9jc8RALFjeQj+KVunSqErPkbanhH9eHrqDp?=
 =?us-ascii?Q?vjD7DKREUoK7IWdJPDcrwDPBiJks9itPmL3Monl8hAJKZEGfx8nipo2y88L+?=
 =?us-ascii?Q?wi6lBgmtZYALGeTkQZ6yYZCiXku5My4VCrUSgzHbsTzCG0/hYg1CK7/OQ8pp?=
 =?us-ascii?Q?DSviF5Q7jAWTWsOjoGs2WN2XhpmovLqkxipNVxDkqsESWobAUJktSo5Rg9mU?=
 =?us-ascii?Q?zftJzS3EnLJF9fz7ayzeWUfXlAnm4HdpLtl3IGNC6tSOEQGBx/5yEZy/G6qR?=
 =?us-ascii?Q?ME8sVHMaDA6aZfTCRJb2bpQb8wN6yhcmtYkz4/x2wrnwM2gvGWYF5eKey5P2?=
 =?us-ascii?Q?j22eRLdqqHA5mC1iZiA7XH8EeyPktdq3bW8jNK9BMrEV+vQaULgjVeRDoBMu?=
 =?us-ascii?Q?e+vb55xeaCY8JSF2Fn9dO99833dILW67r+mrDPDeFVEZAZbs+ME7BNYTXjEd?=
 =?us-ascii?Q?4ojRnBoVo8goJzerVdmPiHEVK2Quzxyr8PUNmPbQXNwFII0drt+lHw47kGA1?=
 =?us-ascii?Q?jqzeTPNPeOxBBuNds/AGmgPm8ChVmgKBVo0SxRWmy1Bc6RaE2gF2A28lRciK?=
 =?us-ascii?Q?eNCqQGyCOji8jeYIereM6BQz4GI6dkk2eGCTGxSPHRBMp4jLfH8CKtz/ulv8?=
 =?us-ascii?Q?F8TAqJraufaffFNrFgnb6zk3nDGLhhBQIlyfY3GghXxmUGxlM9RHO32YJ1Ht?=
 =?us-ascii?Q?u72O3rNqxVhkScr3/a++6HWmAO71uyhz9KJWgsRVYdRnI0u8cfQfhUtc3i8i?=
 =?us-ascii?Q?6dCaGmzLfHHIk+m2PLaDme/mMpMtxDdl8YisE5qf4l/Onic5TrRK8GqUq8oK?=
 =?us-ascii?Q?G2Q/mGgjHaS8pLwLaKiVBvj+51AWK6ET+2vdELDMJMl8ulPJwYmFxyJkd/yD?=
 =?us-ascii?Q?QCONmgsWfsaWN9W59pzpYob70emn+Tib7b4gEuMcuz23pPyZykGgECie7zn6?=
 =?us-ascii?Q?lmTackB0utg9eynVzMrT4xA1wVniVlarzUKaLe+5Ti6ECM2cLjGaGDpnzIAT?=
 =?us-ascii?Q?S+gHt6Tp2inXrVdCcP4frnj1CR2D/PvPHoe7wG6/3JkABvEvjkOlAqFhauu0?=
 =?us-ascii?Q?EbLFUVxeSmEgOxtNgJk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ede6ba-87dc-419d-9eb8-08d9f700be10
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 19:14:41.3225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTgsAJsiw9bFT7I/+BlDQ2bsnJ2NQBQI6//kyymIRcBUvu4EHsWMlUTKGAr3Ab03
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5183
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 15, 2022 at 01:05:09PM -0800, Bart Van Assche wrote:
> Bart Van Assche (2):
>   ib_srp: Add more documentation

Applied to for-next

>   ib_srp: Fix a deadlock

Applied to for-rc

Jason
