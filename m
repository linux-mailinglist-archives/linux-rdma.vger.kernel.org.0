Return-Path: <linux-rdma+bounces-16924-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP4oArEzk2lx2gEAu9opvQ
	(envelope-from <linux-rdma+bounces-16924-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 16:11:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CE514532B
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 16:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8290C305040B
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 15:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC05431196F;
	Mon, 16 Feb 2026 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ul50Zvub"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010023.outbound.protection.outlook.com [52.101.193.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0F4315D21;
	Mon, 16 Feb 2026 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254181; cv=fail; b=sEl1Wiy9Y+sh2OzUhbBysL66nN9IXPSYhz2wQrKNu1k4myeJbd8PoudRpKx5OZDtN6qrrGREeLeKxaWLOBcO/Kjezf3Hc72LL5v1Lcu2wsXJxY/u+B2GV1WcFrM8aTP84MDJWs28PUZlcM4u4MtsqSQW1ELzuPZUAI8CfnWMGCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254181; c=relaxed/simple;
	bh=wxi3JEOa9xNP8zEzZiZlGK+O4tkbMWODBJvhSLHEISI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L6PXjWTcQUnPVbrttVnyRcoyp6A3XCENTKWOpqu5ELLqAgHsf9IQlP/dYqC0IpguAiQr49tAz81n2mxdjs9Yu0Lzi3fiHfaVpRiaKImD6kHYPWWsKqt/nWrVRr6TPqtN4EvijXNtXb6qQ8yiM9jnML/F80q7BuLhLf73kU+TSfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ul50Zvub; arc=fail smtp.client-ip=52.101.193.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnacjNZvIHW6XclzQRyZ+0SwSaW/UA2rhKPWGDxwQGPqCB6VRY6bktPiJBD5Wd0nwtSvZxTf+xOPqghVjZSDc2zqAxdmIU+mjNFedYnACbCPh3Ey5FfhHULKLpnfqrKV52V+UnlZyWws3SwQSG5LUuk1Y/ltvUVNB7K5kzZpi7/Pa/n+4aDbBcSYq9MiY2zZ3zhP2lUxXx8HqXyI6xkkJ3ft4aN5P44BEQf+I+7FsUhqu2PBFEY9KDMHx0uH7NmitwPEwlUJ0whYal7UYdgZW7REbxPU24Gp4CFKvAThZu1/ayPU17ADUnid2c7qZe6PW6k1UdyO7BIH16GCrzZ0og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7qzGKDfkD5pFzrSj3pPTPs0NQSd8yu6TywwuHeQUss=;
 b=qtSKOsCgg1JGoKGT4lQsJEk7bI4hvedYRsMvp9cBR3Zt5O1QItg/0kK8Ful/yh7gEOQwFxXyy4quuGdY4Is7T1d6nZBfIVQH2G5Xz2lOS1uiiYT/aJeMzAEKkL6Tl+0z8LQMeQqomNeQGvcG+HMwQYGBBruMo12Qih+h2TTuNygvACb3kRv2YdU14xlg6dSSd8bRURIIR6OAQu62tmGsGPi0HGVGpxVO4b5hMc12YJQwg3DEN5Mkflw5AU46QkvyvTWCij4IxwouNirwEUxl5M9lGm4xlvgDBHHu650TpQuksvZC3WO0vh4V2Y5uZ+mXcDLwxrEnScPRP1QgeOMDSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7qzGKDfkD5pFzrSj3pPTPs0NQSd8yu6TywwuHeQUss=;
 b=Ul50ZvubFqDtlehhzy0SlIZMCA3Iz/1IR7/WTWMlFRZnnKZAhGPBrzOjvacGyHQ9IkcbeHeTOfp2ioyUyFX/9k+C50/O+Fcj5h1N21YYVS4ZiO7ShLGDBRVChvwIZYYMHzueMl8TZUqOWbrzJOaCfowhu3jFJT9LtzjC3uikumLojnxovTt/3XFER+LVlyDGAAcXzjgqDhLCBKA35/5GKJfGRIJVK5QRtVGKY/TmYLmook7NeU+dJs0FaT0wD9hmZ2poonHapadnentE29M/F2EtILEwINeD/X78cMc7nmFfHNPwXjUBfmHMvHn2Nte2vejWPN0QvmCceEQQVUBo6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB8588.namprd12.prod.outlook.com (2603:10b6:208:44f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 15:02:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 15:02:52 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Gal Pressman <gal.pressman@linux.dev>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Michael Margolin <mrgolin@amazon.com>,
	Yossi Leybovich <sleybo@amazon.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Andrew Boyer <andrew.boyer@amd.com>,
	Gal Pressman <galpress@amazon.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	patches@lists.linux.dev,
	Roland Dreier <rolandd@cisco.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	stable@vger.kernel.org,
	Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH rc 3/4] RDMA/irdma: Fix kernel stack leak in irdma_create_user_ah()
Date: Mon, 16 Feb 2026 11:02:49 -0400
Message-ID: <3-v1-83e918d69e73+a9-rdma_udata_rc_jgg@nvidia.com>
In-Reply-To: <0-v1-83e918d69e73+a9-rdma_udata_rc_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::34) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ae4e34-cf06-4ce7-51d9-08de6d6c74c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WFdAHAhkBmmWV4XaWD45KO1RCV6NNAaDZmnDEInqSbZCg59lYsKzh1BvICQd?=
 =?us-ascii?Q?rd412VkwhsVj+F9EA4TIiyIociWM/YKLfqFyQlAIe8cz5j0h8qF5c0+lMxhc?=
 =?us-ascii?Q?NengYgrXDlkJnjVjb/y6mEi2Fyb/1HMh6BX1Y2P13VtWfeHyoPgf2mgumzhE?=
 =?us-ascii?Q?y1wmfNUTb1ej1GM8NNa3JvUO+VhJP3KBkDZsk7CU3s6HwEgHIFKlcaf8XDWp?=
 =?us-ascii?Q?5+UzyEOsSE/G9KejGmJRy18NLs8Hm4gXAzTbM7Hy3gUk0iXC6ZfXF2vMSM8U?=
 =?us-ascii?Q?3wt2ulBg7ZcVJgbBM0GehVeKX8jmn1UrMPQsFdps2Sl/DgvBBaciWtP9yXXN?=
 =?us-ascii?Q?ODmb+xvbSTS68ktxxrfCKk7Q9mldqGRAJbAQrjzSQzWhAVzRtiS4qi94mzOR?=
 =?us-ascii?Q?Vhk6U3IDsgU2HPQpjS+yOQ93E/MDi6yOwmhPG/FrJhygMVuOeOnZ8c74GCO3?=
 =?us-ascii?Q?Jtq+02/j+kXyAcTVbtb29fxvMjx3IEADEchY5bEjg9l1+gcDDLjS5wkkecW0?=
 =?us-ascii?Q?iwusW78Op8K7n+wbQLDCQDLIUDPeaEPT4hYE4MKn3KJYyrnv/9sVeuIDrN1P?=
 =?us-ascii?Q?MHTMblvmZSIAKEq9EujLDA2QYHvZmNGucwElKukNrHSq5NSrJWgLCp+Yq5XU?=
 =?us-ascii?Q?FZQOuOofdMZHqtEGGsTxmFfizSxxW7oTs2p8Wn0cFMC76fAhK/iNBivUmlM9?=
 =?us-ascii?Q?nnrufne9nYD8LAFJON8NY6BaaDuaFD3pyhBk1mmMouYROOFHsQsV5ICWOUQj?=
 =?us-ascii?Q?huFMKIxygYXgt8H6dclHRPrAJZUiD3idOrzVSSzikXF7tf9ndqLd4QmGeSFg?=
 =?us-ascii?Q?l5i97kbF/ZFH+lnlfSVoZqpMp64HWmJ9q5x85mljLQP43r7RRjKwn9lDBFlE?=
 =?us-ascii?Q?vKY5gYtNXcxKZRY6Aa3F9f744L3bX4Epl+p0mhMAh2B92uq0qorFQzqVkkfK?=
 =?us-ascii?Q?WKt0LRkT4OQGZehDaQGZWQ1c7VHNANeGUnTDCoZYOnwjCgBStL/JBJ/B0t6f?=
 =?us-ascii?Q?Le6dNJ10E6ORCgDmZaKIoxRO89LLDrL743UZ/HXAf36+G6p0yDk5ky4qJZXv?=
 =?us-ascii?Q?PN32uuwV9UGVH3LAWAVSRUswix8UuFGZYvRDLCv51cfJzVPaY4wHehm0ckxf?=
 =?us-ascii?Q?48cRCMBlsR7ftMT+6zta/IB8pOibIf0TNjiLf9tuuAvp2x279mTPMDSqg0es?=
 =?us-ascii?Q?gKgUKTOHyZZ/Ap2Qq5tQkR7HZGpdRwqLVLKUqeyCh6X/Jhag+U+QsezZA3X7?=
 =?us-ascii?Q?4AhLxmiwLFDy0FgIUxT2Ra8HSBHwajD3CXv+RlGV88immGNPCwyMLmTAZWmf?=
 =?us-ascii?Q?sIeqk2gaZaQ+iBpvIL2jCklAILVDOANq7J9uCd8aOhY82N1G+5Hwi6uRt/Aw?=
 =?us-ascii?Q?jZ9gahcsaVMAxUNGXcWj62smGKPJoGrQYLV9P0r9qQdo7lFud73tvoK2qFkq?=
 =?us-ascii?Q?ZK2BzmA88pTDMuYKZiiogv4UBsSOqx9NNnugHX7bUxQNe8e8FE3iGi0ZWFj1?=
 =?us-ascii?Q?HnTUUzi7aanynakQCMQTrjK8iZE9Yt799H6teCDVNLSfQkqq+7UvW6X5fGU3?=
 =?us-ascii?Q?Sk6TmLCgbkpe33HPEz8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/rWi7isFeArahyVgAKsPvK9dFBpO6T1bIVthweXVR64XrKxFSJZYHloQGrA+?=
 =?us-ascii?Q?YCSblpjEPm1PEwZCMYXTWG2LfbGEbLQhp6DZyGMF7Qief5CA7oh0n6r6pYa/?=
 =?us-ascii?Q?0xtCnsYbHfUEIdaBxQN3vttnfi0IS+3Nuapvz7EDuzPwxMl5KuE0Lq58tYrI?=
 =?us-ascii?Q?VhDTqhtmYZiMG42xBV5DMlrXjYnZI5o07E1XDSNOmDMFvZl5nGXMjzIi7XGV?=
 =?us-ascii?Q?yftvpOkSJTkBQVOY2G5fk5GWNneinSPP6IRP+GiWinEGztz24ibF8u/dVEYU?=
 =?us-ascii?Q?bsmn9FVifyfuSOI2ZDyzTvQvY71/AQG1Cbq4UfEyxIfp8biDBAMA4WqqbqPU?=
 =?us-ascii?Q?w3hSAVYU/hpn3x8+r60rQGraKqY8XDThPeEiINGuTbSNoU2oMru2D0ZzXgVZ?=
 =?us-ascii?Q?Rbacp/sJR6puXxCTbf2VytPkNOi99EC1TlyDyI3MhQ2x+FbbTOoBRoM+WQJ2?=
 =?us-ascii?Q?XTcoaHW6RwXXCtI4ouVMsA35YRbpQS7BD8iz2iSVOTsCq/r/a0ymZzfjEpCf?=
 =?us-ascii?Q?PCjj3oesTPc6BtQpv19rwqNfWx+ANET97zfgudyj/q9gJ/O8C0dLU7gWY0J5?=
 =?us-ascii?Q?4Zwtv/Zo6LuEbcXXYbTgU/EyRXVYoo0AuYEkkwrSdbmjUM4c400IRMVe4ary?=
 =?us-ascii?Q?1UmAnHwnbtWBJHYBLajfeZ6nE2ENiAivVfytHkpoP5laPVgPjdjkq/eP3Hal?=
 =?us-ascii?Q?EUTQErrK1qk7nV2Ny6J9NX5v+ol+8fMGANFaA52AW00PoRxEacrvNN6zUzEs?=
 =?us-ascii?Q?mIoX0QlSVZTqfMrJVUySeNGMQeQmaucwUK4xIqT3xqldA8v7UIewduNm6cFo?=
 =?us-ascii?Q?9V6T+XzAZw8v97USZ4qvhj5aw/eT8MBivDOR7exTK/+nyU3lpJj7VmBFmpqt?=
 =?us-ascii?Q?iMq12eUslDZD55WkuvJ60WUopee1mCJ9BXPCvZHP4YqI5GUKpF+KXdKvwNut?=
 =?us-ascii?Q?CPGnNw0LVfDx86dbSzSnIuwsWvw45vQDEiwujaJP58mzGWYQRQlskkEZlvqy?=
 =?us-ascii?Q?sT1+y9foRwI/dYoY+AA73r20eVvNEaLFuX7tKM2d46ccnK3RseokSbr2iWZO?=
 =?us-ascii?Q?ejRTqdUm1Zc3wQ2D029zHHTobUENHpGH6T5wxpckDzuG7FHecFkt4ANDrwfI?=
 =?us-ascii?Q?IGc81+C5thc9HO589BIYxauBBGuektL5XWpFPhqs9GBoKFbnlZNikKz7N5Mx?=
 =?us-ascii?Q?eZ4NWPdhO/Q/RNHzrbyLUElh68smPixSQ6mWIGPTw7+QOqEV6daFBheUGSGo?=
 =?us-ascii?Q?Q5V/7vknGG/6WBVQDOoqg6nDZpljT/qUJfkdsWA7uMZIPzdnKx76Mmox12Tw?=
 =?us-ascii?Q?Ngq3aTX87Vb1GtpxhV4BB+RoQLAnb7l6eT4Aif7apGR8ZhlOK3x+d4sZdXKY?=
 =?us-ascii?Q?Gxk6ICjrEPt9Os2jfyvzR180id4Z8IIZ3nQ6vxzHrDltrEjx0rH78jbqyjqZ?=
 =?us-ascii?Q?Nq8YmC2l3sC9cgbslz/UBx8fFl3FVTexFnelDk1g3mxSxdDr0Gbrgy+saoyb?=
 =?us-ascii?Q?r7jCf55ULA9xIm2MvwO0tM89n41jKrXLxnpv3mfSwkRtWjl6+5yHQSkG+ECR?=
 =?us-ascii?Q?pPdMi9nMLpkmvaE21S2S2k8X2Yq+8XeQ404wVNOae8/9MEJ8elYQU3wj+F7Q?=
 =?us-ascii?Q?18YpKLz3x5zqWCC3mNfBHgudAw5pWhpOiOc7LEVMjNBlkoMzP9nGYYnnZwIG?=
 =?us-ascii?Q?ss2hcgiSfFG/Ps2ocIEKpv+Lu9dXk9eaKxjA9loMcBEhdsBE6G7iRv4mfzz6?=
 =?us-ascii?Q?pAcTW/wurQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ae4e34-cf06-4ce7-51d9-08de6d6c74c0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 15:02:51.9323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JOyfatvQS4Di1HtM9SgT858IDdLXZWIlfAcIB7bO7PNjbQ7D/if6lhhtARA3RSo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8588
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-16924-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 78CE514532B
X-Rspamd-Action: no action

struct irdma_create_ah_resp {  // 8 bytes, no padding
    __u32 ah_id;               // offset 0 - SET (uresp.ah_id = ah->sc_ah.ah_info.ah_idx)
    __u8  rsvd[4];             // offset 4 - NEVER SET <- LEAK
};

rsvd[4]: 4 bytes of stack memory leaked unconditionally. Only ah_id is assigned before ib_respond_udata().

The reserved members of the structure were not zeroed.

Cc: stable@vger.kernel.org
Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index cf8d1915057402..afc41619a0abc4 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -5212,7 +5212,7 @@ static int irdma_create_user_ah(struct ib_ah *ibah,
 #define IRDMA_CREATE_AH_MIN_RESP_LEN offsetofend(struct irdma_create_ah_resp, rsvd)
 	struct irdma_ah *ah = container_of(ibah, struct irdma_ah, ibah);
 	struct irdma_device *iwdev = to_iwdev(ibah->pd->device);
-	struct irdma_create_ah_resp uresp;
+	struct irdma_create_ah_resp uresp = {};
 	struct irdma_ah *parent_ah;
 	int err;
 
-- 
2.43.0


