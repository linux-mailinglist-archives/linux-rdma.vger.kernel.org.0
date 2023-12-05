Return-Path: <linux-rdma+bounces-247-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CC0804325
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 01:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E015DB20AFB
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 00:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5B237E;
	Tue,  5 Dec 2023 00:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QjOYN/oM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B118EBB;
	Mon,  4 Dec 2023 16:11:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wa86Y5m3s+3NixHWDb+Gs0gGHQj+maiCM1OyPQ2AonSK4UqikyGjHhpdP2ZZjc5WkMRntSm4tEnjzSGUexWMQO+GeX/WUcbbWGfBDF9MZ16H6EmgiBHUM/aVbnK6NP3TZjfas428EG7kNCO3AC/m6hM/SSOqTCikLJz81B60xgudKaUqnLCqNSg3Ndx6DqiL4GFK2nT6ltUbOV4PURVF+mOsxJ4R0jFsIc9ifanTJWIfMzruf3auMPpr3CqZIikJ80uSywtOkjqiWmwyWISJk2mmk7+23QIdS+BLaMt4PtqWyxFTYGQyvu/fDW3oIxprNsKpG5BkcFSbflkqw6Tkcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oV94k0pZmAP3xIgYQRY57eF6WY8IcId802Mt3QgQxo=;
 b=M8PaixAucrsWsDigemsPfZD1DEFQeHHcEg6yWaykF+GHtOgMErYwnteSuGVpsoZinW3dP8RKae3W+UbL4Dbj4Orgn7Ri76xvVEkZEDgePZgQmZI2txegr1ZDrzY4x8Mb3gFUJb4CeAH/Zhp63QOftLtC3IOcVgLfbWHTemunhrJBdMtSFLhMM/xwJp2uecbRKNyohQruKdZQtcaTNdQKWlfINkY2QVqlKiVTiDSzpOhJQ40ze8i0UGgg8WVi4vWRFh6po0O91LsbgCohvo2a5OGOudo/bCGz8L+Y3+OPW8D4awSyfy0PjOd0gUqLXJy1B9ZyyPHUsQfvzqpXidE4/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oV94k0pZmAP3xIgYQRY57eF6WY8IcId802Mt3QgQxo=;
 b=QjOYN/oMylfIBRitdiqoynZDcRH/tZIVrYFbXWNVwtvDQh1ijcRGvcAG2Nksax06ZHvr7CyQk9U7Mk5q/y5Pt3w/3tW6uGw7Zn+d1VtHwgsjZUAxJK2xp6M9/48+/4edjs/bD++kUJQ9XMZOaOWOSw+noouOqq69Wsyypl9CNAhPTAJed8JEz1W0RgthOSBt3O2TBknUwSNID0CF+dgrItouuwGRZeDIig1OaooVwH6/xQm31ok8EVmV7lcBwokSYd9SGHfEgVRSWr4Wqd+DRXEwiqpVDq5R9eIOww85QsNwtp12kEw2pMXyXJJjhjV9BdF/sfBGyXaDvdzyT8Bong==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5162.namprd12.prod.outlook.com (2603:10b6:408:11b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 00:11:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 00:11:40 +0000
Date: Mon, 4 Dec 2023 20:11:39 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, zyjzyj2000@gmail.com,
	linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
	yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com
Subject: Re: [PATCH for-next v7 0/7] On-Demand Paging on SoftRoCE
Message-ID: <20231205001139.GA2772824@nvidia.com>
References: <cover.1699503619.git.matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699503619.git.matsuda-daisuke@fujitsu.com>
X-ClientProxiedBy: BL0PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:208:2d::49) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5162:EE_
X-MS-Office365-Filtering-Correlation-Id: caaca912-5016-4e92-fd36-08dbf526c110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u32flMN+olTIdDJKZKAZrto/Pvdfkiopd45FrmZHiOeWq+lsXJ4SPkG+66Xr7fXJ0edpGjAIqaikcmYHK/PUSJOCMJBCPy9r6cyhOMNIqca0yVYIQVckBoGiHhk5OssflN2hoKkHJhbNydbmXG7xchw2QfyAoUIoeS89ApA7tPIyEZ1il7fAKuirPVyu8HGEnYi3uw1ldv3HZ+ha42Vn8CEq93TSFczMik6f4s+5Aqna3fWfelJdXL2XMI8THs7K1csutbW+6gvSRGeKJdQee1WdNt3Q5xY8LPKLTffCdfLvxSK9/mP1aHILTE0oYWNOt1AIhsvR6vs+JjzyyoqfodNMzlUE0Z3g8KlcQ8GV+2Qi9qp2EvXrXZE5QrL8LyKJRKWvaQIOLKLEpfQ1t+5ejsXB7gZslTv+x4nTNb30kQJ8Zu+7IzcTNfz5wKVFLrkuxV7NkMV2XS0TfT+75mSCO51KpqlPTErwXcRHO9MlOFvFYcqeN3ZNY1opcJfeeTlXovC7BvxblXRNQB6NQ68AwKw/NUGPsJ2TsHbcHUv70gJdsDTny43T0FXlYRAc6jdq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(478600001)(6486002)(86362001)(6506007)(6512007)(6916009)(316002)(66556008)(66946007)(8936002)(66476007)(8676002)(4326008)(83380400001)(2906002)(41300700001)(38100700002)(36756003)(33656002)(2616005)(1076003)(5660300002)(4744005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JMy7R2g1uub3zdnBgSzGWDSrH3BcnLibp7GXfhEksHtGZGtbsNe5YN8BVHyX?=
 =?us-ascii?Q?HMvHAPSjrIhQiWLdTP7pzk5k6CqpldqajkJhqIMOirBeRTO15mwut8d4R09d?=
 =?us-ascii?Q?OBrc/WjenBOTfkuKk6nPwFfC/2P3SwPaxIxQQ/xOy8Vw8XJgYoQU+yxImBjE?=
 =?us-ascii?Q?+7ukEqWvVcbX01fVIcVvqZDH/PsC0jSWOBRL1lVz56vM1LtU6Y6it7qbrrET?=
 =?us-ascii?Q?Vx9Ig8zGNma4RnBHykup/jA3lMJztDwpB5WajpHdTdolX7F3i5H23Rph2lB7?=
 =?us-ascii?Q?j1dlLOX2sFl6KXVtov3VPPLPwO5YuAoSheGG5+eo//fGBU3rMqjFythTK/kY?=
 =?us-ascii?Q?SQo+E+DYFQPhc3EFtl0rJXUztkZTVfjuYOvVm/uyA8135YGIDpdB8TP80n8S?=
 =?us-ascii?Q?k7a8swpn3J9j8dixf1y7XTPlopuW0BH6uuWyQfcIWwROczeqGEZNeU1+44d4?=
 =?us-ascii?Q?k0JNdktELApPLn6wUdo9+2KE8ILdgR1DAH9zfi9/oGgxsaG9nC1fy6AfsTDl?=
 =?us-ascii?Q?HFgflwxzkEbfM8CDkTndor9jjCt03DlGjJjsNKcMDFf7GTGp89Uey9dq4VdO?=
 =?us-ascii?Q?SfpdTEUugzsAvSkhGWsZn2hWr/csFIS6xD7GzCEr89Hl0T6PmwXU4doZa7Vj?=
 =?us-ascii?Q?csJrqqUZfgjlYr9BKsHXw/c4uz6lqGUrrhOBwVfyRdadatpGgK7CjmjUtZFt?=
 =?us-ascii?Q?KPlCY32vRftBA1WrNGdMBF0YejMpPCW8jWKl8nU/EyqGu/TbX2I0if5TojV4?=
 =?us-ascii?Q?Ju74pEk1CcRBXtIbLJHgRk7h71BhddajAq0R4WgGKepCh9eANJxC+X/M81Wp?=
 =?us-ascii?Q?ro3XTQ9HRoTxceAyI+EVeIzVZsA5VTjVWWH/oIysBj4mhSYuygld6wxXoCOr?=
 =?us-ascii?Q?mpvuJZVgOUmE3VGilKjAB8wIoCBmwwnOr1qYV7r99AjWR5Sn8PH4Qmtcruuq?=
 =?us-ascii?Q?CRGd/M5hvgbGLB4cqHOqxSfS93zkroV6TlUO2PgYwHOM/rsSZk9D8BdgdCKH?=
 =?us-ascii?Q?djnHc/kdyMBlvCblmg005/cE6bimL5hi6Hfk40kFhR6BW4DW0BlWp6gTmnsW?=
 =?us-ascii?Q?pA1gvCF8juh5Ix6RmC7hqwQDM5mp7lGkb8rqGtzHFzIRfF95bnsvx6o0INMn?=
 =?us-ascii?Q?D0/MX5r45/FsNFZe9KAGc+xAtvuBaxpHif84ywOr89QFXab0iURF8OTFXiLC?=
 =?us-ascii?Q?g/8Ui4/mG2/AgHkygog75PY8w933sNd1067vh0JEK8gEvrGApMSjFHdQGhJ8?=
 =?us-ascii?Q?4QRyUTdh6y27U5+VV/tIJPG70KntlvuHkMcv8XaNgbSp1fqGQ69dg7fYkopw?=
 =?us-ascii?Q?nFgUDIh20OGm4ayqAKKPomx/aI52cBgyI0CgUJ/8eJAtVCQvvK1zyKMnTx6J?=
 =?us-ascii?Q?GpQBffhzZ6YTsvkDcrUekhK4zySzic5uYQlSqh8aGTizSoOtf8mtZssE88RA?=
 =?us-ascii?Q?I0E0288mIOjFMn34ZXdtTfN/FMGr3FgB1RCoJAnFpriFWxgZI9kNwY5wlEAa?=
 =?us-ascii?Q?oA+aMLBMO4XkhSE8PWDM54dQnRHAnPuXImc/cGowK4HNj1uQtHSpnxSOndWx?=
 =?us-ascii?Q?qxVIlqxn8QTamfexN7j1L5O0byLOzHhQKJB1lsal?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caaca912-5016-4e92-fd36-08dbf526c110
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 00:11:40.0959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uX2MXHoJBo5hUZxmUEN9pBHx3KXBE13MJdVXS/0chGXP5KdRdG3bT1r7NkxhIBF4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5162

On Thu, Nov 09, 2023 at 02:44:45PM +0900, Daisuke Matsuda wrote:
> 
> Daisuke Matsuda (7):
>   RDMA/rxe: Always defer tasks on responder and completer to workqueue
>   RDMA/rxe: Make MR functions accessible from other rxe source code
>   RDMA/rxe: Move resp_states definition to rxe_verbs.h
>   RDMA/rxe: Add page invalidation support
>   RDMA/rxe: Allow registering MRs for On-Demand Paging
>   RDMA/rxe: Add support for Send/Recv/Write/Read with ODP
>   RDMA/rxe: Add support for the traditional Atomic operations with ODP

What is the current situation with rxe? I don't recall seeing the bugs
that were reported get fixed?

I'm reluctant to dig a deeper hold until it is done?

Thanks,
Jason

