Return-Path: <linux-rdma+bounces-16610-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDpnBE5IhWkN/QMAu9opvQ
	(envelope-from <linux-rdma+bounces-16610-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 02:47:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3815F9097
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 02:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16B593049277
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 01:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB24F2475CB;
	Fri,  6 Feb 2026 01:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UDlMY9V4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013037.outbound.protection.outlook.com [40.93.196.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5712494FE
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 01:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770342352; cv=fail; b=j7nvOxIvneh7o1zcRITN7vmOnhWZiuy3PvmH8w+meoMYcDn6Ps+nWLO7zkzCiGwxaQMyGZS3RCiolYhAgBtoZ9BowAuxeDQNbcTVdiXUjYfNrQWCJWqCQNevNyvyKhFE2aL6OUDNf+kBDU9Zi/+pZRFYGhKTZQnEvJ/Hl/i4lLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770342352; c=relaxed/simple;
	bh=FkGLa+YC76NW8QSKYb72dNp8rcYmvjiW3TrSTXiIAeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GDPwN8sE6BosOb5pA16UagbXHGZ/zUXzrKlTAwws1D7BJayY/pg73zEA9kAYADlW2dGlRXG0q8I4E7urJs2/p7oZh8AOy4wIHrihlTzu5GJKyzEvmKjuE1UGs3OCvi41yS0n3NxHE1/neomoltbLpHS8ovq/lsUSgQm/Uk47vl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UDlMY9V4; arc=fail smtp.client-ip=40.93.196.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngf26Z8sKNnY7lX+rYMu07JZTfyNYaD6vtnGUo+EnnotUEJPMuCiYAg0+5FuJp2rwYTm0/KqNRCtDNuooMqQFoLMxYsoDQF0WXkyw81rdhUpZVcCJ5TVdjAToKnHarLbqot4Fg9X/ufLX0EfuF5hJ/1HPZwnCvbeaHYIte4hi1q4qEwu3NR1oa+vdI3JpEJBS12KSEzvm2EEDwn3JJFrX9NTYy5YksJuq8n5BszplI22LIwn7kqP3pQoIZrycGBdarQwlP8y7XVQw15dQK+kGVpCrLtivcP8LfBDOiHQIooziv+DQ80OZ5UTg3MzAQ587vgfJ2YtyoyFiZKyMIri5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCFPDokuxIcFYGf6gqLvbDlyIoRBftEadED8/BTgBE4=;
 b=yj4MVlDkV4q7wbjoqb+iLgY8OHwi7FOmpSfupZTxrXxYS9IEyNYDNyGZVexdlXP1bvh0Yc0WEbRkU9ymBx8WHX5w+3VnO0QSfQli96kq71fyUdT77DITb+CBHDR58Z4v9YHdHx7QGN6VikiaHUZgAHfM8p0UmpIoj8c/UaBRPsw3DcCVISGwU8wkVoRLYcopTBhI8K832/+4tGsgnwY4bNCavBV9YAUWRWjK5dma3uJo/mMlYsf0YwEgHLrUvMX/XbHGeRqRng6m1b56L/Td52duNCi8UaOz/bw8mOaJof0NC8cEHOALYwZrNiXqB2GS3vEMOMDAK1GpPEWAQ5f9bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCFPDokuxIcFYGf6gqLvbDlyIoRBftEadED8/BTgBE4=;
 b=UDlMY9V4cgmRAR9s5Gp9zBeJZc1EM2N1wRJh6jpV4xyiN11Mb+SNL/jiaA4k9TiYBef+wEfuqgD5EHVw/B6tiuu0ZMnWykeYFdM078HzugpiLmx1buXU2pdOqtw8+IG9W+sZQc+r1BkqnuZUJENRE9eRmXYFrbylQtwwc5eQ8ivAlfdGvsTK42Xt5OsjKkh5OKils9yECeJySC7wD+6JeqiJglUh1F5hPjqK7t6QxCZb+frLwn3e7IFUcUEvo1IVQLLMPnUVjrjUZU9JdW2zgpyKorB7amMehtEUN8xcttjuCbAO12n/FTAfy2QDxKkvp1YneGVG4j9xKBTrM3wSxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 6 Feb
 2026 01:45:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 01:45:48 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH 07/10] RDMA/bnxt_re: Add compatibility checks to the uapi path for no data
Date: Thu,  5 Feb 2026 21:45:41 -0400
Message-ID: <7-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0041.namprd20.prod.outlook.com
 (2603:10b6:208:235::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e9bfa9-fb87-432d-3d96-08de6521731c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CrZcKYUNKeVbkn8G0j6pJ0GTdRZArZ8pE3++3727P4pUwPdDChBP8ueF8vYA?=
 =?us-ascii?Q?iqs0YdP5TNX/Z21C/h12D95W2yRpKuK6vvwGuy9OXSDI2DroNvJ2PRZFqobq?=
 =?us-ascii?Q?uh7+ykrJEFE1Hs/fW4SqBI7E4flZ43FPYqr11lxUcWF3IKt/ILXt1NVZ/rkg?=
 =?us-ascii?Q?Eai8XrPIyDS/xKMzA00p/zcmfttlbGuoUKOVTpYl98P3pzXhRXLSvaIzFREN?=
 =?us-ascii?Q?qz51kVIvhw0nvag77LedaA2RghMqMWHyzGkBuybNo0V5ZNickn61B2VJz/6y?=
 =?us-ascii?Q?8Gw+MfEFeCsLOKG6BnAU3llXz59icistiN2+mz4odPkOvxS5+BNud4+N5gy8?=
 =?us-ascii?Q?d4ZBWuwlRJasFkMQjUeSjHDhQGmD8ohX0x8rhwouOdeDb/OO4ozprpzQZ12q?=
 =?us-ascii?Q?1bG3kJ01Vct+M5uiVh7iQy/Vf4dcUjO16EvqSO5sxzW7PlsP4DqZx3/9M6cH?=
 =?us-ascii?Q?PuDUus35f583C6adVq2LEDMDMn8etximGc1iXMvgGGppdpZcuS4ocHqJZJ6z?=
 =?us-ascii?Q?FFcqz3LShkJATP/FVwmsa6aW+vSoma1ozywJL9FYkqClQkls8vZmwbxxWkUI?=
 =?us-ascii?Q?e5jvR4D6j9/CKvNolVGWwd0ixQT60IwBadf11tOsaOB7eiNgYbe/1QtE6YMd?=
 =?us-ascii?Q?M7wmB7tKKTy0SWJWcaX72vpyzemQPGy94d3H/VSB8VQw6oQgi86JWh9UxguA?=
 =?us-ascii?Q?FvqIU58arjRL61wYc3eDVIoDFIjiU1IpFTwwpQkdLXBI1PA9uLvhQAabPgli?=
 =?us-ascii?Q?NoF+UFnm36F3qEqkBI3qyfIUIkAnbLbQ1I6EGYjbGn9KkSC3/FQL6SIjj7+n?=
 =?us-ascii?Q?5BkB8BCUrg2Nr2cF/VD4Zvvg5jH7i1xzVNRUACobH7NK10KZ/g8T2D61qBPE?=
 =?us-ascii?Q?3yp0JDIM2LLHDjor/KSSuVD+9UOyB8K7x+TaEfokHC7tCqBz3QIQffIcPn34?=
 =?us-ascii?Q?/sK9iZOqyjXeH8MwnaQAdbNlhnjg10izWgp/QqDyD+aoucVsYIRxbVu8Q5tT?=
 =?us-ascii?Q?y5WbXetd/EKxRB6e4KxS4WqbuU0lGqOYP34SnGqLChGi1PqQaKQhb3t6Mqwl?=
 =?us-ascii?Q?1pm2oANrhujINiDLG4uLzgl5IOPQfLd0jEwTcRdeW+GSv0N3CvOab5CO8srh?=
 =?us-ascii?Q?6qlR+3NhaihyUKFvlrdyPM9b1SqVSk2hymKfjKGe7VA/SDA9Nj2g1sk9RdRU?=
 =?us-ascii?Q?CBFgOW6x2WQc7FgdwtGrKGuprb7mA2NS3wDZ52lmzzXu8CV0uv0BLfvBDjgu?=
 =?us-ascii?Q?IN6sf/eWwxj9v898CnhRijx8CmRt3fV7iz+OUx6yC+03ruxzICMGieRrIlQq?=
 =?us-ascii?Q?YkVp58DIEbuC+9DUCMlQtKD71Yjve+UsXeseijC/AUqFQNshh1HOV2tmhGe/?=
 =?us-ascii?Q?vriQiwjlkyfC8AfFvdeqDSu6gomLvmHx/8p2GlcE1/yZ3tj6JbaApCZnxmL/?=
 =?us-ascii?Q?26x/AS1SV71hMNHsrN7eE6Tfft5Ft7OLn0/aZH2dgh5WYp+2hj9Hw+FjF0F0?=
 =?us-ascii?Q?3jQ4MlpLneNT98Qr4tVRE9TgS5E1P8MSo9vN4/rMc3FPfPxgz5uaSFV6R/DQ?=
 =?us-ascii?Q?CBbdkuqkZ/rQp/ifkbQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PDHOUblPVyuG7ZvqBditHCE61JadQ3SQgUTnt2fuXKjqxyxl2IE7q6SvBdTN?=
 =?us-ascii?Q?Bm/gJDx5UFOzEznTNBGmFmMjCaFe6G920aJdMdscchFTh9oGR97nM0sHE5qS?=
 =?us-ascii?Q?0SrRlWUKPEBJ3+SniQXgyplwM00Ta2McLSwdeSPG2OjUx4mhLOatqX7K/qQn?=
 =?us-ascii?Q?qmBOIJpMCAepOlWbYVloyxM+Km8P83ai1znsqbxO1Do1M4iK0rioSnFAzAEk?=
 =?us-ascii?Q?RSKGOzQF44vcFK6TBl+RyU1LG5gQbFS1Xm2ol6FUgvq3YmAX4BZIf7g6xjd0?=
 =?us-ascii?Q?oLQQ/+aAfVoIGr4Rb+QhMQyG8WISKDyK59B/S4UOXFoPJheLIB2g+qfQhKEL?=
 =?us-ascii?Q?5fc5ZITTPKpH5d1gsk1zOStckdRvQwbcsDkGORSsdDSbqA1zSVAZk6cyNgAi?=
 =?us-ascii?Q?NPWPx78I6Fm2R7wEaGBWAZngps+ziDRSXzLcTLQCgZ1EHuyl7QCpacE7dinU?=
 =?us-ascii?Q?lcIfnDxp1CbrOw0xUrb78ztx0nMd9kxrVeKJ8fMIL68cebFXBE7dfp9d79c+?=
 =?us-ascii?Q?rgR0X3d6pE4vq4za5vdtE1MD5tbCGK+I1HaQvpPcsFSCKrE1Qvr93YybVqlF?=
 =?us-ascii?Q?HtRPa5+rvIrRa+CgMoAX85HJDPMstypIXgrjxs79l36RGXW6+iNUAGNraQWn?=
 =?us-ascii?Q?csVkW8F1bhyzc2zofFN0oJzyKSQttI+M4RQzJnRIrVk4Wz+g8NUAK+1WZWh/?=
 =?us-ascii?Q?BKdI8DfNRmbXRGhN7EfXmHlv4sf3CuoZOWjjJ7AQJ4V3ehkL2f8jbGvF7Dl+?=
 =?us-ascii?Q?RfB8k5BUiRijjZwXzYvAAD1YpCNw7+JewUobk4iM16lceBDEcA67Yivzln8u?=
 =?us-ascii?Q?pimGYWB8kYetqkhs9k9B+kZQkrjnyn8Vhy1tcNTjFkhtAizTrh/xD+azios9?=
 =?us-ascii?Q?vhXJ+EDOMRYyOi6BB5L18HlvvNZuKBKs8djjp444BDKOogOQzaYFr8t7yvmX?=
 =?us-ascii?Q?mVDJCMLLrMHxJM5FXDH9BEkq/t1VK7KLNu8v2w1peXHbsKsE0uQ7K16fw3iC?=
 =?us-ascii?Q?O8TAhHArJXy9F6zZoq6fETWP3Khn/EsbnrW1OaObUOcYiGFU7Me94QF29OlD?=
 =?us-ascii?Q?9AriMiQgSqBoH/e1Fb/zWVzBVSpKVZqF0BRRLqLrsE2W6fqMA8gg64X5uXQK?=
 =?us-ascii?Q?P3WUUrhuUldlse+61jyWpRPpSre32JbLwbb07jBrjSwP0seczPnYY9TVS6Ku?=
 =?us-ascii?Q?vPeAhxIOfshkF97/m7pSBNQy8Q/VrcIdc4mbFUt4UNlGnyiaXMKmaS9ITllc?=
 =?us-ascii?Q?MU3W0SnAALWGB/xRYwfMhOg95iM+6VV3e8wIg0P2/v5PyK+z9eJ9+sqWaiPD?=
 =?us-ascii?Q?YihH9TPSs4H1Fy5RASL6PZlHjHXQt69X0l82c9IpUZ2+m42guCP7YPumLEUm?=
 =?us-ascii?Q?9qdc1fbMUwux846VPMeE5sSyMcuTP7aWQap9PlkQKw0COrdO39XYhznaxvE9?=
 =?us-ascii?Q?wMz3bPQgX40EoBsly/reTJghnqy+XDVd3FJ9HqS2xxw+dBkVqSgG/2mKvkTA?=
 =?us-ascii?Q?yGMvuXY6TTdnedFy1rc9/qaDOQwCORvthEcTYgewZpN1mlN7KdCZ6Y9AQ3vM?=
 =?us-ascii?Q?s2ad3A4Efj+hJffyDeWifheVHejrppK3W8htLx+eVnlmEr9MwofNXZRWCvut?=
 =?us-ascii?Q?mNKKW2S9xNqAi3T882qKj6sleRFTJngOPCWXQb5UfgHRTPs+guApJVNrGBiB?=
 =?us-ascii?Q?cR+x+Kz7RjY5Z3cFaStJFwF1GD6I2cbv04so8GT7wWhzgQFUnpjZFMVBrm1c?=
 =?us-ascii?Q?m8h1N3zriQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e9bfa9-fb87-432d-3d96-08de6521731c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 01:45:47.4569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6f6VdXEI41oMjbAIGBbZyZyC0V/cPzeNQ6n9pWmq+Y/N/O7p2nChjvXODc2JduwQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16610-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: A3815F9097
X-Rspamd-Action: no action

If drivers ever want to go from an empty drvdata to something with them
they need to have called ib_is_udata_in_empty(). Add the missing calls to
all the system calls that don't have req structures.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 39 ++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 2942ff44f6a547..485785fad1df63 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -187,6 +187,9 @@ int bnxt_re_query_device(struct ib_device *ibdev,
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
 	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 
+	if (!ib_is_udata_in_empty(udata))
+		return -EOPNOTSUPP;
+
 	memset(ib_attr, 0, sizeof(*ib_attr));
 	memcpy(&ib_attr->fw_ver, dev_attr->fw_ver,
 	       min(sizeof(dev_attr->fw_ver),
@@ -676,6 +679,9 @@ int bnxt_re_dealloc_pd(struct ib_pd *ib_pd, struct ib_udata *udata)
 	struct bnxt_re_pd *pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
 	struct bnxt_re_dev *rdev = pd->rdev;
 
+	if (!ib_is_udata_in_empty(udata))
+		return -EOPNOTSUPP;
+
 	if (udata) {
 		rdma_user_mmap_entry_remove(pd->pd_db_mmap);
 		pd->pd_db_mmap = NULL;
@@ -703,6 +709,9 @@ int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	u32 active_pds;
 	int rc = 0;
 
+	if (!ib_is_udata_in_empty(udata))
+		return -EOPNOTSUPP;
+
 	pd->rdev = rdev;
 	if (bnxt_qplib_alloc_pd(&rdev->qplib_res, &pd->qplib_pd)) {
 		ibdev_err(&rdev->ibdev, "Failed to allocate HW PD");
@@ -817,6 +826,9 @@ int bnxt_re_create_ah(struct ib_ah *ib_ah, struct rdma_ah_init_attr *init_attr,
 	u8 nw_type;
 	int rc;
 
+	if (!ib_is_udata_in_empty(udata))
+		return -EOPNOTSUPP;
+
 	if (!(rdma_ah_get_ah_flags(ah_attr) & IB_AH_GRH)) {
 		ibdev_err(&rdev->ibdev, "Failed to alloc AH: GRH not set");
 		return -EINVAL;
@@ -978,6 +990,9 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	unsigned int flags;
 	int rc;
 
+	if (!ib_is_udata_in_empty(udata))
+		return -EOPNOTSUPP;
+
 	bnxt_re_debug_rem_qpinfo(rdev, qp);
 
 	bnxt_qplib_flush_cqn_wq(&qp->qplib_qp);
@@ -1828,6 +1843,9 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
 	struct bnxt_re_dev *rdev = srq->rdev;
 	struct bnxt_qplib_srq *qplib_srq = &srq->qplib_srq;
 
+	if (!ib_is_udata_in_empty(udata))
+		return -EOPNOTSUPP;
+
 	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT) {
 		free_page((unsigned long)srq->uctx_srq_page);
 		hash_del(&srq->hash_entry);
@@ -1977,6 +1995,9 @@ int bnxt_re_modify_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr,
 					       ib_srq);
 	struct bnxt_re_dev *rdev = srq->rdev;
 
+	if (!ib_is_udata_in_empty(udata))
+		return -EOPNOTSUPP;
+
 	switch (srq_attr_mask) {
 	case IB_SRQ_MAX_WR:
 		/* SRQ resize is not supported */
@@ -2093,6 +2114,9 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 	unsigned int flags;
 	u8 nw_type;
 
+	if (!ib_is_udata_in_empty(udata))
+		return -EOPNOTSUPP;
+
 	if (qp_attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
 		return -EOPNOTSUPP;
 
@@ -3111,6 +3135,9 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	nq = cq->qplib_cq.nq;
 	cctx = rdev->chip_ctx;
 
+	if (!ib_is_udata_in_empty(udata))
+		return -EOPNOTSUPP;
+
 	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
 		free_page((unsigned long)cq->uctx_cq_page);
 		hash_del(&cq->hash_entry);
@@ -4058,6 +4085,9 @@ int bnxt_re_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 	struct bnxt_re_dev *rdev = mr->rdev;
 	int rc;
 
+	if (!ib_is_udata_in_empty(udata))
+		return -EOPNOTSUPP;
+
 	rc = bnxt_qplib_free_mrw(&rdev->qplib_res, &mr->qplib_mr);
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Dereg MR failed: %#x\n", rc);
@@ -4166,6 +4196,9 @@ struct ib_mw *bnxt_re_alloc_mw(struct ib_pd *ib_pd, enum ib_mw_type type,
 	u32 active_mws;
 	int rc;
 
+	if (!ib_is_udata_in_empty(udata))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	mw = kzalloc(sizeof(*mw), GFP_KERNEL);
 	if (!mw)
 		return ERR_PTR(-ENOMEM);
@@ -4294,6 +4327,9 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 	struct ib_umem *umem;
 	struct ib_mr *ib_mr;
 
+	if (!ib_is_udata_in_empty(udata))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (dmah)
 		return ERR_PTR(-EOPNOTSUPP);
 
@@ -4474,6 +4510,9 @@ struct ib_flow *bnxt_re_create_flow(struct ib_qp *ib_qp,
 	struct bnxt_re_flow *flow;
 	int rc;
 
+	if (!ib_is_udata_in_empty(udata))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (attr->type != IB_FLOW_ATTR_SNIFFER ||
 	    !rdev->rcfw.roce_mirror)
 		return ERR_PTR(-EOPNOTSUPP);
-- 
2.43.0


