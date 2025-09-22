Return-Path: <linux-rdma+bounces-13567-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6813AB918BD
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 15:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 186E37A771A
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 13:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C772C30E844;
	Mon, 22 Sep 2025 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hMEO1CqS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFF530F7F9;
	Mon, 22 Sep 2025 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758549561; cv=fail; b=MVnihLVBhzxbZgK1f4+4Zet+rz8nYDJhH5N2mnfwUvnTluOMXpTJ+8ch7QuApIqlst90cMLu5C9K7639Z8mpL/AQQN9tKCUvR3Xgx0oEFEnur3KAic18e0VZusMwq2UptzFuPaA8bCuelpp0EyVQVyIbr6uMCq7Kg/x6J9r5v34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758549561; c=relaxed/simple;
	bh=FSlAwxzG8/ko40JMyvF0O9cAyrM4+bfHy/cWiDZJEnk=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=oCVnkmGuQbpZziT+o9hkiqPigX2i9GZ0A3G6ePfJG1eH3jLbkjYQXOknDPQSF9mGfkWYqnv8jyt0LtQVXFxHRin0rabWNVh7aPJu4lzhdZbOlrUXlcnVsFO/rCXTEXy9NzE+ndGR1AykdfVdjcuFw9AURAcZxWcz2X28wsAunGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hMEO1CqS; arc=fail smtp.client-ip=52.101.56.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JK2RpLneUFdDWZlFukxXJCoq20WbLNvTxpIml2gKxgLkU9ixLh7Ewl7pAM9dZuTzEu8UNaS8VJlZ39QMT1I+6Ud0i92W1MK+pd9+my5irMU08Xvo4At7658QNdxkfPXp2gVhvwuS1OYkuoERwwCtD2Vld6GzoS6Vf87ZUu7IV/rQ3zH0FqQKj7u9rqTfArtzIW7nxBINCFS9WQgib1UZ4cyhPk3CVZdRwApacnceFGzVgAET1sSMwDoAd5UpGtRp5jRkMHfdcWvyF+116Y2tDdRF/6PPk84iWeBcQ7MLbDMAfT8Vs7U6re53ilqOaSTSw817UIAYtuXESJ80pLjFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10ZDGNlpsgGiGiMu8cqQn8TgynRUsAy0W10y2QJcs1w=;
 b=KoZrbD3G5sNCyORVgjdBiwHtfESHeaZ+CkY+JuMy7Np0zCoz3NP9ocYiwezYMZqGZVTsfR/Zp82oaaB2PbdzgLkptHwUvEo37+O0wlZB27OMTvF0GyQxBWMIVByh8nO6Hz4Ni0522jqJrAqpMEP7wLcGsScnjNOA9LdLUqGPuPOsvvd2CJpO1lQmBeOb92QA5iHNBbsAB1mHR1u3yidGUTJxZQJPFmlhG1L1EC1rzifV6Kfk1/RYwjdjvBHhEfnYpYRnW7urMK0Fnjq0M2EVkqMAzFPmT+IGbu4gb9Gwoo6HzUCAQpaE4QbPR8YoWENfJq1n8zAOtVTkej53IFpAww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10ZDGNlpsgGiGiMu8cqQn8TgynRUsAy0W10y2QJcs1w=;
 b=hMEO1CqSPuEuFytoEW9bjOOEoQ0qtIc5AfNHVODom+i6MO42NwkCfNKYIffVDInZkhyIomUNONmFZ14zg9twJvcRYkMMWnpWYD6loPpJAohGfI+BknF/dYsh57AfB9VA9Ty/T9fQ1nr3eqzYn7QvmXmOroHsCf/d2vz9cmzzgF2hY/DKsGsxW80GFfmozIoKQ1urlswVV7ks2BGNe5sNsV1/IHRR+UR9viCTZR9O0/Hud6iuLOwvoQLrz43cJ1wvPcuIMZyYv9jv09NQztdXPa+5LfruxRDLZA0BJTWwwDhpeANCkD5aiRVuMQzbUhQkjqTT0XuRr8vHfESCKdNk8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Mon, 22 Sep
 2025 13:59:01 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 13:58:48 +0000
Date: Mon, 22 Sep 2025 10:58:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20250922135846.GA2502832@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LnBWRHvfL7tPei4m"
Content-Disposition: inline
X-ClientProxiedBy: BL0PR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:207:3c::46) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CYYPR12MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: b615fd26-57bf-4e4f-7d3e-08ddf9e0277a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Za/dxPQ+9u06gG8eYINrjyMxqRVcmJviwM18OUp4JTBL3R4oEK551QhTeeVK?=
 =?us-ascii?Q?sNVNhAok5DqgYVUJbgFHo7uEa6cFTOuZIQSm6N7W0JsM1tg4tAboj2uFG1Cp?=
 =?us-ascii?Q?Hrpky2wSifSbJCtbJftkMnKOts6+8p3z6Z7a35CrAM1Etgky9N7g0jLgXHlp?=
 =?us-ascii?Q?lJxG1xWZvjqMNhZzVQRQVCP4ouRbCQO57F5H+MJQQipwKQXu8iyQIpvCNxPD?=
 =?us-ascii?Q?buIFMQOR+/kyCf3Uw7NIDVfTXDgWfNFOhd4+tHbU2T+Yb9Sz2b3zuuvg3kVD?=
 =?us-ascii?Q?CMMU9wTzphpf82Jl4LJ255RdvloLcPbxjvjNLopRIkeYLehSI+P83T1CSZ//?=
 =?us-ascii?Q?5R/RlqFSg88hciocmJgzLs71CB78QUqQTbqEBSi+k4+bf9F1wx420vjq6mHE?=
 =?us-ascii?Q?elHisrVgsZJe7ksoOH6L6A3Q3YM0akiv/mO9lun8o6YstQVghru9DHGKYH+x?=
 =?us-ascii?Q?Yj7VYG8Q9FvSyUyYmQmAxO/wV+xPsEM3NxdBHpZsDIuol+bcC4o7OcBWDEQO?=
 =?us-ascii?Q?UJF/OWTf4/bGd6n+pI1tYpBXoseWKQNLGeNTtz9HFO+GoUKlNPR68GNCe1Ia?=
 =?us-ascii?Q?i958HFwsqB1npsbT71jLxBzSICstv2d4e2eIP6uRua4RS9HZjDd7tcdoAylH?=
 =?us-ascii?Q?AmzW20jRw4I7JBWCk+qSGRXUtMvwt80VMWid2YsnH2CURB2003nPdG1XLGoo?=
 =?us-ascii?Q?eT5R3nNJ584V2RCCr92qIKrGCopqCVJu619yTB+AZGkMJ1ynx5D6Tp+HgLxf?=
 =?us-ascii?Q?U4q+9Di38mzrsSntD8nK8W4CBlOzDxgHxXdsriQui72Y8FvQBRmmF8zXB4Sh?=
 =?us-ascii?Q?iCxCjM9aSzof6Kut+IkfQ3rMfuA89GmrjiITXVVcHHUvtpcxlKcBR8hExWDA?=
 =?us-ascii?Q?Hqxk8uBgeh3slCg2uOqtHQr+3UiWlKJEFtejCosfDRhrqh4F4Qocn7OLZwff?=
 =?us-ascii?Q?p4mTZH72Arvlc76LY6Lku+wysx9Uih6EYaOnhPbCcnMi6VofluNQtNJs1qVt?=
 =?us-ascii?Q?lTy/e+zhSNkfmYXIs0d9x1GIhab1mI5QpZzotkU5+xzbZjwr8lVAFlCaEe4S?=
 =?us-ascii?Q?LeWKDDOjf0CNckaYSMCaWhEmpwjfLGKv8yJnEK6uN4769fpvJx8jvO0u+gHx?=
 =?us-ascii?Q?INoR2ATUFcZNYqQUqs25n/aoYZ5V11t4tFWs8MUHu0IQ9Iw5cMblmrD+X68q?=
 =?us-ascii?Q?6qxXVxDkBRI2GBmmWq07lCuGDQK2tGhLb4ZrMbm/zPGdhG/Vv2qXT2ZbIZdS?=
 =?us-ascii?Q?31Wb1MfIrZxG2hUeivjA7kmYqh5vHQdDiC4v/01U4N/S3I6Wt5ZUwqwi11PO?=
 =?us-ascii?Q?kDjhj0Fgno8Ix6WnJfYeg+esTtI+zwucd2L7kM/rNdEP1V6/as/+wfwa8kvU?=
 =?us-ascii?Q?T0wOEJEKP412GXn4ROz3Q1+8uXAYyJ3TkwtaJrxrHsHIs141mUk5Hd3/bDSc?=
 =?us-ascii?Q?iq0gzCeI/L8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ihwe5ukErGXqHNiYEmT2Wd6XBwONL4YwpWkdczZpKFd1RST7yUSxUSWjmj93?=
 =?us-ascii?Q?Ca+FXbCFenaPM6nulZZBnhxyQIOZOBLmjC3XBPNwlBeewjcdgaouDnWjr6pZ?=
 =?us-ascii?Q?/eCOeAv2Ebgg4N1Cgt0XYMm2bdXomAsEPwQErcadoCMdYaykNGaiFTtKRrmP?=
 =?us-ascii?Q?wvmdBNqELM/RJBaZ2YAplGVfB/+0Em2T/TaZUJ+FmycrqX8pnc1V8JPYH4hh?=
 =?us-ascii?Q?5QngFOZ8SNyT+NoKXHCUJt8kNuWjFk2bE6JebuDvxug7e3xJycenqKS5mGcX?=
 =?us-ascii?Q?T0ggWaljf37Qm++du80kuiclzrZbXQGwHySpAXOcYPq77BcQC9Xmrsqtai1C?=
 =?us-ascii?Q?D6JSsBknyKNauWXJzZBfVBdRTVBO1Ix/+Btqo2egAMO/etG1aZS/0AhdzMjA?=
 =?us-ascii?Q?rOBBzN7SOeqhwlCf76PMApPc50sl3zjnn5AAvmwrnZpRulTwKHlqIwnyBO75?=
 =?us-ascii?Q?tIByy2qY+EGRB3/0fSV3SW4pBV5QXjLf8wxQU+SkZPBOxGnYg3L3+oCJ0elZ?=
 =?us-ascii?Q?ESfWTkodilEUumgN+q3THHLx/va5+uC89dXOS2E2inot6Ec6R3+OClqMS7PR?=
 =?us-ascii?Q?hC1CUfJ7RNqpX1qcnYA2z0Io8o5vckGAf6EwJi88bPZcOe8Bvvh6eAhw6dJF?=
 =?us-ascii?Q?xSBiktV0wWSvKz/U+77e7733y623jwAatz/Z19G50+6osnT16n+XI08XWsYd?=
 =?us-ascii?Q?GAuGQXAkniBhDwmfpyYbcl5DRZyjlDQ4lpHCIh1H/GOwjaTeAJeahfEyeGtf?=
 =?us-ascii?Q?gKvLPM2dbLj9/D2hopQAApZw7UkayJ9WSQN2fcpwI0uKaob5JL2GFNXQRm50?=
 =?us-ascii?Q?JJU2a96U5itDTIteZ0/WarsVvr6KAPy/rrxypGMp/SjEkZLjviRXNOoWhQ6O?=
 =?us-ascii?Q?uD9YsRDrl65PqZH2PXgPQe8cU7hHK2LbyvIC9mN/E6d2aeyKBo3SOk8TU8lR?=
 =?us-ascii?Q?YIt9AQpCfwG3IkviaoEyTE3Nmxfd442NXBb8ab+69ls4Ayi2+UtCtgvQgLg9?=
 =?us-ascii?Q?/8SANXGVVfwaZgW5oCIyyAb6IwGPnj/YsCDz/TQqSw/k8EWOJF/YXVrTUD/A?=
 =?us-ascii?Q?fNlPAd/hjBfhRMUXxdBPHxLHViE8qZ6kayTKSAbYlaZUBOb9mCEzptR3/2I1?=
 =?us-ascii?Q?dbthmRNjS2yWhrTa6Zb6VdYt0hARbCgjfiz7Ppi+/n8KXwMAi6gkjYDfYlrO?=
 =?us-ascii?Q?dTMaBBsqK9nqvUbq9zX+UphcjRyXvM8Hg7nb7KY3BCfxCMNyzRnn/visDENv?=
 =?us-ascii?Q?5E2YS0VJxbs2EBhTAmGlpTpSWN0rpJMZ/Ir3ll/kJ6/aGKqMSMNw3PwcODhN?=
 =?us-ascii?Q?lSud1q4CwdA7u5zktN0ot+n0XiJxodbzUmEatG57fSCi1mrA8zYiUnZ9ayeT?=
 =?us-ascii?Q?GHoqvwd4+dmI+EzCT0GlVgovA8TeyLweFacxNKNaFy+MuA95k/65JyYK9fvq?=
 =?us-ascii?Q?hnAe66ECS7Xd+qt63Dg6HO3JgBTL+zAV3IQanrnaS3GQT3oIaIMTVTE20Bw/?=
 =?us-ascii?Q?8VYHYmS5b0h0PiBeVmlucBEzhxnxN2tgSIqEhBqQE/WBCRHsQZxJPKDwAQK8?=
 =?us-ascii?Q?8QEIRc+TWtGvmBO1OEJb0Ovik5Gx869BdX/1ZVUj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b615fd26-57bf-4e4f-7d3e-08ddf9e0277a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 13:58:48.8330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlR71geKTha2w+SY6Zl2Sp/X5pgR/BJALTqhy1+ZvrDk+lgf0LMzRBAEmEO4l20F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8655

--LnBWRHvfL7tPei4m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Just a one line change, was expecting more rc stuff, but it has been
quite.

Thanks,
Jason

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 85fe9f565d2d5af95ac2bbaa5082b8ce62b039f5:

  IB/mlx5: Fix obj_type mismatch for SRQ event subscriptions (2025-08-25 15:06:46 -0300)

----------------------------------------------------------------
RDMA v6.17 second rc pull request

- Fix mlx5 devx event delivery to userspace for certain kinds of SRQs

----------------------------------------------------------------
Or Har-Toov (1):
      IB/mlx5: Fix obj_type mismatch for SRQ event subscriptions

 drivers/infiniband/hw/mlx5/devx.c | 1 +
 1 file changed, 1 insertion(+)

--LnBWRHvfL7tPei4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCaNFWEwAKCRCFwuHvBreF
YcbfAP9XWayGLdCQ3JUi/TmxeP5WvGEFH9TD4WmYHutkGNBk7wEAzopepGqwi8ae
XhxOX/1bUn3x+7d3PJQgM7ba8f7UDQ8=
=yIn6
-----END PGP SIGNATURE-----

--LnBWRHvfL7tPei4m--

