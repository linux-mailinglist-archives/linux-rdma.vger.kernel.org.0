Return-Path: <linux-rdma+bounces-564-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24010827713
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 19:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5811A1F22F14
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 18:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1088A54F8D;
	Mon,  8 Jan 2024 18:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HngQxoLh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2F454BC1
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jan 2024 18:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWOojLqHnA66lJL7s88S0TXv/6olpJPzpidS6Gbzb8n1V5HMMWaZCdsg2G45GgAlz2h51a83fimGWazJtW0/NgLYqHVD1sKP3DLkVRS+6Sp1wdmgOW9y3cDYiyNiFx5AUszRKX/Ltq1DCHEF99IhkyhWkRaf05u/+n4a/jw8MnnUsUqquEqg5OJUPCLBBImeyX7sWOzc3fUEkQJXb9ww9YFBZCpwdR7II2RPykL/vK2vFEDevBazpV9pvzALTTqcp3epDNlWUHRYQi4FiY/f+XiwEqaGJIGE9cCOb3Xo1XkyLodDzE1YHcGjKnpdHEGDjNooM7m2+BAC9FVGI1aJVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drekQOlrkG3dOXiZeq1i/weZBj844r2+xxMKg3UC1Qg=;
 b=m7GtRXfGKD02M6daaGMrpPQgN9SsIL+H/gvFOsaKRpDHLrLvVdocEGXKHxF+plbpt+lvCJcwhW+0xaDIaFtGT/lwF4eFKkpinDCxCv04nFAEjVcvQeYe7CnzDEo7o9Wx2QTthykfCvJjHqLrjSejTwk033XlKOLVjKdPFB0+mfYn4P1RPYp/nkXSjK+XytiF/kqyvlZvfeazIjRID3wBnMeQQ5BFKGglXwmMS5TmLijRqrElnD3KeBLn2f/qnhiyI2jKMrycw8sy0MJkMtAroxt/mF9xUs1fQwOCWqVB5QDsFBeyPai8n1P9zyxHo/pGLZE6LTg+E1WFeM1InlwpJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drekQOlrkG3dOXiZeq1i/weZBj844r2+xxMKg3UC1Qg=;
 b=HngQxoLhFXur92mqSAaWdxzLe6fQoJBWTuLOoh6ym5Iq4YWKP09b4oPiepYLobki9OOrQ8KMwN4FyEOtN0v7euYDo9N+Fe25ihrjarYmbaBWgmaSyaX+GiJHkEHPmlIhIlKIIVrJeVzq1UZ92pAxBKjluZoBh4navhx0yCVTNRjcHc7htlDFQLnL492Ghrfz3muNc+xuXXXu6fNVLhB3qLU5mN9zI/nFoeZ5Pj34Uf8UrzY19s2sveg4QB2LM3mFWN9eGPh0r1k9KMzYFJiQkgjY7qdImE9kkq3XYuRWNJ5OpcT38OCXJczzr1f6ZxfmcLXIcYiFvXGsCw6H4RGFyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6342.namprd12.prod.outlook.com (2603:10b6:208:3c1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 18:06:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 18:06:38 +0000
Date: Mon, 8 Jan 2024 14:06:36 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Michael Margolin <mrgolin@amazon.com>, linux-rdma@vger.kernel.org,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Anas Mousa <anasmous@amazon.com>, Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH for-next v4] RDMA/efa: Add EFA query MR support
Message-ID: <20240108180636.GM50406@nvidia.com>
References: <20240104095155.10676-1-mrgolin@amazon.com>
 <20240107100256.GA12803@unreal>
 <20240108130554.GF50406@nvidia.com>
 <20240108180140.GB12803@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108180140.GB12803@unreal>
X-ClientProxiedBy: MN2PR16CA0042.namprd16.prod.outlook.com
 (2603:10b6:208:234::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d7c58c-f617-4b3c-e140-08dc10748ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lK2UIBbQRnm4Ib0hEF2IBv9GcTPWx/r8vrMScmb9qHQKHfEe/ASgCmtnbfSCjHg18+tmqV5vzrCcCXvt2HakB44wDRPZcfOSNI9YM6whhnoKVVRnFzKaEVMLDJv0rp6ghgluVEOMmXT7QAFJp8IskjcBXvdv9lsK/6t/MvL4DVSMzmkjsedu/VxOGHqGhtGdh6l2JBV0i45zh2nMEeTJuPxXTRTF1F5182fQ401TDKZtED+mvnTAR5Sck47wKDezyBYv454ioiI5bvPe17zewfBkoG+/In7cavnxZMlvgUNgZjlA1xyBoYG+2r7SohC9kUXXGcK81vyflUhX1Jmb6a65EfHKGPwp9uIsxsUStyPBDLEaTjbl1S8JAMEVRbBcADMal98r/NGySZwCzRehXNJlgJghDChJlH7SgBkpCupdWM/NoLh8JVdsJYTDYjvBEG9Da4imQsJL1KtiWMNgAmvsWniPfsYja90aBcaOwTic1hcsQm5L6tNfMUP07i8zxWTzfQh8hCuverHeFMEVnSp2NAzY75dgnV7S2aEgB+3xMi04gerdf79SOookjKdr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(346002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6506007)(6486002)(1076003)(2616005)(478600001)(26005)(6512007)(5660300002)(66476007)(4744005)(66946007)(41300700001)(2906002)(316002)(6916009)(4326008)(8676002)(66556008)(8936002)(54906003)(38100700002)(86362001)(33656002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HjalOBuadH7KrwYLUSuWSvfbYn5m7q9dnuTxUQ5RaTl0h5s+WzFmIyvBPj9T?=
 =?us-ascii?Q?YXkEsF3ne85JEiJYLmUD+aRyet6+dbpIsUMvZLDOMbSqZVYLfoCd5d8kAanl?=
 =?us-ascii?Q?k/OpJMC3VedHUGNsFHMFWFrbhwij0rkq/MEIdCMBlGFUwmDS3f/QQvarT0Bl?=
 =?us-ascii?Q?mTEDrl4sT+7vuTMp/eIrn7xJnN9wTz46l5MXkH7qcELgdGOEKIPFIYD8ULPD?=
 =?us-ascii?Q?Mc4EfSMmQqSgf37VR2lP1nOCf9UNo0BYrt4Y+p3pqxddbHob0TyLJuyUdw4d?=
 =?us-ascii?Q?92wBqhbp3gcHilZvZ2p0tIgrqnYmnqpTlygsRp8qKfd6vAcVB6srxYyKPoU6?=
 =?us-ascii?Q?g1OzP4+U95iOF9ISz0aoztyyC0SpHY5/T1E6vw0OiHE90tI1DUchwnNyfXAd?=
 =?us-ascii?Q?DYH+eLtVH7dl6IDYwkKC3BOjJExd2sq8wTDMzaEvgxzEY3kPCV27kfJIQWX0?=
 =?us-ascii?Q?aalHzcQRDqr90w4cD3zlumpIfXszYOQDo6e5wENMtjWq4q7paUkKWJ+9Ai9q?=
 =?us-ascii?Q?nckIrdqyI0QdW0oxAenPg3ngn6Df3GIiJPG4BkbnFZ7JlVw0ulz4+G00SNOJ?=
 =?us-ascii?Q?UdPxdM1r1pDDm7ZTPp25fSrP+Q+T0IfGop4fQOjYuYdScpPnQ1itlkwqQrHg?=
 =?us-ascii?Q?Bf8PQNi4SBFST8t0iAg+mCl4g68ufeeyZyHE4s4pCkR+sOlkTXvkUKP7zAmg?=
 =?us-ascii?Q?mcQx3DWCLb1vUYMZaAl8JQkbIdUAnlFOvO1fLr8s8nnUxsEm7oofuGLLN6UE?=
 =?us-ascii?Q?s1bL9KBW257816qeTMyc0+7LCkjpe4OqHmTYl2vnd2MhzzgdOWWXbtFyDYQe?=
 =?us-ascii?Q?oST3u0FU4noKMz/4Fg7iWGJwUfFPnh9jVoJ6Rd6MpjAOxk/b9gdxhMfD0ejg?=
 =?us-ascii?Q?qy6pWHoBvVUeY+D9QcDpZnHjpf9xORKaG59yd90abvyf4cz2b/WlT/Fj62d9?=
 =?us-ascii?Q?9cZsYTMzT4TD0gCT6SH1VXXpna8fxsj+8EW3VwC7P1F1JOZflMfAgLfCysxr?=
 =?us-ascii?Q?8sNeWvOiiCg9G0JT3WzFGOY1MMN54CCpf3Nbm23sNqmBG10GgZs6fx0NcBiv?=
 =?us-ascii?Q?OQHrWNSabrm7PVJsHZ+qnFNthsk/Nr8Ne0hFLmMcxj5gGlNjqi5XQWnIZatw?=
 =?us-ascii?Q?5aGptaedAopVf8NSPebwCXTK0+qLceNrtdrLmxGlk9tpwwZ0pncyZjMLFhlJ?=
 =?us-ascii?Q?3ojoFTk+fhqGHk/zydhRQCDKyxAOFNmiBk7suZNRSqrpVDSnoonmqNZwMvXv?=
 =?us-ascii?Q?lcmMdFuUXYCsjiDlQGh9zwhNSjVNpjs5GjiNade27r57VR1ZkaoZ5TF6YtSu?=
 =?us-ascii?Q?6Oz7OD8H5PRtRmxy/rBFzFyVz2g6SQ9XgGOF5gxandTCeQpSwKx96b56vEOB?=
 =?us-ascii?Q?hnhdKzlXJ0vQxVq/A5zXTHHCQp4pIzNFAQhGQjoLl11rUgtNjeyeBjoSj9ST?=
 =?us-ascii?Q?doBKxxXfXOPQ+WZLL07usajc8HE26jpr/9StQNHTCYt/vVS76b9FLfhebB0Z?=
 =?us-ascii?Q?jT5EEY0SWOothfl5ishkgY8iAVce52GPkYBglkx1qvTtE278cjW81TE7XaX/?=
 =?us-ascii?Q?en7qpwmtCRTKOuUGOvTJLOvw0fzQ67tZuBIHqoJS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d7c58c-f617-4b3c-e140-08dc10748ed8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 18:06:37.9856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9h/wicg19VpLgQJ+wGeG0AX0DMbi/q5UZDpDtYmsFG/V6qLPFFnpkngsCQe8ELz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6342

On Mon, Jan 08, 2024 at 08:01:40PM +0200, Leon Romanovsky wrote:
> > I was saying in the rdma-core PR that this field shouldn't even
> > exist..
> 
> Something like that?

Yeah, like that. However it is difficult to get the out valid uattr
back in the rdma-core side.

This is best if the ID's can have well defined not-valid values such
as 0 or -1.

Jason

