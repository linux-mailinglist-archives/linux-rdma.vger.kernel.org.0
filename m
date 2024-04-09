Return-Path: <linux-rdma+bounces-1870-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A077289D9D8
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 15:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22DB41F22D47
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 13:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B9A12EBE9;
	Tue,  9 Apr 2024 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="S7wlMH6w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A5912FF60
	for <linux-rdma@vger.kernel.org>; Tue,  9 Apr 2024 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668111; cv=fail; b=IbtqeSUyabm5F1soA7FXMFIGkdN4wvSwitoOndpW2a2oHFuWL5D7tGT9wwrHmtBweuByzDRbNTtIn86o5JF8028aWWSLWU1rfXUVZAZR1ENoxY0TWqt7cpcWSUxrYgK28tuzVJpCp0sMPxSNOC4+1qtJRDUEYfhS5MY+Ib8DHvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668111; c=relaxed/simple;
	bh=B8uaMnRuNuorSpm1fGnJ0B41U4Pw5I/d1TTs9Akw/TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=csG3g1Z01y+TSxcoONGb9bIxVmT2MBl8dQUx6sGpZB9ELeG/3/C+TC7vPefzaIlrbUROW2F1135xyoX8zjGIsIgOVzzRFJ7taysF+LaAOuMbi1dx9Lrh/a1K6OpPKe3vhVF0IuHR7WAaG2BVC5mI75BR2QgkmU0SeiL/mSg/f7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=S7wlMH6w; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169]) by mx-outbound15-41.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 09 Apr 2024 13:08:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjOwqGlYApaeViFs4wodOqigTKlu78xVNRo7le87ikmC4LWH+qs/7Q/+hMZhmBh9x2qkTU1j0icaPC+HoJ3XoHwS7zSfemJ+XWKlMwa2GjbxtvmD+KYVmmGZ/7Cl8JjX9vR0Y9U8Sca8j6xY9iASFqR6/p6+iWICWMIi0xpH1zPXR5fECnB1nIbqK/UbwR6pCYkbzQNuPc5HLN1gHcSJrfGJ4JppIXiiSm/yOYesqyAkTLHnEwvSAqe/n9yjmJYuxWhED227nTT22HQoglqbzZ8B1FvwQPg9uqVL93A7IxK5yzeIQQyczQBp0ATe8Y4jf66N/uH0dJMJiMpnsOv35w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+t45soP95fINctzWElYPYt1adS/7IeTyTgxOFveiWE4=;
 b=Q4ZJvR7YAAwKYC9VA2G20nJX7C0TAlRqHwxRiTgM8IfyH1+m+Uuho8ToUbzIadITAGi4grbJUL8ydR8P2khvi7Wdl6sQLVu5UbfaU5JlFjdQFbjCCMKVLZVCTr42v449nLzs3Z77iDtExvSXTTNBpN+I/Bh/g8FOtCpgDkjBkMnjj8tnjAWpU0xyjstxppo/9aky0xyLx99y7dkz85Smu7FHfpee+yC+kIX0zMnJhRlAKiHMcS1ZJYTpuIS9wmuIydpeFDmYEyGc6chQvbSXHH3dh1jimJ+ERwFSriFkoX+XBc6Ju+zK0ZyUyMzy73B4TdyDqNBy7S9T9ridLo4hxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+t45soP95fINctzWElYPYt1adS/7IeTyTgxOFveiWE4=;
 b=S7wlMH6whZTgzns+lFQI86AqIf/65BnST6RCoYou8bAkkjTqqQ+8mfVaVhu2MWQZDJgK622sHrY7c+u8UoPh5ZpQlCsf0FPPuCeJdvhVbuvwAC14xwncRbbV74piIpNWjDeKjY2uEF98UTmT7RoAQlQ41ckM4pXSUEeqgXhjTE0=
Received: from SA1PR19MB5570.namprd19.prod.outlook.com (2603:10b6:806:236::11)
 by DS0PR19MB8489.namprd19.prod.outlook.com (2603:10b6:8:1a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 13:07:59 +0000
Received: from SA1PR19MB5570.namprd19.prod.outlook.com
 ([fe80::956b:a5db:c859:cfa2]) by SA1PR19MB5570.namprd19.prod.outlook.com
 ([fe80::956b:a5db:c859:cfa2%7]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 13:07:59 +0000
Date: Tue, 9 Apr 2024 15:07:43 +0200
From: Etienne AUJAMES <eaujames@ddn.com>
To: Sean Hefty <shefty@nvidia.com>
Cc: "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
	Mark Zhang <markzhang@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"Gael.DELBARY@cea.fr" <Gael.DELBARY@cea.fr>,
	"guillaume.courrier@cea.fr" <guillaume.courrier@cea.fr>,
	Serguei Smirnov <ssmirnov@whamcloud.com>,
	Cyril Bordage <cbordage@whamcloud.com>
Subject: Re: [PATCH rdma-next] IB/cma: Define options to set CM timeouts and
 retries
Message-ID: <ZhU9n-f4Zvjs5NZn@eaujamesDDN>
References: <ZgxeQbxfKXHkUlQG@eaujamesDDN>
 <SN7PR12MB68403240EAB2777CB5D8AB5FBD002@SN7PR12MB6840.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB68403240EAB2777CB5D8AB5FBD002@SN7PR12MB6840.namprd12.prod.outlook.com>
X-ClientProxiedBy: PA7P264CA0371.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37c::12) To SA1PR19MB5570.namprd19.prod.outlook.com
 (2603:10b6:806:236::11)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR19MB5570:EE_|DS0PR19MB8489:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MepjnhOYqbz1j1IY9uKcV6GE7q5CEyDTckXyZY2sMClDLPn6GG9vrtmmiauwpea2JTern7tPvrL0mtfZyqZ+4R3by2PSBM1SnttXpmTSCSKI8ZMviXQKB5loLnv7nHO5SMjQ/Gmb47P/voRQUHIu74XCeg6isGa5FKRKZseQVI3KiTHbZnGJQzhGvyEEj7iLuhMfg5NlWQStMNL8V3AKjA6xrdxFOqz5Jy+E2PaAZ+ft0UAu5uocddtwOIGtyCI9uqvHkgpJZTEapJtJM60rTh27fKBBVA4+Dk8dmBTKDcRn3axDR4cz/RAiLi9/kBmtu7GOkizoVX2E1UDG+JmMqPFUiafLm+6NW9otXT81bqrMA18AI6RcYTjzy/HQJRlR78WpKjwhERhsLmd1LnXj/6nb71he7lQ2yH2ncVpIlakv/cxC/P2Z/MgclOpSOhVwWxht1K7IUY7sj+xpOH8xuT5NcJ9CfyGzbgO3kG0txmoWQiiLHGrGY1slYU2ECnCh/Yie0di2obKQcKhoeqlk8x8voFYzmeoFFVuTaqPEIA2JaE43fgWDNxUgye8s3Fc8L9m4/noxXpZhTeaDicVAWQ4/FDlPEKbE/1etTPgBdxE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB5570.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yQMAX0W6D2LpqNfx7J5OZYAPYwjQsolFg88lJxNkS5jPBHg8EY4gRI6h+j7/?=
 =?us-ascii?Q?tqMPK1FgHEllUz7zMWcKk/eDoM+Jtf6htzBHkNXTtTHOffjxrREh1gXtieXj?=
 =?us-ascii?Q?9lSDyvRUQ12cv7lgevnsPmnncwTVLhYnbV45IULYwNR2iY5Cl4TeNde7+4k+?=
 =?us-ascii?Q?XLkVtSCL9pglXxfHq1hXGImucXPkgBpUsQNEmYTvTFeZ3b6M3vKamTMi7RUz?=
 =?us-ascii?Q?bqt1GUVZ3ifINjShdkw+KVACrIqJMpTUqbLUqO/q51glUlBrPq5vP+GyCnmc?=
 =?us-ascii?Q?2s8thGEwGKb+9epps98PyJqa1SGiWJ2Zw6SfE5LJRw8nQ1lWKRdi6XhjRjyp?=
 =?us-ascii?Q?VyvD2+cNYXwVPHqFoTBP8B37x/1v/CVz5G0JTyDaZ4eXealQnus2BK+OEU0G?=
 =?us-ascii?Q?h5fZEOuEgcm3JFBvdvkJ2oCao/s4XNs/O6+yoYZ9ZnlfLSCym79H7+Bvcf0K?=
 =?us-ascii?Q?Ry1rbGpnh0tUsEZcsoEIpgt9O7Jxo0K/97ARVI4eL9w12WIW/eZ0P2Gqsvvq?=
 =?us-ascii?Q?nCqvIzacvZNr05kyP+qCzLzBfEBI7vZL1QaY/huGFgFCldUm43aZxsUDLpOf?=
 =?us-ascii?Q?g+D9R9KR5Cq5EJOcHYvNcImuXn6PpC1sVOJbDI1LVp7IAWBsj8RL52UUyLeq?=
 =?us-ascii?Q?CW1p4taPno1ZmUfwistymx34qJtkc3Zdbmn5suYN5l595qyGKyHD1F/sYSOQ?=
 =?us-ascii?Q?io8T29Za1fsemuG2OzsUZcOUX9C89pyA2CG4zADxEpe2/m6GMNbOhBrZmfYx?=
 =?us-ascii?Q?5PnaPn8YD1IELt4Lp9/0FeK96fK9KXfR5sgzLfAAjKjtmmntAkHpI442XQgC?=
 =?us-ascii?Q?OcgRVkcpAo/3pKMa95zZ8USPPl0TN6oVGwgNuhhkkCg8yAoCaom7WvjHI2h7?=
 =?us-ascii?Q?zHBSIC59PY1bI9mgRm5iHzXv7g8xVuSSCzwj5TGhY9wb8Z2y1obtVvpDtt9Z?=
 =?us-ascii?Q?82HHpPjUGxq692T9z55F7nqLVw8bv6AZdmRvIk04cnl3TRb+GrWmgEIgVkUA?=
 =?us-ascii?Q?oR0HTzwnLkORE5FXXK3iff+M6pqbUHbFjnvM9EjfLbiLTqFxk8fGCmrbWYvT?=
 =?us-ascii?Q?EDTLlEbiCNbgy+fF/J0Y1SAJdI2uq3txx4f89Ny/wJoHD9aDaQsO45r0KhPJ?=
 =?us-ascii?Q?DjbYHLW33KqvjH1uBySfa03qKjYVYM6FX50d+jUWn9HR/GJ5877TSllHwjWN?=
 =?us-ascii?Q?T+XPp7Qv4y8ZQVAO/JSMCC37N0bo9brQd2Q7anFELBPmMRDG+mPF8wqIBvfo?=
 =?us-ascii?Q?PWm9zHC1fexLAOqxz+BIdFznWzdG6JvB5UnHA8dKbpmEnZ8w819cqD/5tigX?=
 =?us-ascii?Q?Oy7q45mU8iyneWj/AsSntjisCcGtKFDt4MY/CO9Nd8hUpyeI6dKQ6ezVqq5Y?=
 =?us-ascii?Q?TVxTGxJUeEg7CCrcb6NQrjoN0zhhivthKDx6wDWOmWQqYHEsUCxJGtgEOdR8?=
 =?us-ascii?Q?LwlNSzhe64C1mjfiugGCqtTxMcAaM8k5qb7boQ60UEIzdziZIoruevHua6O7?=
 =?us-ascii?Q?GMfsW+mSpo+iYJG7jRuST+274xgiYIat6apI+ho5U0yVNraPn8B4WuedPT+X?=
 =?us-ascii?Q?5r0ot6iKzoRnK4QhI1fzkwl3i+mN16E8kwR7PI4eZ8h0uxxa4B0r9JGOAHS4?=
 =?us-ascii?Q?b+MENuzOHdozrjUzNKfzBLfTiOrVzPumcGyDmGYdmlOT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kD/ZpJaXafe96a3H0VeEjSkHABAcs6kBxMUhQfCvQnRdOKL4SjJBwk54KiDczaenSHnRSdkexTi4zTogFvAug6DHElIbfQzaVDX9h0zZxkv8rGSlZDAaW4HTf+PEaLOx/3tpjQVO9r0ib5ZTaDq8bvriv1nnN4PWYqjx/ukZUfMWWpMvvMARRw7s2lU5+g9sj2EX1oTAnCVgJem23/HLDySxscPAsanGDdmQkwvgx7T48hcvNw1PftQoqfF3W+N1Hy3B5kOh4K0hKmJUw/oGjaQonN3vlT2B3SIia0yUyPwH3oAbRXEyuf0xQlp9WO15+UPHHUhbWxa+4oaRP91X8A2PU+CW98VL7sWiZ/mZZQv2PnKLosorEi6fhIXEC7z4B6qMxqi/DTCAvbYorRuOGE/fZlO85QQV9qF3miKl5cQ2X9O8Z2QsqWHknJMYFeddWLSWcZv5owCDX7wkhab36dhOOT8Ertm9+2O1osFpOEoNerP+QjXHOA4QOt2wVa3HRKkYi9kzZwcyiY6gjVrRLMMlBw1MFeGk+f1ipUntABOQoK8TlSvXyJykGw7iFFfeNEJ+X8uC4LYCTfguxeRm/SDCIUV1UD3YpEDr0pp+I47KVWgL5yEMsxLmsHs6D10pSjKLfF0hVBaDK09XGh5Skg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4947ff61-ba46-4e84-cccc-08dc58961456
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB5570.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 13:07:59.1544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKh1MtgpkHiEueSfIh1D0eFnx/PZCQO0puku4l/Zt6tr+SoVcVKYE/wTblxV69oLHXzddH0hOmz2rulYqVfIIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB8489
X-BESS-ID: 1712668083-103881-12680-3836-1
X-BESS-VER: 2019.1_20240408.2306
X-BESS-Apparent-Source-IP: 104.47.59.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaW5qZAVgZQ0DTZMMXAxNTENM
	k00dLSODXZ1CLRIjXVNC3FNNnE0ihJqTYWAFGyY0FBAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.255446 [from 
	cloudscan21-21.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA085b
X-BESS-BRTS-Status:1

> I was thinking of aligning closer with the behavior of the TCP stack, plus a couple other adjustments.
> 
> a. Reduce the hard-coded CM retries from 15 down to 6.
15 retries is the maximum (the field size is 4 bits). According to the
documentation that I read, there is no minimum retries required. So I
don't know why this is statically defined to 15. Maybe this is related
to hardware interoperability/compatibility.

> b. Reduce the hard-coded CM response timeout from 20 (4s) to 18 (1s).
The NVIDIA MOFED set the CM timeout to 22 (17s) instead of 20. This
makes an overall connection timeout of 5 min for an unreachable node.

Some patches seem to argue that 20 is too short:
https://lore.kernel.org/lkml/20190217170909.1178575-1-haakon.bugge@oracle.com/

> c. Switch CM MADs to use exponential backoff timeouts (1s, 2s, 4s, 8s, etc. + random variation)
> d. Selectively send MRA responses -- only in response to a REQ
> e. Finally, add tunables to the above options for recovery purposes.
>
> Most of the issues are common to RoCE and IB.  Changes a, b, & c are based on my system's TCP defaults, but my goal was to get timeouts down to about 1 minute.  Change d should help address problem 2.
Please notes here, that we don't hit this timeout issue on Infiniband
network with an unreachable node.
Infiniband have a SM, rdma_resolve_route() fails before rdma_connect()
for an unreachable node. The SM returns an empty "path record".

Maybe there are some other ways to mitigate that RoCE issue.
For example, when I troubleshooted this issue, I saw that the RoCE HCA
received ICMP "Destination unreachable" packets for the CM requests. So,
maybe we could listen to those messages and abort the connection process.

> If the expectation is that most users will want to change the timeout/retry, which I think would be the case, then adjusting the defaults may avoid the overhead of setting them on every cm_id.  The ability to set the values as proposed can substitute for change e, but may require users update their librdamcm.

Our particular use case is the Lustre RoCE/Infiniband module with a
RocE network.
Lustre relies on "pings" to monitor nodes/services/routes, this is use
for example for High Availability or the selections of Lustre network
routes.
For Lustre FS, a timeout superior to 1 min is not acceptable to detect
an unreachable node.

More information can be found here:
https://jira.whamcloud.com/browse/LU-17480

I don't think that most users needs to tune those parameters. But if
some use cases require a smaller connection timeout, this should be
available.

I agree that finding a common ground to adjust the defaults would be
better but this can be challenging and break non-common fabrics or use
cases.

This look like the same that for "RDMA_OPTION_ID_ACK_TIMEOUT": not all
users need to alter PacketLifeTime for RoCE, but if the network
requires to increase that value, they can do it (on Infiniband this
value is given by the SM).

Etienne

