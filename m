Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C5C507B49
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Apr 2022 22:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355248AbiDSU4M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Apr 2022 16:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353044AbiDSU4M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Apr 2022 16:56:12 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A1D40A0B
        for <linux-rdma@vger.kernel.org>; Tue, 19 Apr 2022 13:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvLSbZL/Gg5uiUIK0cyAixMyd6cF9N2v1qlR0M0RQgaL7fRtXHjNg2oSFqb22e4K79URQN3MNaUk5uhTatLRP5rByxko0WoZNIBH7Gq7WJMEmIN1/64e/7ayXNbMQGA2TfVlfTb3wlHaifZhcSraIpxdVgZ2P7okfsZKRH/EI0VYyquCfTJDYeyHYu0osVmp+Q6MNFTlbhcB7Il/8HH3NDfXNjlfPCcdtWSRgZBtQoYeIRq7i2/kO61vmpNnxs1sjVYQvyYIAdWjyvlaShWcayJTULxdfeYsAqVqArpi8r7eDHyjzJqyLHP7zo22xBAJ2v6SW7MMYo/vdgEot2r7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98146Nqmt41b1ClVC5DDgwciH7gvvTTiEY8XrZ67vWs=;
 b=QErzK7BC0KvvSqs2EzMK2lJe6r0ORShszgGWLpDHR4q43lixr1pPqdYJu3+MMdjO/J472nozCr71NBFJgekbJKiHXtrx3bJSFEoatvYjwdPLQtM4wOKm6hBEwFEbd7dPyfwJTx3tzsf5q9o9QhJkDUaLOGth6goiF5nt92Y4FH3NKQEXB/YrzOSqcYPuzos9TNR4W0RCB32OteKZXVaKhvuBMctqV/iMaZWhmmulhgDZ/2JYUPQh6ujGr2zr+qEuhpYpv6R4sfFvRuon26KI48IS6yfmeqqQ7qJXYkuwR2zpvEBrqObOrXwF6K469Fjmlal9xX2Nia5yz9UHYRokag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98146Nqmt41b1ClVC5DDgwciH7gvvTTiEY8XrZ67vWs=;
 b=pq6gSBUPMh739F1Sq1qDkGvaodGE4Sm8LWzyhm42jj7f6/EyNeDZBSm+tgZC815RPaTvJLiEBeUVPfnxmcEIZm2mbBAq/UUAZGheBsrYJEOZV6vVfDSGvnXLHPapa0H0+XZ4+jHOULM/QaoviCfiX1vsm64m2m5GThcQr2qJfFv5XaOtI3zDBX8D99UWy2nuR7O7ZhyAP0DIv1vNjJkC4TQsGmcNRfFapgCDi0GWXr+yLY2JrnxA64hXCLJR27cnDWGR7XURmCsJ4MUrFYp1giM1CVQXqTrtDzjczPbwRjx8dCsUcPbWHZqxXlw+v8tV9v4P0XdUCFSTd4jd1vGclA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Tue, 19 Apr
 2022 20:53:27 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 20:53:27 +0000
Date:   Tue, 19 Apr 2022 17:53:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org, Raed Salem <raeds@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Fix flow steering egress flow
Message-ID: <20220419205325.GA1353011@nvidia.com>
References: <11b31c1f85bc8c8add385529aa3f307c3b383a11.1649842371.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11b31c1f85bc8c8add385529aa3f307c3b383a11.1649842371.git.leonro@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0341.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd5acab1-17cb-4cc0-9a63-08da2246a6cb
X-MS-TrafficTypeDiagnostic: DM6PR12MB5565:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB55652545F8A221A6C9978FF9C2F29@DM6PR12MB5565.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQr/NWZ+MArfyAtpU6FgMhacGM7FwPGCS2TGoW1jjecayR8Y8sxSFCYZY8z/N89GjYXZVMY7Vp9qf3Bc1wHqsOHpIjdRag7pVMbP1LnmT8Yy1km5mKm+HjO7CHN1NdKjpFykcaWEyp7fCB559PgEQeOf5IHEfoYwq7fAFGoqYsVLn75hF/sqBKJGef7WmbksEV/osOohijPnhEkgy9zNhxY55+PEpw7JpSK2FXBDu6ILMWPiqaZ0Yk7FomIhZ5qYhJyMPgHieYo2bqxVUkiIxK18BU260GyhQ0A0xgwwXVe0rcBvDk2tffk1eLVnwpCP0z+pCzpEikoEP3zCNhuFzXyGFgIgL/0vPXKwC/eiKZ8bsvp8/8Oh2C/noVml4ndMp1ydcnF0a5d3qMGde6AT8HDxb4NUp32ZRfyvvJKlLITS/NgEd2TQqq0TLvgTlusTPnQFngfiJnnEZrxUdMGnYHVtDL4EVYwIjI+ipMU5SAdadLeD+TSMo6nv8wlB9aav+uahYUyXMEn4uLlAq4ML4+ZVLQL4cAluxuqrewaaO1aRialH+SQaK/9kXlOEii+7qxsXS3HHvG3xtKIYykfG94p3hC6cHJRVLPBCDa21g2NIf+TVi4H696ZvS8uDOIZPXBVmjwN5d0QkHpibviZuow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(4744005)(4326008)(5660300002)(66946007)(2906002)(38100700002)(6506007)(33656002)(316002)(6916009)(36756003)(54906003)(8936002)(86362001)(6512007)(6486002)(508600001)(186003)(26005)(2616005)(107886003)(1076003)(8676002)(83380400001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eKtIzOWOxJdPS46nZ0bZjcP4l1IehXtgNLFyMFE9W4LOcIqdz1gErQn3Hcme?=
 =?us-ascii?Q?J97MkE4y4reqVqwTsT0rtnRJIDcPr+zC9u3wJBM7VYiLLdSl4afLvKpSlxrg?=
 =?us-ascii?Q?2osIxsXfUBd1/u1tZ0dnZpGsQLdUG6yeLgykWDmzWBq3L6x47Bfp2v9PTvZM?=
 =?us-ascii?Q?23Bwl3Yj2i1pNHEYeU7/VemcBbHbsoztR/GMeXzgdrHDowmrJVDZVdkCYJ/B?=
 =?us-ascii?Q?SAFlA1+cFhI9BVAbNSTugLGXKlNUkm3p2CTh2KVb6UBK5KeGrOy7b71abWpK?=
 =?us-ascii?Q?q4X6p4XZkImWjGfkaqTS6T5vy3UhN4t9BMNR4pqHCm13158KHwQdlfSOnIUL?=
 =?us-ascii?Q?m7wx10GkygoVYPEEgP64c9RppCdUhvASP4XLCvQdUBCJeHO/Pi7JPiUQkBRt?=
 =?us-ascii?Q?kk6K8LAd72uXbNN1J4gBhX5hzu0ntlmVakBuH2QcaXyhO5IEtlIK3e2qYi15?=
 =?us-ascii?Q?0My2lJxI3tP/VzZJC01rk1p0VRKbcJlxi33Ou0DWfavAl6LYVDr+XEt0x/HM?=
 =?us-ascii?Q?tlXE/6gOmzBTfqIbpINNap1DXdSkB+ZMv6ISDOQ2jc9vOHRwZejzMnTDQCw4?=
 =?us-ascii?Q?0dpjg0lzjntrkR/L0wa6xbX1HA83d4Ywq3mbv1GEjXKZENLIILfJtTyj45ae?=
 =?us-ascii?Q?eWDbJZtjAcfI7AWCJi/6d+mjqvopmgZCVT4zK/2liV5D8L/eAVAlyKgTVDMs?=
 =?us-ascii?Q?ecc4Cd5781iX1yr+ZmNuS9rVZ3SA3vrhG8H+DP/N7i2W8XhXNtINCV6vTXBw?=
 =?us-ascii?Q?oSdYXCUOXDjplwuTLxwcSYvUsKLk7NdTDb7QcWFZW8kcuT/5o+m+6yLIh2e7?=
 =?us-ascii?Q?e98KZpDyseINJhdDitiNJ3ktMgMHgh7Urk//FmXLHJlY7n8J5m18Oniwk32I?=
 =?us-ascii?Q?YggDddT7qKvNcx+21lZrYJ+4OaiqgPTnkGHfuIA+GfXA2N4eiqdE7+/RLcHl?=
 =?us-ascii?Q?RQ1Jxb00IcxPwZsSSBvbj6dmgoKDPNkBI4vsqcTo74EvU1FFEPFDIJYMMFnh?=
 =?us-ascii?Q?z6WjSFVZg9nHBrqZDdwSAS4EQZ9rotREbvfZj7JXdISVFebNAyYimgEUAaf0?=
 =?us-ascii?Q?6+KiISKF4ZtOZCMl3RfvV30YQQ4GXYyyV3TQxdLpD8hm5YT0zPMVkBfStsSj?=
 =?us-ascii?Q?Y0jRlBceiCj2J/4XLiUfnU4kiLcY0DDS6IVhhyUIog0T4Ibw0iDVrVTqmDXC?=
 =?us-ascii?Q?Mbv0L6f24H3grw6nifb9m1z6fUordR2jZ5YlWdJIo2XhqzD7/Z/8h3JFJnzX?=
 =?us-ascii?Q?LBb3G+BcbzxzFnUTzvNAed33Yw/Wjjp37bXp8ttKNV5aXPRIuswIryit2oqI?=
 =?us-ascii?Q?nEsoiqB0dcokYJaMonOWbtldbJuuerMKXRWZv/r5kiEG0lfwvbQm/vxK42ar?=
 =?us-ascii?Q?wxA4iBBRLDjCWoHE+zL+eWitlcpEmbvZNQJfB5l/RtlAR+zwDhvH4P4mTIWI?=
 =?us-ascii?Q?KfWTiUSpHrnXMW4Zo6behBKnm1sWgaP+tLq4wbZWpeKQMtcwpTQfb0lYu9Is?=
 =?us-ascii?Q?y+9sinwU1MinIypNZnMcEYZtwA0P6v6GCOYncPiFkhQjtHUmFN/qQEWIfCxW?=
 =?us-ascii?Q?rb+XGwloZS+qhKR+mqrTrcgaqHyHPfdJbR1E7+fvC5Of28diD3SS/QmOVe19?=
 =?us-ascii?Q?38Cd31cGAmdQf0j9A4dyP0rZr/TWEsJaTZS2s6Ei6LNf8ftHUP87ECo4Swvm?=
 =?us-ascii?Q?RNSZEjorlEuV1pLsmuKo96QX7MjRF4Cpgn4WCXdp9OFNdglLIpFCr2zTLMxc?=
 =?us-ascii?Q?AikJegmkUA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5acab1-17cb-4cc0-9a63-08da2246a6cb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 20:53:26.9168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9LuR8JdSj23VV2wGYrFm8+h2iSyPU+xxZtPPRiGviykeBRjMUkKTXiLPxkMP6ow
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5565
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 13, 2022 at 12:33:39PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The commit mentioned in Fixes line removed the function that was
> called to check validity of esp_aes_gcm attribute. Sadly, that
> is_valid_esp_aes_gcm() returned success even for specs without
> esp_aes_gcm at all.
> 
> So the right fix will be to remove whole if () and such fix
> the following error observed in smatch too.
> 
>    drivers/infiniband/hw/mlx5/fs.c:1126 _create_flow_rule()
>    warn: duplicate check 'is_egress' (previous on line 1098)
> 
> Fixes: de8bdb476908 ("RDMA/mlx5: Drop crypto flow steering API")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/fs.c | 5 -----
>  1 file changed, 5 deletions(-)

Applied to for-next, thanks

Jason
