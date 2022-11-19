Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123C763083E
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Nov 2022 02:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiKSBKC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Nov 2022 20:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiKSBJs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Nov 2022 20:09:48 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7530B3D
        for <linux-rdma@vger.kernel.org>; Fri, 18 Nov 2022 16:07:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCu6C2uWv5WCfzNawMnp7+SkrUTjJFKidAANPVkAbS5/I56HHP6H7Ll1SY5WJ2kyjgavQQXOw1cXTWIw3lO3MH9QjABfoftwRiT89z+vjsYxikA0tfCWsBZM+7FE1b8L27Z2bWHXEO1KzRu/CoyKs2dBMCvRZVRvEXi7OTFiMYDEPdrcR+gW7VASPP40Y6e0tmsl9Hx/uQ51S+le83wfHe0x55EirDYJk2nRBSRTutxOLs15BC0MyaMPSiC7DNId5JNy8fQw8GT+l97Y9i+gc5EjL+Lyo6200I65dkvEa+kurwgG5rDwsWaCc1iECpGXjqA4qBI5EZil/zki2ESEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSI6PHLkkNBlUWhYbcH51wMzueQCyDPXAmboqWnNWak=;
 b=LsRn4HD501HNhi93SxgCf+MEOIy+2VSHfGArkqILpnNeN03xgedaBVNmlPSRKMIeh0xOzVO70VKVUxMpAlXpSu4spk0hK2nrPkKK547SF9/5DVh80ZEwk/Z190QIin2lOTF1ShDySgHv5WYWEsaI/t2siIkbtCZ2+UEJHIQi0cCWiZ5IQRVwdg4uB4xbHpTuMyFkhW0+s/AkgY3VnGj7PftTydCPMQ8xgkPdCZ3Gqcuffjk0juSzU2yXt1f/NrpnmYKIMrZtx1IlTs0gvDFvaF8w2JZ62O1cxvkpehih/VGBI4r1lN3K4AH8vGQo3w/LH7ukYgxvrhS8+NZLE3OLPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSI6PHLkkNBlUWhYbcH51wMzueQCyDPXAmboqWnNWak=;
 b=qM0kwDJP1xQ6bff0yUzCNMnNfBqO5IbNBgITij0MROl3F8tlIXEhMsENsnncp3GexbA9lHbvApeMh84Q2fZPhzepyrig/TTX9m4BCfT3ppJCFnBbwUGWow5dXkX5WkL/it6EaoPINfhn+ODppyNFzVCe8zxBPBR3EPEWRllCDgvMiogOWB9Je8ytfiBjHsJafZzyPaVldybd2LPAH08xDTRCqCA8S1cT3fUL3ZYrlf79C4I4PwoQTe6+slqA6ffxIqvfAd3A5ST8E9LyX5HO8F/EJSkqA7YB3eOXKUNriD3r8QaLJEUpsCbu3Ko4uDsjzfJuUWvIFzHyzHzb5A6qCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4940.namprd12.prod.outlook.com (2603:10b6:610:65::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Sat, 19 Nov
 2022 00:07:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Sat, 19 Nov 2022
 00:07:52 +0000
Date:   Fri, 18 Nov 2022 20:07:51 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH 1/1] RDMA/rxe: Remove reliable datagram support
Message-ID: <Y3geVzH39MDMBzlA@nvidia.com>
References: <20221112023537.432912-1-yanjun.zhu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221112023537.432912-1-yanjun.zhu@intel.com>
X-ClientProxiedBy: BL0PR02CA0074.namprd02.prod.outlook.com
 (2603:10b6:208:51::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4940:EE_
X-MS-Office365-Filtering-Correlation-Id: 552f18db-8f67-49cc-5b76-08dac9c219cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ZcOxpwW/O+d9GeOPLKI2Wa8Kg5o/vD63T4iFZBRJ5EnVtLWZfa8mu3g7tLOKEQvhbHI/WwByMzmTSd44PojYdY65GoOQydbv6duBzhlfi9UXJs5piis794fNp9YSpr24mVNfjSFccKiaX8n/bGfgRQWloZiTkUtZe+0r9QMekm1JjeNARaRB9124B5HYJ0c4V6T4iFcKGDEAnbFZCVr8v1ZcTaYnIhPmM8VaM57qORLJzkaeayd6ha/9EbBP7roYCvvIOzK8aZV+oXVTb+i+Y3sZ8AT/5yIxq9PQJim4Iy3egoYffoIHv2KcXi/SzSiCWdXEvbI4mqOEqaa7375lFLf5oaL8JKKTvJ2UNK7vSkgMOSq5ZmbxIEd14OJkAicG+Pojzm1pzVKXWx6olwoi/8bL/zC1eM4ARDoIMnOl7siVqmskaUZLrX21c1E2WDb1pOhwtluB5USpTCTkGV+aewX9LpNSmRNuChf8iS9N948LwHfhtC6E/r67BOgx/cPEgC9TLfpYem6NzS9C2K9bqd7tyHXq6h7sWfSGNbjkXlRTLInrXX0cLkcxrLXoz6kwp5Npq+OFnCa2344l3bTXcVv65SlGLpvlXIbha9x6kLGsPHpD9fRmGO7vdgXjavHytbnd45e/JlflwQD4lAagw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199015)(6486002)(478600001)(38100700002)(86362001)(6506007)(186003)(5660300002)(6916009)(6512007)(26005)(316002)(4326008)(66476007)(8676002)(66556008)(66946007)(41300700001)(36756003)(8936002)(2616005)(4744005)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bttFwQsQ4huf4MKWshvCNXJGe4i5Ktk/zfSJAuid6teUUmTwMLk3WCHejbEF?=
 =?us-ascii?Q?rDimp361BiaX66VC8p6hu7nQEcL4cYyfLKiw698oX0o0FeCaF2ej/5fyVlzn?=
 =?us-ascii?Q?bXxXLVw/+HNP2kd1FcevGImCOt1FkMcZcHVuCh5odjQRYN7TF5PZRaM7VCVp?=
 =?us-ascii?Q?YcYbF5zWhXqim5RPpxSvnFqhJ/mezN2sIadhSrz2UT/n9Tp/hdP57QHFvv3Y?=
 =?us-ascii?Q?jeaAH1qK5w75vOIBY4kVGdUDN8pRI1Rp3lMW6q1XKLZnRW2ZVuTpUsin5680?=
 =?us-ascii?Q?rNvMmfJLtRvR897hpT6UKTEexu9JBdCQrfswrGJSlIxlTz8arYMIx03HO7tT?=
 =?us-ascii?Q?WNzyI1Md6bouwQAdGpXJUvypnGhG0L9cIrSGGJxy5ZFbTFtCN8wf5iM17Tgz?=
 =?us-ascii?Q?6WNRbAeKPYZtureUYZhylpW5H4kljMSOGGt63ip8C9lCsE0DF/ZODl9i9S9V?=
 =?us-ascii?Q?sygcs7vOLGoqY0mUrTuE3ZAAZIOkGHZq+xjqMD0i8bjzhUqsZ+lwnypr6o+B?=
 =?us-ascii?Q?GT3kPkK9jz5+f9TgGW5ZUIXGYfr7xzCgLKAyhBXnL3xxLiJLPI4ro8rPJeTa?=
 =?us-ascii?Q?l5xlG7noHSPwC9FeOsUX85VR5wanukQE/r6Wu3beYXoV0hM+U3rWiEUpYGkm?=
 =?us-ascii?Q?J2J4mRuxXHEJWVdIMo1P22tm/lQS/HW5A2RJgGU9jsBmKW/8trYKD2xVD1qb?=
 =?us-ascii?Q?2Ygm5R5QBAHxmvPwkjHJ+KPUEfbAzuUQYrjInLRCIYPXkU1IdsplwA7YPdrd?=
 =?us-ascii?Q?4a4ienwfQ+rLs8hwhLsMDzLmKj5QkLQ5WR9hjVhJ5myWx0O56CcGxwXG4cvA?=
 =?us-ascii?Q?5hIrTEwUpnSKiiEU5VUjKQHHnydX//rgn+XaHX1NYXVL0kLfxnpBPqdMjZjr?=
 =?us-ascii?Q?NZooX+3Jo3506ErpKxuzdKfxR2ihdQPvdh7jHg89XKQ9Ho0txalAbOsuLHRk?=
 =?us-ascii?Q?m4gY/AWloUDW+wxA0fy4F36soXLBKi1UW29s8LRxJBGNQ7JHcZTKj4HPm8n7?=
 =?us-ascii?Q?X3RBrRH15cVlmo3+x4PYejZaf0rMhCmvNuHv6f0UMTIFHXTwz+3vQDfB7KzW?=
 =?us-ascii?Q?3zdsSqcPC86hs59KdYwLEFvet4hgVL+tbIcEBoZkc20uiZCZO2Bbz0KC31yq?=
 =?us-ascii?Q?2JJh2ZE7Dqh149byH+zyzRgmfOus4xndocrjM1zYJa7cwnDRwy8cQMHO+gBX?=
 =?us-ascii?Q?e4d0nJ4ClJpEzN/XnFOffbEA0KPxS3cqlqm5smqaPDGz1LE/exlt/KSKvkB6?=
 =?us-ascii?Q?9fs4aaFVfBbh+XUbCJTPZ5MQ2a6hmt0v5C7KSmT9yJclJaCYqPJ7JF8mztBM?=
 =?us-ascii?Q?RHswC/hJ7KH+4QmadsNoeiWVgKOd18h6xpOszA7YsjVMlhq7EifKo+LKeySK?=
 =?us-ascii?Q?P/GJ9drPjwUyKKBQjIFkkEIN+rxAOF9/+XcvGsOm1rL+JqkGjpbRbf1+NOjm?=
 =?us-ascii?Q?fLJ9p30wQjsG5zn6dyegjUzlnj9X8bd0yBUHtao3skN2OWk2dqYMWktM5yr8?=
 =?us-ascii?Q?3xa8cNonV0WaOAnqBcYHQLz2TC/zzB8nKGpJnQ6JNRYpkJNH1XNdrV6MUbnh?=
 =?us-ascii?Q?6rHm8Vdv1KvfCFyrX5w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552f18db-8f67-49cc-5b76-08dac9c219cc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2022 00:07:52.1570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9w1sQ5Jx7wpS8IljYS4PGmY8VBsBTg5qd6c80kFR9yx8sJv7RIjFJTcLFM1ukFY0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4940
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 11, 2022 at 09:35:37PM -0500, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> The rdma_rxe driver does not actually support the reliable datagram
> transport but contains a variable with RD opcodes in driver code.
> And this variable is never used. So remove it.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_hdr.h | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next, thanks

Jason
