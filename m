Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD79526152
	for <lists+linux-rdma@lfdr.de>; Fri, 13 May 2022 13:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380015AbiEMLqt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 May 2022 07:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiEMLqs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 May 2022 07:46:48 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E544663C5
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 04:46:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1R0h4ZMXWCT8D3QZK0aqlTZa7UcMf7WBmUvS2YguXml9xCzpXP8VDUvpWbiv2VBZ388fFNa98auGn9I2yhEzBVGI70co2ajb86k589x4mTr42Ck64zmwJHzpXEHn3X34DrB1EdrZfy+1q3BPr3E6jVwJD3LdMAOwD1D6NlotBqmLUBzmYnjFerYBgpd0xQFxOXQfPGL6M0lXIjqJOD6X6jDuwW+/y2870td7idsa+o55FlQS/jJ+u6FlNhhayuct9kAot6CbNHjCh3eZfIlAXt3eh44pIYXuoSsVmKo2z7QPZtF38ZqUoSg/Bt+0lztj/yw18JbzyqNV6s24T3BWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7n8vn0IWJc2pBXcnGOeSrhcahkwpwduJggmL/b+/9eU=;
 b=ZyFwtp0B2dZfPCizWRcr7qDH4LVEBaAJTXUJZ0NJ1ke+D1VEnrVTPYIVGtYg3r+VzR0EDRZR3DVaQts7HWStCue6hoKCBTCq2/OwbcSeR55SVPAhCvkumqs9E/sawlbYlgxdLZ2cjwjXghNJFCuQgJS2WW2fDiB3SCLg5rBhY9QG8t2jY5wFcY5BPzcZtVXXkixKLNTDHwb3ZctkBXzJmvWoBEfRzD5syWX6Xzkv6L+uVuLStByLh4BQLvSsMushhv/wf8yJFCfhZCThQoLvwCuaYsZhS4zgM+cZjk+4XoJcTK19ncks1Mjxy/zyHwPa66wkRDk1OBkZZQZCqwVabA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7n8vn0IWJc2pBXcnGOeSrhcahkwpwduJggmL/b+/9eU=;
 b=BvBnVTyojTBq+QFYd3UmauuPvmtM8C0r7AAeFdisKuuYqWIRykMdYilVojhFfeJYJlMAN2SrqxDuOpXvluepmJL82a9fcyMv49qf4ZamYMs+ZZ5f8YFyI2RAutVWl7dVvvDkpbsn4PW83PDpmsuONepnMtM+h9qWKsFjDxJ9yjYC+k5Thy/hkohHP+On+EyhzsIk6MtlyXDKZajhlrZ/r5gSPa7Uy9auG1ZzFGEdaoB8ABoe4V9oM4LtQCmYsXGLdxgEiistaQVscGD2pXTOQgFtLf9eANyyEvom+Kl+iC6NOkyYRlIeRXZNAZhAGrW9KRU1zSCLvIg0AkrRaWAC3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1199.namprd12.prod.outlook.com (2603:10b6:300:10::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Fri, 13 May
 2022 11:46:45 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.013; Fri, 13 May 2022
 11:46:44 +0000
Date:   Fri, 13 May 2022 08:46:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: Re: [PATCH v4 0/3] RDMA/rxe: Add RDMA Atomic Write operation
Message-ID: <20220513114643.GL1343366@nvidia.com>
References: <20220418061244.89025-1-yangx.jy@fujitsu.com>
 <8d88406f-cb19-134b-0a1b-ed2b2aea6a91@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d88406f-cb19-134b-0a1b-ed2b2aea6a91@fujitsu.com>
X-ClientProxiedBy: MN2PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:208:23d::13) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d403d8b-ee1c-4c96-1c04-08da34d64130
X-MS-TrafficTypeDiagnostic: MWHPR12MB1199:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1199CC626F008296D27C1CDEC2CA9@MWHPR12MB1199.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fkfrEm79Itz4qyE0gzO5Js4SV/BeltIUvUW9zAnQSXJ+X+sMz/dWE3sCxe5DG20zkyVF4xicA0GW3KNQ8sfwteHrW5ewKug1WuPC2w8ZDaqskbT9dHCEs2L3H0TpeGoUKNoOzEfHc/XzdtP/rU9NSMrZ0qfhX+fVH7uSMfwBJJirItEG7E+0nnqhbNUis2lx8TjyZk5qeMaCq9BOLWeovI5kAvZw31zVpFNwfwLsfs8CVGiGZvekShU5YzvPK5+LJRNiBgnf6ofQcvenI4DIK5fwDbP3eF9Ti4ANTKM04A8LxFsdBNBD5q95q+OYaHtMzh7LzW2F+Cir8bdSsp59tXqpM5sebK2jWoY07ZUq1z+uuic78Dicwz5rUQjbX0aqPS3DdZywMugef6C9sq63qdeZFLnEOJW5bCpdQfAI1uID+R5Eq13S6XUGn8wsuW2LgZW3BibLSVw715tZYGeOKL4HiJEJ7j9XwmFwGpo4hAgwvDNPsnU7LXjN8p1i0WW0T4gJmwNx+2p1VWqB0p65+XDOvQknHJA9cNbgTQLxfGpW4exzFx36MfGmKyobI2tfD1Zh1XGYnnQUxwtk5sJ27v/pYVkzF1sc+QmqFOlMRUqOEqiPFsqN9xDvqFnfdBv803J093lapQ+cPME0iCQRwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(5660300002)(54906003)(66946007)(8936002)(86362001)(38100700002)(186003)(2906002)(6916009)(8676002)(66556008)(66476007)(2616005)(1076003)(4326008)(508600001)(6506007)(26005)(6512007)(316002)(558084003)(33656002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D5g4A/KUYYxFLap4tAEcnji04w4DrP4KAa4OBGMPdXRk40q16VFsxb0J6F5l?=
 =?us-ascii?Q?XiWhVYuWAXWaWYjzi+yQkDa4kVdbFuTusGLgeUCh87+ng+tfOzE8X8wH9uSZ?=
 =?us-ascii?Q?ifwsawUygC83j7Nwpy6iCf+XsO5LAluNNbR7buw2UBKk9MnYJgiDH9i6+B1v?=
 =?us-ascii?Q?GYLDQ/Teiq7LUVLS1jjG8d/gQLBkV9UNQU/+MnBiNNufXkdLdn+XFXt0+m4a?=
 =?us-ascii?Q?tbJdg9BrkibT+gzZR+70ESHbGVn/j8lGnz/VNfJMwzECNPX9zHAoWS24s3qr?=
 =?us-ascii?Q?DQNKacMJDGDMk8H+FNfORZwm5PNI83Q4LHJ0npPNP58s6GK+vxdhI2K6GeuU?=
 =?us-ascii?Q?vweZ1sIaATCtbDoXpZLwD47XmxkxbQJJpUtlbsjbJwEmF8tXHmSgtpQN+Tvn?=
 =?us-ascii?Q?mckbJEZ3fAQoKPORj9ZcVnU/Jfvs/6tJJ9wHHA/K/vDlkMD/cr8qnrf1Sg58?=
 =?us-ascii?Q?9Qczc8zo6t87PNcT7aVDNwSuXbRgEw9M1lciDnXpE7R+E+U/+V0FIELncDWd?=
 =?us-ascii?Q?yy5gl1FmlgcpX5XdNrMXGqGXl5cVN9o2+kvLG6Pm6lsChZDoNmOhewpsPGaI?=
 =?us-ascii?Q?NrgNKyirClOPT/4VTqtzzp6v8phzQK/Cp0Dq2kBpP2ZaS387WhiNsBVTSFor?=
 =?us-ascii?Q?ykdSC42ZOH+tINSNUjB1bf3uLj/ctD5QKLvVKuoJkmgaoZuGgVW+lAJ5mv9T?=
 =?us-ascii?Q?tT8MBUEMZeYxs1L60ODqyb51PmtdJ25vblAyzllII3ltKz1kHkBkO4ufh/yH?=
 =?us-ascii?Q?q0FzV5x9JIHjmMERpzegVzsq4YsfBq/WzNgcRYwbdgE7ZQU0jolKHurvGJE8?=
 =?us-ascii?Q?Ea0ssCGXrjP1w5uUFSsph1fqvnGyvV10HCzeCxTCyOrgZ5Aho/8oEplvSnED?=
 =?us-ascii?Q?13os1gmxOXzTmzscIpS9n3+tXbXtKLlNgDjXQl06+loID15/hPjvGu19yFvA?=
 =?us-ascii?Q?wJRNZk1iHdjI0XkY0wlAxpu3BeGBAVuYm1R6umbjaQ7HLk9fhVv3Kknpc8X7?=
 =?us-ascii?Q?P/bJjTQjR5L3x5OQ6HhU3LLFHN8PmqncbyatwxVmkDceEf5tcwOdlnN/cHqU?=
 =?us-ascii?Q?XIQMRsUFfWcHvpEMrCW8+vYqoJ3pP4cjUR3vTDI4UPRbBYtWzjlEBYW1bSKb?=
 =?us-ascii?Q?4lEwWiGN+8lck1uE46Zc3COGieQzRsW6L22ekhC4FoxBIFrCtZQCw4fXV92D?=
 =?us-ascii?Q?I4OrvNK0gDs7cyJJO5aKi9SXzxBtiCXoyGW7kIt+LG9cBt9zhSWmGd709FM0?=
 =?us-ascii?Q?dRDrRIMPh4UPT/c++4sG54jkJu04bDk/mL/HL/84vxOUOaqIJY+MLG6jHuRF?=
 =?us-ascii?Q?KisIPxwh4P436W7t+5tiQijsAtzfhJSDEaRrXeqOdBrJkkXixLkdzMeyzjNw?=
 =?us-ascii?Q?qcCSDQGGcKJX/DWAssD9dzhJb8rwKAgyUnRjS3PZGoJaw5YWtx1lqlKakbOt?=
 =?us-ascii?Q?5Xs9zqx2B610UqMrIoJ7EsjpwY50SdQEvR4sEB5Se0wuuG8sNCZyGJE0Z2+U?=
 =?us-ascii?Q?Q7Mn7VF55eyav/Z09pop+phdSAnxSsohN+DVlGWDHBPkaqx4VZ8Ow0gg4EkS?=
 =?us-ascii?Q?pq0GrgJL7HauSXP87mJMjqkfMEV1cXitS+OgW0S4XJMdopQxTGV5h1KdKMI2?=
 =?us-ascii?Q?rO42IxU6uMzVsnNtvmOdheERyqC2tVyoYdT2iyRGF3CBh4yM/+wJm4UX3WnB?=
 =?us-ascii?Q?kvMiAGlpm/254VCeOAs0bqWkP60Js7pEnZzUlJNCgEmfaIL4OkZzCG95aFyl?=
 =?us-ascii?Q?1s1hZjuRwQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d403d8b-ee1c-4c96-1c04-08da34d64130
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 11:46:44.8601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mvodJ63yO0IZPk94Py4PdhO26BOs0pG0U5n0G1TJgLVw/+2omlrHe2a4lnBDuTO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1199
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 13, 2022 at 03:46:00AM +0000, yangx.jy@fujitsu.com wrote:
> Hi All,
> 
> Ping. ^_^
> Are there more comments on this patch set?

I think I said this already, but I'm waiting for all the rxe
regressions to be fixed before looking any new rxe patches.

Jason
